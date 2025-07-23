From: Gert Doering <gert@...1296...>
Date: Wed, 23 Jul 2025 17:32:19 +0200
Message-ID: <20250723153224.13708-1-gert@...1296...>
In-Reply-To: <gerrit.1753215725000.I7bbc40b7b66f6e0512cd2cf9791766bcc4970461@...2715...>
References: <gerrit.1753215725000.I7bbc40b7b66f6e0512cd2cf9791766bcc4970461@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] dco_linux: factor out netlink
 notification code
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

From: Antonio Quartulli <antonio@...2726...>

ovpn_handle_msg() is soon becoming the main entry point for parsing
*all* incoming netlink messages. For this reason it is essential
that this function is kept simple and slim.

Move all code parsing netlink multicast notifications to their own
helpers and then invoke them.

This patch does not introduce any functional change.
It is intended in preparation for extending ovpn_handle_msg() to
become a genering netlink message parser.

Change-Id: I7bbc40b7b66f6e0512cd2cf9791766bcc4970461
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1099
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index ec6efaa..7c639d9 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -956,6 +956,164 @@
     return NL_OK;
 }
 
+static bool
+ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
+{
+    /* we must know which interface this message is referring to in order to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_A_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return false;
+    }
+
+    uint32_t ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
+    if (ifindex != dco->ifindex)
+    {
+        msg(D_DCO_DEBUG,
+            "ovpn-dco: ignoring message for foreign ifindex %d", ifindex);
+        return false;
+    }
+
+    return true;
+}
+
+static int
+ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    if (!ovpn_iface_check(dco, attrs))
+    {
+        return NL_STOP;
+    }
+
+    if (!attrs[OVPN_A_PEER])
+    {
+        msg(D_DCO, "ovpn-dco: no peer in PEER_DEL_NTF message");
+        return NL_STOP;
+    }
+
+    struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];
+    if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],
+                         NULL))
+    {
+        msg(D_DCO, "ovpn-dco: can't parse peer in PEER_DEL_NTF messsage");
+        return NL_STOP;
+    }
+
+    if (!dp_attrs[OVPN_A_PEER_DEL_REASON])
+    {
+        msg(D_DCO, "ovpn-dco: no reason in PEER_DEL_NTF message");
+        return NL_STOP;
+    }
+    if (!dp_attrs[OVPN_A_PEER_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
+        return NL_STOP;
+    }
+
+    int reason = nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
+    unsigned int peerid = nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d",
+        dco->ifindex, peerid, reason);
+    dco->dco_message_peer_id = peerid;
+    dco->dco_del_peer_reason = reason;
+    dco->dco_message_type = OVPN_CMD_PEER_DEL_NTF;
+
+    return NL_OK;
+}
+
+static int
+ovpn_handle_peer_float_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    if (!ovpn_iface_check(dco, attrs))
+    {
+        return NL_STOP;
+    }
+
+    if (!attrs[OVPN_A_PEER])
+    {
+        msg(D_DCO, "ovpn-dco: no peer in PEER_FLOAT_NTF message");
+        return NL_STOP;
+    }
+
+    struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];
+    if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],
+                         NULL))
+    {
+        msg(D_DCO, "ovpn-dco: can't parse peer in PEER_FLOAT_NTF messsage");
+        return NL_STOP;
+    }
+
+    if (!fp_attrs[OVPN_A_PEER_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF message");
+        return NL_STOP;
+    }
+    uint32_t peerid = nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);
+
+    if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&dco->dco_float_peer_ss))
+    {
+        return NL_STOP;
+    }
+
+    struct gc_arena gc = gc_new();
+    msg(D_DCO_DEBUG,
+        "ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s",
+        dco->ifindex, peerid, print_sockaddr((struct sockaddr *)&dco->dco_float_peer_ss, &gc));
+    dco->dco_message_peer_id = (int)peerid;
+    dco->dco_message_type = OVPN_CMD_PEER_FLOAT_NTF;
+
+    gc_free(&gc);
+
+    return NL_OK;
+}
+
+static int
+ovpn_handle_key_swap_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    if (!ovpn_iface_check(dco, attrs))
+    {
+        return NL_STOP;
+    }
+
+    if (!attrs[OVPN_A_KEYCONF])
+    {
+        msg(D_DCO, "ovpn-dco: no keyconf in KEY_SWAP_NTF message");
+        return NL_STOP;
+    }
+
+    struct nlattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];
+    if (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,
+                         attrs[OVPN_A_KEYCONF], NULL))
+    {
+        msg(D_DCO, "ovpn-dco: can't parse keyconf in KEY_SWAP_NTF message");
+        return NL_STOP;
+    }
+    if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no peer-id in KEY_SWAP_NTF message");
+        return NL_STOP;
+    }
+    if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no key-id in KEY_SWAP_NTF message");
+        return NL_STOP;
+    }
+
+    int key_id = nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
+    unsigned int peer_id = nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d",
+        dco->ifindex, peer_id, key_id);
+    dco->dco_message_peer_id = peer_id;
+    dco->dco_message_key_id = key_id;
+    dco->dco_message_type = OVPN_CMD_KEY_SWAP_NTF;
+
+    return NL_OK;
+}
+
 /* This function parses any netlink message sent by ovpn-dco to userspace */
 static int
 ovpn_handle_msg(struct nl_msg *msg, void *arg)
@@ -979,24 +1137,6 @@
         return NL_STOP;
     }
 
-    /* we must know which interface this message is referring to in order to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_A_IFINDEX])
-    {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
-        return NL_STOP;
-    }
-
-    uint32_t ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
-    if (ifindex != dco->ifindex)
-    {
-        msg(D_DCO_DEBUG,
-            "ovpn-dco: ignoring message (type=%d) for foreign ifindex %d",
-            gnlh->cmd, ifindex);
-        return NL_STOP;
-    }
-
     /* based on the message type, we parse the subobject contained in the
      * message, that stores the type-specific attributes.
      *
@@ -1008,116 +1148,17 @@
     {
         case OVPN_CMD_PEER_DEL_NTF:
         {
-            if (!attrs[OVPN_A_PEER])
-            {
-                msg(D_DCO, "ovpn-dco: no peer in PEER_DEL_NTF message");
-                return NL_STOP;
-            }
-
-            struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];
-            if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],
-                                 NULL))
-            {
-                msg(D_DCO, "ovpn-dco: can't parse peer in PEER_DEL_NTF messsage");
-                return NL_STOP;
-            }
-
-            if (!dp_attrs[OVPN_A_PEER_DEL_REASON])
-            {
-                msg(D_DCO, "ovpn-dco: no reason in PEER_DEL_NTF message");
-                return NL_STOP;
-            }
-            if (!dp_attrs[OVPN_A_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
-                return NL_STOP;
-            }
-
-            int reason = nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
-            unsigned int peerid = nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
-
-            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d",
-                ifindex, peerid, reason);
-            dco->dco_message_peer_id = peerid;
-            dco->dco_del_peer_reason = reason;
-            dco->dco_message_type = OVPN_CMD_PEER_DEL_NTF;
-            break;
+            return ovpn_handle_peer_del_ntf(dco, attrs);
         }
 
         case OVPN_CMD_PEER_FLOAT_NTF:
         {
-            if (!attrs[OVPN_A_PEER])
-            {
-                msg(D_DCO, "ovpn-dco: no peer in PEER_FLOAT_NTF message");
-                return NL_STOP;
-            }
-
-            struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];
-            if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],
-                                 NULL))
-            {
-                msg(D_DCO, "ovpn-dco: can't parse peer in PEER_FLOAT_NTF messsage");
-                return NL_STOP;
-            }
-
-            if (!fp_attrs[OVPN_A_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF message");
-                return NL_STOP;
-            }
-            uint32_t peerid = nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);
-
-            if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&dco->dco_float_peer_ss))
-            {
-                return NL_STOP;
-            }
-
-            struct gc_arena gc = gc_new();
-            msg(D_DCO_DEBUG,
-                "ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s",
-                ifindex, peerid, print_sockaddr((struct sockaddr *)&dco->dco_float_peer_ss, &gc));
-            dco->dco_message_peer_id = (int)peerid;
-            dco->dco_message_type = OVPN_CMD_PEER_FLOAT_NTF;
-
-            gc_free(&gc);
-            break;
+            return ovpn_handle_peer_float_ntf(dco, attrs);
         }
 
         case OVPN_CMD_KEY_SWAP_NTF:
         {
-            if (!attrs[OVPN_A_KEYCONF])
-            {
-                msg(D_DCO, "ovpn-dco: no keyconf in KEY_SWAP_NTF message");
-                return NL_STOP;
-            }
-
-            struct nlattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];
-            if (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,
-                                 attrs[OVPN_A_KEYCONF], NULL))
-            {
-                msg(D_DCO, "ovpn-dco: can't parse keyconf in KEY_SWAP_NTF message");
-                return NL_STOP;
-            }
-            if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no peer-id in KEY_SWAP_NTF message");
-                return NL_STOP;
-            }
-            if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no key-id in KEY_SWAP_NTF message");
-                return NL_STOP;
-            }
-
-            int key_id = nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
-            unsigned int peer_id = nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
-
-            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d",
-                ifindex, peer_id, key_id);
-            dco->dco_message_peer_id = peer_id;
-            dco->dco_message_key_id = key_id;
-            dco->dco_message_type = OVPN_CMD_KEY_SWAP_NTF;
-            break;
+            return ovpn_handle_key_swap_ntf(dco, attrs);
         }
 
         default:

