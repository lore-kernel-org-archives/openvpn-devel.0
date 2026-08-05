Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D899C56201
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xGeCwED1xGViYxf/i/3KpYjMwGEL2wAxC2Ixuy/jymY=; b=ANP2Y6YcOE8l1sh5XS8Y6C1t0V
	FtyMUtsxuvXfQverGVN5xIoUk6RCtpdnhncApz48/+WFtUunIPKYMF65DPCpHLz3DjFx4QRd1EpTt
	+qkloy5q4sZu7zmlsTn+Ffshimp6r0Gq0rp1aEoBzOt/qHjpueEmx/AyV6atKScZ1YGg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrZT2-0007AL-Kf;
	Wed, 05 Aug 2026 11:07:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrZT1-0007AE-KX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=w7sw8vrmW1bsAQJFYI4WVTDcrh9l2V7iZ4zqej5tnrg=; b=Dd8x9zZQ9gN4BIYqVLE1ceKMjT
 CkiktB2F7quWMMUDHIKXzJe2CnN0p3knNHXYSQtDVO/Gl/HoGwjX6Gn8lHP+tC6i0d1keWTM90VAN
 5FXaL5SfjIGge4gCMzs/BAchtDmzOzm9okDNXF7pabw6l1FiYDerCQXevXpBUJQeAb4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w7sw8vrmW1bsAQJFYI4WVTDcrh9l2V7iZ4zqej5tnrg=; b=X
 812Tyn9MLw0TocPMCVtbfkAq+Ynx4cMRo8lBGxQx594vUWOeIcQpWBhHYKksUJp/+HKw4HlPEEZRi
 248a+fYcb3E9NReUVtEIfXP/yVvHm573PnHOjsZIKD2L2pcVODUp0s/DVURoRPaD8rv2UiXhWLV2r
 qExtpK3hCx89YRB0=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrZT3-00047n-Py for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:07:23 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so4240705e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785928036; x=1786532836; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w7sw8vrmW1bsAQJFYI4WVTDcrh9l2V7iZ4zqej5tnrg=;
 b=Som2fwWIxO557mmey5Ze3os+9pWnjJZuSSkDGOjbw/wAfxifX/fPppzfzHTWCmD9lh
 +Im4uM+q1qHD9I6Ry+y3saQ7MOBe5Y3tQ/nkVrSSTrTOJjBtiY5t89SKLghyGxDPOJtU
 1QZWexRl2/YPuucRomUqfkxo7rKuuZJy6BrstIBEVjgviR3Dk89ctIgc9Bb2lD+RK2l2
 r3ssANSGzEw2tlS69bUX51E5M4+CYcyiJz6DxxDWtpMfbYkuWVMVDh7AyJIrv1Dy7bpy
 SBB+3KLc2mtI5lIVh1DR9nY2vZHt7473OnrVHDGFHcg984Ri2bL21Q5A+ANn5jZbWptG
 LHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785928036; x=1786532836;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w7sw8vrmW1bsAQJFYI4WVTDcrh9l2V7iZ4zqej5tnrg=;
 b=FrTS8+IPydY64ERTm6uZxK5YotLKUa0bGwyCRJO2DGEG20lVq7ajkJeAdNtBeL2guo
 eJAwMa3V3TEejrW6hhTDTrmlYVJ9avigzD9kZdLDGWuwF6mK0Vc+WnM03CPMePuijFBk
 /klP1OoNAqlqrJu54pD1+K4rbHf1UsbCbAlY4orb0XjWHTGY+N3bZtrWhCpR1TdQDydd
 TQycsSYQ+wjLKON9FJdOVGRd797XVpqjbPdYQrUangZ2siXgtjRrUyot33c2kdaL+/0i
 fun+8Kh98nIfBfJNQsrBTpENQX7rNCf85kGNLC2I4u8LlhY2nCePq73I3Qn9/SekWrUd
 v/DQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGhrgcrCa4Ep7Wp19M6CXBMydMQaZSc+uu60vJdt0Nh3MeK1vlZRC6zpaVZw5hb+f0BDxuU8v3Oi20bSrN@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx3dFDlieY61TZjz+tL5Cmep4FHcoAbkfH41a8v91ZE8ydl7hQe
 iDBGulQfzgS/miOABeYxqbliWRjgseKTq5E+cJIhCAd/VxmMOgDZ7PZPmSMWZ4GW/oPK55+G9yo
 p6kd4Ew+wyJrLwkDyh/cZlDsd4EpqKQ9WLMJqTciw0nXBi3n0dzUjooYXr2LnjMWEi/vg2phPeh
 p05WUK6Q==
X-Gm-Gg: AR+sD12NTg99Ax2PHHkXqAT1FxePJKsCwztRAsEzsX+wDs5+SUfDVJBvlYLl72WYIh0
 isTonV+g1EtNtjnF9wmNwaeFyASXmmNAVAnxAR7DjrxGfw6YfdD9RU2c77YlLKy43Yntlmkdqni
 XuKlh7AqooH8t1TSh5smBiL3Ow+rUWMxBZFj1ZoEbgd+DpJIzOs8QZrtzoDryMtnSzUPKWEknbl
 M2EiNlArtS5Bn57wlVfagbztG3Q+9s+SZg3DgwnfVqui9/DL0AwT7e3S2/hCEp1/7CO1Itc3Pjy
 vTZvsn8G9GySL/T5Xle4QbFKkcRfRcPnq/G5ulCPPKE/BRrjJZ5YIsXV5fMBb25K0XI/f+xDxMp
 8oYNCKJmM/2kOXItbKJD7assEigR85LDw/b2d/qdCEs0gAOZROEJbTJ9kPM47MH7wrGW5mIO3Q0
 jAs29zKPTfkSzdZa4AgOGKFdxe+UcfhNm6pzKZPugAOL/P3sMKyyTEter2k+0LbWZoFtyYlYn7x
 0h6i5ixdEJ7WSYOL/H7ZVavPPtuYZWwle9/5CtnWTuYe8/july9hXUdrv6CYg92f4rerWLyVuXh
 pGmKDAVyGihu2mjbMU5BPbidNEkq4dpNFTemDEnt3XkmFNkShOuBtQp0jwEH9w==
X-Received: by 2002:a05:600c:524a:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-4994e71d349mr57060525e9.7.1785928035605; 
 Wed, 05 Aug 2026 04:07:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e99c035sm39995275e9.4.2026.08.05.04.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:07:15 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 11:07:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 673e321220a104f42914bd04adb1968a7b2d9112
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 11:07:11 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e24d378c0c8a3d608dbc60ed819d50740c5ead6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrZT3-00047n-Py
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
Content-Type: multipart/mixed; boundary="===============0780610138625784263=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0780610138625784263==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="90aYgelgiRY="; charset=UTF-8

--90aYgelgiRY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exit the process =
when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS1: 
> The chan=
ge looks good to me overall, but I wonder whether we could avoid adding the=
 persistent bool  [=E2=80=A6]
I took inspiration from your suggestion, but =
I did not go the full way as you described because that flow had other draw=
backs=2E
Still, patchset2 should be a good compromise :-) I hope you like i=
t



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I564edc6e0cc179c=
2b8b5ddef5e80838949fe9fcd
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 2
Ger=
rit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf=
@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 05 Aug 2026 11:07:11 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ralf_lici <r=
alf@mandelbit=2Ecom>

--90aYgelgiRY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?tab=3Dcomme=
nts&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The change looks goo=
d to me overall, but I wonder whether we could avoid adding the persistent =
bool  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">I took inspiration from your suggestion,=
 but I did not go the full way as you described because that flow had other=
 drawbacks=2E<br>Still, patchset2 should be a good compromise :-) I hope yo=
u like it</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change 1835</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I564edc6e0cc179c2b8b5d=
def5e80838949fe9fcd </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1835 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Wed, 05 Aug 2026 11:07:11 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: =
ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--90aYgelgiRY=--


--===============0780610138625784263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0780610138625784263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0780610138625784263==--

