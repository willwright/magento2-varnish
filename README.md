# Varnish for Magento2
__THIS IS NOT FOR PRODUCTION USE__

## Magento Version Support
* 2.3

## Example Usage
`docker-compose.yaml`
```
  varnish:
    image: wwright/magento2-varnish
    depends_on:
      - web
```

`docker run wwright/magento2-varnish`

## Documentation
Varnish 6.3

## Defaults

## Extensibility
Configuration files can be overwritten by mounting a volume containing your customized configurations.

Examples

## Tags
