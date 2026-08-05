Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A4FC55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QtQREA3qsPYkAbWFfHHpHu3LAO4Znu2Ht/BAhCHCX/Q=; b=CavSO19edWQPbpPKgHA3jD3H6s
	lkWdf0ZiTCGxJcOX1A/kB9VqokjcumuCvYM+VCLh/6fgdRZZmnCSaAuuiwMKYkG/ix+k2Vk0Wc+dY
	0K4cYPPx/mcaxXre6bd6/J+KJLWhumaF0m0LWfd+6aR6zClvSVzzsXDFq5RSczYp04X8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrbeg-0002Yc-QK;
	Wed, 05 Aug 2026 13:27:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrbeg-0002YW-9M
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HbDZ/lgknM5mNjfm4y21eeQsdni/sL+61XrkQfhr1oY=; b=epeMo7tRF0Jshp+deFBujV8n/2
 1iVxt67vSLnd22jatSQ2NMEpqSzaoNf6whZ1C7n72ayCAtktinDIlVHoKsqZxHz9PbU1OlEaxEqqQ
 QGzaGn/Tf3uiE5Dc/4CBvx3ouz0uVN7/U6FyqPkyWE0QEtDsyBg5+0+WxGqvDhJw9FUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HbDZ/lgknM5mNjfm4y21eeQsdni/sL+61XrkQfhr1oY=; b=l
 X+8JYwp1Y0o1Omq6CdrUew5wTmMkcqKWeu+6YojP7HC8I5c0p12s8XMbdYQosh1AQwDUrz645ihUw
 f9u2gSMLgymXJLRWNsvOh6KhpbNmoENpDq2Bva625UhOjQ2LoWDIMcu+od7l9Sz8ogva4shjnXKtT
 3L/f5AXUqikdA7Uo=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrbef-0001v3-7r for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:27:35 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so5102705e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785936447; x=1786541247; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HbDZ/lgknM5mNjfm4y21eeQsdni/sL+61XrkQfhr1oY=;
 b=V5bTBJkiRAnwu1CTLfH9DXPeWlxXG113DlCEmJrKWSfRDLgLn3VD4KK1UFQzq6ukub
 pg9mGuvWYKhB3Y8ShnRkezB6ULa0gNjSaMlYKoQjN3ESeKtX/yS7WtZ2GV/IK5RZcb20
 M8Ip7p+01gosTdFuy4dKstZQBAL4ZMtZhBiFSYnALnGIyOeKJ5oe3USU092MojhsCTGp
 orxOHHCsD/dOYmFzQrbTWJb1//GMmqryD4Js+BWRdS6xmrTYnFc4AKf1Nt1oIiPlGPbl
 TlTHTdSgCILGu/b+YdTq0Eo9Y0VROAF6HIt2DGF8O2riInp/AoVSuLoFvUqpac/w3gTs
 LgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785936447; x=1786541247;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HbDZ/lgknM5mNjfm4y21eeQsdni/sL+61XrkQfhr1oY=;
 b=P5+nVMfDinQAbgBQPjKMmKjggQm137YP3Si3gwhgb6y4KFqEr5FfSyqUTgva0aetGr
 CfIlU2RRsG4QkFYr2zFTdKXIBQb89ipHWeF4d4VdVuqy7J7aiegPUsABNxbtdT4Maipx
 Ay6Fvgm3pya/mky3J0O3vO4dR0MqNWspBdMpfBeNO8i/wGCmxzw4cXcEngoLYEi5SYsS
 /KVOBf2hSOeBYhF/1mTrTxDmOkKvM0Ynk9jfK6785RmuOcUlAX+HWZi+IhZRUVJ61se2
 YSmqU72D11sXP1IX5IK5DdJNtdkafHiUHN++1lL1ly93RBVgbhEMImO/cM91Jk7Bi06H
 nmmw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rot0Ew2rPGRehrzpmjWSv2/tboM81PvEzNxeSXv2q5AAkGnJNb8ntkF0YEmEEvWCaaAwuQsqxV1qxdOBLqX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwbcxdklEtEANUNzKXEDBi2iYpsdkL/xcYMEYYMYz9ApxCwAsU/
 xEFZXaSd13JoBpckMfdglRFpov0py1LDYKnxso1WCUV1JDJufhRia088mYDlnzvwUh/uE3cn3l4
 q0Zdg14K4tX9NL57K1Uw81dV1YKVkUurQvrakciRPSHgp+zGB3fv9EwVz5YGEsAKbYDWt
X-Gm-Gg: AR+sD12OTjBhkDOajETzh/Rk2niDNkqUB33sajSkbzNoNNihRINTg9uIItyuZuRSncs
 HSfrs5rO7eC3OZr+5v+0bPwrFFuAAjJ4RXbZ4mtlqXwVuqbdnr1bHpQDE14/6gchLYppo8NTLlv
 3RICi3QLNfuqVimSsVCl4xCjVpytQ2blMd1phXvBdf7vqBMHQxaaymWfzOSRAvBMGvtq7QdfhK3
 iiUNM5FL10vuwmQAtBFTiM7SOpQIZ18uO6bdK0mKUa8NI6bymIZKrBjnTRnYY1v2VBakcWcRTWQ
 2BKZqUUhE7p2F5C7LrFJKH/6LtJlyXpcFOZjCrnCIytrlV2xle2WPIRfcEKuUUNhv7qbERO43dL
 vdZwWD8FkX5fEToTgcstpcCGvpvFxGFeaCrTG92DmBeF/5pViv/HO6lbjv+W+H2sqZOi6DUYo+z
 RNarYMwnGdCAAX8hsTlteWBfy3VBs/E7xaLn6D30U1Sl9BJjHzXmQZ6AS2131xDh6Upn570ZCJi
 wbtPMPFDXLw7WURO13ov4dX6ZERvQdpUyDbqW11YCu9iyeclL/nSLsbjqcF/GEqJdB6cadnFoAG
 vfDXKLvDd4lCjSNNr+ilFb4+ank37I5lfk2D3nl4hH/Ay1cdXYE0rI4VwGOXVQ==
X-Received: by 2002:a05:600c:4f4c:b0:499:4892:e84e with SMTP id
 5b1f17b1804b1-4994e7b74afmr102843595e9.11.1785936446430; 
 Wed, 05 Aug 2026 06:27:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e4bf820sm47020035e9.0.2026.08.05.06.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 06:27:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 13:27:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 673e321220a104f42914bd04adb1968a7b2d9112
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 13:27:24 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e13ff0a5435d6556a1dbf0e6b9a9db0f9d195efc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrbef-0001v3-7r
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7455684505500377354=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7455684505500377354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PPSYM5zt0pI="; charset=UTF-8

--PPSYM5zt0pI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos, ralf_lici=2E

flich=
tenheld has posted comments on this change by ordex=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exi=
t the process when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/ope=
nvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/59d4e=
133_1e230ecc?usp=3Demail :
PS2, Line 1402:                 "notifying users=
pace=2E Restarting the session",
Nipick: Missing punctuation at the end=2E
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I564edc6e0cc179c2b8=
b5ddef5e80838949fe9fcd
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 2
Gerrit=
-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Atte=
ntion: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 05 Aug 20=
26 13:27:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--PPSYM5zt0pI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos, ralf_lici=2E </p>
<p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1835/comment/59d4e133_1e230ecc?usp=3Demail">Patch Set #2, Line 1402:=
</a> <code style=3D"font-family:monospace,monospace">                &quot;=
notifying userspace=2E Restarting the session&quot;,</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Nipick: Mis=
sing punctuation at the end=2E</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change =
1835</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1835 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ralf_li=
ci &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 05 Aug 2026 13:27:24 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>

</body></html>
--PPSYM5zt0pI=--


--===============7455684505500377354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7455684505500377354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7455684505500377354==--

