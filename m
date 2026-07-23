Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2893AC531CC
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQ8jfFnCwQnyuKvrQCER0Ha+RG9AYhO9k3RLlfqXe/s=; b=b3ie68lsgJewY94+ixJ8RqKfpO
	+MXqz7+I0ckrl1Gkm3QigGR4kAkbp51qXYc5BiqkjXZXHn64xIjTdaByZhXykknLVps1DvnzcET7z
	JZndwr7qMWbQsw3VUnOfbB/+I66vCU08STTCfKr8uSCKg2UliINcJBLFu7Ak+FETW3AQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmxoQ-0008NC-Kw;
	Thu, 23 Jul 2026 18:06:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wmxoP-0008N3-7t
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sHKS8UKyU/HiTguLmhbVcnYOK5yMnbVpbwrmLnrGD6o=; b=CrmL5nnpodmY5R8+m/bplElsio
 Z6+b9qVvTXeqFogs7AgTx3Uwauioz3cmwIsQQO4+JmALGpmTqjCMNfXTTTe8HuLFVC/r6K6pWNpTh
 5MFQf4mch7O+gVVG9Avj+c5DQHECYai5u3IepHBxrh99UexH9YxX2kcERLSEnbFRsD3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sHKS8UKyU/HiTguLmhbVcnYOK5yMnbVpbwrmLnrGD6o=; b=cqh331gNwHfqYy6wvsAYT+v1uy
 KP+KQEMh7dp7s1HIj85+kGdyM/FLR4vCc7lFitunI95SwcLeweaCO1y7CYcpLKPSmo36dLmZm5OM7
 1g4GyjF6zA71QVbrk5aqEesYCgQhmkYvD37FIAet1uIYT1/TJs2eszYyhEk73x9+YGGA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmxoL-0006TS-Uk for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 18:06:25 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66NI6F1i007604;
 Thu, 23 Jul 2026 20:06:15 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66NI6F3A007603;
 Thu, 23 Jul 2026 20:06:15 +0200 (CEST) (envelope-from gert)
Date: Thu, 23 Jul 2026 20:06:15 +0200 (CEST)
Message-Id: <202607231806.66NI6F3A007603@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Marco Baffo <marco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260722205210.8060-1-gert@greenie.muc.de>
References: <20260722205210.8060-1-gert@greenie.muc.de>
X-Headers-End: 1wmxoL-0006TS-Uk
Subject: [Openvpn-devel] [PATCH applied] Re: options: limit ping and
 keepalive values to one day
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
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

I'm not a great fan of over-eager extra code to stop people from configuring
really silly (but harmless) things - but I do understand that the Linux
kernel code might explode if fed large integers, and so we want to cap
that userland-side...

Haven't tested this beyond "it does what it says" plus BB-all-green.

I understand that this is needed in 2.7 as well, so backported - it needed
some convincing (2.7 wasn't using atoi_constrained() at this place, but
it exists, so the patch changes the "keepalive" parsing to use that)

Your patch has been applied to the master and release/2.7 branch.

commit d9e9ec2d289e9a3c44144d4972ffe8e1fbe55978 (master)
commit 5d8cb7076108e77c049ff8e91cede207a052fb62 (release/2.7)
Author: Marco Baffo
Date:   Wed Jul 22 22:52:05 2026 +0200

     options: limit ping and keepalive values to one day

     Signed-off-by: Marco Baffo <marco@mandelbit.com>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1798
     Message-Id: <20260722205210.8060-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37792.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
