Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C836606A334
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Zx9F4i54;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P7oCIAD1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YLaj2aoY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Y6hFZCAT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2YdoTb48wvj1m4Vw/xmWii6fHe51oJnj66aTV5UBm5s=; b=Zx9F4i549JuiBxxWApx0Gr9R9/
	4NCr9zom9qB6v56nkuPa9JMeWHBFEs4e92k00dN0g6yk9NTrZ56HcpMwEZsu9I0zqeJMZdUofsMoG
	rrvhhKms2JMKb5zXNqhcEhlR3pL/6nfx/gvK0Y78soxwErUmph2F5be6qHTBS5ZgPqnc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThUE-000000006QA-40U1;
	Wed, 18 Nov 2026 15:22:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xThUD-000000006Q4-2FL9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hjS5EbqePvDprfEOj7oVVyGMp7Nsaf1DFTz5X7TEkjs=; b=P7oCIAD1lLu7ZNRo36qz/d+eTP
 UKnAtTdsF8Kf7LCQAm7coP+7TB5JlK4TZs2V0YDqQIag7QNlq8cd77J65YwiEoWwMIHUB47h9B0o2
 PipbiOue6fq4/LivLVrMJsrisQBUoPprJumjYvXTY0AyVLaTEfbrTuKBOLbwyuBhEwrA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hjS5EbqePvDprfEOj7oVVyGMp7Nsaf1DFTz5X7TEkjs=; b=YLaj2aoYooxfCHUZvAp1RYK2p/
 7R78L36OSXRu6uCvw2WOJ3lTg1eIBmcEvSB5MF1db7wqTg29yxtuTMjO8VmhC6L4kxcc6WobGge4g
 p//pRLDUM4tU8XdG/1/1tU1spr2rNs0hXialiljDoyjdXmU07801FWsaPrdolmcDZAeM=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThUC-000000002E4-3Sh7 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:22:13 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so980572f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795015326; x=1795620126; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hjS5EbqePvDprfEOj7oVVyGMp7Nsaf1DFTz5X7TEkjs=;
 b=Y6hFZCATv7SGOOww1RVKB5ZdADnATPlKRtPlA1ExVaZWoIrE3xF697pNslmHjEk5TB
 RN/Hb8gBtkubS2hX6CoiISYCOq5Hozjp06nCJ5MwjJDdslLJKlPRPU9CkOcDDvmQhaVq
 yf+DXJGrXMIBybm8smnKQ0aq0jB1JNe6dpTL8DBnL3B0Sf7oyjSSutVTezpdeYaJYxyI
 A+GvR4ctYaL8kwaNC1Hc4Ang1jtWq282nVwAUF5ajr1pocQQlmEAPsabHWA5RSFeqKKd
 RrpP+DjFvZPJcdmgLJYRK2cR3tD/pFHoqC8cNWL2Hzgooep4apvvYK0xcQth6s3BOnR6
 BWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015326; x=1795620126;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hjS5EbqePvDprfEOj7oVVyGMp7Nsaf1DFTz5X7TEkjs=;
 b=fBVnq2cB9R2c7b7gKvG8CTvbt5bS2BCu3IjGgjnw5PwZriG10UBEn6zF6f2da0JprU
 p2LsyPtGSYLNKzJeBmWbzP4Hr9WjMqP1G+KYvx06AFpAOuQM3vzgP+yRBVmiTAqxVR+H
 EgpaXVbiZZHP/cMIjnnx2aR1gcOPeIGYQwx7AFpzRP6cPHaGR4ycjcqYFyqhvU1+4Tom
 piH3weABJJS8mENSrrwuFJnBgowx/r8wFlR1Uovy45yU3dLGn3D4G9rDPm5F5ukCEhOW
 kNOkJ9gJWM9ZRXljxDXBfQ28PykR7hhva0qEIo/+Gr/6JlVvgDlgC61gSLnz3MoEeQ97
 O/ig==
X-Forwarded-Encrypted: i=1;
 AL+hErE8juQW6JtB0YKiLmRcNrWWAxj1hNjyk3WXMxadgxHvunHKeTAO6J2kHY7dZrEPBWSgggH15uUCD1QVq68H@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/0+/wVUVKi9JjFSyBU2GDrBxagZj5CdSJ7846YUrH8GcjOyitX
 AGwB4uvb+3+CziPxQMQMVF4SUTBRTXLS7MBf36bIw+ypflsIamPmtuiOb3QbRKQ3H38KZcbMlzz
 dha54iVmkfxKlxYatccmH3uJcEo1BbCn8dAW80BbBKeWJU5u4QPC7Ymapg344zCchb+eJ
X-Gm-Gg: AYBFou05/nkgYY3awDiauE2XYWV0oi/nAQNbhArPr60G3cXyEDx+u6hvTetAg4c07xF
 wu21R64cQ17yw8Ztz0NiqgzMqt/v4dQOz0IiYXrCcM+/yej01W9Gy5jNon5dSenuDClQZgqEN5F
 LcwjQKrk4MfhdFq0jYqjErgx2uFZIQOxPHVP0oZOlaTZwlZzi3ZxeDEyHI1ZvohHml/TlAQuXy1
 kquu6aL/uTz+1h/890X0OcSfRfIXZzZsFTvl1baDBnLerCjVvdV42MG58Qb/jTBcLH6qdj/fXeo
 xT7pEKJAuHZalAFngJ2V3sdbdjcQ+WPdfNeF+UDedW5vaNItVuUoJVOYHFvLzUsyyYv+9a73446
 0h4o/DhQWN+Btx2+uDFdiZDS80YlgoAr1X/AsqqJ+G8yiTDZykWW/kZ+i3kTJL8t9iFdnCsVFIY
 1SXWG2X21wlt6GuzB5HRRcvxBIdrv/1rdy6NRyMQHNhIA8hUolkGwIe1whzBfpzvYNhajswC91E
 33rd80svoCwgVCvhvD8M/xwdczCaYP2VlsMymg19WG6scRjo6/oWEpDe3Avgznz8THhVspKfic4
 fGJnn0gQ5N9Z64AEHmf33OD8/VM0dei4yfg3LHMWw45Yp4VuhE0ZC/9zRXIbjRO9BgEBAGCMl3R
 75SYTERKWUQj/iZ3zV5YD9kxyOMLKj5UFR4F3ucTRCVt3IKZCVWlbGennABtBR+z1VSGM+MqgIe
 sUVhejHCViYPcvoPk=
X-Received: by 2002:a05:600c:3b91:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb7da4647dmr66585055e9.32.1795015326108; 
 Wed, 18 Nov 2026 07:22:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d29c622sm76865495e9.3.2026.11.18.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:22:05 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:22:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2215
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2215?usp=email>
X-Gerrit-Commit: 59829ce2326634210b74e3f469387c0e429ee4a6
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 15:22:04 +0000
In-Reply-To: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwNjU3MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b06a017c44120410c583ccd618007266ab5391d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xThUC-000000002E4-3Sh7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: check
 the address family in addrlist_match()
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
Content-Type: multipart/mixed; boundary="===============2625830982224130608=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2625830982224130608==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MYWKGT9IZJs="; charset=UTF-8

--MYWKGT9IZJs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail )

Cha=
nge subject: socket_util: check the address family in addrlist_match()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2215?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic3efc=
db7bc4e60a81b9292adfe7f8e22b86e274a
Gerrit-Change-Number: 2215
Gerrit-Patch=
Set: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Wed, 18 Nov 2026 15:22:04 +0000
Gerrit-HasComments: N=
o
Gerrit-Has-Labels: Yes

--MYWKGT9IZJs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?=
usp=3Demail">change 2215</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2215?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2215 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 15:22:04 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--MYWKGT9IZJs=--


--===============2625830982224130608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2625830982224130608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2625830982224130608==--

