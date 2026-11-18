Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76181606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=apCmIoWs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RARcIqL/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=foA7mAhk;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=0lTbDW12
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=35fhZxKCawans3H5aQv5golkF385NQH09np4WKNKTJg=; b=apCmIoWsK3/2X8lJyyEOgDGMKu
	3/HuRN5BOSyh34nMLVizvOSvqbC5a0NV4B6/Lns5ZKlKgIYdsqQ3u4Yq2gzem67TqnoQrBHMfouQZ
	fjapiuPpiL9GSBvfCtQ8SiYHgFA4iUgWpDHvz89sscN28wcpTvLaMCQhahoHhobtTY9c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTdWr-000000001AJ-3xJq;
	Wed, 18 Nov 2026 11:08:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xTdWp-000000001A9-1oCv
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2EiPRA/JlzTTjIY+b/xIgXR3IUQ4LamCMgnT+ZcJ8w=; b=RARcIqL/WteLpE/HR/1tXlqSRX
 YTBqEqMBPblvUQIgVPXsZim+kbrqGITl/6IddODHl4Vr4X/SKI5ZmNYgpBl/mt/Zdga5vH7bUFNoM
 AvXVLKRM9HJL5OlQn2PLEz8W9zqZ2oIKrknXFv62eo1sciZvV37fazghGdrw/PRt+EV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2EiPRA/JlzTTjIY+b/xIgXR3IUQ4LamCMgnT+ZcJ8w=; b=foA7mAhktzOGT6qw6qMQ0LE19/
 1HZE/bMrq5/1IbL9eOZle+YCyFPU2q2ztB0ZrBaZfviPr8ZOcwliqDWK3d98R68MTfTtxvPX/QV0m
 cqVc7T9L4Kh8JW6eY1qOf1V1XOdn4i+jGqwnlah9fllnioeEU0SfF+k/3Z2ICuokWKGc=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTdWn-0000000079P-4AIR for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:08:39 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jTzNs61lnzMls5;
 Wed, 18 Nov 2026 12:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795000109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2EiPRA/JlzTTjIY+b/xIgXR3IUQ4LamCMgnT+ZcJ8w=;
 b=0lTbDW12XN1FiVWgZJZAH73//C7xWoVn94g4X5Hi9pkZAs40beEDFYYJs9t/JEbg2bkRxW
 qLFGqhdtwj28LkNpF31N9fCxWppGSxjC+k2Suycesqi80BV1x9StXQiV7nhX82EB1u9Iww
 1HnY12WyS+I/Gqhl7IQd22SeF4OH85E74RQQkIauzD54HXG+mL9xPMRn9XvLdCrjd9buoe
 UZb43bqS+YGLSV4j0GUyFi45Ul28d1ocYYfl2YPPzu4t1/Z0dcZYxIMVrR1Gc/EcRCluv+
 xx/9mQ3Ws5xJtVJala6Msleorr+IrIgfpDICyjfbJF2WSqIJrOEG5/5DbodfcQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 12:08:27 +0100
Message-ID: <179500009335.570092.9385999968959192349.b4-ty@b4>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <tencent_61D46342CA8AA4D20297CC2FB21D4A272C05@qq.com>
References: <tencent_61D46342CA8AA4D20297CC2FB21D4A272C05@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTzNs61lnzMls5
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTdWn-0000000079P-4AIR
Subject: Re: [Openvpn-devel] [PATCH v2] ovpn-dco: hold peer ref in
 ovpn_tcp_read_sock under RCU
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Antonio Quartulli <antonio@mandelbit.com>, antonio@openvpn.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antonio Quartulli <antonio@mandelbit.com>


On Wed, 18 Nov 2026 16:25:07 +0800, liuchong via Openvpn-devel wrote:
> ovpn_tcp_read_sock() uses sock->peer without taking a reference.
> ovpn_peer_del() can drop the last hash-table reference while the
> TCP data_ready callback is still attached, so peer->refcount may
> already be zero when ovpn_peer_hold() is later called for
> ovpn_recv(). That leads to a WARN_ON and a refcount underflow when
> the async path puts the peer.
> 
> [...]

Applied, thanks!

[1/1] ovpn-dco: hold peer ref in ovpn_tcp_read_sock under RCU
      commit: af0f8bda7f8394e98943835d173d82d4f67d9392

Best regards,
-- 
Antonio Quartulli <antonio@mandelbit.com>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
