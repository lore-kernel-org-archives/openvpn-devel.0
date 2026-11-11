Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC2606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F6ul7XbG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XTw1v1Oy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bbKCxKLw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A8JRh+2o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gi7ReSEYxVhPALn3EsloG+zcwhc1bH4BbB3bhrN2zko=; b=F6ul7XbGNfpoePp7SdQ0MC+Ve4
	DgeQzOhY+S8xsQqaboRvtv1dNqq2KQ5Ornuikx+djcVpQ3mVtv4UU/mUI5zOrB6DsSDGTjQNqyLT9
	9Y0jDjoLkmYEdc4LGo46smsfSrozDwv1GRzgbpsb3Ohj8IIxnGwM1bkEVD70aTSlQ1Ug=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4wH-000000002lb-21cs;
	Wed, 11 Nov 2026 09:48:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4wG-000000002lV-1ejw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:48:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CvqExIG1w60M298x6SihmxNF2BLyPHhrMU7glV74f0M=; b=XTw1v1Oy9KJ7cLto88svOOrdgD
 tVGZuLQhk4JXubVQXTtvJb25AUNBBsaWTJ9ITbfmsz6GrQXTFLj25x4+dPiRLBqrKUMaxe/CfUIee
 Y2ak8eMGu0bxTIzNRr376613LT7g5/w08MH8jeCs8evFyXg+S5ReH6EV60v3OZJfPOCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CvqExIG1w60M298x6SihmxNF2BLyPHhrMU7glV74f0M=; b=bbKCxKLw749eC/07HviR13ghSr
 Rxgs2yVcRARamwCWK7dak1hfvc3Lre4WXrmteKC/5f90MoCYf5R+Jq0BG9pFgxiC0fqufmDiWH43c
 VBl1ZWxVoyPjxRrGa4/h4Xh5y7E9xyX1re1Xfhh2pUujF1zRoHKRkEcB7HoBjCDAFMOA=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4wA-000000003VU-3bqb for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:48:19 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1593956f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794390488; x=1794995288; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CvqExIG1w60M298x6SihmxNF2BLyPHhrMU7glV74f0M=;
 b=A8JRh+2o2iTY9rV6FaGEyyKM9o8lYXD1dRnfs9l7KpzG+YZlhTWIL0SkV2qZt3CLf1
 R0YExOeAczccj94RIj7njV+KnDPsR9dwKhTk1Ghjvy3N5tnev4qhY2WNbl/axMJhT/rf
 pUV27XX+AmSIcuAWs1RYI7Mvq2eOK1SWGurbfC/zQHXonCufEsRgFNJAyoSaJJSnLN6s
 4K1E3+PSaUJKxd5h+BcsovZf/xYmQl3XpYRpvrYfzbNdP2j3e2GkSyB0k12PHplLkdAQ
 gQFalFdaws8Q5IShKvjQEDOFHPNHHfeI2Spq53RodSJUsqh7gDqe0i2SDAVsMdyMOWWK
 uVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794390488; x=1794995288;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CvqExIG1w60M298x6SihmxNF2BLyPHhrMU7glV74f0M=;
 b=B2Gksymuf6XrpiOZhOZocs9m12mf2icrtc9vJ52p/nT+iG2P0rpAbLEUYiTI+Mg7Ax
 o4yBaoKJfGc5mxEASw6yqVou2/Y87hbKAacfNUlIcqymRW0YoNizagRDH/dyKywl33MP
 8Lyql/+GsN2Fm7R4PZmPEQ3vIR9ndLq92Oj7rIZdONISL4CD4KP+e49DE3VauoKUFJqk
 s688z2Uw+yP8HtFWOCwBNIuS49kPg/0+uhsEg8Dxbqdy3TisMXf5pGrks6PHjTU2jWRI
 Y/GUERxmtPVs0rT1qWIkIZrnP9elDeuVv8wV12jTFHTFJRfrepIrMqNK82DJWazmH5wV
 xBtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFZb0Tz3TYtAbTidFpdSGVcy7Qnb2WRz40ajCimw+DB2N49ZGYW314lBzjLrS+3scMZHM1ie7r5oH5uX97k@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8owrY4iLjTJVAsuZbrwp7K5YfDDwo0eJKyzJNmw8VK+GGSKOSC
 miXFqRFspA8XqRl7859nljWq3cRzayBgD/6HPyFqg/INL/vRWd5Z5TrBwdGJ7Z2c3ADOiFOE6y5
 Vzg2QjEDry2qaeKmhjLVWU9M/pZfO1e/7zVhUzS1xK+f+yI01UYivk4W4U5eSU1Ujrkm4fE0Ff+
 l+M3/uUg==
X-Gm-Gg: AYBFou1HbplmcvVoyLPRv4l8V9m8WqhoiVdEr0f8CG+hYB50KAPwa9rFGdR6YSEyDo+
 GqFMTPHLZoUXnEFvjb3Uk2mp9TMsbjMjPjDkcvHGepRgwgMAccRQYqebOeG96toneNHHu2xe7CR
 zi5+oSVDdhjErvvASnZFf4L5ofqH1oE7TI9dDbrYq91wp94izp0WkthV8tHIvewikcQYMLBqDdI
 M7UFBPRVV8aHuQkzHKs1RG4kyZfVfjug6huvEcQ5t2dEZtRjz6JPWknqmua58DR5rZKb9QtetJX
 BVu/Hi871srWXIaiwQRAfrGmwJ7cBlu9xwnFY03X+Nz/p4A6YV3YMAbv+9+y6MfKm4OXP1/5Grz
 ObjlZwV3RXqu9i5PbCgqky010pY/JEJxmlgzgMDvBns3DRKwZt/bgmmw5JPGlvQ1JyYcMQsetr0
 AZ4Y6NSpBIDLZFd9q7d3HV4X0doE81UTMBie+Bd8M225QhsXWIDGticnL6mxppuAJJqU5nBbyV5
 y+O8o5Ftkj8i0k6sEoQWKpNjOUWZsjGTlRUpHlr7Fv2npr4OEg9tBUKknbOLzrW3lo2KBwEyLBp
 zN5cEwXRlMm0FOlL49a0NA6teDqq7n4evrY+scdpJOqA1GDDBoa7J1kRrnANodWmfZTBIIlyd5u
 IaW3hO4KblnCPO2PF6hfynrCdn6wD9I84fFKO8my+nEBDxvNv3CnYoU1pWC/43/Hg2KMgT19cUX
 a17THJSl441+UuOB8=
X-Received: by 2002:a05:6000:240c:b0:48e:7b12:ac9f with SMTP id
 ffacd0b85a97d-499c86a03b3mr2656409f8f.40.1794390488140; 
 Wed, 11 Nov 2026 01:48:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm11989833f8f.47.2026.11.11.01.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:48:07 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:48:05 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
X-Gerrit-Change-Number: 2160
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2160?usp=email>
X-Gerrit-Commit: 54055b0dbb5834babd8a6f116c3602beb02dd10a
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:48:05 +0000
In-Reply-To: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
References: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwOTk2MDAwLklkZjM3OGJiNWFmMGIyYjRlOGQ3NDZlMjUyMTU5Yjc1NmU5NmMzN2ZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58e21429f3d1a38ea8bc21b0ecb2ca0530f8a19d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4wA-000000003VU-3bqb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: always
 free the domains in UndoDnsSearchDomains()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6857840132878864124=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6857840132878864124==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y29mY8cygxo="; charset=UTF-8

--Y29mY8cygxo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail )

Cha=
nge subject: openvpnserv: always free the domains in UndoDnsSearchDomains()=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2160?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Idf378bb5af0b2b4e8d746e252159b756e96c37fb
Gerrit-Change-Number: 2160
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 09:48:05 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--Y29mY8cygxo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?=
usp=3Demail">change 2160</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2160?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2160 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:48:05 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Y29mY8cygxo=--


--===============6857840132878864124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6857840132878864124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6857840132878864124==--

