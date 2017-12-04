From: Antonio Quartulli <a@...2181...>
Date: Mon,  4 Dec 2017 12:49:07 +0800
Message-Id: <20171204044907.32261-1-a@...2181...>
In-Reply-To: <20171204042658.23426-1-a@...2181...>
References: <20171204042658.23426-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v4] reload HTTP proxy credentials when
 moving to the next connection profile
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
Cc: Antonio Quartulli <a@...2181...>

The HTTP proxy credentials are stored in a static variable that is
possibly initialized before each connection attempt.

However, the variable is never "released" therefore get_user_pass()
refuses to overwrite its content and leaves it as it is.
Consequently, if the user config contains multiple connection profiles
with different http-proxy, each having its own credentials, only the
first user/pass couple is loaded and the others are all ignored.
This leads to connection failures because the proper credentials are
not associated with the right proxy server.

The root of the misbehaviour seems to be located in the fact that,
despite the argument force passed to get_user_pass_http() being true,
no action is taken to release the static object containing the
credentials.

Fix the misbehaviour by releasing the http-proxy credential object
when the reload is "forced".

Trac: #836
Signed-off-by: Antonio Quartulli <a@...2181...>
---

v4:
- move clear_user_pass_http() above its invocation to prevent compile error

v3:
- call clear_user_pass_http() directly to clear user/pass object

v2:
- rebased on current master


 src/openvpn/proxy.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index fdc73b4a..de0188a9 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -252,10 +252,25 @@ username_password_as_base64(const struct http_proxy_info *p,
     return (const char *)make_base64_string((const uint8_t *)BSTR(&out), gc);
 }
 
+static void
+clear_user_pass_http(void)
+{
+    purge_user_pass(&static_proxy_user_pass, true);
+}
+
 static void
 get_user_pass_http(struct http_proxy_info *p, const bool force)
 {
-    if (!static_proxy_user_pass.defined || force)
+    /*
+     * in case of forced (re)load, make sure the static storage is set as
+     * undefined, otherwise get_user_pass() won't try to load any credential
+     */
+    if (force)
+    {
+        clear_user_pass_http();
+    }
+
+    if (!static_proxy_user_pass.defined)
     {
         unsigned int flags = GET_USER_PASS_MANAGEMENT;
         if (p->queried_creds)
@@ -274,11 +289,6 @@ get_user_pass_http(struct http_proxy_info *p, const bool force)
         p->up = static_proxy_user_pass;
     }
 }
-static void
-clear_user_pass_http(void)
-{
-    purge_user_pass(&static_proxy_user_pass, true);
-}
 
 #if 0
 /* function only used in #if 0 debug statement */
-- 
2.15.1


