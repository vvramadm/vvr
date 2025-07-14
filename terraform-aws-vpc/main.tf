resource "aws_vpc" "main" {

    cidr_block = var.vpc_cidr
    enable_dns_hostnames = var.enable_dns_hostnames
    tags = merge (
    var.common_tags,
    var.tags,
{
    Name = local.resource_name
}
)
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge (
  var.common_tags,
   var.tags,
   {
     Name=local.resource_name
   }

   )
  
 }

  resource "aws_subnet" "public" {
      count = length(var.public_subnet_cidrs)
      vpc_id = aws_vpc.main.id
      cidr_block = var.public_subnet_cidrs[count.index]
      availability_zone = local.az_zones[count.index]
      map_public_ip_on_launch = true
      tags = merge(
          var.common_tags,
          var.tags,
          {
              Name="${local.resource_name}-public-${local.az_zones[count.index]}"
          }
      )
     
  }

  resource "aws_subnet" "private" {
      count = length(var.private_subnet_cidrs)
      vpc_id = aws_vpc.main.id
      cidr_block = var.private_subnet_cidrs[count.index]
      availability_zone = local.az_zones[count.index]
      map_public_ip_on_launch = false
      tags = merge(
          var.common_tags,
          var.tags,
          {
              Name="${local.resource_name}-private-${local.az_zones[count.index]}"
          }
      )
  }

  resource "aws_subnet" "database" {
      count = length(var.database_subnet_cidrs)
      vpc_id = aws_vpc.main.id
      cidr_block = var.database_subnet_cidrs[count.index]
      availability_zone = local.az_zones[count.index]
      map_public_ip_on_launch = false
      tags = merge(
          var.common_tags,
          var.tags,
          {
              Name="${local.resource_name}-database-${local.az_zones[count.index]}"
          }
      )

  }

# # DB subnet group for RDS
  resource "aws_db_subnet_group" "default" {
      name = local.resource_name 
      subnet_ids = aws_subnet.database[*].id
      tags= merge(

          var.common_tags,
          var.db_subnet_group_tags,
          {
              Name=local.resource_name
          }
      ) 
  }

resource "aws_eip" "nat_eip" {
  vpc       =  true
  depends_on = [aws_internet_gateway.main]
}

 resource "aws_nat_gateway" "main" {
 allocation_id = aws_eip.nat_eip.id
   subnet_id = aws_subnet.public[0].id
   tags = merge(
     var.common_tags,
     var.tags,
     {
         Name=local.resource_name
     }
   )

   depends_on = [ aws_internet_gateway.main ]
 }


# #public route table
  resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = merge(
      var.common_tags,
      var.public_route_table_tags,
      {
          Name="${local.resource_name}-public"
      }
    )
  }
#  #private route table
  resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    tags = merge(
      var.common_tags,
      var.private_route_table_tags,
      {
          Name="${local.resource_name}-private"
      }
    )
  }
# # database route table
  resource "aws_route_table" "database" {
    vpc_id = aws_vpc.main.id
    tags = merge(
      var.common_tags,
      var.database_route_table_tags,
      {
          Name="${local.resource_name}-database"
      }
    )
  }

# # #route
  resource "aws_route" "public" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

resource "aws_route" "private_nat" {
route_table_id = aws_route_table.private.id
destination_cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.main.id
}

resource "aws_route" "database_nat" {
  route_table_id = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id 
}

  resource "aws_route_table_association" "public" {
     count = length(var.public_subnet_cidrs)
     subnet_id = aws_subnet.public[count.index].id
     route_table_id = aws_route_table.public.id
   }
   resource "aws_route_table_association" "private" {
     count = length(var.private_subnet_cidrs)
     subnet_id = aws_subnet.private[count.index].id
     route_table_id = aws_route_table.private.id
   }
   resource "aws_route_table_association" "database" {
     count = length(var.database_subnet_cidrs)
     subnet_id = aws_subnet.database[count.index].id
     route_table_id = aws_route_table.database.id
   }
    resource "aws_vpc_peering_connection" "peering" {
      count = var.is_peering_required?1:0
      vpc_id = aws_vpc.main.id #requestor
    peer_vpc_id = data.aws_vpc.default.id #acceptor
    auto_accept = true
    tags = merge(
        var.common_tags,
        var.vpc_peering_tags,
        {
            Name="${local.resource_name}-default"
        }
    )
    }
#peering route
     resource "aws_route" "public_peering" {
         count = var.is_peering_required?1:0
         route_table_id = aws_route_table.public.id
         destination_cidr_block = data.aws_vpc.default.cidr_block
        vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
     }
     resource "aws_route" "private_peering" {
         count = var.is_peering_required?1:0
         route_table_id = aws_route_table.private.id
         destination_cidr_block = data.aws_vpc.default.cidr_block
       vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
     }
     resource "aws_route" "database_peering" {
         count = var.is_peering_required?1:0
         route_table_id = aws_route_table.database.id
         destination_cidr_block =data.aws_vpc.default.cidr_block
         vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id

     }
     resource "aws_route" "default_peering" {
         count = var.is_peering_required?1:0
         route_table_id = data.aws_route_table.main.route_table_id
         destination_cidr_block = var.vpc_cidr
         vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
 
     }