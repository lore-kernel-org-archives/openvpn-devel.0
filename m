From: Arne Schwabe <arne@...1227...>
Date: Tue, 13 Dec 2022 23:01:37 +0100
Message-Id: <20221213220137.1888490-1-arne@...1227...>
In-Reply-To: <20220909195902.2011798-1-arne@...1227...>
References: <20220909195902.2011798-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Improve debug logging of DCO on Linux
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
 src/openvpn/dco.c       |  7 ++++---
 src/openvpn/dco_linux.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index feb38cd02..5cce3f641 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -55,8 +55,8 @@ dco_install_key(struct tls_multi *multi, struct key_state *ks,
                 const char *ciphername)
 
 {
-    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d", __func__, multi->dco_peer_id,
-        ks->key_id);
+    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d, currently installed %d",
+        __func__, multi->dco_peer_id, ks->key_id, multi->dco_keys_installed);
 
     /* Install a key in the PRIMARY slot only when no other key exist.
      * From that moment on, any new key will be installed in the SECONDARY
@@ -181,7 +181,8 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
      */
     if (primary->dco_status == DCO_INSTALLED_SECONDARY)
     {
-        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=%d id2=%d",
+        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, pre swap: "
+            "key-id1=%d key-id2=%d",
             primary->key_id, secondary ? secondary->key_id : -1);
 
         int ret = dco_swap_keys(dco, multi->dco_peer_id);
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 109358205..fbd940c28 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -216,9 +216,15 @@ dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
              struct in_addr *remote_in4, struct in6_addr *remote_in6)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
-
     struct gc_arena gc = gc_new();
+    const char *remotestr = "[undefined]";
+    if (remoteaddr)
+    {
+        remotestr = print_sockaddr(remoteaddr, &gc);
+    }
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d, remote addr: %s", __func__,
+        peerid, sd, remotestr);
+
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_PEER);
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);
     int ret = -EMSGSIZE;
-- 
2.37.1 (Apple Git-137.1)


