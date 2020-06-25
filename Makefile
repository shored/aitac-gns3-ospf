#SUBDIRS = scripts images

GNS3ROOT = ~/GNS3

IMGDIR = $(GNS3ROOT)/images
PROJROOT  = $(GNS3ROOT)/projects
SOURCEROOT = ./word_dir

FRRIMAGE = frr7.1-vm0.4.qcow2

OBJROOT   = ../obj
SOURCEDIRS  := $(find $(SOURCEROOT) -type d)
PROJFILES   = $(foreach dir, $(PROJDIRS), $(wildcard $(dir)/images.conf))
# 上記のcppファイルのリストを元にオブジェクトファイル名を決定
OBJECTS   = $(addprefix $(OBJROOT)/, $(SOURCES:.cpp=.o))
# ソースディレクトリと同じ構造で中間バイナリファイルの出力ディレクトリをリスト化
OBJDIRS   = $(addprefix $(OBJROOT)/, $(SRCDIRS))

.SUFFIXES: .qcow2

#fetch: $(IMGDIR)/frr7.0-vm0.3.qcow2

$(IMGDIR)/$(FRRIMAGE).md5sum: $(IMGDIR)/$(FRRIMAGE)
	openssl md5 $(IMGDIR)/$(FRRIMAGE) | awk '{print $2}' > $(IMGDIR)/$(FRRIMAGE).md5sum

$(IMGDIR)/$(FRRIMAGE):
	wget https://sourceforge.net/projects/frr/files/$(FRRIMAGE).bz2/download -O ./$(IMGDIR)/$(FRRIMAGE)
	bzip2 -d ./$(IMGDIR)/$(FRRIMAGE).bz2

