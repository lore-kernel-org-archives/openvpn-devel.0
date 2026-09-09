Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E25AC79FAA
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MOVOoku+qirDJF3nUmyNKpUAXt4DdNEsnsT+BYcQ/rI=; b=KnyPZ16bVRDGiyPiHtSsH95btD
	4BlFthQNYNyq9u4ex8yJmyrWLZskVAkmGZF0BQx9RiaZK2/ziFRSRxAqwl/Yuj+bzYpebJUnh4hix
	etcLvpuvF6ssYDXPRpkInejZMk34FSqn7iOCzHYdvAuepdipoNlR+xeCnzO4HsmiYhFU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cio-0006DI-ER;
	Wed, 09 Sep 2026 07:27:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Cil-0006Cr-K9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AfFwWo74nkI7So0wIONcmaxIVlwM9eIXaqRborcgE58=; b=T69UXrNEm9nu421ZrEAMsXLj63
 zlxGJ8S3gUiIUeNw78I0HE3GlorjP7xojDokPSxXxfZaL0oLMme7juwWhWlEmzRzCyAOMjo13xhoz
 3Ef8wxcZVr585MeFmFiFinbNfj7TbYZpqnr1ug88P7VC0Veah9WPxkVbh5tflqR9+UOw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AfFwWo74nkI7So0wIONcmaxIVlwM9eIXaqRborcgE58=; b=M
 wvXvjjz+OpmIzJu9X1yYu5H6W4yHqUWf47AAIyHPL6xV2e6zJxJgDzyL70ZUsVZCmXL+U3DKkhAqs
 I0yfcLO9BpR+ZIDwH39j9POeNtH9J8VgJuGWOcmXbwrGB4VzMB2KNb2nbFWHvasO2FByfMUyl0dmE
 x3DOM9gxccybRTT0=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Cik-0006cU-Ux for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:52 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so44340845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938864; x=1789543664; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AfFwWo74nkI7So0wIONcmaxIVlwM9eIXaqRborcgE58=;
 b=aNxULO0V4mx94TaHFDQwKgMGYj/Xc31o41JF0KzwW+4z6xpYg4QszO6omjX7t2mlyG
 hngAwOMOKqMVd7DX5vYIXltvL7HdIxhiNOqYE6T3OfZ1/EfCS41VHVmOLJWNw8cq5Hl1
 DYyzqow7+EYzE+P52KysUQSiHmMH5yPRdiNeR4uEQ0rVqLlQ0JkNwaVDwce5WEqYL3Q4
 MwIQcICa8ZEb+WHMtxg9yb18cERqAq2HsvtOahm3oTgbzJKVTL0u3KqOxBGLs6yWCq9s
 SQ+xjeAbqh1YnWXt/K9g9cCW9353d/kkZ0qNMVF0oo4XiXbsqhfuSP+hLG/SZAGuKDgh
 TiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938864; x=1789543664;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AfFwWo74nkI7So0wIONcmaxIVlwM9eIXaqRborcgE58=;
 b=KfAHmLyffDogYAQiXP7o3AbOB8OMycwn3CHpwn7lJ7waVdNhdgHqc111Unn3z0hUVG
 LyUeuxJ9Po8KHdVoK7JKal06TOrS5bhTKS1urDPThD7nkktBo8yAZFiwp2eKJU1r0IiO
 RYm7MgMX5F3DTroSuPsQorO29ToPCGdjUh54RO+DY3AUbx2oHPJn2wtGLhojmwXaiji0
 X9BJgE5dJSJ8kSHuCAT5o76gaN4y38hAcuJgHCcNBJmLLSEnj15dfX6modATZ/6nKGw4
 LcYx8ZNR3dV7XB175143VSk0pXUulZ5VlnQ/lmKRn+A9Gs7B05FkSXUkZDTAIJkXRTkY
 KpRg==
X-Forwarded-Encrypted: i=1;
 AKwUvByaIW36lahlLyJRY0Gs2j5fNuoI/F6NtxW/7G6Z+xzBQ5xmspdmN4KQ85YUdL27RmVjm8JSqgyb5dSUH7t/@lists.sourceforge.net
X-Gm-Message-State: AFuF++nYaWOQ1kCK/BfxiNpHTpas+FUISkIn/uicrdFGfjDfprgWyg7l
 xzRwWF99W6Ya8hlYH60gkfwhFgZ6lgq+hunXjh6xtOSGHxXClMKWLRYXhmEUhN4u4m3xlv8wE3b
 sBvbRoekY6ktXfDdGjGn3Q0oZi6/LUJd637AfKzNaD7nO65N3QAOGiwbiLs8I9VOtDDW3Wyh13/
 17j5BERw==
X-Gm-Gg: AYBFou2dRcHeznfLmxLbT36zMDIiH+AWDEoCZILo8wqw07f/hWNyYxeRrKBPYpHgtA2
 XVBd7mMBaY6kl3cj33Wa65IZtVqXsO8UaukzzUQhJ5rBCLKUGpCUHNNk1iqIZMTTqjWnx/lMjaG
 wCkSv1S32Su/vsQegvbE99g2e2PvKH/MgpZIXDA6B4fkdXEZJFFBhDiG3ta/WOf2BGk2Z7oHQm0
 kWcATsYj/Y8/WHLl3h9sW6ULi1Re5jBQN36BFodGifiSWa34JgtOoSYAcBrYlBhEn+zEHvkMFsM
 XwmMdxbXBasuoMkSWll+o0kaJC/kvdz+d6T/W8f0ZJck7hlYbtgb/gCDqcwxKUpHa2iFMZC79Lu
 MeHaWzKx2AoFlETqNZkJzXfKgiiVsgQ/V3hItyOHdE7s3XEUMMuFFE0VSCf8eukENoaoKIaPuAk
 KB3Le+JdFXiDDDK7bS/16yZ9m9qiymIhEo0gjofuV906gf55hla5j7wwLz+gbFmzjfxguFiOrB0
 W6c8pMuosIziBDCfN+pTi4U/vTiWACf/r1I73Iz00An7tFTHm/VPq5yWALygCeFvFQgrqFVbyA1
 AiPxLt/wC6dOJ5RHPQq2QJaefTvaT/gqBua/wcAziGi9WM5IrlHg9Da+uEayhQ==
X-Received: by 2002:a05:600c:3115:b0:49c:e1b5:b2bf with SMTP id
 5b1f17b1804b1-49cf7f48645mr333309265e9.0.1788938864208; 
 Wed, 09 Sep 2026 00:27:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff8195ffsm402178865e9.14.2026.09.09.00.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:27:43 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:27:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 8cf9b7955aa320f7fb32dd205689c8c577bf4b43
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 07:27:42 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eabfa7ab9856ee4348f35a25977db9d9313ac5ca-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Cik-0006cU-Ux
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5796760960755371629=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5796760960755371629==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aJ+44XjEIdo="; charset=UTF-8

--aJ+44XjEIdo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER=
_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

(3 comments)

File src/open=
vpn/oob=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/fd4f68=
ea_bd0d1921?usp=3Demail :
PS12, Line 118:  * for the probe_parameter TLV=2E=
 TLV types other than probe_parameter are
> nit: only unknown optional TLVs=
 are skipped; unknown mandatory TLVs are rejected
Again outdated comment=2E=
 Fixed=2E


File src/openvpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1742/comment/f35666c8_a66e6fc3?usp=3Demail :
PS12, Line 116: oob_buil=
d_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t window_s=
ecs,
> I find this function a bit confusing=2E [=E2=80=A6]
Agreed, and done=
=2E It is now oob_server_probe_accept() -> bool and touches nothing but the=
 payload it reads=2E The caller in the next patch builds the reply=2E


Fil=
e tests/unit_tests/openvpn/test_oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1742/comment/1e643339_ce98958d?usp=3Demail :
PS12, Line 419:     s=
truct oob_probe_reply reply =3D { 0 };
> Zero-initializing the reply here i=
s misleading because the subsequent asserts cannot prove whether ` [=E2=80=
=A6]
no-op after API change above=2E



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change-N=
umber: 1742
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>=

Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mand=
elbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ra=
lf@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 2026 07:27:42 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ralf_lici =
<ralf@mandelbit=2Ecom>

--aJ+44XjEIdo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change=
</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742/comment/fd4f68ea_bd0d1921?usp=3Demail">Patch Set #1=
2, Line 118:</a> <code style=3D"font-family:monospace,monospace"> * for the=
 probe_parameter TLV=2E TLV types other than probe_parameter are</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">nit: only unknown optional TLVs are skipped; unknown mandatory =
TLVs are rejected</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Again outdated comment=2E Fixed=2E</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/f35666c8_a66e6fc3?usp=3Dema=
il">Patch Set #12, Line 116:</a> <code style=3D"font-family:monospace,monos=
pace">oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, uin=
t64_t window_secs,</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">I find this function a bit confusi=
ng=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Agreed, and done=2E It is now oob_server=
_probe_accept() -&gt; bool and touches nothing but the payload it reads=2E =
The caller in the next patch builds the reply=2E</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_oob=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/1e643339_ce98958d?usp=3Demail">P=
atch Set #12, Line 419:</a> <code style=3D"font-family:monospace,monospace"=
>    struct oob_probe_reply reply =3D { 0 };</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Zero-ini=
tializing the reply here is misleading because the subsequent asserts canno=
t prove whether ` [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">no-op after API change above=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de=
810a8c2f68c30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 174=
2 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 09 Se=
p 2026 07:27:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<di=
v style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>

</body></html>
--aJ+44XjEIdo=--


--===============5796760960755371629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5796760960755371629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5796760960755371629==--

