From: Gert Doering <gert@...1296...>
Date: Mon,  2 Jun 2025 17:38:54 +0200
Message-ID: <20250602153900.29646-1-gert@...1296...>
In-Reply-To: <gerrit.1748860734000.I15c730c9eb3f1338019577e7c665c0ca5b1edcd4@...2715...>
References: <gerrit.1748860734000.I15c730c9eb3f1338019577e7c665c0ca5b1edcd4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Delete old sample-windows file and
 obsolete Windows sample handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

This file is apparently over 20 years old and
was never updated besides fixing some obvious
syntax errors with new versions.

So let's just get rid of it. AFAICT the Windows
installer does not use it. Only the
{server,client}.ovpn. And even there, it just uses
the files directly from the build directory and
does not depend on us renaming them (which is
obvious since we do not use the Makefile at all
in the Windows build, only CMake).

Github: Closes OpenVPN/openvpn#758
Change-Id: I15c730c9eb3f1338019577e7c665c0ca5b1edcd4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1036
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 9443cf3..4ed78a6e 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -18,20 +18,5 @@
 EXTRA_DIST = \
 	sample-plugins \
 	sample-config-files \
-	sample-windows \
 	sample-keys \
 	sample-scripts
-
-if WIN32
-sample_DATA = \
-	client.ovpn \
-	server.ovpn \
-	sample-windows/sample.ovpn
-
-client.ovpn: sample-config-files/client.conf
-	-rm -f client.ovpn
-	cp "$(srcdir)/sample-config-files/client.conf" client.ovpn
-server.ovpn: sample-config-files/server.conf
-	-rm -f server.ovpn
-	cp "$(srcdir)/sample-config-files/server.conf" server.ovpn
-endif
diff --git a/sample/sample-windows/sample.ovpn b/sample/sample-windows/sample.ovpn
deleted file mode 100755
index be24faa..0000000
--- a/sample/sample-windows/sample.ovpn
+++ /dev/null
@@ -1,102 +0,0 @@
-# Edit this file, and save to a .ovpn extension
-# so that OpenVPN will activate it when run
-# as a service.
-
-# Change 'myremote' to be your remote host,
-# or comment out to enter a listening
-# server mode.
-remote myremote
-
-# Uncomment this line to use a different
-# port number than the default of 1194.
-; port 1194
-
-# Choose one of three protocols supported by
-# OpenVPN.  If left commented out, defaults
-# to udp.
-; proto [tcp-server | tcp-client | udp]
-
-# You must specify one of two possible network
-# protocols, 'dev tap' or 'dev tun' to be used
-# on both sides of the connection.  'tap' creates
-# a VPN using the ethernet protocol while 'tun'
-# uses the IP protocol.  You must use 'tap'
-# if you are ethernet bridging or want to route
-# broadcasts.  'tun' is somewhat more efficient
-# but requires configuration of client software
-# to not depend on broadcasts.  Some platforms
-# such as Solaris, OpenBSD, and Mac OS X only
-# support 'tun' interfaces, so if you are
-# connecting to such a platform, you must also
-# use a 'tun' interface on the Windows side.
-
-# Enable 'dev tap' or 'dev tun' but not both!
-dev tap
-
-# This is a 'dev tap' ifconfig that creates
-# a virtual ethernet subnet.
-# 10.3.0.1 is the local VPN IP address
-# and 255.255.255.0 is the VPN subnet.
-# Only define this option for 'dev tap'.
-ifconfig 10.3.0.1 255.255.255.0
-
-# This is a 'dev tun' ifconfig that creates
-# a point-to-point IP link.
-# 10.3.0.1 is the local VPN IP address and
-# 10.3.0.2 is the remote VPN IP address. 
-# Only define this option for 'dev tun'.
-# Make sure to include the "tun-mtu" option
-# on the remote machine, but swap the order
-# of the ifconfig addresses.
-;tun-mtu 1500
-;ifconfig 10.3.0.1 10.3.0.2
-
-# If you have fragmentation issues or misconfigured
-# routers in the path which block Path MTU discovery,
-# lower the TCP MSS and internally fragment non-TCP
-# protocols.
-;fragment 1300
-;mssfix
-
-# If you have set up more than one TAP-Win32 adapter
-# on your system, you must refer to it by name.
-;dev-node my-tap
-
-# You can generate a static OpenVPN key
-# by selecting the Generate Key option
-# in the start menu.
-#
-# You can also generate key.txt manually
-# with the following command:
-#   openvpn --genkey secret key.txt
-#
-# key must match on both ends of the connection,
-# so you should generate it on one machine and
-# copy it to the other over a secure medium.
-# Place key.txt in the same directory as this
-# config file.
-secret key.txt
-
-# Uncomment this section for a more reliable
-# detection when a system loses its connection.
-# For example, dial-ups or laptops that travel
-# to other locations.
-#
-# If this section is enabled and "myremote"
-# above is a dynamic DNS name (i.e. dyndns.org),
-# OpenVPN will dynamically "follow" the IP
-# address of "myremote" if it changes.
-; ping-restart 60
-; ping-timer-rem
-; persist-tun
-; resolv-retry 86400
-
-# keep-alive ping
-ping 10
-
-# enable LZO compression
-comp-lzo
-
-# moderate verbosity
-verb 4
-mute 10

