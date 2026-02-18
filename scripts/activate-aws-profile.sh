if [ $1 == "prod" ]; then
    $(cp ~/.aws/.s3ProdCfg ~/.s3cfg)
elif [ $1 == "dev" ]; then
    $(cp ~/.aws/.s3DevCfg ~/.s3cfg)
fi
