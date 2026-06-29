Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A121C43327
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5efuPl103HCgPIidm1pOUnIMVqefHP7nFgur6t/mM0=; b=Yi4Fzmhue6CCL06RbHVEPira0V
	0GBuSxqtvFA428R45CPz88ZsuzukOP+cQVbeo8SpftxgiGHyYl4ODY/pJMyUhpP9WO9+9QNPyhjeM
	Au4n0TOWpICvSrmogihovZfv8mhbJ1TwSwiIKh2MyvZY42cWGdj8opGch//Jj6oX/tao=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weC2G-0004Lj-6m;
	Mon, 29 Jun 2026 13:28:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <arne@rfc2549.org>) id 1weC23-0004LW-5s
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:28:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=shbGhahEUhew/JmEnLu6eyZlUD2g4EaTz266DpdrizA=; b=KwSk4gTjaLGJacaiarLffqnggt
 D+S2LV4y/0YwJAh0C8vZS1DldzpM3gpBSNWwRBi36SBN2KFqx70jImZ+Cphqi/HJtNT3XaiU0f7A8
 QRjOf+0oggvVFMqKC9CQpqWp/1PVKNfyJw36LPMnrTP/q9RcV0/l0SGFpb20kBzPpM58=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=shbGhahEUhew/JmEnLu6eyZlUD2g4EaTz266DpdrizA=; b=BVWCEhvlTJ+pKpn0ZK2VeDD82z
 Nt0XEyLG/iuBvqqFej1DAqh2maOz/+w4EbBrisx9Npisrs8gxyGSipgKLknldv56EBHkB6F1huDJ/
 kZnxrfaJGPKnQvjrFHDwEG9xZlkvuZ0rXLYmEbVcuPqQfdar5agBLD/ZDFgW52onPBMI=;
Received: from mail.blinkt.de ([192.26.174.232])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weC20-0007Z7-GH for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rfc2549.org
 ; s=rsa-green;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To;
 bh=shbGhahEUhew/JmEnLu6eyZlUD2g4EaTz266DpdrizA=; b=fO5zMguv3mDBQw0KlpkE8TIQkH
 AW8vwGoh/w1ArqwaGnDg4Ajl9BQNZ2btDrf/UPj0lLZQM7IYjukvo18LoAzaVMlWOPBqvKmAisS+R
 aCULZ3tZRQt4HtZiK+4zO+tn9fAESTc45lKYUp0aUfuZWO6V0otX10q7eZhgCOo5CM22k1z+4BlkU
 C1kVo1YODMATFgz/u+IeCqDCnCaoApx39fVZR84VY5/thdmhAZZpda9IHewfL+deCVjqHz/ozXisj
 QayCw5afzziWhb0vPN9iLbhQ9DWDkKkqFIVYFxuAgSutUQ043Tbd0YCD2eCzeDjX+EoAftoOA2S0Q
 AUq8uf8g==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=rfc2549.org; s=ed-green; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To; bh=shbGhahEUhew/JmEnLu6eyZlUD2g4EaTz266DpdrizA=; b=ilcYfNcH/Cf1YWR
 o3HsI8iTffPRiQWP6PvpUG6PWNEDqqYQdU2cKrnZy0pyLszAna91yEUZMBfR6t6DH0nnKBg==;
Received: from [2a02:908:2220:a200:97a:3044:2b98:e70f]
 by mail.blinkt.de with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3 (FreeBSD)) (envelope-from <arne@rfc2549.org>)
 id 1weC1p-00000000534-23C2; Mon, 29 Jun 2026 15:28:01 +0200
Message-ID: <aa684693-7e53-4528-b67a-a413972f3f8a@rfc2549.org>
Date: Mon, 29 Jun 2026 15:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sami Rusani <samgithub@pm.me>
References: <q2D43uJoozPKtfJvLVuPcngp0-9sjp_HkGFBfdR3bpOTXmPGoi5Fz__jvpLGvsEWHXC5lBnqny8sXX-kkN3zXoRTJmTLjA0mzKb9yG5A4K4=@pm.me>
 <c6e935be-f655-47c6-b968-6962a3cfc58c@rfc2549.org>
 <_5bQ5LvkEmn_vaE7Ng8xPAcHJFWfy7td0Yvim0iLc3YVoer2RM1-PoBKAGPzHZKx1rsZP7Ht7kM_2eIUSidNkMW34yS7eT549_fSvcb-dl0=@pm.me>
Content-Language: en-GB
From: Arne Schwabe <arne@rfc2549.org>
Autocrypt: addr=arne@rfc2549.org; keydata=
 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
In-Reply-To: <_5bQ5LvkEmn_vaE7Ng8xPAcHJFWfy7td0Yvim0iLc3YVoer2RM1-PoBKAGPzHZKx1rsZP7Ht7kM_2eIUSidNkMW34yS7eT549_fSvcb-dl0=@pm.me>
X-Headers-End: 1weC20-0007Z7-GH
Subject: Re: [Openvpn-devel] [PATCH v2] Document --preresolve option
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Am 29.06.26 um 15:22 schrieb Sami Rusani:
> 
> Thanks, addressed in v2.
> 
> This version documents that --preresolve reuses resolved addresses on reconnects, and mentions the trade-off for dynamic DNS names and
> DNS64/NAT64 roaming.
> 

Thanks for the quick change.

Acked-By: Arne Schwabe <arne@rfc2549.org>



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
