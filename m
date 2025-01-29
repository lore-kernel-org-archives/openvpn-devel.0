From: Gert Doering <gert@...1296...>
Date: Wed, 29 Jan 2025 10:41:25 +0100
Message-ID: <20250129094125.13420-1-gert@...1296...>
In-Reply-To: <gerrit.1732545464000.I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0@...2715...>
References: <gerrit.1732545464000.I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] man: extend --persist-tun section
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

The current persist-tun section has no mention of
retaining IP/routes and its potential usage in traffic
leaking protection.

Spell this out to allow the user to better understand
when this option can play an important role.

Change-Id: I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/819
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index fc76939..67f7e1f 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -312,6 +312,15 @@
   :code:`SIGUSR1` is a restart signal similar to :code:`SIGHUP`, but which
   offers finer-grained control over reset options.
 
+  On Linux, this option can be useful when OpenVPN is not executed as
+  root and the CAP_NET_ADMIN has not been granted, because the process
+  would otherwise not be allowed to bring the interface down and back up.
+
+  Alongside the above, using ``--persist-tun`` allows the tunnel interface
+  to retain all IP/route settings, thus allowing the user to implement
+  any advanced traffic leaking protection (please note that for full
+  protection, extra route/firewall rules must be in place).
+
 --redirect-gateway flags
   Automatically execute routing commands to cause all outgoing IP traffic
   to be redirected over the VPN. This is a client-side option.

