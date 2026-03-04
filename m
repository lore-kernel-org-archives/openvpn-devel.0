From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 11:50:01 +0100
Message-ID: <20260304105007.14485-1-gert@...1296...>
In-Reply-To: <gerrit.1754656456000.I73bc163d48b2d6a954cd231961826f33143fcd12@...2715...>
References: <gerrit.1754656456000.I73bc163d48b2d6a954cd231961826f33143fcd12@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] buffer: Clarify usage of char_class
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

Silence compiler warnings due to conversion from
char to unsigned char. In this case we actually
depend on this conversion.

Change-Id: I73bc163d48b2d6a954cd231961826f33143fcd12
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1142
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1142
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index dd74b38..12a8ff9 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -559,7 +559,7 @@
         {
             break;
         }
-        if (char_class(*last, CC_CRLF | CC_NULL))
+        if (char_class((unsigned char)*last, CC_CRLF | CC_NULL))
         {
             if (!buf_inc_len(buf, -1))
             {
@@ -876,6 +876,14 @@
  * Classify and mutate strings based on character types.
  */
 
+/* Note 1: This functions depends on getting an unsigned
+   char. Both the is*() functions and our own checks expect it
+   this way.
+   Note 2: For CC_PRINT we just accept everything >= 32, so
+   if we ingest non-ASCII UTF-8 we will classify it as
+   printable since it will be >= 128. Other encodings are
+   not officially supported.
+*/
 bool
 char_class(const unsigned char c, const unsigned int flags)
 {
@@ -1019,7 +1027,8 @@
 static inline bool
 char_inc_exc(const char c, const unsigned int inclusive, const unsigned int exclusive)
 {
-    return char_class(c, inclusive) && !char_class(c, exclusive);
+    return char_class((unsigned char)c, inclusive)
+           && !char_class((unsigned char)c, exclusive);
 }
 
 bool

