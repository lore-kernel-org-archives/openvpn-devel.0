Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086E606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mfypy2No;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ebPzNlWf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S66DwJ8Y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AmAKuo+w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JLNg+Fm0P3MmX90xfQldOw19FIYXCrRGpgJ26zuzMzw=; b=Mfypy2NoqBXBLNiHIrXa6bLz36
	0fpQxTmQ2WBLYq4g0l6tOij7vE8eIK2RerNNGvyS3ZMVP/ShHsXF9o0j0bFp7VIvdjMvAfZ8F19Kn
	Uf7eLmD4/UTm84uFg83IFdbe6Gad09XtlSMSGjJrIptf2GCYrGLldTM7srRwpoz4GVKU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVrP8-000000000qh-2sJT;
	Tue, 24 Nov 2026 14:21:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVrP7-000000000qb-2YHC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gGLDY3ggldOqtqBRpHN/vcANEIa7pStnSox1Yh1scQg=; b=ebPzNlWf3Y6x7D8ptzjQK69wsl
 5SnOSLQWhxDFk/OYE0+aioG8lxjeYxXWthch13jnNLYfjFxvMHONMnUEwWnr5UBdiYpNziWW8+58u
 +jlElLa/Fpky/zFHrTPAsSLPxM1POn/Mh0Ll3zmMqSuJ2dtm/JuhLi6vUuSIswGVcp/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gGLDY3ggldOqtqBRpHN/vcANEIa7pStnSox1Yh1scQg=; b=S66DwJ8YSEiKMPfXuD8PVZgTco
 rbZReHQBmIdXBMpK2ZKhPKoF2K/ZghHtgnSnwr9muhVPIqgl7+uR+7LTX4m4eimrSwDKq6kkNndZt
 2KXUEFvbTdU85CrLQ/kCJ+KFGV0JXg2O/TDrWdEcHbaA8h6SvjcE1xLNh2WNk1rngX40=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVrP5-000000003bj-3NKY for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:21:53 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso45251085e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 06:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795530105; x=1796134905; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gGLDY3ggldOqtqBRpHN/vcANEIa7pStnSox1Yh1scQg=;
 b=AmAKuo+wTNaZa9di5duc8j+RdJ9beeSwW1BSAMVKEALA21gW6JqRAGnT4ItvFDgtG4
 B4AB7cmERILcclPftLNaBPed+cVZ8QhwJP3TlgWpElSL1BTNpzA8t+QUSBBW/hKO4AvR
 BVlZm/LI0fly8mYNCFcyO0J1uCYnWqAMZBI52nOq+wTwTWKfoi7rjXvn6cZBLMsFVwzC
 X9Xd0GGR+bBLfAIH24ZXN5dyzi11NJ7QQLQL6sQ8Qp3KHs3SuND/3N99adqljHYf6rwG
 lcv3+GwSsRxIuousU8UTi+B78wnLPiOiBTzwLqZlj3DnaalIpXy07TuoJDI3AW13sbWN
 rRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530105; x=1796134905;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gGLDY3ggldOqtqBRpHN/vcANEIa7pStnSox1Yh1scQg=;
 b=ZsLJHLPe9jIoybHa3DtuSSNGze1v3/JHkEfe+oOxZCg4Jr30sUQdTjqfY1hm0n4Bu7
 sa1bRkJYbKEhxlroLbmGuRXT1dyPqS6u5IhIED/dk8NlSExKBkEroaDoFUpgK9W5qt6E
 3RpF0vSF/qI3yvpq9fE715igh/uouI6jDqN+GfXpZ6a14y2+2FpGzsewiU8eZp8VlTC/
 k8a+7zReWIae8kG03SN8kKMK/UOT4EowGGXM159k7c/CVgqHrOSA4oVCbGVHpZq0Hi4q
 01w8dyMZQedX4U2rZyaUOABUlLxSdGnZULW/AzF913iZO7Xx31UPQKP6P0l8m3Eb0URP
 N6MQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGi4PVtdwYdBoiYdetA2fSvfxvVeIqgaYwKUknvJL8W6z908LEZwr0mnQYxNvmofBCP3nuIR6X/H4ERFU4P@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+INlQVmvWK8aWlU1qgWQyc6be0UNBDTzTzyNtQ8ZetIk0Tbrn9
 bbrgA93nOnFMR1cxDQhzn/7eksSaA7Z/HaiLoX3S1ojb7iXMLbFK3WdxrObuaKOvm0A+ACVOjmN
 XxqsBG78jtz2LEJc8oupdpc7waFGd/YxLDIWiumshKUaZgfnOuRCco6XKTvoIQGzcCYVh
X-Gm-Gg: AZFdTZf7y5qO4UlRNelIUV5wpNV0jDZBkBheP4/CH3IRVfKaCCyE9EW1siNlzyzlxH4
 FcZKwWeU0r7MYbjawN6C+GqnaQcCHpozhs0qZm63tvtOHNONow232zIAJNnwLVxb4QHwsiJZT5I
 bVVPXHVAY49ibJRGOXosAHyhFUGGbpcLU3dhmpUrR1njVsTnjMr/Xb0IBobrGJyCwhQUM80aZkm
 22sE8vzpqRXXg5TmjQfbun+Q992K/ej0hsnkwwuZyuEdzjuhKCHOSrVkWoLUDOSLLDWjbmcoQ4N
 JwRSMXHVeTBTYXaRaNE5Fz7mBEY7PeGCvvH3X1qbNL5mQKUC9m8f0fRMieTuSgjMddLLEIOHTWz
 rsVMzvh3GETP0n2ulK//95e/pCDHMwV5i+Fkt5ZI41Iari4fIbQrzRJ7AQ4zinjkdtAoGiZD2O+
 0yqwqSsVlzP3kr5oRCpwBHUl4yxpuVdQcfIuyYvOr/HoUI+JUvD8NLYwbM71N4IunovNkYtkHwi
 VfTHtce+a97wwKxHytKrVJh9ITA4CWHYFeCJ+l6Y+JZz74j7bnnpr/Zje10RYc10v+JpXrjgAvx
 BJ7ztkgd9Venbr9+XW0Tpd1C7Ggov7LXSS0MqWCKk3PPfIUzN2ldzhr5bSqI0tT+4jLTbey9nVz
 pdOqDND+2V7EltnlKhQ5Mtcvhh4rgNxy6alKo69N9C0/yZMzFaOqsztIS7zfftPv7yl/xFvKzuj
 ohr1q9nW/Qu50PCdvh3WtOzY4e+hS0x82Cz8Oj
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4bb888120famr308378115e9.16.1795530105052; 
 Tue, 24 Nov 2026 06:21:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm399015375e9.8.2026.11.24.06.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:21:44 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 14:21:43 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
X-Gerrit-Change-Number: 2337
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2337?usp=email>
X-Gerrit-Commit: 67bbc56f4580be77fd1e772d4c08fdd22d322172
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 14:21:43 +0000
In-Reply-To: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
References: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTI5Nzg2MDAwLkljYjkxM2Q2ZTg5MDYwN2M3OWE0NWEwZTYzZTlhMWJhNDQxNTFlOGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <813a6235ed793df06af1a8297665ad029e243859-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVrP5-000000003bj-3NKY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: list: drop
 redundant check in hash_iterator_next()
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
Content-Type: multipart/mixed; boundary="===============1095253500251988816=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1095253500251988816==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5BChhIK4OyY="; charset=UTF-8

--5BChhIK4OyY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Demail )

Cha=
nge subject: list: drop redundant check in hash_iterator_next()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icb913d6e890=
607c79a45a0e63e9a1ba44151e8e2
Gerrit-Change-Number: 2337
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
t-Comment-Date: Tue, 24 Nov 2026 14:21:43 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--5BChhIK4OyY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?=
usp=3Demail">change 2337</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2337?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2337 </div>
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
"display:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 14:21:43 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--5BChhIK4OyY=--


--===============1095253500251988816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1095253500251988816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1095253500251988816==--

