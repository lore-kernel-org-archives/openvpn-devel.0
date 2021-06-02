From: selva.nair@...277...
Date: Tue,  1 Jun 2021 23:42:52 -0400
Message-Id: <20210602034253.19984-2-selva.nair@...277...>
In-Reply-To: <20210602034253.19984-1-selva.nair@...277...>
References: <20210602034253.19984-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Improve documentation of AUTH_PENDING
 related directives
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

From: Selva Nair <selva.nair@...277...>

Also fix some typos.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/man-sections/server-options.rst |   4 ++
 doc/management-notes.txt            | 101 +++++++++++++++++-----------
 2 files changed, 67 insertions(+), 38 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 036323b9..047f2270 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -460,6 +460,10 @@ fast hardware. SSL/TLS authentication must be used in this mode.
         The UI version of a UI if one is running, for example
         :code:`de.blinkt.openvpn 0.5.47` for the Android app.
 
+  :code:`IV_SSO=[crtext,][openurl,][proxy_url]`
+        Additional authentication methods supported by the client.
+        This may be set by the client UI/GUI using ``--setenv``
+
   When ``--push-peer-info`` is enabled the additional information consists
   of the following data:
 
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 3aff6eb6..9f064764 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -199,7 +199,7 @@ Command examples:
 COMMAND -- kill
 ---------------
 
-In server mode, kill a particlar client instance.
+In server mode, kill a particular client instance.
 
 Command examples:
 
@@ -407,6 +407,7 @@ RECONNECTING  -- A restart has occurred.
 EXITING       -- A graceful exit is in progress.
 RESOLVE       -- (Client only) DNS lookup
 TCP_CONNECT   -- (Client only) Connecting to TCP server
+AUTH_PENDING  -- (Client only) Authentication pending
 
 Command examples:
 
@@ -437,6 +438,11 @@ Fields (e)-(h) are shown for CONNECTED state,
 (e) is available starting from OpenVPN 2.1
 (f)-(i) are available starting from OpenVPN 2.4
 
+For AUTH_PENDING, if (c) is present, it would read
+as "timeout number" where number is the number of seconds
+before authentication will timeout. It is printed as an
+unsigned integer (%u).
+
 Real-time state notifications will have a ">STATE:" prefix
 prepended to them.
 
@@ -608,7 +614,7 @@ COMMAND -- client-pending-auth  (OpenVPN 2.5 or higher)
 Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE message
 to signal a pending authenticating to the client. A pending auth means
 that the connecting requires extra authentication like a one time
-password or doing a single sign one via web.
+password or doing a single sign on via web.
 
     client-pending-auth {CID} {EXTRA} {TIMEOUT}
 
@@ -624,22 +630,22 @@ the timeout proposed by the server, even if the timeout is shorter.
 If the client does not receive a packet from the server for hand-window the
 connection times out regardless of the timeout. This ensures that the connection
 still times out relatively quickly in case of network problems. The client will
-continously send PULL_REQUEST messages to the server until the timeout is reached.
+continuously send PULL_REQUEST messages to the server until the timeout is reached.
 This message also triggers an ACK message from the server that resets the
 hand-window based timeout.
 
 Both client and server limit the maximum timeout to the smaller value of half the
 --tls-reneg minimum time and --hand-window time (defaults to 60s).
 
-For the format of EXTRA see below. For the OpenVPN server this is a stateless
+For the format of {EXTRA} see below. For OpenVPN server this is a stateless
 operation and needs to be followed by a client-deny/client-auth[-nt] command
 (that is the result of the out of band authentication).
 
 Before issuing a client-pending-auth to a client instead of a
 client-auth/client-deny, the server should check the IV_SSO
-environment variable if the method is support. The currently
-defined method are crtext for challenge/response using text
-(e.g. TOTP), openurl and proxy_url for opening an URL in the client to
+environment variable for whether the method is supported. Currently
+defined methods are crtext for challenge/response using text
+(e.g., TOTP), openurl and proxy_url for opening a URL in the client to
 continue authentication. A client supporting the first two methods would
 set
 
@@ -649,17 +655,30 @@ The variable name IV_SSO is historic as AUTH_PENDING was first used
 to signal single sign on support. To keep compatibility with existing
 implementations the name IV_SSO is kept in lieu of a better name.
 
+The management interface of the client receives notification of
+pending auth via
+
+>STATE:datetime,AUTH_PENDING,[timeout number]
+
+If {EXTRA} is present the client is informed using INFOMSG
+notification as
+
+>INFOMSG:{EXTRA}
+
+where {EXTRA} is formatted as received from the server.
+Currently defined formats for {EXTRA} are detailed below.
+
 openurl
 ========
 For a web based extra authentication (like for
-SSO/SAML) EXTRA should be
+SSO/SAML) {EXTRA} should be
 
     OPEN_URL:url
 
-and client should ask to the user to open the URL to continue.
+and client should ask the user to open the URL to continue.
 
 The space in a control message is limited, so this url should be kept
-short to avoid issues. If a loger url is required a URL that redirects
+short to avoid issues. If a longer url is required a URL that redirects
 to the longer URL should be sent instead.
 
 A complete documentation how URLs should be handled on the client is available
@@ -667,17 +686,18 @@ in the openvpn3 repository:
 
 https://github.com/OpenVPN/openvpn3/blob/master/doc/webauth.md
 
-url_proxy
+proxy_url
 ========
-To avoid issues with OpenVPN connection persist-tun and not able
-to reach the web server, a variant of openurl via a HTTPS
-Proxy exists. The client should announce url_proxy in its IV_SSO
-and parse the PROXY_URL message. The format is
+This is a variant of openurl that allows opening a url via an
+HTTP proxy. It could be used to avoid issues with OpenVPN connection's
+persist-tun that may cause the web server to be unreachable.
+The client should announce proxy_url in its IV_SSO and parse the
+PROXY_URL message. The format of {EXTRA} in this case is
 
     PROXY_URL:<proxy>:<proxy_port>:<proxyuser_base64>:<proxy_password_base64>:url
 
-The proxy should be a literal IPv4 address or IPv6 address in [] to avoid
-ambiguity in parsing. A literal IP address is preferred as DNS might not be 
+The proxy should be a literal IPv4 address or IPv6 address enclosed in [] to avoid
+ambiguity in parsing. A literal IP address is preferred as DNS might not be
 available when the client needs to open the url. The IP address will usually
 be the address that client uses to connect to the VPN server. For dual-homed
 VPN servers, the server should respond with the same address that the client
@@ -685,19 +705,18 @@ connects to.
 
 This address is also usually excluded from being redirected over the VPN
 by a host route. If the platform (like Android) uses another way of protecting
-the VPN connection routing loops the client needs to also exclude the
+the VPN connection from routing loops, the client needs to also exclude the
 connection to the proxy in the same manner.
 
 Should another IP be used, then the VPN configuration should include a route
-statement to exclude that route from being routed over the VPN.
+statement to exclude that address from being routed over the VPN.
 
 crtext
 =======
-
-The format of EXTRA is similar to the already used two step authentication
+The format of {EXTRA} is similar to the already used two step authentication
 described in Challenge/Response Protocol section of this document. Since
-most of the fields are not necessary or can be infered only the <flags>
-and <challgenge_text> fields are used:
+most of the fields are not necessary or can be inferred, only the <flags>
+and <challenge_text> fields are used:
 
     CR_TEXT:<flags>:<challenge_text>
 
@@ -707,7 +726,8 @@ and <challgenge_text> fields are used:
 
 <challenge_text>: the challenge text to be shown to the user.
 
-
+The client should return the response to the crtext challenge
+using the cr-response command.
 
 COMMAND -- client-deny  (OpenVPN 2.1 or higher)
 -----------------------------------------------
@@ -925,17 +945,18 @@ To accept connecting to the host and port directly, use this command:
 
 COMMAND -- cr-response (OpenVPN 2.5 or higher)
 -------------------------------------------------
-Provides support for sending responses a challenge/response
-query via INFOMSG,CR_TEXT. The response should be base64 encoded:
+Provides support for sending responses to a challenge/response
+query via INFOMSG,CR_TEXT (client-only). The response should
+be base64 encoded:
 
   cr-response SGFsbG8gV2VsdCE=
 
-The document is intended to be used after the client received a
-CR_TEXT challenge (see send-pending-auth section). The answer is
-the answer to the challenge and depends on the challenge itself
-for a TOTP challenge this would the number encoded as base64 or
-just a string for a challenge like "what day is it today?".
-
+This command is intended to be used after the client receives a
+CR_TEXT challenge (see client-pending-auth section). The argument
+to cr-response is the base64 encoded answer to the challenge and
+depends on the challenge itself. For a TOTP challenge this would
+a number encoded as base64; for a challenge like "what day is it today?"
+it would be a string encoded as base64.
 
 COMMAND -- pk-sig (OpenVPN 2.5 or higher, management version > 1)
 COMMAND -- rsa-sig (OpenVPN 2.3 or higher, management version <= 1)
@@ -1076,6 +1097,9 @@ PASSWORD -- Used to tell the management interface client that OpenVPN
 STATE    -- Shows the current OpenVPN state, as controlled
             by the "state" command.
 
+INFOMSG  -- Authentication related info from server such as
+            CR_TEXT or OPEN_URL. See description under client-pending-auth
+
 The CLIENT notification
 -----------------------
 
@@ -1133,14 +1157,15 @@ CLIENT notification types:
    >CLIENT:ENV,...
    >CLIENT:ENV,END
 
-   Using the cr-response command on the client side will trigger this
+   Use of the cr-response command on the client side will trigger this
    message on the server side.
 
-   CR_RESPONSE notification. The >CR_RESPONSE fulfils the same purpose as the
+   CR_RESPONSE notification fulfills the same purpose as the
    CRV1 response in the traditional challenge/response. See that section
-   below for more details. Since this still uses the same cid as the original
-   response, we do not use the username and opaque session data in this
-   response but only contains the actual response.
+   below for more details. Since this uses the same cid as in the original
+   client-pending-auth challenge,  we do not include the username and opaque
+   session data in this notification. The string {response_base64} only contains
+   the actual response received from the client.
 
    It is important to note that OpenVPN2 merely passes the authentication
    information and does not do any further checks. (E.g. if a CR was issued
@@ -1148,7 +1173,7 @@ CLIENT notification types:
    data has a valid base64 encoding)
 
    This interface should be be sufficient for almost all challenge/response
-   system that can be implemented with a single round and base64 encoding the
+   system that can be implemented with a single round and base64 encoding of the
    response. Mechanisms that need multiple rounds or more complex answers
    should implement a different response type than CR_RESPONSE.
 
-- 
2.20.1


