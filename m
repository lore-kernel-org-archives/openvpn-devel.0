From: David Sommerseth <davids@...515...>
Date: Thu, 22 Sep 2016 12:04:37 +0200
Message-Id: <1474538677-23301-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Have the same username/password length
	regardless of PKCS#11 enablement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

If running an OpenVPN client with --enable-pkcs11 and a server without
and having a username and/or password with more than 128 characters,
the authentication will fail as the server truncates the password
to 128 bytes.

This makes things easier and more predictable.  Username/passwords
can be up to 4096 bytes, regardless of the --enable-pkcs11 state.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/misc.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index b694096..31ea10e 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -195,17 +195,14 @@ const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
  * Get and store a username/password
  */
 
+/* max length of username/password */
+#define USER_PASS_LEN 4096
+
 struct user_pass
 {
   bool defined;
   bool nocache;
 
-/* max length of username/password */
-# ifdef ENABLE_PKCS11
-#   define USER_PASS_LEN 4096
-# else
-#   define USER_PASS_LEN 128
-# endif
   char username[USER_PASS_LEN];
   char password[USER_PASS_LEN];
 };
-- 
1.8.3.1


