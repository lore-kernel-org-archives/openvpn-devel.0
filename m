Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF3C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ur8IO99Qr05aQUC3ybdIuUbZ4A/oZ9CdGJk/II3oMn4=; b=BMOJZDpcOdaN0Svqe0jYlW7aOc
	dPyCYGP1mdQRxgdyfc/cPBxaL1NNbqqJq0SPB64l4i7yzlZU5H7xJ4ADWfB/jvAvgo1AzC+x3pUbC
	ofBFyx6q2n2M9rS50oLzAwxYL8YHA5cu6zwbu5V03+2lgMg/SabcQEVTTHtxlBsfvpzA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wure3-00069p-1K;
	Fri, 14 Aug 2026 13:08:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marc.leeman@gmail.com>) id 1wure1-00069h-Vl
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 13:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=byPoW1dfxgDNBJgpd9s3JzjaTXR5uE7Xpq/R/yyuu7A=; b=WGcrUHAfRNmXAqad+/Sz35S/wC
 TUVSHNhmzKPQ3NL442jSAZHJ+QBG5v3QXWy9bV5x44O25yOHA/ta7cod8wo9HqsP2mpVF2VastRs0
 Xmt96RX5yaQzohxDulYrQvXQPcr0pJaJjWGsqlTLssaPRINOdpQXOxF/FHeYqYKG30hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=byPoW1dfxgDNBJgpd9s3JzjaTXR5uE7Xpq/R/yyuu7A=; b=MQUcrLcHdNq5HYr4K44L44IutD
 AAkacnyI5IQrimNj3AV9JxIlzciNjmtZOAhPC4Py62oetiTS9zLOBxF9gEx9fWIY8P/8zYouY3zM8
 WMM0Preq9YjupOEyMia1KbZ1vuiNnfWTw96StQ+YbjcPxGB03NsA274sueyzGOekQ9oc=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wurdx-0006xC-V0 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 13:08:19 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so11728395ad.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 06:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786712892; cv=none;
 d=google.com; s=arc-20260327;
 b=Z4GG/5gLuWB5WvpDwWoYSKYqqbmGpWeWqoJv5WQgQoiEeBc4OLOMFAfzAF/6R2H+7/
 7v+U0Vxv3b7h8PJkonz+Kka1ZhQs42baF3uuFSsnlUi4tIlkdVplyh82470+sKoJnyj7
 VscAatk7sshJPmmDbK9PUdyxy1O2y1GqBTwz0RKHK3EfXoy9D7WxAi5ZKXLTDrkC0K2f
 zoULprax75FL5TFIyVQ9nqmIUMg3344DGqVTeQZSlkxnA5iLNrITuX5YSbCdgABEX37g
 zMGTBxF9QQcOrY69IqgOZtKlS6biOVg9ICQ7h60aunJyzFiS8eB2XcbIim/FOzEtMmWa
 1cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=byPoW1dfxgDNBJgpd9s3JzjaTXR5uE7Xpq/R/yyuu7A=;
 fh=30oC+EvTQQkhMMxOxOfdXoXFW6wdNq85jD954M8iz2c=;
 b=Vww3VyGsatZJWIOuNeZa/HSQ3WkFNkMfTfF2rtXM8tZWZ3UhOMuUOA1qurGGGaxazr
 10UXJTmbW992vbRNh/9aqVXvfNs+pEWQPNK/c2grD3uPl2Po8YyRo0eogD5NAf7rVV0/
 o9+tx4djt+Lq7vQ0ThzmlrJEGOfMl95XBM6VSzCjjTsElPY4VcuXuvh08SlaitUcw43p
 65Y6BPP0BGsWP18RuAi3xxPzOOVIHw8u7zkyTvzxS/yTH2xJKfOL/yB7PE2ZzAO/onQe
 WzhdX5an0iB9CcKhNkk23Dz2Z78hq+OiD6+w/B7k9yNVgF3qAOCOhSJZBb3amJgb2Wma
 vRsQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786712892; x=1787317692; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=byPoW1dfxgDNBJgpd9s3JzjaTXR5uE7Xpq/R/yyuu7A=;
 b=Pt5QQFEBFFjQyHfZUJK+SDbGne4ybvLR1xK2oCXwY/+9tbKZwdZiMWqClsSwqV+E/H
 ajo5ybswdKT6x63zms1NSh5+STYvox85p++d1lGU/xx+CzzKvr33TISJED8r7YmiGi9Z
 7hXpPZChlsXIR75IBEqIeYFLyZYmSI1YKz44TvM1HJCuUx0SXxs6Y2F3VeGlBobI1lxu
 TZBa0vAPZcgqrnrueZN38mnTgdzMmvLpkK2QVHqbYcyNRngPx8JESWEjudwxuOoUeske
 EwkDVReGaT2rg8JzYseqoLPP5jMd6/458H33DdAXHrhyPPpn4VjgXlc0rTjAK1qBPHxN
 33nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786712892; x=1787317692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=byPoW1dfxgDNBJgpd9s3JzjaTXR5uE7Xpq/R/yyuu7A=;
 b=eN8Ew9qVPOSE1Rq2HncOmJbFMyg4aICrU8WSGi+ef8DL/ce/6wPWJ98paVMeutC6Uu
 GN3ErsGCyCjhO7SCe8FuqqCslvMv2qSzN9d8wOKigJmKmS52cQuN3W6v2nuOS9Ff+NQs
 OH/xqGjsg8Z7oHCd3urRLrFuIAEYUv+7pqU13yFfMG+sEIjaxPH/zBNqv0ZUIiLuBA6y
 siBW2g1rOYggV1BrHhGgEoi+T8xYxod770cCPkV84pR3+lzvi1n1Fx2ti81JGLVlZhVc
 +K4ArlVjvCSO3vcpCr38XkuWS8sfXuh1eKHgb5Q0cl+o4JtQw1Zg4mb7ZdW9glA9olTY
 META==
X-Gm-Message-State: AOJu0YzSJ20qg53eeXAmEboxiREmM2u8De+N5GRf0QgrA5LtMmYfuSL6
 Pq8w3LHi59UICJID3kJlTAbAXv0pxYLz1ETfkn0RxKXuTDgf17Lw+3rw+G8B0Cji/EmGvxNkXpY
 cjxB6emE+ZRd8KbPNmtqf2UAzepbx0hIODxy7
X-Gm-Gg: AR+sD10ZLuvErChRApM6eAcar56lUOVf1bFG/81z3OLiO2Q31EUoIdBzzgf9ZLUNOIV
 IF3TOcC0Tt5W3Dk4JgcZv74LzECzDkscLvVGL3bRZOwMSIV+sEXO7dxpri/qq5nEzMfC5xk+F5g
 QFTt/5AoGvbUfnMsxDl86zI0GsoipiXkZBMLu4cuZBEeZPysA6JNrz06Sz2c+vB4NjpkkO8Hbik
 y4Nzq2BREimb2dHExMraenJLXBddGhQWDlm475hq5rgc4a6IeTFxumXn6GSiNGd7nvCLvX5X5HK
 mJErIWuJJvWp59pD4BzNyQXyInz7NlINenuEVIeIOhOkYHnygL1axESr6nDrpg2ujsZ40WubZj4
 J5uvRxBYzBM3EZ3RQf12TdTxaXXiTaic=
X-Received: by 2002:a17:90b:3889:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3933b8ace11mr5795403a91.14.1786712892206; Fri, 14 Aug 2026
 06:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <E1wrZjj-00GxkI-21@paradis.debian.org>
 <CAH+fs=_5F66-XRw5VtdF4eFrt3GOQZvGfE6AZOav+CrusqN1JQ@mail.gmail.com>
 <anNFyCPJ1euSKfQu@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
In-Reply-To: <anNFyCPJ1euSKfQu@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
From: Marc Leeman <marc.leeman@gmail.com>
Date: Fri, 14 Aug 2026 15:07:55 +0200
X-Gm-Features: AcwNN1WsMpntynfwUtAkl9PpdSfFUOY11J1q2Halo26wa4fAyU2ksnIO1wywzkM
Message-ID: <CAH+fs=_mdbyf+EcUnMSfbk57viOp3SQpbCHo3pRS3UUm0T4vzA@mail.gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Headers-End: 1wurdx-0006xC-V0
Subject: Re: [Openvpn-devel] Fwd: Bug#1143682: openvpn3-client: FTBFS:
 ../openvpn3-core/openvpn/common/unicode-impl.hpp:596:47: error: array
 subscript 6 is above array bounds of 'const openvpn::Unicode::UTF32 [6]'
 {aka 'const unsigned int [6]'} [-Werror=array-bounds=]
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

I had another look at the issue and as it turns out, the
unicode-impl.hpp needed replacing due to a license problem when
uploading it to debian.

This is the comment I added when first uploading it to Debian:

```
 When scanning the sources, the version used with unicode-impl.hpp has
 a copyright header that is problematic with DFSG. There are more recent
 versions of this file that have an updated copyright that are compliant
 with DFSG. The upstream source has been adjusted by removing that file
 and this patch inserts an updated copy. See debian/README.source
```

and debian/README.source

```
During initial packaging, lintian picked up on a copy/not change licence
in unicode-impl.hpp.

The sources indicate that the code was fetched from  a web archive
location (ConvertUTF.h).

https://web.archive.org/web/20041122041550/http://www.unicode.org/Public/PROGRAMS/CVTUTF/

Searching further references, llvm has aa more recent copy that seems
to include an updated copyright file that allows it to be in main:

https://llvm.org/doxygen/ConvertUTF_8h_source.html

The implementation that was in the upstream release has been replaced by
the more recent copy from llvm (and adjusted to inline in a header file).

The original version has been removed in the DFSG source archive.
```

As such, the bug is on my side (the adjusted copy of
unicode-impl.hpp). I have added boundary checks.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
