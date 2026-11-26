Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BD606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W+fncLMY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m94ZPvK5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J2sc1E2/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=X7yQ6nUx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VNaN3HBE4tagam9dFCDJbq8bBAZbeIm7aq3eZVLKztA=; b=W+fncLMYSv4yaWWf+voKsTIdyc
	utXa7BAydVywUp3lKb+WiGediiVWyq4CVQPKTJa/kn47mQALzkdlysuWG/NQtHNdmNMvirov8OyZ1
	fXN1sFzxrx2LNRRrsYrf6E1Z/pCIdAviGt5y8fowSjYXd1ZhApFe0ucXrEKFXZr477ac=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWb6s-000000006qF-1fFd;
	Thu, 26 Nov 2026 15:10:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWb6k-000000006p6-448Y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w/RiDM+hjHzE81mZ5EJSj9RvHfmQHVjcCA5iddPBFrs=; b=m94ZPvK5YqXvTqy9ncwGiYQlkH
 arg5rdLXcLjBDQdKphi1HYb8tq8GgJDQ+bnVwhxNP3FNipYVyJBpmBlzaC+e1Bb/Tf/8mvVVoBHqi
 QkKfq4bCnfGf052XIaratSgIciVOL/uwBXZQbkF/amP6DKLxr+scKgCB+8pFYbPysUPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w/RiDM+hjHzE81mZ5EJSj9RvHfmQHVjcCA5iddPBFrs=; b=J2sc1E2/E1IQHJ/etYJZ57kYDP
 b3hUOehf60Df5Lw8OEHKcEsv31+h3+0OU9PP7yP64iuOHdNWalVbaN/0RaVdNDMcKD86YmlZmN60C
 VQZ4tbq+dxLdFZTqZTFJpRIgkUBEuIhTc3TBwcYRy2xI5bNhzWz7cySj78cyhFpn00oc=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWb6h-000000002RA-44Yf for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:09:57 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so59010025e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 07:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795705789; x=1796310589; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w/RiDM+hjHzE81mZ5EJSj9RvHfmQHVjcCA5iddPBFrs=;
 b=X7yQ6nUxmauGEjSkc9RqMU4zy/nXseJkpEs1e1bfrpmEprZ9UXpyjGD6JkXxr6gfQC
 IuFBgi6nbihdRTsJaqxm3pd2iDsxx0MqKaatJrgwXyu2Ep8CQTk4chNlCploKrTpfSez
 8inUhJI4JK/uqBwvuvfvN/ponh1SbJb4lsGjpgC+ZKqwj/d3+o5gTLxDYEk0Ftm5Vu9k
 ziVv0oSC1wP5ZoGxAOQjBgfHgHQyDdIipWdTXfsYkoxXKTzgQkDi2x641XLvZgw9gxiB
 Lq1j2G8oM0eq/IrMEFSOd9RsmzbWnkD+srxVooK9KhgkDmoKikPpm90HggNZefTjft5H
 +qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795705789; x=1796310589;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w/RiDM+hjHzE81mZ5EJSj9RvHfmQHVjcCA5iddPBFrs=;
 b=yzKEaOOom4n+fLoqzfkSa2pMkZlBEKo+pTAsRu3OuN5mHddaubwjE9aP3jp7VZEnxw
 6n17erPEcAubAlro9xZ1gznzvHspWKDDOkieXvr4XlB1H9EyTYGHYt4aI2LIfqNxqk/M
 rMZXCSnHcFPCPsQedwaygeac/+BV3Yhq3sR6EsTociwYk4ffuMuyUaOFsVLAaY+Hv+1P
 PQhqnl6tazhvtGmmCMmLrVJsVJyuZproJ/QiKBRBi6ngFPBSvWkGLlAlyNJ2cTKDIuzT
 reWwOiPx3856OcL/35OYyQE9mjtxOmwZd+EFTzX2e7IYUMVLXQ4Gnfc3zBLaahL6uKPG
 9jJg==
X-Forwarded-Encrypted: i=1;
 AL+hErFaTGuc6EqBhIuKppWKmpXhI4S77sPTjpEVEd61/9MlwSNT9/BwY18a8qNJkSPe1L3BJT86IwhRhgCd78YZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+7DD9ki/T53FJC8T34C+j13TS198LE10CXowkHjwU0qMJRBQTG
 1Eh6M3Y76sntfQ6atPFfTJ5yL/Z2QAWXg8JMhQo4oA0gV9xhcmZji/zmBBtb/41ifGGsMQNS4Hc
 /6ex0UOz0I81YYcXh+i2Bmqp4UBg4bqAUahriBIxDcUy9Yy7R9AGNh76v3+Nb1iwh5lIuNtrx9t
 0Ee7H9AQ==
X-Gm-Gg: AZFdTZcyTgkgBD3G6rABEEV1260M3UfmEYeASMj084K4+o4V0/0qh8kTQUu1SMsB3se
 6zvuD+BQxId01y6rfvl8S+QEazSbQhdtM+cxLR53BSWT46WRlFCaqUr9C0HnzKR/CIp814aj417
 LY+1idJfGC+ghB7TyJcahY+5qOGniIHF3P3Rk+eLnvEHicTbmBUOU8g8rzQXdGwcQ6O6k1szBc8
 UCsB0EqivmzxgqR93m9M1FXsV8LwNTpojtccvM1B+feYFb1yQJEB6Ybu6uEL/PkqrcK/QnQMVIs
 HUi8rohJ8Jf7MJBr0vZhreJwMvnJCigfExkC18E/+vPOS48lBhmziKDdne6vWUj1euTxcgOG3BY
 yxszWi3/i/8oUuytPqVl4G0vT3BWmJWyMFZ9O4WSMld3CIA3WFtyCzExO4d+ikjOyg+LQt4bTHE
 uUaqRp5zWdtA+z2vFQ0Gg502KLraehfUjePLnucWvxaEHHuja1011e5mqHu+qpfEdXO5m4yWLD7
 JDJKoUaJJRzI1VEwDNTz7mGBnKLo3/hwhVGsElkBFj+sIZE2r99ZKmE7sM3Z/EAeamYyOlgV97h
 36SQp4jLmhu+bXBQZlCNrPNZ4pWj9VQEEogGzHm2YH8U1AvgipXTE+n2xrCr4JdUpQHsSiotWtd
 J4D+WTitHmStTk6yD4hys31imKRgBhee44LQ0+kBUWXkd9pj8XfMfeYYrG37X0gQ4VxBSMFvWHc
 eSKQVM+RfPiC8TxYw=
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr411323845e9.12.1795705789249; 
 Thu, 26 Nov 2026 07:09:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm637482065e9.2.2026.11.26.07.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:09:48 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 15:09:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
X-Gerrit-Change-Number: 2352
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2352?usp=email>
X-Gerrit-Commit: fd5b0a0a662a9b6c5559952ae03c331790e02225
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 15:09:47 +0000
In-Reply-To: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkxMDU5MDAwLkliYzU4YjljMzAyOWZmZWE0Zjg3MDkzMTc4Y2Y1MmJiYjQ2ZjZkODM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc5f5e07969412d85cfadd177e1d560a12ef26a4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWb6h-000000002RA-44Yf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: return early
 from man_check_for_signals() if a signal is set
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
Content-Type: multipart/mixed; boundary="===============1900430165589417330=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1900430165589417330==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1WISA+3Obc4="; charset=UTF-8

--1WISA+3Obc4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail )

Cha=
nge subject: manage: return early from man_check_for_signals() if a signal =
is set
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2352?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
Gerrit-Change-Number: 2352
=
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Thu, 26 Nov 2026 15:09:47 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--1WISA+3Obc4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?=
usp=3Demail">change 2352</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2352?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2352 </div>
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
"display:none"> Gerrit-Comment-Date: Thu, 26 Nov 2026 15:09:47 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--1WISA+3Obc4=--


--===============1900430165589417330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1900430165589417330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1900430165589417330==--

