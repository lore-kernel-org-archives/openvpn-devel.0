Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA167606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RWPTnSrs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DnI2RJWs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f17xZrwW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UlfGb+g6ti/YP8MXYG4xN/eNh3nqE/hP2YxbQUIIZAo=; b=RWPTnSrsJBDXmC
	0zZWxOMt+1AqnJhDWPOL+qFbqW/cUhndaZtBN1mWBSsxH8fULzi6At/DIbl3ZtP//OSD+aiUB8QiO
	0eRBxLmWyIQqVcHIxzu063WRqLYUHRgk1zVbSa9+gPPMiK42UgZhywXdUiSNHWDrw7pr7goEr1+JB
	kik=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ4cU-000000002jw-3R4v;
	Sun, 08 Nov 2026 15:15:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQ4cJ-000000002jl-0LeB for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 15:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rUBPC2HwKfvNobk+8y936YTkw2DTxHqW2VQ7F4pFLTM=; b=DnI2RJWsbVuX2GjrOwM3nmFDLi
 Wk93kvDKy66i12ATzuhL6HiTwq/ygCWj1cu4Oe/bgfZJDdplRjkrpbkZGBmp8LejO9cENvmISyD2g
 6PCXGFw0g/JQuN90TU2qzPJxQ0Iz4CGscGAzJf1UMeJxj1r4yTVXdN3+kry4qkZuwYUY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rUBPC2HwKfvNobk+8y936YTkw2DTxHqW2VQ7F4pFLTM=; b=f17xZrwWYutFgzh4MnrMEPHijo
 iQ3/XgRPQ30XSIuAUvwWzTgVaUlU4+Gh6snQv0Huhwy+76fk8hu1ytWbXCe/08F+wYW/NLyCpGWRp
 SsEqZQZMUjfi3BMYd0jvE/NB//lNPJZbegWIuo0flIYFFr5IY2/QtUpHT1Lz9Tf+OK7g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQ4cH-000000006BS-1Kjv for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 15:15:35 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A8FFNMY026285
 for <openvpn-devel@lists.sourceforge.net>; Sun, 8 Nov 2026 16:15:23 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A8FFNZV026284
 for openvpn-devel@lists.sourceforge.net; Sun, 8 Nov 2026 16:15:23 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun,  8 Nov 2026 16:15:17 +0100
Message-ID: <20261108151523.26265-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQ4cH-000000006BS-1Kjv
Subject: [Openvpn-devel] [PATCH v6] Adjust ACC_MAX_MSG_LEN,
 fix ACC in p2p mode and improve documentation
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

We do not need to limit the maximum ACC message length to just 1280. Also
improve the comments and documentation to be clearer.

Fix that the management notification about negotiated protocol is not sent
when in p2p mode (or if a server has push-peer-info in its configuration)

Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2130
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2130
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 6c798c0..a98b45f 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -1398,11 +1398,17 @@
     next message should be concatenated to this message to form a complete
     message.
 
-    Note that the OpenVPN implementation operates here with the robustness
-    principle ("be conservative in what you send, be liberal in what you
-    accept" - RFC 793 and others) and allows receiving messages longer than
-    maximum allowed message length. Implementations should be prepared to
-    handle messages that are longer than the maximum allowed message length.
+    Note that fragment is basically a flag for allowing peers communicating
+    over ACC to indicate if multiple ACC messages should be considered to
+    be a single message. If the ACC protocol is a stream based protocol
+    then all messages can be sent without fragment flag.
+
+    Note that the OpenVPN implementation allows receiving messages longer than
+    announced maximum allowed message length. Implementations must be prepared
+    to handle messages that are longer than the maximum allowed message length.
+    Overlong messages are considered invalid and indicate that the peer is
+    misbehaving. Disconnecting/dropping the peer is considered a valid
+    response to such messages.
 
     OpenVPN does not verify that the message is valid base64. A peer that
     sends invalid base64 payload will be passed to the management interface.
diff --git a/src/openvpn/acc.c b/src/openvpn/acc.c
index 455f56d..e9656a6 100644
--- a/src/openvpn/acc.c
+++ b/src/openvpn/acc.c
@@ -190,10 +190,10 @@
     }
 
     /* We do not check the length here. We make no promises to support
-     * anything larger than our announced message length but according to
-     * the robustness principle
-     * ("be conservative in what you send, be liberal in what you accept" - RFC 793 and others)
-     * we accept also longer messages */
+     * anything larger than our announced message length but we accept also
+     * longer messages if they manage to get through all the other layers
+     * that restrict the message size like TLS_CHANNEL_BUF_SIZE.
+     */
 
     int payload_len;
     const char *payload_len_str = buf_extract_field(&buf, ',', &gc);
@@ -426,8 +426,20 @@
     multi->acc_negotiated_protocols = string_alloc(buf_str(&common_protocols), NULL);
     multi->acc_max_message_length = max_acc_len;
 
-    setenv_str(session->opt->es, "acc_protocols", multi->acc_negotiated_protocols);
-    setenv_int(session->opt->es, "acc_message_len", multi->acc_max_message_length);
+    /* The normal case is that this is a server where we notify the client
+     * capabilities via environment variables */
+    if (multi->opt.mode == MODE_SERVER)
+    {
+        setenv_str(session->opt->es, "acc_protocols", multi->acc_negotiated_protocols);
+        setenv_int(session->opt->es, "acc_message_len", multi->acc_max_message_length);
+    }
+    else
+    {
+        /* We can also end up here in p2p or if the server has --push-peer-info
+         * We do not set variables in that case to keep behavior consistent with
+         * the other paths on the client that also do not set variables */
+        notify_client_acc_protocols(multi);
+    }
 
     gc_free(&gc);
 }
diff --git a/src/openvpn/acc.h b/src/openvpn/acc.h
index 9c99b11..d640898 100644
--- a/src/openvpn/acc.h
+++ b/src/openvpn/acc.h
@@ -29,7 +29,9 @@
 #include "openvpn.h"
 
 #define ACC_MIN_MSG_LEN 64
-#define ACC_MAX_MSG_LEN 1280
+/* This is a conservative limit. The theoretical maximum
+ * is much closer to the TLS_CHANNEL_BUF_SIZE */
+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)
 
 /**
  * This method parses an app custom control message and delivers it to the
diff --git a/tests/unit_tests/openvpn/test_acc.c b/tests/unit_tests/openvpn/test_acc.c
index 9364d12..bc103b4 100644
--- a/tests/unit_tests/openvpn/test_acc.c
+++ b/tests/unit_tests/openvpn/test_acc.c
@@ -181,7 +181,11 @@
     int max_len = 0;
     const char *protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
     assert_string_equal(protocols, "flower:happy");
-    assert_int_equal(max_len, 1280);
+
+    /* Check that the ACC_MAX_MSG_LEN is 1920 to ensure that the tests get
+     * adjusted if it changes */
+    assert_int_equal(ACC_MAX_MSG_LEN, 1920);
+    assert_int_equal(max_len, ACC_MAX_MSG_LEN);
 
     /* a client does not accept a length longer than it supports */
     protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
@@ -247,14 +251,15 @@
     multi->opt.acc_protocols = c->options.acc_protocols;
     multi->session[TM_ACTIVE].opt = &multi->opt;
     multi->opt.es = env_set_create(&c->options.gc);
+    multi->opt.mode = MODE_SERVER;
 
     determine_common_acc_protocols(multi, &c->c2.tls_multi->session[TM_ACTIVE]);
 
-    assert_int_equal(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_int_equal(multi->acc_max_message_length, 1400);
     assert_string_equal(multi->acc_negotiated_protocols, "power:flower");
 
     assert_string_equal(env_set_get(multi->opt.es, "acc_protocols"), "acc_protocols=power:flower");
-    assert_string_equal(env_set_get(multi->opt.es, "acc_message_len"), "acc_message_len=1280");
+    assert_string_equal(env_set_get(multi->opt.es, "acc_message_len"), "acc_message_len=1400");
 
     free(multi->acc_negotiated_protocols);
     gc_free(&c->options.gc);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
