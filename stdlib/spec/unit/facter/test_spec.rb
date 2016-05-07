Facter.add(:wanname) do     
  setcode do 
    %x{ /sbin/ifconfig|egrep -v "127\.0\.0\.1\|192\.168\.7\."|grep -B 1 "inet addr:"|grep "eth"|/usr/bin/awk '{print $1}'|grep -v ":" }.chomp
  end
end
