From: Gert Doering <gert@...1296...>
Date: Wed, 16 Jul 2025 15:54:25 +0200
Message-ID: <20250716135430.23484-1-gert@...1296...>
In-Reply-To: <gerrit.1752669697000.I22af9957b27785514d8c6d58fe4f2100d007fa5c@...2715...>
References: <gerrit.1752669697000.I22af9957b27785514d8c6d58fe4f2100d007fa5c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] README.dco: update Linux instructions
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

From: Antonio Quartulli <antonio@...2726...>

Update the README.dco file by including instructions related
to the new 'ovpn' linux kernel module.

Change-Id: I22af9957b27785514d8c6d58fe4f2100d007fa5c
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1087
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/README.dco.md b/README.dco.md
index 3f7e00c..a93dc94 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -14,26 +14,22 @@
 
 Getting started (Linux)
 -----------------------
-- Use a recent Linux kernel. Linux 5.4.0 and newer are known to work with
-  ovpn-dco.
+The new DCO linux kernel module (namely `ovpn`) has been merged upstream
+as of linux-6.16. From this kernel version onwards you directly get
+the DCO module as shipped by your kernel.
+NOTE: the new `ovpn` Linux kernel module is compatible only with OpenVPN
+2.7 and greater.
 
-Get the ovpn-dco module from one these urls and build it:
+Alternatively, if you run an older kernel or if you want to use a more
+recent DCO module than the one shipped by your kernel, you need to use
+the ovpn-backports project.
 
-* https://gitlab.com/openvpn/ovpn-dco
-* https://github.com/OpenVPN/ovpn-dco
+To learn how to use the ovpn-backports project and build your own DCO
+kernel module, please refer to the README file available at:
 
-e.g.
+  https://github.com/OpenVPN/ovpn-backports/blob/main/README.md
 
-    git clone https://github.com/OpenVPN/ovpn-dco
-    cd ovpn-dco
-    make
-    sudo make install
-
-If you want to report bugs please ensure to compile ovpn-dco with
-`make DEBUG=1` and include any debug message being printed by the
-kernel (you can view those messages with `dmesg`).
-
-Clone and build OpenVPN (or use OpenVPN 2.6+). For example:
+Then clone and build OpenVPN (or use OpenVPN 2.7+). For example:
 
     git clone https://github.com/openvpn/openvpn.git
     cd openvpn
@@ -48,8 +44,8 @@
 data channel offloading, OpenVPN will automatically disable DCO support and
 warn the user.
 
-Should OpenVPN be configured to use a feature that is not supported by ovpn-dco
-or should the ovpn-dco kernel module not be available on the system, you will
+Should OpenVPN be configured to use a feature that is not supported by ovpn
+or should the ovpn kernel module not be available on the system, you will
 see a message like
 
     Note: Kernel support for ovpn-dco missing, disabling data channel offload.
@@ -131,4 +127,3 @@
 - `--persist-tun` not tested;
 - IPv6 mapped IPv4 addresses need Linux 5.4.189+/5.10.110+/5.12+ to work;
 - some incompatible options may not properly fallback to non-dco;
-- no per client statistics. Only total statistics available on the interface.

