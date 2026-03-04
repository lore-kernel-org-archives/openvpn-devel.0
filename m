From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 15:40:54 +0100
Message-ID: <20260304144059.2518-1-gert@...1296...>
In-Reply-To: <gerrit.1769512571000.Ida8e587a095bdfb821ee0a4783633f026d310476@...2715...>
References: <gerrit.1769512571000.Ida8e587a095bdfb821ee0a4783633f026d310476@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] argv: Fix one type to avoid sign-compare
 warning
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

len is already int, no need to throw another
type into the mix.

Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1494
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1494
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index b5d9603..6a5d92e 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -263,11 +263,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  *  Prepares argv format string for further processing
  *
@@ -389,7 +384,7 @@
      *  Do the actual vsnprintf() operation, which expands the format
      *  string with the provided arguments.
      */
-    size_t size = len + 1;
+    int size = len + 1;
     char *buf = gc_malloc(size, false, &argres->gc);
     len = vsnprintf(buf, size, f, arglist);
     if (len < 0 || len >= size)
@@ -423,10 +418,6 @@
     return res;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  printf() variant which populates a struct argv.  It processes the
  *  format string with the provided arguments.  For each space separator found

