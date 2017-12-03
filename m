Date: Sun, 3 Dec 2017 14:24:53 +0100
From: Martin Buck <mb-tmp-bcraica-hfref@...2354...>
Message-ID: <20171203132453.GB1941@...2355...>
References: <20171128124747.GA10015@...2355...>
 <20171128140827.GG69387@...1296...>
MIME-Version: 1.0
In-Reply-To: <20171128140827.GG69387@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Client mobility in bridged mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

[Discussion continues on openvpn-devel, please drop openvpn-users when
replying]

Hi Gert,

sorry for the late reply, real life currently causes lots of interrupts...

On Tue, Nov 28, 2017 at 03:08:27PM +0100, Gert Doering wrote:
> Short answer: shortcomings in the implementation, and nobody had time
> (and the need) to really look into that and fix things.

OK, maybe I can help a bit with fixing and testing. Still needs somebody to
review and apply this, though.

> There's an open trac ticket that is about MAC learning on the TAP side
> on the server, and LAN hosts roaming from "TAP side" to "client side"
> not working nicely - which has not received any attention due to "lack
> of time" either.

Ah, you mean #626? Haven't seen this so far, but that pretty well describes
(part of) the problems I see. Good to know that I'm not alone :-)

> Phrased differently: I do not see any technical or security reasons why 
> we shouldn't make this more like "a normal ethernet switch".  ARP spoofing
> comes to mind, but since we *do* learn in the first place, we should
> do this correctly :-) (possibly logging if a given MAC address roams
> "too often", though I'm not sure this is easy to do given the current
> data structures - so maybe just a rate-limited notice for "MAC address 
> roamed from <x> to <y>" instead)

Great. I'm attaching a patch for discussion that fixes item 3 in my original
list ("On the VPN server, there's no (source) address learning on the TAP
interface, only on the VPN client side"). This is similar to the patch
attached to #626, but it applies to the current Git master, keeps all
address (un)learning inside multi_learn_addr() and also learns source
addresses of broadcast/multicast frames.

Currently, it doesn't do any kind of special logging. It just logs
re-learned addresses on TAP like any other learned address, using "UNDEF"
instead of a VPN client name. That could probably be improved. It also
doesn't perform any kind of rate limiting at the moment.

Instead of learning source addresses addresses from the TAP interface, the
current patch simply makes sure addresses previously learned from a VPN
client are forgotten when they appear as source addresses from TAP. With the
current "flooding" implementation in multi_process_incoming_link(), this
will work fine, as frames with an unknown address are forwarded towards TAP.

In case we switch to a proper flooding implementation (flood to all except
incoming link) in the future, proper learning will be required as well. In
that case, we could then either learn using a NULL multi_instance or a
multi_instance reserved for TAP. I'm not yet sure about the potential side
effects of either variant.

Thanks for any feedback reagarding that patch. I'm also willing to invest
some time to come up with fixes for items 1/2 on my orignal list (proper
flooding/expiry of learned addresses), if there is interest.

Martin


From 299cc0fb69fd7e82e38669c539b07de3002ec125 Mon Sep 17 00:00:00 2001
From: Martin Buck <mb-tmp-bcraica-hfref@...2354...>
Date: Tue, 28 Nov 2017 17:36:05 +0100
Subject: [PATCH] Learn source addresses also for traffic from TAP interface

In fact, such source addresses are not newly learned, but if they have been
learned previously as belonging to a certain VPN client, the route towards
the VPN client is removed. This causes traffic from a VPN client addressed
to them to get forwarded to the TAP interface.
---
 src/openvpn/multi.c | 100 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 37 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 82a0b9d..2888313 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1092,57 +1092,75 @@ multi_learn_addr(struct multi_context *m,
         && !mroute_addr_equal(addr, &m->local))
     {
         struct gc_arena gc = gc_new();
-        struct multi_route *newroute;
+        struct multi_route *newroute = NULL;
         bool learn_succeeded = false;
 
-        ALLOC_OBJ(newroute, struct multi_route);
-        newroute->addr = *addr;
-        newroute->instance = mi;
-        newroute->flags = flags;
-        newroute->last_reference = now;
-        newroute->cache_generation = 0;
-
-        /* The cache is invalidated when cache_generation is incremented */
-        if (flags & MULTI_ROUTE_CACHE)
-        {
-            newroute->cache_generation = m->route_helper->cache_generation;
-        }
-
-        if (oldroute) /* route already exists? */
+        if (!mi)
         {
-            if (route_quota_test(m, mi) && learn_address_script(m, mi, "update", &newroute->addr))
+            /* remove address from hash table */
+            if (oldroute)
             {
-                learn_succeeded = true;
-                owner = mi;
-                multi_instance_inc_refcount(mi);
-                route_quota_inc(mi);
-
-                /* delete old route */
+                learn_address_script(m, NULL, "delete", &oldroute->addr);
+                hash_remove_fast(m->vhash, bucket, addr, hv);
                 multi_route_del(oldroute);
-
-                /* modify hash table entry, replacing old route */
-                he->key = &newroute->addr;
-                he->value = newroute;
             }
+            learn_succeeded = true;
+            owner = NULL;
         }
         else
         {
-            if (route_quota_test(m, mi) && learn_address_script(m, mi, "add", &newroute->addr))
+            ALLOC_OBJ(newroute, struct multi_route);
+            newroute->addr = *addr;
+            newroute->instance = mi;
+            newroute->flags = flags;
+            newroute->last_reference = now;
+            newroute->cache_generation = 0;
+
+            /* The cache is invalidated when cache_generation is incremented */
+            if (flags & MULTI_ROUTE_CACHE)
+            {
+                newroute->cache_generation = m->route_helper->cache_generation;
+            }
+
+            if (oldroute) /* route already exists? */
+            {
+                if (route_quota_test(m, mi) && learn_address_script(m, mi, "update", &newroute->addr))
+                {
+                    learn_succeeded = true;
+                    owner = mi;
+                    multi_instance_inc_refcount(mi);
+                    route_quota_inc(mi);
+
+                    /* delete old route */
+                    multi_route_del(oldroute);
+
+                    /* modify hash table entry, replacing old route */
+                    he->key = &newroute->addr;
+                    he->value = newroute;
+                }
+            }
+            else
             {
-                learn_succeeded = true;
-                owner = mi;
-                multi_instance_inc_refcount(mi);
-                route_quota_inc(mi);
+                if (route_quota_test(m, mi) && learn_address_script(m, mi, "add", &newroute->addr))
+                {
+                    learn_succeeded = true;
+                    owner = mi;
+                    multi_instance_inc_refcount(mi);
+                    route_quota_inc(mi);
 
-                /* add new route */
-                hash_add_fast(m->vhash, bucket, &newroute->addr, hv, newroute);
+                    /* add new route */
+                    hash_add_fast(m->vhash, bucket, &newroute->addr, hv, newroute);
+                }
             }
         }
 
-        msg(D_MULTI_LOW, "MULTI: Learn%s: %s -> %s",
-            learn_succeeded ? "" : " FAILED",
-            mroute_addr_print(&newroute->addr, &gc),
-            multi_instance_string(mi, false, &gc));
+        if (mi || oldroute)
+        {
+            msg(D_MULTI_LOW, "MULTI: Learn%s: %s -> %s",
+                learn_succeeded ? "" : " FAILED",
+                mroute_addr_print(addr, &gc),
+                multi_instance_string(mi, false, &gc));
+        }
 
         if (!learn_succeeded)
         {
@@ -2767,6 +2785,14 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
         {
             struct context *c;
 
+            /* learn that address is on TAP side (i.e. forget it on the VPN
+             * side if it was learned there)
+             */
+            if (dev_type == DEV_TYPE_TAP)
+            {
+              multi_learn_addr (m, NULL, &src, 0);
+            }
+
             /* broadcast or multicast dest addr? */
             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
             {
-- 
2.1.4



