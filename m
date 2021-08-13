From: Arne Schwabe <arne@...1227...>
Date: Fri, 13 Aug 2021 13:55:42 +0200
Message-Id: <20210813115542.2794-1-arne@...1227...>
In-Reply-To: <20210716121848.67888-1-arne@...1227...>
References: <20210716121848.67888-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Introduce webauth auth pending method
 and deprecate openurl
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

The experience with openurl/OPEN_URL has shown that just sending
a URL to a client is not enough and we often need different
behaviour of the client depending on circumstances. Replace
OPEN_URL with a more flexible WEB_AUTH pending auth method.

Patch v2: use WEB_AUTH instead WEBAUTH
Patch v3: incooperate other comments from Selva

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/management-notes.txt    | 45 +++++++++++++++++++++++++------------
 include/openvpn-plugin.h.in |  2 +-
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index c20344298..1cafb8a8e 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -645,11 +645,11 @@ Before issuing a client-pending-auth to a client instead of a
 client-auth/client-deny, the server should check the IV_SSO
 environment variable for whether the method is supported. Currently
 defined methods are crtext for challenge/response using text
-(e.g., TOTP), openurl and proxy_url for opening a URL in the client to
-continue authentication. A client supporting the first two methods would
-set
+(e.g., TOTP), openurl (deprecated) and webauth for opening a URL in
+the client to continue authentication. A client supporting webauth and
+crtext would set
 
-    setenv IV_SSO openurl,crtext
+    setenv IV_SSO webauth,crtext
 
 The variable name IV_SSO is historic as AUTH_PENDING was first used
 to signal single sign on support. To keep compatibility with existing
@@ -668,33 +668,50 @@ notification as
 where {EXTRA} is formatted as received from the server.
 Currently defined formats for {EXTRA} are detailed below.
 
-openurl
-========
+webauth and openurl
+===================
 For a web based extra authentication (like for
 SSO/SAML) {EXTRA} should be
 
     OPEN_URL:url
 
-and client should ask the user to open the URL to continue.
+or
+
+    WEB_AUTH:flags:url
+
+The OPEN_URL method is deprecated as it does not allow to send flags which
+proved to be needed to signal certain behaviour to the client.
+
+The client should ask the user to open the URL to continue.
 
 The space in a control message is limited, so this url should be kept
 short to avoid issues. If a longer url is required a URL that redirects
-to the longer URL should be sent instead.
+to the longer URL should be sent instead. The total length is limited to 1024
+bytes which includes the INFO_PRE:WEB_AUTH:flags.
+
+flags is a list of flags which are separated by commas. Currently defined
+flags are:
+
+- proxy     (see next pargraph)
+- hidden    start the webview in hidden mode (see openvpn3 webauth documentation)
+- external  Do not use an internal webview but use an external browser. Some
+            authentication providers refuse to work in an internal webview.
+
 
 A complete documentation how URLs should be handled on the client is available
 in the openvpn3 repository:
 
 https://github.com/OpenVPN/openvpn3/blob/master/doc/webauth.md
 
-proxy_url
-========
-This is a variant of openurl that allows opening a url via an
+webauth with proxy
+==================
+This is a variant of webauth that allows opening a url via an
 HTTP proxy. It could be used to avoid issues with OpenVPN connection's
 persist-tun that may cause the web server to be unreachable.
-The client should announce proxy_url in its IV_SSO and parse the
-PROXY_URL message. The format of {EXTRA} in this case is
+The client should announce proxy in its IV_SSO and parse the
+proxy flag in the WEB_AUTH message. The format of {EXTRA} in this case is
 
-    PROXY_URL:<proxy>:<proxy_port>:<proxyuser_base64>:<proxy_password_base64>:url
+    WEB_AUTH:proxy=<proxy>;<proxy_port>;<proxy_user_base64>;<proxy_password_base64>,flags:url
 
 The proxy should be a literal IPv4 address or IPv6 address enclosed in [] to avoid
 ambiguity in parsing. A literal IP address is preferred as DNS might not be
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index abbfd9c2a..28b845af1 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -573,7 +573,7 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PLUGIN_FUNC(openvpn_plugin_op
  * auth_pending_file is
  * line 1: timeout in seconds
  * line 2: Pending auth method the client needs to support (e.g. openurl)
- * line 3: EXTRA (e.g. OPEN_URL:http://www.example.com)
+ * line 3: EXTRA (e.g. WEBAUTH::http://www.example.com)
  *
  * In addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and
  * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tries to
-- 
2.32.0


