From: Arne Schwabe <arne@...1227...>
Date: Wed,  4 May 2022 13:18:02 +0200
Message-Id: <20220504111802.1050648-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove workaround for Android 4.4
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

Android 4.4 is now 9 years old and the main user of this API (OpenVPN
for Android) does not support this OS anymore. This workaround
is now safe to remove.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c | 6 +-----
 src/openvpn/manage.h | 3 +--
 src/openvpn/tun.c    | 9 +--------
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1f408f0b..6e27d14e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2140,10 +2140,6 @@ managment_android_persisttun_action(struct management *man)
     {
         return ANDROID_KEEP_OLD_TUN;
     }
-    else if (!strcmp("OPEN_AFTER_CLOSE", up.password))
-    {
-        return ANDROID_OPEN_AFTER_CLOSE;
-    }
     else if (!strcmp("OPEN_BEFORE_CLOSE", up.password))
     {
         return ANDROID_OPEN_BEFORE_CLOSE;
@@ -2154,7 +2150,7 @@ managment_android_persisttun_action(struct management *man)
     }
 
     ASSERT(0);
-    return ANDROID_OPEN_AFTER_CLOSE;
+    return ANDROID_OPEN_BEFORE_CLOSE;
 }
 
 
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 9621f479..2e497d67 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -383,8 +383,7 @@ bool management_query_user_pass(struct management *man,
 bool management_android_control(struct management *man, const char *command, const char *msg);
 
 #define ANDROID_KEEP_OLD_TUN 1
-#define ANDROID_OPEN_AFTER_CLOSE 2
-#define ANDROID_OPEN_BEFORE_CLOSE 3
+#define ANDROID_OPEN_BEFORE_CLOSE 2
 int managment_android_persisttun_action(struct management *man);
 
 #endif
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 12bdd200..93259ec5 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1879,13 +1879,6 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     int android_method = managment_android_persisttun_action(management);
 
-    /* Android 4.4 workaround */
-    if (oldtunfd >=0 && android_method == ANDROID_OPEN_AFTER_CLOSE)
-    {
-        close(oldtunfd);
-        management_sleep(2);
-    }
-
     if (oldtunfd >=0  && android_method == ANDROID_KEEP_OLD_TUN)
     {
         /* keep the old fd */
@@ -1900,7 +1893,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         management->connection.lastfdreceived = -1;
     }
 
-    if (oldtunfd>=0 && android_method == ANDROID_OPEN_BEFORE_CLOSE)
+    if (oldtunfd >= 0 && android_method == ANDROID_OPEN_BEFORE_CLOSE)
     {
         close(oldtunfd);
     }
-- 
2.32.0 (Apple Git-132)


