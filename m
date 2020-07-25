From: Arne Schwabe <arne@...1227...>
Date: Sun, 26 Jul 2020 01:48:03 +0200
Message-Id: <20200725234803.22058-2-arne@...1227...>
In-Reply-To: <20200725234803.22058-1-arne@...1227...>
References: <20200725234803.22058-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/2] Avoid sending push request after
 receving push reply
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

The introduction of IV_PROTO_REQUEST_PUSH (c290df55) sometimes causes the
server to reply before we setup the push timer. The push reply will then clear
a timer that has not been setup yet. We then start sending push
request after we have gone through the whole initialisation already.

This patch also clears the connestion_established timer that sets up the
push request timer. This lead to the

management_set_state(management,  OPENVPN_STATE_GET_CONFIG, ...)

function not being called. But a to display "waiting for configuration..." or
sending a "getting config state" after "initialisation" does not make sense
anyway.

Also add the IV_PROTO_REQUEST_PUSH feature as new feature in Changes.rst

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst           | 11 +++++++++++
 src/openvpn/forward.c |  3 +++
 src/openvpn/push.c    |  1 +
 3 files changed, 15 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 8fbaf419..e377a36c 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -37,6 +37,13 @@ Deferred client-connect
     asynchronous/deferred return of the configuration file in the same way
     as the auth-plugin.
 
+Faster connection setup
+    A client will signal in the ``IV_PROTO`` variable that is in pull
+    mode. This allows the server to push the configuration options to
+    the client without waiting for a ``PULL_REQUEST`` message. The feature
+    is automatically enabled if both client and server support it and
+    reduces the of connection setup time by one round-trip time.
+
 Deprecated features
 -------------------
 For an up-to-date list of all deprecated options, see this wiki page:
@@ -72,6 +79,10 @@ User-visible Changes
 - Support for building with OpenSSL 1.0.1 has been removed. The minimum
   supported OpenSSL version is now 1.0.2.
 
+- The GET_CONFIG management state is ommited if the server pushes
+  the client configuration almost immediately as result of the
+  faster connection setup feature.
+
 
 Overview of changes in 2.4
 ==========================
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 30a3fd46..759fdbe1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -425,6 +425,9 @@ check_push_request_dowork(struct context *c)
  *
  * Options like --up-delay need to be triggered by this function which
  * checks for connection establishment.
+ *
+ * Note: The process_incoming_push_reply currently assumes that this function
+ * only sets ups the pull request timer when pull is enabled.
  */
 void
 check_connection_established(struct context *c)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 84193afe..9c720b42 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -358,6 +358,7 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
             }
         }
         event_timeout_clear(&c->c2.push_request_interval);
+        event_timeout_clear(&c->c2.wait_for_connect);
     }
 
     goto cleanup;
-- 
2.26.2


