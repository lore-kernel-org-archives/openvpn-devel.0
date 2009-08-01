Message-Id: <274D1D88-EB61-4754-AA47-042B33411140@...1247...>
From: Stefan Bethke <stb@...1247...>
In-Reply-To: <9075ED2D-8ABB-4462-B0F3-48CCE5AF129E@...1247...>
Content-Type: multipart/mixed; boundary=Apple-Mail-2-236492740
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Sat, 1 Aug 2009 13:37:12 +0200
References: <B4AA014B-2444-40AA-A3A3-417E4B89DF90@...1247...>
	<4A709126.5050102@...1248...>
	<3A1518B9-2C8C-4F05-9195-82C6017E4902@...1247...>
	<op.uxusbswp1e62zd@...33...>
	<BEE762CA-4282-4BA8-B92B-AFC7AAE3CA9A@...1247...>
	<op.uxvfpabu1e62zd@...33...>
	<9075ED2D-8ABB-4462-B0F3-48CCE5AF129E@...1247...>
Subject: Re: [Openvpn-devel] recent change to ifconfig breaks OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: OpenVPN Developer Mailing List <Openvpn-devel@lists.sourceforge.net>
Cc: Matthias Andree <matthias.andree@...68...>, James Yonan <jim@...41...>

--Apple-Mail-2-236492740
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Am 30.07.2009 um 10:47 schrieb Stefan Bethke:

> I'm leaving off freebsd-current, since I believe the problem is in
> OpenVPN's tun.c, as pointed out by Matthias below.
>
> Some background on my issue: FreeBSD 8.0-beta2 has apparently
> introduced a change where the previously working ifconfig invocation
> is now failing.  I'm leaving out the discussion on what exactly that
> change is and if this effect is desired or not, but concentrate on
> what OpenVPN is trying to do. We're strictly talking --topology subnet
> here. tap's are not affected.  I haven't tested any other topology.
>
> As can be seen in the commit below, ifconfig is invoked with both the
> local and the remote IP address set to the server-assigned local
> address.  If this code could be changed to call ifconfig with the
> local address and the server's VPN address (I believe generally .1)
> things should be fine. (Also on earlier versions of FreeBSD.)  It
> might be necessary to install an explicit route for the subnet, since
> FreeBSD will only install a host route for the remote end of the  
> point-
> to-point link.  Please note that FreeBSD's tun interface is always in
> point-to-point mode, and cannot be configured as a broadcast  
> interface.

Luckily, FreeBSD's tun can be switched from point-to-point mode to  
broadcast.  The attached patch does this.  I've tested this  
successfully on FreeBSD 7-stable and 8-beta2, with server and client  
in --topology subnet and net30 modes.


Stefan


--Apple-Mail-2-236492740
Content-Disposition: attachment;
	filename=patch-tun.c
Content-Type: application/octet-stream; x-mac-creator=43574945;
	x-unix-mode=0644; x-mac-type=54455854; name="patch-tun.c"
Content-Transfer-Encoding: 7bit

--- tun.c.orig	2009-05-30 23:34:13.000000000 +0200
+++ tun.c	2009-07-31 14:22:31.000000000 +0200
@@ -863,11 +863,10 @@
       else {
 	if (tt->topology == TOP_SUBNET)
             argv_printf (&argv,
-                              "%s %s %s %s netmask %s mtu %d up",
+                              "%s %s %s netmask %s mtu %d up",
                               IFCONFIG_PATH,
                               actual,
                               ifconfig_local,
-                              ifconfig_local,
                               ifconfig_remote_netmask,
                               tun_mtu
                               );
@@ -1745,14 +1744,15 @@
 {
   open_tun_generic (dev, dev_type, dev_node, ipv6, true, true, tt);
 
-  if (tt->fd >= 0)
+  if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
     {
       int i = 0;
 
-      /* Disable extended modes */
+      i = tt->topology == TOP_SUBNET ? IFF_BROADCAST : IFF_POINTOPOINT;
+      i |= IFF_MULTICAST;
+      ioctl (tt->fd, TUNSIFMODE, &i);
+      i = 0;
       ioctl (tt->fd, TUNSLMODE, &i);
-      i = 1;
-      ioctl (tt->fd, TUNSIFHEAD, &i);
     }
 }
 

--Apple-Mail-2-236492740
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit


-- 
Stefan Bethke <stb@...1247...>   Fon +49 151 14070811





--Apple-Mail-2-236492740--

