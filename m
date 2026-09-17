Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25BFC982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sIaAu6xeEunCT1CZwoIn+wQdKXInKwFQ9hp7/CYWt/o=; b=c3z+tA4g7IJd4qd+wEzgAZ7mzV
	Ed3YOl4xgLKuIL5m8Vg4ajzz6XHJ2XLceg/j3DjpNle2MfbZjLHLikJJsfSKpkxsnWKTXpRPFa+93
	nRt43qPgZCIuH7sRH8jzEscbVG/DolbO9n4VmMTGGZcfWoabXKhfXEgmsTSexI0mFI/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7BEV-0006Xe-SM;
	Thu, 17 Sep 2026 12:28:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7BET-0006XX-Hu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QFEwVSIFAgfhrzFD8X1b60HNTd/jW9GDECiVztB37ck=; b=iAbfeTeKLWJ2kxSfKGtFCIJqkB
 pL+JRsziFvHS6urAKA36dFvMhaW55Pwsc8oJB4Kaja0hqmyYeNl6wpB7q7BP6E9P4fE0S+gWlmUd4
 N0EJb77NW9k4ef426MfZf3u9iVvzH/XSiiS73gHRF/cN5ikW+nHxCIrndwiQ5PPeHOT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QFEwVSIFAgfhrzFD8X1b60HNTd/jW9GDECiVztB37ck=; b=j
 mm0qX+CUrpF54k0Ps/PXlHa3oc/ipM5vitL0hN0A2cjk28mJMKsR3nKZaWqNqyzYtZXO/KOV3MMRl
 xBwaiWEaBg8NPTZqVXD9xGUECKbjn8CK94NKwAb4oaSW7zSkBqAg6hmdxXrEYxnwpzGemUiviGK2/
 e+KGXe0y2Kb0SSoA=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7BET-0008Vd-Ej for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:54 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso7343035e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789648127; x=1790252927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QFEwVSIFAgfhrzFD8X1b60HNTd/jW9GDECiVztB37ck=;
 b=BF4PxFPGUs9sGjUOXEIfIEWW9eFbzO7fiq8nas01uj+BGd8l8k9W3oSHRuVHorg9rd
 4rbRzJVU1uqTuBd32LCH/CG6hr0ZutKfVGblMTcPgdfMJfR4FG6X9iEyPSYjkz7lQJvw
 3mQjO5BVIwTrtM9jvHdqmX6Y10BzThfymr0Z8FD0PL7FNJBkzlTeiCQuGL+TMu5xjpdQ
 hSQGGBEuG9+WGN6gJyGwKVK1nGDDpZ+bViLC8anL9vUmniZb5yD7tYXy3xElU83Yc3hn
 qN6YwOAn1H4nMvtaPmQJkDBdmnXzXUliK21Ge4PYwNBQBZCFibE5oAnd8SRIYAs1eIWS
 PnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648127; x=1790252927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QFEwVSIFAgfhrzFD8X1b60HNTd/jW9GDECiVztB37ck=;
 b=rHGUW8nSGiU5Mi2VyM02Lmrrl4qmQ2BwopOlMXJiCv4p1IMxy/VFXZASST70oFabz5
 Oc+EB5XO1Uvtm8Al++XLgCNMJ6NAwWcSwauJfFbr/eMtQC358kEtveL++/zvYUl14f8R
 YhZaak8AfJTBzj60b+RreKW79YmF6o1lubDLlDlYWf3JaqDEGwyZhKLlPcB/kdVnrX2p
 hh3ybH66mTdYzir5wNQTiWlwjD13CCqqMQK3H4fNvKmCn27Ibk1ba66MRaXO+CX50pqs
 dnrdbDcmvXAEuE0nuM+EaLpw5NjngTa10h1CRax5198ha17+sfcLVnR5LqwZ5BU7o4wp
 IsiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz93w14Auuz1B0xj1ke6b1xDoJCOtAX5OTfnphbeejvz6QRZ0dEGJL+O+rESn5/U5p7YBQFfdKL8+NcgPNl@lists.sourceforge.net
X-Gm-Message-State: AFuF++nvTad17WB+UUc5FyAUp10rS8KGIDSfPD7fNlrO+F7g5Jq4X9Nf
 YPVno5SAjiCgNJJfprLG3KUUzHtD+foEh+IZtGvscshjoRwsxu458O2W+y9JK7qEMAHvOGXTPGB
 3ubjkCsVtuQ7QLawO0ZcJiMYCBt+Y2L+sT4INzf+1qG/8dqjSYdrDb+4Ob/YaYmdKNi2u
X-Gm-Gg: AYBFou3EOWJx0TqColbbqTpxVzW0U0zZTCQnxvnPFyVwdvzSFVBIuBxTE17gzILLZHo
 zb47aQjKqXZrDpfKHj+lKWVg53ZZ47RXNvHJ3aFXiTvD282gzahlFF0TILM1Umt1nIep4a4rfv7
 B5yU78wHA3zQWqJgECC1ssB+c8mj08Yxhweu83SHXGpDk/huqjShc7hlJTX3l6TRsqYMw/+oV75
 WoRD7MO9n4R3ZkY9oi28AD4OoJPkjRBBC3dAKGB5Yxl6dnbp44UvEM6rLoe9z2SprCOExsPJOQF
 dX6ByC7DeqC4IP1F2q8dBpeVo9IBGAFyktWFqQMT6r8+ElB/ZKcyKxHVH6++XiIPl7B73iVxPOk
 k2VNUjaPBhOVBKpgF/7+LJdAww2deTzZ5M/+C9fiOTwYkGDmew77Vw0y8FQyMnOuxdhRj3naA+5
 7kcDJVPlChhefIKTuLex3C4G2v51wHg6S7MN5+FCB3aYIvewnjZj9+4sNdEYqOAMiBVzPiSMy0f
 dG3ocsbvklDsp3MMGcC45r/c1GYb5IPp90KAMe742pfc1TNjW7TRNR9iTdW5nCHF+lOOZ7UvOUO
 4TpfXbTQvwD0T21JYlBnk6u72eaTDExf+Y0iy15dwyRm2wZE5YWDK5/3aIjOxA==
X-Received: by 2002:a05:600c:3492:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49eb72fb7f2mr69091265e9.12.1789648126743; 
 Thu, 17 Sep 2026 05:28:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd226ef3sm72899245e9.1.2026.09.17.05.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:28:46 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 12:28:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: f033251ac0d6b54e2017d85047d26df9db423eea
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 12:28:45 +0000
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <654373bbb244790f6796956a436fd27b2dfdac6c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7BET-0008Vd-Ej
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 probe-result ranking for server selection
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
Content-Type: multipart/mixed; boundary="===============8368080997265260131=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8368080997265260131==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SrHvlfg+l6Y="; charset=UTF-8

--SrHvlfg+l6Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1746?usp=3Demail )

Change subject: oob: Add probe-result ranking=
 for server selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 20:

(1 comment)

File src/openvpn/oob=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1746/comment/66452e20_a9b4b2fa?usp=3Demai=
l :
PS14, Line 253: announcing 0 asks not to be
              :          * =
compared on weight
> Okay we seem to have very different understanding what=
 max_latency_diff is used=2E [=E2=80=A6]
Okay, I think "the fastest server'=
s max_latency_diff applies to all servers in the group" is easier to grasp,=
 so I've changed the implementation (changes are small anyway)=2E Man page =
and tests updated=2E RFC text should probably say "the fastest remote's" in=
stead of "their"=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1746?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerri=
t-PatchSet: 20
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2=
026 12:28:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: ralf=
_lici <ralf@mandelbit=2Ecom>
Comment-In-Reply-To: stipa <lstipakov@gmail=2E=
com>

--SrHvlfg+l6Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1746/comment/66452e20_a9b4b2fa?usp=3Demail">Patch Set #14, Line 253:</a> </=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;"><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">announcing 0 asks not to be<br>         * compa=
red on weight<br></pre></blockquote></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Okay we seem to have ve=
ry different understanding what max_latency_diff is used=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Okay, I think &quot;the fastest server&#39;s max_latency_diff=
 applies to all servers in the group&quot; is easier to grasp, so I&#39;ve =
changed the implementation (changes are small anyway)=2E Man page and tests=
 updated=2E RFC text should probably say &quot;the fastest remote&#39;s&quo=
t; instead of &quot;their&quot;=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">cha=
nge 1746</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 20 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 12:28:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--SrHvlfg+l6Y=--


--===============8368080997265260131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8368080997265260131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8368080997265260131==--

