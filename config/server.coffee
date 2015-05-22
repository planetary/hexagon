module.exports =
    # the port this instance will listen on (in production, pm2 will spawn multiple instances on
    # [port:port+numInstances]
    'port': 4620 + (process.env.NODE_APP_INSTANCE or 0)
