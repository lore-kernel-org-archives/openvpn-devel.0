Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FD606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TcdRkUZc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OiVVatwW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hwrYoTTy;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=w+sY9yhr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=gqNXNIZk6kNjnTNK5e2xIZTLB+OHSuIhWIRoWX/AybQ=; b=TcdRkUZcNamaeVC22mUSF/qoOv
	CimVf35svIvRUkOmmP3955upYCgIxzYJd6GRiFjJ6GvTypYM+5z3zktmsDg+VQhVhBm9DQSipKK4s
	waZIcQO2YKFF+OBdwKAID86QUAejo9KM7NocfnIM22ic1ybkR5VCKY/UJduv2N1i9Czo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWbCO-000000003aW-30Zw;
	Thu, 26 Nov 2026 15:15:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWbCM-000000003aO-33iE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tNUn/mHP24wNXqinamn2q2EalXCuzRaORgx9mEIbI0k=; b=OiVVatwWzspTS44p42KGkfYsBV
 ArjflCt1xXxmF+zDp9F+s091zMCcrBJ+L30MBqk0jbZOG0Xi/fQS8leMkI6XulQYrUUyRnPoSFU5U
 rCR5xuG0hmXpFtqQXXf1gIG1tWkeg4GFlaSx68PcFsfYSG8tff/Wym3gp+WI3f128oNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tNUn/mHP24wNXqinamn2q2EalXCuzRaORgx9mEIbI0k=; b=hwrYoTTy90wC3DPipidd8Nw8jU
 //GI8j45jbRkCn/dE8T1CtJXZfJNdhXBI9l4hQ41pJlO8GgBdE5sxeIaZhyWL7J1DlyKoKWlMEtg5
 Joe2AnqYOZnXhDtr/Ppe9V1uRuI4Nw85dgk2MpTr0gRWTc7aLgZ+rlcHyV6UReKcC/ig=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWbCK-000000006YO-3ZqS for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:46 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jb0VJ6V4VzNkHD
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 16:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795706136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tNUn/mHP24wNXqinamn2q2EalXCuzRaORgx9mEIbI0k=;
 b=w+sY9yhrtTV0E3ok2ccVAlB0XY5Adf11f64H9gfH3aQVnPKZ0sTeoxT9r8f8zX8XuaBNk3
 E1Ic7/g4LLLur3VjHaOs9jX3wuyEBSv7qV627QxYnSxtyThZeuiSVk8Cu3n9d4MTMlpmA7
 gRO+C1XueXUNTuvhiO5tAKFAOEHfmX+EDWmCcXYi+pSWdcD7fEBfKbm5jrud/Wyl+9NTO/
 QHs81+2S0HlaZojJov2kdmdXFSIfjYiD7KWx3N8ZI8jvAcw2v0+u6IzkzOmiZJOoo9fQaS
 emEdnsTdEhnfCOcdC/RTfnB+WxAQvj9lh/hHiMQmUgCdmtWWsCeqTWRGe9sbbw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 16:15:22 +0100
Message-ID: <cover.1795704654.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jb0VJ6V4VzNkHD
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWbCK-000000006YO-3ZqS
Subject: [Openvpn-devel] [PATCH ovpn net-next 0/3] ovpn: assorted cleanups
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
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series collects three small cleanups with no functional change.

Patch 1 uses rcu_dereference_protected instead of rcu_access_pointer in
ovpn_crypto_kill_key, as the slot pointers are dereferenced under the
update-side lock.

Patch 2 corrects the kdoc of ovpn_udp_output: the skb is consumed only
on success, as the caller frees it when an error is returned.

Patch 3 drops a redundant forward declaration of struct workqueue_struct
that was added together with ovpn_wq.

Patches 1 and 2 link to the Sashiko reports that flagged them.

Thanks,

Ralf Lici
Mandelbit Srl

---
Ralf Lici (3):
  ovpn: use the right RCU primitive in ovpn_crypto_kill_key
  ovpn: correct kdoc return statement in ovpn_udp_output
  ovpn: drop redundant workqueue_struct forward declaration

 drivers/net/ovpn/crypto.c   | 6 ++++--
 drivers/net/ovpn/ovpnpriv.h | 2 --
 drivers/net/ovpn/udp.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 7ccc5e05043b1bb84326b19a2b05938d8f7a2ae6
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
