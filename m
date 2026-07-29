Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF153C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+V1EfmfyOVr4Lfe3I0vFOWg/ZD0u8kumavpuID1nFc=; b=iNn1IEEPsjFSftBlUJxfRvyPmC
	bKnPELEu3AScff/0E4U9/Fq5QFF9muv19TgFn2stD89aZypdtB/AxIXpXt4CZeBZQTZhK2Y+oV6Ch
	xc6E8EtE86nrHZU7myE8oVQyInfC0ZAbbFiWcs0iRJbsadzvUdnpO3y/A3MapJ9mfY1c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wozWA-00073B-Am;
	Wed, 29 Jul 2026 08:19:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wozVl-0006tc-7c
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f0+ZqkEaKHDcJd2/VFjLjd6mgkXBzgygxO0OP+ArWj8=; b=JQkFw8mfCAftBQYaNoTUX68QHs
 clPc8m/2VoPHfdUbKg8Jh3009o60SZfeYih59cZR1hssWYJGMU3bJCU94nTSvkFg8B+LKxB2Y2q/O
 Mg0BoQ2fC2uFIASajat0iqCRQ2Jbm7YIgvWhvnIzU/nc5ferR48KDhm8++vKU69zD+Xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f0+ZqkEaKHDcJd2/VFjLjd6mgkXBzgygxO0OP+ArWj8=; b=KdxatLe7/XGc08pW4hLbxa9+ut
 5qzk5oZ8VXTQHAzUYyNjappSCkWoJBAzDLjLuMEojmZO6O1TybsT5TZMhcLwPonvFGaLdnhFRQQ/e
 3hEJrxctZpkg9W1UgM7Z2Yub+9bOyUejgLoYu2FY2DnI3npAobWcfoQdZYBRH8bx7eiw=;
Received: from [80.241.56.151] (helo=mout-p-101.mailbox.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wozVg-0007T2-TS for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:19:30 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h94xN4fVsz8v3T;
 Wed, 29 Jul 2026 10:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785313160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0+ZqkEaKHDcJd2/VFjLjd6mgkXBzgygxO0OP+ArWj8=;
 b=IVddPfKBWxZUIaKBPERU9g4x/dMjQkJSm07HQlerJQURLCYHAyHOOTzeXYEI5wQRHXqQTq
 DJFJEyCCoBc2wtrQLJIaI/angEvIIOuOko1Voi8ekVlKZTEVkKoW4Jexo7OFb9wtUXCZur
 SyvivBJuL76gARt/P1ZUEcZr4vkIZXVSw+KJ5cCIcetXXZCPvSVbNDYI96pRz+R+ZoWzaF
 GMps3zTHmLm/DNzpuZprnFOeBQz+k8bY/SWkHmFvuHHs9ZaCVPlijE0SFkk5HRnlPvZBF4
 vXZugLyC1TT18c1xws5QeR/RtcvUSyC+M41csgl8+r+Oy7P1Bne3KGbjl6NzFA==
Message-ID: <0ca7cdfd-dd3d-4e58-be8e-a200f70bbf94@unstable.cc>
Date: Wed, 29 Jul 2026 10:19:19 +0200
MIME-Version: 1.0
To: Gert Doering <gert@greenie.muc.de>, openvpn-devel@lists.sourceforge.net
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
 <20260729064158.15731-1-gert@greenie.muc.de>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260729064158.15731-1-gert@greenie.muc.de>
X-Headers-End: 1wozVg-0007T2-TS
Subject: Re: [Openvpn-devel] [PATCH v2] Correctly calculate packet id size
 when epoch packet format is in use
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

On 29/07/2026 08:41, Gert Doering wrote:
[...]

> +    /* epoch uses a 64-bit packet ID consisting of 64 bit (24 bit epoch + 48 bit IV) */

As reported on GitHub, there is a typ0 here: 24 should be 16
Sorry for having missed that during review.

Regards,

> +    if (epoch)
> +    {
> +        return sizeof(uint64_t);
> +    }
>   
>       bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
>   
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
