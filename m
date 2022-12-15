From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:39 +0100
Message-Id: <20221215190143.2107896-5-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/8] Improve documentation on user/password
 requirement and unicodize function
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/misc.h |  1 +
 src/openvpn/ntlm.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 2a6c0b8b3..6a883f70a 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -67,6 +67,7 @@ struct user_pass
 #else
 #define USER_PASS_LEN 128
 #endif
+    /* Note that username and password are expected to be null-terminated */
     char username[USER_PASS_LEN];
     char password[USER_PASS_LEN];
 };
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 72c13130a..20527d442 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -140,6 +140,19 @@ my_strupr(char *str)
     }
 }
 
+/**
+ * This function expects a null-terminated string in src and will
+ * copy it (including the terminating NUL byte),
+ * alternating it with 0 to dst.
+ *
+ * This basically will transform a ASCII string into valid UTF-16.
+ * Characters that are 8bit in src, will get the same treatment, resulting in
+ * invalid or wrong unicode code points.
+ *
+ * @note the function will blindly assume that dst has double
+ * the space of src.
+ * @return  the length of the number of bytes written to dst
+ */
 static int
 unicodize(char *dst, const char *src)
 {
-- 
2.37.1 (Apple Git-137.1)


