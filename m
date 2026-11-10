Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C04606C678
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a9Yk0Z+0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MbfFOnKR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l2n30IN1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=afB+IVuv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4/V5S79LMqh5zmMAsOf1+OcO2XbVqUOZptWbs6Fo158=; b=a9Yk0Z+0FeO5muxJwAVK6Ls73n
	9DQpDMyOChP+0WZxD5HrsRXDKyv5tag9KAjcsMYVqr9hcxVKFBPLe6EKVGJwcRrEyPEDiqlMrsscA
	cO3QDnL9JFzVIXCS1L4mSdhiIBTL0/VO1Ql6mZRpIqluS4ge95czzvLxxo1F5KxZt1TE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQiBT-000000004Iw-3xVL;
	Tue, 10 Nov 2026 09:30:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQiBD-000000004Gm-10a1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mc6NVegBOlfR+tX9TwMEbfahD1t6bZFkSFLjIwnG2YU=; b=MbfFOnKRwYrn1RATmecB80zq7Y
 /HCf8VEpcA4nL7vgeK3V7KrF3DE3quAqJQ2K+V/WZNNC9/J6yxOJNduFdeTfTviJM+wlvriQZ1efu
 hfaEZpzWQoONZb1l4IXTj578tVXQHxW53xgLnGCe0v/nyowSlnJIA/qpmbID4DyVzdD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mc6NVegBOlfR+tX9TwMEbfahD1t6bZFkSFLjIwnG2YU=; b=l2n30IN1qoTgbseRGN3HgQt9z2
 O9/qnqpfk1k3sRaDTT79ZH82D9rxQwIWjHIHtyaXVD8Un2JUfReA3xGTIplk9MeQdMLRXBh4Ka2Jl
 YB0lWaEnFXr+NbNYWquC9WfdTHGY1t/DT/rG4EWMqwJXtaIguJla1jDOg6oJTKFdbsAY=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQiB1-0000000025Z-1r7G for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:30:04 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso13532045e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 01:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794302997; x=1794907797; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mc6NVegBOlfR+tX9TwMEbfahD1t6bZFkSFLjIwnG2YU=;
 b=afB+IVuvyGyommMv8MtA74EzfK8trVzpz5DEhzl6NNhU5D0h4Pv72gw4GUClW9hyXz
 boSqtZbQXfiWw7n7iwvmG+eu+/yEk73k9oaRiA44vHtKy75bZrXiuL3Bk3BM5qtTCE7O
 kXb8Jr4BoEAXqCgaxi3IX5865QvM2tY5tCgwsX/lwo86uZC5rkuHPl2I5ZyvBLeWXloY
 NzOtuMW3cluR/HfQvELuiv9N/NLpR3d0QU3EGA/JXK1+M747czDZ80dDdcdIZjz7haPo
 jz4H1F0ISwAVkOZxICnZCcpJ02VQmmfUxp/0ULZsLkBgEGqqM5fNiMOjvgMvnAvqj8x8
 Dm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794302997; x=1794907797;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mc6NVegBOlfR+tX9TwMEbfahD1t6bZFkSFLjIwnG2YU=;
 b=cWkvrexA74aHxrre7Vcs5g/hZ3vdvWlYfwZdOT29qCO9wkPlX3KAzzrHUhMZztcERB
 H03ROQF6Wa90WKLOXbEuEWQPwh/0xRZJHuBzGAoK5Bc+HpxZjZ5o/UtH2QGrQWUP2JrS
 +y6YJiadv8Ea1EzMGuALt5E1vhz4iRcZfqDIUREk+AWdoztmFycLBUJFy8Y4Mvt57eY1
 JDA4RRjtT3hEGgl7x8pcAm5+exc1wz64glBhweVwZpCUdmPtPGdzYimXLwu6j0BiYfZu
 U/7mbuUQ5ppRyqc0uS/9C4VUjUgPIEOfww0tvVQWQFpO1f2Vx4QCn3Bi7DLsTw5MKEwb
 IP1A==
X-Forwarded-Encrypted: i=1;
 AL+hErFC2rLBlGDYYbveECEJUfFNEzpIgBK9KVrOg2VehJkZduDBqaU68MgP2vfDiUfEPclQXWPMaXMNyCWGDBpr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9WgYn6Ty7PKR1INeoBj5Dkx10LLAFdXkjP/2CxV57JsW7kVfmr
 /icXe4V4b9V5R1iXmrKha6xwaeaf2PWVlwt+K86XGKICS2TEVo7Yrn2i1QZXIow6buF4C2ykmFn
 en1y2tRlc/ovYU1pkBMfB45zxniwBVjtZjclFxynckuirzThrqfKXQBcizKm3Zg5UnQ7f4vtbSE
 HVEXel0A==
X-Gm-Gg: AYBFou3BQ0bTdYdF5AC2/LMr2nF/pKAzWAPWe3b+k8wm5h5GheVg4k2YIaMKXnPrvy0
 70iRJD1x3FCeeSDxaxHaeKYbMrgCzZ/uNwDE3jw/3SuqBbzrtoXozdwHiKASfi84C93JHGUIRtG
 S32pKmoTtBgJP5D9YEAee8meY1pH7oLdhpDhV8pO5paWf8VS8lQ7wbluo1QrZ5glz3g6KMIzYjv
 N4ibxFufY1YGNuczYbK14A+16klZ7cGR/ldqf6JECMFn5p/XrxlKhyv7qJlGRq4/hVIBVhtwaQP
 /0oqMziK6RR07XiDll4W/zuDDeayahQS756I7DTiiOeeUoVZdn/Ex6hMzeEuYey5fKgZ9ZrSYKt
 fJSANTLD+ouOsm1Sh3yjENe+suVDpaijkiIOlkA1nQ/Eup6QmvqS4bYboDxVsvhFjQvA7KZgG4e
 KiEAGZDjiDXmJ4F3eXx9XH7MCNUCl/KG7hcrEvBgNcjNSZ0fC51BbZd2uxd0lS0CXe/R6ujrquW
 Ijvnv0AH0spJknCAUTzTjrFbJScKkNIijtLjSfsBUKUv6xfDUFWlMXQFrrdZPDTa1cG9E0zn3Qw
 NwaCWNJvC78PKG9TRY27un6akU20C0/BxxKzkJBzt0ZqLtbzziTKZzkF++6TKPlJcUbmcGfB+hh
 iARSqA0KR+5dV882SJp0fzSZnqycSABrHTQc5XWMrx/X3ZXwH6yhIJfc7A5fraGe+6tCZMmuSNw
 6dchaGYamG6gkqHls=
X-Received: by 2002:a05:600c:811a:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ba02348d9amr28996995e9.16.1794302996702; 
 Tue, 10 Nov 2026 01:29:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba020485bcsm47915045e9.11.2026.11.10.01.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 01:29:56 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 09:29:54 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: 3102b510fb9b835cf3ac6ef32e41b44a0e112b95
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 09:29:54 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <14240338434188f626dfc68c295a800f26e1036d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQiB1-0000000025Z-1r7G
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5056326794462293685=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5056326794462293685==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JuIHyQ5t0eo="; charset=UTF-8

--JuIHyQ5t0eo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Ralf Lici=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux: enable RP=
S on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: -Code-Review


-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
G=
errit-Change-Number: 1991
Gerrit-PatchSet: 4
Gerrit-Owner: Ralf Lici <ralf@=
mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 10 Nov 202=
6 09:29:54 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--JuIHyQ5t0eo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Ralf Lici=2E</p><p>Patch set 4:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #ddd;">-Code-Review</span></p><p><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><ul style=3D"l=
ist-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">change 1991</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I97c55e211f9113d0=
90808724ab43cb3c94099fb0 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1991 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartul=
li &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 09:29:54 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--JuIHyQ5t0eo=--


--===============5056326794462293685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5056326794462293685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5056326794462293685==--

