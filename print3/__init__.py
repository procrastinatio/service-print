# -*- coding: utf-8 -*-

import os
from pyramid.config import Configurator
from pyramid.renderers import JSONP


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    app_version = settings.get('app_version')
    settings['app_version'] = app_version
    print_proxy_url = os.environ.get('SERVICE_PRINT_PROXY_URL', None)
    if print_proxy_url is not None:
        settings['print_proxy_url'] = print_proxy_url
    config = Configurator(settings=settings)

    # renderers
    config.add_renderer('jsonp', JSONP(param_name='callback', indent=None, separators=(',', ':')))

    config.add_route('print_create', '/printmulti/create.json')
    config.add_route('print_progress', '/printprogress')
    config.add_route('print_cancel', '/printcancel')

    config.add_route('checker', '/checker')
    config.add_route('checker_dev', '/checker_dev')

    config.add_route('get_timestamps', '/printmulti/timestamps')
    config.add_static_view('/pdf/',  '/var/local/print/')
    config.add_static_view('/', 'print3:static/')
 
    

    config.scan()
    return config.make_wsgi_app()
