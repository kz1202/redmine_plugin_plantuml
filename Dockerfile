FROM redmine:3.4

RUN set -x ; \
	if [ ! -d /usr/share/man/man1 ]; then mkdir -p /usr/share/man/man1 ; fi; \
	apt-get update; \
	# install java
	apt-get install -y default-jdk ; \
	# install graphviz
	apt-get install -y graphviz ; \
	# install 日本語フォント
	apt-get install -y fonts-ipafont fonts-ipaexfont ; \
	rm -rf /var/lib/apt/lists/* ; \
	wget -q -O /usr/share/plantuml.jar https://jaist.dl.sourceforge.net/project/plantuml/plantuml.jar ; \
	echo '\
#!/bin/bash\n\
java -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar /usr/share/plantuml.jar ${@}\
'> /usr/bin/plantuml ; \
	chmod +x /usr/bin/plantuml ; \
	# plantum plugin 
	git clone --depth=1 https://github.com/dkd/plantuml.git /usr/src/redmine/plugins/plantuml ;

