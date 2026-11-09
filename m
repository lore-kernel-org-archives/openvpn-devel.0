Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16AA606A321
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MT6aqc7Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G+ED++Ec;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H2J2QdHI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PlErVYpy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HiJSBhPhI1SX6W3Ccx8zD3lbT0dojlwN1vTRYyEOhxg=; b=MT6aqc7ZyKRu33p99CnianDfIv
	tnXXIL49ANTfKDUP0bGWyK5i6kl6Gku5BLPnFLRChakNuCeLDsyTxx82tyVmzmXYKFb4yO5zUYOPj
	bmcxyS3urnWlSyersDrNaUIMSpyGKgobtGTLk3Lvg0++UPRCrtaaiMUBiPjigSphLEGU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQOsw-000000003yr-3Jw9;
	Mon, 09 Nov 2026 12:54:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQOsf-000000003yN-1ie4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LlpUtNwbbOBbAXHev2ppOxZqN5kIfZY2+6ym9AQukiQ=; b=G+ED++EcKxYo42z5NdedwYooPI
 m2LTn2zpAyJvlAaZV1FUi00G1+j4rRKBrPl1BHL2Or2pk0k1ulbYrZJcvnf4lTKorKN/RwdJlairo
 X2+P796FguzyKimsweXXWgsqxBqfBChL/yBGlVQ0ZZFWsyHgjz9Pe1AVyKqgocXqNxls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LlpUtNwbbOBbAXHev2ppOxZqN5kIfZY2+6ym9AQukiQ=; b=H2J2QdHI4ZNJ5rCWF9KoqLx2+d
 jcMgxai5sSXqgvDpdpj4DkzlGaA56OBAqhgnCAQL/I+x/Xo16xmRK+2i1ipQB4BhCSkwIta1FMcpP
 matgilcViF6op+1KAZb/Cr36yQj7v1ku6XsZup6Xf7r1Uaq0fO4tRCVideHRBM68SMeI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQOse-000000006gW-045P for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:53:49 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so673052f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 04:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794228821; x=1794833621; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LlpUtNwbbOBbAXHev2ppOxZqN5kIfZY2+6ym9AQukiQ=;
 b=PlErVYpyJIveDNkYj5T9oXv1Hb86oQ48aVE6MTpvbzE3fQWo7lJY4q6ClWdbEB0m/b
 ChSekhGd0pdHNqdQcBmy2+c8eNj8hiENHaaZFdSVaIljEHkM6kzDMAFyHpyOYV00gvYd
 wP8pxnPcKIml67nE0SkWyEX6cq6XRU1oAXKk7e38oK2VmVgdGM0S3/MvTDA46BZQ9MAK
 YdGnKsZuS2tVHpsJswH5ztX+OMHLxMGdXLH9NIYO9PbB2yqLYqxNONiJl7Wb9R3xzkuA
 RZZE/kKMJKWII5GjgOu5SQ2c1AT7HDlVUnlimsqt7RsIXomt0fFakirQ18BJhfiwg0Wx
 S7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228821; x=1794833621;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LlpUtNwbbOBbAXHev2ppOxZqN5kIfZY2+6ym9AQukiQ=;
 b=AnBUCEe4vXxcHfxfNLfliFiZ/Erd8APcLT8FtW6lJ9tY4To77kjytI6Rj1lU9Q14po
 3BllxE1jtmLXXd3cJrHQGDRQvNb0/QBp60BJvDv7012lqI5jg8npPG2CvjGblMe36+B1
 0CQDujqxBAVyV931ngoIEDGBMsQfIaKXHU9MXgU0h9YAHj9LmNqm5cCBTv9Xku5tvUFp
 hLYjco+BaUeu6j+yFnSexFlbWg/Blsjf94GVfRlZrfz9ImAJ9gmXH9CMOxqqBnwrvG2c
 hM6j9NoWmjIEnsK2B+LyF3xMAcB+2oJuCFjg9olpYJOo+KGYQSzSy2WD8DaBvQDBT2QI
 CNgA==
X-Forwarded-Encrypted: i=1;
 AL+hErGQvNddPGX6f+Y8WBhw17nQtwunmaKQPujfonEaF7cWYWM7chItPq98xIFfVgau2QqIs2ViRWkLKeGelZll@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+vVewll1+BISrVcHDeL51Z8nV4YYURFBwhfMIa38MlnEtKsmzp
 qYzQWNaDTFPvFKDsdanATQu2RkQ0m58L6kO9WingBWg+xtE4t1KwjznTCMxenRrXpcshNqcKhP8
 7g3aFT4ajaS7OSs0lyb7FXkOAnlvH16O/riPc/HiDSqvCZp1zFDQscutcz1ekXs4gGAI2mRUPsF
 2ByRKESw==
X-Gm-Gg: AYBFou25s+udaEmiLGs52foePDfYAFTf8xbllK6TiKM+y6mExDeh61/hnQ1AeohpgWW
 PayHckulRimlPTms9XTKFnfcRk1zhawk9PG+0NI4/uOlJliZLdZ5W3kCa2WrQecyLs40Ea3ccNC
 UuzZEhBtSX21f/YCJtwIGZqccV3uaQzvdJDsjwXdh5q6SDaS9fwTD3P+mFdy9P91a0JS3C3yt4b
 8Uxdk3lM899+3khJYWZSQSHDVfPWrotFrJMg/Ehc3pdRADe1pvZkYlRLnryNvMy5dfHUhXzVgsV
 dHnHY3IxJwv1IJO8jZQpH9sXMYTDHnYamjDG84cbLQrr8aiQRyFb6BJQVrxJOvujzb+TXAgRPwz
 qraJipIeAnmH2WGJuEH3qXo8gOVOYNCJn0R9jpZ4KSXqCsSR7VJ8QflSZ3DyxvSBuiswGubu5ba
 79ihSjdo1u8tKTqApU/Voo08D431QIb8PSCHDqjUwuSCk9yNYKmvDw9cT+cMyLPABOm6K3mJtxU
 BxUxLQwtg51SwU8f2SvMHhcJQzg9l6CdrMvZ72BNIPt04FBKf6Sy4EEfgX6MVTNLp98DgaKBarE
 sgZjW24BkCgeYiidJSCOlvamifVu4lgZVFrkSvMud2/FgZpsCbpvGPzpkW+5zi908c9038z2hBg
 byI6kZUPFzFp01Ily6+WvNYYP2gYrbkhK0RYv9BMA2BvgX3RnNO8gbM3zx0mHKuVKZsUYvXMV9a
 udcZaBy+l/LiKQSw==
X-Received: by 2002:a05:6000:220c:b0:492:aff5:da4d with SMTP id
 ffacd0b85a97d-49422f09ec6mr14425921f8f.7.1794228821236; 
 Mon, 09 Nov 2026 04:53:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495b90701c7sm12194870f8f.10.2026.11.09.04.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:53:40 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 12:53:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: 3eba815527c82563ce47b123e60207b0a2b9aeef
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 12:53:38 +0000
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7cb10d7e570d1852b42f0facb130de7860bf07ff-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQOse-000000006gW-045P
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Check the result of
 unchecked allocations in the server
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3659456666527929226=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3659456666527929226==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="03COzOnSrGw="; charset=UTF-8

--03COzOnSrGw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alexandre Laroche, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Alexandre Laroche=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail )

Change=
 subject: Check the result of unchecked allocations in the server
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew-1

(2 comments)

File src/openvpn/=2Edirstamp:

PS1: 
This file has bee=
n committed accidentaly=2E Please remove it=2E


File src/openvpn/ssl_verif=
y_openssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155/comment/a14=
12397_6b6c7997?usp=3Demail :
PS1, Line 327:     check_malloc_return(buf);
I=
f the certificate's SN is 0, `BN_num_bytes()` returns 0 and the code calls =
`malloc(0)`=2E Some libc builds return `NULL` for `malloc(0)`=2E

`check_ma=
lloc_return(NULL)` would now abort with "Out of Memory"=2E

Before this pat=
ch, this case worked because nothing was ever written to the buffer, so thi=
s is now a regression=2E

We could probably just use `gc_malloc()` here ins=
tead, which would not return `NULL` for SN 0=2E

Granted, everything aligni=
ng to where the SN is 0 and the used libc returning `NULL` for `malloc 0` i=
s not very likely=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2155?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
Gerrit-Change-Number: 2155
Ge=
rrit-PatchSet: 1
Gerrit-Owner: Alexandre Laroche
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Alexandre Laroche
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 09 Nov 2026 12:5=
3:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--03COzOnSrGw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alexandre Laroche, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Alexandre Laroche=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=2Edirstam=
p:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2155/comment/5d9c4ee8_1f483aea?usp=3Demail=
">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">This file has been committed accidentaly=2E Please=
 remove it=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/ssl_verify_openssl=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155/co=
mment/a1412397_6b6c7997?usp=3Demail">Patch Set #1, Line 327:</a> <code styl=
e=3D"font-family:monospace,monospace">    check_malloc_return(buf);</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">If the certificate&#39;s SN is 0, `BN_num_bytes()` returns 0 and the co=
de calls `malloc(0)`=2E Some libc builds return `NULL` for `malloc(0)`=2E</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">`check_malloc_return(NULL)` would now abort with &quot;Out of Memory&quo=
t;=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Before this patch, this case worked because nothing was ever writ=
ten to the buffer, so this is now a regression=2E</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">We could probably jus=
t use `gc_malloc()` here instead, which would not return `NULL` for SN 0=2E=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Granted, everything aligning to where the SN is 0 and the used libc re=
turning `NULL` for `malloc 0` is not very likely=2E</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/215=
5?usp=3Demail">change 2155</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2155?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2155 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Alexandre Laroche </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Alexandre Laroche </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Nov 2026 12:53:38 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--03COzOnSrGw=--


--===============3659456666527929226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3659456666527929226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3659456666527929226==--

