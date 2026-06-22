Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CC5CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5z0pJBsJIFA3jhMB/QrX/j9gQoecqeyX9qbitkuO2SI=; b=Igayn6c4002USzBIFq/I7bur/O
	VhsEnWq2ckphp0tJw8m5Vlm2T/TD06mA9dj0fgT+2n8R+cVcn5U1jF+YMouqkESaQzrPM6iq1ZNNv
	4naUNq1bxAjNNJhViSQQjHt605eciqX4DqE/Fc+uhjGxf5EN8KSzilFafj4B4TAEIYnc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgKm-0001Lz-7i;
	Mon, 22 Jun 2026 15:13:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgKk-0001Lk-9C
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:13:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cnxqWAIxljgeNbpO0YZKpVVlUrLQYG+T7O1lWfxXHCQ=; b=PC1ER3qioQE8Prae62h1nK/RLA
 vgAjMahNckRD0usqNEhN1WwE1qSxC6Y9iU0skIhR6Qap9uDhefbZanDZXfXmdjVTbKRgch5PZNpzl
 XaM3SgvaO5jl1AJhJ9mmhoWaU3Q5Nv0G50ugKRCm3NISS0yQ/f2lLS66Y75DD1Jsgp4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cnxqWAIxljgeNbpO0YZKpVVlUrLQYG+T7O1lWfxXHCQ=; b=C
 TXa2lcH84L09y8p9fC0vCGo+p6DS8//Yd0HHXkFVkI6Fp6NeKd32KZjUrfEDpH9eo8M5nvF3q8bIn
 bpH2D1/ggQgniE8JV2yIL6Wo1CJSD1PZegkbeuisHhwzrkKfXeqo9WZn1AmdNNdC666A8QxERCaSn
 RB5aW8LQDjL8swis=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgKf-0006kO-Ff for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:13:11 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4629051c946so3338952f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782141174; x=1782745974; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cnxqWAIxljgeNbpO0YZKpVVlUrLQYG+T7O1lWfxXHCQ=;
 b=KqNGF8haYX70F0nQyusC+spLuVhrSfmxHV00eZOXX/Arh99/6oHczJvYnPBy60N6As
 zHDGRuvDDywq1wSnft6yKCWEbp+TpOzbhLLSPMu+4wZLJ574ryv6pAH02TRW0iNZ8WM2
 1FUcKtc8oZvj3htepA5Cd/ZudouUTmrrsRgX4cYBCgzXXms4/G5NVUcNJRR7gpe2awIQ
 necj+NlpgO/OGmzXtS3J684W9PppjjMabCiFNTxrsDi/NhvROo3ZOMrvO5dtOl/lyg1t
 EgXvUfe5woalOwgNW9Kh01a6YWfg1mCQLrluXLyd2czQlndWmrIrs30BWyOIPG6hvzvQ
 edyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782141174; x=1782745974;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnxqWAIxljgeNbpO0YZKpVVlUrLQYG+T7O1lWfxXHCQ=;
 b=U2OU/V61Z/CNi2hwKWeG0CpFdlQDF5jt59egExQ+za1UayQ65miPAzLChlTMlmljdA
 nq50DmUJokZay7C0g+tJ6uIuO2k/GufgIFufHODnsAbrLnZRO8m1d15o86UF2p6h/3NV
 idOnf0IaD8uSpFxXUiNqbwj78yhnXQB2A/U0ga29zlugrPt/rF0BbRLJ8hduxsMWtpFG
 qWJjYE8QiUcjpgXX/Qw9ukvxub7bDB7QytmcrbXbjyCEXrCD4/O7ZX5tnAQPv6qtusuc
 t8ct+wyhjHfUdkKBY1VFzigGPwLWa8wSFZf4br7rAeGgl51f0NKOwHcJPWtkYZwf3LZD
 tAZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjdyFGuNAqyIxHBBxH53tmnuXmVuQ72f1Z/L3+o9LTDD16TS1F6Iic9RQR92mRje089qsQNbVHYSNXSJKd@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxomtCTk7gKuXt+z7xMh1UGzeWk1ADo0k546XKZqObvlPCerm/E
 aT22l8a4sYyFmQF0PrCxMvf6jliRa7Cp7NL/BKdw+cPE2BVeb7RpYE566CfH9w7QrzEk9mFrto/
 SV65pN0Ac9/c6MX05/fF5ynROuS0xQyLSxZHLZLqIAqg23vZI37t3heYzA9Ho3dRzc6tuE1120q
 b1lTr2vA==
X-Gm-Gg: AfdE7cko44Kf0EmH3Ba4vqXvnd/TgYc1mlqQNDtAhghdoHzsjIpqf+HkXEWzWdkIxBt
 QsP2r2kx58LbmSVVB6FBl8lzc58HEcKGJCZNX9miMHboK+xMUadPnDkukohreiNRmyaR+LC26ZT
 /CdjBa77SCyN63gWXhYdHtyn5cKXmUriVxVnhw2rxNobQV6K4+ZmaBCkkjjPaH7yiu7dlnQLuf7
 /zzQZCSUEVj6CTM4O5g3OrLJo6Eq2r4UE19gObh/Sb8YiTHhA2vONsVE5PorMbgX/7Zk0NnNnmT
 cJUr1rf+vIP5m9gAZTQFO1zmJ3yxda+1ODXMRqgoqoFq33pxCPJDa/PGdbsJ2hZIKkiqmOstKBQ
 C1VvFY57UQRBWoB58w2G7IF+lM2ET8coidlrrQ42nMGJQQYs33fUlshJ9/YT8aOGw3o1rCTO14w
 1lOtbmPC8OlkBJEKVRqFo+RvjnKqK6xXrJldN4AZnvUc30Dtcs/4QmdeunzS35TYrYaB4BEeyS9
 YIBZQvr/m7+NTV7PWQ53/9Som8J6bg3O9KAu3djbyvzhyGPQ4eMW/lGCa5U+Aq6EIPMFRyqFaAM
 40eRT4X2rFAnNg==
X-Received: by 2002:a5d:453b:0:b0:45a:5392:3a19 with SMTP id
 ffacd0b85a97d-4651dd1d5d9mr16437281f8f.16.1782141173304; 
 Mon, 22 Jun 2026 08:12:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e3esm25782129f8f.8.2026.06.22.08.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:12:52 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:12:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
X-Gerrit-Change-Number: 1570
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1570?usp=email>
X-Gerrit-Commit: 17df5a96967aade7a3a3f8c34e78a3dc466a708a
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:12:51 +0000
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkliODE0MDEwN2Y5ODE2NGQyYTJlMTc2OGE2ZDhhYzY1MDE2Y2Q3ZjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fdda623f348f7e3a6472b3437961699a1ba7d939-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgKf-0006kO-Ff
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash values
 in our hash map from uint32_t to uint64_t
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4054641480249171084=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4054641480249171084==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XRHAjKmx5r8="; charset=UTF-8

--XRHAjKmx5r8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Demail )

Change subject: Change ha=
sh values in our hash map from uint32_t to uint64_t
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comment)

File s=
rc/openvpn/list=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570/commen=
t/3e51a88f_b3749820?usp=3Demail :
PS5, Line 37: hash_init(const uint32_t n_=
buckets, uint32_t iv,
> any specific reason you removed const from iv? It d=
oesn't break anything, but looks like a spurious  [=E2=80=A6]
Acknowledged
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8140107f98164d2a2=
e1768a6d8ac65016cd7f7c
Gerrit-Change-Number: 1570
Gerrit-PatchSet: 5
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Comment-Date: Mon, 22 Jun 2026 15:12:51 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichten=
held <frank@lichtenheld=2Ecom>

--XRHAjKmx5r8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/list=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1570/comment/3e51a88f_b3749820?usp=3Demail">Patch Set #5, Line 37:</a>=
 <code style=3D"font-family:monospace,monospace">hash_init(const uint32_t n=
_buckets, uint32_t iv,</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">any specific reason you remove=
d const from iv? It doesn&#39;t break anything, but looks like a spurious  =
[=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1570?usp=3Dema=
il">change 1570</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
570?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1570 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Mon, 22 Jun 2026 15:12:51 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--XRHAjKmx5r8=--


--===============4054641480249171084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4054641480249171084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4054641480249171084==--

