Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFA606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l5etA1e6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WT8RN7xn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VQ9WevLh;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=n7Yc/X5G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MJB6whLGufjdjC+/5Mkw6bZVvvZRKJH5sSHdUU5nHlM=; b=l5etA1e68HD0O8
	uqdIwMoZz12LCxez7l138RbhJ1/OpMcpL4T2uQr09ma022DowB7+qIAJFl1S717nEklzyFhsa5DwS
	dei6ksp4XZUJWhIaC4Cu8kg5fkc8FM5ArACfvLtgajbu+ic+2auI3IqarKrVA3MUEgmaylmY83u+L
	r4s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWbCR-000000007H7-2z23;
	Thu, 26 Nov 2026 15:15:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWbCO-000000007Gl-26Kp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JAAOeM4yhAAFzqs5RnbFYA5UAvmr7w2WFlTxu1tVPzI=; b=WT8RN7xnz83zuK3B4k+qG12u4c
 snTdeoAzwGcEMZAB6alOAsAPiN24EA11gPcTM68Zx/ad2B+nX4fmrS9s8RLGGtT2J2vm93BLU6WOY
 p4Ao0sRAhAe8JqHhIIXem6UK88s3mkkO+7bw1EAE/M/s6GrIwhhhr8+1YSzqxTyqpstM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JAAOeM4yhAAFzqs5RnbFYA5UAvmr7w2WFlTxu1tVPzI=; b=VQ9WevLh1HZ9/Sb8qfSEbgvay3
 vl6HWHH7X1h2/CZUZAhK1hvDUKoFbsx2lxgNuAvUCtatyi0jS2HlsiQ8sBHzY9g/B3BEnUqklSn71
 qB8ttg1siZGrYMhc74OdYGiUXCC7ya7eUYmEorFA1GM006X5/r+L0E1nUlHX3jK/aWf4=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWbCM-000000002ac-2PLp for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:48 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jb0VK51VmzFqcZ
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 16:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795706137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAAOeM4yhAAFzqs5RnbFYA5UAvmr7w2WFlTxu1tVPzI=;
 b=n7Yc/X5GYuaqSBVsH5sAjMYgRnaIGO+K4Ne45UkAx5J6a04nfH2RybYKmQ18fEKgqY3a6q
 TTYM7u/0fGGoNbs6CWIsSc5tliq3WRBAEgrVZ1s8Nj4e8ilg5INV/OvyOsyEqmFMtpswMJ
 2olzxjjkKuIEmwyG7jXWumrQb/VckCA4Vtq8rvs/uvhQE4xbmwB9U0N4L2MqpcNu8cUw9j
 d04mo3Xo0MeXn5wy9A9YqMto06MmKbQfE1JJuDBDzCRGsKRjymRU5i6TCL6FnWr+wokloU
 CXFa5Ws+77yr2wfDwxB/0AMDB2Uq0+TTRo4NRrxhR6Mn2UMFkEl01nZoo4NDBQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 16:15:23 +0100
Message-ID: <23e0c4d292f834bdf1efc5bb14ee20519409a61a.1795704654.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795704654.git.ralf@mandelbit.com>
References: <cover.1795704654.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jb0VK51VmzFqcZ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWbCM-000000002ac-2PLp
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/3] ovpn: use the right RCU
 primitive in ovpn_crypto_kill_key
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

The kdoc for rcu_access_pointer says it is meant for cases where the
pointer value is used but not dereferenced, that
rcu_dereference_protected should be used when update-side locks prevent
the pointer from changing, and that assigning the rcu_access_pointer
return value to a local variable "results in an accident waiting to
happen".

Swap rcu_access_pointer with rcu_dereference_protected in
ovpn_crypto_kill_key, adopting the same pattern of
ovpn_crypto_key_slots_swap.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809212142.2249027-1-antonio%40openvpn.net?part=1
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 7e545428900a..cec39147e011 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -54,10 +54,12 @@ bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
 	int slot = 0;
 
 	spin_lock_bh(&cs->lock);
-	tmp = rcu_access_pointer(cs->slots[slot]);
+	tmp = rcu_dereference_protected(cs->slots[slot],
+					lockdep_is_held(&cs->lock));
 	if (!tmp || tmp->key_id != key_id) {
 		slot = 1;
-		tmp = rcu_access_pointer(cs->slots[slot]);
+		tmp = rcu_dereference_protected(cs->slots[slot],
+						lockdep_is_held(&cs->lock));
 	}
 
 	if (tmp && tmp->key_id == key_id)
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
