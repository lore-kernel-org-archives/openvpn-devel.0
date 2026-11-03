Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A580606EE94
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=enP6E5eW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PtMro6v5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jy2s/C0r;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UnMTI2X7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VXzxFNZqXV1ufZO47VChUbbInbA71e/6a780qgEn3nA=; b=enP6E5eW7iDwpAaanQvRoiDCJH
	tM9Z3HreZRqV0qSbeJvQPUj6tiu+q66SZ5u1wACVG/oZ/1Jxrp8GUm+oDWq3mluuqme/nRR9/r//1
	6KVnzlONYS1REKcBi91ulK/ATx4kg6LaExyBRDMdZD3HxSRShyNrzlpTsgv2a7+VUiho=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOEYV-00000000650-3zAs;
	Tue, 03 Nov 2026 13:28:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOEYU-0000000064p-3k01
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:28:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fcNtq8kSdbT7bQyTMKQvsAg5sO+pzb49sK1EElRfnUQ=; b=PtMro6v5UAMj4mv1zpV0CZUqM5
 bsCtbFMgxaueKM3xKZrdpQdZKBM259PCPIG8ddDsFyB3KOBw1dSCQkgIdx1C0aSV902Z6ilzUthB4
 uENjBr0GjwiS7urT4H+JVxVGN0B7nQ6WnsFthkGWSkDKYN5FdSLgJNsKvy1D3jyQ3aCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fcNtq8kSdbT7bQyTMKQvsAg5sO+pzb49sK1EElRfnUQ=; b=jy2s/C0r79y76Bx1hQvxetYjKy
 ssOuEn5GfLdo0urCysiEKzhfOIM2VRBRnddvMstY8eb+2auoBw2nckzamWpXw2eVp1/z5Xb7bmxly
 pGRyG/AKkthx3ty4J9yy3ZezkN/jYIz+yCUL5tAT2lFCvKvkFULBrmccfUUO1IHnClbM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOEYT-000000003Ue-1rQR for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:28:02 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso34116895e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793712475; x=1794317275; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fcNtq8kSdbT7bQyTMKQvsAg5sO+pzb49sK1EElRfnUQ=;
 b=UnMTI2X7GnlNSViHvlKBi4i0iFm0QKJ+x7QSRgKlKrlLEbb9+xlxIPAuQX4RnkgqAs
 sSfv65MyaP++jFnUBRVqgBMrDXlN7muBrfVMDLw7ZkPmyyBeFsKFU1Rda6xI1p6vsjSy
 jYXHOL/7/IfZg6oF6to7CcqR4XGNG+ouGYhbz3/5RbzbCKRPUXVIJcZFbyj2Sjkb0bxw
 Ksq0SfUeq7tS/EdsPk3NgbqvC+XRqkVI7wwSnYUqQJdqcouNrn4jzpSy8jRQY/aQzcUf
 sPG4xEkW1K8x6AA2Y3MA9UQyW7exA6o+tZSB/9RiUNkBFdcjc59EbmyeDU73I6L6eJIJ
 puOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712475; x=1794317275;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fcNtq8kSdbT7bQyTMKQvsAg5sO+pzb49sK1EElRfnUQ=;
 b=XDd5JpkCpDTOhUGLLx2rbq+2o3tq6icda/lVBdD2I6gu7C/py8kPqHA+5mAkkdsYyI
 4s4ThuFr1rX3ct2p6+HExZ5pLpzbEgiUf7HcX+xs4Mvna+Ojq/0/MfUr/hmeXMxkeTF3
 sElCSoHj030ymGbThxogE/S7Bb1aRPt8oytjMWtarP2luUPNHl/+OELI9p0U9hkvKMUl
 O8T14T59RSnwfanY+gcdUk0CWKBBu/WBU+rIRDYpSUB+gmVtRYv5fDk/Z5PQuxnKnIzN
 FZgKmhBU/dI9sm9vaogiecb3truLKH1DMahuVN2xEtB5mCq67VqsJQHDji+dP/qdAFbU
 G3Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvByesohIu7tRIAWNwafSaA/B8Y1qoG9ohdAi1emFYA13B+JpCjx1lYzgeFobVuJ+rBray4dRVlnvZt0bSsnc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/e6Pp4Mzhf3/kUm68uyoD7SJRCLmtN+kDNqHROFmrpHvdKtxwm
 kyHvLkdUmobwHz7ObNj/erpB8fDLob8Iip2pvM89v7/JVPLkYM9El2EmtJxz+BAyP5loA4qiZZi
 +nnTmDjBIiMZv+EXWGqzO76Is+QVi8TBUokgPRQ5/QcFd0M/aI8/BrtP54gWl7pWWL4e+
X-Gm-Gg: AYBFou2psuIHaeGKW/63z7o/siaqbc3+1v9a9y4/5F12QR9tCnGpgfvnVe8NvbaWNYg
 1k5icHgVfkCXAZ2WqA0Edmahc5SBvetGTywEmQJ1sl1BeUE0XN0xVnBWLcuwQ2dA0ZhIByb/1e0
 zCn0uZZxFJ9/Uio3KANdXcOSqFH78fYdQuWXqizRWcRL9uamRWm4HKNjICwZ7Vuc3FGEa3Hbihs
 Epjh2wsoLFOL2HBFD2r2jhSbff66mOjjD0Rvs6sGOept+VMe67vKKAxktc0u5q8gQ5iRvBcdgwQ
 iqRWM8EMdNrxFYw01tLdXedWs3ALN0YI3T/PM/2bFcdIU5OSnK3h9MZIByXAyoPhKLVlJuX2Tgn
 h4QbNmu61Pgf5WGMWoIlfo0LRZdRLHb5VvJOiVC5ErLZCrLgp58BUDV9pc2iVphCHVtzHyFsZOA
 ZZW+/Rd1/zFaqZev5rjOMwkUEPb3weFw0iRAgsQnGokhn3K/W1+IHWN4DHwee3UbbqsyH5xG+rv
 dMLAr+zS1R0wmYDRcHWPA016eDRfICJWnVpzgCvKLSL4mhC7PbqNFzcTZbv/iJr3ba1hAAdcCMT
 CgbDII1UroEAKUgyp5njrLCpq2IkQmXjL/YgzAQcP/KOcJYvZzpYhOptYEiQUIVEjQIo/QicOsO
 yGrv0LHyMb0nQMWpHuOuTb9IX4DqQHgIWevarloA2Uq2NEHYSnNYldLIgOoBODtck6N8Q6QpIpQ
 mjuMeU+gBbY3Ykaw==
X-Received: by 2002:a05:600c:a012:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4ac1793fb0fmr296589105e9.17.1793712474146; 
 Tue, 03 Nov 2026 05:27:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78f95sm23530795f8f.28.2026.11.03.05.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:27:53 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:27:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: d6770048b77488747e40f67058e821c6ea13337f
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 13:27:51 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fcf31cca64c195efd76b761de55c3743194c95bb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOEYT-000000003Ue-1rQR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7568482314798479650=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7568482314798479650==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L1mBNgCUOt4="; charset=UTF-8

--L1mBNgCUOt4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
alf Lici has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openv=
pn/dco_linux=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/=
1d453ffc_9d0b4e0d?usp=3Demail :
PS1, Line 665:     int fd =3D open(rps_path=
, O_WRONLY);
> It will work on initial startup because this runs during int=
erface creation, before privileges are d [=E2=80=A6]
Documented that, after=
 tun recreation, enabling RPS can fail=2E


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1991/comment/8420519f_0e31424c?usp=3Demail :
PS1, Line 734:    =
     ovpn_enable_rps(dev);
> I understand and share your concern and I thin=
k a user option would be better suited here=2E [=E2=80=A6]
Add `--rps-off` =
as an opt-out=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1991?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I97c55e211f9113d090808724ab43cb3c94099fb0
Gerrit-Change-Number: 1991
Gerrit=
-PatchSet: 2
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Comment-Date: Tue, 03 Nov 2026 13:27:51 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: No
Comment-In-Reply-To: Ralf Lici <ralf@mandelbit=2Ecom>
Com=
ment-In-Reply-To: Antonio Quartulli <antonio@mandelbit=2Ecom>

--L1mBNgCUOt4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Ralf Lici =
has posted comments on this change by Ralf Lici=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><p=
>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1991/comment/1d453ffc_9d0b4e0d?usp=3Demail">Patch Set #1, Line =
665:</a> <code style=3D"font-family:monospace,monospace">    int fd =3D ope=
n(rps_path, O_WRONLY);</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">It will work on initial startu=
p because this runs during interface creation, before privileges are d [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Documented that, after tun recreation, enabling RP=
S can fail=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1991/comment/8420519f_0e31424c?usp=3Demail">Patch Set #1, Line 734:</a=
> <code style=3D"font-family:monospace,monospace">        ovpn_enable_rps(d=
ev);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">I understand and share your concern and I think =
a user option would be better suited here=2E [=E2=80=A6]</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
dd `--rps-off` as an opt-out=2E</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">chang=
e 1991</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I97c55e211f9113d090808724ab43cb3c94099fb0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1991 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Tue, 03 Nov 2026 13:27:51 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

</body=
></html>
--L1mBNgCUOt4=--


--===============7568482314798479650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7568482314798479650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7568482314798479650==--

