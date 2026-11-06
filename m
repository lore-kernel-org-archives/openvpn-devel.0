Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6A606A338
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hMTNk13x;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NDPI7Lmy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eM9G9t/v;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U9UDDCwj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xCW8QnSU8J9IWkgirSuh4Tt7UOo/Ne/woLWrRbIiHyQ=; b=hMTNk13xgvQiLONp+lhI1iehpS
	dzxOBonav1W56aItdreMCaRepjhvnzwxH9GlqkaT8TS6vZl0FsL7ztbUG4ydfmUcCnSpdOjfN5TDA
	YMlJ2t8GmXzhsKpOrPRQAq6qsgJTzA8bV83i1SQ6mp8LvS9+fiz6ihJtN/gQ6VHoVaCg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP8db-000000001Ib-3MMe;
	Fri, 06 Nov 2026 01:21:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP8da-000000001IO-1Ogz
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 01:21:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Umwa+BmdN8dDqET9xq6cIWAq220nFZ9v5ZDvRVj7dq4=; b=NDPI7LmyUQKsV0DeBE+ysso9u8
 T9FoEDgLslr9b6RVwdgzfSK6Md/MROHKrk5ToLcnT5Ou/dA1sbgKC/ldCLLpBq6/uF8qbFDTRNEiM
 viK0Wh3/PSIEUhSB8StqCpPXn1T2iPONqLxN+Vf2uq2Hyl9zlKAH5REn+rtYuNl/h6HQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Umwa+BmdN8dDqET9xq6cIWAq220nFZ9v5ZDvRVj7dq4=; b=eM9G9t/vOh6ucgfe3bOSGWzL7y
 iT9mQwa1KyjBJ4SzN5J56iMDleszV2xxuplUsrDcJan6o0YIo0Iea+7v1oJRrgEyGQ9sRWU3CSYlu
 nf6ha4mIZxaMAIttquaOJCxFh9nlcmznkkyeHEoD7QRK9wYakAZnX9yF1gbsQKrJm/Js=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP8dZ-000000002IH-0fP3 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 01:21:02 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4919a880834so68856f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 17:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793928054; x=1794532854; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Umwa+BmdN8dDqET9xq6cIWAq220nFZ9v5ZDvRVj7dq4=;
 b=U9UDDCwjkiwMwkddlicMKmsZkg8QxAZH8FL832OQVB//ELEJR3zAZium8V7PaVN5Mg
 FSbSNCx5vwrNLANwYJ0JOuzeFVNHV3rGI+pvz4xMBl/ebcM/vEsRRN7KrQ/gcu4G6Yc0
 5nOGAghQPtRJwToOsr4AciUXO+OIdTEGpjkXhEmArXhYYlLHxFuBZixkLipX9lM21SSS
 mIMhDgSbVhGGxDlu2EJnr53zNG/i2AOuZSsFvSMto95i6kS7ywLtsOnoRPNVxcoouOE7
 ynwMAZNEACHoDXuHF6c3CtkWTKhs6TJ6mpU+4qDrRTtQSbvrkBDNpvm4ZPWxxd03C/G+
 b1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793928054; x=1794532854;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Umwa+BmdN8dDqET9xq6cIWAq220nFZ9v5ZDvRVj7dq4=;
 b=l1zWOvjjxNxGvndOSegRCEvhM2ZYlNvad8g0lRAxWNSYzGLtH/AYcKyhXrgJ8Z1WkF
 XNuNpIBv+EoNc0GWOcvWG2OUJVh/xKhRfWR8FXhYZyMXKGuxAVFynmTt7w0FOzLkaZXv
 hrxBe51ugF9Obe22LJXBIAUGM5cykKZ+T+gs7Gf4HmMrDkfvSw5x7xhCebIKIvnaAT6J
 UqbGa9wLPwsiFWmhKAzHeEPV6OHrTcNIqc8KbCo7ELsS0RNjB9noBbBkVuHeocnQKq0K
 BaqgVS0GnpYR82xBCzu++LaD2nmPCXP5feJBUEatTjNb7P8GzzvrN1blWRwmgoDOm8wW
 4T9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8HETPP+YSmf9j4IYgyqEwPbKVihHbIEnmDhwT/CdEAFHpCPvQlBRizOW7aBKumFr13WomLyNxiDiR8HOH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Bv8iGA/8ubPymrfif4KqHgqLTT9tGPUi0sF9ER3Wz/Nz1YRXX
 tTRb9/cI87pcG++8u0ZLV94ntg1casxStgFCU4w8vp/m/jw+wvnwkHRB6Us2i4EG6M+5ZEM/zGr
 p6P1v2GYYDPN3g+RGXXo0nHb382K4qVth+JdxhQU5BGYMQwt4m2MavuwU47XVWG+vCkVHshnU7i
 W2jSI0dA==
X-Gm-Gg: AYBFou34pWr0dpTUCnEdtwneFhpL+icRbQ5d5I8BJ1h3cS/JSoz0aITVnv5++0QiRux
 2HqseGtWpQQmeFo4Jhfadp6uiLFSPmpLyp6DOq2YG33Jt5ur6N2YBdISDBJfPLuZ2w780tP7gVi
 74imUrMdRo7+g2fikEoYhDESdYVf3FCraEKfEz0XVw6L5LffcHvhG9h7vyoJAsaqHD+tv92yOjb
 AP0dcRBjQTlpzWxM6cD4IJXR6gmqDcgCxkv4t5esrDTCB+X5uoGw9b5M++UvJFgWAwcG5vC6tll
 ZdNBdwrgrVxHj7NtCKZ9seXYbIQ5K/5Ouy4wd4dXm/zj7PK+bhz3ln22hXc4DYna6bLil2qxE4c
 cysVnQ/KYsjKYTTmObZW0G/SuKpcwWJQfx2lop/JJN6uhcqSrkcwgZ6pQhEjFXfSpKeauf/6/ol
 5+3lSftapdhqScQvOh5WoyZ2hCAm7Fp9ZcoDSwqsNca/haAYuHe2o3l+qAgwtpGR/AWosmfzGkR
 dBGw9lIzNULIekThjRxAUfnkfYMiURx832kIIlqZr83ppNPUEpnlCqTMub1ZO4XnWSaEe4CIMsg
 Eet4e0Gi3irFp+8cBngfa2MGx9L4UpojMZpub633RSd9hW2sBmiocPlcaX1A8SXIYXEbBtVWFv1
 ujMa66y5Z0HxJj9s5pjNoWLw/WIrxIMWxygBjPDUYMZ4G4RuCxdi19MelieOf+G2f9JNhM+dime
 97SOONeE0Hwc3wPw==
X-Received: by 2002:a05:6000:400f:b0:48f:bc05:76fc with SMTP id
 ffacd0b85a97d-49274bc8358mr2435373f8f.11.1793928054428; 
 Thu, 05 Nov 2026 17:20:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d3d609b1sm550514f8f.8.2026.11.05.17.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 17:20:53 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 01:20:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib65ceb898d23777663c32241156d597918a24ffb
X-Gerrit-Change-Number: 2114
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2114?usp=email>
X-Gerrit-Commit: 2dea0d7f7ae25baf03867e3d5e92e34703000ca5
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 01:20:51 +0000
In-Reply-To: <gerrit.1793747232000.Ib65ceb898d23777663c32241156d597918a24ffb@gerrit.openvpn.net>
References: <gerrit.1793747232000.Ib65ceb898d23777663c32241156d597918a24ffb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLkliNjVjZWI4OThkMjM3Nzc2NjNjMzIyNDExNTZkNTk3OTE4YTI0ZmZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21dbf9b6acf0bab7f96632c0ab086465b5c449ce-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xP8dZ-000000002IH-0fP3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: don't
 stop if the next pipe instance cannot be created
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6031904349499434748=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6031904349499434748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QzUXWaQ5jGo="; charset=UTF-8

--QzUXWaQ5jGo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
eiko Hund has posted comments on this change by Heiko Hund=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail )

Change subject: openvpn=
serv: don't stop if the next pipe instance cannot be created
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment=
)

File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2114/comment/422c3e91_66c74142?usp=3Demail :
PS1, Line 4093:     =
             * Drop the client and keep listening on this instance=2E Handi=
ng
> Why no error logging here?
All conditions leading to `next_pipe =3D=3D=
 INVALID_HANDLE_VALUE` are logged inside CreateClientPipeInstance() already=
=2E Logging here again would lead to errors being logged twice=2E



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib65ceb898d23777663c322411=
56d597918a24ffb
Gerrit-Change-Number: 2114
Gerrit-PatchSet: 1
Gerrit-Owner:=
 Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov 2026 =
01:20:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--QzUXWaQ5jGo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Heiko Hund=
 has posted comments on this change by Heiko Hund=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail">View Change</a></p>=
<p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpnserv/interactive=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2114/comment/422c3e91_66c74142?usp=3Demail">Patch Set #1=
, Line 4093:</a> <code style=3D"font-family:monospace,monospace">          =
       * Drop the client and keep listening on this instance=2E Handing</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Why no error logging here?</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">All conditio=
ns leading to `next_pipe =3D=3D INVALID_HANDLE_VALUE` are logged inside Cre=
ateClientPipeInstance() already=2E Logging here again would lead to errors =
being logged twice=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail">change 2114</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib65ce=
b898d23777663c32241156d597918a24ffb </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2114 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@=
openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Nov =
2026 01:20:51 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div =
style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>

</body></html>
--QzUXWaQ5jGo=--


--===============6031904349499434748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6031904349499434748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6031904349499434748==--

