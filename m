From: Gert Doering <gert@...1296...>
Date: Tue,  7 Oct 2025 22:28:10 +0200
Message-ID: <20251007202816.27730-1-gert@...1296...>
In-Reply-To: <gerrit.1759868804000.Ie8c6381e66d57e0c1ec31132fad8277e0133283f@...2715...>
References: <gerrit.1759868804000.Ie8c6381e66d57e0c1ec31132fad8277e0133283f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Document that tls-crypt-v2 can be used
 in connection profile
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

From: Steffan Karger <steffan@...1856...>

As reported in https://github.com/OpenVPN/openvpn/issues/795,
tls-crypt-v2 was not documented as an option that was allowed to be used
in <connection> blocks. This is a documentation mistake - it has from
it's introduction been possible to do so.

Verified in the code and tested locally.

Github: OpenVPN/openvpn#795
Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f
Signed-off-by: Steffan Karger <steffan@...1856...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1254
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1254
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/connection-profiles.rst
index 767ff3a..8710a2a 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -58,7 +58,7 @@
 ``http-proxy-option``, ``key-direction``, ``link-mtu``, ``local``,
 ``lport``, ``mssfix``, ``mtu-disc``, ``nobind``, ``port``, ``proto``,
 ``remote``, ``rport``, ``socks-proxy``, ``tls-auth``, ``tls-crypt``,
-``tun-mtu and``, ``tun-mtu-extra``.
+``tls-crypt-v2``, ``tun-mtu and``, ``tun-mtu-extra``.
 
 A defaulting mechanism exists for specifying options to apply to all
 ``<connection>`` profiles. If any of the above options (with the

