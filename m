Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025160A2603
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZKU0I3s+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Sf7czNwJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PLidCjoF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ya/EEwrN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yWxph5zHd21VUSr1gqZboEw6yMq/PLQ9LJ//Z8tPXB4=; b=ZKU0I3s+e7eYvPhWoAoqD8Y/9O
	vHs6u0g1NIHHcxaGtv3r/D8KIlilL9nsB3JG2nPD0BSJpwxaZJEPfkPAvgMGD3TlUIDe+tL8+PddG
	WU/S2Pl/ZKYhHLuDQOI/KsKHKlB0DidE5pQpxgmkMuKN6pwWNZzrakho1wJpyXSNRPO0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrYI-000000001Pp-1jmR;
	Mon, 02 Nov 2026 12:54:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrYH-000000001Ot-1NrB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:54:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NvIp00Kt+Df0n3NBsibZvXYCKMsimefPBSW9n82GfpE=; b=Sf7czNwJ8g+1kz5H8oNgju7+5G
 BLChFRa5MRvIvP/aAtYrUfpsBvYfUIvGz5b3ZKKg6QQiUCVB/6LQnAFaA+lx7zpS5vySAR67pKa2D
 NjXdiWG8PNjenJDweZnQtlK+gJo77MyQR7AOS1OwPFjgd2D/TFXRA9wbRSWV/3+QFPaA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NvIp00Kt+Df0n3NBsibZvXYCKMsimefPBSW9n82GfpE=; b=PLidCjoFSSkH8KV3OEK/6fY42w
 o6y09vWLPxYzpArkezmqv1lkUXOHLfODtm3vHMhcCpZIs9oN3xQ4ujHmrOUnYpMYOzT6QzobQ6J1u
 iL1kFPDg9ET3pAgsB79cEVYFut485MA2GdQap1UxE5hyVZSdGH2jVNA0K/dr4SjdYJdw=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrY4-000000007RK-2vF0 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:54:05 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso29330605e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793624038; x=1794228838; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NvIp00Kt+Df0n3NBsibZvXYCKMsimefPBSW9n82GfpE=;
 b=Ya/EEwrNPr6YZRYIUX4pZAG7MtXtbY9D8QL5y92jFDUker257inQ4/8wyRlsQF/1hA
 HH1AzoJeJyS9z5hwM4t7aaJCxstfIlJgX2/ri6OFDaL9vhS704nkm3F0RYckK5JiRqlG
 OzHqBl0NCFUwvUIK2G1ts9FlsYyQBdbu0A8ifP7bmIiR1b9e85dG7flwuFJo/jg5OeDU
 Sif76glEZVupBy356OrzFgTNDLhssPXpzJks2xz9YNPavuIUGXJr2kiqg4zyyMJFNaD+
 9w2vvx4zy3M15ihYfFf/fw6g0/pxIYtSvW2qfsSudJvM3hMoDD1w9HuJbrKH2RXBf/Sx
 nJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624038; x=1794228838;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NvIp00Kt+Df0n3NBsibZvXYCKMsimefPBSW9n82GfpE=;
 b=WBrJiuA9FMDN3A1MULhcsFG0Fp0X5J3PtMTFtQnjqzywqV9hnKdesd83gVl3MY17m/
 W5JTZ7//H0urc9qJC1wctZO/1Ye62xpgHhybBuL6X9boare0DpGuwdI15lK/3cWiBaZj
 6T/EFdfj+nOrXnpqz+w5eI0ImLz3K8NZLTvzKZw8si0m7CJb4+tExc0nsnTDyR5T9CwL
 vjZfgpauOuwjYwMWAoil7h+8TQv+JTfPNyZrAn75tgSvlx53+kvoUMXF8zxcVq8n4y7d
 /pkeiaKpvzmpifdvrI7IqbxMJGSY4jl2zVLNbu8+g4esd0wROEUz7CJTZrQuKlYqtSRm
 tBfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1S07VvBT7d1EV2u8lmjVMhP4dREqG1fpcHiFNz6S+BJYQOo6P4pUKgj1t2Ac/GshARM8n1mPMNsil0ykf@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK2uwU/UXiKtV0iUVuKu+7AKquEIZsgKNGbcgO1Z3rqmo/mNiH0
 Sk9vO8iA8jv0M3MLfLj9oblgBevOwGyXwvdimtVN2HzQ64XHEtRmD4nsNy58+BLGBIoCWRHuevm
 lwCH3hWNOF4YEozZVf11BvAN6wG7/F10EL1wbmux9/8/A5MB85mmSLCYhmDDCP2xGmvJrKGYZPD
 z5ETltZQ==
X-Gm-Gg: AYBFou0w/lo5hqeqUl7hkVspYWRqmvm1rKsFcKGzrxGwESNkwiXchLL+adLw4IRQpjH
 VsQFwxv2FLX3qCKXTmJG30y4ThRlUXrdi9GgD7kWNVrmpXIfpGbuS6LEK5hkeK0E8zuV5R9BQnm
 +/ZflE30S+uDXj4JjEHUoeVo3SIRK9kchpKyKi1GZGMOYxbHlv/aysFaihFm5rsHcF9MhLlvn1W
 HJCRX47CPA5qgFTKiIZOJFC9xj+xlR5f61tvF1L0R3mOvY6JwJPMGnR4aJxIJxffCWrSXr3VA7x
 BKpmZ2+BCke1JUP0hnfOZTHIYaycAjDutpLJKmXq/EBoHKZzNbia9ITUTvOxzy+WboDnGYkEKxD
 VUeqTgs+89RRgcsC5+rduEO7L7APTU1Y7J3y5fnnE+Y0kUBEBjAEXtzWeUHWOQPP5fgKVGQF3ml
 1kjEYJus0Cw8vYTLfJlXvbouZly+wLEXG0+wN/ygjPplKO+goVaski6kiAsstL0YD1YMen/6685
 IxvM67RgLZTFizc9d5bMIVc6jef2v4kE7sX+SIVv8EuSRoCfD9HRfElT12sZB7xHHaRngWQvAz3
 p5uj3KNV1q8fm2267mJMiprRgVJfFV/TmYuk9ijrj6Y7UOtYGxs78k+QMttWAzuuuPdYuwMdRcR
 ZeTOmcq98T9ZYnD0YcFJ0si75dz7z5jooffYfXDtlIx0/aijqhhmvFAAPNLDAMgNZxDNQ0GDJKd
 mTsH95Ioh0MxMYyFG80gYZu8DifLzhdqhEEOo=
X-Received: by 2002:a05:600c:1381:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4ac180f27cfmr240787945e9.25.1793624037997; 
 Mon, 02 Nov 2026 04:53:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7270asm20061137f8f.11.2026.11.02.04.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:53:57 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:53:56 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56
X-Gerrit-Change-Number: 2088
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2088?usp=email>
X-Gerrit-Commit: d21f51156eb2bcb068cd487e7d2120ec91405754
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:53:56 +0000
In-Reply-To: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
References: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIyNzgyMDAwLkljZjgyM2MyODZlNDg3MjY5MzQxMzFhZjcyMmZhZGVlNGEyZWY3YTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98ef7abfddb1e341f57ddc17b1966c31fa64ede8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrY4-000000007RK-2vF0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: wipe PRF master
 secret on failure paths
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3225750602783419421=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3225750602783419421==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NPrfOEkWzqg="; charset=UTF-8

--NPrfOEkWzqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Steffan Karger has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3Demail )

Change=
 subject: ssl: wipe PRF master secret on failure paths
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icf823c286e48726934=
131af722fadee4a2ef7a56
Gerrit-Change-Number: 2088
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan Karger <steff=
an@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Mon, 02 Nov 2026 12:53:56 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--NPrfOEkWzqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Steffan=
 Karger has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=
=3Demail">change 2088</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2088?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2088 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Kar=
ger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 12:53:56 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--NPrfOEkWzqg=--


--===============3225750602783419421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3225750602783419421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3225750602783419421==--

