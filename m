Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF3606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mmPoz0xQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i77RoHx5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CpohJgcq;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=bkUQZ6xi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=0j6GDL3JWy7lNyk0XbwJBR5CICuINln4gnIcmm2iBog=; b=mmPoz0xQVis6dphGFDZwvr3fdy
	XkSpd0FGWYvNq81jBJcflsnf3+tG3NsxUhyqOWxv6FlmnjjIjnb/HnZ7fN2145MLTP6dYlyNv1l5j
	QzgpO5I3ruh0gcL8EOKkIQ2sLBGznRBq+MPiBp316HxWCb2qHlAF9X/GADAG1hZRT6Xs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWVk1-000000006lu-2NhR;
	Thu, 26 Nov 2026 09:26:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWVjz-000000006la-0e72
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vSch2vRyyaYj+bdi5vvixQDk46smLPs0GJCYzj+QxGE=; b=i77RoHx5/H2NsDFDtWkDWKhb7E
 OHtVkqR2RdTbmVGGzPnP+TW2B+3gy++kVTi4HfXRH+WDn9KujnoHMBve+IpUaPjOtoybXqcLAAj5W
 MHRIVMVrwLaK39mRK1E4hdUpnNcj+lUdYYxXXh91qGvTrvUcm8vAxIel27LNyj3hmMso=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vSch2vRyyaYj+bdi5vvixQDk46smLPs0GJCYzj+QxGE=; b=CpohJgcqipfk44SxT399ctw9iG
 9gVGO071lxpdSZzmzYWCPbIdqifyYOjuQ0iAGEJ6at62b90I+Hn2ngXkJrU4LColtOCtPVwfQHteu
 sqstzMVHLnvEP6YnL5Xd3/5Svre2pqCBNPHNql5IMfXmx2Hb7JIlmp0PmC6BD90yHQPA=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWVjx-000000002GR-1OX8 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:26:06 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jZrkr22KLzNkRf;
 Thu, 26 Nov 2026 10:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795685156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSch2vRyyaYj+bdi5vvixQDk46smLPs0GJCYzj+QxGE=;
 b=bkUQZ6xi7AMvd266hvvsFRrF3+jvxNQErE2iEVsl5VCoimnuEHR4aXJpCdm+W0Zlnmp3K3
 b732/B8hQS6ZZZrqG0CAWxI1jhSUcPS7kDtltIpWRKOXuf0iNdZ/pQZh5l/IRupZqzSdnY
 uxzHVlmO9jeDbg/eR5a6F/Lv5IB/bQTYqo3gZtWiH3jNSJy+Skd+wi5/MWuD6zuwe/RD1s
 a+Hb5M+7y6tEEnJiEnIbaWG6j4N/j8xJIyc3yas2zaOFvPvoKp6W7+foF547D1sKvGaGUm
 oFelOyKSFQolqIgpt7pVVWUr0BzEQuCBiHzDlvqXMKa42xJKohaNGFCrU/97Ow==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Farshid Rezaiyan <farshidrezaiyan@gmail.com>
Date: Thu, 26 Nov 2026 10:25:46 +0100
Message-ID: <20261126092547.132254-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CADJo8AbsiVxntM2bXe+RsjA756MvwiTqw9FLa7d5KT1q0YT3+g@mail.gmail.com>
References: <CADJo8AbsiVxntM2bXe+RsjA756MvwiTqw9FLa7d5KT1q0YT3+g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZrkr22KLzNkRf
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWVjx-000000002GR-1OX8
Subject: Re: [Openvpn-devel] [PATCH] multi: call client-disconnect handlers
 when late client setup fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Farshid,

Would you mind uploading the patch to Gerrit [1] instead? It's our
preferred workflow for review.

Logging in should be straightforward with your GitHub account. When you
push make sure to include the Change-Id tag [2].

Thanks!

[1] https://gerrit.openvpn.net/
[2] https://gerrit-review.googlesource.com/Documentation/user-changeid.html

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
