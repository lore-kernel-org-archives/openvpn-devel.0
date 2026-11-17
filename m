Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E3E606ABA4
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MJhzPj9G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GAY6+VtO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R68oSlkW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BHGstZADL8Emo0uQPYoXVABvPtT4vJhGiDkG2+jCPAY=; b=MJhzPj9G4cFZx1
	W5Bf/SCEghBr6E+fNdvPKjGYh4X/mCQiPq7ntTl/qHl9Rcpqj56y3Em5YujWuGoz+32E4xXJq512L
	E0/pEvbDPVQxvKUxNb0/gdNaQiUMWbqU2xf75b715H4QPpvVLF0vMTUq9jkH8jdApSj9NBDSLHcbW
	ARA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKIO-000000003rm-3gFc;
	Tue, 17 Nov 2026 14:36:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTKIN-000000003rX-0QLj for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zl7RayW0viicpT24LlEvQi1ZA6yrYSLum9Mm2FxerIk=; b=GAY6+VtONWqFl2/2nEOjb1vDtx
 BYxKkZG/MJiWQ720kBS2D/4sokNr5fguKNfGZodYNhNgCw+xqiE4w7kv/VgUjKQs50cUNnXQXr8BD
 zz+f/SLtXbGMOEaUg8gOcf+MbZ3YWTr2UbKMIllD+b72mrbgl9FaCBwRRyROPhHu0NuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zl7RayW0viicpT24LlEvQi1ZA6yrYSLum9Mm2FxerIk=; b=R68oSlkWV/w45YYdUSRndFdWrq
 dGlZweSOwTCFBlRByScw5vfZ3VtHt9+mRpgY7BIhsyLPheoGH2fvFnOLZp3Az4HyunDrwsVcIwSkM
 38Gk3euGOfPe6d5LEtbdFltcPU1FjzvOtqOeGHv6S8uk2chBe4b3sj2uFjB638lbQTnQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTKIL-000000000B0-0Eif for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:36:27 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHEaIjm025106
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 15:36:18 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHEaIBu025105
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 15:36:18 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 15:36:12 +0100
Message-ID: <20261117143617.25095-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTKIL-000000000B0-0Eif
Subject: [Openvpn-devel] [PATCH v2] options: drop impossible out-of-memory
 branches
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

From: Razvan Cojocaru <razvanc@mailbox.org>

gc_realloc() aborts via check_malloc_return() and never returns NULL.
Remove the NULL handling from alloc_{local,connection,remote}_entry(),
their now unused msglevel parameter, and the callers' checks.

Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2196
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2196
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1d8bb2a..de6efdf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1377,7 +1377,7 @@
 }
 
 static struct local_entry *
-alloc_local_entry(struct connection_entry *ce, const msglvl_t msglevel, struct gc_arena *gc)
+alloc_local_entry(struct connection_entry *ce, struct gc_arena *gc)
 {
     struct local_list *l = alloc_local_list_if_undef(ce, gc);
     struct local_entry *e;
@@ -1387,16 +1387,7 @@
         const int new_cap = l->capacity + 1;
         const size_t elem_size = sizeof(*l->array);
 
-        struct local_entry **new_array = gc_realloc(l->array, new_cap * elem_size, gc);
-        if (!new_array)
-        {
-            msg(msglevel,
-                "Unable to process more local options: out of memory. Number of entries = %d",
-                l->len);
-            return NULL;
-        }
-
-        l->array = new_array;
+        l->array = gc_realloc(l->array, new_cap * elem_size, gc);
         l->capacity = new_cap;
     }
 
@@ -1418,7 +1409,7 @@
 }
 
 static struct connection_entry *
-alloc_connection_entry(struct options *options, const msglvl_t msglevel)
+alloc_connection_entry(struct options *options)
 {
     struct connection_list *l = alloc_connection_list_if_undef(options);
     struct connection_entry *e;
@@ -1426,16 +1417,7 @@
     if (l->len == l->capacity)
     {
         int capacity = l->capacity + CONNECTION_LIST_SIZE;
-        struct connection_entry **ce =
-            gc_realloc(l->array, capacity * sizeof(struct connection_entry *), &options->gc);
-        if (ce == NULL)
-        {
-            msg(msglevel,
-                "Unable to process more connection options: out of memory. Number of entries = %d",
-                l->len);
-            return NULL;
-        }
-        l->array = ce;
+        l->array = gc_realloc(l->array, capacity * sizeof(struct connection_entry *), &options->gc);
         l->capacity = capacity;
     }
     ALLOC_OBJ_GC(e, struct connection_entry, &options->gc);
@@ -1454,7 +1436,7 @@
 }
 
 static struct remote_entry *
-alloc_remote_entry(struct options *options, const msglvl_t msglevel)
+alloc_remote_entry(struct options *options)
 {
     struct remote_list *l = alloc_remote_list_if_undef(options);
     struct remote_entry *e;
@@ -1462,16 +1444,7 @@
     if (l->len == l->capacity)
     {
         int capacity = l->capacity + CONNECTION_LIST_SIZE;
-        struct remote_entry **re =
-            gc_realloc(l->array, capacity * sizeof(struct remote_entry *), &options->gc);
-        if (re == NULL)
-        {
-            msg(msglevel,
-                "Unable to process more remote options: out of memory. Number of entries = %d",
-                l->len);
-            return NULL;
-        }
-        l->array = re;
+        l->array = gc_realloc(l->array, capacity * sizeof(struct remote_entry *), &options->gc);
         l->capacity = capacity;
     }
     ALLOC_OBJ_GC(e, struct remote_entry, &options->gc);
@@ -3069,20 +3042,16 @@
         {
             const struct remote_entry *re = rl->array[i];
             struct connection_entry ce = o->ce;
-            struct connection_entry *ace;
 
             ASSERT(re->remote);
             connection_entry_load_re(&ce, re);
-            ace = alloc_connection_entry(o, M_USAGE);
-            ASSERT(ace);
+            struct connection_entry *ace = alloc_connection_entry(o);
             *ace = ce;
         }
     }
     else if (!o->remote_list && !o->connection_list)
     {
-        struct connection_entry *ace;
-        ace = alloc_connection_entry(o, M_USAGE);
-        ASSERT(ace);
+        struct connection_entry *ace = alloc_connection_entry(o);
         *ace = o->ce;
     }
 
@@ -3115,8 +3084,7 @@
     {
         /* if no 'local' directive was specified, convert the global port
          * setting to a listen entry */
-        struct local_entry *e = alloc_local_entry(&o->ce, M_USAGE, &o->gc);
-        ASSERT(e);
+        struct local_entry *e = alloc_local_entry(&o->ce, &o->gc);
         e->port = o->ce.local_port;
         e->proto = o->ce.proto;
     }
@@ -4486,12 +4454,9 @@
     }
     else if (streq(p[0], "local") && p[1] && !p[4])
     {
-        struct local_entry *e;
-
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
 
-        e = alloc_local_entry(&options->ce, M_USAGE, &options->gc);
-        ASSERT(e);
+        struct local_entry *e = alloc_local_entry(&options->ce, &options->gc);
 
         /* '*' is treated as 'ask the system to get some socket',
          * therefore force binding on a particular address only when
@@ -4522,7 +4487,6 @@
         if (is_inline)
         {
             struct options sub;
-            struct connection_entry *e;
 
             init_options(&sub);
             sub.ce = options->ce;
@@ -4536,12 +4500,7 @@
                 goto err;
             }
 
-            e = alloc_connection_entry(options, msglevel);
-            if (!e)
-            {
-                uninit_options(&sub);
-                goto err;
-            }
+            struct connection_entry *e = alloc_connection_entry(options);
             *e = sub.ce;
             gc_transfer(&options->gc, &sub.gc);
             uninit_options(&sub);
@@ -4630,11 +4589,7 @@
         }
         if (permission_mask & OPT_P_GENERAL)
         {
-            struct remote_entry *e = alloc_remote_entry(options, msglevel);
-            if (!e)
-            {
-                goto err;
-            }
+            struct remote_entry *e = alloc_remote_entry(options);
             *e = re;
         }
         else if (permission_mask & OPT_P_CONNECTION)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
