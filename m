From: JuanJo Ciarlante <jjo-ipsec@...283...>
Message-ID: <20050429163854.K12118@...283...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
Subject: [Openvpn-devel] IPv6 support for OpenVPN 2.0 release (UDPv6, --udp6)
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
Date: Fri Apr 29 13:42:06 2005
To: openvpn-devel@lists.sourceforge.net

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi....

I've finished polishing mi udp6 patch for openvpn-2.0

You can get it from 
   http://www.irrigacion.gov.ar/juanjo/openvpn/
   
There are two patch flavors: udp6 and udp6+MH (mutlihome , as required by
James for merging). I've successfully tested udp6 on both (MH support
compiles ok but it isn't tested).

Feedback is welcome, enjOY!

Regards

-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="README.IPv6"

# $Id: README.IPv6,v 1.1.8.2.2.1 2005/04/29 20:23:41 jjo Exp $ #

This README covers UDP/IPv6 v0.2.4 ( --udp6 ) support for openvpn-2.0
Also, with address family "generalization" changes came local AF_UNIX socket
support.

Available under GPLv2 from 
  http://www.irrigacion.gov.ar/juanjo/openvpn/

See "Examples" section below for usage.

* Working:
  - upd6->upd6 (AF_INET6)
    tested on GNU/Linux, FreeBSD-5.3 and OpenBSD-3.6.
  - upd4->upd6 bound (show correctly mapped address) but requires
    --float (to be fixed soon)
  - unix-dgram->unix-dgram (AF_UNIX)
    useful for implementing local proxies that can take full advantage
    of POSIX filesystem permissions ( more powerfull access mechanisms
    than inet, even for localhost)

* Setup:
  ./configure --disable-ipv6        (enabled by default)
  ./configure --enable-unix-sockets (disabled by default)
  :

* Usage:
  For IPv6 just specify "-p upd6" an proper IPv6 hostnames, taking the example
  from man page ...

  On may:
    openvpn --proto udp6 --remote <june_IPv6_addr> --dev tun1 --ifconfig 10.4.0.1 10.4.0.2
    --verb 5 --secret key

  On june:
    openvpn --proto udp6 --remote <may_IPv6_addr>  --dev tun1 --ifconfig 10.4.0.2 10.4.0.1
    --verb 5 --secret key

* Examples: some succesfully tested command lines 
  [  BTW did you know that openvpn can succesfully negotiate to self
     with --remote localhost ? (VERY useful for fast testing)         ]
  
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

[[[ NOTE: this has changed change in MH (multihomed) merged tree ]]]

    it lacks simple type overloading and maybe portability)
    union sockaddr_ovpn {
    	struct sockaddr addr;
    	struct sockaddr_in in;
    	struct sockaddr_in6 in6;
#ifdef USE_PF_UNIX
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
    
    allows simple type overloading: local.addr, local.in, local.in6 ... etc

  - several function prototypes moved from
    sockaddr_in to sockaddr args type
  - several new sockaddr functions needed to "generalize" AF_xxxx operations:
    addr_copy(), addr_zero(), ...etc
    proto_is_udp(), proto_is_dgram(), proto_is_net()

* TODO: (D: Done, !: fundamental, w: wanted, n: nah ... not critical, ?: need more thought)
 --
  [D]-  ./configure [ --disable-ipv6 ] [ --enable-unix-sockets ] 
        map to USE_PF_INET6 and USE_PF_UNIX
  [D]-  merge MH patch
 --
  [!]-  -p tcp6
  [!]-  Implement comparison for mapped addesses: server in dual stack listening
        IPv6 must permit incoming streams from allowed IPv4 peer (ie without --float).
  [!]-  IPv6 with actual host resolution, currently only numerical (AI_NUMERICHOST)
  [n]-  call socket() lately, after getaddrinfo() to decide IPv4 or IPv6 host 
        (hence socket()) instead of needing -p {udp|udp6}
        NOT ACTUALLY a big trouble, given that you _do_ setup both sides
        (keys, certs, etc), using udp or udp6 is actually _another_ setup bit.
  [?]-  integrate both IPv4 and IPv6 addr resolution with getaddrinfo instead of
        venerable gethostbyname&friends, problem: horizontal portability (across
        platforms) and vertical portab. (across versions)
 
--
JuanJo Ciarlante   jjo|at|mendoza.gov.ar
:                                                                  :
.                                         Linux IP Aliasing author .
.   Modular algo (AES et all) support for FreeSWAN/OpenSWAN author .
:...       plus  other scattered free software bits in the wild ...:

--bp/iNruPH9dso1Pn--

