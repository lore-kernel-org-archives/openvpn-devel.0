From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
References: <40E18559.8020407@...244...> <200407090123.51480.vda@...216...> <Pine.LNX.4.60.0407092256040.8983@...210...>
In-Reply-To: <Pine.LNX.4.60.0407092256040.8983@...210...>
MIME-Version: 1.0
Message-Id: <200407101914.52001.vda@...216...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Jul 10 09:16:03 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

> > IMHO daemontools for windows, if ported, can handle quite a variety
> > of different setups, including one needed by openvpn. Then you can
> > install it as part of openvpn install.
>
> If the only issue we had to solve here was how a normal user should be
> able to spawn openvpn processes, I agree we should use already existing
> software to solve this.
>
> However, this issue has grown abit larger than that. Our gui client needs
> to:
>
> * Scan a directory for configuration files.
> * A way to spawn processes (preferable portable)
> * Maintain a table over on which port it can reach the openvpn
>    process management interface.
> * Monitor that all openvpn processes are still alive
> * Connect to all the openvpn processes and get status info

:)  I will append 'man svscan' and 'man supervise'. Judge for
yourself how many of your points are covered by them.

Also I'll append my current 'ps -AH e' output. You can see there how
completely different daemons are controlled by those tools.

> There is no fancy hardcoded things we are talking about, so it could all
> reside in the gui client, however I liked the idea of moving this
> functionallity into a portable service manager.
>
> I need to code this regardless if we put it in the gui agent itself, or in
> this service manager, so I think it makes more sence to put the effort
> into a deamon from which other gui clients can benefit on all platforms,
> instead of into my not-so-portable gui.

No need to code it. Port it to Windows. That's all.
--
vda

svscan(8)                                                            svscan(8)



NAME
       svscan - starts and monitors a collection of services

SYNOPSIS
       svscan [ directory ]

DESCRIPTION
       svscan  starts  one  supervise(8)  process for each subdirectory of the
       current directory, up to a limit of 1000 subdirectories.  svscan  skips
       subdirectory  names  starting  with dots.  supervise(8) must be in svs-
       can's path.

       svscan optionally starts a pair of supervise(8) processes,  one  for  a
       subdirectory  s,  one for s/log, with a pipe between them. It does this
       if the name s is at most 255 bytes long and s/log exists. (In  versions
       0.70  and  below,  it does this if s is sticky.)  svscan needs two free
       descriptors for each pipe.

       Every five seconds, svscan checks for subdirectories again. If it  sees
       a new subdirectory, it starts a new supervise(8) process. If it sees an
       old subdirectory where a supervise(8) process has exited,  it  restarts
       the  supervise(8)  process.  In the log case it reuses the same pipe so
       that no data is lost.

       svscan is designed to run forever. If it has trouble creating a pipe or
       running  supervise(8), it prints a message to stderr; it will try again
       five seconds later.

       If svscan is given a command-line argument directory,  it  switches  to
       that directory when it starts.

SEE ALSO
       supervise(8),  svc(8),  svok(8),  svstat(8), svscanboot(8), readprocti-
       tle(8), fghack(8), pgrphack(8), multilog(8), tai64n(8), tai64nlocal(8),
       setuidgid(8), envuidgid(8), envdir(8), softlimit(8), setlock(8)

       http://cr.yp.to/daemontools.html



                                                                     svscan(8)


supervise(8)                                                      supervise(8)



NAME
       supervise - starts and monitors a service.

SYNOPSIS
       supervise s

DESCRIPTION
       supervise  switches  to  the  directory  named  s  and starts ./run. It
       restarts ./run if ./run exits. It pauses for a  second  after  starting
       ./run, so that it does not loop too quickly if ./run exits immediately.

       If the file s/down exists, supervise does not start ./run  immediately.
       You  can use svc(8) to start ./run and to give other commands to super-
       vise.

       supervise maintains status information in a binary  format  inside  the
       directory s/supervise, which must be writable to supervise.  The status
       information can be read by svstat(8).

       supervise may exit immediately after startup  if  it  cannot  find  the
       files  it needs in s or if another copy of supervise is already running
       in s.  Once supervise is successfully running, it will not exit  unless
       it  is  killed  or  specifically  asked to exit. You can use svok(8) to
       check whether supervise is successfully running. You can use  svscan(8)
       to reliably start a collection of supervise processes.

SEE ALSO
       svc(8), svok(8), svstat(8), svscanboot(8), svscan(8), readproctitle(8),
       fghack(8), pgrphack(8), multilog(8), tai64n(8),  tai64nlocal(8),  setu-
       idgid(8), envuidgid(8), envdir(8), softlimit(8), setlock(8)

       http://cr.yp.to/daemontools.html



                                                                  supervise(8)

# ps -AH e
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:01 /bin/sh /init
    2 ?        SWN    0:00   [ksoftirqd/0]
    3 ?        SW<    0:00   [events/0]
    4 ?        SW<    0:00     [khelper]
   20 ?        SW<    0:00     [kblockd/0]
   46 ?        SW     0:00     [pdflush]
   47 ?        SW     0:00     [pdflush]
   49 ?        SW<    0:00     [aio/0]
  479 ?        SW<    0:00     [reiserfs/0]
   48 ?        SW     0:00   [kswapd0]
   50 ?        SW     0:00   [cifsoplockd]
  214 ?        SW     0:00   [kseriod]
  392 ?        S      0:00   devfsd /dev
  681 ?        S      0:00   rpc.portmap
  993 ?        S      0:00   svscan /var/service
  995 ?        S      0:00     supervise fw
  996 ?        S      0:00     supervise gpm
  997 ?        S      0:00       gpm -D -2 -m /dev/psaux -t ps2
 1007 ?        S      0:00     supervise ntp
 1011 ?        S      0:00       /bin/sh ./run
 2274 ?        S<     0:00         ntpdate -b -t 10 -p 4 -k /dev/null 1.1.1.1 PWD=/.local/var/service/ntp SHLVL=1 _=/usr/bin/ntpdate
 1008 ?        S      0:00     supervise log
 1012 ?        S      0:00       multilog t n5 /var/log/service/ntp
 1009 ?        S      0:00     supervise top
 1036 ?        S      0:19       top c s TERM=linux
 1020 ?        S      0:00     supervise ups
 1021 ?        S      0:00     supervise log
 1022 ?        S      0:00       multilog t =/var/log/service/ups/last.out /var/log/service/ups
 1027 ?        S      0:00     supervise klog
 1031 ?        S      0:00       klogd -n -c 3 -x
 1028 ?        S      0:00     supervise once
 1040 ?        S      0:00     supervise pptp
 1041 ?        S      0:00     supervise log
 1056 ?        S      0:00       multilog t /var/log/service/pptp
 1047 ?        S      0:00     supervise sshd
 1048 ?        S      0:00       tcpserver -v -R -H -l 0 -c 40 0.0.0.0 ssh setuidgid root sshd -i -e -u0
 1049 ?        S      0:00     supervise log
 1091 ?        S      0:00       multilog t /var/log/service/sshd
 1064 ?        S      0:00     supervise httpd
 1075 ?        S      0:00       tcpserver -v -R -H -l 0 -c 40 0.0.0.0 www setuidgid apache httpd -X -f /.local/var/service/httpd/httpd.conf
 1065 ?        S      0:00     supervise log
 1076 ?        S      0:00       multilog t /var/log/service/httpd
 1066 ?        S      0:00     supervise nmlog
 1071 ?        S      0:00       /bin/sh ./run
 1072 ?        S      0:00         /bin/sh ./run
 1073 ?        S      0:00           nmeter c l x lx  p lp m lm  nif nlo d120000
 1074 ?        S      0:00         logger -t
 1067 ?        S      0:00     supervise mysql
 1068 ?        S      0:00       /bin/sh ./run
 1128 ?        S      0:00         mysqld --user=mysql --datadir=/var/app/mysql-3.23.52/data --tmpdir=/var/app/mysql-3.23.52/tmp --socket=/.lo
 1069 ?        S      0:00     supervise log
 1070 ?        S      0:00       multilog t /var/log/service/mysql
 1087 ?        S      0:00     supervise pgsql
 1088 ?        S      0:00     supervise log
 1101 ?        S      0:00       multilog t /var/log/service/pgsql
 1113 ?        S      0:00     supervise serial0
 1115 ?        S      0:00     supervise dnscache_local
 1130 ?        S      0:00       ./dnscache ROOT=./root IP=0.0.0.0 IPSEND=0.0.0.0 FORWARDONLY=1 DATALIMIT=2000000 CACHESIZE=1000000 GID=50 UID
 1116 ?        S      0:00     supervise log
 1132 ?        S      0:00       multilog t /var/log/service/dnscache_local
 1117 ?        S      0:00     supervise nmeter
 1138 ?        S      0:00       nmeter t c l x lx  p lp f lf  b lb  m lm  nif nlo
 1118 ?        S      0:00     supervise ovpn-1
 1297 ?        S      0:00       openvpn --secret /.local/var/service/ovpn-1/key --dev tun --proto udp --port 8006 --remote 1.1.4.1 --ifconfig
 1119 ?        S      0:00     supervise log
 1152 ?        S      0:00       multilog /var/log/service/ovpn-1
 1163 ?        S      0:00     supervise getty_tty1
 1164 ?        S      0:00     supervise getty_tty2
 1870 vc/2     S      0:00       agetty 38400 /dev/tty2 linux TERM=linux
 1165 ?        S      0:00     supervise getty_tty3
 1218 vc/3     S      0:00       agetty 38400 /dev/tty3 linux TERM=linux
 1166 ?        S      0:00     supervise getty_tty4
 1227 vc/4     S      0:00       agetty 38400 /dev/tty4 linux TERM=linux
 1167 ?        S      0:00     supervise getty_tty5
 1231 vc/5     S      0:00       agetty 38400 /dev/tty5 linux TERM=linux
 1168 ?        S      0:00     supervise getty_tty6
 1232 vc/6     S      0:00       agetty 38400 /dev/tty6 linux TERM=linux
 1169 ?        S      0:00     supervise getty_tty7
 1233 vc/7     S      0:00       agetty 38400 /dev/tty7 linux TERM=linux
 1170 ?        S      0:00     supervise getty_tty8
 1222 vc/8     S      0:00       agetty 38400 /dev/tty8 linux TERM=linux
 1171 ?        S      0:00     supervise syslog
 1172 ?        S      0:00       syslogd -n -f /.local/var/service/syslog/syslogd.conf
 1247 ?        S      0:00         multilog /var/log/syslog/auth.all
 1252 ?        S      0:00         multilog /var/log/syslog/daemon.all
 1255 ?        S      0:00         multilog /var/log/syslog/kern.all
 1258 ?        S      0:00         multilog /var/log/syslog/mark.all
 1261 ?        S      0:00         multilog /var/log/syslog/syslog.all
 1264 ?        S      0:00         multilog /var/log/syslog/user.all
 1267 ?        S      0:00         multilog /var/log/syslog/7.debug
 1270 ?        S      0:00         multilog /var/log/syslog/6.info
 1273 ?        S      0:00         multilog /var/log/syslog/5.notice
 1276 ?        S      0:00         multilog /var/log/syslog/4.warning
 1279 ?        S      0:00         multilog /var/log/syslog/3.err
 1282 ?        S      0:00         multilog /var/log/syslog/2.crit
 1285 ?        S      0:00         multilog /var/log/syslog/1.alert
 1288 ?        S      0:00         multilog /var/log/syslog/0.emerg
 1176 ?        S      0:00     supervise watch_quasar
 1177 ?        S      0:00     supervise automount
 1179 ?        S      0:00       /bin/sh ./run
 1306 ?        S      0:00         sleep 32000
 1178 ?        S      0:00     supervise watcher
 1209 ?        S      0:00       /bin/sh ./run
 2278 ?        S      0:00         sleep 33


