Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4F1C79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MePdCtGY3upoWwbDaw65s9fwWzSycjmS6yRds+PyvY8=; b=eA8yYJQ1ISTo7RF42hMgp3DAv0
	2+KWyH+H/iob6hDuckiGm3O8dS7ySQL58cBoT8kmKBT5/83CwZDVa0fS7PXuTDpUQoafZfVINWIT6
	gRNzBpjCQtsTfHqhlY3rxjLqmH1W1U+o2Df50upZ0vRqss1ztaHFVoAgAlcF5Nkxem+0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3VKn-0007EP-6h;
	Mon, 07 Sep 2026 09:08:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3VKm-0007EI-0G
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9sqMrHO0sHnEFdrPaNn9dO25/KFXb+Yiktb4cwduQG0=; b=mcsAWGzJi/nykBgToeKXUa4yfs
 jYNLlUR29dMgTvU3OLbZYoQZpZoNX5ReE5mGgTa/l6W2wuUbKq9n+BhDDToOWJppXyJSrghntkL+7
 aVjA9cjdJExL86wiD892umQlUWuryRc45fH4pJ8An5LhxD1wFzhBKc013cbfeeDXPKFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9sqMrHO0sHnEFdrPaNn9dO25/KFXb+Yiktb4cwduQG0=; b=e
 kmapBAj+ADY0LVRDy435ehG550A/y7KbdN3vNynBPXoeXLqOLaiVjrvEowLSWSIbsYQpIWEEeTvHM
 jEAMhTIb34GGAdBoZwczMS3ofonZ2lXxflPUZXzTgCvDheISSLMhDqlY8efGNDzlmBXbn5lphAxPy
 01ZhkNGBd3al59zM=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3VKi-0003h4-3v for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:08:09 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4858595f997so1895477f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788772081; x=1789376881; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9sqMrHO0sHnEFdrPaNn9dO25/KFXb+Yiktb4cwduQG0=;
 b=XjiP1Lr/rqoOgniJQV4PqeyCXO+77yEcaAMXl33eL1JNYstXOYAXYbdG2j7xeadirN
 NelJXbWoD6qdU1ImTQD9e5JfHW2jlhSNyC33b37PjaCfMt2P10KiO4bGkC68qazpqrsM
 FO8Py5X5z7JLPkyvB+M7Q9OzQTiLINCMMvFU5ZR4+DM+94lVads+RJGxt/688Cjn3dCE
 OC1pRUnKR7cKpx1kEPSyvN5DnrqEzOJnR2DPHROALMw0lhVbeKULswTcZ0ZtQR46S8r9
 ClakCFITKj2Vv3JNHiVnAXmUis5D755zNgdbZ8WosfRRHyBfU3oao8ye9Y7hXhgpIT2z
 Q4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788772081; x=1789376881;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9sqMrHO0sHnEFdrPaNn9dO25/KFXb+Yiktb4cwduQG0=;
 b=mojMw1xjOfM6IuVS8YRdqu0ukWZY8z1YXm8394tSlCloiRe9cfAsnFgx+kgZMtQxQd
 rjw1lYI/aulK164znrtoRZo/33AkwAj9J7xtTdCdR/Ag/er5ANt2ur5OMqrijAhhwn6Z
 ifniXtH6VgaErKb6kzVI8yF97dhObYPCL90HPzxCZl/Eywpc+3TRbogFW40lL4D3y4o7
 Cs7xmE6z2Q5ySaBxKyBFZYDO2w3lnJXX+8Wata0dXl/afngKert8+9viI/rK/RLAK37f
 WLnstTmKmeDTeBstSz/7d+NTsGwmZ52LQYludcHKfHk0/O/n0WcHA22okIiLcm6qNczS
 1kBg==
X-Forwarded-Encrypted: i=1;
 AKwUvByYsNgDKjW46Vc/HH1aErxonG/JAXaAc5YUSf75dXIJQtx49P1U9ySxr/qT0tl4ZK/qbfbNJUuj51cyfWI3@lists.sourceforge.net
X-Gm-Message-State: AFuF++kOJtueHcti+ej+eeyoJbGk8TAJYtYpdBOljfThKjIi0mr/zH+L
 JOnaLUxsTaAqzQJ4g9EPf2aCW9BazYpAxgFYxDLecjM0nRDEqvP0DmVU55iP1rjRN3K5+tuVPfE
 IuEHK18CPUgizAyQlPo1d2G6FnnhwyieCOyYtbNT2W5bAKxj9vQpN225y35PseE6k+LvG
X-Gm-Gg: AYBFou0v1p02HY1R8kJ6j0eFRGCD8T4qLQ7og11ojquoL0r2ZDphMa26fHbq3SMKhXU
 9n06XQCZM17ZgUIaa+e0LPt0UT/GqhV2WuAR/Yzg3z0/oaMSM8iESIMzDWZPVGNZMHaoSK0Ri+h
 HX+4t4HhkQLJFHXvKv1oJCEiU61mnHhIZBCdV1Dm6NjZ3bu9xlZoTHFf0k39m9Gj0VNWO+03QhL
 +/cxADPuXfyZ7Q9nGVtEvuJnQReSXSUf43ikUpNoknzEriibRIpFTFHxP3uyIdtbrUwd79XLI7w
 UX9ecacZ4fp56zsqPd3HE62riUscJrKC8rDPmXDZFJGk/J14nehsbEQdPxw527JSN/+UMAyvKp3
 mfenXIopQ7FAFmZyztlp5sbSKTJQB1glPZ+PSg1RvnD705+x8RyeZi2c0dMgGpf7orKfgMEaFQ6
 Db+ii/XU3K6Re7e0lobnbdywOSC5zxNei8M7PrABbTy8jHzUv3ZssqOtR6CVhJA1tMSZto6a1OC
 WWH9hG+B8dXrXSHxzToxPW1zgxg6hScgoE2SaHkZkcAF++GqSaCpacF1Ink6wSqr4jLHzV6akJL
 tXr3MJLBsHF+/qkzRrRg5QdwhV1bYUpFqj0heMV4sNBM9d0O3vE=
X-Received: by 2002:a05:6000:2c02:b0:484:3604:c7bd with SMTP id
 ffacd0b85a97d-4858708c895mr44707395f8f.17.1788772081373; 
 Mon, 07 Sep 2026 02:08:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588135600sm23352299f8f.2.2026.09.07.02.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:08:01 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 09:07:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: 590a76643df65c4fc73a696a83d58b90ded32af7
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 09:07:59 +0000
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5acb68273e2aa51859fe91661949262faea88c68-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3VKi-0003h4-3v
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for \0 and RFC
 2253 chars in cert subjects
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5963673863200135615=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5963673863200135615==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sGJZvBAJrn8="; charset=UTF-8

--sGJZvBAJrn8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, syzzer=2E

MaxF has=
 posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1898?usp=3Demail )

Change subject: Check for \0 and RFC 2253 c=
hars in cert subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS1: 
> wrong `assert()` =
used=2E=2E=2E [=E2=80=A6]
I replaced it with assert_true() and changed the =
commit message as you asked in Signal=2E



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
Gerrit-Chan=
ge-Number: 1898
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2E=
net>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karger=
=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: syzzer <steffan@karger=2Eme>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Comment-Date: Mon, 07 Sep 2026 09:07:59 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=
=2Ede>
Comment-In-Reply-To: MaxF <max@max-fillinger=2Enet>

--sGJZvBAJrn8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, syzzer=2E </p>
<p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">wrong `assert()`=
 used=2E=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I replaced it with assert_true(=
) and changed the commit message as you asked in Signal=2E</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1898?usp=3Demail">change 1898</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1898?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1898 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer=
 &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@karger=2Eme&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Mon, 07 Sep 2026 09:07:59 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Comment-In-Reply-To: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

</=
body></html>
--sGJZvBAJrn8=--


--===============5963673863200135615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5963673863200135615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5963673863200135615==--

