Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9809606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jlB1GBgP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=grI9cL+U;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Gr47KnCj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MhM3aHDB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LpOT+zRgkHviS8dLGiWPOf/rMR67Ki62FKvJ72Ed/v8=; b=jlB1GBgPVXwAt5iIqqH6IwZa2T
	XEbuQW3FBSpm2mIkKK4nSyrcA7W5xa8Xg1dj1fwFzWBMRex2TlW458wr4RwNGMN+ONHS+An1KsF2q
	HoKo73FrWrJCvMryp9D2wNbe7rVIxCURoXvgWtoU2IHM966qy3Ll68KsltflfOk93HWw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLf9J-00000000765-09oc;
	Tue, 27 Oct 2026 11:15:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLf9I-0000000075z-0Hrj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DlR/zAE216Sp7Jrf3WS/uRk19ruvyuRl6Wsd15UHTuc=; b=grI9cL+UmMT2Gq98XOUGYcSxLX
 Hh3OjFOL8vHdMPb05YedWbaFio7Q3Ttq5K5aKub/6xYRYgOqUEmbpnHFfVmzsSNJFmsXueHUXbcOc
 xUBSwLPNu64f5dYeGBvFoC0BzB6G+YrRsntlnTtjWIfcDBkjQYGC+7OWOCjvsmtKS/3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DlR/zAE216Sp7Jrf3WS/uRk19ruvyuRl6Wsd15UHTuc=; b=Gr47KnCjilqXIO4ctlUMyMirVV
 OQhvsNfRUKfvnScJahcyNDGyzJ4Ag/mKPOiiUOq4c+BKlKpl0WdyaEn3/c2G00BODeSFH8M1NFiBH
 zu6UVRZpJtRe2xSiqi2s8PZ6g0vljJeszOGjMf0ItFoN50PJ1ofERsnjXCwGl+aQbOpI=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLf9F-000000003b2-1o5q for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:15:23 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso2290427f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793099715; x=1793704515; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DlR/zAE216Sp7Jrf3WS/uRk19ruvyuRl6Wsd15UHTuc=;
 b=MhM3aHDB4AoEs8vCpPvYOUhUW8Eag7fJtLHqjQPTPVrham4DRStbO4dJRo3CohzJ49
 L/54wuxZHf0sF7FgkoKNcZvXFkJU8icgwvQ1r3DbIFzDqu4L1l2j/z+pngGqn1ubO9g8
 J6DMbM8mU55UcXXeEXTAnNi7HyGLdPySgf3y863QY/zR3QzkoOO3LAqwhv7FdGl6znyc
 bcwUNWdqtYiqcinmMKSAx8muuPA7krsQZ/GM+uncned5CQ+LdM3zTL7RqGBjfx/aSQ4j
 PWgx/Pef+xotchWaVWmSNhk9f6567Pmz0OUepa8BVQqP7GHyW2CYctfPuURvi6OzIcPJ
 rruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099715; x=1793704515;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DlR/zAE216Sp7Jrf3WS/uRk19ruvyuRl6Wsd15UHTuc=;
 b=UzS7esznlBgDQzjmZo5ixIira4Kbqkb2gvNtaJ4pRRREJM9+Yjz2bK57t3RXKdCa91
 T7ifGQx4NSs1TtjAEOysoxHjpKfuQLmqvTECq8Cwj7vHhtVip82rbkeJijGcpq9Eyy2I
 G/exNsxklgRQ4v1auuzpPhZ5JXQnxEa//p4YPtqjFQ+JbZ26zerHmmY6JMDXtv+j+a3h
 Wzr1f06+m+LN2vbApdzZTV/A6yK0J5wcPIDkbVdA8ekuuCGBdKoj2YTA2BnRD766Zha7
 tVhN+BKmEyNQrL7oqu5k6wtcL0NtS04qZ+isknucZj2BxvwcbWYOvMBDhZUwbds1uYpd
 qDBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxH5TgtmsVBtZT0Jjg/27xmdpcd5mI8QNnghVOs2veS5eyNcYvixp9LE7TB3ET3x/jm8jsqIYeT0sQ5Dpl9@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKg2UbDIy0Ur1vuO+/diLcQDpAWE2DM2HItWtoFWfbCS4Bcrp57
 qZST8PHzkmQMGGqAK8pPGdvvL0UsJHcdbZ74nBNpNNeXZkgAX6hrp7pfdFImWZSNdQ27vGkjzl+
 eryPLJjhksoU4dDyJMDw5rD0TKXZSJiU7BCF6cbz6Vc7KJy/TUgCkdQD7SkUsmwD35HOdTVZWTv
 8QfRRYpA==
X-Gm-Gg: AYBFou1UmpbXaf6cTKR4peDWEna2Hh36E6DCxhaGfN/PmPCJD4xKJ7kAnLKzJhY7YF5
 LI7U7Qg3lBR7IePjk+igGviF1IfeWZyNZFqMBems3c47yFAg9pU1CaUy1r7vINngJkGCYM4V6wH
 6W4oqgy1hQ+Kmw6aiXVOdqWWnjvNFDg4IQgRKAqi5HVkzqItAFZkcgE3K+bnFS5kvGQuPdKeyyL
 7GR60CkEhC7dJyYdDs8TiLXRpSX5fAOjwqCV4AOzP/gb5/gYY74VQ/DvEbl3U35C/s9O7z5Du+4
 Wbqh1WPxvk29XtRoQCxg3vCAcgBumxAkmjsjrZ5TD1rswPk5kQauA7kJOB4ITSnGnSSJKG4ERVu
 pzD66r9un8zzeHz5zBPlzIEY235Tm2J7OkLtjVyxSvGyxPWMNmUbfNrSvQN+BCfjhioSQcWSWGT
 jaJiTIvfpDLcpKdnDRz8brnuKsX3PthY5K4Ubc+A26ajjE809vhq3gHjB3Z4UC5zf1HJfpFkeNI
 B248MuBsbyG12AN85anm9m6JFnuqcoLv5HS/00XsgsT8/3C8vA9ErgbT+IQrBngPZMP+gMYE5Dj
 HtYGLVqHM2B5QrwqAmXC5HOvgDDN+rHkZcPkOs5anUzYg4p1L1EpfkWdl9u2DMg3AE5RiBrdUHa
 jFzJZXBE5hVPkLR+OTP2j7nBgsq4RPc+bgwyqnolMKw==
X-Received: by 2002:a05:6000:46d3:b0:48d:f9dd:e3de with SMTP id
 ffacd0b85a97d-48e3eba4619mr11664248f8f.45.1793099714567; 
 Tue, 27 Oct 2026 04:15:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm22788005f8f.47.2026.10.27.04.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:15:14 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 11:15:12 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67
X-Gerrit-Change-Number: 2038
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2038?usp=email>
X-Gerrit-Commit: a4627d79a6e6f81c96143f6dd38944e28de70c5e
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 11:15:12 +0000
In-Reply-To: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
References: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ1NjY4MDAwLklmYTQ0OTc5NjM5ODljMmQ2YmE2OGQ3NTk0MmQzNjhjMTEyYWM2ZjY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6fd6943ea0c1a9f710c88bf0229049b475030e5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLf9F-000000003b2-1o5q
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win32: pass the
 buffer size in bytes to get_openvpn_reg_value()
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3698627567050826031=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3698627567050826031==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2EkK4yRQIR8="; charset=UTF-8

--2EkK4yRQIR8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, Lev Stipako=
v=2E

Frank Lichtenheld has posted comments on this change by Heiko Hund=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3Demail )

Change su=
bject: win32: pass the buffer size in bytes to get_openvpn_reg_value()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2038?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa449=
7963989c2d6ba68d75942d368c112ac6f67
Gerrit-Change-Number: 2038
Gerrit-Patch=
Set: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Heiko H=
und <heiko@openvpn=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Tue, 27 Oct 2026 11:15:12 +0000
Gerrit-HasC=
omments: No
Gerrit-Has-Labels: Yes

--2EkK4yRQIR8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, Lev Stipakov=2E </p>
<p>Fra=
nk Lichtenheld has posted comments on this change by Heiko Hund=2E</p><p>Pa=
tch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3D=
email">change 2038</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2038?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2038 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev=
 Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 11:15:12 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2EkK4yRQIR8=--


--===============3698627567050826031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3698627567050826031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3698627567050826031==--

