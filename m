Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4606CC61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LXZkS2RcpNZed2s6taosUBQE7zBr5zjaF9hg2COn4n0=; b=dGJY0fJyk/N0DhqzaDTvQK5SbS
	fO2qNz97mR4yMSsKank7BLzRucsf/VMXZNize3pewnn7+k2spA/rSReI902erx3eo7Jg3lt36xoCT
	OSue7F4Zm1DjjzFVu5oTXTt3PF5Bh+9s8/gpg80BMfxekQFHuvE2ICwvYfRQpqtPKkfY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1KZu-0002Gf-MG;
	Tue, 01 Sep 2026 09:14:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1x1KZt-0002GX-3R
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 09:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tt2nezJzW5jJLFbl8RYCd5634c3igcl86GU9dpSCMXQ=; b=JhG6L9kzxTN3ilRfMgUZaBGgof
 Q/qb1NTQkywV7fQcGShqlNQW1wjRPhEu6oKKwMLuU7f8wPNak8Li+I89/GSZini7b/+Kg9RKrCJrL
 1ZBZoSkfxrqnSq5hBzTGg3vEOEQOgZzoPjyDLHxfvtLPZCokyJMel01kiCv4OGpU47co=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Tt2nezJzW5jJLFbl8RYCd5634c3igcl86GU9dpSCMXQ=; b=JJNy+yxe47KAT40yp2iMpzgIyN
 lZmXvZwy2DIBA623nc3Xh9+rcIwBC/4OXVTvdNeXhDODoyNqQHNoj1j9N4XJ1A6LPB/ogvpA9ahuS
 RDEAW3O8HF5KiIuw3T77npVriFNF1HWTeF4OP+dxO3wV2SiLJG+JGBlYzws2Ry+j7q2g=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1KZr-0002oV-Te for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 09:14:49 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hZ0YW39rfzMlGF;
 Tue, 01 Sep 2026 11:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1788254079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt2nezJzW5jJLFbl8RYCd5634c3igcl86GU9dpSCMXQ=;
 b=b49pEY/3/+CSc+Wta+f5LDJIuHvw1VvO20MxhCl+yVCAE8m2ax4EI9OSU3l4f/Sm8VRp1k
 jz2QWYmtS4eHWBLS5ffU3BxGiXapQpUhQ3hf6W9plCwy/lSNlRAPuv4uhLViGg6N/jpDDS
 ffhzpA44y3Rh3Fx4gVqeTzlo3816sgioc+zOrKL6APisHmldnCNOZzMc6bfJzQp+ieRAeA
 E3VJVWSDQurwXYN1YIY6Rwu++bOHOO2akzkgKwrAP+fq6/nFhV9M+WFxR2CxX5jTBpTMGh
 l2qvQR7dts/Pd2PUBLNhinW5Szu+R7YRugaflPcVc2+dNNeM2J6QoJzzV0+XDA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <f2dd03ca-5923-44db-b1aa-6ebe56294f0d@unstable.cc>
Date: Tue, 1 Sep 2026 11:14:36 +0200
MIME-Version: 1.0
To: Gert Doering <gert@greenie.muc.de>, openvpn-devel@lists.sourceforge.net
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
 <20260901075858.11210-1-gert@greenie.muc.de>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260901075858.11210-1-gert@greenie.muc.de>
X-Rspamd-Queue-Id: 4hZ0YW39rfzMlGF
X-Headers-End: 1x1KZr-0002oV-Te
Subject: Re: [Openvpn-devel] [PATCH v2] networking_sitnl: validate netlink
 replies against the request
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

On 01/09/2026 09:58, Gert Doering wrote:
> From: Antonio Quartulli <antonio@mandelbit.com>
> 
> sitnl_send() passed every well-formed reply to the callback without
> checking it matched the outstanding request: the seq/pid check was
> commented out and the sequence number came from time(NULL).
> 
> Seed a monotonically increasing sequence number and drop any message
> that is not from the kernel (nl_pid 0) or does not echo our port id and
> sequence number.
> 
> Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
> GitHub: fixes OpenVPN/openvpn-private-issues#9
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> Acked-by: Ralf Lici <ralf@mandelbit.com>
> Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1782

I forgot to add the tag, but this patch was

Reported-by: Joshua Rogers <contact@joshua.hu>


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
