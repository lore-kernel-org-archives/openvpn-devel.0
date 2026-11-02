Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B4606B1F6
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dqYKQiPT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YdIX9Nla;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lVr9pLL6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QL5ANshi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=irpQB0eUC+aJxHexolWk4KYHCX0xN7+5zxuA0y4nA18=; b=dqYKQiPTXj51vYf3+qlGS5J/gi
	UqN9POU7ioXv87Vl7KcdWEgc5QrWB4ZNIOwPrXiIUAW71NYI3lbRjIe2FWgURj8XRPXW2tLqXRBnV
	7ey9oM8koy1UZ0HbCmqm4VHxoUa50JL4gjneilcdjuNXBqqxFeIRPlyyV+lzXu+n6iEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvCv-0000000033Z-1hf9;
	Mon, 02 Nov 2026 16:48:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNvCu-0000000033S-36ZK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZKihQlRz8Igc4bo8AcuR7q+6b/TbANt5Xn3+8YAbyU=; b=YdIX9Nla7sjf3IuG4JtyYmMrjN
 +Wr6EKnx6XEgjkI2e6tjHBv0r9Fxez6Tqpd5D57FUWiPLEDzXgCm0smEOJ3j9/DMuforG4VjO4LLM
 hVPTqf7hHEECZ4fUj+lqo+urQia/xjm/Vu0+doL945iu7w7Txrmp14I8oOcf5fn9T0b0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZKihQlRz8Igc4bo8AcuR7q+6b/TbANt5Xn3+8YAbyU=; b=lVr9pLL68qN5fL3Et6QegmSJGM
 Q3byMFCtkGAZ7uW0/4NWIZMgHpfta/xTl1up2lCOyjwMXl8avj3hr8mueDHN/+b1qj84XeYhGtvlv
 rW3FAU5raddapKx2aUw+7Emju8zkgzmaR9SzrCEXDciCDlQZLgS7nLlJSaNYAQwfge8A=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNvCu-000000005di-0cIQ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:48:28 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so42543175e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 08:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793638101; x=1794242901; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IZKihQlRz8Igc4bo8AcuR7q+6b/TbANt5Xn3+8YAbyU=;
 b=QL5ANshii1K2ND9WfymsZZs10Wpcir6zhDaqvxRERGLTe01cMzrI4hlewuPFXXb/lT
 8xDMqgCtWGoNfdaEPbZUf4Ac8GCLl0ts42b6q4lYosF8HFD/7GpdXLjFX4iLjAFE00W3
 nYeQT6//XGeDmcLsrRNKqBG6boi3M0C5M8DN+cbCpPEdsKS7fSM3KWU6T1/0BiKMhyIz
 QUz5EhWeXE/aBVg7HXQ8S/XuoF2l6pIqm3i7RpmYUUOUA5R8P2yAdarwzC2PaTvqxbg1
 lDkCkLBS+ofmjgK+/YCf0Z/TbGNmiCNZlZ4b90bpql+Bfh4lvZyZ4x802yOnsloofmCc
 23IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793638101; x=1794242901;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IZKihQlRz8Igc4bo8AcuR7q+6b/TbANt5Xn3+8YAbyU=;
 b=dPlvfVbZDB64VmsIF8Wwjec6723728TDKpPkOfm3onMmnPt64GGsZNvaiaOe5nXJ7o
 spJySPYg/8Ffk/BaGMUXq3FUy7Y6OR6FUn84om//9cmQbsvNcCy0E1jqTdTjDEwPR9rU
 mADotjTR8NN1cNowByYV4u4poM5J+rsE/K06433ypVm3600xEUWhr/P3U7OElrWuNqkP
 4smSSRZ3Zrw90r1qR4ZDE+dziGtu6LVUzxW8jYgjwP1v28qrgi6R6RUAHW/65frw53Zf
 CI0zQkVFz18nWRn3o2TK7FsDfwCbt2LOSPqMWjvhZF8pWqUDFNoxw+kjH7S5h0gCftIz
 HRhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7gAFgHhRDRGs4XYr6qMark7BlAjsYKyOz7S6P2FauZtZEYCzqX56rVEebVd5qAbarcgT8fN22L1+dRSk+@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLuRvV1htCjSFth8RCCqEncFrD//pmwcEiAI1udf8ifJU0SyGpS
 suQG9BPAcuJOs52UXjQIEPJV9KiK/T0KDcjdn7/L/SzWqKRDMAeq3Ssv58xGj2Y7zx/ARrUpmX0
 FEnS75y24+fDomHrsx01tUNixUWZI/bTl6cPmaCI2/ch5VDCxF4Q0PjB2rVnew2JCUK14
X-Gm-Gg: AYBFou0GqAJAcklXb0WAQEG3QsXCfew3f67B7XCA/ZJUG3JN8jnvQVtgVrOWoPwbTig
 Fi0Bbv2fozQQfaB2hlet+alqJxgAPVRU7xVbWTdaZCan+czVrTOuFtsQnxguEomRuSGRcRfBHis
 2SvwGd3Rcm3MYcYHfr6aJSA2Wny3SFj3cEyVFSkQi5xICQOsyOS3IS5qKBB9fjbJmpMPSlEty53
 tPsQNCZxh/kuj4hbB3SLu45TqUXZjpSFU1+ldzX/B+ujWxKm0YyzWwhT7LdcHhEbSvT6RRXxg7F
 cxJpzvf518Bm/lWxYJozwheC0Vjvg9DNbrss0JS475ZtdIkMvxj1cpPQ8Oj+LTem0KzzpF7tuo+
 +VKl7uxxDKQmf6OHL9DdG5LQUPpjYIJhFjhBOq2m3Zhfj1rpcbaNS5g2oIArVrdhaOyr2W4sXjA
 p+/lCjKGLrafcoa/HMkDgJIOx1A61rJGKzp5C51eGpgXZVZ1N0QDRfXNWS1JOut4/57qrvWh59n
 e1MQHFaht16evb4IyUC2w9NXimECgd1z0d0uNWiY+J9nwbjKVV5XiFND+P9kX34Yy/NGyBVA3ZJ
 MQ5JjMDpMeRasmLEtQqyDM9klTlCLdAyf6u/QA9QMo41Cmt79imEtEQEfsFv7E8XPDEEXWjHtvc
 /LWeDPq3vxulvtDiY4x86y/uhjXGzZid7pXyFuUoNENsTxQb7QJozgIIzEsw3wZ7ofP4y/ZnsVQ
 JDm+iAsM3Y+r8gHA==
X-Received: by 2002:a7b:c051:0:b0:4a1:d766:758 with SMTP id
 5b1f17b1804b1-4aa8b0609cfmr265401075e9.16.1793638101505; 
 Mon, 02 Nov 2026 08:48:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a7d1sm20925602f8f.38.2026.11.02.08.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:48:21 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 16:48:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b
X-Gerrit-Change-Number: 2094
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2094?usp=email>
X-Gerrit-Commit: 222ab299b8a40568240846d8d15e16d5cde45d62
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 16:48:20 +0000
In-Reply-To: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
References: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM3MzIxMDAwLklmYzEyZGFmZTk2MjFjYTAwZGMwMDIyYWQ0MjZhZmViY2YzOGZiYzNiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a2bdd911543113b6a25bd2ea6892aa8922680a80-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNvCu-000000005di-0cIQ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: use man
 argument in management_query_cert()
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
Content-Type: multipart/mixed; boundary="===============3468451506465046632=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3468451506465046632==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ImsUuVtSNA="; charset=UTF-8

--1ImsUuVtSNA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Demail )

Cha=
nge subject: manage: use man argument in management_query_cert()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc12dafe962=
1ca00dc0022ad426afebcf38fbc3b
Gerrit-Change-Number: 2094
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Mon, 02 Nov 2026 16:48:20 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--1ImsUuVtSNA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?=
usp=3Demail">change 2094</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2094?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2094 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 16:48:20 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--1ImsUuVtSNA=--


--===============3468451506465046632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3468451506465046632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3468451506465046632==--

