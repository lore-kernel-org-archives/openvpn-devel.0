From: samuli@...515...
Date: Thu, 11 Aug 2011 19:00:57 +0300
Message-Id: <1313078457-6512-1-git-send-email-samuli@...515...>
In-Reply-To: <4E1F78E8.4050203@...515...>
References: <4E1F78E8.4050203@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Merged TODO.IPv6 with TODO.ipv6 and
	README.IPv6 with README.ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Prior to this patch were two sets of IPv6 README/TODO files: one from paylo=
ad
and one from transport patchset. Unfortunately Git on Windows gets very con=
fused
of these files, as they only differ in case. This patch merges these sets i=
nto
one.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 README.IPv6 |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 README.ipv6 |   81 --------------------------------------------------
 TODO.IPv6   |   41 ++++++++++++++++++++++++-
 TODO.ipv6   |   30 ------------------
 4 files changed, 131 insertions(+), 116 deletions(-)
 delete mode 100644 README.ipv6
 delete mode 100644 TODO.ipv6

diff --git a/README.IPv6 b/README.IPv6
index ca578f2..bbb9db3 100644
--- a/README.IPv6
+++ b/README.IPv6
@@ -1,8 +1,97 @@
-This is an experimentally patched version of OpenVPN 2.1 with IPv6
-payload support.
+IPv6 payload support
+--------------------
=20
-Go here for release notes and documentation:
+Latest IPv6 payload support code and documentation can be found from here:
=20
   http://www.greenie.net/ipv6/openvpn.html
=20
+For TODO list, see TODO.IPv6.
+
 Gert Doering, 31.12.2009
+
+
+
+IPv6 transport support
+----------------------
+
+[ Last updated: 25-Mar-2011. ]
+
+OpenVPN-2.1 over UDP6/TCP6 README for ipv6-0.4.x patch releases:
+( --udp6 and --tcp6-{client,server} )
+
+* Availability
+  Source code under GPLv2 from http://github.com/jjo/openvpn-ipv6
+
+  Distro ready repos/packages:
+  o Debian sid official repo, by Alberto Gonzalez Iniesta,
+    starting from openvpn_2.1~rc20-2
+  o Gentoo official portage tree, by Marcel Pennewiss:
+    - https://bugs.gentoo.org/show_bug.cgi?id=3D287896
+  o Ubuntu package, by Bernhard Schmidt:
+    - https://launchpad.net/~berni/+archive/ipv6/+packages
+  o Freetz.org, milestone freetz-1.2
+    - http://trac.freetz.org/milestone/freetz-1.2
+
+* Status:
+  o OK:
+    - upd6,tcp6: GNU/Linux, win32, openbsd-4.7, freebsd-8.1
+    - udp4->upd6,tcp4->tcp6 (ipv4/6 mapped): GNU/Linux
+      (gives a warning on local!=3Dremote proto matching)
+  o NOT:
+    - win32: tcp4->tcp6 (ipv4/6 mapped) fails w/connection refused
+  o NOT tested:
+    - mgmt console
+
+* Build setup:
+  ./configure --enable-ipv6        (by default)
+
+* Usage:
+  For IPv6 just specify "-p upd6" an proper IPv6 hostnames, adapting the e=
xample
+  from man page ...
+
+  On may:
+    openvpn --proto udp6 --remote <june_IPv6_addr> --dev tun1 \
+      --ifconfig 10.4.0.1 10.4.0.2 --verb 5 --secret key
+
+  On june:
+    openvpn --proto udp6 --remote <may_IPv6_addr>  --dev tun1 \
+      --ifconfig 10.4.0.2 10.4.0.1 --verb 5 --secret key
+
+  Same for --proto tcp6-client, tcp6-server.
+
+* Main code changes summary:
+  - socket.h: New struct openvpn_sockaddr type that holds sockaddrs and pk=
tinfo,
+    (here I omitted #ifdef USE_PF_xxxx, see socket.h )
+
+    struct openvpn_sockaddr {
+    	union {
+		struct sockaddr sa;
+		struct sockaddr_in in;
+		struct sockaddr_in6 in6;
+    	} addr;
+    };
+
+    struct link_socket_addr
+    {
+            struct openvpn_sockaddr local;
+            struct openvpn_sockaddr remote;
+            struct openvpn_sockaddr actual;
+    };
+
+    PRO: allows simple type overloading: local.addr.sa, local.addr.in, loc=
al.addr.in6 ... etc
+    (also local.pi.in and local.pi.in6)
+
+  - several function prototypes moved from sockaddr_in to openvpn_sockaddr
+  - several new sockaddr functions needed to "generalize" AF_xxxx operatio=
ns:
+    addr_copy(), addr_zero(), ...etc
+    proto_is_udp(), proto_is_dgram(), proto_is_net()
+
+* For TODO list, see TODO.IPv6
+
+--
+JuanJo Ciarlante   jjo () google () com ............................
+:                                                                  :
+.                                         Linux IP Aliasing author .
+.   Modular algo (AES et all) support for FreeSWAN/OpenSWAN author .
+.                                        OpenVPN over IPv6 support .
+:......     plus other scattered free software bits in the wild ...:
diff --git a/README.ipv6 b/README.ipv6
deleted file mode 100644
index 4295f85..0000000
--- a/README.ipv6
+++ /dev/null
@@ -1,81 +0,0 @@
-[ Last updated: 25-Mar-2011. ]
-
-OpenVPN-2.1 over UDP6/TCP6 README for ipv6-0.4.x patch releases:
-( --udp6 and --tcp6-{client,server} )
-
-* Availability
-  Source code under GPLv2 from http://github.com/jjo/openvpn-ipv6
-
-  Distro ready repos/packages:
-  o Debian sid official repo, by Alberto Gonzalez Iniesta,
-    starting from openvpn_2.1~rc20-2
-  o Gentoo official portage tree, by Marcel Pennewiss:
-    - https://bugs.gentoo.org/show_bug.cgi?id=3D287896
-  o Ubuntu package, by Bernhard Schmidt:
-    - https://launchpad.net/~berni/+archive/ipv6/+packages
-  o Freetz.org, milestone freetz-1.2
-    - http://trac.freetz.org/milestone/freetz-1.2
-
-* Status:
-  o OK:
-    - upd6,tcp6: GNU/Linux, win32, openbsd-4.7, freebsd-8.1
-    - udp4->upd6,tcp4->tcp6 (ipv4/6 mapped): GNU/Linux
-      (gives a warning on local!=3Dremote proto matching)
-  o NOT:
-    - win32: tcp4->tcp6 (ipv4/6 mapped) fails w/connection refused
-  o NOT tested:
-    - mgmt console
-
-* Build setup:
-  ./configure --enable-ipv6        (by default)
-
-* Usage:
-  For IPv6 just specify "-p upd6" an proper IPv6 hostnames, adapting the e=
xample
-  from man page ...
-
-  On may:
-    openvpn --proto udp6 --remote <june_IPv6_addr> --dev tun1 \
-      --ifconfig 10.4.0.1 10.4.0.2 --verb 5 --secret key
-
-  On june:
-    openvpn --proto udp6 --remote <may_IPv6_addr>  --dev tun1 \
-      --ifconfig 10.4.0.2 10.4.0.1 --verb 5 --secret key
-
-  Same for --proto tcp6-client, tcp6-server.
-
-* Main code changes summary:
-  - socket.h: New struct openvpn_sockaddr type that holds sockaddrs and pk=
tinfo,
-    (here I omitted #ifdef USE_PF_xxxx, see socket.h )
-
-    struct openvpn_sockaddr {
-    	union {
-    		struct sockaddr sa;
-    		struct sockaddr_in in;
-    		struct sockaddr_in6 in6;
-    	} addr;
-    };
-
-    struct link_socket_addr
-    {
-            struct openvpn_sockaddr local;
-            struct openvpn_sockaddr remote;
-            struct openvpn_sockaddr actual;
-    };
-
-    PRO: allows simple type overloading: local.addr.sa, local.addr.in, loc=
al.addr.in6 ... etc
-    (also local.pi.in and local.pi.in6)
-
-  - several function prototypes moved from sockaddr_in to openvpn_sockaddr
-  - several new sockaddr functions needed to "generalize" AF_xxxx operatio=
ns:
-    addr_copy(), addr_zero(), ...etc
-    proto_is_udp(), proto_is_dgram(), proto_is_net()
-
-* TODO: See TODO.ipv6
-
---
-JuanJo Ciarlante   jjo () google () com ............................
-:                                                                  :
-.                                         Linux IP Aliasing author .
-.   Modular algo (AES et all) support for FreeSWAN/OpenSWAN author .
-.                                        OpenVPN over IPv6 support .
-:......     plus other scattered free software bits in the wild ...:
diff --git a/TODO.IPv6 b/TODO.IPv6
index 092a1a3..59f7453 100644
--- a/TODO.IPv6
+++ b/TODO.IPv6
@@ -1,5 +1,5 @@
-known issues for IPv6 payload support in OpenVPN
------------------------------------------------
+TODO for IPv6 payload support
+-----------------------------
=20
 1.) "--topology subnet" doesn't work together with IPv6 payload on FreeBSD
     (verified for FreeBSD server, Linux/ifconfig client, problems=20
@@ -147,3 +147,40 @@ tun0: flags=3D8051<UP,POINTOPOINT,RUNNING,MULTICAST> m=
tu 1500
     to the config
=20
     (problem + workaround applies both to tun and tap style devices)
+
+
+
+
+TODO for IPv6 transport support
+-------------------------------
+
+[ Last updated: 11-Nov-2009. ]
+
+* All platforms:
+  o mgmt console: as currently passes straight in_addr_t bits around
+
+  o make possible to get AF from getaddrinfo() answer, ie allow openvpn to
+    use ipv4/6 if DNS returns A/AAAA without specifying protocol.
+    Hard: requires deep changes in initialization/calling logic
+
+  o use AI_PASSIVE
+
+  o the getaddr()/getaddr6() interface is not prepared for handling sockty=
pe
+    "tagging", currently I abuse the sockflags bits for getting the ai_soc=
ktype
+    downstream.
+
+  o implement comparison for mapped addesses: server in dual stack
+    listening IPv6 must permit incoming streams from allowed IPv4 peer,
+    currently you need to pass eg:  --remote ffff::1.2.3.4
+
+  o do something with multi mode learn routes, for now just ignoring
+    ipv6 addresses seems the most sensible thing to do, because there's
+    no support for intra-tunnel ipv6 stuff.
+
+* win32:
+  o find out about mapped addresses, as I can't make it work
+    with bound at ::1 and connect to 127.0.0.1
+
+* N/A:
+  o this is ipv6 *endpoint* support, so don't expect "ifconfig6"-like
+    support in this patch=20
diff --git a/TODO.ipv6 b/TODO.ipv6
deleted file mode 100644
index 966af2d..0000000
--- a/TODO.ipv6
+++ /dev/null
@@ -1,30 +0,0 @@
-[ Last updated: 11-Nov-2009. ]
-
-* All platforms:
-  o mgmt console: as currently passes straight in_addr_t bits around
-
-  o make possible to get AF from getaddrinfo() answer, ie allow openvpn to
-    use ipv4/6 if DNS returns A/AAAA without specifying protocol.
-    Hard: requires deep changes in initialization/calling logic
-
-  o use AI_PASSIVE
-
-  o the getaddr()/getaddr6() interface is not prepared for handling sockty=
pe
-    "tagging", currently I abuse the sockflags bits for getting the ai_soc=
ktype
-    downstream.
-
-  o implement comparison for mapped addesses: server in dual stack
-    listening IPv6 must permit incoming streams from allowed IPv4 peer,
-    currently you need to pass eg:  --remote ffff::1.2.3.4
-
-  o do something with multi mode learn routes, for now just ignoring
-    ipv6 addresses seems the most sensible thing to do, because there's
-    no support for intra-tunnel ipv6 stuff.
-
-* win32:
-  o find out about mapped addresses, as I can't make it work
-    with bound at ::1 and connect to 127.0.0.1
-
-* N/A:
-  o this is ipv6 *endpoint* support, so don't expect "ifconfig6"-like
-    support in this patch=20
--=20
1.7.4.1


