Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6488606A31D
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bL8eAY/K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Dst+aDze;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KUA9iXI/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B2nzoLxq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gpQWZxjWmp4LKER/cSkBce2g+bOnzV9/LbwHqGIzdlo=; b=bL8eAY/KSMLqld01ed6JNiWrZ4
	Xhp77xn+zjM4FcbCbXbStjZQ59hpTezZEeKVa4bcGMydXFD7hDEQiHC1WoOqjS6ifcbRCk1RWemLv
	0jBJI0NXs0c6/vUoVSkklnmjOQ553a6is64Ce5fWvDdTwQzD3os1zTpRECH0Q7SQ68Bs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMR4x-000000006l4-1fUp;
	Thu, 29 Oct 2026 14:26:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMR4w-000000006ks-0QEd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 14:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8UEocssgwmJNiJH1WdQh+q4zG4Olntj8iHVB8Yn8Uqk=; b=Dst+aDzeeGp+SiKKRA19DcMvoS
 hSjegq59F8t1t8CkeAHHH/fgUN1ZWnpsNPiMSR3CyfdRuP+cLvfk95XmKHmPDt9Q9BVLYlqEiyuKD
 /vljMbBLGljnJv0mi+kAb9w+nOaiC0qljopdgOSl4w345F9PWZii1r6qF9PuGpQs0oV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8UEocssgwmJNiJH1WdQh+q4zG4Olntj8iHVB8Yn8Uqk=; b=KUA9iXI/y8fQ6xMnMU4i51HP71
 loIGUYE+I47BDQ0H3+BNERWslKeUiL6UuHAN3caRSfiIBhvh0EHVCwvOBljX7/Nunt1E6gaxb+35g
 WKBVjaS97UZiIUEqSEjLNLyfiCItzjuqvxdpk4a9ggmdxXszM3nNPOLQ5NNAQNaA5OhM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMR4u-000000001YC-477D for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 14:26:06 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so19757225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793283958; x=1793888758; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8UEocssgwmJNiJH1WdQh+q4zG4Olntj8iHVB8Yn8Uqk=;
 b=B2nzoLxqbgtU96/zvcrzAKXGaEAv7lLMw2L0p/gUn7ubxGOfAKki1Qkqkjl2xmfPPe
 v+BvoC4t0MaI0lebApS94RNYPBsNpDxIKCFf1W99Yew56jRNTxxUpuTwRrQWZRaFwfxH
 GchjsZl66HG3zUErQhaiJ79Uxb9c2alWohUK1aykmdb0qYe1m2mFzpzYGjGtxozBK4fB
 AiIE/Kxnm/aHwCZjYFi6+6T2IuqAodx9QVDpoDRODKA8uJIUpgCZ/3gSyGXQFljq/n67
 EPiVlT4g+A3ydegZ0CGeOjvMMtufpj1PvesEGPjR9/d3HZsRe7VEz0vQCr7yi3vOKoIo
 HIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793283958; x=1793888758;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8UEocssgwmJNiJH1WdQh+q4zG4Olntj8iHVB8Yn8Uqk=;
 b=wlk+NJ5zzP9MeLHit1PlrUlF5Q5ZFkeL1IITAFGkwT0gv1BFI/G3H7dUiApW1by1FM
 Hcy96gl3HK36D91I/QCzfF8KV5IDQN3KBzJU5OU8PwKxIkwyHwTUSOb8brdwWMVTjY97
 CkCW5lnWDoOMYvrWK3DWW2ebqrS7Z4VwZJkA4WdmSNW+UecoxbnEN/3W/CJmuyK1TtrP
 JYGuWBtWi0YKTWW2Drmw1M6csntBW9vt1rzaBWT7yK0jvTIdUEBEfGGu8fAzlipC6fso
 nZK/5xAJUZkSbKdY9T40t4hpYotY/SZh9zN3YfyYYBJ8/zuktle4nyKqMncVJtJRmFvA
 q/dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0Ezrw/GQRkINFF2hOcB3IyK2aSeN2N12jJxocm6MjHX6NLCEIJZ18eo+2UzVmI4Pe5tTMS96YstNXpiCu@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJgd3MfVnyvNRrvj2hKh0CXnParVq8uJZUu4u0N/dBz5puHb0Z5
 BPDFo0KLwFjM+bLUbTxIK9VyzdpNp1rBjbfTUERpVxPat8iP7ZG4SmyMXmyHlWgO0KRalveOy2v
 K6ZtmfWyCvcTf4F3w2DrjAx9nOXZ/tzenyMGrf43kAWY6G51twjU2SpSxeRxUSyLSFHmz
X-Gm-Gg: AYBFou07G9zBaUq4L5dZ6weFXU+8ediLgtK+CsO9GJz7SLFZQoOuEaDnlGbv+1t5kpE
 zArdRCy/pM8YCSSJCcG2GW8w1hm51mxLLMC5ln/K/UQwcKciqeUbGzmQzhG07duF48GToPC4pTR
 FUrFcHweCzrZcCaeIJ6fWJgObmq3kEGqY7ITshr/Bg0rxpx7DSHyOcBs6PudHM3Lanxg1TOwuzQ
 VyJQIbGEEWHWLy06pfGYMnKngkShsXSjdu98dlteM+7pcDkDrXBQjNQG9yxD5mT6ECwj4apUxuN
 Y1pqPmfGWvtVkEGIkksfP2sMIFvOs+3h4emDY1P7CE0Uu+gMFS88jOBqwfcsdhROjY6Xa3WPYFT
 KEnOILdcw26YFMquteFYB15ZXNrEULpldQCD8GGV4QyDufgE0lV5fHzB7p9nUjk3hT6Zyn9XWB1
 CqLk3hLv0ZvBn3pezmWYCvv+AHvvZWo5lqi92ZZnorsWUX4Clq6og9kjeTpDAb2BhKi5EeoOhHy
 wzRWR5BrRyH8l1z41i0fc4Y3PIVIp2+wjjyI228orqxAMs5rWW6KMfN2tZj+U1nhpteUXQ8WB3o
 02gwaQBiGfbWVimwTsR4FdNnV6N/1L42lUudhyogIejQ45oaJ5Tqxxxyn8YAbJSIlyWH46cpEDm
 39o8vbUGAxVNSuwCwfeuXzUuUnCtjb2xqLU3jQPe/fsYHRst/wxvT34Zqpj9RUW3/2rIl6Gp3A/
 J5gLb9LtY298GFPLY=
X-Received: by 2002:a05:600d:604d:b0:4a1:e0d5:293e with SMTP id
 5b1f17b1804b1-4a966c3f65amr128464305e9.21.1793283958161; 
 Thu, 29 Oct 2026 07:25:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm28738710f8f.40.2026.10.29.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 07:25:57 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 14:25:56 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
X-Gerrit-Change-Number: 2070
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2070?usp=email>
X-Gerrit-Commit: cd427dd611e34c9ae67b671e0be9faf0244d1296
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 14:25:56 +0000
In-Reply-To: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
References: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjgxOTQxMDAwLklmMzM1OTZhYmVmNGU5N2FhOWI1OGYxMmNkODY2YTVjZGVkMTdmZDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d5bf7bd1b8f62cd08a583a77e2954a46edb62402-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMR4u-000000001YC-477D
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_provider: Fix
 compiler warning with clang 23
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2561067116302066874=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2561067116302066874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PB/QooroFRg="; charset=UTF-8

--PB/QooroFRg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?usp=3Demail )

Change=
 subject: test_provider: Fix compiler warning with clang 23
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If33596abef4e97aa9=
b58f12cd866a5cded17fd4f
Gerrit-Change-Number: 2070
Gerrit-PatchSet: 1
Gerri=
t-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comme=
nt-Date: Thu, 29 Oct 2026 14:25:56 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--PB/QooroFRg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?usp=
=3Demail">change 2070</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2070?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2070 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Thu, 29 Oct 2026 14:25:56 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--PB/QooroFRg=--


--===============2561067116302066874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2561067116302066874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2561067116302066874==--

