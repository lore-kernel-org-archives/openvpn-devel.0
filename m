From: JuanJo Ciarlante <jjo-ipsec@...283...>
Message-ID: <20050421134313.H15659@...283...>
References: <425EE976.9040505@...376...> <20050420143356.C1503@...283...> <4266DA7F.6020106@...376...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <4266DA7F.6020106@...376...>; from berni@...376... on Thu, Apr 21, 2005 at 12:41:03AM +0200
Subject: [Openvpn-devel] Re: UDPv6 support for OpenVPN
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
Date: Thu Apr 21 10:41:43 2005
To: Bernhard Schmidt <berni@...376...>
Cc: openvpn-devel@lists.sourceforge.net

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2005 at 12:41:03AM +0200, Bernhard Schmidt wrote:
> JuanJo Ciarlante schrieb:
> 
> >>I've been just trying the OpenVPN IPv6 transport patch you posted ...
> > I've finished 2.0 final port of my patch; I've tested under FreeBSD-5.3
> > (compilation and run OK).
> > 
> > Get from:
> >    http://www.irrigacion.gov.ar/juanjo/openvpn/
> 
> Great, thanks ... Now it got just another problem :-)
> 
> When you do something with routes (--route for example, or
> --redirect-gateway) you get
> 
> Thu Apr 21 00:38:53 2005 OpenVPN 2.0 i386-unknown-freebsd5.3 [SSL]
> [PF_INET6] built on Apr 21 2005
> Thu Apr 21 00:38:53 2005 Static Encrypt: Cipher 'BF-CBC' initialized
> with 128 bit key
> Thu Apr 21 00:38:53 2005 Static Encrypt: Using 160 bit message hash
> 'SHA1' for HMAC authentication
> Thu Apr 21 00:38:53 2005 Static Decrypt: Cipher 'BF-CBC' initialized
> with 128 bit key
> Thu Apr 21 00:38:53 2005 Static Decrypt: Using 160 bit message hash
> 'SHA1' for HMAC authentication
> Thu Apr 21 00:38:53 2005 Assertion failed at socket.c:1495
> Thu Apr 21 00:38:53 2005 Exiting
> 
> same on linux. Any idea? :-)

Yep .. redirect-default-gateway semantics (even if NOT used ) are triggering
this, please try attached patch 

Feedbacck very welcome!

Regards

-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jjo-openvpn-udp6-v0.2.3-v0.2.4.diff"

? .deps
? .gdb_history
? .socket.c.swp
? Makefile
? autom4te.cache
? config.h
? config.log
? config.status
? occ.d
? openvpn
? out.k
? stamp-h1
? tspc.log
Index: socket.c
===================================================================
RCS file: /home/jjo/cvs.juanjo/openvpn/openvpn-2/socket.c,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 socket.c
--- socket.c	19 Apr 2005 18:25:11 -0000	1.4.2.1
+++ socket.c	21 Apr 2005 17:32:58 -0000
@@ -1492,7 +1492,20 @@
 {
   const struct link_socket_addr *lsa = info->lsa;
 
+/* 
+ * This logic supports "redirect-gateway" semantic, which 
+ * makes sense only for PF_INET routes over PF_INET endpoints
+ *
+ * Maybe in the future consider PF_INET6 endpoints also ...
+ * by now just ignore it
+ *
+ */
+#if defined ( USE_PF_INET6 ) || defined ( USE_PF_UNIX )
+  if(lsa->actual.addr.sa_family != AF_INET)
+	  return 0;
+#else
   ASSERT(lsa->actual.addr.sa_family == AF_INET);
+#endif
   if (addr_defined (&lsa->actual.addr))
     return ntohl (lsa->actual.in.sin_addr.s_addr);
   else if (addr_defined (&lsa->remote.addr))
Index: socket.h
===================================================================
RCS file: /home/jjo/cvs.juanjo/openvpn/openvpn-2/socket.h,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 socket.h
--- socket.h	19 Apr 2005 18:25:11 -0000	1.4.2.1
+++ socket.h	21 Apr 2005 17:32:58 -0000
@@ -84,7 +84,9 @@
 union sockaddr_ovpn {
 		struct sockaddr addr;
 		struct sockaddr_in in;
+#ifdef USE_PF_INET6
 		struct sockaddr_in6 in6;
+#endif
 #ifdef USE_PF_UNIX
 		struct sockaddr_un un;
 #endif

--a8Wt8u1KmwUX3Y2C--

