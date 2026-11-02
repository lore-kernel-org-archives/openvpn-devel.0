Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729F60A2603
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mTREiCmX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DcCHOQZU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YvPmZZh0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NSqk27GB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LKH7jHwzsVsd7uCSYA9xzvZdAJAaKhJVUoFZETKUzrs=; b=mTREiCmXElc3yIokhT1CMRcjLZ
	V8RXNeEhAUeGZXu+N7Kb2lnvtH7ja/oVRq/scmUHFCn5NAmqpkGMjXmqoFgXTnAT8NKDS0XzQVclZ
	VnDBCkhjAY6BPpdH+L3xYp5MniAn9k+QAvN2a+2fwZKS/qiQhO15KT9rFJBwlcp19SWM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNryT-0000000066z-2P2p;
	Mon, 02 Nov 2026 13:21:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNryT-0000000066t-0Oo6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lk0uqeCmIFM5D+INEBhW7qiXrDxEkAZQTMyoq1LuRs=; b=DcCHOQZUcVKSxXkzSY34CzHeht
 xLPjs/JcN1LAzZgWwsnTvrTu6CAVFKvmCKyi2HEP8yLiDGBtfp4rGzlAU81vjCkSI3Hued2/O4YCK
 mOqvfIpd+99P+WEMzs3CtB3NKrpGppQgsFVKtURSvIbPjv2GFngqoAWU0/bbLZ1hE4PA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lk0uqeCmIFM5D+INEBhW7qiXrDxEkAZQTMyoq1LuRs=; b=YvPmZZh0s2JQHsXoRScUhjEtH7
 JZun2LB3RIBrzteIT+yMNWUdjjjFi4A6KhQbVOr/2h8FNf8imn9nmmkgncLnLJ+7nwVr0XXp7FADV
 QxZKLjicR6BvSOeMCx1cP+b9/WOB1EcSTIcBZBS1l43lsuQWGi31+tN3X2nuwuDV1u8Q=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNryR-000000008Io-29pr for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:21:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso23457405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625673; x=1794230473; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7lk0uqeCmIFM5D+INEBhW7qiXrDxEkAZQTMyoq1LuRs=;
 b=NSqk27GB4CQfENiOzj8UDRG8cYdeYeDEA1LNtew7LeLnOce+Dr9vXcXWb637HpVX9U
 fiv4GeoLi76+r2Sj7PGOdr9Mif2rSGgU+lt6ULPA/Sp6VxDcl8IuBkHf2lYNOrpk8wzY
 jWgy5A1026GZOI4r8QiufastgS7+QA4QibBPcEIuA885sYAV1GjkRhKv2G6EU/d39LxG
 Fs+9ZjjndqO/VN37NE7neNEI0+1tpgekp/+rEzIdy77KNS9fzNSv0T8PvCh2QFYdA9Hn
 kdmQ/PyPo2YilZ+ibfqMf/BXI+nmN5oTq5a5Mlg+2EBfYJoin6lMEsgCHJ5PxhTKJRN4
 Sl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625673; x=1794230473;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7lk0uqeCmIFM5D+INEBhW7qiXrDxEkAZQTMyoq1LuRs=;
 b=E4uEsGcORlQI6ALx08URHTkgSyjzszU4lVZavg8HgZIDObX5r3fb3NWYEY6z9KgyYl
 CIcQj3JnVzS/YG9W0sNmgXPeKr3/cNuxudX4/h7iGFJszEzwZWHtLkgtr48IQ4DO+l+z
 jCwU3wM0DlX93li8KAPmNxBnSVXRdq1kykRCDXLqTRvcgoQn9ZpjJ67ZuvcjuXuUhXEh
 k3IIIXmjHauiI96/SuLuK7WQTIkRjxqNFO0JASOcaCPAajcC9jQBnsoxhOeDHp0xKRiN
 SbfIHCY4+UtScOV20rQSzvU17lR6mg1jyNMIVVYoqXiJQHl6h/TcxbqFNUeeD4BTXSS/
 mhNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxd1y+w9frwhz6b/XH4dMQ3KD85Jd/AbkJ/qlQpSUYU7Koc4PnDnnyJiX3YP6SQGVjcQWIpSNxj7JzPh1FX@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLH7h1aNLxaMf4v9a8FBx9zC6AviWQrj7iitS62dYOjAOZ6Mmdq
 uOQLew092sRyzz4ZpTCPgJp5XuC0QMHZr5yh/hzVtSP2NJ0g7s1Wcnrxp9VgCApCAdAdDpqV3Vn
 H3E55tVwgEMd2+5SKWMHGubG2cAcm0qkobFglh7m8M4zMotDk1ADpbY+8xhn4xrrDqKOdvCbTpQ
 WVQQa1HQ==
X-Gm-Gg: AYBFou3XZpNM6ZsGWjQyhXHjSP3uvjFEsWgt7hbYtByALv32/98tPYlsfd04scEzuzz
 Nu5w6R6hKtVbHIAyJxt8vb1HXNUDObIIkPH9vIdNuVFEyuQq6KqWla8tF3hyDbj5DDXhHurMllC
 3V2It2bLd6bJY2v+FKvzUYBE5tN30aOazWRaDCoHlCx31BSt/eSOKow9o6I6yJxsVLJrR7crZwO
 Z5WeSi9yChFPLTPU/7DaKuHn0fM7KswRt1p0/nJ91h9jsJibT4Rx+uks2urozwkvIe9iCuEoGpS
 F8X3QNRQ1ZgfkB0ALFERjkukc5S7ber3ELZs5FmuhFmSydOjHJANNxYrmE6F5zkRrFPkcEnirYV
 ftPPp9AH6wGxVBwXb2PtIUoKGLtJPRP5SeR1HT6mgIWzo6nJtKacUqSf0MHTPJvCS+r3cK22y5V
 fIjSWTS0s0pIHK5hoL9bYQ5QcmVIcgUR5UE/OZkDg9KhoQLVD7SBWFMhAlFDfjf8xtIBgYtQi0D
 OuPM/hT6rVlvP4f7SliEL2Uf7QYXSRzHBA/spdZvsmb3tlfHPTIi1kscp34riHIXqZI/+OCl+5d
 aza8jvoSh2UjOiTnNCDH65YJLv+eqQPDfKtfDZjuFrSAWQQ79/xZ7rOlfHNua+/2ceVs3wS84ZT
 MwAIrF8gLS8svbkT0+Mg4kywXQfGcn43p6mJNxRpAvqKZlbuNYakd/XVBPB3zQz0OknAojrpYgm
 NOO+082ALb6TAh1Q==
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id
 5b1f17b1804b1-4ac177539f6mr220599585e9.17.1793625672814; 
 Mon, 02 Nov 2026 05:21:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm350382485e9.12.2026.11.02.05.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:21:12 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:21:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: 8191543f128ca4c29ac7f0806663132bead3d1ae
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:21:09 +0000
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7771a1831f9e23b6e8907ae39306f453fc2d95a8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNryR-000000008Io-29pr
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Clean up weak key
 check
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
 frank@lichtenheld.com, steffan@karger.me
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3590991454133963499=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3590991454133963499==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wRdMO3zRIDc="; charset=UTF-8

--wRdMO3zRIDc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Steffan Karger=2E
=

Arne Schwabe has posted comments on this change by Arne Schwabe=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail )

Change subject: C=
lean up weak key check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/crypto=2Ec:

https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080/comment/1d8b74b5_8ca3aed8?usp=3D=
email :
PS2, Line 1680:      * not a compressive check, but no valid key sh=
ould fail this check */
> Comprehensive ?
Done


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2080/comment/c9cd59e5_e9dfda86?usp=3Demail :
PS2, Line 1=
689:         msg(M_FATAL, "One key in static key/generated key  is all zero=
=2E");
> Not sure we ever trigger this code in response to external input, =
but in general we should better no [=E2=80=A6]
Yeah it is better to use mem=
cmp_constant_time here=2E External input is only TLS EKM generated keys and=
 there might be a theorectical problem indeed=2E 

The old code didn't do a=
 constant check but I don't think that gave a useful side channel attack ve=
ctor since this check is only done once=2E



-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit=
-Change-Number: 2080
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ste=
ffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 02 Nov 2026 13:21:09 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Steffan K=
arger <steffan@karger=2Eme>

--wRdMO3zRIDc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Steffan Karger=2E </p>
<p>Arne Sch=
wabe has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Change</=
a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2080/comment/1d8b74b5_8ca3aed8?usp=3Demail">Patch Set #2=
, Line 1680:</a> <code style=3D"font-family:monospace,monospace">     * not=
 a compressive check, but no valid key should fail this check */</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Comprehensive ?</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080/comment/c9cd59e5_e9dfda86?usp=
=3Demail">Patch Set #2, Line 1689:</a> <code style=3D"font-family:monospace=
,monospace">        msg(M_FATAL, &quot;One key in static key/generated key =
 is all zero=2E&quot;);</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Not sure we ever trigger this=
 code in response to external input, but in general we should better no [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Yeah it is better to use memcmp_constant_time h=
ere=2E External input is only TLS EKM generated keys and there might be a t=
heorectical problem indeed=2E </p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">The old code didn&#39;t do a constant ch=
eck but I don&#39;t think that gave a useful side channel attack vector sin=
ce this check is only done once=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">ch=
ange 2080</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2080 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@ka=
rger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Mon, 02 Nov 2026 13:21:09 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Steffan Karg=
er &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--wRdMO3zRIDc=--


--===============3590991454133963499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3590991454133963499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3590991454133963499==--

