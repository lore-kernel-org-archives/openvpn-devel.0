From: Waldemar Brodkorb <wbx@...270...>
Message-ID: <20040911143321.GG31609@...271...>
Reply-To: Waldemar Brodkorb <wbx@...270...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
Subject: [Openvpn-devel] Mac OS X tap support
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
Date: Sat Sep 11 07:33:10 2004
To: openvpn-devel@lists.sourceforge.net
Cc: Mattias Nissler <mattias.nissler@...68...>

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

yesterday we found a new tun/tap kernel extension for Mac OS X
here:
http://www-user.rhrk.uni-kl.de/~nissler/tuntap/

After some short testing and a small patch to OpenVPN
the Mac OS X client seems to work correctly via the
TAP device.

It would be nice if this patch and eventually 
the driver could be integrated into openvpn like the
win32 driver. 

If someone is interested we also would provide a binary
package, which installs the tap/tun driver and OpenVPN on
Mac OS X.

We have a project in our university, where we would like to
use OpenVPN to secure our Wireless LAN. 

Mattias Nissler: Thanks for providing this driver, there
was a very short timeslice, where I was thinkning to do a tap
kernel extension on my own ... but luckily Daniel Lehmann has some
greater ability to use google correctly ;)

Thanks in advance
    Waldemar  

-- 
CE94 5F99 BA88 65B1 25B9  8CD1 305A FF6B F8F8 1846
gpg --keyserver x-hkp://pgp.mit.edu --recv-keys F8F81846

*** http://www.luusa.org/~wbx ***

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="openvpn-macosx-tap.patch"

Index: INSTALL
===================================================================
RCS file: /cvsroot/openvpn/openvpn/INSTALL,v
retrieving revision 1.37.2.2
diff -d -u -r1.37.2.2 INSTALL
--- INSTALL	24 Jun 2004 03:48:27 -0000	1.37.2.2
+++ INSTALL	11 Sep 2004 14:25:41 -0000
@@ -232,6 +232,9 @@
 
   Obtain Christoph Pfisterer's TUN driver at
   http://chrisp.de/en/projects/tunnel.html
+  or  
+  Mattias Nissler's TUN/TAP driver at
+  http://www-user.rhrk.uni-kl.de/~nissler/tuntap/
 
 * Solaris9 Sparc/64
 
Index: tun.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/tun.c,v
retrieving revision 1.37.2.21
diff -d -u -r1.37.2.21 tun.c
--- tun.c	19 Aug 2004 03:28:11 -0000	1.37.2.21
+++ tun.c	11 Sep 2004 14:25:46 -0000
@@ -682,7 +682,14 @@
 			  tun_mtu
 			  );
       else
-	no_tap_ifconfig ();
+	openvpn_snprintf (command_line, sizeof (command_line),
+			  IFCONFIG_PATH " %s %s netmask %s mtu %d up",
+			  actual,
+			  ifconfig_local,
+			  ifconfig_remote_netmask,
+			  tun_mtu
+			  );
+
       msg (M_INFO, "%s", command_line);
       system_check (command_line, "Mac OS X ifconfig failed", true);
       tt->did_ifconfig = true;

--DBIVS5p969aUjpLe--

