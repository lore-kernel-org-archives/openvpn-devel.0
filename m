Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59D606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Jkpm+bPa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lgozzEGc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nEF2vF/+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=azAh3Wsk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8AMmAzjfnV47Mec7Wu9bQkkYAb6GQE7b2Xm21cBQBI0=; b=Jkpm+bPaaKH9S+UnJvu5lFquDe
	7PiykjG+k8piAztIrnRH1iU8GrPOHXZkJX32Jra798ImybF0pGYYsYv33Ze3GIvSeO9mqcZg9HIG8
	O7lN/NzbkQiSj4zt3mgRnQSXyD68a0jFluyPY73KeuD0vmUoBJKCdEtPWe2O2f2PdHhE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJxVt-0000000059b-1CwS;
	Thu, 22 Oct 2026 18:27:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJxVk-0000000059P-05zv
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 18:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yV3ltMTogcwbEaf7D6TrpIikzYeJTmd/3vcI/9iwAZw=; b=lgozzEGcjkGla+r7dVs5CknbRB
 G2xvSU5Yb6J7x9er9VPQUM+X/BxapJH/zjutGtR4jk7ne9Wu6zjXJLnHpkmJYgcwvpNHFUCiuAv4n
 Mzak+3RssQqugsDQgtOQV3QXZLJfi9W+0RqUIDpL7UVyi3C0gZeRmuofMcrQ5FOSXddo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yV3ltMTogcwbEaf7D6TrpIikzYeJTmd/3vcI/9iwAZw=; b=nEF2vF/+QSTiSTdgyDAdCI1Tur
 Oje0ilMqwBcL2R7d7vp7vdf+SuB7y/VjLdsoOa/NeuZK/6dS+H5jAS0yJQvefeUVqezhHzhw/TLO1
 0iEBsR/9gTO1jdnqp1SIdNnPG8DnLskhpHY/lZGy9eHIL82wb660Js4ebnyDItkR21Jc=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJxVh-000000003Jg-36H8 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 18:27:31 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so928671f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792693643; x=1793298443; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yV3ltMTogcwbEaf7D6TrpIikzYeJTmd/3vcI/9iwAZw=;
 b=azAh3WskWSNTb8ee3tESSVlp3pS0gG7M7lMsqL2VpsB8ZLc4StihpOzk26G3QdiCdp
 kAp6JFqv/5ZAIJfdeYCwlU0ED96MSR84O8WbdcvtNIQsw6HB41KxWYlryLFrwHwZMkZ3
 8jqhDBsUz0jvt/nJwiHxK2DqIjqfR4j3WG3Fc87MUAKWcAokIPtJaa3i8fupGfWIdF/R
 606pgQsbk8zBdYh9y+w860M3oeYG3ixXquQ6eze6s4pLzqhtMBB+jXZRp6jjGz1fE4GW
 lNU17HunPe/31lj24wmIJpJZ/OXb4hlbGgrkhn8wOfkVJHy+VaqTxdjLLyJDP0Yq+lAG
 ztWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693643; x=1793298443;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yV3ltMTogcwbEaf7D6TrpIikzYeJTmd/3vcI/9iwAZw=;
 b=rPV3GaGsyVEFtAz8wi325B+gMvBsu4GqQEHTXm1O6RUNnpEr/L6E4dbepKyyCH53dq
 YsIVXrRtqtwKi7ONTSGc8ywHyKG8t/oiVKdP+fDRwmstv/9zGw3KKAiVF13YR45i63aN
 geLP4A9GoSCzWS1lkZuI0YvgAAhdhVvC+S7tWt720/46ZVnTL1oizTE4m/quapjmKC5x
 JvqsWP6P8p9XF+Vzi8vGy0P2aiLOyfStfQDKyQ5XcYBYWUHxMbsMtjO+gRGz/oZpQ3G/
 pZi9FblLhpJ2DHQq45TyDXBewdmOh6hPQrOPgfTKd/AZ3PdXLJsm40sV1Qaez1RyO2n5
 L+DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbqAoKi9SpFdNKkYz9Gfpqe6nabpL/XcRmvyGUq1ZLCBMvxSKd1TkmhHonSFe4WHjwkoQVEFvUtDdiU99P@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKVz8NXkZUmmgPltcqK3E9E9Ti57Gp+UQCpTLVUjaw3jVoaWwAR
 2z4v/RAnTvE2t4zDZTMqZ7v5/MQPYbTpFJlFv+o+o3wRDCwb60p3v96lnnC4oHXkynqyZ2aHmUx
 6m7RQm/JY4XiTfXOewgzDVJt8wEflc8PfUoe18FNp/a1LqEVmEZ0NYkvLfkymzk3UUrdk
X-Gm-Gg: AYBFou3HDNUBuBOoxRMC+8km1y/xhrr27mepbLT5CPLePNpt+WN8PLaijsD31GODqKd
 urIxV+o/AURLOFEuth4F5dGuK0NYvSH8Ciodtc4DixoGzevPn26vqCVwBxCOAcoJXP1hBrlA75I
 H8QfomznUxEB1PEhT4s+uwgCm4YfsuD3vxpEQdibgLUs9HrIm++LFx8TLCFmzLaE4JCT6pcIBIy
 VwZdB3s7fZlN2CjwP8NRUsxTViFp/B3k8UiaObH6U3b8s++zCmSJqrIQg9kMKmgrcPaE/0afu2p
 yVn+0/mG6nzHwwfAqcKHefvn35a8QAq0tMIDTli3TgtmLV0rjQAX3EAkNia9rExfSchQdiPIsCk
 akLwZIAuNpi9INNZvKGFukSldZf9nSf+8IO2i3VWBR1N8f5fwuxOQF8b/ISH98Dco7uXIufQpK8
 bRdxvxJDhIpPwm0ktd3UOb7uhsqDV2wrb1B9eDUdWh0Ah/ajcLAifCiKO11vEMCv+3LLcOYwwON
 KRZ+n7JoDM+S3yyAwB/dABfd66t2i5SFiOWOGyXFCauUPmSL7pyJssfCHGk/Mb4sYYaZwmsvXkH
 lf1zioYdNZjrdpeIeKbJLq2cFnvGd0d8667JQkOhROEwYUs8TZc/v/ulJX6KDBuB9BCnUwbimPH
 RcPpNE5sjS5BGgfUvZa6mQBa08yzjsbwTLL3mzbgnqQ==
X-Received: by 2002:a05:600c:4513:b0:4a2:1a:a11c with SMTP id
 5b1f17b1804b1-4a2047df0damr63420045e9.0.1792693642955; 
 Thu, 22 Oct 2026 11:27:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21143ef4csm3203155e9.3.2026.10.22.11.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:27:22 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 18:27:20 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 2063f63886796ac4afd05e7509268c03bbee5d3c
X-Gerrit-Comment-Date: Thu, 22 Oct 2026 18:27:20 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32eeb17485eaebd65e8ae48b356c2cd9d83e5cd3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJxVh-000000003Jg-36H8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6449482793400247821=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6449482793400247821==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n5wA6gs2zOs="; charset=UTF-8

--n5wA6gs2zOs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Max Fillinger=2E

Frank=
 Lichtenheld has posted comments on this change by Max Fillinger=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail )

Change subject: R=
emove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

P=
S1: 
There is also a clang-format failure


File src/openvpn/Makefile=2Eam:=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/6c4b1033_bdad1f51=
?usp=3Demail :
PS1, Line 95: 	mbedtls_compat=2Eh \
you missed mbedtls_compa=
t=2Eh reference here



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2029?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Gerrit-Change-Number: 2029
Ge=
rrit-PatchSet: 1
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Max Fillinger <max@max-f=
illinger=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Thu, 22 Oct 2026 18:27:20 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: Yes

--n5wA6gs2zOs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Max Fillinger=2E </p>
<p>Frank Lichtenh=
eld has posted comments on this change by Max Fillinger=2E</p><p>Patch set =
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">View Chan=
ge</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2029?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">There is al=
so a clang-format failure</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/Makefile=2Eam:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029=
/comment/6c4b1033_bdad1f51?usp=3Demail">Patch Set #1, Line 95:</a> <code st=
yle=3D"font-family:monospace,monospace">	mbedtls_compat=2Eh \</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">yo=
u missed mbedtls_compat=2Eh reference here</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3De=
mail">change 2029</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2029?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2029 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Max Fillinger &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Thu, 22 Oct 2026 18:27:20 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: Yes </div>

</body></html>
--n5wA6gs2zOs=--


--===============6449482793400247821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6449482793400247821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6449482793400247821==--

