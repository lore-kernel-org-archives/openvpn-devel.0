Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065B4606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NgK5isCv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PA/PmDeB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Jbdu5hCM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OUrJkZ0Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=c7YsDVTEvgr7OP9ZOoeK5/BT2lMXXec1BUm9zvWJB8A=; b=NgK5isCvUVaF9xuY6BhcGIcM/g
	1jw7WwByXNrOoU+jTLdnTugWocBK4bHPhGEbhzjm0f/UOeYKp4NHqAWijrIV9iwTfr6Iv7f3EFiir
	EJGLnS/sCNp2tmw3QFPDfjNcalo1cgmcfvD8/bmPUsjAC+1+Gj4KI2pwSLHOHCikj/mA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKj2-000000005Pu-2AsG;
	Tue, 03 Nov 2026 20:03:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKj0-000000005Pg-0RwY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 20:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SBVQHC/uhpwdMe2wDXkZ2gaUdihWnCCrJ/6KHdoDsY=; b=PA/PmDeB66VFn3U56YxtAqcOGM
 R9S2Z/r1IEjSAM4Ra4/AV5tF+IB3Srl2CbHmrGew3C1x/g0VornTRl5cFC3SmNTjhZKs7ElMpaJNH
 lc8NefURahgHaiyIUJ9WQXm/jIuy36uLCfPnm6kei1uqovE+n3OCwqGgOxUXOJVqmYI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SBVQHC/uhpwdMe2wDXkZ2gaUdihWnCCrJ/6KHdoDsY=; b=Jbdu5hCMPLRx9LudRwIo3/s6xG
 59dAtR/IBn37IjSOrPVG9HvDVAnuV/M5lGmPdFVm7JmlEziO/reDiciEV3Z/WS0BPXUjTyzNmB1bZ
 M9O2uZjGPrun2NjYJqXAUlr1FGcbcHtBHREgOzQW6dTrxLjP/psiJpgwlMpcf4DxeHvw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKis-0000000070y-24cP for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 20:03:11 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so50856435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793736184; x=1794340984; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2SBVQHC/uhpwdMe2wDXkZ2gaUdihWnCCrJ/6KHdoDsY=;
 b=OUrJkZ0Q8vbt0vtjFVVbYQqdJ2raS1sMrU5qohmvpOeTjS2di1baNKUDTIbcA3YN8l
 nFwQ9BEkNZGkjJVIh8Nabd5kkKdIvR0lLEK9wPtTUcqo+jjR5EQOD72E/TXgIlLXB3La
 2P/O0KhEn0BmEu16oBQ9sUAwzQo3KfMQyjARGbk6LaEIBaIo1gXtJlBYImtbKmszJipL
 dwnzbTQqQsd4MdiDgcm5vdrNiuABCbitdPgImUIBFjO2Y5eEZ4W3T+a2Fws+e8dxJqMD
 iI4mVp566W50ZExjdG+ao+3CaeIBKMt7liNhkYcprIkLJMUxieenol43H9O1x+58Vmec
 BSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793736184; x=1794340984;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2SBVQHC/uhpwdMe2wDXkZ2gaUdihWnCCrJ/6KHdoDsY=;
 b=gb+LhcyS8QksQpd2O0KGjRNqq/6Pz8wo+uzWDGAh5VHwI/2Y1jHcWXMEUKagq+n8hZ
 ibyVhgk1zyyks51nCtAt9jTZZLZaxjA1fqR+PqzyVk/NB8tAfMTxN/Agp/d4ZUyEUdwv
 P5oTAKUJoSN1hiCHfcTurooSWjKiCWyFp8CnqdD24XY5s9zYLBzytQ30VWdht2PVnHMf
 aW6RfghW6qa5my5QmyVckRcF57xOBC7VrcMzlDhYADv21/8UkzmEwNV2sfgnXbBq81vU
 ri4TIfF0sYCxTr7uYkCDOPOJgyCvgFv88F1TNnvQU0KbgFwbAeqlERp26xyErHFh17/u
 iNIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyLTllo8cheKYZiaJgkMWNF2LF5JiEBzNM/3jmEymCFEBl1d/bjsvxF5WcgOoz1ScGmrteTHLUTbZJYGNe@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/FhzkTK1H8nFJ0TSBVJuKmS2ifmoJ0bXcNrCb/O/Hw4LPsbqdF
 JJ5vBj2qBHqDUrVX/A/CdJSFB1/pNnD8Jjphpisu/U9F2SqW1PsVq6fwvg2hvr+YFRSPBvBEUhu
 BI/idPhne7fs6OiDsMVT4PeZEQrV9H0NgqEZJlBoOc9gsLe+Io8YN8s/eTKC9HNKfGvpg
X-Gm-Gg: AYBFou3aQpCwUGsQLWEP3QkYpLiOCQltelzK6g6hEgj58uKzP3H7MXXDgOm/pC9Hx9q
 PgBI00LvzoZzFOqz+VlIFuVhzEYvm+DUV5LrrxIY1koCMVXGSFYfTGwoQuHC11Wt7qAcDUVv8tp
 5JWRk87SMmOyEElg6C8y5JA6sNfWA6DjsqPjdXZSYCQYH10t720Q3Z6uxdgU6GxExtJbNfw0U8e
 Bowv23Uk917d1Y3S65BDPEut3gLauUbVJ+FnGHRv8hnQcwdyeDuS6gu4RD8JqbkqBMGW3e6c8e8
 p/O6Ip/XPDaWXceQYW6XJN2YZkKSCibp4orkTMb51F0s9gzslP2dO/8fDyW3/KfbGUbyn+T9yfE
 0dlOy48++ljenacKRNEMHadliYwTaOltv+iC0KTZBWcFgMd5utRx7odvigkCEofppiSbiAmtuOc
 hCR3JVR2W2mGS4D5Jz052ac/kYOt+PPcEYkgcSXFswKSz5ts7PLn7M46a/XQR65DInMo5A2Yzsm
 jmp3ENWvlAV0aYRFOjQS7StHQuraokwGOQ3WWCldBHhM+hADQqYYXrB7AqwsFxt7/YGE97MjVLi
 LlmNXBCLhvTqhrcNULj//5nyZJ9Mzku0XDFCJCTtBI6zBYG7ftYFP4MX70CImcaDVJoFxIqd0wo
 YBnMCLqibWMDq7xJOoPY1rhZIO/iOsxDceJHsF6hWN2PFl1pf1qruTbkx9f7XzpxHKxb49OdW70
 p+ccGRdq/vjPotfw==
X-Received: by 2002:a05:600c:46ce:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4ac18a88820mr329971375e9.33.1793736183754; 
 Tue, 03 Nov 2026 12:03:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a8d60bc5sm86052245e9.8.2026.11.03.12.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:03:03 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 20:03:01 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
X-Gerrit-Change-Number: 2106
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2106?usp=email>
X-Gerrit-Commit: 6fd0e4b10e28bf743f2e99bbf519ebc8c41e744b
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 20:03:01 +0000
In-Reply-To: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
References: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkllZTNmZjFmNWYzZWM5MzMxZjYxYjBhN2YxZjNiOWNhNTE1NzU1MzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b5fd272c5e5956543b29ef160297f3728bccd5e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKis-0000000070y-24cP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make parameter
 openvpn_net_ctx_t const where possible
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6763260296496028911=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6763260296496028911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1He68WBCewM="; charset=UTF-8

--1He68WBCewM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2106?usp=3Demail )

Change subject: Make parameter op=
envpn_net_ctx_t const where possible
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca5157553=
3d
Gerrit-Change-Number: 2106
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@m=
andelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date:=
 Tue, 03 Nov 2026 20:03:01 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--1He68WBCewM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail">change 2106</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iee3ff=
1f5f3ec9331f61b0a7f1f3b9ca51575533d </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2106 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 20:0=
3:01 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--1He68WBCewM=--


--===============6763260296496028911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6763260296496028911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6763260296496028911==--

