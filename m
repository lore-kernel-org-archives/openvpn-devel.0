Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B3EC61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYNKPkSv2fCI7yQj+L6Tn+IDlOvvpHv7wBOyIu91wl0=; b=OL0JOASchQ1uvBh8bXyJdkr1bq
	1ulRFtiPRbXRm5QKR8qxVPE0kS3Cr/KHRWIKEJyqgo9amKucXH8cSJpHkbmF1ZrhUqK1dcd55gDBP
	VrG4mEx3JGHe4GeGMlMBtBVJ7rUTO/CryXkNEHBlJQ1mywcf4xYlJZLh3Rqq+IYr31t0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0iIV-0003ry-T1;
	Sun, 30 Aug 2026 16:22:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0iIF-0003rh-IJ
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=c7HZwiIYVVN3dzlAETglExLxRrVylTbfeHDgmG14Br8=; b=mk+6kQj1xVb3zrUy3wWkCDq9xe
 D9wuxK5CTg8K9lhLO/S6O+rRhcs2j7dUI8X9WD/S/NkSs2+RfkRQFOi5/34mQp+otnTWULZPAWPS/
 A80tQ3JNDraBIMW6BYl5d/5IxAdy32+xlCEAlp5ltkWa2C59U3QKCmLhkcro+7uR2YhE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c7HZwiIYVVN3dzlAETglExLxRrVylTbfeHDgmG14Br8=; b=g
 J1KXat34qJ4/2xJnnZfPsYzTjJk+QYyVzLFe83Rtdqq3aPvfHf2d2/6qFJhObMthh7AxaYOokTm9K
 C0sqQUe4DnQr1v4M6Z5KdBsDz5A/mvWsCPIVt0WEiIMk96Sunxf+ZxwWPnvxdyn69kAoqEskwWG+R
 8L8JElnH1XCIfkM4=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0iID-0002tz-JH for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:22:03 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4843c41f35bso60880f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788106915; x=1788711715; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c7HZwiIYVVN3dzlAETglExLxRrVylTbfeHDgmG14Br8=;
 b=TbhIl3l1lMz4XduE638B2EnEnOmI285ouIirZR6wv7mgyfpJMFwirWrkxCtqmKmMtu
 Uw/FoVxXnHOGiHdJjWSLVb1kQRg4SxDSHO71YHiuTcDozSj/pUbqv29v3N3pUDFv9ym9
 HEnY8rYJWIK3OO6ObAm73gJlsl5OR6xrXdZkH6PPLFDSrmjdw6vkyentVXvNLfE1HNp/
 u4OCzGTAbCoCDVX2DDMWnYgLtKLTptDLhofUz9UeWTUDpKwdKegYftqCcZtlL138yJfH
 6d7IFnkP4s6BH/dVvxsC7nQyVOlnru87IZnRjB0ni8xh+jyNWloeXZ4wmP2DcASGDD2K
 UOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788106915; x=1788711715;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c7HZwiIYVVN3dzlAETglExLxRrVylTbfeHDgmG14Br8=;
 b=XGx6mxssdtyy/WFLaO0nGTL8xgYsNWwncx+bZevjbdUtsKno2CrGnrjq+NGRarnww0
 hFgQm8tn5Q+7ACsSgXlnyEQhwg3lS5V6Dy7E1buxJm3VHuXsOlizp60LDqQC4XsVcjQ8
 XgsiKvM3s2v+b//IshKmcWKycE/2J9PwqbudbaX3UFoxFLGBBCrhpLFV+W8j5GtQgE8D
 5lneIpkHszhrZE/Xxt9WWwqCAJeGragrCwTCJjQu4JOLzAYhCve0KoL86QNohoogaiN8
 rfzNJ+bOkHjCRamzq7Dtlmg6EnpPYlesBvj9s6fMp/zui1qTxNWq6RKE/sDRVarPayOu
 FVHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8CS361qpLqalldK/4vFXXFdtDHBkKSUY9hAhOsOJkRD21MYdP9dAKxrh0/up8XRu2EFOOsw0YOdU+OrSu@lists.sourceforge.net
X-Gm-Message-State: AFuF++nFIHN9G35GyFnCPwMgjB7VcrpnuH+YCdGaokqAe61vlCxeUgpM
 4sDlclFvlvRBmZUnPfYWxIzGtA08aLI8L1kHe0ZTHKZhIMH0d0/e3AeahkiL4PirdTt6fdR0Q5b
 MCE3PEc4841bpBtnclCwgoklx0XG+X5qhjcCzm3lJIFxCrYCH5gRPdQoSKPIIUZhuMb3J
X-Gm-Gg: AYBFou2EzC8hvFExCh5r1lE5P+OlaueuTg5e45MnZm85h6mGrUn7KC4tfR42oismGps
 J79msjMFaFM5MSNa5ttKXyKb7Pzy9qhNUkAIuzh1zIF2G3lPjBMTl28MIUIQ6gQk5acyVZrQTU0
 vumEhbmse59OWGIRHMhm0JLMoMVb1uFVxOgXxw9E3XVQTfwucKnmX2dADpXNb6PwL00EdLxo5np
 GrXj8PR5MXH/w4rSY7YMez1BsbDFSF/DgNiVNvooVNEbHI/WyuLrlufCDUunPJz89sHbOX6zHL9
 A9V5/uRiKqxsXwkni6mvgFnB+vh3mS4FCwHTZEmpmLtTwhTPFt3jKuHuuxMBQWAj64kp7IuZm+m
 psU/9Yg11S5IEbEJF63srHHqmUsnIoCvok6KoKgMFqrQFpNGXXknbGbne2X9CPs0O1YmcwoCyeg
 7oStsbr6dJi31ERTEICxkdNx22RYbGGiVpdabMixJtCILb3ma+qSBAd8lFfE5HtNc1qoIo2scH0
 CoeWKsT9FWVoolZ+Oy9gUd+O0Jrhji5ZczfgMw6OGph+1+SsV8Qtiitk98xmGaWI6pP874/kDsY
 6T1NLrYJ8XBMjTBRA9oLINbHi/Tj64/p4jHkaApKsR4p4X6qqcU=
X-Received: by 2002:a05:6000:2013:b0:484:361a:1c7b with SMTP id
 ffacd0b85a97d-484397a616bmr5172732f8f.7.1788106914858; 
 Sun, 30 Aug 2026 09:21:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484397f33fesm3435439f8f.15.2026.08.30.09.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:21:54 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 16:21:53 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: 7b3fc92556d90c37f743d98ba1b7744caacaaae2
X-Gerrit-Comment-Date: Sun, 30 Aug 2026 16:21:53 +0000
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <309d610827389018286a1c5734a0603c0f6f7e6f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0iID-0002tz-JH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Check whether addresses are in "tentative" state
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1353927146196643295=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1353927146196643295==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wApMmbR297g="; charset=UTF-8

--wApMmbR297g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1882?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Check whether addresses are in "tentative" state
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File t=
ests/t_client=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882/co=
mment/98f5c54e_87c3b0c0?usp=3Demail :
PS1, Line 277:     done
Probably unli=
kely to happen, but since this is unbounded it could theoretically hang=2E
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07b373851175d865ab=
db1513f90655b3fa31d5fa
Gerrit-Change-Number: 1882
Gerrit-PatchSet: 1
Gerrit=
-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 30 Aug 2026 16:21:53=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--wApMmbR297g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1882/comment/98f5c54e_87c3b0c0?usp=3Demail">Patch Set #1, Line 277:=
</a> <code style=3D"font-family:monospace,monospace">    done</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Pr=
obably unlikely to happen, but since this is unbounded it could theoretical=
ly hang=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail">change 1882</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I07b373851175d865abdb=
1513f90655b3fa31d5fa </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1882 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Sun, 30 Aug 2026 16:21:53 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--wApMmbR297g=--


--===============1353927146196643295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1353927146196643295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1353927146196643295==--

