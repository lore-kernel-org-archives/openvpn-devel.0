Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AB606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NH/Ne2Ba;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WKomrF7A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A3phcN3D;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aUOqaoYx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b4P4r1/ruN2hJUkPfKWHYsNT7uaHj4Ax6m912g7jO/w=; b=NH/Ne2BarF9RFNaV6mrhkI/R/d
	lk18jOPofNVJGHMXZXPfi7s8eJ6t0Y/Pqy82h8OSc5buAcs3odPqK+XzbDhO+bs3fHteJzTSE5ALC
	UYL9XPL/zIf/RlqOCU2wFsP9NLm64NhZiHhpMd6xguNSTtjWHlccADo+xhAEuTIfoWqc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQXKe-000000000DG-1IKG;
	Mon, 09 Nov 2026 21:55:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQXKc-000000000D7-2rF1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:55:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=psxkF8Bv/DEFFThZsdGPJRLl1zRwqtggY0vNSCcV8mo=; b=WKomrF7ANCneff89vMr5fbe4uP
 kZfUR2QVK0Dbx5uvy46IPTVKH/yJaoM9RS7e3s/e+0eKQtGWe0YorwHngOD0hHFrt5j7qzOwln8vo
 LyjHzVvkU41+19LJJOqLOY0gUFyE29Wik5vkPvzi2tCjiFp5A6gEuJOV5Auze0+yC7ig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=psxkF8Bv/DEFFThZsdGPJRLl1zRwqtggY0vNSCcV8mo=; b=A3phcN3DQtrUFjoGMcm4CwkIBT
 nCIwUvL9V+dpMw6PqTRpmZejtFkjH+VvEXV4kojnPSf10hvpVVZhyEGR2gC5B4A2/BAKnE+KLzWD0
 flpZXhZCIVVobR2s0Y652dLSVDxxI2Li/1uRtkSqltzHosM+Hmfh5UPBvFkfqEEJmzgA=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQXKa-000000001as-1Sqt for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:55:14 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so12959225e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 13:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794261306; x=1794866106; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=psxkF8Bv/DEFFThZsdGPJRLl1zRwqtggY0vNSCcV8mo=;
 b=aUOqaoYxzV+Mggv44uQLO6s0Oa02HWdBAX2GK/d/AbVZ4U82xMjq+mNvmQa2Wqd2C4
 +4tC0BtXKiGVS/vBBWA8XqvcLLqIWe2rH6A5ctGEsOmo3NkSA2fyw1/XCFT8SHoOnuRr
 ES5m0WrcfuK039N8WT+tuxeVT8j3osjFFXzBarTWeLCunM4N3cYGv8OQX3W9ORDO7sHu
 FDqr5OT6prZ4mP/qlMq3U8sD6OSP1GciCs6HnxKbywusGcnv8HDYYnHRQaC7yKt1KV6M
 rZPQqa96fvbthtN/6Q7Mn3qJkNnPS3JQVwnA/SHbQDdN6HNQaFfnk/0bUSO8+fC829Jp
 2GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261306; x=1794866106;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=psxkF8Bv/DEFFThZsdGPJRLl1zRwqtggY0vNSCcV8mo=;
 b=o/JtSg4rWks4yIc/v3MaysRvlTNu2ZO78tUDbwdu8tTszLQJkjU+Upok5B9Qkguv9F
 L7sXj4Dl64lx692T3mx0BaJVnHw8YrNgxLGfSi9ct/koDPvfhvv3Hh3hbScHEKe4bn4/
 i1CEWzgzRIgxHTwwKl1Yda0Oy4y6R4FqvUiFBOULk8MAKCfI3yH2ATquQa4rx0Fk2Vy0
 rtaJeidDvuzYi1qjxHqxZ7BgiqiviEA7zqWqLzmla4ZOXFsX3sDPSHcipCZd+UzeDBYA
 ryMt81wCABumTNGRq0op2cemZzH1lcDayk/ATppv0rfVbPdbZy3PihbWdy4l4cD58r/a
 rT/w==
X-Forwarded-Encrypted: i=1;
 AL+hErHhfyZPkWZX1fovsCfTsw+jz2i6QiVisIIpApmQPVr1f2pvf3266Ili9a48JooXV7ZRD5bEDFdnSpS+p0Oj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z97sHupd9rfKb0hRIkY8UM6Pu2Jxd5yqvljkrkBdpg/bdb5RDib
 knWCz7PBeIIMrD0MVnPgE8I0bIoq9RhJyyvxbfbeEzheGwkkBIk1+kFkPVUL0+PibKsw1QxVfko
 mLWI9odrBlk6I+EHs2xr4GvdyB9Lsnr09OaNR/BnZHWXzIU5xLTMunGNNMwQJPci6DAVZzElHKt
 03oI2TqQ==
X-Gm-Gg: AYBFou3atO9M5xq3M59MWm48n0GW9WgTVUkmv9Wz1kY+MUQF8KhHytMgkbmY4qS2PHh
 yzPdjdwW9jPUdQPkSr8RdjrGu531Q5ESBqkEgoOTcHONWWlEnMGmaX4KwXQk7sgseBJWdauLga3
 1gU1dIjwzXycW8h5KUm0/e+ElYB0M1yod2GehbCmNXm9ksAxYWfzcBTzCmcaxRrWgNMArjpuJD6
 fhWGMSvhZdGed7MqMksxFyzJcGQ9o1my7KFb3EsxsFXkm8TjJ1hwk6xLwaJdNwzOuNT9UQpEeFR
 SJ9lWJMKgVO3urb2ZpmfTWLDy1mZteXFr2Tg1NDkpj2R8k3iQgXLKZ4x9sOG3SWk+zy1Q1lGCuV
 NMN0I4GYVqoJr7C9F6FlQw83bvhe7cClWKhehpUBRHD/h8DyCIZzLZUXXHt65V84fS2duiHa1Lu
 jP7XzjWj4Vfv489h4Nx4CYjMscGRdpY87gzI2g6JrBy8LWmTHtjj3yjV7PcUNthLNKk3nNJdCgn
 a5sS7kwL4zy73AOujTb8jaLwJb4/xh/gpat7U3AtHAs47l4/TPQk56ldWsVTKjgIStmKWBminy9
 +NRpbHCWwpH5XpovXtHw1YM3Hp5PCeZlvf6WjOyJTE9HzT7MIgWJmqZN6Oz5N9adcjPoBVv7SP4
 RuexeEEd85DBZXeTIqO04VjNtRBju7iIoEs89M9BA1pWeg+TDTO2AwVEEgFXsx/aS8qCNMLh8bO
 qhpRjT2CavGYwCeqnxn6uq2gl2qGlzHwr09Fc=
X-Received: by 2002:a05:600c:3b93:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4ba02350566mr8233165e9.29.1794261305631; 
 Mon, 09 Nov 2026 13:55:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm1137207f8f.49.2026.11.09.13.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:55:05 -0800 (PST)
X-Google-Original-From: "Laptops (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 21:55:01 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
X-Gerrit-Change-Number: 2035
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2035?usp=email>
X-Gerrit-Commit: 45f87821413653b51161c188436baf2526db6acb
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 21:55:01 +0000
In-Reply-To: <gerrit.1793032811000.Ib57d973a2f8ef48c3710f7d034da1a91c64d4755@gerrit.openvpn.net>
References: <gerrit.1793032811000.Ib57d973a2f8ef48c3710f7d034da1a91c64d4755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkliNTdkOTczYTJmOGVmNDhjMzcxMGY3ZDAzNGRhMWE5MWM2NGQ0NzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b1f7e2e9816bcb69b758cfa5a4505b45832a6420-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQXKa-000000001as-1Sqt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: add optional
 -fbounds-safety annotations
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Laptops \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: jeff@incrediblybased.co, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Laptops \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3812311988449822278=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3812311988449822278==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KwqUN6aEtcg="; charset=UTF-8

--KwqUN6aEtcg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Laptops has posted c=
omments on this change by Laptops=2E ( https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2035?usp=3Demail )

Change subject: buffer: add optional -fbounds-sa=
fety annotations
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1:

Hi Frank, Arne, now that the restructuring in 2034 is m=
erged (thanks, Gert), this one and the macOS CI job in 2036 are ready for r=
eview=2E Both still apply cleanly on current master=2E The annotations are =
opt-in and compile to nothing without -fbounds-safety, so default builds ar=
e unchanged=2E Happy to rework anything=2E Thanks!


-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2035?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
=
Gerrit-Change-Number: 2035
Gerrit-PatchSet: 1
Gerrit-Owner: Laptops <jeff@i=
ncrediblybased=2Eco>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Mon, 09 Nov 2026 21:55:01 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: No

--KwqUN6aEtcg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Laptops has posted comments o=
n this change by Laptops=2E</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Hi Frank, Arne, now that the restructuring =
in 2034 is merged (thanks, Gert), this one and the macOS CI job in 2036 are=
 ready for review=2E Both still apply cleanly on current master=2E The anno=
tations are opt-in and compile to nothing without -fbounds-safety, so defau=
lt builds are unchanged=2E Happy to rework anything=2E Thanks!</p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2035?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2035?usp=3Demail">c=
hange 2035</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2035=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2035 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Laptops =
&lt;jeff@incrediblybased=2Eco&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Mon, 09 Nov 2026 21:55:01 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>

</body></html>
--KwqUN6aEtcg=--


--===============3812311988449822278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3812311988449822278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3812311988449822278==--

