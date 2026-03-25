project = "df"
env     = "dev"

aws_cloudfront = {
  df_example_cloudfront {
    price_class         = "PriceClass_100"
    default_root_object = "index.html"
  }
}

