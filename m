Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92E606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N8NHQonM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ad/+Hysy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jpEY50wA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=043+iVBC1aTq3ibMS738qc22CNH952eWeGEaxYupn/4=; b=N8NHQonMjacIQ8
	j3nnWAsa6o0eITbNa1bNYN1agugDKEKqzwVcRM4+SSyBYyJHmhdYBcqJG+R14UliIDqY2kpH68tXQ
	KxIWc/+PZmKf5B9fdhL5v/lQ/FjVnDWCanwx7iqb0JPcE+5FqZ4zmkKFy49m1m17ir7aavP/1ysL8
	4n4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODoQ-000000000vs-20bG;
	Tue, 03 Nov 2026 12:40:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xODoN-000000000vj-2R1g for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JMQnVYSjeX09C6XiR0Qlm7v1X82CwT4fN4Erv3zpAfo=; b=Ad/+Hysy2AuvfQKLPeSlcQq/kc
 QEHMeeVzUVdCBZ0wwmn/LClqrK1GyAPDh3bPXx/K18VbVO890kZwD3YN2DoCdNawYl3uG7IPwjFt7
 K/bs1fERZzp9jPAG7dCAVYbhhwGzbBr3oxlosHiYIk4hWgqMZKkpYiF5Ufbll5bAj1zo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JMQnVYSjeX09C6XiR0Qlm7v1X82CwT4fN4Erv3zpAfo=; b=jpEY50wA1GOk7xbHXF6ZRKqj6Y
 2a7yA7a7gvcwMcJBF226jzYg39typiyto9E5c63+AW6XDbucT+dS8p0JByIRuIzfPqySKvGxRi53c
 MRG21CpnAQs3KxaopxXtm2Ra80W6QAjkzKSPFUfCCT97aT3x+SwdvYo+LUzqK1ZuvPJ4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xODoK-000000003l6-03nG for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:40:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3CeDNh004684
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 13:40:13 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3CeD4m004683
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 13:40:13 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 13:40:07 +0100
Message-ID: <20261103124012.4642-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
References: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xODoK-000000003l6-03nG
Subject: [Openvpn-devel] [PATCH v1] crypto_epoch: wipe key material with
 secure_memzero()
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

CLEAR() is a plain memset(), which the compiler may drop for stack
variables that are not read afterwards. Use secure_memzero() for the
derived send/recv data keys and the epoch keys freed in
free_epoch_key_ctx().

Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2103
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2103
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 69a1852..35f9b55 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -181,7 +181,7 @@
 
     init_key_bi_ctx_send(&co->key_ctx_bi.encrypt, &send_key, &co->epoch_key_type, name);
     reset_packet_id_send(&co->packet_id.send);
-    CLEAR(send_key);
+    secure_memzero(&send_key, sizeof(send_key));
 }
 
 
@@ -196,7 +196,7 @@
     snprintf(name, sizeof(name), "Epoch Data key %" PRIu16, co->epoch_key_recv.epoch);
 
     init_key_bi_ctx_recv(ctx, &recv_key, &co->epoch_key_type, name);
-    CLEAR(recv_key);
+    secure_memzero(&recv_key, sizeof(recv_key));
 }
 
 void
@@ -346,8 +346,8 @@
     free(co->epoch_data_keys_future);
     free_key_ctx(&co->epoch_retiring_data_receive_key);
     free(co->epoch_retiring_key_pid_recv.seq_list);
-    CLEAR(co->epoch_key_recv);
-    CLEAR(co->epoch_key_send);
+    secure_memzero(&co->epoch_key_recv, sizeof(co->epoch_key_recv));
+    secure_memzero(&co->epoch_key_send, sizeof(co->epoch_key_send));
 }
 
 void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
