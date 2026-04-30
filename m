From: Gert Doering <gert@...1296...>
Date: Thu, 30 Apr 2026 18:32:43 +0200
Message-ID: <20260430163249.13638-1-gert@...1296...>
In-Reply-To: <gerrit.1777558352000.I53b3f4c60897a1f4dd5efeb6575d525ffb082402@...2715...>
References: <gerrit.1777558352000.I53b3f4c60897a1f4dd5efeb6575d525ffb082402@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] DNS server documentation update
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

From: Selva Nair <selva.nair@...277...>

Change-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1646
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1646
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 1664eed..3ad9104 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -216,7 +216,8 @@
   DNS server options it must be between 0 and 127. The server id is used
   to group options and also for ordering the list of configured DNS servers;
   lower numbers come first. DNS servers being pushed to a client replace
-  already configured DNS servers with the same server id.
+  already configured DNS servers with the same server id. Only the group of
+  options corresponding to the lowest server id is applied.
 
   The ``address`` option configures the IPv4 and / or IPv6 address(es) of
   the DNS server. Up to eight addresses can be specified per DNS server.
@@ -249,6 +250,19 @@
   so that ``--dns`` overrides ``--dhcp-option``. Thus, ``--dns`` can be used today
   to migrate from ``--dhcp-option``.
 
+  Windows only:
+
+  #. If tap-windows6 is in use, dns servers are set by DHCP by default.
+     In this case only ``--dns search-domains`` and ``--dns server n address ..``
+     with the lowest value of ``n`` are interpreted. All other ``--dns`` options
+     are ignored. Use of the dco driver is the recommended way to make use of these
+     new features.
+
+  #. If ``--dns server n resolve-domains`` is in use, the DNS server addresses
+     corresponding to ``n`` are set on the interface only if ``search-domains`` is
+     also specified.  Otherwise these DNS addresses are used only for NRPT rules for
+     split-DNS.
+
 --explicit-exit-notify n
   In UDP client mode or point-to-point mode, send server/peer an exit
   notification if tunnel is restarted or OpenVPN process is exited. In

