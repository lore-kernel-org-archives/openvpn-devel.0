Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1D606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SvnA76jc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ibo/zsIg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AT0+o/i+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KzTa4FLeM/ed0nJr1SkpSVSdORJnX+2ZIByg0bDlGww=; b=SvnA76jcAVTEYP
	72ezPeSBM4CphIxkq6sLymqR1KTyaKg5pEsJ7wv7kuASNzbtaATATkVRPXE2s3TFRLKq4+gjQkUEU
	fruJ3Rm2KZWx/D1Jqs84ACNM1xm8Gnr861UscML3sxsmxfV/nGlz4EFED6p7iQI11wyfW6j7lr+7Z
	cb4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWWI-000000005Uo-0J6c;
	Thu, 26 Nov 2026 10:16:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWWWG-000000005Ua-3FN8 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XW+J81OShVrSdj5zSvb8x+l5t+RBTwHQmhU4pjWcTOM=; b=Ibo/zsIg2hQlcLRNhwrdap2TL3
 243/85ZCw5O2o4nsPJr2oVsbozzZnOB2N6PaCgUJb9PUFyhzecRpDZ93kXh0teZtxWoCGKotdNK6J
 EUEeRRC/rHzdao4hu4YYz+/tz/5QQAkXdxDqUVip7t6EDu3JDjUU4yRicIGjJYnyt2Ec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XW+J81OShVrSdj5zSvb8x+l5t+RBTwHQmhU4pjWcTOM=; b=AT0+o/i+gybX+87qFga5uTzYhA
 itHvmvGAaHsHKvXYR+VK+h/cvxhd8lOeFW9IA+E3c8MWQZk9FFgpX4qC08iMgnGm8Tlb6vowWyZXh
 cC8u35f1u9cIhkxPwkONLwTqQdGWE27hc8zXnUCFw+OKpoIBD6YFQnYfrdj4tPMM18Qs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWWWD-000000006j9-2vb0 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:16:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQAFomq028795
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 11:15:50 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQAFo3r028794
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 11:15:50 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 11:15:45 +0100
Message-ID: <20261126101550.28784-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795687157000.Ic667de6f830fa86e2842f1da2820e1250b9d6054@gerrit.openvpn.net>
References: <gerrit.1795687157000.Ic667de6f830fa86e2842f1da2820e1250b9d6054@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWWWD-000000006j9-2vb0
Subject: [Openvpn-devel] [PATCH v1] multi: call client-disconnect handlers
 when late client setup fails
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

From: Farshid Rezaiyan <farshidrezaiyan@gmail.com>

multi_client_connect_late_setup() is only reached after all
client-connect handlers (scripts and plugins) have succeeded. It sets
the state to CAS_CONNECT_DONE and then downgrades it to CAS_FAILED if
setting the protocol options, adding the DCO peer or generating the
data channel keys fails.

multi_close_instance() only calls the client-disconnect handlers for
instances in state CAS_CONNECT_DONE, so for such a client the
client-connect handlers have run but client-disconnect never does.
Anything that pairs the two calls gets out of sync. For example, a
RADIUS accounting plugin that sends Accounting-Start on connect and
Accounting-Stop on disconnect keeps the session open forever.

This is easy to hit with DCO on Linux and TCP: if the client closes
the TCP connection while a client-connect handler is running, the
kernel refuses to attach the socket ("provided TCP socket is not in
ESTABLISHED state") and dco_multi_add_new_peer() fails.

Remember in the new did_client_connect flag that a client-connect
plugin or script was called with success. This is the case if one is
defined, because multi_client_connect_late_setup() is only reached
when all client-connect handlers have succeeded.
multi_close_instance() then also calls the disconnect handlers for an
instance in CAS_FAILED that has this flag set. So they run on instance
shutdown and exactly once, as for any other client, and only after a
successful client-connect.

GitHub: closes OpenVPN/openvpn#1155
Change-Id: Ic667de6f830fa86e2842f1da2820e1250b9d6054
Signed-off-by: Farshid Rezaiyan <farshidrezaiyan@gmail.com>
Acked-by: Ralf Lici <ralf@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2350
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2350
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@mandelbit.com>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 900b5a3..706195a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -718,7 +718,10 @@
     set_cc_config(mi, NULL);
 #endif
 
-    if (mi->context.c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
+    /* A client that failed in multi_client_connect_late_setup() is in
+     * CAS_FAILED, but its client-connect handlers did succeed */
+    if (mi->context.c2.tls_multi->multi_state >= CAS_CONNECT_DONE
+        || (mi->did_client_connect && mi->context.c2.tls_multi->multi_state == CAS_FAILED))
     {
         multi_client_disconnect_script(mi);
     }
@@ -2414,6 +2417,15 @@
     /* set context-level authentication flag */
     mi->context.c2.tls_multi->multi_state = CAS_CONNECT_DONE;
 
+    /* We only get here if all client-connect handlers succeeded, so a
+     * defined client-connect plugin or script has been called with
+     * success. Remember this, as the steps below may still set
+     * CAS_FAILED, and the client-disconnect handlers must then be called
+     * when the instance is closed. */
+    mi->did_client_connect = plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT)
+                             || plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
+                             || mi->context.options.client_connect_script != NULL;
+
     /* Since dco-win maintains iroute routing table (subnet -> peer),
      * peer must be added before iroutes. For other platforms it doesn't matter. */
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3d2e932..9cc986c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -145,6 +145,9 @@
     struct buffer_list *cc_config;
 #endif
     bool did_iroutes;
+    /** a client-connect plugin or script was called and succeeded, so
+     * client-disconnect must be called when the instance is closed */
+    bool did_client_connect;
     int n_clients_delta;    /* added to multi_context.n_clients when instance is closed */
 
     struct context context; /**< The context structure storing state


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
