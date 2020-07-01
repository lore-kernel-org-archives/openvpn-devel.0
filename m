From: Richard Bonhomme <tincanteksup@...277...>
Date: Wed,  1 Jul 2020 23:28:11 +0100
Message-Id: <20200701222811.14900-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch] New man page corrections -
 client-options.rst
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

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/client-options.rst | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 966ede1e..c5aa58c9 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -26,9 +26,9 @@ configuration.
   pass over this token as the password instead of the password the user
   provided. The authentication token can only be reset by a full reconnect
   where the server can push new options to the client. The password the
-  user entered is never preserved once an authentication token have been
-  set. If the OpenVPN server side rejects the authentication token, the
-  client will receive an ``AUTH_FAIL`` and disconnect.
+  user entered is never preserved once an authentication token has been
+  set. If the OpenVPN server side rejects the authentication token then
+  the client will receive an ``AUTH_FAIL`` and disconnect.
 
   The purpose of this is to enable two factor authentication methods, such
   as HOTP or TOTP, to be used without needing to retrieve a new OTP code
@@ -130,7 +130,7 @@ configuration.
   Set ``--verb 6`` for debugging info showing the transformation of
   src/dest addresses in packets.
 
---connect-retry args
+--connect-retry n
   Wait ``n`` seconds between connection attempts (default :code:`5`).
   Repeated reconnection attempts are slowed down after 5 retries per
   remote by doubling the wait time after each unsuccessful attempt. An
@@ -139,7 +139,7 @@ configuration.
 
 --connect-retry-max n
   ``n`` specifies the number of times each ``--remote`` or
-  ``<connection>`` entry is tried. Specifying ``n`` as one would try each
+  ``<connection>`` entry is tried. Specifying ``n`` as ``1`` would try each
   entry exactly once. A successful connection resets the counter.
   (default *unlimited*).
 
@@ -331,9 +331,8 @@ configuration.
 
 --server-poll-timeout n
   When connecting to a remote server do not wait for more than ``n``
-  seconds waiting for a response before trying the next server. The
-  default value is 120s. This timeout includes proxy and TCP connect
-  timeouts.
+  seconds for a response before trying the next server. The default value
+  is 120s. This timeout includes proxy and TCP connect timeouts.
 
 --static-challenge args
   Enable static challenge/response protocol
-- 
2.17.1


