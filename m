Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6944606A337
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YpoTa0Se;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QCjU6cTm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O3VR1vWU;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=BywB+isI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=tbI7eSn6y0al0sjiNyyiQGQotgf1DctnHnKqsfjU5ss=; b=YpoTa0SeotiZLtgNKcdAUtgEvG
	IcudyYV06KsvVA/UPDTosGdqtomNsV/uIKhPumamIat/ikfruMdBwiHW00xb0WejjMkGdeiFGXLgo
	vSfaOGiKU9IvBfz2RlaZsBwr57Qza0cEVouIA8VRdaAalCp7C8BdW1jQzXcWtrBbHWjI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzS2-000000000kd-3qHI;
	Thu, 19 Nov 2026 10:33:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTzS0-000000000kW-1QEQ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cJ803KXznO+3dwPHh5v0KFNucILSCXipvK8bUZUEKmA=; b=QCjU6cTmzhGEXXZUkumv3JGEcM
 NtfgoCgM37nBfF2AZVtNPUfric/2K4D8JrCktL/xQGkXmMHiIa9uMEIaKre0/Ue+w2dxcI8GF1xx/
 XByXNATp2BdDaW0FEH0MEbRjUFgih0haGFr6vJXyegWQQ60KcjoNO8Wxv/4mvf58QS6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cJ803KXznO+3dwPHh5v0KFNucILSCXipvK8bUZUEKmA=; b=O3VR1vWUB4JcwQrIFyglmWYgqJ
 YB/2cO509SApxjaELnBeJLiAdSt2+FHKntcjAMkBtjopSRILlVSpqoFVJIEbxBiu32cjqmmU9OJ/E
 wiwkoujl9crPkEE7GrsR+9oiqCrCpWNrMUzUgBwbVwjapNxQ9pCwy3cmLTnzs0z7wpHs=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTzRy-000000005Uf-49Fj for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:33:08 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jVZYQ6BQ5zNlPZ;
 Thu, 19 Nov 2026 11:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795084378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJ803KXznO+3dwPHh5v0KFNucILSCXipvK8bUZUEKmA=;
 b=BywB+isIO0xz+InV519vMOycfCgNYDkgJtYRswExquV69RXT5NisCE3vnVJE3OWUl/Ffg9
 vMU41ITNQgcKKL/Pup7Ror8o7Px/MxYzbfFdb6wS4bCbfjPgBRMS9Ra2EIVArF0xfc9Nb7
 U/u0fyRHbkscZNXg065qPeoxFTgu/QDNnhiPZF+d1VxgVAv1EdrMW9eQsQ2CKtH5G94yZ5
 BdvBbBrMM77YfMxEIumn1/Mpm1NlktuCd58ApkY6bHdtyUR5FkWLeVcMjGSCKe4JMsOx00
 3mW51FUdDAqg2V34I2nnaRh+9tAJYyvWiufW4KuwLWMnU30zjGOqPvC+JFGDOw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Liu Chong <979504756@qq.com>
Date: Thu, 19 Nov 2026 11:32:48 +0100
Message-ID: <20261119103249.285372-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <tencent_DB0ADABF741A42D32620ADE82AF77005FC09@qq.com>
References: <tencent_DB0ADABF741A42D32620ADE82AF77005FC09@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jVZYQ6BQ5zNlPZ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTzRy-000000005Uf-49Fj
Subject: Re: [Openvpn-devel] [PATCH] ovpn-dco: fix IPv6 VPN address
 comparison in peer lookup
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: antonio@openvpn.net,
 Liu Chong via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thanks for the patch.

On Thu, 19 Nov 2026 12:40:08 +0800, Liu Chong via Openvpn-devel <openvpn-devel@lists.sourceforge.net> wrote:
> In ovpn_peer_lookup_vpn_addr6() the word-by-word comparison uses
> 'continue' on mismatch, but it only skips to the next word of the
> inner loop, not to the next peer. The comparison therefore has no
> effect and the first holdable peer in the bucket is returned even
> if its IPv6 address does not match.
>
> In multi-peer mode a packet can be sent to the wrong peer whenever
> two IPv6 peers share a hash bucket (with a single peer per bucket
> the bug is masked).
>
> Replace the broken loop with ipv6_addr_equal(), like in the IPv4
> lookup path.
>
> Fixes: 94581f0cb760 ("ovpn-dco: restructure code to allow supporting multiple link to peers")
> Signed-off-by: Liu Chong <979504756@qq.com>

Reviewed-by: Ralf Lici <ralf@mandelbit.com>

Regards,

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
