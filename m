Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995EAC5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxvdXKveqqR70mqnnoCZGpQMAOsEixBVGrhhVjdhD8c=; b=Hh9lkesT8KRwtKLvbCXRSnXrPo
	TsO3vJpnS/sf4Pbw69GlYjoADo79Bjb3c59q86VY9/M4buEj6nqH15bhIegi7EklrCyH5KPUmIjkx
	7x374LL0ZovHsPG0nDnbYxXPtsMNAaZnOmumoFrXOJznMB3rT+5K7SreXe4eF15PmO4A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiOR-0003nx-8c;
	Wed, 19 Aug 2026 15:39:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiOQ-0003nq-0Y
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QntdocT2PDc1CE5Kknw9FwYhHKuVuNl7WvUyQdIEIrI=; b=Tp6sSoE0Hrvt8210GYv1QHd3rr
 Vd+Pvk5fEvrk2O3SBlmPOBoN9TQce8JeiSKl5Cxk37LIE4gE/Ui9vTP3QfwnfKg28uSvLlW+hPVeX
 yVfyP6YrJWdevI5PpOKyxYOgAYaiTL2QwJj3hQXMe57mLK/azoMWT09xSpwzn6/odXQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QntdocT2PDc1CE5Kknw9FwYhHKuVuNl7WvUyQdIEIrI=; b=U
 m3vbBAtdLOM80dyIAog/F4lJsX6zTJxVS7uXW10f1jYz5qawCTMUYm1EFk8Zw4++0uQLPDZPsSw9Q
 owb5oJ0BGJaVN+sPpgzB3Chmd5+pJ1GUWG8CeSjTF7waO0ECYmilnE2158uC7slK/YxafKKGUKvqB
 uO8CYzAbCg9frOb8=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiON-0007ll-7A for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:39:53 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so11303755e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787153985; x=1787758785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QntdocT2PDc1CE5Kknw9FwYhHKuVuNl7WvUyQdIEIrI=;
 b=HqQ/BaaU2Wp0znQmqTn9pbiOxBdxUIQWTjWKTuFvcAWJB05ovIUXdubVp288+Ie2h6
 jmvkFUB+MnPHf82T8XXegBhk/vjVohNMZzNFJDCiwk6zPe8uNMhmN/IAPPmvxUHM1kSU
 Io3mU8InWceo/oLkqRtnprMfDsnxDVB+d8l7hHusYIFMbDw2POzxIZtVB9pNaW2/JEqN
 ohgCw3hRFdxBZ/Wd7yWrT0wm9wJWBy2sO/CSDah+93w0W4syddfxfzPb9ayHH61PyZ+G
 84YK+/pO9momxuQ3FtgeYb7xU05jcfcCONg2IA+SV1EaFl6xYfIM/TKxdCCsq3wid4sJ
 UUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153985; x=1787758785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QntdocT2PDc1CE5Kknw9FwYhHKuVuNl7WvUyQdIEIrI=;
 b=IIDXCPJQGCdXMFEFWd1JFKg9fWMG6sEKtzaSFnLQs0ujgGyU/9TjtM5WBL3gyeNxEQ
 kEaQu3Ezr/EL5/DrT7z0qpluJnCENrsUkJyKIO8J7eA61Eqv0WefZ9GHBGKH/66IQAir
 SP2Sf3UCiLqaJXvwzexPHlXgg/KBfoAbGU9UX22mIPN1dsrwQA6a6+kIzWn+fPeF3nYQ
 aHYddyzb1RTx1phDh+u3Nd5LlehL2Hmm6FDTgyNOsotBOJ1VlVdumw2KCHIU1s4wz6J1
 2s9mH0o0Q56yBqMEpqiCgvMXy+/P9NEW04wbhXgf6kmwzgvY8M7wqpr1MaDPoZ67CH0F
 VT7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlnU8x+1Uzm14ezW2W40p1d9XNV+oS/MmQ7jlMdDZ/WJ0fjjs8pWLrzf+BXaWibIik6rqgf83OXxaJn5Ox@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwGDzzvyhAJHcvhWTZcJ3vAOCV8Ju2r7gIgG+N99Srxy0YGih6M
 hoV/d4WvXz9mk7fM9zfLaKFWZhKTA0i1bhdtcUo8PACQ+G5AZSVpkT2818hKUnJuPBkovj/s23R
 926vw5b1gYDWuR+uqA9JQUQy0JrGJU7jTBJL5lsvxCWlTckP5vZgCrue/p7+HILgSY7Oa
X-Gm-Gg: AR+sD13EVP5VB/96TOt1+ROv6Src09wak3nECjefseNBZxSwQoZ+De+qBt1ZnkAv/QY
 esN4yiv3q4ZM6c7fFqaSINyVWkzgSPSbStRZBGYRzC6PB/1WZqV+J0i4nrKu693vvYwbt9Tb8st
 VgyB8ipXR1oAV9OE0zJ0yhEira6UT5gmB3sENvVu8LlhBfQ1fUjH1QfVHutGJN/9a61HwKwJB0B
 j+BY1Ie7MSXZM1djBnsPTVJVtJFJyzZs/n3WlULNOpqwdTShXGqG7WsbmlwzIFHzpL3WRuniCm/
 GyxyXVkTdXVGR14q32hVz77RwvX0kCf1upaxdJK37Kp2Rd17NChgvu3ndcsey8AY+DFTWtzbNRv
 udFT+o/nvKMS4sBgxgp/olw3syq9uoWgCfyxCwlNFXzyUX/BlA2LrlhhhMs9sGwUoZzr0b1etUH
 CAFwJWgJN43xBRqu/upm1RAglf1n8i0wSRuA5swG1UwoS6tZM2xEN4aZRvkx/dO657ZJutkV0ow
 CnojobhMBAXtFVdcZI/ihp6jstbp9BRMAQFESz3I2Mxmw2DUpPAmy3Pq87c7VK4a/MRG81k3XDi
 bLIMM7amjf4tI20wrMMawfu/7obUHsq4JyvXpvYlsfyppkhHzTLs14Bx
X-Received: by 2002:a05:600c:468c:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-499aa180578mr91045145e9.1.1787153984471; 
 Wed, 19 Aug 2026 08:39:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e0eee0sm52628175e9.4.2026.08.19.08.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:39:43 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:39:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: 3e9ac12d79222f17b2911a834dd5c473ec6578cb
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:39:42 +0000
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca680ffb637d2e91ca01c23018092cd675afcb2a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiON-0007ll-7A
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 file access code from options.c
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1975893466739859115=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1975893466739859115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tYPx03WTL5k="; charset=UTF-8

--tYPx03WTL5k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1774?usp=3Demail )

Change subject: options: Factor o=
ut file access code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comment)

File src/openvpn/chec=
k_file_access=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774/comment/=
a922253d_14924181?usp=3Demail :
PS4, Line 36: void options_postprocess_file=
checks(struct options *options);
> Should we have Doxygen for these functio=
ns in the header (or also in the header)?
Done



-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerri=
t-Change-Number: 1774
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-C=
C: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
omment-Date: Wed, 19 Aug 2026 15:39:42 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--tYPx03WTL5k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/check_file_access=2Eh:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1774/comment/a922253d_14924181?usp=3Demail">Patch Set #4, Line =
36:</a> <code style=3D"font-family:monospace,monospace">void options_postpr=
ocess_filechecks(struct options *options);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should w=
e have Doxygen for these functions in the header (or also in the header)?</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">change 1774</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6dafab74=
b82fbf770c1798b4851a0fd5e4b5d81e </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1774 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:39:42 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Com=
ment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></ht=
ml>
--tYPx03WTL5k=--


--===============1975893466739859115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1975893466739859115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1975893466739859115==--

