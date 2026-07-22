Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECC8C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zib5KJ8gC5Ikk9afMzuyrWwjePQsc9X6Vb4eK+FN28o=; b=WpeUb3wM0hjs0PG/kYEQ07M7Gk
	yS7TEHXYnCun+kybQh9vEHM0+wgzqJ28Tbt2NifcfVoFDWsesNKmRN9/4XBvsDv8GjpEbK5WW5DBP
	qCrzLBmXQgrp4vMOozvSK54FKRVbV0qRNP+WD2RPmPyt+sOgeucxR/H3WteAXcWdn9S4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmTwR-0007Qx-1Q;
	Wed, 22 Jul 2026 10:12:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmTw5-0007QZ-SE
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pOlHc+OqeiwXsuFySGDbnFaLUBmGKwcECphb2jjAA2U=; b=fvp0og+HELkXaUewOVvbfiVktm
 nQLovarcf+CKxaVJwpm0eEHpSMEsxney4IcdAgySq8QdbJbAyqHVH2cL0U4+TT9dIyvUTySUSqYr1
 rC+UiSYPJ8AIBWk7mPLL1S7cUOsCfF6oYu6/I3sLvpOiANPAE45fJsCN+wMDijcTc5Yw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pOlHc+OqeiwXsuFySGDbnFaLUBmGKwcECphb2jjAA2U=; b=g
 A/fNnYQSADBdvYShNbSGgudVTX25BjFvPdOv3yFHUm9yuQf7VCLZdoSokiXYm6OwgjxTt982DuV0O
 C8xea3LE5XBv/W0DKV+f8/4FVU3WPdwBQCjF/YPsP6apPyPSvq2Qw+qbANT5M+LPSFiJ7dIrljQu+
 OVWBY4vIvUbTzwV0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmTvt-0006oY-Ty for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:12:12 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49547fc63a0so27103905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784715123; x=1785319923; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pOlHc+OqeiwXsuFySGDbnFaLUBmGKwcECphb2jjAA2U=;
 b=ZE26c/HI0pXPqWHfQuVa1yvVMNwCize9u3p0r+M8xIMfVZht9PJjWfuQJ26KiupHrj
 d4OYif2YzVhuqnAObtED6X2HFvIT4Lb3qJab8eldQOHB3uPj6aWk95rNqzQsU6hcduEj
 GFB9hpqBAfos/EGxgxYvSq3GBMjqDptTnWx0Kl/4w/Y3Gw2vey2hErp+foWrvICHb3Uf
 nbDdQAOAfXunSdMEIKzDm8qHbPw3riA/dk4Csx8vCrQqLUwb+2HyH4MRZej6QVKz9gkD
 gjifR0LfmdhE666cBFdbbXh7QcZvPYpSzl7y/J0db9UBls6KUWSFQuWXLeKt3o4KP545
 ieNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784715123; x=1785319923;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pOlHc+OqeiwXsuFySGDbnFaLUBmGKwcECphb2jjAA2U=;
 b=SZJSlFSPMzWXUfju6mBzA7m4Ix7AJadGPAUu0uOb7OqYh96kH8Yk9q8yYtz9mhQa4U
 dJDv29uBlcbBecgLTjYYzboOQeDmgxOBctI6rhFrIe7syhJ4BZH6JDxqi/ezm80zIuI7
 /jO1LohQfaoCy7Vba+rqcKuylN+xb9cePSce7jYoeH2gzLTU7fKh/WvaGQN94PPfj8J0
 jtyY4361EMbPaymGxzePq4FwCyiA5xQ875H6RV0H/s+MypskE3quHHRb8XW9U4JsYj2/
 cBuxaNSvzhhV22TdyEJ1JuohpuZ43ji118EM98dvJh3Lji4g/wuzCQyJtHc5qmmNjr9Z
 I8Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOGMtra4UXrOnFev2IGOJAnIGoLLCko96bBp98KX1GwQaSGuuRoIIZUdxQWqcH64Mfrh39hfLtYmImV7QW@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyhw1LlJzibbYcxKZAz/iziFVQZdJcyJhqdTEz4mwG2ld68/n+1
 hBILQS23UyO+XbpQ6SwHC9FB2qmgaWhCOKq5My95DGputw2WlBk6/2QOKShifcPOWigOAjQ2IDt
 Vn6mkAKD22nGDEr3vosEpjI2eaER2LYNEvf2TqoCLldaM0FlMV9z4Da5Zehc/BaJOo8Kz97XbWz
 Dj11pS4g==
X-Gm-Gg: AR+sD13Xk4d0VdPDBRnWbaYqTrfETznlHqsn+yE208mbEjVkOSaBxrcZliNrBqSyZPC
 X/5mf0jHv06ztsln1Gk2MOI4Alb9tdm5/DR6x9dvZLNLbYEKX+Twey9/hOgPseMQN5Ll1L/HabI
 KQLATa++ystQirzV2esNVR+1cxCpWZFGM1bdTxBCqoQI+uy/stDebfocIG76/PnsbOEUseRSxJ7
 CgbdbYWMGr+mfDxEvCvbc8rdAtpXb8IAr2Px5Vu0c1ztKH31/bysIHJh3QR1Y5FeGxAu+kFUWy2
 IQ0aPH1kjkVhlI2gUWEF+AOwTgqwzvq9DPLLev6pCs6H0SSyfwWXNaGz5alArfN42Qc9bKpO8wB
 AghC/TKNxgMOI/WveqEq/n1r7p5jJRHE+whYYKuFlLPj8WP6aZkbwRscEgDxBjd9lUEQgCB3mZr
 vQMaLEKFd9yBqJvw2s+LqzZ39SNAo4oKsqNdcfo7gBRIyGGGJ8Ovkp0Gnir9zdNPLzwUfPfS2fA
 J4D0LxKHgzEla1bgRUaZM/CuiWods3twSoEW53YHa1tvtbO8OxJMcBximG2DwTZFu5V
X-Received: by 2002:a05:600c:3b91:b0:495:4c62:9d43 with SMTP id
 5b1f17b1804b1-4954c629e5emr294549145e9.34.1784715123045; 
 Wed, 22 Jul 2026 03:12:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm4433908f8f.27.2026.07.22.03.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:12:02 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:11:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: f53adb3c21b87136486bc9c926247d68403c9cf5
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 10:11:58 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6ad10d493de7f7bdd7638f5bf64827fba2f2ca1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmTvt-0006oY-Ty
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6122880645094767354=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6122880645094767354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nRxEdjDws8M="; charset=UTF-8

--nRxEdjDws8M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 7:

(1 comment)

File src/openvpn/sid_hash=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/66cdb410_efe372ef?usp=3Demail :
P=
S5, Line 59:     struct hash_element *he =3D multi_hash_sid_lookup(m, sid);=

> yeah looks like the "just quickly inline the function" in last iteration=
 was not a good or quick fix [=E2=80=A6]
Done



-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit=
-Change-Number: 1727
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 2=
2 Jul 2026 10:11:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Com=
ment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-T=
o: flichtenheld <frank@lichtenheld=2Ecom>

--nRxEdjDws8M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/66cdb410_efe372ef?usp=3Demail">Patch Set #5, Line 59:</a> <code s=
tyle=3D"font-family:monospace,monospace">    struct hash_element *he =3D mu=
lti_hash_sid_lookup(m, sid);</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">yeah looks like the &quo=
t;just quickly inline the function&quot; in last iteration was not a good o=
r quick fix [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=
=3Demail">change 1727</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 10:11:58 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comme=
nt-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>

</body></html>
--nRxEdjDws8M=--


--===============6122880645094767354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6122880645094767354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6122880645094767354==--

