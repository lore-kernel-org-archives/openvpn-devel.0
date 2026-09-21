Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F51C982DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0Vsat8hwSVa2famt4Kok/vY5Ho7agR5OQ+btcufh8I=; b=JicPe2MZ0qv0qOwGtSjxZoQ4EQ
	AocYmAU216Zqj8BFq9DxRpVXLSX7hQc3n5OGObB0s3idaY1Zqyebt3g0vyEgUR2nKdWYdkbFsi9Zn
	tOuwFcnDCiGyAWJgSosisJALD9L9Uo+ieokHU3tCJpB4IWKlHZ+eE0qaIZWkDKU+OpZw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8az6-0005dV-Oi;
	Mon, 21 Sep 2026 10:10:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8az5-0005d4-7t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qBv9klfo4/lUIELJN80PaEZkFVt+dPhuxH4Oh2+SxCs=; b=UXWIdiq9v5FINx0X59FWuL7THY
 Tex6XqUglj1us18ZjRQE9GJ5iJTO3f+hd6TfVwsuuxjjCunzGN27DNHIA00bmezOFGkp9QlBK3d5Z
 qdHlWqVb8VhHo3SfvyB1Nz/Hsq2kA77WETFfjhIsYuVEa1A8jaggKxcrCgMGAb+dJM84=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qBv9klfo4/lUIELJN80PaEZkFVt+dPhuxH4Oh2+SxCs=; b=a
 vdr3vKAmDgHTxeu16ZSr4XnxHrG0Z4lu+jyV4j1sTxO2T7yDYrw5r5AvPBE+ZU/Vniusdmp11prjg
 g7gicifklTDfxc0FVFBVvHtO3IONr2iCGzUi+uHNzRzWqefwCyo1ChBb3ZF+q8YcMCXcpy6DeeXcx
 f8B29ljeQkc6MhqY=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8az1-0007Ex-5s for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:10:48 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so1640490f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789985441; x=1790590241; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qBv9klfo4/lUIELJN80PaEZkFVt+dPhuxH4Oh2+SxCs=;
 b=BEAC/reFIrii4zubq2SiHezp68x7uU4Ct6W+H2JIB0z+RuxuAGrcz1Qppe2lQAL2zE
 j1zMK4YxK2+EJCCsW8gqFatVHCTB5AeI7JUtB+t9YFTKB+YLoODTN2hRQRIL3Gml9uao
 lgE7tnt8W51NHIupojYWKK39ZhKZ70Urq3H8x1++7Pi1Do53GBmRZEwzKaItf/oNOHdw
 +avkP8URYq2uAZRRN9PRmXLXV1htpjFNRWJ8423Hf3hXqcYJ3aRE/mNP1FHGKtOpKOaS
 Ch6cFXP/yjcRLAf8S1LqrKRGnZL9ewpVbUChKgR/oCWy7DSsf4c0Owa6QOdp6qSuuDuS
 k85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985441; x=1790590241;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qBv9klfo4/lUIELJN80PaEZkFVt+dPhuxH4Oh2+SxCs=;
 b=mDBosSIvKst/PIBKgRNLHczv6lC+xMT37OTPj0lPL7sFYIQj0hwigbP08a0OCT4t7i
 idTTeRziDzrkOOU39pQT3Uij9pEqBm7+ca0HChY+DSQuOFazmOFljvMI0VdE7ywKSleI
 AedfKETPl+rSOAMTk5iD2R3yjCrm+1iRnVk0/gNK6SgTVs1S0bRVg5wL+AqAz8PxEjRB
 sIoV/966LWzqBCCgm6QonjFC8FcmL0uxgiZEHr+S+gPji28s/M1A/uVYMQ/8578h72/5
 ui8u5xTiIlO0YqDtQi6PCV3k6qaDkp+zboR6obfD3E7B7Z88Bhigrj00YphWRpUo0Mg/
 fwJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhF+sHeD5APvvEwawmAujM4MwBDR0QrOL/nRgll9vVZB4R6rRRRfHdga/kP1TRAotKD4yJJ/AaMwF3gVkK@lists.sourceforge.net
X-Gm-Message-State: AFuF++mjnEca7FATdsxR57UEGHU/Np1pduv0LgxT1Q5ZjtdRN2vGKefF
 JXb6duJtEkqFk3LNTZL4vqQcw/QhOErCGh72qojTJH0yMgM/QJ8nJCyB4CjQS+N6J62zaOAUujY
 8XZGEKJ85gP8H1Sd4SfxrkbnV1o+F1F/R9S7qHNcdo1xiuGmgl0e1U0aiTeNI3dR4SS45TKKfAE
 1UTtNsBQ==
X-Gm-Gg: AYBFou0WSPbbNhjLeQ/tyIJG5Gy6vkKBDvNThjInPcEflWKzlGXL/3NLjDGYnp3O0KV
 3FEibIeh3b1yMH10OjqvVgSyLbrENzqfsB33IOwmraggEGgPzKijZx2skLo1AxDlkpFupCY49Fr
 1RXlr/4xbCiTpyoXK71TuH/Nq0uC/QcqM13n+J8S54Y2Y0UNnMBDmReKsVV0Yi8Bk3CFXcBSi/9
 zvwQfBXYagRYn9+D+SzO2YU+24D/hGOSU8t2wAv4rY6/89oNDLzPeg9nf5bIzk2YYzw3Mg7ZV6g
 m59SldmzukBzyZmRctSadnHUbGS54V9YLREOkrqMo748Nm/SpGMaKfgNiyqYwdXf0BJJ5OJPfZB
 ocnkKrUurW8WdPlZxD7eRsDDzlQyfY8Jz4jQSsNFQFY/EATj/IhFVU3ZpRDFISxTKw4xhU7pXp5
 7QZ6BZ79YLsFcdO1EAONHNVCzOuohVP/VXtc86ABaePIGrqobcLza1trfN3ne+Xx0qr3jRbfXaw
 X1qfjoh7SE4ShJQZp0D6rFmoo3BoKZVln14JqH16UG4D0l3Z+yQUQwcBGqtsKvHCbjvxJOX0GEf
 /0o3FLFsAwdwbTCd956ruDKUc7QZxw1B/uHm6vwagIXrS6+DmqYRnbfqhMXfzg==
X-Received: by 2002:a05:6000:1446:b0:487:27f6:a4e2 with SMTP id
 ffacd0b85a97d-48727f6a65emr9031688f8f.50.1789985440492; 
 Mon, 21 Sep 2026 03:10:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872442263fsm22243940f8f.1.2026.09.21.03.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:10:39 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 10:10:37 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 21988787f31d2c2ada5ff44da777eb0ca86063ec
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 10:10:37 +0000
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d64caa2fecf3645aa7e1fa118e8889a3eec55e9d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8az1-0007Ex-5s
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Unwrap
 tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3686709138008997428=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3686709138008997428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4WGNYVyKy9c="; charset=UTF-8

--4WGNYVyKy9c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1758?usp=3Demail )

Change subject: oob: Unwrap tls-crypt-v2 serv=
er probes (P_CONTROL_OOB_WKC_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 27: Code-Review+1


-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
Gerr=
it-Change-Number: 1758
Gerrit-PatchSet: 27
Gerrit-Owner: stipa <lstipakov@g=
mail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Com=
ment-Date: Mon, 21 Sep 2026 10:10:37 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--4WGNYVyKy9c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 27:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">change 1758</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb8c0c66=
0a98de8ec549b69f6692a7b41b092eaf </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1758 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
7 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Mon, 21 Sep 2026 10:10:37 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--4WGNYVyKy9c=--


--===============3686709138008997428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3686709138008997428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3686709138008997428==--

