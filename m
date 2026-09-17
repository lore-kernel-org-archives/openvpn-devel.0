Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B9BC982C1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pR/msQQHj+lkZq84fgK+De30iJNNAcEnfizJrlmuHls=; b=Kc7Y63ucSbii2w4t3pMuj/3wsR
	fRdwdrViBArHF0WBZfAN7DhZQD2OgAOT/mXjxN/qww+p/HAoul5aCpTfhF2mN7L+rKvb2SQhEN7kR
	3CtRn8DchuQkb4aHMyJPvTFXHrQDJVlB55bx3F6ETDfjdoz5+AVgCBuJ1sY8X7us9T7U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x76j3-0006Bk-UE;
	Thu, 17 Sep 2026 07:40:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x76j0-0006AE-7n
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=r2lZgREcFZkYUbV6yhS1MQUkFUtMLEscb11+W9W83kc=; b=KtiCKb49DQY85N868MHpvQ4Dlh
 G80nvVsynbq6uSSy+V9lTyoL0Rf8Jk9PxKdG37olQwGRgrdzWdaTmwY+R1RG8ZyZrvH4Jtr93MI/r
 09J90PjgaVcBMk7Xv6VnbEfBII6ZVWULOMxUx4e112zdTrp/CybB/ujRSU/e2TGFPXJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=r2lZgREcFZkYUbV6yhS1MQUkFUtMLEscb11+W9W83kc=; b=k
 9QX6rV/AO7fn1jRuJGsBDHD/DR6zB+WSjeibnh8WDeRS0b8fE3F1PpZQIsm0yKv73zSwulji1ZsaL
 e/p6DI3nbf6UwawXNSSpGehYSooXhHdp3n+cY89c7Ac1rdv8dAWgIsQa2kMDkGdZJSj5rpAARH0DB
 gRmNcHlj4ZIn/Efk=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x76it-0004de-BC for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:40:00 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so3769235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789630793; x=1790235593; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r2lZgREcFZkYUbV6yhS1MQUkFUtMLEscb11+W9W83kc=;
 b=WMFl/wibueh3nxv+aqA2EssmjrAA0KsWFDrNpK7YPuWsnmANrIEpjICtfWkIO4SRof
 N7sCdwaHqHW+OsoAbk0za9EeAbHctcv5225Y8cVDVo4YRazFKMKTH0qSKI+4r/FlRM6H
 7GewDAcZQIhb2nijeUJi6giVKF1KDNOyx1obv8+Kc8vVsklQ9HFDVNsOz6Fni8lz76gS
 Ehb91QiH2QkB4NPGvHXaNxzgw0p2iSVU5oE0MpJgyVCGLiPpH/KnyYfvI7w+FDpzvLqH
 e60XPjdBubmWqlBrOTLGxY5w4OnnnnX9KPgEpRFXxcSJag24nN5Xg3ZGlPxora3gluzM
 kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789630793; x=1790235593;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r2lZgREcFZkYUbV6yhS1MQUkFUtMLEscb11+W9W83kc=;
 b=AgTRcp3sqf3TtkVuhGiSy90esFhfI9lifBp5gKpxuVUYdKuiFQj2HPKkAk+SgmPtLn
 ACrfTp2nLtcybRQjH94ubBA4PDTSMBQ4TbXVhKZX0cTfcG7F+6DWGCzEw+XJ1iYWhwrA
 pFzMookQaWZWIo0XuZ9PsUA8RZ3JVrNpxaJ115yWAsxxZXKQXXeVYeo14x7zcVzM+qr2
 62t7Vy3fsGxqxx9pVcrz65lhcv8FhvSDTviCTEJ2Xlf8rhB/iDhfBUE2eC75uiaf9UFp
 f9IhfVtAyQ3UY9TyzRX22jlkLm8yYGXAXl4cSI5C2xP0lZc5iG3gaBkMOS2k5wzrBTXx
 5M2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1qt6ZlgwPzk1YlnFqvGAh9xfdtwiQ5C+k71duzHLbTySSiZoWeQ/gMQQRqzsweD7Kznn22zlJo0pmnaiV@lists.sourceforge.net
X-Gm-Message-State: AFuF++mOCTTx3W5i2EFa6abJ8Gc84+AECHWA2I6dG1/V+eVYYsyTMo95
 hJbkap2fU9lMowLw+wGNpBIATrG+G0AcyOi8Hxmo8xE39cQM0UZ/jyVAZaorttAfywFfmP8CYhD
 NA1nEe7HO8mg+W0Ou5f+fRqR49IgDQ5JUzeyOov1t33SvXbkeJUpIN3ATNAsWk+vh7TqT
X-Gm-Gg: AYBFou03zv8OSv4NBTcNdvZs1J3/+GTDHZbc0D2MICnVT/jN34pqWFj0y4+YUIqTAv2
 nrDHepg/u2t4rPI0lvk6km5k0oEyRbdHAU0taK4wpl9uMF1K51Tu1C8ehlFd2fDiW7O8cLfrvxQ
 hJ9pqD90S98y4qpft1IjMNY47hMCFuYfTb6FeQjcHL6M1iIJmtkH+2jwNYfD4jbhaDTkRS75fBD
 KxbpE0dHARArD5drybdSMQcJ3UwR5dzy34dAcbmkKmh5M5YR8WfdlCgXUv9ntE+OqJ1vEnuWZPX
 6v9mV0fs4HQYlv5wOVuK+MY6PoG0fAlHcbuYRJhTDV/0icop2Iavb//P5+sE8gTsRH9cZ4+gsZx
 +c18gKwnTYnPlxpZazBSnwDXBQCQbtvcoJXQDLkb4OEGL9Qs0F7TUx9rhoZXcjrvPA5f0vehljb
 XaPN4rFiNqBus5widp6iwnQbveBvqG3X848H39uoHrx7zrX9k+Uh3Vak7pZloEySoCn9eEKyI1m
 zUq/ZZ0bNpwteeHv6bRzjO38WJGMoOzwFU4Hj+J+aQjz6ySpuXZdH8GvOR4Az5JhAhOKa1Sz9Pn
 rK/JlDaitM7v5YkG6dzwKLXvNDgb2qVbJdSD9P+IgTHpE1dwKckmjNjceWdvqg==
X-Received: by 2002:a05:600c:a14:b0:49d:433:c3b6 with SMTP id
 5b1f17b1804b1-49ec053a640mr66799335e9.27.1789630792671; 
 Thu, 17 Sep 2026 00:39:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd226ef3sm52764035e9.1.2026.09.17.00.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:39:52 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:39:50 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 555fa6dba7f577477cea8b5730f56d9b27967792
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 07:39:50 +0000
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab6abe3e9a8214f69b6cf3ab0447b7744705549d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x76it-0004de-BC
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Probe every
 resolved address of a remote
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6353700556983584101=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6353700556983584101==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GY7gu8jvKnk="; charset=UTF-8

--GY7gu8jvKnk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1751?usp=3Demail )

Change subject: oob: Probe every resolved add=
ress of a remote
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 26:

(2 comments)

Commit Message:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751/comment/e15eb201_e8d127cf?usp=3Demail :
PS24, Line =
17: first reply for a remote wins
> Does this assume that every address of =
a remote advertises the same priority, weight, and latency ma [=E2=80=A6]
Y=
es, that is the assumption: the addresses of one remote are the same servic=
e and advertise the same values, and the first to answer speaks for the rem=
ote=2E Now stated in the man page and the commit message=2E


File src/open=
vpn/oob=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751/comment/bfa1f4=
c9_5d495a41?usp=3Demail :
PS24, Line 200:     struct timeval sent_at; /* wh=
en the first probe went out, for the RTT */
> Sharing one timestamp for eve=
ry address of a remote might be problematic=2E [=E2=80=A6]
Right, the share=
d timestamp measured from the remote's first send=2E The first-send time is=
 now kept per address and the RTT is taken from the address the reply came =
from; oob_probe_rtt_ms() with a unit test on exactly your example (A at 0, =
B at 20, reply from B at 25 -> 5 ms)=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Chang=
e-Number: 1751
Gerrit-PatchSet: 26
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-=
Date: Thu, 17 Sep 2026 07:39:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--GY7gu8jvKnk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751/comm=
ent/e15eb201_e8d127cf?usp=3Demail">Patch Set #24, Line 17:</a> <code style=
=3D"font-family:monospace,monospace">first reply for a remote wins</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">Does this assume that every address of a remote advertises th=
e same priority, weight, and latency ma [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, t=
hat is the assumption: the addresses of one remote are the same service and=
 advertise the same values, and the first to answer speaks for the remote=
=2E Now stated in the man page and the commit message=2E</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1751/comment/bfa1f4c9_5d495a41?usp=3Demail">Patch Set #=
24, Line 200:</a> <code style=3D"font-family:monospace,monospace">    struc=
t timeval sent_at; /* when the first probe went out, for the RTT */</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Sharing one timestamp for every address of a remote might be=
 problematic=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Right, the shared timestamp me=
asured from the remote&#39;s first send=2E The first-send time is now kept =
per address and the RTT is taken from the address the reply came from; oob_=
probe_rtt_ms() with a unit test on exactly your example (A at 0, B at 20, r=
eply from B at 25 -&gt; 5 ms)=2E</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">chang=
e 1751</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1751 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 26 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 07:39:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </di=
v>

</body></html>
--GY7gu8jvKnk=--


--===============6353700556983584101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6353700556983584101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6353700556983584101==--

