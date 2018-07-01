From: Gert Doering <gert@...1296...>
Date: Sun,  1 Jul 2018 21:59:38 +0200
Message-Id: <20180701195938.2541-1-gert@...1296...>
In-Reply-To: <023bf67a-02c2-93ca-7c97-3219b24d3411@...2181...>
References: <023bf67a-02c2-93ca-7c97-3219b24d3411@...2181...>
Subject: [Openvpn-devel] [PATCH] Extend push-remove to also handle
 'ifconfig'.
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

Push-remove (introduced in commit 970312f1850) did not handle "ifconfig"
yet, as both "ifconfig" and "ifconfig-ipv6" are handled differently from
all other pushed options.  Since there was no valid use-case to not-push
"ifconfig" (no support on the client side for running IPv6-only) this
was not an issue so far - but with the recent commits to enable ipv6-only
operation it can be a desirable feature.

The implementation is similar to "push-remove ifconfig-ipv6" - namely,
flagging via a new context option (c->options.push_ifconfig_ipv4_blocked)
and then not creating the push statement in "send_push_reply()".

While not truly elegant, it's much less invasive than the alternatives
(storing the list of "push-remove" statements somewhere and then checking
in push_option_ex())

Trac: #1072

Signed-off-by: Gert Doering <gert@...1296...>

---
v2: style changes, manpage note about exact match
---
 doc/openvpn.8         |  5 +++++
 src/openvpn/options.h |  1 +
 src/openvpn/push.c    | 10 +++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 0e5d467..46ea58b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3045,6 +3045,11 @@ an option,
 can be used to first remove the old value, and then add a new
 .B \-\-push
 option with the new value.
+
+NOTE2: due to implementation details, 'ifconfig' and 'ifconfig-ipv6'
+can only be removed with an exact match on the option ("push-remove ifconfig"),
+no substring matching and no matching on the IPv4/IPv6 address argument
+is possible.
 .\"*********************************************************
 .TP
 .B \-\-push\-peer\-info
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f7d0145..3a6c33f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -425,6 +425,7 @@ struct options
     bool push_ifconfig_constraint_defined;
     in_addr_t push_ifconfig_constraint_network;
     in_addr_t push_ifconfig_constraint_netmask;
+    bool push_ifconfig_ipv4_blocked;                    /* IPv4 */
     bool push_ifconfig_ipv6_defined;                    /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;           /* IPv6 */
     int push_ifconfig_ipv6_netbits;                     /* IPv6 */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6a30e47..a7ec4dd 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -342,7 +342,8 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
 
     /* ipv4 */
     if (c->c2.push_ifconfig_defined && c->c2.push_ifconfig_local
-        && c->c2.push_ifconfig_remote_netmask)
+        && c->c2.push_ifconfig_remote_netmask
+        && !o->push_ifconfig_ipv4_blocked)
     {
         in_addr_t ifconfig_local = c->c2.push_ifconfig_local;
         if (c->c2.push_ifconfig_local_alias)
@@ -602,6 +603,13 @@ push_remove_option(struct options *o, const char *p)
 {
     msg(D_PUSH_DEBUG, "PUSH_REMOVE searching for: '%s'", p);
 
+    /* ifconfig is special, as not part of the push list */
+    if (streq(p, "ifconfig"))
+    {
+        o->push_ifconfig_ipv4_blocked = true;
+        return;
+    }
+
     /* ifconfig-ipv6 is special, as not part of the push list */
     if (streq( p, "ifconfig-ipv6" ))
     {
-- 
2.7.3


