Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC52C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VReNDh5bVA0McQZLyMTt75RieNyYS/krZvdBdUJL6nk=; b=PjIT9LZCAdNwtZCPBzMjqPLDMh
	6vpMBmbtEeXpaE8i4+h44/IdeL0n4+LQxvpnTyAmPbltJlnHkHuUStxHr90qVEVnKy0fXHeOrBydU
	77jvb+RxoB11UhZ+mDzHK7hEFe1AfmDRq3DKi6rILQHqIzDaJkTrzUXywaYLU7Ig6pFc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wepaM-0007dS-Jn;
	Wed, 01 Jul 2026 07:42:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wepZt-0007bK-QW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lo421tLPWdxh6dj39ps5w03lmAJhltqMVNqKioTQeBk=; b=bhTQjMF5wzvxvV2yFzvTNw1irb
 KCnQxQFpK7LhOBc/pbrmMTRv/UVxKedr6+OphOUFUbd3uaU3XfPiD8YfM2fZnggy7fQfPFsepMIjl
 vcknLQYxkquo4po80jsfTZlLsrGut6Q8wV9edsVyQTvJYJEXh02a6mMdXyYrQdGCOsb8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lo421tLPWdxh6dj39ps5w03lmAJhltqMVNqKioTQeBk=; b=F6k+X6iGLAIl5EzenK013YXk4q
 21NI4ff2qeVjiMWT03uIeCmaY55gAuEwdz336a3juUWecWiR9wqCkMGJfXA3gQmjjZrY3OZM0IUiN
 at7kGTjrpqsQ/tN5osUeSsRM0ragFdMQnrNwzfAE0aTjavbqucqgaXjTnVIDADkuL4OQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wepZl-0003tu-B7 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:41:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6617fMvv028824
 for <openvpn-devel@lists.sourceforge.net>; Wed, 1 Jul 2026 09:41:22 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6617fMTF028823
 for openvpn-devel@lists.sourceforge.net; Wed, 1 Jul 2026 09:41:22 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 09:41:15 +0200
Message-ID: <20260701074122.28795-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
References: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wepZl-0003tu-B7
Subject: [Openvpn-devel] [PATCH v1] dco.c: fix argument order in
 dco_install_key() log string
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

From: Ralf Lici <ralf@mandelbit.com>

The debug log in dco_install_key() has the epoch and dco_keys_installed
arguments swapped. So a line like epoch=1, currently 0 keys installed
actually means dco_keys_installed == 1 and epoch == false.

Use the correct argument ordering in the log string.

Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1760
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1760
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index f5b7081..e944547 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -57,8 +57,8 @@
 
 {
     bool epoch = ks->crypto_options.flags & CO_EPOCH_DATA_KEY_FORMAT;
-    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d epoch=%d, currently %d keys installed", __func__,
-        multi->dco_peer_id, ks->key_id, multi->dco_keys_installed, epoch);
+    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d epoch=%d, currently %d keys installed",
+        __func__, multi->dco_peer_id, ks->key_id, epoch, multi->dco_keys_installed);
 
     /* Install a key in the PRIMARY slot only when no other key exist.
      * From that moment on, any new key will be installed in the SECONDARY


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
