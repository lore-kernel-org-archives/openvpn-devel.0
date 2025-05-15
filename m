From: Gert Doering <gert@...1296...>
Date: Thu, 15 May 2025 17:00:31 +0200
Message-ID: <20250515150038.30097-1-gert@...1296...>
In-Reply-To: <gerrit.1747256571000.I7fc033a7ffee73045316763356a95d75ef23f5ad@...2715...>
References: <gerrit.1747256571000.I7fc033a7ffee73045316763356a95d75ef23f5ad@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Implement ovpn version detection
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

From: Ralf Lici <ralf@...2726...>

Add detection of the ovpn kernel module type: if a backported
(out-of-tree) version is loaded, the MODULE_VERSION string is read from
sysfs; otherwise, for the in-tree module, the function reports the
kernel release and version.

Change-Id: I7fc033a7ffee73045316763356a95d75ef23f5ad
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1022
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index c950e3d..a5f9e06 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1117,10 +1117,77 @@
     return true;
 }
 
+/**
+ * There's no version indicator in the ovpn in-tree module, so we return a
+ * string containing info about the kernel version and release.
+ */
+static const char *
+dco_version_string_in_tree(struct gc_arena *gc)
+{
+    struct buffer buf = alloc_buf_gc(256, gc);
+    struct utsname system;
+
+    if (uname(&system))
+    {
+        return "ERR";
+    }
+
+    buf_puts(&buf, system.release);
+    buf_puts(&buf, " ");
+    buf_puts(&buf, system.version);
+    return BSTR(&buf);
+}
+
+/**
+ * When the module is loaded, the backports version of ovpn has a version file
+ * in sysfs. Read it and return the string.
+ *
+ * The caller is responsible for closing the file pointer.
+ */
+static const char *
+dco_version_string_backports(FILE *fp, struct gc_arena *gc)
+{
+    char *str = gc_malloc(PATH_MAX, false, gc);
+
+    if (!fgets(str, PATH_MAX, fp))
+    {
+        return "ERR";
+    }
+
+    /* remove potential newline at the end of the string */
+    char *nl = strchr(str, '\n');
+    if (nl)
+    {
+        *nl = '\0';
+    }
+
+    return str;
+}
+
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    return "Unknown";
+    const char *version;
+    struct stat sb;
+    FILE *fp;
+
+    if (stat("/sys/module/ovpn", &sb) != 0 || !S_ISDIR(sb.st_mode))
+    {
+        return "N/A";
+    }
+
+    /* now that we know for sure that the module is loaded, if there's no
+     * version file it means we're dealing with the in-tree version, otherwise
+     * it's backports */
+    fp = fopen("/sys/module/ovpn/version", "r");
+    if (!fp)
+    {
+        return dco_version_string_in_tree(gc);
+    }
+    version = dco_version_string_backports(fp, gc);
+
+    fclose(fp);
+    return version;
 }
 
 void

