Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AC606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TShUPhOw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jk1efWxg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Q1jgLJfc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=a1cTnLsMrtnfnjl61Oq7qoPQi8SCsBmnY3Y0Pqsqknw=; b=TShUPhOw1cuL8B
	x1UyxX4At+7CC0aH6DAVEfCTbnRO9JAx4NkRi62MxGQhwkMfEFROxr1atuf59GF4Qb4cXmawlaoaT
	+rUbCxIinEp57sIAc+OkSDEGZJvc7TsoK4p/+zDw0ploLvbonJ+2xZq2qsrraXSqYs2negO51VeIj
	OMA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoab-000000007Ra-1TRI;
	Mon, 02 Nov 2026 09:44:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNoaZ-000000007RQ-2s7v for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3IYPInPuelGjTMKI8l5/J/LHDc0c+ovFNjGkXrue7ok=; b=jk1efWxg+oXtpGPLgLKxK6QaxU
 zQTw6EO/V0h/rrVI9qHmT1QG9ekGots/rysVP33Ix8oIARzUdSGHJnQNFHoC/zbxG3eS5ZawaaK5N
 Cg5/L60KyeYuykv/h76K5fXyx93F3dD3mkY6jtzBD0vpOQaFhAuwYyb/PrjsYSCCOn/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3IYPInPuelGjTMKI8l5/J/LHDc0c+ovFNjGkXrue7ok=; b=Q1jgLJfckdVDm8kVNlsymDbcAJ
 zA94T9xTrdusmZ2/bmiiuSl/erN+2C4/+1rTiHhhV/pAEClbH5Q0BY5obXbFGJhyIxsZXVKqc3dbg
 k4UDpap6Blxtsweqm521c9cuW/an/pkXIBH6f1jMB1rBuIxG8Wz+x16QAQk+uaDVjLKE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNoaX-0000000024q-3Nfg for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:44:27 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A29iImC030357
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 10:44:18 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A29iIWZ030356
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 10:44:18 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 10:44:12 +0100
Message-ID: <20261102094418.30344-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
References: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNoaX-0000000024q-3Nfg
Subject: [Openvpn-devel] [PATCH v2] Use m->instances instead of m->hash to
 iterate clients
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arne Schwabe <arne@rfc2549.org>

This simplifies the code a bit and also fixes a problem introduced by
66f8cdb that connections in the early stages of connection are not shown
in the status file (e.g. telnet openvpn-server 1194).

Since this removes an indentation area, it is best to look at the changes
of this commit while ignoring white-space changes.

Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2065
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2065
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0fc9ee2..d3e6b5a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4300,12 +4300,14 @@
         }
 
         /* iterate over peers and report counters for each connected peer */
-        struct hash_iterator hi;
-        struct hash_element *he;
-        hash_iterator_init(multi->hash, &hi);
-        while ((he = hash_iterator_next(&hi)))
+        for (uint32_t i = 0; i <= multi->max_peerid; i++)
         {
-            struct multi_instance *mi = (struct multi_instance *)he->value;
+            struct multi_instance *mi = multi->instances[i];
+
+            if (!mi)
+            {
+                continue;
+            }
             struct context_2 *c2 = &mi->context.c2;
 
             if ((c2->mda_context.flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
@@ -4313,7 +4315,6 @@
                 man_bytecount_output_server(c2->dco_read_bytes + c2->link_read_bytes, c2->dco_write_bytes + c2->link_write_bytes, &c2->mda_context);
             }
         }
-        hash_iterator_free(&hi);
     }
 }
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 82757f4..79e6bae 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -807,210 +807,205 @@
 static void
 multi_print_status(struct multi_context *m, struct status_output *so, const int version)
 {
-    if (m->hash)
+    struct gc_arena gc_top = gc_new();
+    struct hash_iterator hi;
+    const struct hash_element *he;
+
+    status_reset(so);
+
+    if (dco_enabled(&m->top.options))
     {
-        struct gc_arena gc_top = gc_new();
-        struct hash_iterator hi;
-        const struct hash_element *he;
-
-        status_reset(so);
-
-        if (dco_enabled(&m->top.options))
+        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, true) < 0)
         {
-            if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, true) < 0)
+            return;
+        }
+    }
+
+    if (version == 1)
+    {
+        /*
+         * Status file version 1
+         */
+        status_printf(so, "OpenVPN CLIENT LIST");
+        status_printf(so, "Updated,%s", time_string(0, 0, false, &gc_top));
+        status_printf(so, "Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since");
+
+        for (uint32_t i = 0; i <= m->max_peerid; i++)
+        {
+            const struct multi_instance *mi = m->instances[i];
+
+            struct gc_arena gc = gc_new();
+            if (mi && !mi->halt)
             {
-                return;
+                status_printf(so, "%s,%s," counter_format "," counter_format ",%s",
+                              tls_common_name(mi->context.c2.tls_multi, false),
+                              mroute_addr_print(&mi->real, &gc),
+                              mi->context.c2.link_read_bytes + mi->context.c2.dco_read_bytes,
+                              mi->context.c2.link_write_bytes + mi->context.c2.dco_write_bytes,
+                              time_string(mi->created, 0, false, &gc));
             }
+            gc_free(&gc);
         }
 
-        if (version == 1)
+        status_printf(so, "ROUTING TABLE");
+        status_printf(so, "Virtual Address,Common Name,Real Address,Last Ref");
+        hash_iterator_init(m->vhash, &hi);
+        while ((he = hash_iterator_next(&hi)))
         {
-            /*
-             * Status file version 1
-             */
-            status_printf(so, "OpenVPN CLIENT LIST");
-            status_printf(so, "Updated,%s", time_string(0, 0, false, &gc_top));
-            status_printf(so, "Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since");
-            hash_iterator_init(m->hash, &hi);
-            while ((he = hash_iterator_next(&hi)))
-            {
-                struct gc_arena gc = gc_new();
-                const struct multi_instance *mi = (struct multi_instance *)he->value;
+            struct gc_arena gc = gc_new();
+            const struct multi_route *route = (struct multi_route *)he->value;
 
-                if (!mi->halt)
+            if (multi_route_defined(m, route))
+            {
+                const struct multi_instance *mi = route->instance;
+                const struct mroute_addr *ma = &route->addr;
+                char flags[2] = { 0, 0 };
+
+                if (route->flags & MULTI_ROUTE_CACHE)
                 {
-                    status_printf(so, "%s,%s," counter_format "," counter_format ",%s",
-                                  tls_common_name(mi->context.c2.tls_multi, false),
-                                  mroute_addr_print(&mi->real, &gc),
-                                  mi->context.c2.link_read_bytes + mi->context.c2.dco_read_bytes,
-                                  mi->context.c2.link_write_bytes + mi->context.c2.dco_write_bytes,
-                                  time_string(mi->created, 0, false, &gc));
+                    flags[0] = 'C';
                 }
-                gc_free(&gc);
+                status_printf(so, "%s%s,%s,%s,%s", mroute_addr_print(ma, &gc), flags,
+                              tls_common_name(mi->context.c2.tls_multi, false),
+                              mroute_addr_print(&mi->real, &gc),
+                              time_string(route->last_reference, 0, false, &gc));
             }
-            hash_iterator_free(&hi);
-
-            status_printf(so, "ROUTING TABLE");
-            status_printf(so, "Virtual Address,Common Name,Real Address,Last Ref");
-            hash_iterator_init(m->vhash, &hi);
-            while ((he = hash_iterator_next(&hi)))
-            {
-                struct gc_arena gc = gc_new();
-                const struct multi_route *route = (struct multi_route *)he->value;
-
-                if (multi_route_defined(m, route))
-                {
-                    const struct multi_instance *mi = route->instance;
-                    const struct mroute_addr *ma = &route->addr;
-                    char flags[2] = { 0, 0 };
-
-                    if (route->flags & MULTI_ROUTE_CACHE)
-                    {
-                        flags[0] = 'C';
-                    }
-                    status_printf(so, "%s%s,%s,%s,%s", mroute_addr_print(ma, &gc), flags,
-                                  tls_common_name(mi->context.c2.tls_multi, false),
-                                  mroute_addr_print(&mi->real, &gc),
-                                  time_string(route->last_reference, 0, false, &gc));
-                }
-                gc_free(&gc);
-            }
-            hash_iterator_free(&hi);
-
-            status_printf(so, "GLOBAL STATS");
-            if (m->mbuf)
-            {
-                status_printf(so, "Max bcast/mcast queue length,%d", mbuf_maximum_queued(m->mbuf));
-            }
-
-            status_printf(so, "END");
+            gc_free(&gc);
         }
-        else if (version == 2 || version == 3)
+        hash_iterator_free(&hi);
+
+        status_printf(so, "GLOBAL STATS");
+        if (m->mbuf)
         {
-            const char sep = (version == 3) ? '\t' : ',';
+            status_printf(so, "Max bcast/mcast queue length,%d", mbuf_maximum_queued(m->mbuf));
+        }
 
-            /*
-             * Status file version 2 and 3
-             */
-            status_printf(so, "TITLE%c%s", sep, title_string);
-            status_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, false, &gc_top), sep,
-                          (unsigned int)now);
-            status_printf(
-                so,
-                "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID%cData Channel Cipher",
-                sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
-            hash_iterator_init(m->hash, &hi);
-            while ((he = hash_iterator_next(&hi)))
+        status_printf(so, "END");
+    }
+    else if (version == 2 || version == 3)
+    {
+        const char sep = (version == 3) ? '\t' : ',';
+
+        /*
+         * Status file version 2 and 3
+         */
+        status_printf(so, "TITLE%c%s", sep, title_string);
+        status_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, false, &gc_top), sep,
+                      (unsigned int)now);
+        status_printf(
+            so,
+            "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID%cData Channel Cipher",
+            sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
+
+        for (uint32_t i = 0; i <= m->max_peerid; i++)
+        {
+            const struct multi_instance *mi = m->instances[i];
+            struct gc_arena gc = gc_new();
+
+            if (mi && !mi->halt)
             {
-                struct gc_arena gc = gc_new();
-                const struct multi_instance *mi = (struct multi_instance *)he->value;
-
-                if (!mi->halt)
-                {
-                    status_printf(
-                        so,
-                        "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c" counter_format
-                        "%c%s%c%u%c%s%c"
+                status_printf(
+                    so,
+                    "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c" counter_format
+                    "%c%s%c%u%c%s%c"
 #ifdef ENABLE_MANAGEMENT
-                        "%lu"
+                    "%lu"
 #else
-                        ""
+                    ""
 #endif
-                        "%c%" PRIu32 "%c%s",
-                        sep, tls_common_name(mi->context.c2.tls_multi, false), sep,
-                        mroute_addr_print(&mi->real, &gc), sep,
-                        print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc), sep,
-                        print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc), sep,
-                        mi->context.c2.link_read_bytes + mi->context.c2.dco_read_bytes, sep,
-                        mi->context.c2.link_write_bytes + mi->context.c2.dco_write_bytes, sep,
-                        time_string(mi->created, 0, false, &gc), sep, (unsigned int)mi->created,
-                        sep, tls_username(mi->context.c2.tls_multi, false),
+                    "%c%" PRIu32 "%c%s",
+                    sep, tls_common_name(mi->context.c2.tls_multi, false), sep,
+                    mroute_addr_print(&mi->real, &gc), sep,
+                    print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc), sep,
+                    print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc), sep,
+                    mi->context.c2.link_read_bytes + mi->context.c2.dco_read_bytes, sep,
+                    mi->context.c2.link_write_bytes + mi->context.c2.dco_write_bytes, sep,
+                    time_string(mi->created, 0, false, &gc), sep, (unsigned int)mi->created,
+                    sep, tls_username(mi->context.c2.tls_multi, false),
 #ifdef ENABLE_MANAGEMENT
-                        sep, mi->context.c2.mda_context.cid,
+                    sep, mi->context.c2.mda_context.cid,
 #else
-                        sep,
+                    sep,
 #endif
-                        sep, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->rx_peer_id : MAX_PEER_ID,
-                        sep, translate_cipher_name_to_openvpn(mi->context.options.ciphername));
-                }
-                gc_free(&gc);
+                    sep, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->rx_peer_id : MAX_PEER_ID,
+                    sep, translate_cipher_name_to_openvpn(mi->context.options.ciphername));
             }
-            hash_iterator_free(&hi);
-
-            status_printf(
-                so,
-                "HEADER%cROUTING_TABLE%cVirtual Address%cCommon Name%cReal Address%cLast Ref%cLast Ref (time_t)",
-                sep, sep, sep, sep, sep, sep);
-            hash_iterator_init(m->vhash, &hi);
-            while ((he = hash_iterator_next(&hi)))
-            {
-                struct gc_arena gc = gc_new();
-                const struct multi_route *route = (struct multi_route *)he->value;
-
-                if (multi_route_defined(m, route))
-                {
-                    const struct multi_instance *mi = route->instance;
-                    const struct mroute_addr *ma = &route->addr;
-                    char flags[2] = { 0, 0 };
-
-                    if (route->flags & MULTI_ROUTE_CACHE)
-                    {
-                        flags[0] = 'C';
-                    }
-                    status_printf(so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u", sep,
-                                  mroute_addr_print(ma, &gc), flags, sep,
-                                  tls_common_name(mi->context.c2.tls_multi, false), sep,
-                                  mroute_addr_print(&mi->real, &gc), sep,
-                                  time_string(route->last_reference, 0, false, &gc), sep,
-                                  (unsigned int)route->last_reference);
-                }
-                gc_free(&gc);
-            }
-            hash_iterator_free(&hi);
-
-            if (m->mbuf)
-            {
-                status_printf(so, "GLOBAL_STATS%cMax bcast/mcast queue length%c%d", sep, sep,
-                              mbuf_maximum_queued(m->mbuf));
-            }
-
-            status_printf(so, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep,
-                          dco_enabled(&m->top.options));
-            status_printf(so, "END");
+            gc_free(&gc);
         }
-        else
+
+        status_printf(
+            so,
+            "HEADER%cROUTING_TABLE%cVirtual Address%cCommon Name%cReal Address%cLast Ref%cLast Ref (time_t)",
+            sep, sep, sep, sep, sep, sep);
+        hash_iterator_init(m->vhash, &hi);
+        while ((he = hash_iterator_next(&hi)))
         {
-            status_printf(so, "ERROR: bad status format version number");
+            struct gc_arena gc = gc_new();
+            const struct multi_route *route = (struct multi_route *)he->value;
+
+            if (multi_route_defined(m, route))
+            {
+                const struct multi_instance *mi = route->instance;
+                const struct mroute_addr *ma = &route->addr;
+                char flags[2] = { 0, 0 };
+
+                if (route->flags & MULTI_ROUTE_CACHE)
+                {
+                    flags[0] = 'C';
+                }
+                status_printf(so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u", sep,
+                              mroute_addr_print(ma, &gc), flags, sep,
+                              tls_common_name(mi->context.c2.tls_multi, false), sep,
+                              mroute_addr_print(&mi->real, &gc), sep,
+                              time_string(route->last_reference, 0, false, &gc), sep,
+                              (unsigned int)route->last_reference);
+            }
+            gc_free(&gc);
         }
+        hash_iterator_free(&hi);
+
+        if (m->mbuf)
+        {
+            status_printf(so, "GLOBAL_STATS%cMax bcast/mcast queue length%c%d", sep, sep,
+                          mbuf_maximum_queued(m->mbuf));
+        }
+
+        status_printf(so, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep,
+                      dco_enabled(&m->top.options));
+        status_printf(so, "END");
+    }
+    else
+    {
+        status_printf(so, "ERROR: bad status format version number");
+    }
 
 #ifdef PACKET_TRUNCATION_CHECK
+    {
+        status_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
+        hash_iterator_init(m->hash, &hi);
+        while ((he = hash_iterator_next(&hi)))
         {
-            status_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
-            hash_iterator_init(m->hash, &hi);
-            while ((he = hash_iterator_next(&hi)))
-            {
-                struct gc_arena gc = gc_new();
-                const struct multi_instance *mi = (struct multi_instance *)he->value;
+            struct gc_arena gc = gc_new();
+            const struct multi_instance *mi = (struct multi_instance *)he->value;
 
-                if (!mi->halt)
-                {
-                    status_printf(so,
-                                  "ERRORS,%s," counter_format "," counter_format "," counter_format
-                                  "," counter_format,
-                                  tls_common_name(mi->context.c2.tls_multi, false),
-                                  m->top.c2.n_trunc_tun_read, mi->context.c2.n_trunc_tun_write,
-                                  mi->context.c2.n_trunc_pre_encrypt,
-                                  mi->context.c2.n_trunc_post_decrypt);
-                }
-                gc_free(&gc);
+            if (!mi->halt)
+            {
+                status_printf(so,
+                              "ERRORS,%s," counter_format "," counter_format "," counter_format
+                              "," counter_format,
+                              tls_common_name(mi->context.c2.tls_multi, false),
+                              m->top.c2.n_trunc_tun_read, mi->context.c2.n_trunc_tun_write,
+                              mi->context.c2.n_trunc_pre_encrypt,
+                              mi->context.c2.n_trunc_post_decrypt);
             }
-            hash_iterator_free(&hi);
+            gc_free(&gc);
         }
+        hash_iterator_free(&hi);
+    }
 #endif /* ifdef PACKET_TRUNCATION_CHECK */
 
-        status_flush(so);
-        gc_free(&gc_top);
-    }
+    status_flush(so);
+    gc_free(&gc_top);
 
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_watchers)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
