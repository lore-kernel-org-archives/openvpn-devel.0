From: Gert Doering <gert@...1296...>
Date: Fri, 12 Dec 2025 11:09:14 +0100
Message-ID: <20251212100920.7671-1-gert@...1296...>
In-Reply-To: <gerrit.1765467748000.I4f95edd7ce2098180aa620a231727217f333a12d@...2715...>
References: <gerrit.1765467748000.I4f95edd7ce2098180aa620a231727217f333a12d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] buffer: Change limits for array_mult_safe
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

- Lower the limit to 1GB on 32bit systems.
  The limit of 4GB-1 makes no sense on systems that usually
  don't allow a single process to allocate anything near to
  this limit.
- Increate the limit from 4GB-1 to 4GB on other systems. It
  makes no difference in protection but makes it much easier
  to use the limit in other contexts, e.g. if dividing it.

Change-Id: I4f95edd7ce2098180aa620a231727217f333a12d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1436
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1436
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 293622f..40baca6 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -39,7 +39,7 @@
 size_t
 array_mult_safe(const size_t m1, const size_t m2, const size_t extra)
 {
-    const size_t limit = 0xFFFFFFFF;
+    const size_t limit = ALLOC_SIZE_MAX;
     unsigned long long res =
         (unsigned long long)m1 * (unsigned long long)m2 + (unsigned long long)extra;
     if (unlikely(m1 > limit) || unlikely(m2 > limit) || unlikely(extra > limit)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index ab2a29d..1dbe0b2 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1044,6 +1044,18 @@
  * Allocate memory to hold a structure
  */
 
+/* When allocating arrays make sure we do not use a excessive amount
+ * of memory.
+ */
+#if UINTPTR_MAX <= UINT32_MAX
+/* 1 GB on 32bit systems, they usually can only allocate 2 GB for the
+ * whole process.
+ */
+#define ALLOC_SIZE_MAX (1u << 30)
+#else
+#define ALLOC_SIZE_MAX ((size_t)1 << 32) /* 4 GB */
+#endif
+
 #define ALLOC_OBJ(dptr, type)                                       \
     {                                                               \
         check_malloc_return((dptr) = (type *)malloc(sizeof(type))); \

