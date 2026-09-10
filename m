Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F832C79F9F
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xzJ8ofBJ/dR8h9PD4hcAcMYR5UceRncvQcQdXmJh7s=; b=fa0CMqcgfMreiswmkbc4xUyPDY
	5trSzzZ29xJciMBP6e6pzb/w3vlRDek3baQq+CaL7R6x6yhtjUtq2Nzz53KjKcjVhenoVlaTHWllo
	HbacWFvQ7bkYWCqb9m6dE4xnWvW3ywZQ5Ez5gqxd0KO/VHIzWXo6aFBE2zPu/DbgYfSU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4aUQ-0001NO-9Z;
	Thu, 10 Sep 2026 08:50:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x4aUP-0001ND-99
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kLrs6rMnZpNaIJSZy54UOAxUNZITQCRW0CV/YzDrPZE=; b=AVPmsiIHzKIS0sk+qOCBqKlHUG
 d0n90A1YdPwAEDLUgd3zM5B1/X4zwGQMRmeEQOzb4RKP+0r+RMscqPgzP0Y+0fobBspag71WptBbQ
 lbZKT8ncHWuxmqjUKNHoMM/K8TFz+eZ9/8lq+1hNDQ12Dkweq/s/6l+9dXkWBgJNfazg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kLrs6rMnZpNaIJSZy54UOAxUNZITQCRW0CV/YzDrPZE=; b=HRyRzG/omuR03P5N4GdbUNKKm4
 KI7DKzVmWscCLot5TaQYMB+2EEnnyLl2SG4EsttXCJym1ZhnkTZuH/zobs0ulMwNtFyB4JTXyCfwe
 wC/zbV9OwsYAP6RSOqrlRfmE4aZTuPMDpR+7BDdEKQSdXXW9D0fVHh8yIACTSFajctkI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4aUN-0001hq-VE for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:50:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68A8oSIh030745
 for <openvpn-devel@lists.sourceforge.net>; Thu, 10 Sep 2026 10:50:28 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68A8oSxA030743
 for openvpn-devel@lists.sourceforge.net; Thu, 10 Sep 2026 10:50:28 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 10 Sep 2026 10:50:22 +0200
Message-ID: <20260910085028.30710-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
References: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x4aUN-0001hq-VE
Subject: [Openvpn-devel] [PATCH v3] Avoid unbounded reliable TLS timeout
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Arne Schwabe <arne@rfc2549.org>

Avoid an unbounded TLS retransmit timeout, which could potentially
trigger an integer overflow.

The maximum initial timeout is defined in reliable.h and used to
constrain --tls-timeout, so that the relation between the option range
and RELIABLE_MAX_TIMEOUT_SHIFT is explicit and checked at compile time.

Github: OpenVPN/openvpn-private-issues#161
Reported-By: Mark Bregman (Fox-IT) <mark.bregman@fox-it.com>
CVE: 2026-84732
Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1908
Acked-by: MaxF <max@max-fillinger.net>
(cherry picked from commit 207ac5f47e46565881dcec385020ebdcb682caa4)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1908
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9344f99..56041bb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -9180,6 +9180,15 @@
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
         options->tls_timeout = positive_atoi(p[1]);
+        /* Constrain the timeout to not have problems with
+         * RELIABLE_MAX_TIMEOUT_SHIFT creating an overflow. 65k seconds
+         * timeout is already way too much anyway */
+        if (options->tls_timeout < 1 || options->tls_timeout > RELIABLE_MAX_INITIAL_TIMEOUT)
+        {
+            msg(msglevel, "tls_timeout: Must be an integer between %d and %d, not %d",
+                1, RELIABLE_MAX_INITIAL_TIMEOUT, options->tls_timeout);
+            goto err;
+        }
     }
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index c2b9439..babe4c8 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -683,11 +683,22 @@
             }
         }
     }
+
     if (best)
     {
+        /* The initial timeout is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so
+         * shifting it cannot overflow. */
+        static_assert(RELIABLE_MAX_INITIAL_TIMEOUT <= (INT_MAX >> RELIABLE_MAX_TIMEOUT_SHIFT),
+                      "initial reliable timeout overflows when shifted");
+        const interval_t max_timeout = rel->initial_timeout << RELIABLE_MAX_TIMEOUT_SHIFT;
+
         /* exponential backoff */
         best->next_try = local_now + best->timeout;
-        best->timeout *= 2;
+        if (best->timeout < max_timeout)
+        {
+            best->timeout *= 2;
+        }
+
         best->n_acks = 0;
         *opcode = best->opcode;
         dmsg(D_REL_DEBUG, "ACK reliable_send ID " packet_id_format " (size=%d to=%d)",
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 766c07d..5877f20 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -41,18 +41,32 @@
  *  @{ */
 
 
-#define RELIABLE_ACK_SIZE 8     /**< The maximum number of packet IDs
-                                 *   waiting to be acknowledged which can
-                                 *   be stored in one \c reliable_ack
-                                 *   structure. */
+#define RELIABLE_ACK_SIZE 8
+/**< The maximum number of packet IDs
+ *   waiting to be acknowledged which can
+ *   be stored in one \c reliable_ack
+ *   structure. */
 
-#define RELIABLE_CAPACITY 12    /**< The maximum number of packets that
-                                 *   the reliability layer for one VPN
-                                 *   tunnel in one direction can store. */
+#define RELIABLE_CAPACITY 12
+/**< The maximum number of packets that
+ *   the reliability layer for one VPN
+ *   tunnel in one direction can store. */
 
-#define N_ACK_RETRANSMIT 3      /**< We retry sending a packet early if
-                                 *   this many later packets have been
-                                 *   ACKed. */
+#define N_ACK_RETRANSMIT 3
+/**< We retry sending a packet early if
+ *   this many later packets have been
+ *   ACKed. */
+
+#define RELIABLE_MAX_TIMEOUT_SHIFT 6
+/**< Maximum shift or doubling in exponential backoff
+ * we allow. This is a safeguard against an unbounded
+ * exponential backoff. With the default timeout of 2s this
+ * equals 128s */
+
+#define RELIABLE_MAX_INITIAL_TIMEOUT (1 << 16)
+/**< Maximum initial timeout (--tls-timeout) we accept.
+ * Bounded so that shifting it by RELIABLE_MAX_TIMEOUT_SHIFT
+ * cannot overflow an int. */
 
 /**
  * The acknowledgment structure in which packet IDs are stored for later


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
