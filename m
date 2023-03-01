From: Kristof Provost <kprovost@...2661...>
Date: Wed,  1 Mar 2023 10:18:51 +0100
Message-Id: <20230301091851.82243-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] options.c: enforce a minimal fragment
 size
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Very low values for 'fragment' can result in a division by zero in
optimal_fragment_size() (because it rounds max_frag_size down with
FRAG_SIZE_ROUND_MASK).

Enforce a minimal fragment size of 68 bytes, based on RFC 791 ("Every
internet module must be able to forward a datagram of 68 octets without
further fragmentation.")

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9105449c..9f79da09 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6549,6 +6549,12 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
         options->ce.fragment = positive_atoi(p[1]);
 
+        if (options->ce.fragment < 68)
+        {
+            msg(msglevel, "fragment needs to be at least 68");
+            goto err;
+        }
+
         if (p[2] && streq(p[2], "mtu"))
         {
             options->ce.fragment_encap = true;
-- 
2.39.2


