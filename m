Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5E5CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUwZRY3GC4jnDRpnjBDF/ZJTjrgIWH6i7BvoxJM5H0k=; b=AwndmclEW4ZaD+NObM8o8/hlv4
	YqNWuGOjV0208A9vE9g0O8fO/L9LN1tq5RuY+ujqMzBvkbwMydsirfH4/ypSqhByqxYRAQARAlgka
	ME6SVGj4DmEJmdV1wryb84AOIn2rhtZLGMbh3VB44V8A1vIWU6WYNJ25nrDRpXScVVHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIKmU-0000wJ-9W;
	Sun, 18 Oct 2026 06:54:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIKmT-0000wB-2Q
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 06:54:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U/ASblayrPRlmkoDHU5RlpSgVEkA1DhwZzJPw84dc9k=; b=ZhRPGR1eJzKcNV3Q8YXMRrzm0s
 pD+OPbZvMsQ7OsdTs3FR7+MkGiUaQYQdpDdu9VYEts6MqVodbNjEUR3mlewXTtglHZMNUcGTJQIUk
 ebNqrisY7i0FF0P3aquNxlzexjD7bnU3OBo4Aog7cei/HZIyswV+Uj9U63G/848NtDL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U/ASblayrPRlmkoDHU5RlpSgVEkA1DhwZzJPw84dc9k=; b=i
 SJelZFVFGMfk1RDde/WPmgyG4/LGNX+Gg/R369qaoDj5NKPgYTM3bOhJfyJ7Pq2F9YdAUTGPJ7UAi
 yEjZlfg6HsDsPmueDJKAEAScJkJY6IVB06mjq96jlDbH8LnVkJLUAydlXPFEl8ICrh2JIRFgtYf3k
 HIsIRumVbik0nK1g=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIKmT-0004Sh-5A for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 06:54:05 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so4101865e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 23:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792306438; x=1792911238; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U/ASblayrPRlmkoDHU5RlpSgVEkA1DhwZzJPw84dc9k=;
 b=JRseYhZIymOYfamu6wCfP0dkf5BMfjNtvNK/A4eTAWIt8qzkMoLebbuHyDexDiNK3p
 bxizIaSuYUSnCbVGDVziV6ZvwZzCMgK+6IvdmKY08lD6rrTbnTwKITaZiKaSROYLCVps
 jkE95FR5ViS2YQtqbPjbgXaAjavi1Ib5meyxVsbFvcSD8jibM1oGuuOi9e8XW0RU9CkH
 08aeMigre4h+6oOs7IswnxiW2aD1Pk7QdG9G1bIJPHDR82lF8FD0ZBWgKKLie2gxSVtv
 QCom5LhMSvEtxlOWdDy/7DZ7dEdpZawqQuY4aVKdF50NiMlhArAJ35Lg5fdvnbWg3ZFQ
 fhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792306438; x=1792911238;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U/ASblayrPRlmkoDHU5RlpSgVEkA1DhwZzJPw84dc9k=;
 b=RNcM985bAcRcippS8Fm0pPizQ8X5PjLkBBtWhM6ZfKThhWBM2xWteUtnLuMJkq2Vqv
 xohSEHpXL+0KB08SCXA2TCiwRh9U49Zhjqu3Z0/tQDLDPvaiPBoAWgOc3mtlSCUdjBSc
 puaGq1ITmsYQMdHbTF3HnoiCCRzvXLwEW2b46bFoQz0csYNOR5b4c7G5PL6Eyuqk0tCR
 RMYPSGrCkxM80T1JLB32WOtRpEGu6CekvKMhh93ccyC6/IthI1pR0vAVqRB7zZAlT/H5
 0we61QGYEtu0EhTqEFo21SMKlzsq1+XMHrBbjacCxQ5BXeZAE7xwnwrvigc5RK3GYFN+
 eI8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9HXlxZLxudZFANqLK0VaIMNiJzwYsDU7jOoE8aRCowS3gtvYjbMPSh3UiP8+swzpw6u5brDQDKBx9hb7t@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJbMv8rK6lw7cu3Di8/ojnR/FOWnGPbWi7LFkdo8+sjWIcSmKCC
 b3slLV7m7EIUwG5zaMdv3Uo8OcYUoA6Syplg3oy50kMmYdIX0vYFDtJXCoctUvzLb/IDTSN9SYm
 C99HeM3HheJ5shGiNBPv/IIL4Gd2QaKqOpSgfkeWfwjrcDD84RZYjoUzhbo6c1LzJ8Jgx
X-Gm-Gg: AYBFou3bvBdtdVa7itNPNTDt3M7eD+p5nLVtUUKzmnC4HWzaW3c3n2/4dvk7LXeC+vB
 S5Gs0DaIwVAyfLk48WYdUXWf+pkKkUUOId82sT8DDnrvGQl3bRYZJeLeW70YMOJsQstLvsNJu/W
 Ff7KG6dlviKT4dnhG0of0HN5IdxIL+/H+4k/N6DxkxblX9lzr5sV3JcPHMLykL1DKXFD3Bh5Oau
 FzwF9scxUJvTKytIVLExhISLsDD7XYRtVKQSm1jnSmbuk7kDnXwEmn0RTv3N7JeKa6tIToZyMaM
 iWXFdlsJUFKuD0AddzTzN+61rG6vf/w1KKk0nRELDmYyzH8vk4fY0w0ml7yQPTNN5sxLPb+X6Bv
 /YYeRuTS8t9ECZLKlJMKj/M37khC6/EiAlsM1n8LgINExJSeT4VxUzrRAiPh2NpC2KcyMzSHXH5
 s9xktNzbJXVUNGw65xCtn3S8RgUDgv0JZ3WZy7uH/faTNnepGeFAUbdPHbCYX43j63OQ+A+erwJ
 YjsfCfj3pF7UJuRXHWmZeDQapF5zsEYoyDpzJip1ZB6Eas9mZ+jjqE+L3uYPY7fiIub5WLXmExl
 rIvC8yDUFt8vYoyo/z8Tg9FJG8pk5RZSBlqmHB5zSLhUSG/KZ7rEe7K4wh8S
X-Received: by 2002:a05:600c:608e:b0:4a1:e000:71c0 with SMTP id
 5b1f17b1804b1-4a1e0007288mr37877995e9.30.1792306438392; 
 Sat, 17 Oct 2026 23:53:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e2def9ecsm18954805e9.1.2026.10.17.23.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 23:53:57 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 06:53:56 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 06:53:56 +0000
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a2c455d96740e764b08afa627a25e257ccf785c7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIKmT-0004Sh-5A
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4775404296317536113=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4775404296317536113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="719A7Sslk+I="; charset=UTF-8

--719A7Sslk+I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail )

Change subje=
ct: gen-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)=


Patchset:

PS1: 
The script no longer works with LibreSSL (I had 3=2E7=2E=
3 installed FWIW)=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2010?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
Gerrit-Change-Number: 2010
Ge=
rrit-PatchSet: 1
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Steffan Karger <steffan@=
karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Sun, 18 Oct 2026 06:53:56 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: Yes

--719A7Sslk+I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Steffan Karger=2E</p><p>Patch=
 set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2010?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The scr=
ipt no longer works with LibreSSL (I had 3=2E7=2E3 installed FWIW)=2E</p></=
li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2010?usp=3Demail">change 2010</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9=
d17d668 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2010 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Steffan Ka=
rger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 06:53:56 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--719A7Sslk+I=--


--===============4775404296317536113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4775404296317536113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4775404296317536113==--

