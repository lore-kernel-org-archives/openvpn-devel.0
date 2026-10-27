Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA310606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gFDkr+xH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a2nnaoGC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mZeE8Sgs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aBqhicanApuvAQJIquQnlmSzb2hGZ7JRcyh1OClIjps=; b=gFDkr+xHFdO5qh
	4KwngpolGAtNhQPBzWOWTRHRcwh4A4WycwKxTxNEpn8iUNcTIxch8bNAi1QToRSjNP3jme2autjgD
	/v5p3sFVRe7OiPJdSUJ1KFa4hvhrS0P7mVjDZBVpumoe5+sau9JJf5IlvIMbB2J6IG4WYi9nTC4G7
	qCE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeLD-000000004RH-1mec;
	Tue, 27 Oct 2026 10:23:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLeLB-000000004RA-33gI for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WQvyUFX1aX1DCmz9ltV6ASovzI/RHI6eWiHR/v1fxuA=; b=a2nnaoGCIHooFtSq7m8GIDLr3+
 26P3YnWIVqqPHvGXrq2I+dtypMfDrafPMFGTXLIDiugh8IlzzjF/+dKFyon8RnEJ2VXNGYISdzedW
 B5U90cbs/DX1SLW1G5IascHp/xswmxwtqoYMZD0NEJUmUAS+Y2wdegyP7guqRu8IvpuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WQvyUFX1aX1DCmz9ltV6ASovzI/RHI6eWiHR/v1fxuA=; b=mZeE8SgsaJKIU1vJp3A3n/NBs0
 27Bm6vNx6NFqr5B5afEqT4Bm97Sf1+W4Y9cbmfJnU9cWpdV39vrFL/Gz9QIa9LTiGsf1I6jhFulh9
 ek0ujhhggNGWSbKaqs1vfY1OYQh9I+abCJ/7wDzvdq2vFV9BJEpPo5mGrEcc2dMaHUW0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLeL7-000000002F5-1eTg for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:23:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69RANQsH019461
 for <openvpn-devel@lists.sourceforge.net>; Tue, 27 Oct 2026 11:23:26 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69RANQih019460
 for openvpn-devel@lists.sourceforge.net; Tue, 27 Oct 2026 11:23:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 27 Oct 2026 11:23:20 +0100
Message-ID: <20261027102325.19448-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
References: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLeL7-000000002F5-1eTg
Subject: [Openvpn-devel] [PATCH v1] multi_io: move the tun write functions
 to multi_io.c
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

multi_process_outgoing_tun() lived as a static inline in multi.h and
multi_process_drop_outgoing_tun() in multi.c, while their only caller
is multi_io_dispatch(). Move both next to it, as static functions named
multi_io_write_tun() and multi_io_drop_tun(), so that writing to the
tun device is found where the state machine decides to do it.

No functional change.

Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2042
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2042
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e302a81..2e804ff 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3766,27 +3766,6 @@
 }
 
 /*
- * Drop a TUN/TAP outgoing packet..
- */
-void
-multi_process_drop_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags)
-{
-    struct multi_instance *mi = m->pending;
-
-    ASSERT(mi);
-
-    set_prefix(mi);
-
-    msg(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue full, dropped packet len=%d",
-        mi->context.c2.to_tun.len);
-
-    buf_reset(&mi->context.c2.to_tun);
-
-    multi_process_post(m, mi, mpp_flags);
-    clear_prefix();
-}
-
-/*
  * Per-client route quota management
  */
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 5db7147..2d4983c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -295,7 +295,7 @@
  * function controls the necessary postprocessing.  It is called by many
  * other functions that handle VPN tunnel related activity, such as \c
  * multi_process_incoming_link(), \c multi_process_outgoing_link(), \c
- * multi_process_incoming_tun(), \c multi_process_outgoing_tun(), and \c
+ * multi_process_incoming_tun(), \c multi_io_write_tun(), and \c
  * multi_process_timeout(), among others.
  *
  * @param m            - The single \c multi_context structure.
@@ -364,8 +364,6 @@
 bool multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags);
 
 
-void multi_process_drop_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags);
-
 struct multi_instance *multi_get_queue(struct mbuf_set *ms);
 
 void multi_ifconfig_pool_persist(struct multi_context *m, bool force);
@@ -627,41 +625,6 @@
 }
 
 
-/**
- * Send a packet over the virtual tun/tap network interface to its locally
- * reachable destination.
- * @ingroup internal_multiplexer
- *
- * This function calls \c process_outgoing_tun() to perform the actual
- * sending of the packet.  Afterwards, it calls \c multi_process_post() to
- * perform server-mode postprocessing.
- *
- * @param m            - The single \c multi_context structure.
- * @param mpp_flags    - Fast I/O optimization flags.
- *
- * @return
- *  - True, if the \c multi_instance associated with the packet sent was
- *    not closed due to a signal during processing.
- *  - Falls, if the \c multi_instance was closed.
- */
-static inline bool
-multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags)
-{
-    struct multi_instance *mi = m->pending;
-    bool ret = true;
-
-    ASSERT(mi);
-#ifdef MULTI_DEBUG_EVENT_LOOP
-    printf("%s -> TUN len=%d\n", id(mi), mi->context.c2.to_tun.len);
-#endif
-    set_prefix(mi);
-    vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
-    ret = multi_process_post(m, mi, mpp_flags);
-    clear_prefix();
-    return ret;
-}
-
 #define CLIENT_CONNECT_OPT_MASK                                                            \
     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \
      | OPT_P_COMP | OPT_P_SOCKFLAGS)
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index ebee86c..164b214 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -290,6 +290,62 @@
     }
 }
 
+/**
+ * Send a packet over the virtual tun/tap network interface to its locally
+ * reachable destination.
+ * @ingroup internal_multiplexer
+ *
+ * This function calls \c process_outgoing_tun() to perform the actual
+ * sending of the packet.  Afterwards, it calls \c multi_process_post() to
+ * perform server-mode postprocessing.
+ *
+ * @param m            - The single \c multi_context structure.
+ * @param mpp_flags    - Fast I/O optimization flags.
+ *
+ * @return
+ *  - True, if the \c multi_instance associated with the packet sent was
+ *    not closed due to a signal during processing.
+ *  - Falls, if the \c multi_instance was closed.
+ */
+static bool
+multi_io_write_tun(struct multi_context *m, const unsigned int mpp_flags)
+{
+    struct multi_instance *mi = m->pending;
+    bool ret = true;
+
+    ASSERT(mi);
+#ifdef MULTI_DEBUG_EVENT_LOOP
+    printf("%s -> TUN len=%d\n", id(mi), mi->context.c2.to_tun.len);
+#endif
+    set_prefix(mi);
+    vlan_process_outgoing_tun(m, mi);
+    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
+    ret = multi_process_post(m, mi, mpp_flags);
+    clear_prefix();
+    return ret;
+}
+
+/*
+ * Drop a TUN/TAP outgoing packet..
+ */
+static void
+multi_io_drop_tun(struct multi_context *m, const unsigned int mpp_flags)
+{
+    struct multi_instance *mi = m->pending;
+
+    ASSERT(mi);
+
+    set_prefix(mi);
+
+    msg(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue full, dropped packet len=%d",
+        mi->context.c2.to_tun.len);
+
+    buf_reset(&mi->context.c2.to_tun);
+
+    multi_process_post(m, mi, mpp_flags);
+    clear_prefix();
+}
+
 static struct multi_instance *
 multi_io_dispatch(struct multi_context *m, struct multi_instance *mi, const int action)
 {
@@ -334,11 +390,11 @@
             break;
 
         case TA_TUN_WRITE:
-            multi_process_outgoing_tun(m, mpp_flags);
+            multi_io_write_tun(m, mpp_flags);
             break;
 
         case TA_TUN_WRITE_TIMEOUT:
-            multi_process_drop_outgoing_tun(m, mpp_flags);
+            multi_io_drop_tun(m, mpp_flags);
             break;
 
         case TA_SOCKET_WRITE_READY:


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
