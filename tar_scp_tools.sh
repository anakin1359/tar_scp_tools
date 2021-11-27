#!/bin/sh

#----- [ tarファイルの圧縮処理 ] -----
dir=$(find ./ -name "log_dir*" -type d)
dir_check=$(find ./ -name "log_dir*" -type d | wc -l)
tmp=$(mktemp)
trap "rm -rf ${tmp}" EXIT
i=0

TAR_EXECUTION() {
  if [ $dir_check -ge 1 ] ; then
    for d in $dir ; do
      tar -czvf ${d}_fix.tgz ${d}
    done
  else
    echo 0; exit 0
  fi
}

TAR_EXECUTION > $tmp


#----- [ 圧縮ファイルの転送 ] -----
tar_file=$(find ./ -name "*.tgz")
tar_check=$(find ./ -name "*.tgz" |wc -l)
dest_dir=/root/tar_scp_tools/
dest_ip="172.20.34.161"
dest_pw="pass"

TAR_TRANSPORT() {
  if [ $tar_check -ge 1 ] ; then
    for t in $tar_file ; do
      expect -c "
        spawn scp -p $t $dest_ip:$dest_dir;
        expect \"password:\"
        send \"$dest_pw\n\"
        interact;
      "
      rm -rf $t
    done
  else
    echo 0; exit 0
  fi
}

TAR_TRANSPORT > $tmp

exit 0