import ConfigParser
import sys
import os




DIRNAME = os.path.dirname(os.path.abspath(__file__))
CONFIG = os.environ.get('CONFIG', 'production.ini')

configfile = os.path.join(DIRNAME, CONFIG)

from paste.deploy import loadapp

if sys.version_info >= (2, 6):
    from logging.config import fileConfig
else:
    from paste.script.util.logging_config import fileConfig

try:
    fileConfig(configfile)
except:
    pass

application = loadapp("config:" + configfile, name=None)

