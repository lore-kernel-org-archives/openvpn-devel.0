From: Gert Doering <gert@...1296...>
Date: Wed, 26 Nov 2025 11:34:21 +0100
Message-ID: <20251126103427.4085-1-gert@...1296...>
In-Reply-To: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
References: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] iservice: fix calculation of converted
 domains size
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

From: Heiko Hund <heiko@...2662...>

To keep track of how much of the buffer is already used, the difference
of the current position and the start of the buffer needs to be
multiplied with the size of a character / glyph to bet the byte count,
with which calculations are done further down below.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: I16f9426e57f4802ba038ab51f5b70161464b9428
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1390
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1390
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 07ca7c9..9c533c1 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2181,8 +2181,11 @@
                     *comma = '\0';
                 }
 
-                /* Ignore itf domains which match a pushed search domain */
                 size_t domain_len = wcslen(pos);
+                size_t domain_size = domain_len * one_glyph;
+                size_t converted_size = (pos - domains) * one_glyph;
+
+                /* Ignore itf domains which match a pushed search domain */
                 if (ListContainsDomain(search_domains, pos, domain_len))
                 {
                     if (comma)
@@ -2199,11 +2202,14 @@
                     }
                 }
 
-                /* Check for enough space to convert this domain */
-                domain_len += 1; /* leading dot */
-                size_t converted_size = pos - domains;
-                size_t domain_size = domain_len * one_glyph;
+                /* Add space for the leading dot */
+                domain_len += 1;
+                domain_size += one_glyph;
+
+                /* Space for the terminating zeros */
                 size_t extra_size = 2 * one_glyph;
+
+                /* Check for enough space to convert this domain */
                 if (converted_size + domain_size + extra_size > buf_size)
                 {
                     /* Domain doesn't fit, bad luck if it's the first one */

