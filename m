Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73464C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfDdmBB+Tq+wq0Z4/xZlBtmxmKx6S3nbueqOf9nwKfk=; b=IdiCc1V4fJL4qy2AsvudZYDjvy
	iWutBnv+SaSQTK6qKByOYOQfU6PtVgzJc1wtnhp9QJhYFL/JI3junH/APg3rIr4ewiDpngqnhKlEU
	bcqS0q14sht6zirt+KG1H/0+VKSp8pBdReztskMHxeEdsYHjYa9MqvGDNXTaJsP4F8/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wethQ-0003U3-0q;
	Wed, 01 Jul 2026 12:05:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wethO-0003Tu-7L
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 12:05:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A2ZS5sHSCwVmhV3WmNxCCOlLuMtwqHtQ/UpAntU+76s=; b=RXVtEzdL1CC0kgs/7R843Q/523
 HxySzzIfoMXDDOM4R8DBYOmWc7YX3uc112qQF/xzyEYJyj7SHa/Qi98o9cqNduXei8JeaaTlEUBkL
 LcWGuH1lkm+Edc4vicUi04wSGByXCRxTwqSqM5kXF4XCXtFeCZLVUL0iIKnftxr+X5i4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A2ZS5sHSCwVmhV3WmNxCCOlLuMtwqHtQ/UpAntU+76s=; b=m
 sFN1dLoWRd8aPPtLZJ7wpHoYt+cs/rSqJZ9bjuWNfPjc1q9tjSZR1cAxiE1qz29suecTUGezvHAY7
 T2I+nD4WAhqH0+2UxZlvg0RDGJ9r/v84p91neADMEva/ZeTMd/BVkvifG53+agIu7vbeWC1KHKqfD
 tBrnX20RGOf996x0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wethL-0005Gr-Ur for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 12:05:50 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-474303f3c72so361899f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782907542; x=1783512342; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A2ZS5sHSCwVmhV3WmNxCCOlLuMtwqHtQ/UpAntU+76s=;
 b=B2FkWoO5rhLruu9Stjimvo4D7acdt5EggfR//FE/sEriIQhATU+teZn8vYfhCiElLT
 MpQxlgOSzAXo7bABwyTCU4oNDakjwQb5C7ftAptVx0ADpUSdfmrJGIZLapEit73OriAQ
 nOmYFrg+yVJgFubLHhCMp8bR600yQi+yoHo+t2tmvhAMskg+yqV2rkgxC98f4qmIq/HP
 a9FtxQFIl3jHBEivPqyXNu09sziUb0lbTJlo+krgCFepdxHba1OW03Oco9TW2U08eZ1D
 V6DC4CPfOdf6f7V86mkW7ld4uEiQ/mQnIF1G5iJ+W9I2B1ICK5PkhPqTN5v3YrHfbIq7
 Pjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907542; x=1783512342;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2ZS5sHSCwVmhV3WmNxCCOlLuMtwqHtQ/UpAntU+76s=;
 b=p/QMH1azv/Ix/wrgmj6ba2zLrgiv7eh9b/VkbZykVXb7wf7JbamEr9HdpM3KVH5GdR
 nFkJJunkx6seaEeMvM3U9cWaeU/oquIWA0y0gdn8AtsO4q/qzGjWFHcQhz/K/u6da6pz
 7wAGZNGSYPstbw5ifVkw2Tmy8GpAPNjhXXE8Hk/IkwPL1KDRYy9IgzQE+il5SAO8gETt
 dvuvXb9e3dtpg1i+oTWeIV0+i1lKG55VZVxFlzawIchpqSvhuw6LnpsiKBaluymc5epN
 cjUUSKZ8jQX/IVULasK6hTDiQfx7k9TuCSLQJMkdrAN6V8mwiRJyDKsMG3/gkZa4BFGS
 cRyw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpv7C+DoulJHZuQb0firhYsbm+E3YZshlhJfOnR0oWj83xCEcKbx8BETvMw9yPavOnGv2gReZerxL/QEvxX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwaJSdWtIJfqeO4yWZSfReQaAi/IBrm8oxD5jY6MXKJfeG9U9S1
 /6MbN3WBpKEZQC4+o2fafHQhzDOuPCudSPko0tZioqPI5FpXKOg9dDtSzyNuOcZT15ikUU4Da3d
 kY+sgOBWHK8rlnrL+y8coeeqvpNV2vSJNP44C+frmQpmVAp8E4XPgTQzBQFLV6B+fyBhr
X-Gm-Gg: AfdE7clyiGM/zUTqjTnKcuJzsZf1GmgsTSNSnih2G/inwxTHp1OPj2+NqnOnH2HBIg6
 hIV9h4qg5IzW13tPpy/O3GzAMYnhb0ihuLp1xrTKr0JPrOnagmYe2PTj2U2MfQ9osRiNuun3wgT
 gZEJQAxnLMviQRDjfQmJsFT0dvhMsnsIgrrCJ8oX2jrKrjz3gccLsPye1yKFaNr8YN+KbXbJok4
 yDZANhdhngQlAUtF/xuZHHpTlXBhDAmqBEwlTYXPoU8vtS2Br6qyCbc+KNXvHLqNo8N6zRWS+XK
 l6qIU7rV2pfDjv7H8lwcinssUQpyeUVRFwYyO2BOFmjNvTFiFnf+hxxu8H4K0y5Mu8C6xanDKi8
 IlUvGOP/zab0KD4c8SWJL8lHvYF/qtVpf8RNqTmsqQdxCypUhR4VARJQB+agGJZQHCU7zCGTiUv
 5e8YhdmMkHOUUybo2w4rVjAAcw6RQyJ04Pyf89ZY/LEbzltCYSyFtzQlsWdWZafBg4T37Jqc6i/
 A6h1qwsfpZgW7zfDPpl+wPM8wykMeTz/lf2l8/EJUV4ldYXMTuKGiGPD7u4ig3MWIM1QjUjKSbB
 y6xklNksRzY8Qw==
X-Received: by 2002:a05:6000:230f:b0:46e:98a7:232b with SMTP id
 ffacd0b85a97d-477573bbc16mr2268519f8f.10.1782907541638; 
 Wed, 01 Jul 2026 05:05:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194bbsm14658667f8f.3.2026.07.01.05.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:05:40 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 12:05:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
X-Gerrit-Change-Number: 1735
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1735?usp=email>
X-Gerrit-Commit: f0a65c3eb248ff25a418ac3403cd603bd5364782
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 12:05:39 +0000
In-Reply-To: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
References: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkljOGM4MzEzMmE0ZGU2NGYyN2U2NDUzZGRiOTBlYmNmMTM3NTAwZGIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5172148b036cba2bba3a01a22dee3229aad43c3c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wethL-0005Gr-Ur
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: create and
 destroy Linux DCO devices with --mktun/--rmtun
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
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2444170918435261518=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2444170918435261518==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mJBZcNy8o1o="; charset=UTF-8

--mJBZcNy8o1o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ralf_lici has posted co=
mments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1735?usp=3Demail )

Change subject: init: create and destroy Linux D=
CO devices with --mktun/--rmtun
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
> I think =
you need to add a paragraph or something to the man page that explain the b=
ehaviour that thi [=E2=80=A6]
I was talking about this behavior change with=
 Antonio, and we were thinking about adding an optional `dco` arg to `--mkt=
un` so current users don=E2=80=99t see any change at all=2E New users could=
 explicitly ask for a DCO iface=2E OTOH this would=E2=80=99ve been a nice e=
xcuse to push more people toward DCO :) WDYT?

On your tun=E2=80=91mode que=
stion: yes, https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734 probes the pre=
=E2=80=91existing DCO iface and checks its mode=2E In fact, 1734 is a depen=
dency for this patch=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1735?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
Gerrit-Change-Number: 1735
G=
errit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 01 Jul 2026 12:05:39 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos =
<arne-openvpn@rfc2549=2Eorg>

--mJBZcNy8o1o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1735?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">I think you need to add a parag=
raph or something to the man page that explain the behaviour that thi [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I was talking about this behavior change with Anto=
nio, and we were thinking about adding an optional `dco` arg to `--mktun` s=
o current users don=E2=80=99t see any change at all=2E New users could expl=
icitly ask for a DCO iface=2E OTOH this would=E2=80=99ve been a nice excuse=
 to push more people toward DCO :) WDYT?</p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">On your tun=E2=80=91mode quest=
ion: yes, https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734 probes the pre=E2=
=80=91existing DCO iface and checks its mode=2E In fact, 1734 is a dependen=
cy for this patch=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail">change 1735</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic8c83132=
a4de64f27e6453ddb90ebcf137500db2 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1735 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Wed, 01 Jul 2026 12:05:39 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--mJBZcNy8o1o=--


--===============2444170918435261518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2444170918435261518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2444170918435261518==--

