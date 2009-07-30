Date: Thu, 30 Jul 2009 10:11:24 +0200
From: "Matthias Andree" <matthias.andree@...68...>
MIME-Version: 1.0
References: <B4AA014B-2444-40AA-A3A3-417E4B89DF90@...1247...>
	<4A709126.5050102@...1248...>
	<3A1518B9-2C8C-4F05-9195-82C6017E4902@...1247...>
	<op.uxusbswp1e62zd@...33...>
	<BEE762CA-4282-4BA8-B92B-AFC7AAE3CA9A@...1247...>
Message-ID: <op.uxvfpabu1e62zd@...33...>
In-Reply-To: <BEE762CA-4282-4BA8-B92B-AFC7AAE3CA9A@...1247...>
Subject: Re: [Openvpn-devel] recent change to ifconfig breaks OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Stefan Bethke <stb@...1247...>
Cc: FreeBSD Current <freebsd-current@...1249...>, OpenVPN Developer Mailing List <Openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

Dear Jim and other OpenVPN hackers,

there is an OpenVPN regression, apparently affecting 2.1 on FreeBSD-8, and  
caused by OpenVPN configuring the local address on a P2P interface for the  
local AND ALSO the remote address.

See  
http://lists.freebsd.org/pipermail/freebsd-current/2009-July/010032.html  
and followups for details.


Am 30.07.2009, 08:40 Uhr, schrieb Stefan Bethke <stb@...1247...>:

> I'm not sure if that is a more general problem with OpenVPN (at least in  
> --topology subnet mode), or a specific problem in the FreeBSD-specific  
> code.  I just looked at a Linux box connected to the same OpenVPN  
> server, and their ifconfig invocation looks different from ours, so the  
> FreeBSD-specific code at least plays some role.
>
> I'd still like to know whether the change to the routing code is  
> intentional or a regression.

Stefan,

Which version of OpenVPN are you using?

It might seem that this is a FreeBSD regression, as OpenVPN assumes this  
about --topology subnet, so that the using of the local address as remote  
is intentional.

(This is from the current OpenVPN 2.1-RC manpage):

               subnet  -- Use a subnet rather than a point-to-point  
topology by
               configuring the tun interface with a local IP address and  
subnet
               mask,  similar  to  the  topology used in --dev tap and  
ethernet
               bridging mode.  This mode allocates a single IP address per  
con-
               necting  client  and  works  on Windows as well.  Only  
available
               when server and clients are OpenVPN 2.1 or  higher,  or   
OpenVPN
               2.0.x which has been manually patched with the --topology  
direc-
               tive code.  When used on Windows, requires version 8.2 or  
higher
               of  the  TAP-Win32 driver.  When used on *nix, requires that  
the
               tun driver supports an ifconfig(8) command which sets  a   
subnet
               instead of a remote endpoint IP address.


I see this in the ChangeLog:

2006.04.05 -- Version 2.1-beta12
...
* "topology subnet" fix for FreeBSD (Benoit Bourdin).
...


And it appears that exactly this patch may be the culprit. This is from  
the OpenVPN 2.1 source repository:

------------------------------------------------------------------------
r986 | james | 2006-04-05 08:28:19 +0200 (Wed, 05 Apr 2006) | 2 lines
Changed paths:
    M /branches/BETA21/openvpn/tun.c

"topology subnet" fix for FreeBSD (Benoit Bourdin).

------------------------------------------------------------------------

Index: tun.c
===================================================================
--- tun.c	(Revision 985)
+++ tun.c	(Revision 986)
@@ -795,19 +795,42 @@
  			  ifconfig_remote_netmask,
  			  tun_mtu
  			  );
-      else
-	openvpn_snprintf (command_line, sizeof (command_line),
+      else {
+	if (tt->topology == TOP_SUBNET)
+            openvpn_snprintf (command_line, sizeof (command_line),
+                              IFCONFIG_PATH " %s %s %s netmask %s mtu %d  
up",
+                              actual,
+                              ifconfig_local,
+                              ifconfig_local,
+                              ifconfig_remote_netmask,
+                              tun_mtu
+                              );
+	else
+  	    openvpn_snprintf (command_line, sizeof (command_line),
  			  IFCONFIG_PATH " %s %s netmask %s mtu %d up",
  			  actual,
  			  ifconfig_local,
  			  ifconfig_remote_netmask,
  			  tun_mtu
  			  );
+      }
  	
        msg (M_INFO, "%s", command_line);
        system_check (command_line, es, S_FATAL, "FreeBSD ifconfig failed");
        tt->did_ifconfig = true;

+	/* Add a network route for the local tun interface */
+      if (!tun && tt->topology == TOP_SUBNET)
+        {
+          struct route r;
+          CLEAR (r);
+          r.defined = true;
+          r.network = tt->local & tt->remote_netmask;
+          r.netmask = tt->remote_netmask;
+          r.gateway = tt->local;
+          add_route (&r, tt, 0, es);
+        }
+
  #elif defined (WIN32)
        {
  	/*


-- 
Matthias Andree

