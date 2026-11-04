Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037D606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e9hoqYc2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gtSiEkRb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cUTo8AaS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QRQtAfAV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bgsJ0QiBX06mmap24K09MZMUOPA+xlbm5z02sto+06k=; b=e9hoqYc2WocepCPFSmFR+a3mLd
	/ci5uwwOqWnpD3lhSTCDnv8tnmL7pi6gPwdza7eNstKutk6XM5FenH9eTkzprEBTT3XxBdWSjPIHU
	sCgV4tQRV15OT5R5Fo+TlGJ04B+fr/k1H+BXBEkkjzP2+nTXHsqlIzHK6bzPUBI/vic4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaj9-000000000qN-0fGS;
	Wed, 04 Nov 2026 13:08:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaj0-000000000qB-2SKF
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 13:08:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WvlbPzlPzuVuN1Jk0J+oIns2bE7YJNpybAAVG9k4MXI=; b=gtSiEkRbfTRC09dsGD2PICaTOi
 qQUmTTCtXIwEOZ6T/vUfdve6O9rG/hjNznlXQRXqExSBe4KT3AQBsA8hZhZk8jlzhO8l8FjwvEPUa
 nd2ghb1aCsxQCkKiz+GUnxjBruE5onoye31rGr+uhkogSAvANX3SnvZLydmV4qGXlsNU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WvlbPzlPzuVuN1Jk0J+oIns2bE7YJNpybAAVG9k4MXI=; b=cUTo8AaSX2YpXtqOLTsVEiT339
 RtDyugEtw6fj1fTe1XCU2D/oJ8rYFa1NdM3AzBmJmRTQ/vWmuSlf2eOhMPI+/XfvUs8vdYCGt7Doq
 Lv94y2j146s1iLlSW7iu7tQBSwtDiKfd0iqQGwFFsENZ3CQU4vh59Gb9uWXZV7fLZXtw=;
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaiw-000000003QF-2OIB for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 13:08:22 +0000
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c4d1b35dc42so32235766b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793797692; x=1794402492; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WvlbPzlPzuVuN1Jk0J+oIns2bE7YJNpybAAVG9k4MXI=;
 b=QRQtAfAVSAAyo7ZhF8nF67JDNELjZ4MK36sHPUlzFzH2u+M2pDUoKwPEMoUtSlU3kB
 ERIl+G5W3SSl8tNZuDatFYyFAYqMWj7niNddjDSTxzZfiqTptRYStqfgazEDbwI14EW+
 7Df6DJfGET/zyudBPLLj+euLkjgE9WDAb9BisWUmV6V3zEnzom4fEKmep3gIAcpiiZ+4
 iYcWp6Sr3IfYbcMeL2Tj6YiNFCgpYMaoRFvpT+KzXR4d1tkRhGcJjUBQCEU/QEhQkAj9
 CAy6L/FLPuiAxa0Wpyb8bgCApIE7SRf3VJmPLtwykeMPCvpPFoRO41yPhe42JecB55/S
 pcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793797692; x=1794402492;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WvlbPzlPzuVuN1Jk0J+oIns2bE7YJNpybAAVG9k4MXI=;
 b=dq5lxK2O/RjkI+9utnEIKMWlAKpkaqmxo3E6Am05D1qE5AOJ3NHXKfbxmUKP4oMtTs
 DgQ9xTDyU2bIHPpB09r/eGy2/T2IzRzgpl6ur0TmUq4O+gL9CYr7+DazBCjjkQPrZNlZ
 bagUaZ2PrzXtCajWrdF5FTgoHFFGPEPLaBiNrU95zdKjluQnzFS/2dkITJftfKKlu00Q
 DQ4Xdk8DQkUafXzS30AdUdp9AY8FYibyIAjcdq8YAWCeov/Jbd+1PZzcMzConM8Mze4m
 /RqtpAXk8KP91pyVc+ooQWD3SACucQP7jw0tNPQpYeyVKLG93nZJk/tynnZanvUyfo+D
 FtmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByOKFyrTtC3AI1j06rY7TyalJaIu6y5Djp7SGy5ke6IuMHfjptuc3ejYRyx6K/5w1q1+GIh1RWnUioESm2y@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8o3EAPh6cegJ0DvZ/bes4ztKvpb2E1EQPifDKQO+RFhC0akFkN
 Z2i3LlVXUXMk85ZFZCMPo1PVgHBSYDVDFAL1hZSPDtdDCLiHdYxuzLQgmsjB5OQTZotYFQum+DR
 xQ5TSO3IrAF1GulW5tXFm1pOpoAVRqyD4Sh0ewwCUG1rNEuMz+Ivq5uqsjhXO1iKlWipgyPkkyD
 Nh85oV+g==
X-Gm-Gg: AYBFou1I6E98wZOtc8v7kIkqAvJV0/5Chy31FAuHpynQwE1I8Vz6lW7nHDLVTOPgKcC
 oc2wAIjntaa3rAPzbuaC/qi4ZQ0ahuW/7MwAfY23ppU/ecME77VBdOEPdnSKGK68klnEvG7R9fO
 HdngY6TIVFGihrrRS442vqwtbqWemBruS3qbe+cByfkHXJ7jUUOdacV1eelZaGXDV5KfT3/QTd2
 xQtxcBqtcp5FEzBkQwGzH+OLs7peGt4xNSNgOtyWw4/JgfEwv3h9a+gl4I+KI7MaqmltCogmXiC
 oGDtfLd659NqOwCT48GxIlf6o+iTe54pvvwkLfrCb6G/FfelvpEY9cw+BntiCHdHLht/UZqTYD9
 v2tdxCMrj4bNkzt16qlRmf5pAIxjt3s6NV1e+3v67TBGhx0I5oGEhaRCiu5vpu5eU0bwDoNg3Zu
 p6ocs9xHaiXVeeH7YJs6pvqWB8TG4w2x83c6XXVN1NI1kd9DsEBxHP0RlzIn3jPDSLtAFeRIXWt
 EHv+e6PKstmQRKls5e1MbCtPAZUX/1UqZ3p/nbYbAY8OTc8EZrpqyFF1q2I3ett/3O9DTd3yCJU
 1iau+fzGonH1q7yRIZd/XKF8GYHUb2nphjtMhxvsYJoytOfXmJHS6yY60HSjShDFjLyEvUb4do7
 vQClSKxNrvYY3ApJ/UlIQOCjQ6UmNVwCc09n44N2F16MUlkfMdjoYs31BrLYJEQlFf9hFk+ZQhL
 sLmrA/xfoHoYJkSg==
X-Received: by 2002:a17:907:934e:b0:c3e:d0ca:d30a with SMTP id
 a640c23a62f3a-c4ca7a423acmr1468708666b.4.1793797691623; 
 Wed, 04 Nov 2026 05:08:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4422d1sm68443066b.39.2026.11.04.05.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 05:08:11 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 13:08:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
X-Gerrit-Change-Number: 2118
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2118?usp=email>
X-Gerrit-Commit: a95c2533fd931037fa021b38a42d7cbe6f334cef
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 13:08:09 +0000
In-Reply-To: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NTkxMDAwLkkwNGMxMjhhOTM0ZTlhMmU3NjczOTRkYmU4MjQyN2RmMmVlODg2MTc4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <140973dd84d17556baa4cda4d96f12923a3eb9fb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOaiw-000000003QF-2OIB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: drop the
 return value of verify_user_pass_management()
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
Content-Type: multipart/mixed; boundary="===============0590261733846991620=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0590261733846991620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VcTffGGtk9E="; charset=UTF-8

--VcTffGGtk9E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail )

Cha=
nge subject: ssl_verify: drop the return value of verify_user_pass_manageme=
nt()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2118?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I04c128a934e9a2e767394dbe82427df2ee886178
Gerrit-Change-Number: 2118
Ger=
rit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 13:08:09 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--VcTffGGtk9E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?=
usp=3Demail">change 2118</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2118?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2118 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 13:08:09 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--VcTffGGtk9E=--


--===============0590261733846991620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0590261733846991620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0590261733846991620==--

