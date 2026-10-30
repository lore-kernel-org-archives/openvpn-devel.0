Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055D606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AWLJSB1A;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aiZZyYJT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FRpGyVd3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=g22ZgCry
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sn83rco25SUFY/ED1iSfWWT6LPrmAhLNBRuek2i3E8o=; b=AWLJSB1Afefkj+tnz+ReTF1eFX
	+jLRUxzqnKMZX0u+bPJny5tod+J9R7Zm0+u2P4KsvoUnucE/UTS0oZU7U1sfCoZnanweSfnDdOhs4
	5sNCnrcE7rzzih275i+QJEAp+wAU3+Hn0C5vNjGj/Lt8UG+BwjVxhqlv/2pnglKm+GAM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMthI-000000001Mb-0fpX;
	Fri, 30 Oct 2026 20:59:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMth6-000000001MO-2qKc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 20:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VOh5CyX5IGj32EV7f+aiKmrhNRBQiQLbZiqx0NlX9vg=; b=aiZZyYJT8zHauinSbN0TaW93Bb
 VYh1vQjFuYL0RPVmwVEX415oWbrbdMUKdK8BxXA42BhuySMP8LE2LIXef7qppawu3+HMLd/s+7NiZ
 Q6nX1z0MMZN6GPRKLZ53ecn5Urv9NAJ/gJD3tn3vv8uNQGsrIimc671bNqBtRweIg6Cw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VOh5CyX5IGj32EV7f+aiKmrhNRBQiQLbZiqx0NlX9vg=; b=FRpGyVd3keTwG/tpXiD4KHjONq
 krU6tZ+GAbYnBpxe+4TBDZ68MXqlgTpqrhD+45+KSWzlm18SMPGiVKYt3d2Olt8iY+umDLs3cjlhj
 4fzG7DpGcq8zxK3Fq3QDvslVzjig9xyLFKGVnieqjInCWbitDnEEwZaKaGSITif5AGos=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMth6-0000000047F-02g6 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 20:59:24 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so11386515e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793393957; x=1793998757; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VOh5CyX5IGj32EV7f+aiKmrhNRBQiQLbZiqx0NlX9vg=;
 b=g22ZgCryagq6Yi8aqxMTJSx9Dem9XRFYwOGjScoAwe9rawuvoWFVf5YxFBRh/zcz8/
 Y7AZW8PCfIlgPF3kJTpbO7JQD0+PWvrC9SlK1Ad+mc9oXHOZRi9hFqk2dbADVSpAwzAg
 t3uJZ0aKTh55YYgzElm472LpXNM9Ad173f6PVQxPGmny/moWvPVTy6ZkTfLuC6rF7PFK
 DvqG6GeNOO5TIe4MMKWQIVMmo5FT4gZH9iZHUO2K+KhA1ymfzxwDqY7qoUKPE0fHOBDZ
 VGXbcWvOTCiZSR3JAsWIs350Bh7PockNzmZq5U0iAvYOjopbFEcwpGBs1sj+2m8v5p+n
 Bvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793393957; x=1793998757;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VOh5CyX5IGj32EV7f+aiKmrhNRBQiQLbZiqx0NlX9vg=;
 b=nCArSzEdrRgB3QOxktRaN8G2/gMy6RpHlk2eAvd80t41qx7+T7ziXRL2/1/AbxvKYG
 J9YAy1HlL81NIejajhpLjY2hQO6vixrhbixz3kmtQySKjEAQ2sIKvF9Dy8fZnMPD/nWL
 G6IlFT4hyptCWWA0aR3UxmgISzrh7EImUHR1v6bb+9Nnf+V+sbpl9I7cmwIhzQUT+nj9
 2xnowcL9r/gaT/Wby4P6968es8ucsa/BsrcZ5vdrfyA2ngBEr6ELTbWOLzxdN/9XxfMo
 oL5CGqaa8yyGglTXMIBBoVRKUwbnft0XYuO6AHM9RhuREBabpLova0zkWR7qTum5cjjc
 chTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWrkJm4PMk+947mWGFlbNAW51JOdsr51ZyYZRzsJ1SNu1YXLlXsl1eKyLI/Tt4Xs+qlCBLebETTiS/zxuO@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJJWTeKT0Zam7ecTcj99ciTbM7A1iyaEvyr0uaplLyb9RFQN+uD
 7jW7DxbGRcyhipsUfHGnypRI3THoUCPZdSTLo5dR9WimP11XJzEAcXZFY1JAHbogamEdgXo/FGU
 KAdp4B+MlSy/+SOm0q6mblTTlfLB8n37TdJxgoea9dXNpRZ4Hf9nxZrpTUtgQ9nOq2Ryk
X-Gm-Gg: AYBFou0NBePuusOAg1Aq5h8No/DZ/BwDiLOg6UGb+toodjiFf0hOWt77/X5Wd/WIYLV
 PNNAl5WnXp8MOWnPl37T04IVknhooTgTWuNsrwe4OFlUXt67kp8LGLTQDMwLDOA9krrpdeVaWZc
 0+eh+XvRY2NsH90yuaPtOxdzImhJWrCy/Fk8XrUxg4BkELxyDgbiUkbqoIcmSE8uE6/l+Ut0pr3
 LtOnT/np0SebmWv8TkaOGUtdOdSPnjZ4AhKDZKSWRX7JlAGhFfBDFoClvHBWMq8fL8qk3x0KRSK
 SRucJDH3UTE1nkMohIuYvmiBVVKyiwFC846ZUn6UlbpveNJZ5vOUTQOAYZBzuZSA0FNA8pe1S2V
 lEce/IBIbnR9d+btt3v0n/QQohVNxuUO5wwIxKVeSWKrNo/josxFSJtpSEBuq7v4Hq8ZQEadS/f
 BpKiSzUW1qMjucgkKWWMytKTscwZIrcYVHKDyw+Ebee5m8RukDUvesLSkIy2VVg/gWWdM1caGxW
 JjMNPnN6FaIGfrOtKr30lzM5KvaeLTmxqoEZO29pu/84qrLCWFekV7T5H4wF0i8P2IFOI46eZ92
 fMom6YUEYA4f7JSpCnU3dgaqFDuVROk3C06Fa2L/lefAiraDHMdHqojI/vh1DQr44roI4IY4+HX
 Nt1OfweKNPO2j7qov+yMp3ANDY5TG+hiYdQB97A+Xc505rpx2WMVObSCt7ZPjxkcSoyJwVN6fsv
 xLZyH0xDNPKEThrRw=
X-Received: by 2002:a05:600c:4ece:b0:4a3:5a42:b2a4 with SMTP id
 5b1f17b1804b1-4ac185bca52mr78921665e9.12.1793393957348; 
 Fri, 30 Oct 2026 13:59:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe885d91esm61244885e9.0.2026.10.30.13.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 13:59:16 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 20:59:15 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
X-Gerrit-Change-Number: 2073
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2073?usp=email>
X-Gerrit-Commit: fcd51de7b4ed18d43d6acdec8bf148cf6323ffeb
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 20:59:15 +0000
In-Reply-To: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMzg5MjcwMDAwLkllYTE0ZWYwODI2OGU2ZjYzMDllNGJhYzRhY2ZmMjc5NThkYThiMDQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73c6cbbcd5b86bd0d6cb23297862871a7206e4dc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMth6-0000000047F-02g6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Increase the buffer
 size for alert-message in management user-pass query
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2364880939694483342=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2364880939694483342==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rnx2ON4Ecjs="; charset=UTF-8

--Rnx2ON4Ecjs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Selva Nair=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Selva Nair=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail )

Change subject: Incr=
ease the buffer size for alert-message in management user-pass query
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review-1

(1 comment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2073/comment/57844a87_beb7402a?usp=3Demail :
PS1, Line=
 3685:                 if (!buf_printf(&alert_msg, " UN:%s", user64))
`buf_=
printf()` keeps only partial text on overflow, so a long username sends a t=
runcated `UN:` and squeezes `SC:` out=2E

We might want to either size aler=
t_msg from `strlen(user64)` and `strlen(sc)`, or append `UN:` only if it fi=
ts, with room left for `SC:`=2E

But granted, this is probably a corner cas=
e and most real-world usage fits within 256 characters=2E



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958=
da8b045
Gerrit-Change-Number: 2073
Gerrit-PatchSet: 1
Gerrit-Owner: Selva N=
air <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 30 Oct 2026 20=
:59:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Rnx2ON4Ecjs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Selva Nair=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Selva Nair=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2073/comment/57844a87_beb7402a?usp=3Demail">Patch Set #1=
, Line 3685:</a> <code style=3D"font-family:monospace,monospace">          =
      if (!buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64))</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">`buf_printf()` keeps only partial text on overflow, so a long username s=
ends a truncated `UN:` and squeezes `SC:` out=2E</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">We might want to eithe=
r size alert_msg from `strlen(user64)` and `strlen(sc)`, or append `UN:` on=
ly if it fits, with room left for `SC:`=2E</p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">But granted, this is probabl=
y a corner case and most real-world usage fits within 256 characters=2E</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2073?usp=3Demail">change 2073</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff=
27958da8b045 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2073=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Selv=
a Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Fri, 30 Oct 2026 20:59:15 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Rnx2ON4Ecjs=--


--===============2364880939694483342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2364880939694483342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2364880939694483342==--

