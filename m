Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE45AC5DF70
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CH3PEqbySUrzmy4ozW04Rsyg9eWzt3VNnTnBAhprMKE=; b=dpz5H66ul0RmAwHf0XpzwFoP/s
	18a7cmwInUumJSv3hqXGq1grq9he5icUoKzG1d0AMYSuO3ubqFABsBNeaKVgKKxngNFzWdetwmKWH
	PHL2okxrHp9MUfwvT49aaBmxNkTHxnCELBwEvTPmblOvLWlVNFw6BR9MppCpHuGGxN4k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvupU-0003Bn-29;
	Mon, 17 Aug 2026 10:44:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvupS-0003Bf-5Z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 10:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2PwM0NZ0n0zF0UiqSMA1CRh70SGqvr632WeSsfNZ2j0=; b=R3GWO3c7QwsySoGaLIfz7j4SYz
 tzBwHAhkfX+0mGbN8f5z5cKyStn94yyZ9j4HLDcHXR9Yk2qYOTKRbCuhrdfSx0imY+xycFekXKhW0
 6exjHG3Ubbqaz0ezhxkFNrTtNmnj6OmoIet8LAUDITFV2GwcExTjr2eivP4lz1jk9V7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2PwM0NZ0n0zF0UiqSMA1CRh70SGqvr632WeSsfNZ2j0=; b=W
 9zttar/JxV4pQB9SgP/GIWqHppgXGLGUv8I6rtl9eopw6rDozO/utgbTbmRr896RUuJo9jGLIfdUk
 nt7OeFpKzRa7C0UUFsSQ5dOKBimhD+e+nQUzSgtUUB2IVJyox2cff3sHkaN5uK/64Df9OKNGtpi7Q
 vBqFpI/nROP/lb/c=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvupP-0000mN-9u for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 10:44:30 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so30074195e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786963461; x=1787568261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2PwM0NZ0n0zF0UiqSMA1CRh70SGqvr632WeSsfNZ2j0=;
 b=BnUmHQmRMGDnu8wXrg7SYzvN218qUxg1KmUErMDdP1DMRYpTiU7qOaRrhS9oimed9Y
 QOP/aDcV6MwF7ZoRcRoGIMTgX94xFuBF/gnmIKm1zqBK3zfMU5JNCdce2msC+8ijvUgI
 Iu8vVYUlKaepcqdgGb1+AME2xITWbEm4TIWtwClOPI7FvMmh0YII5+ykeNbIeMB22Yju
 udgPf7eC1wXi0yaBTpfHGXqJpY235Dx1Yp3Z90FsAHdfagthM6+J5PtYkVndieylAL0G
 GN+xuhCKxPcmIs/CEsBGsKxMxHsiIza04jeMXWtaQSq0DG4EcKg8ASa4UNs2PZD9Bcz5
 hekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786963461; x=1787568261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2PwM0NZ0n0zF0UiqSMA1CRh70SGqvr632WeSsfNZ2j0=;
 b=fCQcksg5BgkrtQtIvmNIY3xmrwH4c5RBJ7ahRYfvRV1wqt3F5/PkT9hsvKo53sCaOY
 E2A6lvmmLHnMuIgrB9/EguRWT2gwnlxyWbe3aC6GPWt516JP+HnvvP5KAwLjtpx4AlSr
 9q0nA0yKxH8VSDTdd66MlLN1J0DwwYuzhLY0D0cj8/eFOEgwk/jBIhKVYTjMlX2nmrAz
 NX5Zi+zNYujAnD3bhOCiVIpADPj7I4uzsHVIKKBTqcexdcjd40eylN0Xfp0f1i8Y/yUD
 7Yc64j+82RfUn+b+UMVGu23CNhCYRqU7NICCuubEthcAGxhs57pJdFnneI7vJMGJY9cJ
 YYMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOvjlb95W7XVbyg7/05/go/noW003Wqd1q7tmgqWghNLv32UKUFWpVv9GqMpC3g4HdYsEd6z2HKyM1m6Pe@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzrtHm67Gf/uW7h5jphiJfLFN1xI8vsGk4/mdGcEvrZuBuyMEjx
 /nk61v+ImeJCZOoT1Nti7KAZz/DMID9rR/+ZxcPrR7vh9WCJRYMPtzBUG9KcMD/adwZ/iwOI8nO
 8momLs6p8j1pdb6AdeEGz0wC3Zmx7eue5kHF6ApQUVowTuhtMWRdFBFDg5TiZo0pTziEgvWSj41
 DAx4n4tw==
X-Gm-Gg: AR+sD113o/ZgeU8DAbPMSObp/O3u96FLhEgIbFjA7ssivXmhqyFVILyA7Yai35AsDQR
 k5ZYXMnia9wgV0xySFEP2Q53rHXxP6gEd6wOQjzcthlMnsdRMgEjUAqec4OPcU1YvgD2Jae2uzQ
 7Z8LNsGryvhRhhsPjMuPfFRQw3ibKHTCQjn2atXFe3fugLpd6b1Msc13zn/JEObRa1NMtOYNOvv
 GgVIvmF3YQOxGiB+YqFqsihHhsGCalVrlYWzlK6dmjdaf46jQhcwDUnSL/biT4617tKk7eEDZHQ
 MDz5oPowqSDRhsgKsir+7UIca/Hfpj5Sq98/D5J1tFb4SwFhQ0z1Ejcd2EOlznVBnkwfO/jBwf1
 dLJlFcH/xHDvWhDuHw2uzazHSoZkCuFhyXxQNevmSlsbi3pBC1AnFENLjS5Avx2y+uX4YyrxrYc
 rieZP6/55GJIHB/Z70sQO5T7qgwFXojCgCgMBApyrJgP2m/m33nVjxK2yMU5ECiZp4JdjK4ARTc
 ypLkjfQ4XDgt1Fdfrfth1qhr2JFxkO3CyDVWKbsF1EngU12CImw9TvAEYckkkduECx9l7Lnv26w
 vj+1MdiCVTA4sOsJ9QPhBWXmRxqzdMwOH6wuHKRUXqjFFxprNw8=
X-Received: by 2002:a05:600c:c165:b0:499:4892:d022 with SMTP id
 5b1f17b1804b1-4998795bca6mr418097845e9.8.1786963459652; 
 Mon, 17 Aug 2026 03:44:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b1a31esm282446805e9.2.2026.08.17.03.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:44:18 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 10:44:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: 929f70e5dd6518319e1348cbcc6cadd719bac374
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 10:44:16 +0000
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <237ab6a3b16f2a573bcd1aca0fd90d1066a7a552-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvupP-0000mN-9u
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4601978714927446310=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4601978714927446310==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="opiS5cmvPt8="; charset=UTF-8

--opiS5cmvPt8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1773?usp=3Demail )

Change subject: options: Factor o=
ut options_string code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/o=
ptions_string=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/comment/=
dca28b61_5f2f174d?usp=3Demail :
PS2, Line 24: #define OPTIONS_SHOW_H
> This=
 looks wrong=2E [=E2=80=A6]
Thanks for catching that=2E It didn't cause any=
 compiler errors since options_show=2Eh is only included in openvpn=2Ec whi=
ch doesn't include options_string=2Eh



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Gerrit-Chang=
e-Number: 1773
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-=
Date: Mon, 17 Aug 2026 10:44:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--opiS5cmvPt8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/options_string=2Eh:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1773/comment/dca28b61_5f2f174d?usp=3Demail">Patch Set #2, Line 24:=
</a> <code style=3D"font-family:monospace,monospace">#define OPTIONS_SHOW_H=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">This looks wrong=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Tha=
nks for catching that=2E It didn&#39;t cause any compiler errors since opti=
ons_show=2Eh is only included in openvpn=2Ec which doesn&#39;t include opti=
ons_string=2Eh</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6824058fc9c4efd4=
8ceeb32d4164f97b2a243d85 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1773 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 10:44:16 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--opiS5cmvPt8=--


--===============4601978714927446310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4601978714927446310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4601978714927446310==--

