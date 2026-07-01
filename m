Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A53BC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+I/alYm+3CChTBshUpf35VzHdUeGDn9ZdFMPHswYGo=; b=f5W+4R7IItnWfgAr6B41S04e9x
	nt8VEvITiO1nt6dKgXnlQLspt3k4yKLNIVLqoFRf816LZ4lXQwcJ4nYLJDGnk2dc0KkdcNiZZPm5a
	VIrOmrO5qDg4xAFuVGcmyoKcFuwPPN7BZfkZvetT7/cVsa+BbUs7MUEF5O4EGoy2Nv3c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weztJ-00009D-Mm;
	Wed, 01 Jul 2026 18:42:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <matthias.andree@gmx.de>) id 1weztH-000094-9F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vjUxo05nv/fe0+f8KkWBsWnUcf58gk4ISG2/y7LI/M4=; b=Fm+W5hWfLdgR8xy0/sk2GaUJAq
 Hgxx+Rp/2B1RLq6TtqC6kDC3NLQaBntvytRefOcSw9F5ro1dtnJryRQLHKIuewHhOVrOhSrkUb8up
 45w46hhURxvNPEVdo3EVHLgnFHV2i57lNP0sP5v6FNENCjvD+yA647vI6BuHGO69FgR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vjUxo05nv/fe0+f8KkWBsWnUcf58gk4ISG2/y7LI/M4=; b=jp02lpxzb8zuADg7/aQqSBalIR
 fqiZ2EaRlUGGjtcPFdWh6AUayfw8wszcOqkQcRmjWx6gpTtFM6rdpQK1DSLt3Zga+vxgZuh9w88Vi
 261s2r1HrUNwtYw65sf0E5OpxyMFgPVYQxNgzpgnPmFefeJt5q2cPeT+SE7K2lXO7rS8=;
Received: from mout.gmx.net ([212.227.15.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weztC-0005PR-HG for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782931335; x=1783536135; i=matthias.andree@gmx.de;
 bh=vjUxo05nv/fe0+f8KkWBsWnUcf58gk4ISG2/y7LI/M4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ciw1LygMlnwvgc8BAY3gJEfwUWkTc3lpT5ep4spDML+4FazefvvmNFNKUNK7eIty
 6D6Yg6i0YsBLvtW8N690lBiyu9GaGlf9NL/Ne5b9S5HGyXePAsu3GWuGSqlt5RBMv
 KxYGR3nduvVkLY1M3lDx9rC25QmifzyuLki7P2WZF/xqcAS+PrKY5d6sqiUVtJBUe
 nbcPLLq+1l0s9P7vm+oZcq77AgIrlbr7/q7wj8mLM3Ig8JSWDdX3+7PUzCVfUIoHq
 auhymgAum1TvTAEr9fPjcp6y4/As71D8sLZO66xyiXg+4Z6qUx8SWVepvz2s1hf9h
 bbsrueL54WUnADtgIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1xMKjA23yZ-00cMsq for
 <openvpn-devel@lists.sourceforge.net>; Wed, 01 Jul 2026 20:42:15 +0200
Message-ID: <2663cbaf-5ba9-4796-bff4-f0c68301353a@gmx.de>
Date: Wed, 1 Jul 2026 20:42:15 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: openvpn-devel@lists.sourceforge.net
References: <20260701183650.29936-1-matthias.andree@gmx.de>
Content-Language: en-US, de-DE, en-GB
In-Reply-To: <20260701183650.29936-1-matthias.andree@gmx.de>
X-Provags-ID: V03:K1:dnszSkK3ESkfH4uplWI9gzUmJrE2SV6OK1qH+YIiV//4GU0C78Y
 P17hwDSlt+1plKF92pJH+D4Hloyq4/urxiuYiKn+NfmXvmrF81vNtjdxvGiTsdwySc94jig
 KI7EDNx+u5pRK4VNCyNwiPuvztOEjZwzeRctVgK6ZL13XihmrjCnFR9LqxRJw7RbRbLD3eR
 j8w+pKMKcPSj5YORGA8bQ==
UI-OutboundReport: notjunk:1;M01:P0:aivyScBVvLg=;zsXgSSgEOItJHvHLJQ89GTipwKT
 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
 UlMwzg==
X-Headers-End: 1weztC-0005PR-HG
Subject: Re: [Openvpn-devel] [PATCH] Limit file size assignment to safe
 size_t range.
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
From: Matthias Andree via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Matthias Andree <matthias.andree@gmx.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is against master and can be cherry-picked to release/2.7 and 
release/2.6.

Am 01.07.26 um 20:36 schrieb Matthias Andree via Openvpn-devel:
> Some operating systems (FreeBSD 14 on i386) have
> sizeof(size_t) == 4 (which is used for object sizes)
> sizeof(off_t)  == 8 (which is used for file sizes),
> so assigning a file size obtained from stat to a size_t
> causes justified compiler warnings about a narrowing
> conversion.
>
> It is safe to assume a 32-bit platform will not want
> to load a >= 4 GB file there, so let's just ASSERT()
> that the off_t we are about to assign fits into
> a size_t object.
>
> Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
> ---
>   src/openvpn/buffer.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 5f2b2338..4b6acb36 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -1391,7 +1391,10 @@ buffer_read_from_file(const char *filename, struct gc_arena *gc)
>           return ret;
>       }
>   
> -    const size_t size = file_stat.st_size;
> +    /* for some systems, off_t is 63 bits wide + sign bit and size_t is 32 bits
> +     * wide, and we need to avoid negative garbage wrapping around */
> +    ASSERT(file_stat.st_size >= 0 && file_stat.st_size <= SIZE_MAX);
> +    const size_t size = (size_t)file_stat.st_size;
>       ret = alloc_buf_gc(size + 1, gc); /* space for trailing \0 */
>       size_t read_size = fread(BPTR(&ret), 1, size, fp);
>       if (read_size == 0)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
