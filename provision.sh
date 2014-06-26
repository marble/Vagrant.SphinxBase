#! /bin/bash

echo ""; echo "###"; echo "# Start of provision.sh"; echo "#"

# define parameters
homedir=/home/vagrant
template_make_folder=/vagrant/Templates/ExampleProject/Documentation/_make

# This project should be configured for latexpdf generation in ${example_project}/Documentation/Settings.yml
example_project=TyposcriptReference
example_project_url=https://github.com/TYPO3-Documentation/TYPO3CMS-Reference-Typoscript

# This project should be configured for latexpdf generation in ${example_project}/Documentation/Settings.yml
example_project=sphinx
example_project_url=http://git.typo3.org/TYPO3CMS/Extensions/sphinx.git

# Let's generally work in the home dir:
cd ${homedir}

# Update packet information:
echo ""; echo "###"; echo "# Update packet lists"; echo "#"
sudo apt-get update

# python2.7 will already be there. But let's ensure this anyway:
echo ""; echo "###"; echo "# Install Python"; echo "#"
sudo apt-get install -qy python

# Provide Python imaging library:
echo ""; echo "###"; echo "# Install python-imaging"; echo "#"
sudo apt-get install -qy python-imaging

# Install curl:
echo ""; echo "###"; echo "# Install curl"; echo "#"
sudo apt-get install -qy curl

# Install git:
echo ""; echo "###"; echo "# Install git"; echo "#"
sudo apt-get install -qy git

# Install unzip:
echo ""; echo "###"; echo "# Install unzip"; echo "#"
sudo apt-get install -qy unzip

# Install pip
echo ""; echo "###"; echo "# Install the Python packet manager pip"; echo "#"

# pip is the packet manager for Python packages listed on 
# http://pypi.typo3.org/. For Python 2.7 pip needs to be installed
# separatedly. To do this we run 'get-pip.py' which we can find with
# this Google search: https://www.google.de/search?q=get-pip.py

# Download get-pip.py:
curl --silent https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py -o /vagrant/Downloads/get-pip.py

# Globally install the Python packet manager 'pip':
sudo python /vagrant/Downloads/get-pip.py

# Globally install the Python yaml package:
echo ""; echo "###"; echo "# Install Yaml for Python"; echo "#"
# sudo pip install pyyaml
sudo apt-get install -qy python-yaml

# Globally install the python-markupsafe package:
echo ""; echo "###"; echo "# Install markupsafe for Python"; echo "#"
# sudo pip install pyyaml
sudo apt-get install -qy python-markupsafe

# Globally install Sphinx and everything that's needed for this:
echo ""; echo "###"; echo "# Install Sphinx for Python (sphinx)"; echo "#"
sudo pip install sphinx

# ##########
# handle sphinxcontrib packages
# ##########
echo ""; echo "###"; echo "# Install sphinxcontrib extensions for Sphinx"; echo "#"

# We would like to do these installs:
#
# sudo pip install sphinxcontrib-googlechart
# sudo pip install sphinxcontrib-googlemaps
# sudo pip install sphinxcontrib-httpdomain
# sudo pip install sphinxcontrib-numfig
# sudo pip install sphinxcontrib-slide
# sudo pip install sphinxcontrib-youtube
#
# But for security reasons we only trust the Sphinx extensions from 
# https://bitbucket.org/xperseguers/sphinx-contrib/downloads
#

# garantee that the file is empty
rm /vagrant/tmp/sphinxcontrib_settings.sh >/dev/null 2>&1
touch /vagrant/tmp/sphinxcontrib_settings.sh

# either write correct data or write nothing
python /vagrant/Scripts/handle_sphinxcontrib.py >/vagrant/tmp/sphinxcontrib_settings.sh

sphinxcontrib_zip_url=
sphinxcontrib_hash=
sphinxcontrib_unpackfolder=

# define the settings
source /vagrant/tmp/sphinxcontrib_settings.sh

# start with an empty download folder for sphinxcontrib
rm -rf /vagrant/Downloads/sphinxcontrib  >/dev/null 2>&1
mkdir -p /vagrant/Downloads/sphinxcontrib >/dev/null 2>&1

# download and unpack the zip archive with the sphinxcontrib plugins
curl --silent $sphinxcontrib_zip_url -o /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}.zip
unzip /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}.zip -d /vagrant/Downloads/sphinxcontrib/

# globally install the Sphinx plugins that are available on docs.typo3.org too

echo ""; echo "###"; echo "# Install sphinxcontrib-googlechart"; echo "#"
plugin=googlechart
cd /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}/$plugin
sudo python setup.py clean
sudo python setup.py install

echo ""; echo "###"; echo "# Install sphinxcontrib-googlemaps"; echo "#"
plugin=googlemaps
cd /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}/$plugin
sudo python setup.py clean
sudo python setup.py install

echo ""; echo "###"; echo "# Install sphinxcontrib-httpdomain"; echo "#"
plugin=httpdomain
cd /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}/$plugin
sudo python setup.py clean
sudo python setup.py install

echo ""; echo "###"; echo "# Install sphinxcontrib-numfig"; echo "#"
plugin=numfig
cd /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}/$plugin
sudo python setup.py clean
sudo python setup.py install

echo ""; echo "###"; echo "# Install sphinxcontrib-slide"; echo "#"
plugin=slide
cd /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}/$plugin
sudo python setup.py clean
sudo python setup.py install

echo ""; echo "###"; echo "# Install sphinxcontrib-youtube"; echo "#"
plugin=youtube
cd /vagrant/Downloads/sphinxcontrib/${sphinxcontrib_unpackfolder}/$plugin
sudo python setup.py clean
sudo python setup.py install


# Download the TYPO3 ReStructuredText tools and install the 't3sphinx' Python package
echo ""; echo "###"; echo "# Install RestTools/ExtendingSphinxForTYPO3"; echo "#"
if [ ! -d /vagrant/Repositories/git.typo3.org/Documentation/RestTools ]; then
   git clone git://git.typo3.org/Documentation/RestTools.git /vagrant/Repositories/git.typo3.org/Documentation/RestTools
fi
cd /vagrant/Repositories/git.typo3.org/Documentation/RestTools
git pull

# this is the traditional but buggy version from 2011
cd /vagrant/Repositories/git.typo3.org/Documentation/RestTools/ExtendingSphinxForTYPO3
# sudo python setup.py install
# sudo chown -R vagrant:vagrant .


# Download the new (~2014-06-16) ExtendingSphinxForTYPO3 '3sphinx' Python package from github 
echo ""; echo "###"; echo "# Install ExtendingSphinxForTYPO3 (github version)"; echo "#"
if [ ! -d /vagrant/Repositories/github.com/marble/typo3-ExtendingSphinxForTYPO3 ]; then
   git clone https://github.com/marble/typo3-ExtendingSphinxForTYPO3.git /vagrant/Repositories/github.com/marble/typo3-ExtendingSphinxForTYPO3
fi
cd /vagrant/Repositories/github.com/marble/typo3-ExtendingSphinxForTYPO3
git pull

# let's use the improved version from github
cd /vagrant/Repositories/github.com/marble/typo3-ExtendingSphinxForTYPO3
sudo python setup.py install
sudo chown -R vagrant:vagrant .
 
# The syntax highlighter 'pygments' should have been install by Sphinx.
# Now add syntax highlighting for TypoScript. To do this we need to copy
# the typoscript.py lexer to the lexers directory and update the 
# mapping by running _mapping.py itself in that directory.
echo ""; echo "###"; echo "# Install typoscript highlighting for pygments"; echo "#"
destdir=`python -c "import pygments, os; print os.path.join(os.path.dirname(pygments.__file__),'lexers')"`
sudo cp /vagrant/Repositories/git.typo3.org/Documentation/RestTools/ExtendingPygmentsForTYPO3/_incoming/typoscript.py $destdir
cd $destdir
sudo python _mapping.py

# Our system is now ready to handle Sphinx projects. Moreover, the
# TYPO3 specific additions have been install so we have TYPO3 specific
# features as known from http://docs.typo3.org.

ls -1 /usr/local/bin >/vagrant/logfiles/new-commands-in-usr-local-bin.txt

# ########################################
# Let's try an example HTML build.
# ########################################

# Fetch the ${example_project} for an example build. Store it in the
# shared folder of this virtual machine. Go to the _make folder which
# serves the only purpose to ease offline building "at home".

echo ""; echo "###"; echo "# Fetch example project"; echo "#"
if [ ! -d /vagrant/DocumentationProjects/${example_project} ]; then
    git clone ${example_project_url} /vagrant/DocumentationProjects/${example_project}
fi
cd /vagrant/DocumentationProjects/${example_project}
git pull

# make sure there is the Project/Documentation/_make folder
if [ ! -d "/vagrant/DocumentationProjects/${example_project}/Documentation/_make" ]; then
  echo ""; echo "###"; echo "# Copy generic _make folder to example project '${example_project}'"; echo "#"
  cp -r "${template_make_folder}" "/vagrant/DocumentationProjects/${example_project}/Documentation"
fi

# make the HTML version (TYPO3)
echo ""; echo "###"; echo "# Run 'make t3html' for example project"; echo "#"
cd /vagrant/DocumentationProjects/${example_project}/Documentation/_make
make t3html

# Find the result 'Index.html' here:
cd /vagrant/DocumentationProjects/${example_project}/Documentation/_make/build/t3html


# ########################################
# Add pdflatex generation
# ########################################

# A lot more has to be downloaded if you want to have 'make latexpdf':

# Install texlive-base (~143 MB):
echo ""; echo "###"; echo "# Install texlive-base"; echo "#"
sudo apt-get install -qy texlive-base

# Install texlive-latex-recommended (~284 MB):
echo ""; echo "###"; echo "# Install texlive-latex-recommended"; echo "#"
sudo apt-get install -qy texlive-latex-recommended

# Install texlive-latex-extra (~558 MB):
echo ""; echo "###"; echo "# Install texlive-latex-extra"; echo "#"
sudo apt-get install -qy texlive-latex-extra

# Install texlive-fonts-recommended (~61 MB):
echo ""; echo "###"; echo "# Install texlive-fonts-recommended"; echo "#"
sudo apt-get install -qy texlive-fonts-recommended

# Install texlive-fonts-extra (~571 MB):
echo ""; echo "###"; echo "# Install texlive-fonts-extra"; echo "#"
sudo apt-get install -qy texlive-fonts-extra
 
# Install the TYPO3 'share' font:
echo ""; echo "###"; echo "# Install share font from RestTools/LaTeX/font"; echo "#"
cd /vagrant/Repositories/git.typo3.org/Documentation/RestTools/LaTeX/font
sudo ./convert-share.sh
 
# Make the TYPO3 logo known to TeX. Copy files without subdirs:
echo ""; echo "###"; echo "# Provide TYPO3 logo for tex"; echo "#"
sudo cp /vagrant/Repositories/git.typo3.org/Documentation/RestTools/LaTeX/* /usr/local/share/texmf/tex/latex/typo3

echo ""; echo "###"; echo "# Update information about the ./texmf configuration hierarchy"; echo "#"
sudo texhash

# ########################################
# test-font: verify that font 'share' is available
# ########################################

if [ -e "/vagrant/test-font/test-font.tex" ] && [ ! -e "/vagrant/test-font/test-font.pdf" ]; then
   echo ""; echo "###"; echo "# Do 'pdflatex test-font.tex"; echo "#"
   cd /vagrant/test-font
   pdflatex test-font.tex
fi

# ########################################
# Let's try an example LaTeX-PDF build.
# ########################################
 
echo ""; echo "###"; echo "# Run 'make latexpdf' for example project"; echo "#"
cd /vagrant/DocumentationProjects/${example_project}/Documentation/_make
make latexpdf

# Find the result here:
cd /vagrant/DocumentationProjects/${example_project}/Documentation/_make/build/latex

ls -la | grep .pdf

echo ""; echo "###"; echo "# End of provision.sh"; echo "#"

# End.
