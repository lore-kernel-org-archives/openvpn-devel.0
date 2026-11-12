Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE2606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b17IqOCT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MZcX4ZpR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UI/0zV+P;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IM7DvTR4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zuc1M1nDQ/HKqiNQL35dLasD2sj3twp3YxJ0LC1hNvE=; b=b17IqOCT8NUKJuF842GCHiBBEj
	D1/oESrABOd3SUXZMbEyXVflePZrFc7U4fR5dY0Vtl/OjEVY1D77V4Jd+SVg5a29HZzlSAPs84Uau
	DLi1EeSbutaGAos+pqDYlas13BIwf/E2CvDvrHi86EIACmE0dumQwnPIbVeMgh1imP5U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRb29-0000000064L-3EaJ;
	Thu, 12 Nov 2026 20:04:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRb26-0000000063v-3ccL
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 20:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VBuvZalCpyJ6picbnOhDt8DBoXUcMxfa9L+aWNdQo7o=; b=MZcX4ZpRqH9En0nxAle9E0l7IE
 DdlKs89iv54E11EWskia1Inmpv4CR6zZ7yO/IoKmvzq6J/fGsFT51F2zM8M57msR+AR8bqsw8Uf2l
 6qeCTXhRpuJpuSRWCh6teJrs1dTI0Hh39bNf7kpkFy4M8IXzLXCzD60xYA3+oSkwJe0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VBuvZalCpyJ6picbnOhDt8DBoXUcMxfa9L+aWNdQo7o=; b=UI/0zV+P9ZNUiiqQmXl9PRm7eW
 3JF3F74cyAFvEnCq/Hz7hmhonuvQGZBLujkb7c82d7o4YxLVO+hVG1ifzLQEteflX86/9l4jDPj0q
 SJFVDiu7K54tHuXq09OjptAqG3ZKp1Y/3tPQoAvg70zX2yNg0Mhkc12Lf/BC2rX9cV3I=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRb23-000000003IR-19P8 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 20:04:28 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so2049445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 12:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794513861; x=1795118661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VBuvZalCpyJ6picbnOhDt8DBoXUcMxfa9L+aWNdQo7o=;
 b=IM7DvTR4+NcedYcNA0UuPrUw/UV1LBPEyLrESeX9qGsCZSBPStcTOyGRyQLMOaX/cY
 mJdPLmkIqZbjQsyoOlHMVncdfD5n4PtsW7AExZfZekSTI6yNddSfwJE04nyesMVbJrrP
 8grEfZhydjXMSVhSAUojf00yzOBqSXJtoRlpkjONzig36LKcwX7+uGIj/DrBRDXWzVDc
 rnz1SbASlrzmCONHuCWB3E+nRApQGbNE0/mPEiIIFsvIgb27SEiz56l0MXbxRFTbHEpC
 4G+TgvXsZHmhFnHMF0UM+UbDpS9z7IFhU7Tpy9izYTyXA/se66DgBEXCbtn4OLImO4ph
 neGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794513861; x=1795118661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VBuvZalCpyJ6picbnOhDt8DBoXUcMxfa9L+aWNdQo7o=;
 b=c8JefGW9XtJVDLKsABBI6Un9Qx+FIq2pjQukhUkQ4/GjEw6b+STzuXV8/4l+3XueOm
 FPYcfO9PEgg7qUAqe/vN3VXMXsB9KYz+8CjrAHQVXGF9OIwU6Gj6IyzbFeGTNPkCMiyt
 IfJ6rIoWWBuDKpaRxGxDQlSeLEnC9pP2FlJONs/WEM3jw5m8APWP6lHrBGPoOEZaLX15
 eXzz3joG3nxKzQ4IzLcBHuxFZgvpO8/S+vbh13ca8oCVKFfQzN1jd6wAO+3CY0HxaxgG
 BaywBC5aKrsyKTpKHRNWC4oxxo3RhhwqYGZKBj0SsDgd6j/g5O2R/uH0FtVkZI7AfGxs
 aedg==
X-Forwarded-Encrypted: i=1;
 AL+hErEJSJn29hBcsufTBdyDViqUaqHz8UE/9tZFVIe3sJMFZmScTeJS25S2CtIQM/KcF0m44hduKDR1to5cUMXL@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9kIVpWhXW6RtxAwgJT/8r5cy5Yn3SbXKNVL9USTZIyXJkiFmOO
 Dv9e9dQ0XNWkvYaJDsoq7XYw4LUfQmvJJXcxAkaNqgad2pbqVRNk3mTwpslpxL3JHM042AoDE+z
 sICTqVlqo+g8/F7JNFdjjE6TX17W6aDUp8ZdblvWJR2f4nn5beCATZAX6KRtU2URZFOxy5yo1vc
 mY1D7xlg==
X-Gm-Gg: AYBFou2GQrEqR514MJfdqY6b01pmaVTt7au5Cug+CUC1epbWNYFTCijHnabZqspEM0D
 S37yNzCvirOOVJNULRMske4BOH9U/FwX2DIdXo1Xu11jfTy+sQyd8a8uulVCzDcYnl+lTsR9AtE
 myPe5Kf4qsGW6yhyszcC/KvEqN4ew67TjX0hoYeb2/5wcxLXkmzazrCk+ZK+UeUVDR/f0H/VFGM
 3yo0Cc/qsRu7QCUNhEVuQKYUGCbdqihSRwBZ/oPi7AtQWDTwyj1qjbBs5VkUpYoztXcwyW7fc5X
 zHNC7EcWIGhd9c9FYj/+fKWncQuP7/FH6VRQfrH0pA5jo8VFsgkfsA3J0oz0r3Lh8wjlNaxRd+8
 soAZFYYivSO8iDyNLQwJOfLnLJ5UGx+kLCv8EarngMiMeVLdZaTk0CnwpTvSTpwo7LZO1n3hlgg
 JXQAbQEXttFC3+QCrvetX9G59g/ernFzYA1CPpycJ//oYs6q8CmI23SBbsrHeMzNn90uo/ihyDl
 Num4K8MdmcJ/gBJbdwPP38pHGc/6mZoxWwRpnBZInWjiSEsQ4Eto+ZwDxHWgNXrBJEo8KZRGLJH
 /Yb7EyjH5PBjA6fBncPRmySvyh2ge1nix5Q657WW4VuqRgdIHGXvjvGaAQsxgmSMFg/SuYt9FOj
 lVw2g1KUETf95oZB5bviFGdNYHQuk4ZVbHwlPg/pDLSfMs00UXpXdQw6TH8lXJzsawzYWsfB+BN
 JiFPhtnC/3Dfn7G0M=
X-Received: by 2002:a05:600c:b86:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb55a61183mr6919635e9.6.1794513859479; 
 Thu, 12 Nov 2026 12:04:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac1159sm5152595e9.4.2026.11.12.12.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:04:18 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 20:04:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: e4663828f40e1184bff8ec0801bc7f1b2ae3cf28
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 20:04:17 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e03264980efcc25bc16dd1a91c5132b9978c058c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRb23-000000003IR-19P8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8546893511328415895=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8546893511328415895==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XCwJL0DKv9Y="; charset=UTF-8

--XCwJL0DKv9Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Heik=
o Hund=2E

R=C4=83zvan Cojocaru has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail )

Change subject: openvpnserv: reject a config file passed withou=
t --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 7:

(1 comment)

Patchset:

PS7: 
Had to push a new version becau=
se the Doxygen checker complained about <handle> not being a tag Doxygen re=
cognizes=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2159?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5746=
9ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-Patc=
hSet: 7
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-R=
eviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 12 N=
ov 2026 20:04:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--XCwJL0DKv9Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Heiko Hund=2E </p>
<=
p>R=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?=
usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2159?tab=3Dcomments&amp;usp=3Demail">Patch Set #7:</=
a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Had to push a new version because the Doxygen checker complained ab=
out &lt;handle&gt; not being a tag Doxygen recognizes=2E</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2159?usp=3Demail">change 2159</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Thu, 12 Nov 2026 20:04:17 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: No </div>

</body></html>
--XCwJL0DKv9Y=--


--===============8546893511328415895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8546893511328415895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8546893511328415895==--

