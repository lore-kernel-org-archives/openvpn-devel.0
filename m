Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82E7C43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RaP6HpbiNDc6VFTOnVWpufmd3hPy+wejl3DNRVP6hu8=; b=R95WfBI+L6D7JtbKl/vzXb5/IO
	KaQcBU6OayXYYav37kX+tQR6880U0NY1OyNlXMp4ySIlUoh5Y/YUt4GG6EHnnFUkzCNxYcQNTPlrw
	zNA6KCX6aU14pFfyaHWgPlkHcwXMkejB/c2g8/MbmeHWPKHVxSbMATzLHHPokmoN0mI0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgzS0-0006WH-0S;
	Tue, 07 Jul 2026 06:38:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wgzRt-0006Vi-9P
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 06:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A4DgTndyzDMegkv48yDJcMtF3VhRB0EdX7g2hEg6hPw=; b=CWSt20SHa536MuAWN6Baj0XMSi
 Gk3jNz+Hd5lDWEAzOPfapaxQIol7w9EPmFfdVZHi955iZly904Wd4FFdAWf6MtlSWKhJoDTKKL+Ie
 zaLb3acDm7hZoW79p9mXHdD4yVm/FrbfMdQ5lSpMZMW/oZvNFolHCFL8GmAiV+EmIyZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A4DgTndyzDMegkv48yDJcMtF3VhRB0EdX7g2hEg6hPw=; b=Z
 MkO7jMM7ndjlewicJW6k1qBEGK6McyopmAU5GzzWZHQ3ejsrdUY9akQUDlOqeD1zPy6RdWz26LKcC
 FhEWLM4Ak2HuEdQtb41XuxQHq7mOdNQKKxhs3+oIHJy2F8BHVdRpflFPijui7MEYmAQzH/aUkKzNn
 8xrAFTLbJYw5jH5o=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgzRr-00014U-PN for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 06:38:30 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4gvWkv09xqzMm0B;
 Tue, 07 Jul 2026 08:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783406295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=A4DgTndyzDMegkv48yDJcMtF3VhRB0EdX7g2hEg6hPw=;
 b=W+hWm6f2q62pj03Y9xUe5ioWOxd5mTWt+k1OmCUeZNlWeq1W2gIx4eXeD1XRZjj6P7QUMt
 ceCGOJw9OnDTstiZavDvbfAGEnneZ88MUBoIzNz3a5WR2rB5iftuBMxPw1Z10SNWLTi7TK
 H5t6GR0zrPkGCY1CqlvWQy1Qs1p7/jGpc/ZNBRnvFipM3LCgyw+1VWDR+GHCox4lnkyaHa
 dxF8vhvPXhVSKmzTDc18d6o9Sh57NNgFdYONs1OLpMPRDA04CGKEfqogVAZAwzRS8D2oci
 iwA/WoFcfQajfPvAcsYbDHvyZ7ayoXHQTNNJ9wA6kIqKDgmVw6wUgAH94q0YBA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  7 Jul 2026 08:37:48 +0200
Message-ID: <df3a48623cfbce08c74acdd0e6ad0313eda17c8a.1783405648.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wgzRr-00014U-PN
Subject: [Openvpn-devel] [PATCH ovpn net-next] ovpn: remove unused work
 field from struct ovpn_socket
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

work in struct ovpn_socket was introduced but never used.

Remove it.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/socket.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 4afcec71040d..5c87392ecd30 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -24,7 +24,6 @@ struct ovpn_peer;
  * @peer: unique peer transmitting over this socket (TCP only)
  * @sk: the low level sock object
  * @refcount: amount of contexts currently referencing this object
- * @work: member used to schedule release routine (it may block)
  * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  */
 struct ovpn_socket {
@@ -38,7 +37,6 @@ struct ovpn_socket {
 
 	struct sock *sk;
 	struct kref refcount;
-	struct work_struct work;
 	struct work_struct tcp_tx_work;
 };
 
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
