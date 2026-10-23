Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7355606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GeXzbMtr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m9JbtWWn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jE95aHD5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=e8wHglFO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kHpSapQ16YVzEg7wb+1UqcozC0BjC6LMPeMflQdhD0Q=; b=GeXzbMtrMKB6jG2/ElBaCgU1/C
	5nx0eqyGMzfVlTLmMXnR52teLDU7trzNTuEz7ZdwzhTmPJwxEDOf0BlzrBv8yL3d6FON+QEw+cYFN
	2IkhQNf6yI2L3PdHIgkCC1fyRmXjw/h/EWFD8NcOblorRpqGfeNyt10QC6vK65Giiwnc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xKK7E-00000000200-30Gy;
	Fri, 23 Oct 2026 18:35:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xKK7D-000000001zu-0jyK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 18:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1wHbWi+lf3XNS7KaYIj9wniwrYkvlmok2O7weBGohsg=; b=m9JbtWWnpT/1yICJfQZER/ELT4
 WMOW1cGY8OezdwXxxUCNr6g4mKUEjeB86CfqayPy9FMLkJTTiVSQVM07UX6Gz6FHei5AaB4rvSmds
 Vieec0aNjJn6vl/bZz51mctgKmbYn/1RcMeSmEbGw1MgTvtVZt2qz6PxrSThk8nR5zNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1wHbWi+lf3XNS7KaYIj9wniwrYkvlmok2O7weBGohsg=; b=jE95aHD5guJiMU73BgcXBVsvuF
 8/Z46b+Q/uEcrGE3Vfp9Uys0RhfO7JF7L5nB73BY+YGvJ9seX8BtxQNmSza+ZVlnNyz1vUDIEpkHF
 4wYBrfR4jYeqi30Px3w1CdC/ZcNhRXus8+sEAla+casPXGUopwVrvlkn6MKkf0ZF/aN0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xKK7C-000000000ur-04W4 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 18:35:42 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so8523585e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792780535; x=1793385335; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1wHbWi+lf3XNS7KaYIj9wniwrYkvlmok2O7weBGohsg=;
 b=e8wHglFOWTJTSm3Z/evMY5G2t6YfiBPMWzx4CNvc0FutGZOLKSvWP9Ru7htvduDte5
 zWkolEa8EnPNLROmJ3klLy8jW1MKKgHqE8OwhDx/esnGZncmzcgW/r0N5dyUNfxhXDBy
 PPsM5+rHbrgJgZlhNCyWtVpDp8YMD2rrwk8a1ijBvxT7wJGP223YSCJ3Pct024Vk3vjH
 dAn8H4D7aRWc0nRrP/7nIMups5Luvp0FpNy4tRs5u4BdP2lfwr7TeWiTb621irImPW58
 vpzIsfgexcqhvmF6Ncq8bfJc7wGReCwJTe1eLymiXDpTxHXN6jIJhHFfsMAC6gBINti9
 m7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792780535; x=1793385335;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1wHbWi+lf3XNS7KaYIj9wniwrYkvlmok2O7weBGohsg=;
 b=dGFTkg8cxfSLXQIovHFCXiSwEIyJ8G1987WCDA2KO2FyFiCTArEfuTUYzKo8YpCnbl
 4bMFYsYRQtHi71w4aoRbtQC946n9g7LR6WdUjXLyRxR+zJnEFwFsHAqvKITng0Y8R+RV
 stu85U0VS38lD0SV3HlmCDpZIHTA8S0Jbx7G35oon8OR5DzG0qOTGH9fTmCoj2TAcjGf
 k+sFhceVU+e6R1XTTLDh6WiGp5H0iMWlU66cMEXn4Ub8wbfrJFFhGiKHzbG5H4oE0SpE
 KL1ms46D7qDAtPgcbQ7rbPZE6xIgLfYrpMn2HBbdh1BZnymjD5EuJE8Tu8YJuMgeEQmo
 cCiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy392IAcEantfVUWWBKzB0QMG6fTTuOyJqNYBb3PHL5ZWSOJ4FtFxppCUkT9Hib3nMaNGz2JFaRiBEeIxe0@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLpFADgCyWCR8p6+uDdFP2e0CuSPrCGpvphJWwcWCxKd0l9+Z/R
 UiHzY+b+UijP21nytZM2sXT3BlpwjLeM4e3Jua31y4yiBIqcHhr+e4kwnhArpZm5MJx0ps2sDkW
 J5ooX91bq07NXzaqMfu8JehDgrh5Ws0aEpKWq4A6JNf4iMMGyXV8yKevsTe4Wl6VdP8fg
X-Gm-Gg: AYBFou2/rvE/jH/wCEd4DNRp0O7iLEFCM0jGJd2MpUvazB91tPNP4xQhV1LN8QEpe5i
 zEl2afPHwyXy22LxOl7np36A3FYa5e0r3Je0nKbWMnQQxrnPQs25YagJwhWKCJTPQCa+Juk3YVP
 yUBTi5s8vO8AHwvLcppvwSxQ67KaSCfvcGxvEsvg5m2k4BxC9cIMwEVYuQ9WZ9q5s4GosHcDxb4
 eIl0N2hGh87cx/c83r7k79MH8D7RS1ouPU2GPSbPRhesrbeW7EAP+8lL5w/4riNntuKmy7e1S/U
 mBVhADuld9J9kwd1HgLhiz9U+EkCBlBb9cDOM9cpW/ubNm795WaZZ40OeDdmKeeiR+Qtt8Pccsy
 wLe2YkOzzMkfpWXqvfJnZeFUxbOLtxM5rhIhtIs0LCF+ggdkCBL3YbOyFyrABUbFcAtR9Rz8YB0
 Jam6I1aWK/wWL4ZXTekwegdVZszR13e643Sk9wVMxjWc3ziV3ErAkwZ4Q6WSqnQW7qsrsifZJXq
 VgeQpqjSCHxbSrrsUwo3vWz/9faANOj1JSssYzx947CoHTHed9a4dsPN62Uvl/lTXc6bwrpKPL9
 2UPaxlDJgdnUK2nBT3rR8WzQX50CH8NGTeuvij4DQICL+VhqY6OJJ3F17+Czml5JU0WpKrTGFML
 aVaoVQXkVW0UEKBeMh9nCnf3OxT1l/A0oQI1i5aZK0g==
X-Received: by 2002:a05:600c:c170:b0:4a1:fb01:13 with SMTP id
 5b1f17b1804b1-4a21908175bmr28366125e9.18.1792780535303; 
 Fri, 23 Oct 2026 11:35:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d37ca2asm1545912f8f.8.2026.10.23.11.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:35:34 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 23 Oct 2026 18:35:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1
X-Gerrit-Change-Number: 2030
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2030?usp=email>
X-Gerrit-Commit: 0d7c91a11c99f254b9b29630a8bdf760a883351c
X-Gerrit-Comment-Date: Fri, 23 Oct 2026 18:35:33 +0000
In-Reply-To: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
References: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNzc5OTQ5MDAwLkkwMDgzYzZjNTQ2MGZmMmFmZjYzODU5OGFjMjZmOTlmZDMwZDAxZmQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0282700ffc7ef13742ff6c939d18cb3d0645d68e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xKK7C-000000000ur-04W4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: interactive:
 validate message size for dns/nrpt/wins handlers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1299257094314372056=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1299257094314372056==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HQymQJZviUc="; charset=UTF-8

--HQymQJZviUc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Heiko Hund has poste=
d comments on this change by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2030?usp=3Demail )

Change subject: interactive: validate mess=
age size for dns/nrpt/wins handlers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1
=
Gerrit-Change-Number: 2030
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <hei=
ko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 23 Oct 2026 18:35:33=
 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--HQymQJZviUc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund has posted comment=
s on this change by Heiko Hund=2E</p><p>Patch set 1:<span style=3D"border-r=
adius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-c=
olor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2030?usp=3Demail">View Change</a></p><ul style=3D"li=
st-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demail">change 2030</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2030?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0083c6c5460ff2af=
f638598ac26f99fd30d01fd1 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2030 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Fri, 23 Oct 2026 18:35:33 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: Yes </div>

</body></html>
--HQymQJZviUc=--


--===============1299257094314372056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1299257094314372056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1299257094314372056==--

