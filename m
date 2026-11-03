Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C46606D80C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nJwYlHtl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FDIs7BNK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bR5wosXZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A/o53m3W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9q9blXULy7nYxM3CveJHtDOOhQEKUYLf+0HRpKcc5+8=; b=nJwYlHtlO2vFT9BJa+KqMfmcpL
	ghy7pYZlxiut1WoMUx7fvYsGRW9JqRbuQvTqgPjKCGV8ufdCcxpqQiEDdObMxBmDyVdHlGkFObmHp
	Rlozq01uPWhUV5kXOEIYRflLad/pngAvhNpeTM7PULThtzhOqIbo4UrVAkNEK7c25OIY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODdj-000000001Aj-0kHY;
	Tue, 03 Nov 2026 12:29:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODdh-000000001AW-413S
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:29:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oY6KSS2cMRNMRm5D1q/IFGBHxlcNhPbltxvhcV9rZeg=; b=FDIs7BNK4tnsgYhJZ6BXtTmSII
 w/+MuPb4dvn6/TYwMVM3Q48z59aByLgIqvis11O9dvd+fSjQzZfths4dgNm96SfJmpoQt/6z8zmsE
 GFN0RzQrBIDcPG2fSUXGQjtFuF4WRbTeRjj0H3u9uZR/ZJAnp1r+ErwaowiWPn8dzroA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oY6KSS2cMRNMRm5D1q/IFGBHxlcNhPbltxvhcV9rZeg=; b=bR5wosXZ2IdsZ28tlTlIR+6oP2
 V1mK4GsdVsPIF1yOrnOHJUcRWJQtrAVaecwthmCO+3kqFT5rXNulkB3Id9Iviwpn47+cpRVJXpPzS
 Z7S+Z6DzyGV4iKpaZ7DxFPHJu9+LyObQUSb6P8Ziey0JH1Nqh0H1bYt7whz87ogGYlAQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODdg-00000000218-0g8t for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:29:21 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so31478525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793708954; x=1794313754; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oY6KSS2cMRNMRm5D1q/IFGBHxlcNhPbltxvhcV9rZeg=;
 b=A/o53m3WVUI0/951NATdtAEO3Ve9HQoE3t4gblPpfW+ryjSEJ8m8zsztWaITCyXlIL
 XE42v5i2Z52BMbzyzSdewftH8vcTIOWAaoCBDEF58y8SMOUnp55zD2Z9pHlzmMrP5Idn
 zqxZ9X85JavHLzIFx1uCovnth//KkdugF0KlfkAPOMuDONu8SrWse7gVpy/H7RzzoeCC
 uXJtmIE92doaRIQE2tGJWjXOCljA/2T7Yx7hbLCPMNBKpPgKm++xdqXKT5XxCDtHneDN
 I9jUCPbHanjyFKdfHpCFq3FVPRI0DQ3O3ORB3oiAvBP+Nsh6eN1H4mV24Ruj3XQTfdvg
 9+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708954; x=1794313754;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oY6KSS2cMRNMRm5D1q/IFGBHxlcNhPbltxvhcV9rZeg=;
 b=CSnPp2rqNEnHgdhh9eeZo6DJLGhB09a11QjukTmfJRh+/2XnpP+YR+Rulspc5MFp+5
 FkKCup8+ojZiO90/sBcDqJZlxtZLa6BU5MjXZd8xIMjvbInzMHkxipjFi94pZwbArWGN
 PqOu/Y6I3t7ujjx+VFxLEXOghSLTxdWDib00Wd0VOmdtXtIiUFxL5i0xYje8jNiqMj8B
 5rEhybFKkIEb+H1dOz6fGyLQjpQnJvfCj/y6tCHdW4ymV4C+W/WLTD5rxXl7iucd1lRC
 u4G5QlXAnfB7BubJmGbAIw8vcLnghzm62/j9f9rYVnH/pTDLKKW+kX2EGf9l5Xx8jpVG
 vhKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWmuYXrY5RwK4DifDkAFeDm8FYxnKJkTcIuvnXBDPRB022x7y4d+gBsqZyqW7SoUI1JMOgxbYTJs8w4HAB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8WSkepx8VMsFnoHsqb+XIHZN70KUn3/s+R0w6Q8XjNCvUBnRv+
 WeHETFFNhLDXxBQJwLhKPRRNQTGIWS9V1AravvWLX5GLlAV9Qzk37Lgn5umSGj6/cjvaPywxAos
 C97FV6+327MTTu/oFQyGkGHIwy4Vw1n9hEmalmA16AHaxwNCsjJHMC18HP0TKl1XlG6Rg
X-Gm-Gg: AYBFou3x0UvEyd0p469rKU1neHzhpl51ubHvF/JidzAuubZGaRTvdJgeuL3vnBVSodZ
 AiapAoq96K/3sdpEUzOsI2pXM5LPpKssKTfIP50PvhagEzF/Iry2qTcu7w5ZmprUHbSl4S5rAgL
 OXezfZkz6oPHg0mqEJuOfqG4bqcliiFpuYmVg+GO3j9tP801hxUq5/IS3ukuy0BxOPzoDV7zVfk
 kjwb3khSpPBEyqLQfS2rtm7IvU2moFGs9cutcyJvOPq2RryykE3PnqzeDVKY0nX2XEKMT1KQmLA
 Nrtt4SRZ8RH1tscagJqbY12WsXntPk5DQAimfuBW2NfWHIMIOlVrd1E+Z1GAMlwdOhhK0k0sKm3
 O1phtaeFJkyPSPIob5TFHwKXRGCRUn75KlOO8bSqkZixxNzVfKys3EgnaEG8YSGqjyg62bP9u6K
 /QnF4q30gpes+/2WzUVRpQBuWT8JoAY0l6WT9jrcIC7XJmoIduGf60xiSC/uVEYF0YGiDjhtJf9
 fODVYR8BhHyUIl2DVnY5s+4SAvFXVWW5EGnycRslzvJawH+e4OIr+UPu5si28+Ll2SEq1r10pXY
 IEfhItpFRCBDzkC4x0cyTlZX7jFctTozc2RImSQOK4OdFrhD8SZAgC9ACFUSKzLo67MtWUgQ1eI
 0LJhu+sjStAwq/vPaRI+laoAncm8RtC0ZQR2tF/sihnR6lPdAIITcsSX4jRn7NKcTr34lYOGzL+
 Wd5Pr4DxfKHuzUf6J6BBbObwT3E8/C7nWOzC8=
X-Received: by 2002:a05:600c:6095:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4ac182dc30fmr261096565e9.22.1793708953479; 
 Tue, 03 Nov 2026 04:29:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa38bb4asm53649385e9.6.2026.11.03.04.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:29:11 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:29:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
X-Gerrit-Change-Number: 2103
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2103?usp=email>
X-Gerrit-Commit: b8db75ff7b316b7f58606f1cef9cfa2d5516de26
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 12:29:09 +0000
In-Reply-To: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
References: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjk0ODg0MDAwLkljN2NhNTRkNGUyZWM2Njc1MzJjMDA1MmYxMTBhYWYyZTlhZDViZjgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d5e018690e213474e9b3624a3585de2689838dc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODdg-00000000218-0g8t
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_epoch: wipe
 key material with secure_memzero()
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
Content-Type: multipart/mixed; boundary="===============5635360042473042126=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5635360042473042126==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1XY+6bbaKa8="; charset=UTF-8

--1XY+6bbaKa8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?usp=3Demail )

Cha=
nge subject: crypto_epoch: wipe key material with secure_memzero()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
03?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic7ca54d4=
e2ec667532c0052f110aaf2e9ad5bf82
Gerrit-Change-Number: 2103
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Tue, 03 Nov 2026 12:29:09 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--1XY+6bbaKa8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?=
usp=3Demail">change 2103</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2103?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2103 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
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
"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 12:29:09 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--1XY+6bbaKa8=--


--===============5635360042473042126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5635360042473042126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5635360042473042126==--

