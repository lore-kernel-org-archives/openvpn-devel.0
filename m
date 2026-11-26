Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB9606A329
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DG3c8xV0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CjaVw8zd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GUzSuJ8G;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fwGxuopA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OqJk5Wk6DA1jg6mj7bA7Eb9qutsvFtV6Y+cIWDf4f+o=; b=DG3c8xV0SPkbfH9hO8GyhDo394
	kxjzjOvQoku1ByKPRhHPa/so0efEm8aJgt2tMTT+fUd+xYPEz/YnRbYKg5AcytcKkA/LGKK2aI2sd
	1zGcXwvQ61GdIx8TfKr98wlaf6O+Jcy0b4Ge5Hzcob3WdhnsQjZB6q8NBR7W0vpvZLR0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaIg-000000002Ih-08Ws;
	Thu, 26 Nov 2026 14:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWaIe-000000002Ib-2zq2
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=47bR8328/Vtyrz/A78edPvkQn0VJtjhooSsIbY3kOCQ=; b=CjaVw8zdvdsre8iBnQx2g3AVnO
 WeYSVp7hr1guX2Z0tRyxEK8ziiX4PY62+EpR7D75PVvfh742+0eeSx+vT7IpHPyet79A85M6eDYst
 NuJ/HHDF+cdG5q7zTRK+KR1lRaDNdRXnfS7vXzzJ+ICQ7/kO5aHdMgTCDLJYiHdDSFMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=47bR8328/Vtyrz/A78edPvkQn0VJtjhooSsIbY3kOCQ=; b=GUzSuJ8GsPyuF2gEIB7fDGAhZs
 AzP097WkRgNrK9aXhcefI08SI9QyNU+2mCCGUmd19hGDjGbZ/HlFv9aTDYadrrfKNJzYjPaCrfngZ
 D6PaLxaHOPMfWWotnxJYDYzYY3DmeM6zNSpBDfa/yglSBkmFlX1TcSJdDUbHsQCDDi8A=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWaIb-000000005BN-3zdC for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:18:12 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so4488977f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 06:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795702683; x=1796307483; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=47bR8328/Vtyrz/A78edPvkQn0VJtjhooSsIbY3kOCQ=;
 b=fwGxuopASgn5AJrm5jS9coQas1gkhKgm1sOJRHIPyQJdvgR2pQ5o7xVcnFobC/Cj7k
 OMVJb1e+fz7X3hJbXWIYV6NC9Swp1ae2fCiqLJp4l8IauygWkIuyfGNfJLHnNwB0YIrJ
 ccmd+mlW9WbZ+mV/8EHrUNghGxhMbkwNO2o7aSYETse4C752w6ScWNCemnN+CzyI+wOC
 gfdi8Rw7sJbv2n6cWDtu2okmayFXrrbFhIGcOwkY1Q+bSPUxAXEF2Rcs4ibmHkbOlJb0
 uGy4t3D9Xol0utceIJU5wBMh678xQkZWvUltaGH7foqHrY/og2A4wmlPYPUXfYaPMU+9
 9QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702683; x=1796307483;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=47bR8328/Vtyrz/A78edPvkQn0VJtjhooSsIbY3kOCQ=;
 b=YaGRNGoWtLOCWr/WYmvB/iVSu/BWoRocDj/cZUDAdQx7DVTddaASA08e5nLRgvvuFx
 gc5LABboTOYabI2Pmba7MRk361Tu0OdZegWeHowVsY4/u0LcNluWdI2aVRE+Wdal02Y3
 elzwffJzPB20Rt2RKz9ZGABYbcvpQyPyZx+xffzPf8DvDB0YKQffnlHwjxaPtZAwgDp2
 FG+6N+VvoATTwaI0W+HUULcmp39Yqvh9BucCde44XPm9g2Jslf2Ctc0/+aFx7DE0qcWQ
 P+Ih1MjfbjTe26zx1tw+n+kVQ3g7qyLNnDgqHQCW791t+RnVsskPlaSmab3PJGj7AtAK
 eTEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHdKREhcWih1y2jsVDJHbVvPr3t5FChuDryj/W3pD1ZQPxTxeRONH9NDsWEJw9vKYaajPXZT+ybX6nb7S99@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9S5ZE4cPYodzRaH1qV6N8p4KH1LeD3GFuFfMqp1Uq8Rvf5XNZd
 UpUH9eVNOHhwC/8OpbhotAq4p3ysYNDPBrWhofhk+glkaj6aQGV+al8sUQD6f2VxdBu0hDqoR80
 Ja0dC+iXFH7Meak7eGNyJ0v7vDG5GyiqrUm72KqHsBGFg7O2gkV5ZAIxJ4igE7JHaYTlX
X-Gm-Gg: AZFdTZczZExIuynAdbbLCmw81KqlZxQdPUsg+sznvvqoRjod3x/YqaBY8a0tJFV33Du
 UPuVOxx042tgXmtTxbjGTSP226OVLwbZSb2b/Pv35bC2bSgsp1QA8hMGQtG3reT6MEtVUC5JcWZ
 CRY5rLboRiOPFYK5LwhHmKV+HhrCMlv/GQKf15PBStkny9EML7l2n3Y5A4UXYuMDf5Eb07NIcuW
 HyEQIWMjdFySwhsayWWSkZgSunwvDZW0W3BOVMKRAlTHjrKtSuAhtmfYUsTIBNACGtTyT73+Zm3
 +ezSjfYbK7lxJBU4xCJlFC/BATTzhTsN5+q322PlYfzn4Ur3U2owGNGq4v0J1m8RaHqu4GLeUN4
 HyI3Gj5ggKX/z9e0/xwJISjfvk+HPkRWPtoLcyrVNWs/pyAb1tPPpOrBfANVK9JZzV5iLj9nl48
 yuDpLENaxjWO2ylIYJS/EY+lfr8FbkQu2mDF69hH7IKF8U7LGgQwtICbRoBckmJjc7hAWxMxmYE
 051jzEr4pI2eIn10lBJwRu7fl69HiCS1RcPDnDPBcEWdVS6gf4WrL7NoFXIf/Rz3AYxDUdmrbs1
 l59DIWng/g2rpUlDs0kRWWPRlG4XRPFVL6kXe9wnZ7nEWFotVf0l5LeC5+6lEf7U/tQLP6hQJeq
 20YoC/kbseBNkiQsHbbm6u84+LgZNrzGB5XJF02wbTzA4aopmlIfEhq17Hpe214JicYZO0Y8Plq
 CA2O8QtiMgYmCBS84=
X-Received: by 2002:a5d:6691:0:b0:4a6:c3f:9d0e with SMTP id
 ffacd0b85a97d-4abb3d2c0bemr30370515f8f.44.1795702683048; 
 Thu, 26 Nov 2026 06:18:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm40947291f8f.51.2026.11.26.06.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:18:02 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 14:18:01 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
X-Gerrit-Change-Number: 2355
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2355?usp=email>
X-Gerrit-Commit: 16ea2d6f7698f7600e5c918afef0d8ec37419077
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 14:18:01 +0000
In-Reply-To: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk5MjA2MDAwLkkxZjc3NTk0MGMxM2NmOTg5Y2Y4MDRiZjYzN2Q0YTYzYzNmZTVhYWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60be136ebeb5b1dd69b7caae217beb9ce5742897-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWaIb-000000005BN-3zdC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleaning up Windows
 error handling for signing conversion
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1993461857665452812=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1993461857665452812==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nA8c4v/yQxU="; charset=UTF-8

--nA8c4v/yQxU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Frank Lichtenheld=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail )

Change subject: Cleaning u=
p Windows error handling for signing conversion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Build-Request+1


-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1f775940c13cf989cf804bf637d=
4a63c3fe5aaaf
Gerrit-Change-Number: 2355
Gerrit-PatchSet: 1
Gerrit-Owner: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Th=
u, 26 Nov 2026 14:18:01 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--nA8c4v/yQxU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Frank Lichtenheld=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Build-Request +1</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">change 235=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
f775940c13cf989cf804bf637d4a63c3fe5aaaf </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2355 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Thu, 26 Nov 2026 14:18:01 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--nA8c4v/yQxU=--


--===============1993461857665452812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1993461857665452812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1993461857665452812==--

