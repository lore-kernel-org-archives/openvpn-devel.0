Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D202C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3kJwf9hxFRbGdjz8fv94dTuHkviNL9jPbRZN/0ND0M=; b=fRM2zlahyif+CowTPLpnmbv31R
	tFWFx6eK6bg7pRXB2qqZJ9G3/c0v/7YoCRuHPQTzxo7dMJJwzttmX+I4NM3Yu3oxCt/Vj8fgTepod
	zc/dtiEFH6DeYXaBWc+Tgv7lRlTrC+pIine3Itmn7OHYnEJdHLnNfGZr44tgdK9P8SF4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojMV-0006vk-Sh;
	Tue, 28 Jul 2026 15:04:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojMU-0006va-TV
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UtTzLZoyuOk9RJyaZXOEY+39lk3gDxjS+LmGp9ic0V0=; b=PfROXFs/WBiTbXjgLQKwFTscHQ
 6IE3/SoPQzG87sPTzl7/jg6nzDIpC8+tu6ZSM6AtVLHvbLYM3F9HmfIir6uCxE5kUYy60pF7c8Iw1
 3jR9bSb1Yr2cvxRS0tO964YPH6P+7bFTthGrRa3NWR1Xw5IGDpXA4+qey5NJvmDakS5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UtTzLZoyuOk9RJyaZXOEY+39lk3gDxjS+LmGp9ic0V0=; b=B
 TvCTK0Z67wersbDg4PyHbFYqhUmleQFcnSaVamICQtpcXCQ0eTuKL+uHh8rLCbLorYUoIbKOpSOlm
 IN/jtP5xl3JIu20WQTskA/eWpkaoRY+CcByv1YnzwpLYule2K7e6sL0Xbc7S88SfPvvIVkeA+qzkb
 zQnJrPBiregWFl6g=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojMV-0000Tq-Rv for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:54 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so2395476f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251086; x=1785855886; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UtTzLZoyuOk9RJyaZXOEY+39lk3gDxjS+LmGp9ic0V0=;
 b=fLffcb4Fyk3DP5LjWl3dFWhKj5IuGm2GE+VZ5UnacLsnB9h6rvDPBviO94LmFB6dfH
 18VYlEDUcom6f5EOoimeuAVGktr30dW2X6ZkPeSjQdo9aVYhrp74QN2xz4tprR/tDsr8
 43zMeXQOezK1tSEqIZWh/owVzdhKVdTXutmviO1tGxarb/CjA2F8GD/MgBvxbbgclZbL
 3AOfYN+g/i7g2CJpd2ygYA+m2tvnU5YnWzJ+6KdC7kjO7s6OkdJj5oz2bd4sbdUG4ShL
 /rB7ZsnuHTdL5Qh/MbPOzzcjAAy3WzokxV40xhP3BqfN5wsgYDQIYH2LvdEXA+fIpXBa
 mPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251086; x=1785855886;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UtTzLZoyuOk9RJyaZXOEY+39lk3gDxjS+LmGp9ic0V0=;
 b=N3m4icAxiG767cKJyH/3DjZFjmwOh+eSHvj1XyjWatjPRXGOcogIPFK9yuL3qg5Evb
 Zs+PUlTDnYaYDUgwPEaJ4NOZcOSDjs2CQK/89pbltOpqxjyo7YTypMvad0DLhqLZpKyF
 SVQBQ+I1zxqT5BaRP0dXtef6OJiv/m2+EPxhS4md4kxYANhfgwgUwrLj46YCIA2UnHwx
 WkNuA6KGEEicEfzRkuTMBflx963OjpHvtdq7VT1mBEaQI1IiJiqcrdTA/bYakOfmCUh8
 7R8kcROCCUdYspHU8A7eNmj3SCFA/QWGJGeyWuh1rxf6AvFAvxzBUZt0i03jvFVILuai
 1gKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RozZCBARHksrlqxIOwwfD47vkNyWyfxLsuURWWnXJLPJQpbc5S/HOx83fdp2kCLCJALZHrgcz4IfP99e2vU@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz5X0n1Dz51D6I/ysBxtHClG8A3rSlZvXO9lyKg5JkFSvZy0CEA
 c4qGkBkTznqWwCxocxtUz5R6r3daiKITlT9XV1p/BFPaxUu/PK+xYCctPcQo9kymmOWeMXbFmCP
 54aHAkZ/daDUzz/mRPBdUY88W1cUdFpEJTUgdoZxtKIIoM7ck+lFRYn3/WTr8ZyG7K/LL
X-Gm-Gg: AR+sD12tPzOAcWHNXvqmnODLVF6P6qPh/74AiTfDIFZg+lIk2+QhwwNGH+x1WDF8S4e
 RrulETsfyOsEyOYzW2DVVFweqfjZgZbZ2kjquCn//mpQ5j3mQ2TP9m9vgX81Z6iZxJzkWcu2oYH
 PRQUM0cLK0O5QvHDDwQ6q8J7xmBamYgafxYfugO+CWC9SzId4EgHqlhjNVaJjoKQNB7LSAPwwwJ
 7vIGIOQK+9DevJ+bpw41zMcVqGa9piBduD0lGl/xg5CQ8wJdg6JObjDEBIFSJqCxFEyqdY43/h8
 ho+KprTMLO+VR9Iu2BDG1vDL/raYSaxjQtUv6L/l/z/fnALnfc/JT932bQIrBpt6t5oVqWeYuRZ
 7TFjcLJd3+pPOfHAMXZ8johO3uSkB+BqHwwLlJ9MmaET9Hj2SSN3+4eihcMmfucWhaOTL7i73CR
 hF9bxdOX48IBivyNag+AC+lz93xUz6D4OfZBDeG6P9BvODHu81oAw41g+o1vRNgKhztwhioZfWY
 UjSrPalWw5P5BPyT6TxxH2rCFa6wjA5/7gW2JDPW6xTQHryP6RJ84OwROS1VO2+7koj
X-Received: by 2002:a05:600c:350c:b0:493:b6ee:fcb7 with SMTP id
 5b1f17b1804b1-496c642c901mr31360525e9.14.1785251085555; 
 Tue, 28 Jul 2026 08:04:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4625161sm82589995e9.14.2026.07.28.08.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:04:45 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:04:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: a342918fab203bb635bcb53c314871e141eeb4d4
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 15:04:42 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4807ca7e1391cab6f3162de4a3247ebc870ed0c5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojMV-0000Tq-Rv
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5591818265164922706=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5591818265164922706==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bjVKeTVurTQ="; charset=UTF-8

--bjVKeTVurTQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER_PROBE pars=
ing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 9:

(2 comments)

File src/openvpn/oob=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/c9972fc4_8a4889bf?u=
sp=3Demail :
PS8, Line 161:  * skipped, so the scan tolerates additional/fu=
ture TLVs=2E @p payload is consumed
> the scan?
Let's just leave "other tha=
n probe_parameters are skipped"=2E


File src/openvpn/oob=2Ec:

http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/1554b53d_267d712a?usp=3Demail :=

PS8, Line 226:     }
Is this needed for the clients with the wrong timesta=
mp?

At the moment the window is picked as --hand-window which is 60s defau=
lt=2E I would say the implementation is in accordance to the spec:

> Any O=
OB SERVER_PROBE MUST include this TLV=2E The timestamp allows a server to s=
ilently drop any request that is not in an acceptable window of time to red=
uce the attack surface for replay attacks=2E



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit=
-Change-Number: 1742
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Comment-Date: Tue, 28 Jul 2026 15:04:42 +0000
Gerrit-HasComments: =
Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2=
549=2Eorg>

--bjVKeTVurTQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1742/comment/c9972fc4_8a4889bf?usp=3Demail">Patch Set #8, Line 161:</a>=
 <code style=3D"font-family:monospace,monospace"> * skipped, so the scan to=
lerates additional/future TLVs=2E @p payload is consumed</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">the scan?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Let&#39;s just leave &quot;other than probe_=
parameters are skipped&quot;=2E</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/=
comment/1554b53d_267d712a?usp=3Demail">Patch Set #8, Line 226:</a> <code st=
yle=3D"font-family:monospace,monospace">    }</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Is this needed for=
 the clients with the wrong timestamp?</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">At the moment the window is pick=
ed as --hand-window which is 60s default=2E I would say the implementation =
is in accordance to the spec:</p><blockquote class=3D"blocks" style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Any OOB SERVER_=
PROBE MUST include this TLV=2E The timestamp allows a server to silently dr=
op any request that is not in an acceptable window of time to reduce the at=
tack surface for replay attacks=2E</p></blockquote></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=
=3Demail">change 1742</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue=
, 28 Jul 2026 15:04:42 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--bjVKeTVurTQ=--


--===============5591818265164922706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5591818265164922706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5591818265164922706==--

