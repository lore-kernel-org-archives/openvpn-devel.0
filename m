From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] New pre-1.3.2 beta available, please test
Message-ID: <20021018233447.GB3745@...33...>
References: <200210170203.g9H23xL13456@...41...>
Mime-Version: 1.0
In-Reply-To: <200210170203.g9H23xL13456@...41...>
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
Date: Fri Oct 18 16:35:04 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 17 Oct 2002, James Yonan wrote:

> 
> Here is the latest pre-1.3.2 beta that now supports IPv6 over tun on Linux.  Please test.  I plan to release 1.3.2 shortly if there are no problems reported.

No problems, just documentation about FreeBSD. Most of this has been
filed as update against FreeBSD's 1.3.0 port.

FreeBSD currently installs tap0...tap3 and tun0...tun3 by default.

The FreeBSD GENERIC kernel has tun support compiled in, no further work
necessary. However, for tap support, the admin must execute "kldload
if_tap" once (or he can recompile and install the kernel after adding
the line "pseudo-device tap").

(kldload is called insmod on Linux, rmmod -> kldunload, lsmod ->
kldstat).

I suggest this patch (against CVS) -- it also includes two whitespace
fixes, so don't copy & paste, but pipe it into patch:

Index: INSTALL
===================================================================
RCS file: /cvsroot/openvpn/openvpn/INSTALL,v
retrieving revision 1.22
diff -u -r1.22 INSTALL
--- INSTALL~	28 Jul 2002 07:54:57 -0000	1.22
+++ INSTALL	18 Oct 2002 23:33:02 -0000
@@ -152,20 +152,35 @@
   openvpn.init script, these steps are taken care of for you.
 
 * Linux 2.2 or Solaris:
- 
+
   You should obtain
   version 1.1 of the TUN/TAP driver from
   http://vtun.sourceforge.net/tun/
   and follow the installation instructions.
 
+* FreeBSD 4.1.1+:
+
+  FreeBSD ships with the TUN/TAP driver, and the device nodes for tap0,
+  tap1, tap2, tap3, tun0, tun1, tun2 and tun3 are made by default.
+  However, only the TUN driver is linked into the GENERIC kernel.
+
+  To load the TAP driver, enter: 
+
+	kldload if_tap
+
+  See man rc(8) to find out how you can do this at boot time.
+
+  The easiest way is to install OpenVPN from the FreeBSD ports system,
+  the port includes a sample script to automatically load the tap driver
+  at boot-up time.
+
 * OpenBSD:
 
   OpenBSD ships with tun0 and tun1 installed by default.
 
 * Mac OS X:
 
-  Obtain Christoph Pfisterer's
-  tun driver at
+  Obtain Christoph Pfisterer's tun driver at
   http://chrisp.de/en/projects/tunnel.html
 
  See the man page for more information, usage examples, and

-- 
Matthias Andree

