From: Gert Doering <gert@...1296...>
Date: Fri, 19 Jan 2024 13:03:41 +0100
Message-ID: <20240119120341.22933-1-gert@...1296...>
In-Reply-To: <gerrit.1704798536000.I64f094eeb0ca8c3953a94d742adf468faf27dab3@...2715...>
References: <gerrit.1704798536000.I64f094eeb0ca8c3953a94d742adf468faf27dab3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] buf_string_match_head_str: Fix Coverity
 issue "Unsigned compared against 0"
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

As Coverity says:
An unsigned value can never be negative, so this test will always
evaluate the same way.

Was changed from int to size_t in commit
7fc608da4ec388c9209bd009cd5053ac0ff7df38 which triggered warning,
but the check did not make sense before, either.

Change-Id: I64f094eeb0ca8c3953a94d742adf468faf27dab3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/491
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 0b94a52..2ad3461 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -822,7 +822,7 @@
 buf_string_match_head_str(const struct buffer *src, const char *match)
 {
     const size_t size = strlen(match);
-    if (size < 0 || size > src->len)
+    if (size > src->len)
     {
         return false;
     }

