From: JuanJo Ciarlante <jjo-ipsec@...283...>
Message-ID: <20040924023235.M12953@...283...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
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
Date: Thu Sep 23 22:36:21 2004
To: openvpn-devel@lists.sourceforge.net

--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi ppl ...
As part of my master thesis _and_ community giveback y added UPDv6 support to
openvpn-2.0_beta11, its working AFAITested, see attached README.IPv6 for
details.

Output from my uoooooHAaaaAAA!! session:
"""
  root@...284... openvpn-2.0_beta11-jjo # ./openvpn  --dev tun --proto udp6 \
		--remote fe80::240:5ff:feae:c851 --port 5010 --secret ../openvpn.key \
		--ifconfig 1.1.1.253 1.1.1.1
  Tue Sep 21 17:30:39 2004 OpenVPN 2.0_beta11 i686-pc-linux [SSL] [LZO] [EPOLL] built on Sep 21 2004
  Tue Sep 21 17:30:39 2004 TUN/TAP device tun0 opened
  Tue Sep 21 17:30:39 2004 /sbin/ifconfig tun0 1.1.1.253 pointopoint 1.1.1.1
  mtu 1500
  Tue Sep 21 17:30:39 2004 UDPv6 link local (bound): [AF_INET6]:::5010
  Tue Sep 21 17:30:39 2004 UDPv6 link remote: [AF_INET6]fe80::240:5ff:feae:c851:5010
  Tue Sep 21 17:30:49 2004 Peer Connection Initiated with [AF_INET6]fe80::240:5ff:feae:c851%wlan0wds0:5000
  Tue Sep 21 17:30:51 2004 Initialization Sequence Completed

  :

  jjo@...284... jjo $ ping -c 2 1.1.1.1
  PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
  64 bytes from 1.1.1.1: icmp_seq=1 ttl=64 time=16.5 ms
  64 bytes from 1.1.1.1: icmp_seq=2 ttl=64 time=5.92 ms

  --- 1.1.1.1 ping statistics ---
  2 packets transmitted, 2 received, 0% packet loss, time 1001ms
  rtt min/avg/max/mdev = 5.928/11.258/16.588/5.330 ms
"""

BTW ... I've broke some basic indentation rules in order to avoid enlarging
diff size.

Patch attached, also available (GPL) under
   http://www.irrigacion.gov.ar/juanjo/ipsec/

Best regards...

--
--Juanjo

PS: Sorry for not signing this message, I've broken my mutt setup recently,
     you'll find signed MD5SUM @URL above..
     
#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="README.IPv6.txt"

# $Id: README.IPv6,v 1.1.2.5 2004/09/24 04:53:59 jjo Exp $ #

This README covers UDP/IPv6 ( --udp6 ) support for openvpn-2.0_beta11
Also, with address family "generalization" changes came local AF_UNIX socket
support.

Available under GPLv2 from 
  http://www.irrigacion.gov.ar/juanjo/openvpn/

See "Examples" section below for usage.

* Working:
  - upd6->upd6 (AF_INET6)
  - upd4->upd6 bound (show correctly mapped address) but requires
    --float (to be fixed soon)
  - unix-dgram->unix-dgram (AF_UNIX)
    useful for implementing local proxies that can take full advantage
    of POSIX filesystem permissions ( more powerfull access mechanisms
    than inet, even for localhost)

* Examples: some succesfully tested command lines 
  BTW did you know that openvpn can succesfully negotiate to self
  with --remote localhost ? (VERY useful for fast testing)
  
  - IPv6 "normal" usage (+succesfully tested tunnel traffic) 
    server# openvpn --proto udp6 ...
      :
      Thu Sep 23 22:15:48 2004 Peer Connection Initiated with [AF_INET6]fe80::205:5dff:fef1:1ceb%wlan0wds1:5000
      :
    client# openvpn --proto udp6 --remote fe80::240:5ff:feae:c851 ...
      :
      Thu Sep 23 22:13:19 2004 Peer Connection Initiated with [AF_INET6]fe80::240:5ff:feae:c851%wlan0wds0:5000
      :

  - IPv6 server, IPv4 client (more detailed)
    server# openvpn --proto udp6 ...
      :
      Thu Sep 23 22:28:36 2004 UDPv6 link local (bound): [AF_INET6][undef]:5000
      Thu Sep 23 22:28:36 2004 UDPv6 link remote: [AF_INET6][undef]
      Thu Sep 23 22:28:50 2004 Peer Connection Initiated with [AF_INET6]::ffff:10.55.14.253:5000
      Thu Sep 23 22:28:51 2004 Initialization Sequence Completed
      Thu Sep 23 22:28:56 2004 WARNING: Actual Remote Options ('... proto UDPv4 ... ') \
                               are inconsistent with Expected Remote Options ('... proto UDPv6 ...')

    client# openvpn  --remote 10.55.14.254 ...  ### same default as now: --udp
      :
      Thu Sep 23 22:26:11 2004 UDPv4 link local (bound): [AF_INET][undef]:5000
      Thu Sep 23 22:26:11 2004 UDPv4 link remote: [AF_INET]10.55.14.254:5000
      Thu Sep 23 22:26:21 2004 Peer Connection Initiated with [AF_INET]10.55.14.254:5000
      Thu Sep 23 22:26:21 2004 WARNING: Actual Remote Options ('... proto UDPv6 ...') \
                               are inconsistent with Expected Remote Options ('... proto UDPv4 ...')
      Thu Sep 23 22:26:22 2004 Initialization Sequence Completed

  - IPv6 loopback
    alone# openvpn --proto udp6 --remote ::1 ...
      :
      Wed Sep 22 13:03:07 2004 Peer Connection Initiated with [AF_INET6]::1:5000
      :

  - AF_UNIX toself
    alone# openvpn --proto unix-dgram --local /tmp/o.s --remote /tmp/o.s --dev tun  ...
      :
      Thu Sep 23 16:37:27 2004 Peer Connection Initiated with [AF_UNIX]/tmp/o.s
      :
  
  - AF_UNIX between to diff instances
    peer1# openvpn --proto unix-dgram --local /tmp/o1.s --remote /tmp/o2.s
    peer2# openvpn --proto unix-dgram --local /tmp/o2.s --remote /tmp/o1.s
      :
      Wed Sep 22 12:49:03 2004 Peer Connection Initiated with [AF_UNIX]/tmp/o1.s
      :
  

* Main code changes summary:
  - New sockaddr type (could have been sockaddr_storage but
    it lacks simple type overloading and maybe portability)
    union sockaddr_ovpn {
    	struct sockaddr addr;
    	struct sockaddr_in in;
    	struct sockaddr_in6 in6;
    #ifdef HAVE_SYS_UN_H
    	struct sockaddr_un un;
    #endif
    };
    
    typedef union sockaddr_ovpn sockaddr_ovpn_t;
    struct link_socket_addr
    {
    	sockaddr_ovpn_t local;
    	sockaddr_ovpn_t remote;
    	sockaddr_ovpn_t actual;
    };
    
    ... leads to simple type overloading: local.addr
    local.in, local.in6 ... etc

  - several function prototypes moved from
    sockaddr_in to sockaddr args type
  - several new sockaddr functions:
    addr_copy(), addr_zero(), ...etc
    proto_is_udp(), proto_is_dgram(), proto_is_net()

* TODO:
  - call socket() lately, after getaddrinfo() to decide IPv4 or IPv6 host 
    (hence socket()) instead of needing -p {udp|udp6}
    Not actually a big trouble, given that you _do_ setup both sides
    (keys, certs, etc), using udp or udp6 is actually another setup bit.
  - Implement comparison for mapped addesses: server in dual stack listening
    IPv6 must permit incoming streams from allowed IPv4 peer (ie without --float).
  - IPv6 with actual host resolution, currently only numerical (AI_NUMERICHOST)
  - integrate both IPv4 and IPv6 addr resolution with getaddrinfo instead of
    venerable gethostbyname&friends, problem: portability across platforms, 
    across libc versions? (dunno).

--
JuanJo Ciarlante   jjo|at|mendoza.gov.ar
:                                                                  :
.                                         Linux IP Aliasing author .
.   Modular algo (AES et all) support for FreeSWAN/OpenSWAN author .
:...       plus  other scattered free software bits in the wild ...:

--FEz7ebHBGB6b2e8X
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="openvpn-2.0_beta11-udp6-jjo-v0.2.1.patch.gz"
Content-Transfer-Encoding: base64

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
4Hx1vV2Y3/tf6PH5rUgDAQA=

--FEz7ebHBGB6b2e8X--

