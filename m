Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842760A6F4A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nPuagQEZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ina9c5xz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OMJXpIUc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dzpRdlRH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=fi6AddDbm61an7qrPbCEFNg+9r1zoINztdtLxaJKWcM=; b=nPuagQEZ/Cko/mq19CVcjvXZig
	6hVRj49P5+daHoKc59+p5pQ3vvq/kNyHipdmDKcRRvITu16cXvkTz+jiqmQBKXnCoaJ53cKZHvpJa
	tBlCCHJvRNEiPEQzTPwJZB02HA/yDGGIkVEFwLg2RisYXCV6Gxwnis6XxgaTHOaMagv4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVVQX-000000005BQ-3lgq;
	Mon, 23 Nov 2026 14:53:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVVQN-000000005BE-0LPh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8wA/11rgAkKJbnyAaxddkClQ/QfCLFKIXPpN8/2yEbs=; b=Ina9c5xz7ta+wTbvNEIsdUxABe
 qoPNK110ROzwNRSuxXjWYG3/U9i1LKk1Jt/ix0mJdCYDgIlgItyUnNJ/+tP08hQ1imofjZknKdkSV
 2Ucl1nhUPdM19uBQHEniqcLY0Y+lYgzrFfrjsgOXdPL6oFhIG0KL4crfEUek93s2d5X0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8wA/11rgAkKJbnyAaxddkClQ/QfCLFKIXPpN8/2yEbs=; b=OMJXpIUcoz32X1F1oVGome8hf5
 eROv55qHsUmX7yj/zctILITw3HJPo090bcvCMrMY5wnfuD9rCDX/wZ9PFxTrPt3maQM8+ordFkSKH
 EpjTek4hpMBb2wtoJtzph1PLABL/KZ6CcGhSx+Z4bx8CzKCm2mj2yNQ7vqro6vtxR/ZI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVVQM-000000005gw-0sS4 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:53:43 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso31836665e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 06:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795445616; x=1796050416; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8wA/11rgAkKJbnyAaxddkClQ/QfCLFKIXPpN8/2yEbs=;
 b=dzpRdlRH6Urx4Z2I5vZUwlxNolOtA8g//Sq+qUuw3l1VLKtoT2KOcEVB+kQ33tytdq
 2dybO74Roj5/NSEFcSjz+Bk+UAXvmwUARybWYNxhx45Vms09wNOhK5Mt35YyyX7WLS8I
 xHwprdEmgrqDtqD13N2azyOn6JcHHBzFVdPrhPv62ItOQfpElVkqkLOErHv7u9Auychn
 n5WtVICxIt9N14GLIrmAhsgJAbNgSdxhvxmi3iaSKCyPeWQ50eRfYUWRv1ejwcWmJUsS
 BLw1NN4HZgHvDk61k4X/gBcIcsIgt18y7EFyf69uyGcxcj9zOMvbts8UrCuxEUijapBS
 HXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445616; x=1796050416;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8wA/11rgAkKJbnyAaxddkClQ/QfCLFKIXPpN8/2yEbs=;
 b=0XKbVHFVbD6oAUDgjjv1P6EiYO3SUEvMYiuXkX0HvJikU0NveAS69tqvgW81MmaeS1
 NYELc4P8RLk5pVa2mQzLvBAqGzzDy/tsTvG+6Tm8w5o2G4cRe4eSlmB6HACIF6tEtt6O
 a8rqcseSa05NLN9f6Y9NlPtozVeYEBlBSwqgcmXXlbac26lfYgIRGfm5lCnwk9BHhG6C
 l41XKiqD2Hmlk1mRHCYWGHqwmLecIPo+o3jsNGVzoJKbSwgFuU2HliP632Ryg8HtKIUP
 Ik/SBvnW4Im9U74EICbpG+glssb8rwJxCi3zHOr8G9izj2CsdSYCwL1KOrY4Dd6u9Jie
 NkRg==
X-Gm-Message-State: APuU4Z/knIoWBaqBHhR+kasEIVAO9GCmOGUeAqzYNczAXoAQNYS7sPbn
 O2F1gWqCtbJvJIE7AG4jJCqkAYXGKIw3DZcdYoVLa3s7k9NoH7DPw6kArqmrTfDFPcPQDwTWB3h
 gRhflAZIl+ApzbkpNqU0BIKUprj3tYGrebar0QeVUk3khlNSaMc4/4hlanac0Br3u2dK6COwhVI
 mYbRV2sw==
X-Gm-Gg: AZFdTZeb/Y1w2950jD9vydFcn76zaWqVI+5OUJ0AQEznfjQQtQBmF/Uo1ceTfg1oR+Z
 pxouchsf02Txaa0KCpeboK27by+vFpnl7OEPuBcKjMTcaVNPiAIIr/9Docaj0ywzakQd4kfrW/w
 WiDsbH/7ckdUgBAn1dpgqvv7eeyUnYG0Shtr+/xKWwWX3K+PRfgBYl6RrfmN0z40stH13mg6K5p
 Vj3EGtr2BpPLbUs1EtyJqDfBKA79XIpt2bmKw7hJ2lg4B0BuxMVAANrk0W5EHO31yez6ra1UhAR
 kZZ1SfAgOSWyaHx1opq/6r88QiC3CeIdgazAbFKk05qOS60Ajln42z5t2i8ozwL+JVQKXrz68sH
 zS98eGwRKqJZPXreJsgbLQcUOMXv7Z3Zm5comdS24e/jcF5hyKrqKY8/6LIgBhb2KfCQPi+NGj3
 gDOFjI/hsRt5cXCo2Mw633LmBGYfCP03iw2hQDarZ2pfGK0bMmnt7NYZfqe4RPdSIZcR0WF6kq/
 xUmFay1JUbHAtXdTBRI10ycTx41Yycbks72I82F9ZGRuquW82ht0w6Y+wznEcvfpVNAyVF3LPeA
 BwqzqZvXQdvIyNzp2bRmTStYOIDFWeOZutzqMfIiK1KARnGLlJjlIFpHnS1+Qs1xlBGEKJJLEGj
 CdCp01NiRMMg6JVPJuEyRR3zpcspkPSpbwwuCNZGasqp9Q6xuc8K/6c64MwCsyhHjATGguVwvAg
 MF3iB2Efe83wBYgzk=
X-Received: by 2002:a05:600c:4f4b:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4bb888226c0mr287470505e9.27.1795445614789; 
 Mon, 23 Nov 2026 06:53:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm488204995e9.13.2026.11.23.06.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:53:34 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 14:53:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
X-Gerrit-Change-Number: 2330
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2330?usp=email>
X-Gerrit-Commit: 43dc628de9c4f5de6b5cbbeeb767ac0a36e718c0
References: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQ1NjExMDAwLkk5YjJlZDMzMWI5MjIxMmNmNTE3NTY4YjBhMGFjZWNmNWE5N2IyZDM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85dccd7754fec3dfb956f628a28b0b3e09a5b2bd-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVVQM-000000005gw-0sS4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_common: drop
 unused key_state.acf_last_mod
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8447245464379179866=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8447245464379179866==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HKZbrBjQpoY="; charset=UTF-8

--HKZbrBjQpoY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2330?usp=3Demail

to review the following change=2E
=


Change subject: ssl_common: drop unused key_state=2Eacf_last_mod
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_common: drop un=
used key_state=2Eacf_last_mod

Added in 47ae8457 and never read or written=
=2E

Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl_common=2Eh
1 fi=
le changed, 0 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/30/2330/1

diff --git a/src/openvpn/s=
sl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 436770b=2E=2Ecfe3fea 10064=
4
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -263=
,7 +263,6 @@
     unsigned int mda_key_id;
     enum auth_deferred_result m=
da_status;
 #endif
-    time_t acf_last_mod;
 
     struct auth_deferred_st=
atus plugin_auth;
     struct auth_deferred_status script_auth;

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0=
acecf5a97b2d36
Gerrit-Change-Number: 2330
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--HKZbrBjQpoY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_common: drop unused key_state=2Eacf_last_mod<br><br=
>Added in 47ae8457 and never read or written=2E<br><br>Change-Id: I9b2ed331=
b92212cf517568b0a0acecf5a97b2d36<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl_common=2Eh<br>1 file chan=
ged, 0 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/2330/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br>=
<span>index 436770b=2E=2Ecfe3fea 100644</span><br><span>--- a/src/openvpn/s=
sl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><s=
pan>@@ -263,7 +263,6 @@</span><br><span>     unsigned int mda_key_id;</span=
><br><span>     enum auth_deferred_result mda_status;</span><br><span> #end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t acf_last=
_mod;</span><br><span> </span><br><span>     struct auth_deferred_status pl=
ugin_auth;</span><br><span>     struct auth_deferred_status script_auth;</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2330?usp=3Demail">change 2330</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2330?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97=
b2d36 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2330 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>

</body></html>
--HKZbrBjQpoY=--


--===============8447245464379179866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8447245464379179866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8447245464379179866==--

