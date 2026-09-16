Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F84C982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BauRKI/WjRj7/wDgkCrboZ9hppJZ/LEIxTeeBGrsbR0=; b=Vl18Ec16ydmVnRjB0WAZrJ6Q34
	PbiY7kH/rLogmphSYrsLC/fECnLohk+mOoffJD9jMK6aIb0Qjiw2BuO3emhW7EPcTR1GFPrqj7YjC
	iLFIQiqPiaQCZlUp7qwA82KriwVkMJMgyrT/zBHSoa4bloLne8GqvWHxWHDEJT2fscIs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6rpj-0003iZ-SM;
	Wed, 16 Sep 2026 15:46:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6rpi-0003iP-4W
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:45:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6EBCBW9xJyx+Pt0h5+iDevlMKfBM347RfpLT9p2Evag=; b=U+lVHI9bBMcW6DZ5dlTcINCvb8
 tznxNzTeLZhoHZDj3kyiJb3RIkCK4w7P90z1B7fHJdouYQXq1x6xXXPNooYLrULezHIiod1xfuZ4l
 hMV+pSqFg4l7UHVnLPSbcuOn++x3qjwOvqY6+WDaq8jDsekVEFYCifmu7pKGs6sJP8Nk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6EBCBW9xJyx+Pt0h5+iDevlMKfBM347RfpLT9p2Evag=; b=A
 bPKUhLp9iy2Ob+mNgyRhxiMShtzNDlSiPdppx94yU3SIQKWLDYtEGmuuezfmhHEi4bNQVhrJjzjY9
 d15oi0f4xl1mOVnVmFivemNycAXzjjsJbUTkDNNHMxTG+lXA8RuIYojEBx0DXexAp/lSOeSTb0USS
 zIidgjp8tdKmm17Q=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rpe-00043u-QW for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:45:59 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f88so635463f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789573552; x=1790178352; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6EBCBW9xJyx+Pt0h5+iDevlMKfBM347RfpLT9p2Evag=;
 b=Xl8QqFoWt32qtHYBUiP4SoYxMwDcdMFy4N4zNfIKfDHj17gUqXFvwanNyoU846WoPB
 1P/RNSxHwrPrf4YqrE8q/FNEStcl8eD9Lk9lJpAeJpL4qecy+nTpoyYHQGbSxmS+K6KX
 qU9qjIoAPMAtypGJsTO56PxgmMjYMTAX7pspFLd3Bo3kEMB8jTchbMsZg+0D6wKwGjTU
 p9iKNLaCy5RiNyWp1eSlHyLfTiawZ4VlMLMxaqXWGsWgQTINJwON/rfDFpoTLUeSEj9a
 pxwv97mplcdHASVR75ZrGuXaN16K1bfKVtXyYEtS8UfRitWaPpyP6wsMZ5C00TXdYEGP
 U12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573552; x=1790178352;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6EBCBW9xJyx+Pt0h5+iDevlMKfBM347RfpLT9p2Evag=;
 b=OKb+fZpCoC3IL26Oxe+irwKGpPaTPVVRh7LdT3A8oRxCGG6Pr2Mz6UBsB9TNa5PPZl
 Y3hNIA8LyPAohcd8RzsIkKLQ4DTDsEO1SjQIaGak7HU3+QnNyLd4gA5P/ElMQWprrszB
 ECRreFFWk75Pw6J1NkoyN+Sr09coqJwoOzK/CqJYud2OF8s5/ilta+OSmri5LiFplglH
 RWzx39W1PxuGr3P6aFzhZxpy139W4kWch2tbsiegBuWFTZWUnL/vZ7JfJXmTmyokX40M
 nv3wx+XQmpQF87RCszZa16UR0m6UjplWo4EavIEqgPQjKK+OZa2vkdE1Uo2c+eGJ5T7Z
 LJew==
X-Forwarded-Encrypted: i=1;
 AKwUvBzerTL6XTeQM0ReM7oJfIK+hBrGB9ZSYxrrjdOV8G892kMognd8pZLzatnFwVuqWXxhPp40cy7SlUxmLJ/s@lists.sourceforge.net
X-Gm-Message-State: AFuF++leYkKf237bLj2o79qXmfDdzQpz3rCax2wmQydoGuFIdjEFsyPx
 OZDXc2uxWkMaA7SjNDd2MsNEX06ziwDz3mHFPQyz4LBQ330dFAnOPKj6BMDciF6l00Z1HQa2Ro8
 MH3xCM4aOlK++lAVYT3pB9BQuzbiFClIKk7euo7b0MplLu9KXanayf41luNlMpkfrtztWBlNo4B
 uhL6Icng==
X-Gm-Gg: AYBFou1uOv19dPgLUtCLjoWyKLvkz7AnMhFjWJ+yixZaU2UJXN74SUceEkajqxwgOS8
 RsvQsYi6Mb/vfkvfNgb0DLz1rTYbjwwO5vsNg+yaMz72N+tOVGgH5Gkh1Egfmgs31fF4UT7Cbex
 dmVMdzZ1Sr9TEFiiZqnOYDyKB89/ysdUod06LeciwbiM+l71PfgLR2mdNJv/Y4VPpsOsXcutdYj
 0aAjfHCu0juYNnYm8zhrsHc/Ek84MQKb8ik25GnrHF3FbN6VsPcvNjUx2eqgTgAGOYF401KupjG
 lwcNhT6o+NPnsrYQkE/6EHTiZY8B9jCZaMc88AF45v8txzcGiTro6XuagJf81f0yxjXTr+mrEOi
 UNmVcpAQbTEsNci2ENR8s/D7bgIxidIHa38aInXUbCOJX47PXvSC3qlhzMDYn88Xs8mVCx6Lw4+
 jOr/3ALUB39ve6Z1IU7DX8DWfuCtekgvZqe9CLNMa/E625Dn/uxgW1qmAbwFGI3fFsq3Ct7B5Cj
 Av0YoBtjGGyeA4M7ncpj9vDdBSOZvGpY9PKlSJpUx5Sz9mSIXlv0QACPJ1z3Y/n7kPE3tg4NNjY
 YLuDQKI9GNCCje7rdKa0p1436OlKFSgJbZNuDcRVjEFD/ib9zcN1EZ0VM5otmYMG9+yBGs0t
X-Received: by 2002:a05:6000:41e6:b0:487:a49:69d3 with SMTP id
 ffacd0b85a97d-4870d27670bmr4038175f8f.55.1789573552064; 
 Wed, 16 Sep 2026 08:45:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bcc7d1esm7975140f8f.0.2026.09.16.08.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:45:51 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 15:45:49 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 9e50152ebd8573e5ea2d97849672dbd45a408169
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 15:45:49 +0000
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ce473752016c9058e49ab47b2e1e06587bdc0a6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6rpe-00043u-QW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8205309995253111532=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8205309995253111532==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ILy8uh1JDEM="; charset=UTF-8

--ILy8uh1JDEM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1752?usp=3Demail )

Change subject: oob: Add --server-probe-reply=
 to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 24: Code-Review-1

(2 comments)

File doc/ma=
n-sections/server-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1752/comment/ec68f1fa_f418543b?usp=3Demail :
PS24, Line 691: A UDP server
=
              :   answers probes by default, whether or not this option is =
given
IMHO this is a wrong design decision=2E The change is somewhat invasi=
ve for a server configuration and silently enabling it, with default values=
 that cannot faithfully represent every deployment seems wrong=2E Specifica=
lly, upgraded servers reply and are therefore ranked ahead of older, nonres=
ponding servers, even though the administrator configured no selection poli=
cy=2E Am I missing something?

I would expect the server to answer only whe=
n `server_probe_reply_defined && !server_probe_reply_disabled`=2E


File sr=
c/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment=
/5e28254e_3725cfae?usp=3Demail :
PS24, Line 131:         && opcode_is_oob(*=
BPTR(&m->top=2Ec2=2Ebuf) >> P_OPCODE_SHIFT))
`opcode_is_oob` identifies the=
 generic OOB envelope, not a `SERVER_PROBE` specifically=2E Since the same =
opcode carries the other OOB message types, `--server-probe-reply off` will=
 also disable `ECHO_REQ`, `ACC`, and any future OOB handling before the mes=
sage can be parsed=2E Is disabling all OOB traffic intentional?



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee8=
5a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 24
Gerrit-Owner: s=
tipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Comment-Date: Wed, 16 Sep 2026 15:45:49 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--ILy8uh1JDEM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 24:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><p>2=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File doc/man-sections/server-options=2Erst:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1752/comment/ec68f1fa_f418543b?usp=3Demail">Patch Set =
#24, Line 691:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;"><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">A UDP server<br>  answers =
probes by default, whether or not this option is given<br></pre></blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">IMHO this is a wrong design decision=2E The change is somewhat invas=
ive for a server configuration and silently enabling it, with default value=
s that cannot faithfully represent every deployment seems wrong=2E Specific=
ally, upgraded servers reply and are therefore ranked ahead of older, nonre=
sponding servers, even though the administrator configured no selection pol=
icy=2E Am I missing something?</p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">I would expect the server to answer only=
 when `server_probe_reply_defined &amp;&amp; !server_probe_reply_disabled`=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/mudp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/5e28254e_3725cfae?u=
sp=3Demail">Patch Set #24, Line 131:</a> <code style=3D"font-family:monospa=
ce,monospace">        &amp;&amp; opcode_is_oob(*BPTR(&amp;m-&gt;top=2Ec2=2E=
buf) &gt;&gt; P_OPCODE_SHIFT))</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">`opcode_is_oob` identifies the ge=
neric OOB envelope, not a `SERVER_PROBE` specifically=2E Since the same opc=
ode carries the other OOB message types, `--server-probe-reply off` will al=
so disable `ECHO_REQ`, `ACC`, and any future OOB handling before the messag=
e can be parsed=2E Is disabling all OOB traffic intentional?</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1752?usp=3Demail">change 1752</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1752 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none"=
> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed=
, 16 Sep 2026 15:45:49 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--ILy8uh1JDEM=--


--===============8205309995253111532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8205309995253111532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8205309995253111532==--

