Message-Id: <200302231610.h1NGAKf32688@...41...>
Subject: Re: [Openvpn-devel] MTU
From: "James Yonan" <jim@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Feb 23 08:11:08 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Russ,

Have you tried the tracepath utility to attempt to measure the Path MTU?

Are the routers in the path properly forwarding ICMP code 3 (destination
unreachable), and ICMP code 4 (fragmentation needed but don't-fragment bit set)?

Most MTU problems are caused by routers and firewalls which do not handle
these ICMP codes correctly, causing path MTU discovery to break.

The symptoms of this problem are as you show below...  Running an app over the
 tunnel works fine initially until the first large packet is sent, then the
app hangs.

Right now OpenVPN relies on Path MTU Discovery (a service provided by the
kernel) to get the MTU right, so in the short run the best thing you can do is
to try to get Path MTU working.

You could also try to lower --udp-mtu by trial and error until you find
something that works (essentially a manual approach to MTU discovery).

If you are running tunnels over tunnels, the lower-level (more nested) tunnels
will need lower --udp-mtu settings. 

Longer-term, I hope to put some intelligence in OpenVPN to do this automatically.

James

R P Herrold <herrold@...43...> said:

> On Sat, 22 Feb 2003, James Yonan wrote:
> 
> > Recently I've been taking a new look at MTU issues.  It seems that some people
> > are having problems lately that are related to MTU or PMTU discovery.
> > 
> > I was trying to think up some ways to make OpenVPN's handling of MTU a bit
> > less opaque, more automatic, and also give more manual control to those who
> > know what they're doing.
> 
> If it is any help, I can replicate the error on demand.  Coing 
> frm my host 'couch', through two openvpn legs, once of which 
> is running encryption, the other not, I get:
> 
> [root@...69... ORC]# scp ftp.victim.lan:/etc/ORC/* .
> root@...70...'s password:
> Permission denied, please try again.
> root@...70...'s password:
> ORCsetPXE              0% |                             |     
> 0       --:-- ETAKilled by signal 2.
> 
>    **** it is locked up and hung here.
> 
> [root@...69... ORC]# ssh ftp.victim.lan
> root@...70...'s password:
> Last login: Sat Feb 22 15:21:51 2003 from router.victim.lan
> [root@...71... root]# cd /etc/ORC
> [root@...71... ORC]# scp * couch.basement.lan:/etc/ORC
> The authenticity of host 'couch.basement.lan (10.16.33.101)' can't be
established.
> RSA1 key fingerprint is 38:d4:69:9e:cb:96:81:68:d2:2b:6b:6f:b9:33:c2:39.
> Are you sure you want to continue connecting (yes/no)? yes
> Warning: Permanently added 'couch.basement.lan,10.16.33.101' 
> (RSA1) to the list of known hosts.
> root@...72...'s password:
> ORCsetPXE            100% |*****************************|  3032       00:00
> ORCsetPXE~           100% |*****************************|  2955       00:00
> installCDrc          100% |*****************************|   234       00:00
> installCDrc-80       100% |*****************************|   227       00:00
> installCDrc-8094     100% |*****************************|   234       00:00
> installCDrc-LTSP     100% |*****************************|   188       00:00
> installCDrc-template 100% |*****************************|   565       00:00
> [root@...71... ORC]#
> [root@...71... ORC]# dmesg
> Linux version 2.4.18-17.8.0 (bhcompile@...73...) 
> (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Tue 
> Oct 8 13:51:08 EDT 2002
> 
>      **** it is locked up and hung here.
> 
> 
> going to another host in that same remote subnet, but behind 
> the router I also get:
> 
> (from 10.16.33.101 - host: couch )
> 
> bash-2.05b$ ssh ftp.victim.lan
> herrold@...70...'s password:
> [herrold@...71... herrold]$ dmesg
> Linux version 2.4.18-17.8.0 (bhcompile@...73...) 
> (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Tue Oct 8 13:51:08
EDT 2002
> 
>       **** it is locked up and hung here.
> 
> 
> lots of these on ftp.victim.lan:
> 
> ISO 9660 Extensions: RRIP_1991A
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> ICMP: 10.16.33.101: fragmentation needed and DF set.
> 
> but no 'noise; attributable to the tun device or openvpn in 
> the router:
> 
> 
> eth0: Promiscuous mode enabled.
> device eth0 entered promiscuous mode
> Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> divert: not allocating divert_blk for non-ethernet device tun0ip_conntrack
(2047 buckets, 16376 max)
> TCP: Treason uncloaked! Peer 10.1.2.30:515/692 shrinks window
2141696489:2141697513. Repaired.
> TCP: Treason uncloaked! Peer 10.1.2.30:515/692 shrinks window
2141696489:2141697513. Repaired.
> TCP: Treason uncloaked! Peer 10.1.2.30:515/692 shrinks window
2141696489:2141697513. Repaired.
> TCP: Treason uncloaked! Peer 10.1.2.30:515/692 shrinks window
2141696489:2141697513. Repaired.
> TCP: Treason uncloaked! Peer 10.1.2.30:515/692 shrinks window
2141696489:2141697513. Repaired.
> TCP: Treason uncloaked! Peer 10.1.2.30:515/692 shrinks window
2141696489:2141697513. Repaired.
> TCP: Treason uncloaked! Peer 10.1.2.30:515/692 shrinks window
2141696489:2141697513. Repaired.
> divert: no divert_blk to free, tun0 not ethernet
> divert: not allocating divert_blk for non-ethernet device tun0
> [herrold@...74... herrold]$ 
> 
>    ...   10.1.2.30 is a printservice device, not relebant 
> here, I think
> 
> =================
> 
> General layout
> 
> 10.16.33.101 --- clear tunnel to hub -- 
>   hub in the internet-- encrypted tunnel to hub -- 10.0.1.x 
> 
> The subnet 'victim.lan' is doubly masg'd -- behind two
> iptables based NATting.  This may be affecting things.
> 
> 
>   0.0.0.0 --- public-10.1.2.x --- 10.1.2.y-10.250.0.x --- 
>  internet            |        dmz          |         victim.lan
>                    NAT 1                 NAT 2
> 
> -- Russ Herrold
> 



-- 






