Vagrant.SphinxBase
==================

.. attention:: This README.rst ist work in progress. It is still very incomplete.

Purpose
-------
The purpose of this project is to maintain the recipe of how to set up a Debian
system that provides the basic shell commands to render Sphinx documentation
projects in the same way as it is done on the docs.typo3.org server.

It is intended that this recipe covers the part of setting up the basics
in the more general recipe of setting up the whole build.docs.typo3.org
server.

Currently the basic Debian machine is the same one that the
`Vagrant.Themes <https://github.com/typo3-themes/Vagrant.Themes>`_ project uses.
It uses a 32-bit version and thus does not require a 64-bit host system.


Installation
------------
It is assumed that you have Virtualbox and Vagrant on your system.

#. Clone this project.
#. Go to the start folder 'Vagrant.SphinxBase'
#. Fire up the machine. Recommended way::

      vagrant up 2>&1 | tee logfiles/vagrant-up.log.txt

   Afterwards you may check the logfile. Look for '###' to find major steps.


What does it do?
----------------

A basic Debian system will be set up with these shell commands. Try
each of these commands with '--help' as parameter::

   easy_install
   easy_install-2.7
   easy_install-3.4
   pip
   pip2
   pip2.7
   pygmentize
   rst2html.py
   rst2latex.py
   rst2man.py
   rst2odt_prepstyles.py
   rst2odt.py
   rst2pseudoxml.py
   rst2s5.py
   rst2xetex.py
   rst2xml.py
   rstpep2html.py
   sphinx-apidoc
   sphinx-autogen
   sphinx-build
   sphinx-quickstart

It is set up in a way that the Sphinx documentation at http://sphinx-doc.org/ is valid.

'sphinxcontrib' extensions for Sphinx are installed.

The Python package 't3sphinx' is installed from a Github fork. It does
not have the problems with creating JSON files. Use ``make html`` and
``make json`` to use the normal html-builder of Sphinx. Use ``make t3html`` and
``make t3json`` to use the TYPO3-specific html-builder.

See the ``_make`` and the ``_make/build`` folders of EXT:sphinx in the
DocumentationProjects folder.

LaTeX is installed so PDF files can be created.

The 'share'-font for LaTeX is installed.

The TYPO3 logo for LaTeX is installed.

A PDF file is build from 'test-font.tex' to verify that the share font
is being used.

The TYPO3 CMS extension EXT:sphinx will be cloned and the documentation
is rendered in the TYPO3 style. An HTML version and a PDF file is build.

To save bandwidth cached Debian packages are saved in order that they
survive a ``vagrant destroy``.


((to be continued))
