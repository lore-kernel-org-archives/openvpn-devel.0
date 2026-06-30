Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E5BC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LcfNEVC6ftA9wkoDUMZoN1p5aDi88ci8RQ8Dy/DqPVw=; b=fG3UHwqy0pqe2G0gfphjOKK03X
	98QdoCFl86ZRySOO4Czw3XnVwuCT1duAInhOCNNSXHJtD0hg4HH+G0qmmIbn05c/l2CI5p4uQXfLB
	ZV5H+TFlpdHX33ZETgq5ITUmckvdVpQQY45RKgfcKB2d1Jd03B8oIhom6vGHl99tm4Ow=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weZLc-00084D-G5;
	Tue, 30 Jun 2026 14:22:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1weZLZ-000846-8w
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 14:21:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nrmq3DTkseE8p34Jg2u8m85y8RNSQpJTpV1EGeex/Ek=; b=EaO27Ht4DEUvdj2PlGaxbQMfOq
 WQFWiySrIEX/W17cjljTgBgWytHAXB5qlXZTYzn+ERg+RX/twy8FAtKY9SGXEJ4Xa9XlijIGYiDGp
 iWF4ZQZWrrnhdUmlGcXo++kUZAnrh85VkspeinALDYGweHQiVz0FjqLBQG35Q8Tlb3qo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Nrmq3DTkseE8p34Jg2u8m85y8RNSQpJTpV1EGeex/Ek=; b=U
 Oi9UNQ3mCLoH7ge9jdfH722AaJljpaEkfOu+GM94lXB0uxyUkqjX7XGcHMnfsWsvuViLXIQXeImrt
 ZZJwazfLj8z19t8tFLIiW+GTdXCsPPkK7qyS+QQvpnVGhRkrWcQNE4b7lG4ci4Eqi1h9bA34Z4akg
 UeWKPD/eyxT0O6Bg=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weZLY-0004JD-7y for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 14:21:57 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gqQLv4zpDzDsgK;
 Tue, 30 Jun 2026 16:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782829303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nrmq3DTkseE8p34Jg2u8m85y8RNSQpJTpV1EGeex/Ek=;
 b=OdP0JzDeg7RNURPHTp5+cBWja1If/jr3hRqSF3limvVTb9LYwQlZhHGCHYFIDShvm6h3ow
 Q5ZEPQMRhYVbI8dYqm6RwAfC3dBdH8e6o0IyK7cE7rZ8DXsQVJ0qHwws+7Khc9+L7lci9v
 i+V84kXoIJscxwLpKEOHrx68SzBjSFQBjTtlcDEKW/0q08zFwK2zmIZDSNfbZUtrHn/35M
 CSoploeLoKetSbh8LNwp/Iu7G77WYhGD8Sp6E0W9z+LgvJ9px5YKHVmwK9VTfgyxUoCSut
 LSqndgJHH9+ja7z2LPROtPgTtKQfh0elwQYqeLzw/NyDUTATwfMuwhn/okUlQQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 30 Jun 2026 16:21:30 +0200
Message-ID: <9fc33e6f9fae10b9e372a3e06934d697edf5b024.1782829171.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gqQLv4zpDzDsgK
X-Headers-End: 1weZLY-0004JD-7y
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: fix NULL dereference when
 killing missing key
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

ovpn_crypto_kill_key assumes both crypto slots are populated and
dereferences each slot before checking it. That is not guaranteed: a
peer can have only one installed key, and the kill path may be asked to
remove a key that is not present.

Read each slot once while holding the crypto state lock, check for NULL
before looking at key_id, and only replace the slot that actually
matches.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 90580e32052f..577a22b4e810 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -58,12 +58,18 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
 {
 	struct ovpn_crypto_key_slot *ks = NULL;
+	struct ovpn_crypto_key_slot *tmp;
 
 	spin_lock_bh(&cs->lock);
-	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
+	tmp = rcu_access_pointer(cs->slots[0]);
+	if (tmp && tmp->key_id == key_id) {
 		ks = rcu_replace_pointer(cs->slots[0], NULL,
 					 lockdep_is_held(&cs->lock));
-	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
+	} else {
+		tmp = rcu_access_pointer(cs->slots[1]);
+	}
+
+	if (!ks && tmp && tmp->key_id == key_id) {
 		ks = rcu_replace_pointer(cs->slots[1], NULL,
 					 lockdep_is_held(&cs->lock));
 	}
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
