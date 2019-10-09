From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:20 +0200
Message-Id: <20191009143422.9419-8-a@...2181...>
In-Reply-To: <20191009143422.9419-1-a@...2181...>
References: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/9] VLAN: allow forwarding tagged and
 untagged packets on the server TAP device
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
Cc: Antonio Quartulli <a@...2181...>, Fabian Knittel <fabian.knittel@...1547...>

This changes allows the user to configure the server TAP interface to
forward both VLAN tagged and untagged packets (i.e. vlan_accept == VLAN_ALL).

Untagged packets are marked with the VID configured in the server
configuration file, while tagged packets will keep their header as it
is.

Forwarding is then performed following the standard rules, while
ensuring that pakcets do not leave the VLAN they belong to.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 12 +++++++++---
 src/openvpn/options.h |  1 +
 src/openvpn/vlan.c    | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5be6a6a8..3bcb9063 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -406,7 +406,7 @@ static const char usage_message[] =
     "                  to its initialization function.\n"
 #endif
     "--vlan-tagging  : Enable 802.1Q-based VLAN tagging.\n"
-    "--vlan-accept tagged|untagged : Set VLAN tagging mode.\n"
+    "--vlan-accept tagged|untagged|all : Set VLAN tagging mode. Default is 'all'.\n"
     "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
 #if P2MP
 #if P2MP_SERVER
@@ -853,7 +853,7 @@ init_options(struct options *o, const bool init_gc)
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
 #endif
-    o->vlan_accept = VLAN_ONLY_UNTAGGED_OR_PRIORITY;
+    o->vlan_accept = VLAN_ALL;
     o->vlan_pvid = 1;
 #if P2MP_SERVER
     o->real_hash_size = 256;
@@ -1239,6 +1239,8 @@ print_vlan_accept(enum vlan_acceptable_frames mode)
             return "tagged";
         case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
             return "untagged";
+        case VLAN_ALL:
+            return "all";
     }
     return NULL;
 }
@@ -8418,9 +8420,13 @@ add_option(struct options *options,
         {
             options->vlan_accept = VLAN_ONLY_UNTAGGED_OR_PRIORITY;
         }
+        else if (streq(p[1], "all"))
+        {
+            options->vlan_accept = VLAN_ALL;
+        }
         else
         {
-            msg(msglevel, "--vlan-accept must be 'tagged', 'untagged'");
+            msg(msglevel, "--vlan-accept must be 'tagged', 'untagged' or 'all'");
             goto err;
         }
     }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3447b7e2..6f5e1f53 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -173,6 +173,7 @@ enum vlan_acceptable_frames
 {
     VLAN_ONLY_TAGGED,
     VLAN_ONLY_UNTAGGED_OR_PRIORITY,
+    VLAN_ALL,
 };
 
 struct remote_host_store
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 88c90574..a5885de2 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -74,6 +74,10 @@ vlanhdr_set_vid(struct openvpn_8021qhdr *hdr, const uint16_t vid)
  *   returned.  Any included priority information is lost.
  *   If a frame isn't VLAN-tagged, the frame is dropped.
  *
+ * For vlan_accept == VLAN_ALL:
+ *   Accepts both VLAN-tagged and untagged (or priority-tagged) frames and
+ *   and handles them as described above.
+ *
  * @param c   The global context.
  * @param buf The ethernet frame.
  * @return    Returns -1 if the frame is dropped or the VID if it is accepted.
@@ -133,6 +137,7 @@ vlan_decapsulate(const struct context *c, struct buffer *buf)
 
             /* vid == 0 means prio-tagged packet: don't drop and fall-through */
         case VLAN_ONLY_TAGGED:
+        case VLAN_ALL:
             /* tagged frame can be accepted: extract vid and strip encapsulation */
 
             /* in case of prio-tagged frame (vid == 0), assume the sender
@@ -310,6 +315,18 @@ vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi)
             mi->context.c2.to_tun.len = 0;
         }
     }
+    else if (m->top.options.vlan_accept == VLAN_ALL)
+    {
+        /* Packets either need to be VLAN-tagged or not, depending on the
+         * packet's originating VID and the port's native VID (PVID).  */
+
+        if (m->top.options.vlan_pvid != mi->context.options.vlan_pvid)
+        {
+            /* Packets need to be VLAN-tagged, because the packet's VID does not
+             * match the port's PVID.  */
+            vlan_encapsulate(&mi->context, &mi->context.c2.to_tun);
+        }
+    }
     else if (m->top.options.vlan_accept == VLAN_ONLY_TAGGED)
     {
         /* All packets on the port (the tap device) need to be VLAN-tagged.  */
-- 
2.23.0


