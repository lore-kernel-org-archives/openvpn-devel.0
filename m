Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA65CD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bF6l0mdqK0E27FpF5P/cATl3ZMKDzSO5DcESzCTqGOc=; b=Gj4s0vG2GQ6dqRaBBdkWeTWBYn
	jXRgJNEDvebUltJ/iji6bRrd/2ZCNkBD+zJyWu66gH6YEiChbXQSplxwtrIkiINfm0dl/XNt0QKYf
	eIJ934O1z4lt+UR+n12EXSggxR3ISN61cxbUWYYMhEiNXsq/cE+q3zca9VcdihOjJ3YQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa0K-0001gH-VE;
	Mon, 08 Jun 2026 13:26:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWa0H-0001g9-IW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HUvsem0MgFNuIQdTFVnLKEdDH8oQRgv61zUaUbouS/8=; b=aeeRQGxJJ2d4MDhPgUYqVzLiAs
 VIpjlMJ53+S9Q/q2ajmWO+Mp4MWbx57apkdk51FoPuz9AIY+lvmrTCnQrS71ty6h48ZaTC9Y7NmJ7
 0Am1aZsy6ojsE62yWYONkvrBB2r8qGt/Juu21J/RHv+phJ0+HpK7ZVApEBsiKugMLSLw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HUvsem0MgFNuIQdTFVnLKEdDH8oQRgv61zUaUbouS/8=; b=Z
 94bVGQvjpwPrlmebzc2kyTvBjQB+nD1ioEvdQruiqAnif0wuy9rVqjSPPD+7UKYmd53MmU65UvuII
 ZJ5l29lkMM7BrGw94xHVWeZE/esKCTj7CdFTOv/A2G3p+7H/K4/PZK8JQVrI8bcgreJTNdLsMi9J+
 r5qR2sw6SWdGMLCE=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWa0D-0004MA-8B for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:26:55 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso2173627f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780925207; x=1781530007; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HUvsem0MgFNuIQdTFVnLKEdDH8oQRgv61zUaUbouS/8=;
 b=YX7ampwMf5jJNdTwTnjeGEKopxFdaye6KHNqsUWIUt4ETYM6UdWpabuZ6IQ/DiwtGU
 Z/shjfjgKBVf6FhEDD4cr0GKxUSHAQFcF4oFiEtd/UuvbY+b9lBkLbEgwkAdrWWKRlFK
 7gFucOYoguotFcaUz1TICAWiY8wlY6HpS/+gyfkZkZf4OJvtvwoU/ulwisu7faQ4ab+4
 7VM7k9TVaJvou0bo9hukBAwBjCiOrgTP8Q6JJkYSNiGHyUHWGFd650Cvr88BBPRXub50
 J4Dt3clvKhZXIBg162AkTrj+cPjeqgxtN7Yhc98rtshIXTv0iSCKpsZZkIxZC4aaiDtH
 EE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925207; x=1781530007;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUvsem0MgFNuIQdTFVnLKEdDH8oQRgv61zUaUbouS/8=;
 b=VezPdH0VRda+GSOuo9THKYFrSdCWTywuNC5HYKRQyTJ4kzmi9bJstztoPSO9978u/o
 9jN7qlWZlcP3anaJJjMcbJs4lSuzWK2KYawoHK+0DPiOAfXst7DnHY0ejRvXq5qUA3TN
 JUVTdO8Nf/A1o8oaor/c53uG0ANeVG6VH9KEbyw9iKtXn1DI/8UMKJXFw6h55z7vRUXA
 2kT09+rdmKKB28NbGBEELMIhs9sa1V1IRgydmd9ebWDnR2Jd9bFzWl4ZfYLdmJeCsVmt
 He1LmvNEfFjMqtN+v4Jjl1WrrpARou2nrERemgOLcvsJGIkASV8tY5rDonMkw7Vf7js6
 HEKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GlQAz53P8fXoxEQDU3E1tNYQcN5LnKLlvCBVTcrL/r60Qb8gv1iFy3Al2BLf/zOz3yucO0IY9Dmo/+rrT@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyPg/eo6qL9/pRWAdqBnyJiJ2PXnmRyoTKGgEjnEakBPgPjPUh4
 uMcJnxJJfdOvDZip+WJURhSICk29BATOzr80ndj8GmV65PkOlarzJL4pSjFfJMgVBtgxFvXJjiL
 bjOZWiIJetHSaSIwEh0vAOTV7F5JxUa1VrYgAPZasac9R7KsE7l2ioIPyQTrEhlJ+YIcw
X-Gm-Gg: Acq92OHkBYOYy5dc2OOVAiTsrzg9VJz5D80sgvl26veKg8mwb67U4ZUdwhTWpLnoz7U
 mxgk5n8EeVbxfsJBYwmJpAcPPcfbqWEYxkrK7YCdUMR1TXYvbY0B3jV+iC/3fbcNAnurDV0ydUD
 axHhzpI1P+Qt6YapypeedOWBIqK8j/DCCR7c2caE7jQSjgle7zAoHTp+iFWH+TZERgXlSnaZrNq
 f9Nnidh24M0bPd+cXz7hmYzqDBBcKZSfIMxZZAtPnnHe1pwDBD3SoZYfAQHxuOdB6rtRdY4aI0L
 pApNwx9Gdr1XVIDzznQDB/uXDJPtaLSIAFnmJsa1ZacC+/NSgTl7Px5k+eX5Mk0CGD2LLVHUvmL
 QgrGzOt0HkR0SEs+iRBAlvAxhNXUtZcyfNqmCOh06ki4/s3mLNCLSTcczdcD19LurcGqC0BaoEY
 APW4S9hsGUsl5tWgx+9iKICP1OJLe6SCPDEPFB2KDpMikR4LrbHH85Yz9hkzcAAlERvPjitDwa5
 EQMyxDOyaqPqQaywqCcIkA3HU/Uv5DY84vrpocv/YfX2GmLETrT4HowHlTrHqdq4WQgI7J8JDte
 HMjR6+DkagpThhK1TjOAuj3j
X-Received: by 2002:a05:6000:2993:20b0:460:138d:c9b0 with SMTP id
 ffacd0b85a97d-460302dc735mr18269321f8f.2.1780925207111; 
 Mon, 08 Jun 2026 06:26:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2eadefsm53878949f8f.11.2026.06.08.06.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:26:46 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 13:26:44 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
X-Gerrit-Change-Number: 1521
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1521?usp=email>
X-Gerrit-Commit: 0356b37647206fa103cd845e666a8c1f80906477
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 13:26:44 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@gerrit.openvpn.net>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcwOTg2MTE4MDAwLkk4YjBkMWNhZDcwNjI4NTZhYmNjNDBjNGUxNmVjOTNiNDUyOTViYmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b7b85c573deccd5fdb0f39e95e523ea999544f9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWa0D-0004MA-8B
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for user
 defined network namespace
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2890901943785350542=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2890901943785350542==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6F50lcgtBBo="; charset=UTF-8

--6F50lcgtBBo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

flichtenheld=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for us=
er defined network namespace
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 11: Code-Review+2


-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit=
-Change-Number: 1521
Gerrit-PatchSet: 11
Gerrit-Owner: its_Giaan <gianmarco=
@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@mandelb=
it=2Ecom>
Gerrit-Comment-Date: Mon, 08 Jun 2026 13:26:44 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--6F50lcgtBBo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>Patch set 11:<span st=
yle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4=
px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail">View Change</a></p><=
ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail">change 1521=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1521?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d=
1cad7062856abcc40c4e16ec93b45295bbd3 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianm=
arco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Jun 2026=
 13:26:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--6F50lcgtBBo=--


--===============2890901943785350542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2890901943785350542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2890901943785350542==--

