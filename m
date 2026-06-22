Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757B2CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBSsfmiZttGp5EhOihYkuy1BZY0fbdx7cPnVQKoXzG4=; b=Z7JihpSOJM1XR00oRUYmuYVnGv
	yBLaPx9rGFD3miz2sn2F40FHZUxg4haxXu7r1DT4A0oIdWmPvsnHfK2kutavYH7fj1MCYTcaBbZjD
	BsG42maVXOlGADiZfit/prSt7DX+uDmVDp7ylorrxM3j4HonkuzSz39awouuKE8FcVfE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfUp-0006A3-NV;
	Mon, 22 Jun 2026 14:19:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbfUo-00069w-5p
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=H94/8TGXXyajhcnNqmRyd3ogkl2wDWh0o7B0x5Qfqto=; b=LuHJ/9gPTxwQAU8o4p3x70XqWT
 POemLBDbabyH9ZP9ygexekURLeSPSOFkEec0f+sx0ozXtI1RrfVRdaXFBMNlTAqzaodZZpjXAzA0c
 uA18M8i8+b8EnnK8G9BfMdPb9toq2keStkCVcG99FTfRS1b1KDH5JdPMpCyiTBf0lkwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=H94/8TGXXyajhcnNqmRyd3ogkl2wDWh0o7B0x5Qfqto=; b=V
 3/xz3zyTLPZMw5xc7rD6CoXiCYs/sZDgdb8ULTYWRCdOPbQ8SEhdKwZnxYyGcWR2MtMD1NH04dLm5
 4v3T373iNJvaAQWUrvFNMXLTEDt5er3f325XR3SwgywYqlPG+Rq0mTuvTsE4SYOjE8INRyJvfr9Go
 Ce4HtG+9TF5u0oB0=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbfUn-0003jm-Nq for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:19:30 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-463b2f6fc9dso286143f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782137964; x=1782742764; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H94/8TGXXyajhcnNqmRyd3ogkl2wDWh0o7B0x5Qfqto=;
 b=LfQTzidF1nnvA/VLCrcx/xaZ8LKho2zYrp8GvsleSyQ3iwr6X1CDWiCX8cs+H2PPyD
 HBJ7I8JuBMmWyj1TdeoaiYDEk2hTagA/MRCTgbh1JqrDcO8NDgm4MrbwitpJwE0URP6O
 90D6ZGqkbx6o1rQhbM53CD4q28CoYtri5IddjtEHLn4e/efl24hLpHwm1OKsV7HR7kIX
 +fiJKlQSxZcv01hfwW3tPWX4OJkZxNyZz0SiCs6yn5G2cIxsAH5rez0NruKA4o4JEumi
 Qvqld/1vUT9WGfc21sGpNNdcnYHyJPg8ZjuPN7QTg5ZG0TcH4uEYttjV717arTDoKyAq
 f9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782137964; x=1782742764;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H94/8TGXXyajhcnNqmRyd3ogkl2wDWh0o7B0x5Qfqto=;
 b=dBJ9BrBn4PqEBM9MsADA5X0ITNfzA5aAW1eBe740gNW66DU5KXL9u5Um5BkIGzccw5
 7HWWM3w3yNm8aRlMfKRlBWO6q8y8qZ93MeY7EKpOcrC/2iEPHgACeilQw3Lchv5wZoaC
 M87mXyji3ySHc/6XIQyofW0pCk8hZafQYF9x4bbZh7ZUYhKLzbLqCbB1Tm+FNeykR3Sg
 rE+5gkJOoUOScdksq11TTfcMZ9zQb6/B9wLa/65GEYLW3mV7wa1wviGZKRvAretVZ53r
 YAPGLiXue3R2Q7snSyGG1BY15Q48NNDwKrl2WZcwKC9xw7RzXWi7/KBKvTCH+r+9fgQ/
 MrLQ==
X-Gm-Message-State: AOJu0Ywiu4uaVvGnDNZzxt+1k6GktK5aPjXSjVftzjhVZH2CMgzr8zC8
 UJi7nLWPGc+M8ZxZ5rkX90IUjLrrfLjqr379As64v1pifAILe9kFyDuq9Cf8S+gF6c3OBYX/od8
 9tG7zIWMLiD0HF+Ng//lrgzu8zxxX+5cwbBLLjHqr1XZ3YYYM9mK6ShKXsMssmd/Ly3LT
X-Gm-Gg: AfdE7ckF761T/VU2PlYXz0O5bPdG9JLeQv6Yd578hBYOTuT6wAtZOsVpBwM0p03NYrc
 jv7u/bfHcjhXPDlde6HgaPz2iCvZboggLbcUiObcA3K5ajed/Krupx5eVOfGqFJ5xmVvNbTh4xx
 q0lj1o3YuFfFHIG64Xj4Hb4URq8Qh0L2KjMwsn7WUY9zcNS1fj1UQhRBWmssgVq0MCX9evdmy8G
 8waMBza6u4i3xzYG3Bep7BOX4WpvMTCwMI/MctFiP4upVobRruQcaPgqtDXUV69tKhZyTBhkDzv
 7Mj/poeocAjVy2+k3w0HvPbbgmC7It//3NX3p0c1UpE/pihaefm5xvlACE/6VWv0BhMoIwix0pg
 Pr1ImgU3lrvsT7boYuBi6B7TQrUUjs0jNyxeYLfbDTQcGwdouMaBL4EmC44CbhahE6tGcurjC8V
 32LUcJ6bkhCNfCX4XPD7lCpPH9N1qV0mnE6/m/q5ou6nwy3x9RSMs5J1MGNlm6YeAueP4XE8+G2
 Oh5tPfZUg0cIJLlLASMegg1tkcj5YaTfSV90s4sLmxWXk6qZXJc3GQvmorN7HOdjSHTBauW0hIa
 QG/F6yM6Lfbt2g==
X-Received: by 2002:a05:600c:5285:b0:492:4640:cf59 with SMTP id
 5b1f17b1804b1-4924640cf67mr214627315e9.36.1782137962479; 
 Mon, 22 Jun 2026 07:19:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492492338e5sm240742615e9.3.2026.06.22.07.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:19:22 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 14:19:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
X-Gerrit-Change-Number: 1604
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1604?usp=email>
X-Gerrit-Commit: 70c1193f3ee2877cf39ecc947b7c2101a3a3cb41
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 14:19:20 +0000
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MTMwMjM1MDAwLkkzNTU3NjBlNDNjM2UyZGEwZGRhMGNkZWM2ZTQyNTNjMDI4Y2VmZTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d2aebfe2c75a25444b9edc49f087199ee29fcb1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbfUn-0003jm-Nq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 wolfSSL with CMake
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5618292610925831859=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5618292610925831859==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/+tSAqqbkWI="; charset=UTF-8

--/+tSAqqbkWI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1604?usp=3Demail )

Change subject: Fix building wolfSSL with CMa=
ke
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 3: Code-Review+2

(1 comment)

File CMakeLists=2Etxt:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1604/comment/6124305e_08a5b1d8?usp=3Demail :
PS1, Li=
ne 328:         target_compile_definitions(${target} PRIVATE EXTERNAL_OPTS_=
OPENVPN)
> Since this is originally set via config=2E [=E2=80=A6]
Done



-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I355760e43c3e2da0dda0cd=
ec6e4253c028cefe38
Gerrit-Change-Number: 1604
Gerrit-PatchSet: 3
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Mon, 22 Jun 2026 14:19:20 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=
=2Ecom>

--/+tSAqqbkWI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1604?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604/comme=
nt/6124305e_08a5b1d8?usp=3Demail">Patch Set #1, Line 328:</a> <code style=
=3D"font-family:monospace,monospace">        target_compile_definitions(${t=
arget} PRIVATE EXTERNAL_OPTS_OPENVPN)</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Since this is o=
riginally set via config=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1604?usp=3Demail">change 1604</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1604?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1604 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Jun 2026 14:19:20 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--/+tSAqqbkWI=--


--===============5618292610925831859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5618292610925831859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5618292610925831859==--

