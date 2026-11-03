Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB251606A32F
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gYVfROCU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j3c5m+2/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OHq8MO3i;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XPh2oGCK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=H2529K9MtzSfVFV65KlrZpSyNLPKI6EdNDKQKWkIkPk=; b=gYVfROCUJbtWjeQoZ9jeW39ywL
	VSvvcqh9Mg2V7w7uu7nBE0l4GJTLehUadqzAYrGTNTvz9pyU35UtgDmJ9uM/+AgnWS2AFeHOZIcz8
	oQXorPgr9yW/3Ak9WGElAs/SnD6zOHwwYhjwcJ30jHBH2+/IarREG7VYRrRpPQLU/W1k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9Zz-000000005H8-0aj5;
	Tue, 03 Nov 2026 08:09:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO9Zy-000000005Gv-03XX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UQHW9g1jPBNAbV0MwMtA/V7NGO2k0VZ2LQv5JXe1IW0=; b=j3c5m+2/7qC40HoRxgTRJf1eWF
 mCcGWI43mQMw9a16QFZt9nXLz5jDKljn+A0CG2b8/4z2FKq0bkHVEIkSYdYbkxYwga2QNTtaYK/X2
 RLZeLvSY9wjIcz8HjMHURY7uGu45/SxQf4xzr3bn8q+bRSKbdseLrtSO7p05Ywasf38Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UQHW9g1jPBNAbV0MwMtA/V7NGO2k0VZ2LQv5JXe1IW0=; b=OHq8MO3is5QNW4/YdJuAUUAE/N
 1OQs9mEyvrxPYZKfpXRD2J61rI2GQa2eFUJBH4unbzA+NWEi1UB5D9sZwbaX16WgplMmM8MNmIa13
 1tkhgCPkaff/v4kFjVx4cgz9sx2TSGeFNejrz5kAHt4RHaTMgh9scMFl63XUxSa6KOuQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO9Zx-000000003K6-1mt9 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:09:13 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso26734055e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793693347; x=1794298147; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UQHW9g1jPBNAbV0MwMtA/V7NGO2k0VZ2LQv5JXe1IW0=;
 b=XPh2oGCKJVyQXpHIR8+DHk4jNde1m5YvG0b+Cdk/CC7jL5L2uAjmNrMzQ1hHhjNZ5G
 onURtaSPtfvQOJB+yZWTEJrGV80j8c/JvzWMG22PsTf4vxh6CMIecd2OuO4tyuEa132k
 EfMRVRvTSKmqGByALttKArALvo0PxgiAXA6SGsu9mvomGKYs8tBZlIhrMplotalsTqRA
 Rv2WKm+e/9TU82FDZrW7oKTX3Xl4LrSMKwg8UT19P1v29BU7wtRzUFO5hizHzEidUyV5
 sCybPoyPAvw1YBLmS/j/O+J61zmTtSX7LAXjtmNiwOe1oyS92z4zApCUKa1Lh2l8SGP6
 2uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793693347; x=1794298147;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UQHW9g1jPBNAbV0MwMtA/V7NGO2k0VZ2LQv5JXe1IW0=;
 b=seI44z4yHNvgnW7NJYbH4bFV8/jsLg2rXRmpCTQ4b3YOS/U9BQotlhw3un+eL0xFXI
 T3QPy3QkwPjlCxKoXC9m4ybIJjoQA8Md++7zIC1UTXUbTN04f5rhNWQhtOLaSC5CTRkr
 PFjvfqEGq4BUUL1GI1iXyaUI0TvCqOTjntsGGGBgWzSr6Am1ipKvFx0FnTxoLYECMala
 9YUnXCif3nicxuYwwtE0LbID5nBfs8yaxAxMwqNafQ+tq06x9/V4AAYH3sfOdqz/Ny/5
 Lews9IjN7bSvJqwqnPxdxWF6FbIA80FdxQAyon9pbtVuZ7Uu6ojvYYCypZi3zHeeOwRw
 7guA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWrlXqbi14kYKWDRG7IgFzbniDstFhmymJmDrpUT9WNsnc/ue7P+ss+454UUY/mjZvx6ci+1DOeiY+ya38@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/WSGS85ReCddWuJ1WViSEa6WSNtJyR9glASRiMMB6n3gOebT1P
 FEJDYThJwEvzbGCTGhFzSgjdR40F/eYeRjPEL9duqOXjDFm6UWwBYuK/Ek3OudB5p3rBYBARXvq
 Dk9uHFeKwJy8Ls2Ruxg+kLOHWK7x6rPjO/wqbKfpLd1shxQ/7qNOUoo5Gj3ReOPC9b8oL
X-Gm-Gg: AYBFou1ymLZUqwQnCY5opPA26XINlqGTFzxgMZXr2qePtJVGMuhnKU0TyH51n8yf6Op
 lYJ/f7CmZoetcDtp3wjPYBfnNOWfqv/tbcnNWo48jhb6EOD8jAQbogSHpptlajnM3jqwSmAvQnX
 smj6gaOOVU+jCkegM51YaoxTuHKT+cmuTAQGLtPn29VjpSiMEPgSMPG4ULPM/pWzidYqeL4UHem
 +ADDJmOL86eo+lpoaKDgoMa0UBlLUJxvj0OTt4W66IIHiqGw2QGabhgLU+8Mburvd6aYyK1s+RK
 QAzXe+6B7wJ3RhKiaVybjfo9Hpu9ME+vitAGCgWe9VZSFzmLDUP3PvZsDZIrkvMT1AOQCThFunK
 WNCQSuh0m7XcQSzfUqA/W0eP/aWH0U8Os3Imi9J6kKl64YqlRIC5L3DohMDRuD7IcC2mucwn1TO
 xuK+uyBwVGA0ya/5pTllj0vcef2ECj7xfakV0ABQ7dCVk5j0A/Y2H/RhI0LQPleA2+Lbw2pHmwJ
 oqyfXzA6wllqQmbffUKcDv4SsmALYjVLRwExvtGlr6FukUV1zOm5BPYR2unLYuzInBCttti8xu4
 jyyiB86o3/9RFXXGyJLKbrslwBT+2lHr9the6qsJvx9FpnC3FXjRh73metxby+QRFe7H8l0GnMF
 s4nAmFohfwewo3xJgEOIXRR+ydjh1wIGVKW95+vYU2THesD2HVmCu8DLPN50+yB4YqqI+5vNQTA
 AAlyC1lrpeFZu1EQ==
X-Received: by 2002:a05:600c:138c:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4ac1765d3e8mr277289705e9.19.1793693346843; 
 Tue, 03 Nov 2026 00:09:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a80e184esm44511875e9.2.2026.11.03.00.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:09:06 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:09:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
X-Gerrit-Change-Number: 2102
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2102?usp=email>
X-Gerrit-Commit: e1713e6b61e7d7798e4ee41eace30b8946640317
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 08:09:03 +0000
In-Reply-To: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
References: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMjY1MDAwLkk1OTUzZGQ0ZTU4Y2JjZjhiMmM5YjM4YWRjYmU3NDcyMjNiYzRlYjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <038ca1e97d5ff9468f443f1b1c63c7ade157f015-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO9Zx-000000003K6-1mt9
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: fix AIX IPv6
 route delete error message
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6173575321395510470=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6173575321395510470==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gRioV/yNaVY="; charset=UTF-8

--gRioV/yNaVY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Demail )

Change=
 subject: route: fix AIX IPv6 route delete error message
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5953dd4e58cbcf8b2c=
9b38adcbe747223bc4eb6b
Gerrit-Change-Number: 2102
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Tue, 03 Nov 2026 08:09:03 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--gRioV/yNaVY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=
=3Demail">change 2102</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2102?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2102 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 08:09:03 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--gRioV/yNaVY=--


--===============6173575321395510470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6173575321395510470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6173575321395510470==--

