Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F230C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kTr+bki87z4yz2GaIuHZ4rgAQ3iGuirbSJDwlWVuy0U=; b=hZKTFhyViIyz+GfhoSAZAt3Top
	tSQL1AJW05Bh7EsM//7JDG1XPBEQuLs1PPuC3M/PW1y0VT/MNMvGYCErH6GFtSRfa5nQ81ZKZE7np
	3EpATtbb8Xp00Dd6n9HcbiGA0QODVLJatTUJ32tVcDU12atOi8mQnxbh5VYLvQdB8YnU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvyDL-0007pq-Ok;
	Mon, 17 Aug 2026 14:21:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wvyDK-0007pk-R9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=siYjw9XF0fn1rzz/vCvQ2+I2OtYx5u/m+mpbnnE3Juc=; b=PYZVtrZXUoDk3mtK8XxAf62ojH
 4sMs6N5QgM0mIgh00DVqrAtKJxPkuOE1F97KCHhJuepQ12xKtneOoidMF+9X+Og7ErUZ1W8UUMNNL
 X8VYmkzPXq98/qFbOc9drQ5JxVHVh6KbvHzyGAXAa67NGN0k53PbCEjgAfsqws6JCxwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=siYjw9XF0fn1rzz/vCvQ2+I2OtYx5u/m+mpbnnE3Juc=; b=JCj8o/vrWVYf2o6jxMOPCqBLKB
 85AoR7AR2Ex6InE2ss9Iu0mQBq5bZE0ypNgXq130RU1j9OY9I2fixbz9zqCgi/AUPLMesOp8xmdGw
 63XscH/MO3JQW3f1hRwqyMJzTvjVRswOhedDDBKGlApAvrrW+x1nV7q9AFG0/RW7P730=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvyDN-0008Oc-Sq for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:21:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67HELFlI029021
 for <openvpn-devel@lists.sourceforge.net>; Mon, 17 Aug 2026 16:21:15 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67HELFl4029020
 for openvpn-devel@lists.sourceforge.net; Mon, 17 Aug 2026 16:21:15 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 17 Aug 2026 16:21:10 +0200
Message-ID: <20260817142115.28993-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wvyDN-0008Oc-Sq
Subject: [Openvpn-devel] [PATCH v4] Reduce number of future epoch keys from
 16 to 4
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

The calculation in the RFC was wrong and probably influenced
by an older worst case assumption. With the fixed calculation
four future epoch keys should be more than enough even for
100 Gbit/s. So change the number to 4 in OpenVPN as well.

This also reduces the spam about the epoch keys a bit.

Thanks to Ralf Lici for noticing the wrong calculation.

Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1844
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1844
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 54225bf..37933a1 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -308,9 +308,10 @@
         free_key_ctx(&co->key_ctx_bi.encrypt);
 
         /* Update the epoch_key for send to match the current key being used.
-         * This is a bit of extra work but since we are a maximum of 16
-         * keys behind, a maximum 16 HMAC invocations are a small price to
-         * pay for not keeping all the old epoch keys around in future_keys
+         * This is a bit of extra work but since we are a maximum of
+         * epoch_data_keys_future_count keys behind (4 by default),
+         * a maximum 4 HMAC invocations are a small price to pay for not
+         * keeping all the old epoch keys around in future_keys
          * array */
         while (co->epoch_key_send.epoch < new_epoch)
         {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fd96b85..01e45fd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1343,10 +1343,14 @@
 init_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct key_type *key_type,
                 bool server, struct key2 *key2)
 {
-    /* For now we hardcode this to be 16 for the software based data channel
+    /* For now we hardcode this to be 4 for the software based data channel
      * DCO based implementations/HW implementation might adjust this number
-     * based on their expected speed */
-    const uint8_t future_key_count = 16;
+     * based on their expected speed.
+     *
+     * One epoch lasts 910 GiB with 128 byte packets or 78s at 100 GBit/s.
+     * (respectively 1011 GiB and 86s with 1280 byte packets).
+     */
+    const uint8_t future_key_count = 4;
 
     int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
     struct key_direction_state kds;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
