From: =?UTF-8?q?Fran=C3=A7ois=20Kooman?= <fkooman@...2318...>
Date: Fri, 10 Nov 2017 17:39:46 +0100
Message-Id: <20171110163946.7656-1-fkooman@...2318...>
Subject: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for management
 interface
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

Parsing CSV can be cumbersome in depending software, so instead
offer JSON as well using "status 4".

The "status 4" command uses the same keys/values as "status 2"
and "status 3", just formatted as JSON.
---
 src/openvpn/multi.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 82a0b9d9..3e82431b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1014,6 +1014,102 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
 
             status_printf(so, "END");
         }
+        else if (version == 4)
+        {
+            /*
+             * Status file version 4 (JSON)
+             */
+            status_printf(so, "{");
+            status_printf(so, "\"TITLE\": \"%s\",", title_string);
+            status_printf(so, "\"TIME\": \"%s\",", time_string(now, 0, false, &gc_top));
+            /* UNIX_TIME added here instead of making it part of TIME as well
+               as in status 2/3 */
+            status_printf(so, "\"UNIX_TIME\": %u,", (unsigned int)now);
+            status_printf(so, "\"CLIENT_LIST\": [");
+
+            /* JSON needs a "," between items, but not at the last position,
+               because I was unable to figure out how to determine if we
+               iterate over the last item, we inverse it by prepending
+               additional items with a comma */
+            int is_first = 1;
+            hash_iterator_init(m->hash, &hi);
+            while ((he = hash_iterator_next(&hi)))
+            {
+                struct gc_arena gc = gc_new();
+                const struct multi_instance *mi = (struct multi_instance *) he->value;
+
+                if (!mi->halt)
+                {
+                    if(0 == is_first) {
+                        status_printf(so, ",");
+                    } else {
+                        is_first = 0;
+                    }
+                    status_printf(so, "{");
+                    status_printf(so, "\"Common Name\": \"%s\",", tls_common_name(mi->context.c2.tls_multi, false));
+                    status_printf(so, "\"Real Address\": \"%s\",", mroute_addr_print(&mi->real, &gc));
+                    status_printf(so, "\"Virtual Address\": \"%s\",", print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc));
+                    status_printf(so, "\"Virtual IPv6 Address\": \"%s\",", print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc));
+                    status_printf(so, "\"Bytes Received\": " counter_format ",", mi->context.c2.link_read_bytes);
+                    status_printf(so, "\"Bytes Sent\": " counter_format ",", mi->context.c2.link_write_bytes);
+                    status_printf(so, "\"Connected Since\": \"%s\",", time_string(mi->created, 0, false, &gc));
+                    status_printf(so, "\"Connected Since (time_t)\": %u,", (unsigned int)mi->created);
+                    status_printf(so, "\"Username\": \"%s\",", tls_username(mi->context.c2.tls_multi, false));
+#ifdef MANAGEMENT_DEF_AUTH
+                    status_printf(so, "\"Client ID\": %lu,", mi->context.c2.mda_context.cid);
+#endif
+                    status_printf(so, "\"Peer ID\": %" PRIu32, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->peer_id : UINT32_MAX);
+                    status_printf(so, "}");
+                }
+                gc_free(&gc);
+            }
+            hash_iterator_free(&hi);
+
+            status_printf(so, "],");
+            status_printf(so, "\"ROUTING_TABLE\": [");
+
+            is_first = 1;
+            hash_iterator_init(m->vhash, &hi);
+            while ((he = hash_iterator_next(&hi)))
+            {
+                struct gc_arena gc = gc_new();
+                const struct multi_route *route = (struct multi_route *) he->value;
+
+                if (multi_route_defined(m, route))
+                {
+                    const struct multi_instance *mi = route->instance;
+                    const struct mroute_addr *ma = &route->addr;
+                    char flags[2] = {0, 0};
+
+                    if (route->flags & MULTI_ROUTE_CACHE)
+                    {
+                        flags[0] = 'C';
+                    }
+                        if(0 == is_first) {
+                            status_printf(so, ",");
+                        } else {
+                            is_first = 0;
+                        }
+                        status_printf(so, "{\"Virtual Address\": \"%s%s\",", mroute_addr_print(ma, &gc), flags);
+                        status_printf(so, "\"Common Name\": \"%s\",", tls_common_name(mi->context.c2.tls_multi, false));
+                        status_printf(so, "\"Real Address\": \"%s\",", mroute_addr_print(&mi->real, &gc));
+                        status_printf(so, "\"Last Ref\": \"%s\",", time_string(route->last_reference, 0, false, &gc));
+                        status_printf(so, "\"Last Ref (time_t)\": %u}", (unsigned int)route->last_reference);
+                }
+                gc_free(&gc);
+            }
+            hash_iterator_free(&hi);
+            status_printf(so, "]");
+
+            if (m->mbuf)
+            {
+                status_printf(so, ",\"GLOBAL_STATS\": {");
+                status_printf(so, "\"Max bcast/mcast queue length\": %d", mbuf_maximum_queued(m->mbuf));
+                status_printf(so, "}");
+            }
+            status_printf(so, "}");
+            status_printf(so, "END");
+        }
         else
         {
             status_printf(so, "ERROR: bad status format version number");
-- 
2.13.6


