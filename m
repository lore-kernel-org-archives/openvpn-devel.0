Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1848606A32C
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FtiSMK+D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SSUR3joy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cgjnwWsj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HrPPhPRj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s0u+q5yUY2FUutWddAQY0hTQcAjG2glq5Y58Mwn2ipQ=; b=FtiSMK+DMptWDcsXZpoEHEF4su
	OlKyNuQzioMBmxT9HUcr8o8ASPiXa5799rZgmaRPSNHK45jCClS7KQh8euGM0ZgvJ0uzj/lVj60gf
	yDrtd4ocqTlrushG060o3kWBn26gyg6wcEEHkPXLQEhPv2d6oDissRV7SB6lzSTmWZIw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNr3Q-000000002D2-3s1d;
	Mon, 02 Nov 2026 12:22:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNr3P-000000002Cu-337z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:22:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=96vVT7heITrWyQwZ0WDqehd8gQFt16KlcouWMaZOlPk=; b=SSUR3joyeBEbgyagH9x3scALNk
 9HQ7S7O1ncSqnVtOZhUL0dcuOjjosJpX59FEuS5uRmkDCMi5c3ZvSmCTfY3vkVm54+PaJZdWvhsUv
 03U0zSDFW+ZGO0hZhddPvHzxUFSBlZkhmznuDyEvTYOe+0zstoaCFxc5Pnm0w//Ks6vo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=96vVT7heITrWyQwZ0WDqehd8gQFt16KlcouWMaZOlPk=; b=cgjnwWsjSBqErwoGAhE6UBgvO/
 POSj9LCv2wfoldkDp8liVs4c/s1M4jZwg0k2tl6yzpvQVrPYRZwiayi5VKoEtZtpyX82RPVbYSUlm
 eZLBY3RD7uP4wqybDh343gTdTk1ARACTXdbkYfBpl4pIOfSSTQvWQxJ7pVXxr1WgG8hY=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNr3L-000000006a8-0nld for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:22:23 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2410406f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793622133; x=1794226933; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=96vVT7heITrWyQwZ0WDqehd8gQFt16KlcouWMaZOlPk=;
 b=HrPPhPRjJvDWgpVD1LLvVQt7WrPGCPx1ZTLgHTjq5wA6Pyx7GiUUtIIWoAb45vrt/v
 OjNnW2KXDm9JPW023/gBW5viModNKb1nl89GxCeBFi0czi40sSr5C/dEQe6huM7aggxq
 WDDLOhxABZNS0Wk82p/snYtjokSpeMErE8mWF4KttUvyajuktYsm7BHcul5KKAW1oUzU
 ls6fHRxVJZh8hYyWRDx2+fV78Oaw0Q9QawAU3BaHEITDXzb33vfVJ5OpPZOBmJRHbPBG
 DCQFPER3st5v0ERHEMUL/gcf8SrB79spejbmyfH/ZJXQnrzREWJ+hDtClKiR4dFHnJjm
 Ajww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793622133; x=1794226933;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=96vVT7heITrWyQwZ0WDqehd8gQFt16KlcouWMaZOlPk=;
 b=1ka91N0FBwJzShBeugDBKNh98guW79sFcwIn7ZuY1GYOwchMxJyQRG1kGFv7QFgvtO
 slMkSZxPi9kOMjbn08leHarhYKPdDpVpfz5dGGFZocd3h+4ueMKAuqZQ2k9+0UhO89Pi
 FW1iDTpnRWsaufNrqLkOgv4fCs/GAttYzjaM4kww3dQOF+nED0Ycej37A6mYzoAWXjFz
 f5ORH46zJlX59F6s8JiPT81G/HDujWDcxjXwoGfV1kL1SoqrkbGpYv2tl/ANFu/2DFML
 tXqmhFNsXULDGUkoWP+/5SlnkU94cGkNPI9TDgg0YdO2qJBerBTQfEuiIB6ghc/7TMk2
 uD0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmc4/Gh52Mlw118mUFju67sQlLEJSq1NGq+r1DOtsH8p0m++aWCi1M5vR9qFEcveiHWACCuzfkDazLo8kU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/8qkrOFrRoQuS8cn640BeDQCXng8ryRRAkBkIFNpkmL7HBaEXJ
 JGs4FW1gqR7MnnbztPw5ZCoGuPWnY5UEnBI2UxB6ag2XXEq6RgtQ77zPVFqjueknRHL30qwfdZB
 fwRmOEr/kUZKP6KGdxQ8pN/EacMJTF10CW5UJP7/quww5Nl4EFzKmu5kW7ekGQ3RGkhQT8vSlNm
 KsUCZWDA==
X-Gm-Gg: AYBFou2y3rgZsJHJTIOMgFh9taTPGPV7sLwcgd/nX3nb5r0epdk/72KPLnAEqn8ojWC
 jkIdcYkrORmjTC7hIf2q+R4G2ZgncwHPZGoDwCQC5W16hhD9VdHChB8XekyBlSVTQUBzOEGJtUK
 hIlj4hrNZFAY/dYSubg7Y5zJXUgnz4kR7BXGk0b9muUPR5VPWs45GmEhhIzICD5L804UCaYzMpE
 HqqtABCsw1JBQvPkYbcl7ISybS+ixXV0UyxK1Ghz8q+fLfrhsaARNVl/NmBDf0zrX+oQsuQGFb6
 r1LtbGlWkWL+rinVEfiXweoFxAkNkPLhiCX1LcthnVlAEiGZyoGN/t/lFzQ0h47+z6XO1rKDW3P
 2xGMe2WaddTMY0GUz8HZuRHtt2+wnvYc+dWXMT0b/PFf6DBMY/Wu2tahPkHzDGrVzxP7uFX0RFY
 FDnxfmtrKCBJSoZWKfCMAsWvIp14oXpvmG/HJctJBTaB2lJrGhmfAtfMqSrnv+A0qlv4AvTO/XH
 CFyNLB6TRzlPpkkdvAywfkXhBILswaWQJEbkdvAygPe/HdsoqNSqTMZI8s6gfCzCdH1G6lavPTI
 OqUKwc1GBUX72wbh6+ktCeSguCXMunypjn7oFwsdljrovWzhkCBiruwyeDOK7PIjsuRUFEiwjau
 KaWf2saypJPbHLTrFKwcS2UzJc/Ku9sJpcp7dwNHkrl6GMM5wZ5zIBYTTOlCRXQ8yIvfHNnlzmQ
 LCgOLXMU5j/Ghdww==
X-Received: by 2002:a05:6000:22c8:b0:48e:2c2f:59eb with SMTP id
 ffacd0b85a97d-48e6e303c74mr22652220f8f.12.1793622132574; 
 Mon, 02 Nov 2026 04:22:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b72715sm19397707f8f.18.2026.11.02.04.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:22:12 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:22:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 8292574b42c32903e304a7e88e92e4e60bea50a9
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:22:10 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8cb9a360328bcf214974f27fc7822ed78858e803-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNr3L-000000006a8-0nld
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0677905424210986050=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0677905424210986050==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZyN2t9kYTDw="; charset=UTF-8

--ZyN2t9kYTDw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subject: Remove support fo=
r --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(3 comments)

File Changes=2Emd:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2081/comment/f7470c94_93585c11?usp=3Demail :
PS1, Line 32: =
 
> spurious white-space
Done


File doc/man-sections/protocol-options=2Ers=
t:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/82e6544f_2b2397=
07?usp=3Demail :
PS1, Line 216: --allow-deprecated-insecure-static-crypto
>=
 We should add notes for this and `--secret` to unsupported-options=2E [=E2=
=80=A6]
Done


File tests/unit_tests/openvpn/test_crypto=2Ec:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/f3a3e24c_a475dae9?usp=3Demail :=

PS1, Line 373:     for (int i =3D 990; i <=3D 1015; i++)
> Why all these c=
hanges to the numbers? Separate patch that spilled over?
No, the old calcul=
ation tested all these with secret which uses a different header size (e=2E=
g=2E no op code but 8 byte packet id instead of 4 byte)=2E I changed the te=
sts to use/work with TLS now=2E



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Gerrit-Change-Numb=
er: 2081
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, =
02 Nov 2026 12:22:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Co=
mment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--ZyN2t9kYTDw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Change</a></p><p>3 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/com=
ment/f7470c94_93585c11?usp=3Demail">Patch Set #1, Line 32:</a> <code style=
=3D"font-family:monospace,monospace"> </code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">spurious white=
-space</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File doc/man-sections/protocol-options=2Erst:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2081/comment/82e6544f_2b239707?usp=3Demail">Patch Set #1, Line=
 216:</a> <code style=3D"font-family:monospace,monospace">--allow-deprecate=
d-insecure-static-crypto</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">We should add notes for this=
 and `--secret` to unsupported-options=2E [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_=
tests/openvpn/test_crypto=2Ec:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/f=
3a3e24c_a475dae9?usp=3Demail">Patch Set #1, Line 373:</a> <code style=3D"fo=
nt-family:monospace,monospace">    for (int i =3D 990; i &lt;=3D 1015; i++)=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Why all these changes to the numbers? Separate patch=
 that spilled over?</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">No, the old calculation tested all the=
se with secret which uses a different header size (e=2Eg=2E no op code but =
8 byte packet id instead of 4 byte)=2E I changed the tests to use/work with=
 TLS now=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af55f0=
f2069f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Mon, 02 Nov 2026 12:22:10 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ZyN2t9kYTDw=--


--===============0677905424210986050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0677905424210986050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0677905424210986050==--

