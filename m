From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 13 Dec 2024 17:47:04 +0100
Message-Id: <20241213164704.266204-1-frank@...2641...>
In-Reply-To: <gerrit.1733989644000.I6b4aa3d63c0b684bf95841271c04bc5d9c37793b@...2715...>
References: <gerrit.1733989644000.I6b4aa3d63c0b684bf95841271c04bc5d9c37793b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] service: add utf8to16 function that
 takes a size
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

utf8to16_size() takes the size of the to be converted string. This is
needed to convert MULTI_SZ strings, which contain inline NUL characters,
but can be useful in other cases as well.

Change-Id: I6b4aa3d63c0b684bf95841271c04bc5d9c37793b
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/836
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 96bf800..61a7296 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -247,17 +247,16 @@
     return error;
 }
 
-/* Convert a utf8 string to utf16. Caller should free the result */
 wchar_t *
-utf8to16(const char *utf8)
+utf8to16_size(const char *utf8, int size)
 {
-    int n = MultiByteToWideChar(CP_UTF8, 0, utf8, -1, NULL, 0);
+    int n = MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);
     wchar_t *utf16 = malloc(n * sizeof(wchar_t));
     if (!utf16)
     {
         return NULL;
     }
-    MultiByteToWideChar(CP_UTF8, 0, utf8, -1, utf16, n);
+    MultiByteToWideChar(CP_UTF8, 0, utf8, size, utf16, n);
     return utf16;
 }
 
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 6d0827d..dbb2b5d 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -89,8 +89,40 @@
 
 DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMsg, ...);
 
-/* Convert a utf8 string to utf16. Caller should free the result */
-wchar_t *utf8to16(const char *utf8);
+/**
+ * Convert a UTF-8 string to UTF-16
+ *
+ * The size parameter can be used to convert strings which contain inline NUL
+ * characters, like MULTI_SZ strings used as values in the registry do,
+ * or (sub)strings that are not zero terminated. If size is -1 the length
+ * of the string is determined automatically by the WIN32 API. Make sure
+ * you pass a terminated string or else bad things will happen. Note that
+ * the size you pass should always include the terminating zero as well.
+ *
+ * If the returned string is not NULL it must be freed by the caller.
+ *
+ * @param utf8  const string to be converted
+ * @param size  the size of the string
+ *
+ * @return wchar_t* heap allocated result string
+ */
+wchar_t *utf8to16_size(const char *utf8, int size);
+
+/**
+ * Convert a zero terminated UTF-8 string to UTF-16
+ *
+ * This is just a wrapper function that always passes -1 as string size
+ * to \ref utf8to16_size.
+ *
+ * @param utf8  const string to be converted
+ *
+ * @return wchar_t* heap allocated result string
+ */
+inline wchar_t *
+utf8to16(const char *utf8)
+{
+    return utf8to16_size(utf8, -1);
+}
 
 /* return windows system directory as a pointer to a static string */
 const wchar_t *get_win_sys_path(void);

