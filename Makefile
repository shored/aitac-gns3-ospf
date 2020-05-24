#SUBDIRS = scripts images

PROJROOT  = work_dir

OBJROOT   = ../obj
# ソースディレクトリの中を(shellの)findコマンドで走破してサブディレクトリまでリスト化する
PROJDIRS  := $(shell find $(PROJROOT) -type d)
# ソースディレクトリを元にforeach命令で全cppファイルをリスト化する
PROJFILES   = $(foreach dir, $(PROJDIRS), $(wildcard $(dir)/images.conf))
# 上記のcppファイルのリストを元にオブジェクトファイル名を決定
OBJECTS   = $(addprefix $(OBJROOT)/, $(SOURCES:.cpp=.o))
# ソースディレクトリと同じ構造で中間バイナリファイルの出力ディレクトリをリスト化
OBJDIRS   = $(addprefix $(OBJROOT)/, $(SRCDIRS))

.SUFFIXES: .qcow2

fetch: ./images/frr7.0-vm0.3.qcow2

./images/frr7.0-vm0.3.qcow2:
        wget https://sourceforge.net/projects/frr/files/FRR7.0-VM0.3.qcow2.bz2/download -O ./images/frr7.0-vm0.3.qcow2.bz2
        bzip2 -d ./images/frr7.0-vm0.3.qcow2.bz2
