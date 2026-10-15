Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5529CC6B38
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDkatozrIop7wXJKJ4kZ/GihTs+g4gTcVv1Lq266o2k=; b=V7h9G1lDLElfRMB5DrAzifVgf9
	weWpj4xVUk80Fd9LRHwsFI+UinX6EitOWnHcikwRNlbdX8kCTQuMRRo35WbEW1k3qSQjGW2pDXfUD
	hJmYsdjS9cf8qOSNGUPLUN7Ek0tqdPckChlmdwZRPmNN8Iku9jT/SN/Jtp2WwgbyJ8BA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHQtB-0004MU-Ad;
	Thu, 15 Oct 2026 19:13:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHQt9-0004MM-LK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 19:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=h6At8ZV2/ChrGs8mQjAmIsiNU+rkxCYvbep+mTjWy/I=; b=TrMhDCzDh3CJlTz7OmfNaeyk/X
 p9D74N/2CeILCCvTCHztxQDE42BolINawEch+Yi1CdnsiD367KrXnFxf8etDNmTk6V7BsxQ68+SbA
 2zeQ/8VvvZZz6HEzC8x/ayGBbvDQ5ou3eQ03FaKFJZS39eWZUzY6FEphtHx/3Vkt2Vlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h6At8ZV2/ChrGs8mQjAmIsiNU+rkxCYvbep+mTjWy/I=; b=C
 a7oO6avBT6nlYP7WRU1NMVm7UBIpijqeXBHm+xsOevyWPOrAExBzoNQxRffeft9olgOPbaBEITPXU
 YjfcegKYo203lthbAKbYR/wcbQ3omJo5CAZ07qs4pDKnMQxxt0Q05WiIrgRiA1qSQPmXHmDMz9juK
 OyHqUzbD7AjewA+Y=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHQt7-0007JC-O1 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 19:13:15 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so21942175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792091587; x=1792696387; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h6At8ZV2/ChrGs8mQjAmIsiNU+rkxCYvbep+mTjWy/I=;
 b=dmBBrEyYToosxDR/rjwPOQppLzcCY7s5wyfEVrPEhOEEFoQGCGolH5E2EAOPzy+U4v
 LmV92vTVq5rNrbe2nBC79WiY9jlah/P85OV20z79MU9TsByZTgKgCpUBYfOSt1XXSbCP
 JJ4bObjmfwT+R2FSaTI7Mp3jGlNUSUGRDym8RE6Wfoq7MlJ19WCqrPbotpxqJjJ9GUt9
 Ovy8cj0nIB/LFAhizv9Qo4NLHJ3DL3VCBqvjewBy8VP0fwSaSPf9EJEd2RYSxNG8W2Sa
 Fvj3kDClJ3V3ClKmn9agIel2grvvCsuIdQGo+BdV5jQevGwXO2M1f9ax26j2CHFm1X24
 LDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792091587; x=1792696387;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h6At8ZV2/ChrGs8mQjAmIsiNU+rkxCYvbep+mTjWy/I=;
 b=w8rkfXgg+EXJLueSfM6wJMfluHlUM0L0KhFNeMS+jwSfAp9wxRuWvMPFEfb7K1OKNm
 LA+GFG6zUiTuomkmkOj8Lwya/85WFMY5mpdB7Z31mpccdphyGn5hRXRk6NOkdEeG0lr3
 n65UncyjJZwY1FKwn5jr31gFcukoDIRGklJ0TehRWh7K6nOBnG4YQ5vLJUtMcnDo+vE/
 EXOoNSYxGwi8vkSTpMx886Sq8D134616KsDdPq34WTO1boDN3SZX2RKW0hecYOl6beJh
 ZeuxVZURidUVAnmGQ9X3xy2nLgxjk4A2/dVHULTuM3ZfvF/f3KWt2q6NiwrbU4Vi6usb
 s0Jg==
X-Gm-Message-State: AFq9FYLcYogQ0V2hkX7KuvOYuD0qZzIg+2QykA9WCVzaJbGve0dwmein
 SNhdBOw+U5xIsAsejaGU0NnjR1pP8TSGFeLb716EOFaM3at618XBWCC0YzERnxCqW2jRkinxtEp
 yQpQAk2r5YmQpru1bjF6rOGvIeTv1FQhrtLF9P8aQiuyNlzpZd1ej1jvdXdKDQMZQAx9M/hQaps
 9hPDYkJA==
X-Gm-Gg: AYBFou2ufqzE/9cXMOuXivmuEVMNIv78zd/xWRw9ft3rMw7xoIffKh4+cxHX2JInsAI
 2K2F+1l5NfSHQu2qx3A1pFc9BRCvuoTKzyKtp1BK5rDTfRcbtDJF4XO9iWgHwl/vDRwrdWgzT3r
 tRZFxvhvn933ctJf9xZspl6iZHMAgUjVqip1E4HU9aZDRC+y8jTo9e/Xj59TEGgIZCvo0fKa0Sq
 4JNDQ2FKtJrDV8iRNRn9IILXvmjH6IIab6sblgiGuJ0a1l7v60ccg7Z2FLWpyF238qWe+/22X+4
 IME9hfWZGzpXPsU5sbLK4rmm1S+4qKCCpTaDqlcDZJinnkJ1IUnjmSuNQEAZGjO41PUBYXzQZ6q
 XjL5DzhnPRHgIY4gn94BwlJgjePSs1qojybZ/bITQBBUKZszQ6k/qS9sPDHYree+lSVD9RvHAiF
 rTDhHQRZdruM1N/lm8yMmEKXAj23sTi85w1Kln28O8einayibtFkkE9+zU9jYYmwqjQNtMXXsZe
 9SrvkJD1sstuXuYPPVTOuYtp4dYBfZa/X4At2Mh54aHZ22JCwEopDNPIaaJhlYSgniDs7tcqgL6
 BFoDFpIczcHuXXPsDbOkssaLkRc35hMhRez0UQTCxBPMjo/F/qRczva5TR42
X-Received: by 2002:a05:600c:e557:10b0:4a1:8efb:c9ae with SMTP id
 5b1f17b1804b1-4a18efbcae9mr258944305e9.23.1792091586938; 
 Thu, 15 Oct 2026 12:13:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd67502asm68065025e9.3.2026.10.15.12.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:13:06 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 19:13:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c
X-Gerrit-Change-Number: 2000
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2000?usp=email>
X-Gerrit-Commit: cc22f6e3b9b3bf812184f359bd2890ed2a31097d
X-Gerrit-Comment-Date: Thu, 15 Oct 2026 19:13:04 +0000
In-Reply-To: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
References: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDc5MDEzMDAwLkk5YTM1OTgzODJlY2Y5MjhhYTgxZjAyN2I1NTM1MjE3NWFkOTMxNjVjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1537a36237f051fc3c1145abe8f1546ffaa48e61-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHQt7-0007JC-O1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: repair const
 mismatch in siphash_openssl_available() prototype
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6831224930495108211=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6831224930495108211==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EBfy35sWsAI="; charset=UTF-8

--EBfy35sWsAI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering=2E

Arne Schwabe has pos=
ted comments on this change by Gert Doering=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2000?usp=3Demail )

Change subject: repair const mismatc=
h in siphash_openssl_available() prototype
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I9a3598382ecf928aa81f027b55352175=
ad93165c
Gerrit-Change-Number: 2000
Gerrit-PatchSet: 1
Gerrit-Owner: Gert D=
oering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Co=
mment-Date: Thu, 15 Oct 2026 19:13:04 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--EBfy35sWsAI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering=2E </p>
<p>Arne Schwabe has posted comme=
nts on this change by Gert Doering=2E</p><p>Patch set 1:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail">change 2000</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a3598382ec=
f928aa81f027b55352175ad93165c </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2000 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Thu, 15 Oct 2026 19:13:04 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--EBfy35sWsAI=--


--===============6831224930495108211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6831224930495108211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6831224930495108211==--

