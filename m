From: David Sommerseth <davids@...515...>
Date: Wed, 14 Dec 2016 13:23:30 +0100
Message-Id: <1481718210-15673-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Further enhance async-push feature
	description
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

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst  | 9 +++++----
 configure.ac | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index a5002dd..7da1119 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -148,10 +148,11 @@ Control channel encryption (``--tls-crypt``)
     post-quantum security.
 
 Asynchronous push reply
-    If asynchronous authentication is enabled and completed after server received
-    PUSH_REQUEST message, server sends PUSH_REPLY immediately without waiting for next
-    PUSH_REQUEST. Requires use of ``--enable-async-push`` as ./configure parameter at
-    build time.
+    Plug-ins providing support for deferred authentication can benefit from a more
+    responsive authentication where the server sends PUSH_REPLY immediately once
+    the authentication result is ready instead of waiting for the the client to
+    to send PUSH_REQUEST once more.  This requires OpenVPN to be built with
+    ``./configure --enable-async-push``.  This is a compile-time only switch.
 
 
 Deprecated features
diff --git a/configure.ac b/configure.ac
index 27bdcc3..4f086ea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -266,7 +266,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[async-push],
-	[AS_HELP_STRING([--enable-async-push], [enable async-push support @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-async-push], [enable async-push support for plugins providing deferred authentication @<:@default=no@:>@])],
 	,
 	[enable_async_push="no"]
 )
-- 
1.8.3.1


