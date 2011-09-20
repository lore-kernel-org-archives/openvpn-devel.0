Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_F16171CC-4D73-4A09-B714-D1251B150DDA"
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <CACZrk5fMRMOayEeT-bX-F8ir1vd0=3p3G-Ft_6bzo+9jpdJ2rw@...278...>
Date: Tue, 20 Sep 2011 09:15:24 -0500
Message-Id: <A26F53C9-09DE-4BDC-BAC5-383EB3A658A8@...1286...>
References: <4E7364D9.3020706@...384...>
	<CALCV6bdx31k4SK_FyVZEA6Vv71GBBKSMRot8NRL2FvR918QUuA@...278...>
	<CALCV6beAdFzbKd6BUaRoQyMMtykaoV=PETw6q=Kh7gA4T90cXw@...278...>
	<CALCV6bcYsbTTvWz_fa=TELmFb5=qucJT77w9bAs0_SJkbVjDiw@...278...>
	<CALCV6be++J3mcup6Jy9n+buoYe3QwGaVk4kxhR0d28jPxLh2pQ@...278...>
	<CALCV6bcu4Zi+H5bZ_nNp_NZQDY2PB9A_LP1DKrXW9b88hDbLrg@...278...>
	<CALCV6bfP7R3dxfdLQvU4yDCe2FnkkAVeb_Ohm3ARUb8kvTDpng@...278...>
	<4E774F8A.1010803@...384...>
	<CF814EC1-EEDC-4E78-81B8-2D425055C825@...1286...>
	<CALCV6bdAErM-AXKAKpiVnNgirbGtqD5XBSwgKzoqPjO5QUUZHg@...278...>
	<CACZrk5fMRMOayEeT-bX-F8ir1vd0=3p3G-Ft_6bzo+9jpdJ2rw@...278...>
Subject: Re: [Openvpn-devel] Build issues on OSX Lion
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: JuanJo <juanjosec@...277...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

--Apple-Mail=_F16171CC-4D73-4A09-B714-D1251B150DDA
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On Sep 19, 2011, at 16:05:27, JuanJo wrote:

> On Mon, Sep 19, 2011 at 5:56 PM, JuanJo Ciarlante <jjo+ml@...410...> wrot=
e:
>> On Mon, Sep 19, 2011 at 4:46 PM, Eric Crist <ecrist@...1286...> wrote:
>>> After testing, this appears to compile and function, with David's tun-s=
tuff.patch, which was attached to the first message.
>=20
> FYI indeed had to add tun-stuff.patch to compile under freebsd, quickly
> tested ok also.
>=20
>>=20
>> Great! ... thanks Eric for testing this (fwiw checked building+test under
>> openbsd ok - just to assert that I didn't broke any BSDism).
>>=20
>> Cheers,


JuanJo,

I forgot to mention the FreeBSD bit, that was something I already knew, sor=
ry for wasting your time by not saying something.  For posterity, I've atta=
ched the patches here, and added the openvpn-devel list as a CC.

Eric Crist


--Apple-Mail=_F16171CC-4D73-4A09-B714-D1251B150DDA
Content-Disposition: attachment;
	filename=0001-fix-ipv6-compilation-under-macosx-1070-v3.patch
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/x-patch;
	name="0001-fix-ipv6-compilation-under-macosx-1070-v3.patch"
Content-Transfer-Encoding: quoted-printable

=46rom f11d7ddb965c6bd65d7dd02cc57539ea4f1c5598 Mon Sep 17 00:00:00 2001
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Mon, 19 Sep 2011 16:07:14 +0200
Subject: [PATCH] fix ipv6 compilation under macosx >=3D 1070 - v3
 - use __APPLE_USE_RFC_3542 for macosx build environment >=3D 1070
 - define SOL_IP from IPPROTO_IP if it's missing
   In Linux man 7 ip says:
   "Using SOL_IP socket options level isn't portable, BSD-based
   stacks use IPPROTO_IP level."

Signed-off-by: JuanJo Ciarlante <jjo+ml@...410...>
---
 socket.c  |    3 +--
 socket.h  |    6 ++----
 syshead.h |   14 ++++++++++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/socket.c b/socket.c
index a2f9511..47e44ed 100644
--- a/socket.c
+++ b/socket.c
@@ -2878,8 +2878,7 @@ struct openvpn_in4_pktinfo
   struct cmsghdr cmsghdr;
 #ifdef HAVE_IN_PKTINFO
   struct in_pktinfo pi4;
-#endif
-#ifdef IP_RECVDSTADDR
+#elif defined(IP_RECVDSTADDR)
   struct in_addr pi4;
 #endif
 };
diff --git a/socket.h b/socket.h
index a9a29c5..4a4f75d 100644
--- a/socket.h
+++ b/socket.h
@@ -86,8 +86,7 @@ struct link_socket_actual
   union {
 #ifdef HAVE_IN_PKTINFO
     struct in_pktinfo in4;
-#endif
-#ifdef IP_RECVDSTADDR
+#elif defined(IP_RECVDSTADDR)
     struct in_addr in4;
 #endif
     struct in6_pktinfo in6;
@@ -589,8 +588,7 @@ addr_defined_ipi (const struct link_socket_actual =
*lsa)
   switch (lsa->dest.addr.sa.sa_family) {
 #ifdef HAVE_IN_PKTINFO
     case AF_INET: return lsa->pi.in4.ipi_spec_dst.s_addr !=3D 0;
-#endif
-#ifdef IP_RECVDSTADDR
+#elif defined(IP_RECVDSTADDR)
     case AF_INET: return lsa->pi.in4.s_addr !=3D 0;
 #endif
     case AF_INET6: return =
!IN6_IS_ADDR_UNSPECIFIED(&lsa->pi.in6.ipi6_addr);
diff --git a/syshead.h b/syshead.h
index e208d4c..66a2538 100644
--- a/syshead.h
+++ b/syshead.h
@@ -57,6 +57,12 @@
 #define srandom srand
 #endif
=20
+#if defined(__APPLE__)
+#if __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ >=3D 1070
+#define __APPLE_USE_RFC_3542  1
+#endif
+#endif
+
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
@@ -401,6 +407,14 @@
 #endif
=20
 /*
+ * Does this platform define SOL_IP
+ * or only bsd-style IPPROTO_IP ?
+ */
+#ifndef SOL_IP
+#define SOL_IP IPPROTO_IP
+#endif
+
+/*
  * Disable ESEC
  */
 #if 0
--=20
1.7.3.1


--Apple-Mail=_F16171CC-4D73-4A09-B714-D1251B150DDA
Content-Disposition: attachment;
	filename=tun-stuff.patch
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/x-patch;
	name="tun-stuff.patch"
Content-Transfer-Encoding: 7bit

diff --git a/tun.c b/tun.c
index aa17c36..5185f73 100644
--- a/tun.c
+++ b/tun.c
@@ -865,13 +865,13 @@ do_ifconfig (struct tuntap *tt,
 	  /* Add a network route for the local tun interface */
 	  struct route r;
 	  CLEAR (r);      
-	  r.defined = true;       
+	  r.flags = RT_DEFINED
 	  r.network = tt->local & tt->remote_netmask;
 	  r.netmask = tt->remote_netmask;
 	  r.gateway = tt->local;  
 	  r.metric_defined = true;
 	  r.metric = 0;
-	  add_route (&r, tt, 0, es);
+	  add_route (&r, tt, 0, NULL, es);
 	}
 
       tt->did_ifconfig = true;
@@ -1061,11 +1061,11 @@ do_ifconfig (struct tuntap *tt,
 	{
 	  struct route r;
 	  CLEAR (r);
-	  r.defined = true;
+	  r.flags = RT_DEFINED;
 	  r.network = tt->local & tt->remote_netmask;
 	  r.netmask = tt->remote_netmask;
 	  r.gateway = tt->local;
-	  add_route (&r, tt, 0, es);
+	  add_route (&r, tt, 0, NULL, es);
 	}
 
       if ( do_ipv6 )
@@ -1105,21 +1105,21 @@ do_ifconfig (struct tuntap *tt,
                               ifconfig_remote_netmask,
                               tun_mtu
                               );
-	
+
       argv_msg (M_INFO, &argv);
       openvpn_execve_check (&argv, es, S_FATAL, "FreeBSD ifconfig failed");
       tt->did_ifconfig = true;
 
 	/* Add a network route for the local tun interface */
       if (!tun && tt->topology == TOP_SUBNET)
-        {               
+        {
           struct route r;
-          CLEAR (r);      
-          r.defined = true;       
+          CLEAR (r);
+          r.flags = RT_DEFINED;
           r.network = tt->local & tt->remote_netmask;
           r.netmask = tt->remote_netmask;
-          r.gateway = tt->local;  
-          add_route (&r, tt, 0, es);
+          r.gateway = tt->local;
+          add_route (&r, tt, 0, NULL, es);
         }
 
       if ( do_ipv6 )

--Apple-Mail=_F16171CC-4D73-4A09-B714-D1251B150DDA--

