Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F271C982C1
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8huREo93fNjgiuUzNyY8rtaH2WXARW7d6nqBsntjyzQ=; b=TyJSdJBQHvlws5tAMyxo+ydcVE
	R5FbCk6GEmSGYeXAfOwDOx5iDAwxIMvtTCR7etdUEr4osIxOgbM38rrj2q9zE2L9bNdzV8bGeVvvM
	57iKYBEsrBqy68PpA14wJjgIox+X6xwp4S5E2bON2gO3mVodCwEcNZGbxqruR54dAaYI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6yvz-00006G-Nr;
	Wed, 16 Sep 2026 23:20:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6yvy-000068-C3
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 23:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YUNeiPokQUQLHURi+xMinv0UXgGK2ZhxAH3Q0TDd3ws=; b=kZtBqmFiF6K/lO12iC2+TuQT/m
 AGZpvjucj2/TNFZPckuxQkE7GcjY8nS9/foK+01LFjcaHy3TIiLcq2/K3qNmqB/X6KRX8U327xmzA
 hHHfU44BWLO+3CoHgOcYjJDvJDGcJOzr96ArXnc2p/rAJdvhOLbbTmteOQg0RyCjakB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YUNeiPokQUQLHURi+xMinv0UXgGK2ZhxAH3Q0TDd3ws=; b=I
 Fi84li3rpmg5lEI1U9XuzHJ21nQ5S0WDYJiD4ugUYzuMPWmraNxU1jUEXE8uujGOEikqE2Bjhhq30
 x92l9FoMtDhidMKCoGMu7EiEPbB3KRFZkb94yTG/GvnlaPVjdS4vKZyfxAix6oSA/d5fshA6CUfAv
 cpMFQ1jH05Pb9TvE=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6yvv-0003YH-6x for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 23:20:55 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so1183215e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789600849; x=1790205649; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YUNeiPokQUQLHURi+xMinv0UXgGK2ZhxAH3Q0TDd3ws=;
 b=cCg8Lci7+q94wO3aGYCSJ4err+mKZYINmmSI6niiytWqSJgItyxqzeYP8hWWi4f99c
 XHtv0y1DwfGIyikBHwLf3EY/6pfEM5ryxeQlq8qIvpHdR5t6hva2G56oU65sGxGN/JRP
 ciyMpH/B0iP+vHBSlawKNk9W9bFrf/sKsL1VoNUfxvlmd5v3du7YkA1YuJREcDOWHQFE
 1VusLNFLNl5L1Ph0rA6bZmhfsiusHQwlzmPA+At/Cya94ubfdBarnXUSbT7L8eafFAnK
 14nqIsM2N2G00uW/+vta7ACgIWheszORrKG4/gyKP7VmybL/Og5BT7d51RyXSBvPnChR
 rnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789600849; x=1790205649;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YUNeiPokQUQLHURi+xMinv0UXgGK2ZhxAH3Q0TDd3ws=;
 b=qJgwzxLT6U4LfkFlCcNkAvWxHf5K8WK/VHfKf5wjqm/1hCaSsk1HCKQP+U63l36PUi
 yEsywnaUsoRo33yGETdeQ0Zxzx5BPTd3WCr6sMxEmCvjHJHqFCzXhQOd8F61ykSiszec
 JoSqz70waG6ciLjvapVm5fiZhAMikzFOce7yN561e3iv9ibnTW7XkgQlCBwf4R3FxKIW
 ZimADBbcAki4+1loUjDj1MEWhZ7SnpWUI3BqMbDYwIfaElbF88lT2XLr4qIG4zJW7QcT
 B/H7ZCEzVZpESyYOJp0Uen8hFHg17knaqra91qnJNo0PhbKeeCzwVxtAurgdWgbOH5pI
 bGNg==
X-Forwarded-Encrypted: i=1;
 AKwUvByzn02HnJTafRZAfXJoOGBK8KkwaTJcaiMHGblr4mRg5lmm/M7OCSVbfvYPy3mJbbDDWoy6JtYm7rQ6mSAd@lists.sourceforge.net
X-Gm-Message-State: AFuF++nBsngTd3hevygQlak3paMQrq1srO6v/H6lafuR1IOWeTdTAoCw
 FS5gd5X58Wj9ra98A12oMNhFlu/8FTZCxFWvW8aeUiSugWufdHppqmmWXcm1U+mZieCs1xIkzY4
 AVWYxAmQA0UG90TyFpuAbfoal+wP5VE/jvZ7CfTUA8XC/pjPE0tjQK3b5bcFYEkMLP2Opeg5doj
 FcHDvESw==
X-Gm-Gg: AYBFou0LONUx8V4avpyrRv3/jf0rbG14phIw8hITj4wBQrQIUPCp/kRX5Y6P/aqAIvB
 mLfOgMrc6ObQ2yMl08ipej8/+SL3+rlSW8eHIPBR1R8radS4bNZiWXVJmoRt2cZR85ffAfu5hRn
 Rdz3fCCnBBnYl8ILmmRmYQKs9PxRvizmt3RV6SAfy2KC0ECsKQ+Fs9ZLmvn512hEKRSHkUu0SyI
 IsK7FG9sJflAX6SmgJfLEuLOsFf/vVVbH7lJhrF6Inr+/j1sAo47XHOW8WKju9S1VStnyoQ/RIQ
 jiwZN5sqa3TmXbhIIlnGxFaHhwpVX3ze0DivYMZp596WyTOA5q7TG3WlSjcqjnB11C/Bwa7GQ7L
 p6wsadz4pyYcrzZ+FSFzCWkCmY3HJGJbgBk74QDdKRgrHjwrFqfNH862L26/gPZ3nGyHgmov91W
 MkGev4tzuFmS46cmxW7m7I132awjmcJxEHWwkv4ckXj2prAy6BneoNgxr0S3KgK4wb4iMPT6bRr
 fY8VjZVrtZq86gCFJoyVveC+7KnQbQZAbNBxXFUaPEA1EQywGavhTspqgqIfvHmrwtIMh0Rueda
 QGUsHzdyQt6/k2GrElwV8IjeAPJDXwO4L/egCwF60YtjizkB3owO+FsN+uZZxA==
X-Received: by 2002:a05:600c:3547:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49eac45c077mr49489705e9.7.1789600848581; 
 Wed, 16 Sep 2026 16:20:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd225898sm28401275e9.9.2026.09.16.16.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 16:20:48 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 23:20:47 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 59a6b578f3df7a070b2b213db4f5a1e75a4dc416
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 23:20:47 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2671663d4597fb025f3f841967a88db414410439-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6yvv-0003YH-6x
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com, frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6563923462735537894=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6563923462735537894==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C5fk0Ns9K8E="; charset=UTF-8

--C5fk0Ns9K8E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

pl=
aisthos has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER=
_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15: Code-Review-2

(1 comment)

=
File src/openvpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/c=
omment/4ed90f3b_759c0b71?usp=3Demail :
PS8, Line 226:     }
> Is this neede=
d for the clients with the wrong timestamp? [=E2=80=A6]
The spec got change=
d/revised after the first draft and now explicitly states that the server s=
hould accept this=2E 

If you disagree lets discuss that on the PR of the s=
pec rather than in gerrit=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change-Number: =
1742
Gerrit-PatchSet: 15
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: =
ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Comment-Date: Wed, 16 Sep 2026 23:20:47 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--C5fk0Ns9K8E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p>Patch set 1=
5:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742/comment/4ed90f3b_759c0b71?usp=3Demail">Patch Set #8=
, Line 226:</a> <code style=3D"font-family:monospace,monospace">    }</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">Is this needed for the clients with the wrong timestamp? [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">The spec got changed/revised after the first dr=
aft and now explicitly states that the server should accept this=2E </p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">If=
 you disagree lets discuss that on the PR of the spec rather than in gerrit=
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
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Sep 2026 23=
:20:47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--C5fk0Ns9K8E=--


--===============6563923462735537894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6563923462735537894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6563923462735537894==--

