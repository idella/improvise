#!/usr/bin/env python2

from distutils.core import setup

setup ( name = "webcamoid",
	version = "9999",
	summary = "A plasmoid used to show and take photos with your webcam",
	author = "Gonzalo Exequiel Pedone",
	author_email = "hipersayan.x.gmail.com",
	url = "http://kde-apps.org/",
	package_dir = {'webcamoid/code': 'webcamoid/code'},
	license = 'GPLv3',
	description = "A plasmoid used to show and take photos with your webcam",
	classifiers = (
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU General Public License (GPL-3)',
        'Operating System :: POSIX :: Linux',
        'Programming Language :: C',
        'Programming Language :: Python',
        'Topic :: Multimedia :: Plasmoid',
    ),

)
