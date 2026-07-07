Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB9CC43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvNVQrtLVo7frlkgv7LLCTLDaVqgW7PG8rUL6pxya+U=; b=l9UJVbCo0lWCXCEHCfOB48wKd3
	j/Sii39ll/9q8q7IBRdV5r8zRPDOr7E1HUO1kCy7rxm8KVp3JH1t9zWoNGmwBKKiN704kTQhsyBEY
	CtIM957smxZbSdwasK2FodFSKgpsdz4H11gXuIDRGQsGhnU0t8ysbdyYFPYgRYSt3dWE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wh1Hs-0001Kj-1r;
	Tue, 07 Jul 2026 08:36:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wh1Hr-0001Kd-0d
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 08:36:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=B1s2Zlqr2nUAhJ4B93XXIjnyIaWzyTD22df+klLy4jU=; b=Djkm4tdGzXl8TlVums1oNMgtgl
 Ecx0ojYLIMflykUzto88od1Jh60blGeh2/9DNctaRYWmy+bvrTpRU/nQj2svBUEV6ctdrVco1nMV2
 8Xp2kJTEt3rRc/rebGHt/rIAeOiRlCYIUDCQLZLQjVo+hAj0JcHk/kcmMUSO4LYqZoCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B1s2Zlqr2nUAhJ4B93XXIjnyIaWzyTD22df+klLy4jU=; b=Y
 tpuNJH458VLx2RWthAdlMdunz4r/j1tSSIFmEes+A6tPbLKzgt3ry1FP4A/ak6vhMZ9aDMsPBrcVO
 qHMTN+zlSPw8QcxKAxtEKvLwL2DLo86Hpbl2CZc0JzgXf9thUO5rndJ8aUpEY8q3zXkADi/rsenu8
 BQXXirYOgexQa5Js=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wh1Hp-0000DG-CG for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 08:36:14 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-475417f010dso2113118f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 07 Jul 2026 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783413367; x=1784018167; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B1s2Zlqr2nUAhJ4B93XXIjnyIaWzyTD22df+klLy4jU=;
 b=NULoIgX3VrWIrhkE0k0EttgZMXc0LhHCagqTTKsykErSsjKYAHQDT0I7mT39PUy9Jc
 oaU+z6AImp9wgNICcZPZmn8LDH346+aeGe3bsCthyM1UQkLadfOfs+CMOtt9I00tQKWe
 VVYhH2/gV6zzbfw7uYJt3EDKzhMFfibM0v48kLuHPkB3t7SqL/Br3/Hf7HfnT0JX/vFg
 ikdFZjuxUxX9MdDH4dMhfpbXMJUrPhKJhb6IJQMnC9qkUMZQF85WHq6YwFK0a6osTHyc
 GPjwYouo0dWn+f++TZrV8cefAGSgPrkszN+ikFjwtuiDDlkscERP+qlDe+3sCKYTaDa/
 duxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413367; x=1784018167;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1s2Zlqr2nUAhJ4B93XXIjnyIaWzyTD22df+klLy4jU=;
 b=paCYDR1sS3aRd0OFrOGJbtb3Y4bSXCwRXTadaGz0Ie4Wdb7MKhM+ByYXCLRKwtt5iz
 nwQ742CoSUjSdL86/Rd10gBrS9j3CPsdWtfcz132veo0dYuRg9wJYBGTtyGvxgMh/gwU
 sAGmDanmAF6UC0l3zi8rjoHcd+/ztnEpqWnxqmqsM1GCIq8rhipfGtW4Ookyqjkvb0c0
 LvSnz4+ZTSPe+5Y5QrRNcbITznnWFivF8PriIc0XN1OaoH79lmcuMUwuyqXSP1E509ST
 JKinFkUdbgF6c+AiBVttlvCUZR16ngyTFI+CLFn02wQoEZobsAgGyPGYSyg1rMbw0hky
 vBqw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3zylOmLnMv2KcfdgGOlTTeKGANACfKkdseRPXOdw5rzbpplFoUWYX1oW1Vg8gmls4DSxluvh2Mpn8Vl1I@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzRE8AHyjcr0XjnBXd/i8QwA8RMuuLumuL7hmuA1ZuREyzR9ARr
 RGQJ9dU4Z3otWTt2yh8019FTQeku177hHT1OUqh/AFxZ7rBWgqgKJiUG5Fz0IvWMas2X45P9n8m
 b403IUbo6QfxE+If+YLXSCoFm4lby3Yg9vs1bMROwcR5m2sY4fjuO0gKVxoVfdd9aHVk8IDiwk8
 tDGyoKOA==
X-Gm-Gg: AfdE7cnS4//DYgshxEaPdg3Us9uG6sGD+gulPc53/TnXQZ2j+Xl5xLMXVyCq1/QMK7o
 je4vdwoDs8acNWAYHBhDxz3jg5EvseKRC0h3fiLJ7IKxT2ZjF5A0jyfrQYt4+orG3M50urnLLfe
 uVkEfVoAnmFif0YpDBq5eO40ZrvzjJY2arq0XQHrAmetdh6CUOM/yw7W4j3aKLv0hGkSBNJYehL
 uHPCcebe61xmuHy0Co/IEp91V82gZFjIPLRAJhuc0ra5dnqvV+jHQuGf/irlgtdvYGxvoSiK5kf
 RAFiJ+ZITKMMYBF5dpYjb9B0DpfIPsbWSXyF36xjCNX1ux/fWutf/7B7wB+PxbT/NJy27BIR1Gk
 a7rynl2ND5KhRIPKuhFmGlLsb1Hs8MRANkOf/nD/4S4tiigRXT1jKZLrJGqP+lzdsrkABqdB4fJ
 +agivWTYBXE/+KGBSc5+LXi6JHf4uibSgKErbAsKEZe7ILCoXx92ymWwNUYHcK5tFuFY48HD46G
 haA+LMntFyeBMpCarIrde7TJfrTfs3RLVukvjGHYaQ1+SYQB7J9EiOgM7Jm/IgeOFpXe48Yhrf/
 9pw=
X-Received: by 2002:a05:600c:820b:b0:493:b771:ddf9 with SMTP id
 5b1f17b1804b1-493e19a75f2mr16164725e9.1.1783413367181; 
 Tue, 07 Jul 2026 01:36:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f294a6sm79682895e9.1.2026.07.07.01.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:36:06 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 7 Jul 2026 08:36:04 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: e3676dbba60cf1e453dae83018200bf362eb604f
X-Gerrit-Comment-Date: Tue, 7 Jul 2026 08:36:04 +0000
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2bb1eb60b1eff057108c5b625c5f83c217c50ade-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wh1Hp-0000DG-CG
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1268061362274808205=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1268061362274808205==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PeExcfTk/iM="; charset=UTF-8

--PeExcfTk/iM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici=2E

ordex has posted commen=
ts on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1478?usp=3Demail )

Change subject: tls: reject incoming reneg request i=
f primary key is not fully valid
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchset:

PS3: 
> Looking =
at this change again I realized `goto error` marks this scenario as a fatal=
 error in TCP cau [=E2=80=A6]
I agree that ignoring the reneg and going to =
`done` is less harmful=2E This way we prevent reconnection bursts=2E



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I704c560fa23c03237d0f8adc=
30908a617265a5a1
Gerrit-Change-Number: 1478
Gerrit-PatchSet: 3
Gerrit-Owner=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: ralf_l=
ici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 07 Jul 2026 08:36:04 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ral=
f_lici <ralf@mandelbit=2Ecom>

--PeExcfTk/iM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1478?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #3:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Looking at this change again I =
realized `goto error` marks this scenario as a fatal error in TCP cau [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I agree that ignoring the reneg and going to `done=
` is less harmful=2E This way we prevent reconnection bursts=2E</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1478?usp=3Demail">change 1478</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1478?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a=
5a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1478 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 07 Jul 2026 08:=
36:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>

</body></html>
--PeExcfTk/iM=--


--===============1268061362274808205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1268061362274808205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1268061362274808205==--

