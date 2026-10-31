Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F0606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fc8j2Msz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ej9ik5Wd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aq3ugc5M;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HWWh1oiD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=J/CJrUOd18ldzf2kFSIqnnuWHNsnBNXT/WITSR8i0mg=; b=fc8j2MszQKOyedxyOuudYLZwKA
	t1W2nJme+8Zw2w1T3qqFhGu4nJDj1fEvPI/YBj40uNGcZM05XXez32UmgIotGQSShpMO0SsRBl8S/
	hvWXL2vjULjrPq93pjiR/1wdo4dCxoFPnR2EJzmwpneqYJ41oex6s7SHlSWcxCj+6fEI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8nZ-000000000ei-2Gwq;
	Sat, 31 Oct 2026 13:07:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8nY-000000000eb-119P
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 13:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kyTsAL3W5yOA1YFbXKTv2Xp7Hc2QTB/LPRRNx9n+anY=; b=Ej9ik5WdkLdy4xtFGT+nAnMa1M
 P/jZWFPNB738QHhvuW2XJGG+WGV6nABSQAGxMPSHZbMtMCMGg+455CyknVyCuMwAYgmHKN7buqBr3
 NzUw6IE05i4IkvKMj8Yw66v3Deu+2BmCsLAKOcY9lvQqedmtSiZzF7yld+4Wklxgib1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kyTsAL3W5yOA1YFbXKTv2Xp7Hc2QTB/LPRRNx9n+anY=; b=aq3ugc5M4FttEKLgtZYbalopxB
 j2bR9RFG4MMBBg6rvkc8NC2xR74SUZhdKvTBX0Z2d5x7FRHJ+iQmkhDse+ocNqdJiW82ULxjfwHpk
 ndEJCCp4TISiNMuIcwx6evCeFA7Zr11tadFssb27azhCaRrD6vl2CMX8/JdQb1rboXuk=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8nW-000000003pV-16BK for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 13:07:04 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so17089615e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793452016; x=1794056816; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kyTsAL3W5yOA1YFbXKTv2Xp7Hc2QTB/LPRRNx9n+anY=;
 b=HWWh1oiD9i5lPgP/2nljfwwGr7azo5ProEYmLJJKcRqxO+SZMioxkbjMr8iOezQyel
 nedTf+dYDUYtiKNTA+vw+LJO7rWQWNyuxwNFy6lXDO5HvLK2Cccj1MojoTh+OTroPW55
 6B0BDDRyrO5eBNTGUQrTMPG9eV8XKLc/jnHP4iCYsb5XdkE/BvvNUaQ9fxmHbKeI2o1F
 g4DF4Xyzx3oiZrNuCBzmmRiuNAyyurGbww9Vf2FJ1LtHPalJHff5x7HDrjB07oMpq5SS
 +a2V5uYxSvCqai6DJ35VxAy4+u4x6T0otffX/mPsPsc/U4R7VLiqP4SGenavJwsM+lb6
 lxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793452016; x=1794056816;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kyTsAL3W5yOA1YFbXKTv2Xp7Hc2QTB/LPRRNx9n+anY=;
 b=h6NLeg0x5XLHXXzpNhk1fQidmDZICO16oTL0zcgRf4inyiAR2YnvFjSMmeSZRSpQhP
 zf9lZPrH+sBIB+UFCUxE95i4eypcsDdR5tY1mhkB2BvhM6gYvXAh/0sZ8Oy27A9wdhly
 kHiPNj+oTsL5mhg3CYqVTsy3lfjxvhPNhQYKc0rF4+zlXBGOlFx4rLswc++E7OAL1B/s
 z7zdy2Jj5jSHxeoUNfHscIRicu5UOHhMGAwliK1yTOAyMUhIsnYjfZmPazXjHF9alLHI
 G0eeQ51wjMbV1KdLHjfnimqroird8iKvFRwnDBW5wqIRW4a0D7HhKFd7trQeMN5Oof3U
 mdOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByG/5B+VqJi9+ARLwAx9Yy7f1Us6o8LPVE5I49FLHi1WRWaOTmcohmVIL5p1qCdPflinODYgtsdI94GIrmg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKtKcN13dfdYaI/1IjxdwcXWPndzNkIuDn6llnjRaQRY7nKxgeM
 euR4YCyMSDq0CAXWYvDi4LDJfQ8EYHs6fNafEnslNJ8pP50q7jW3xmvER8x33JVfKqlcpXeTEG+
 MDFeh9+L06Pxc3+plDOYFRQhR2eju2uxvIFBOl0P6aiA6bTfFzdcfq/k4Ll7WOVJKVcCEMP2bEv
 JoS6Ziug==
X-Gm-Gg: AYBFou3QO4HtHWBLWahZDkSK/kOamocmeQrPNFHApEdc/v/NYwthL+GlzFcipXY4cUE
 F+FyHS4JlwSxloKsct802iKrWyQb5y7C+lZTlWq00ZYaHO2iiR/mn21H/poyZgH5wgqWMYi/NQE
 3PO6/4b5fulwFGM6HyZ2LaH7fPIwltKPevolveBNaQNFhfLVgRbS2iqDaJzF0j73THuwC9qMPw0
 tIZuFYmRmEGrpIvR8RPpCECwH2VO5nPh/lMfCyXsNfaLQHcBtxOuSuTfF5eK8gk7O7V0QudmgR9
 iBCorvb1V1TSX/m0kXcyhX9j6iA4SYmnSyJzen5c9zYLf0j1/oBo36yEp7E69a/Kllp+suQHNiG
 +oB4Yi+59iQYUSqq9lPSQ3nzEWKLlCmZa7KgwxYk1GszkwoYhHJdD4EEnuaPGqEzmNTzt/NMMEU
 +VFSfjjyVamjttskFPuUKxL6mVv5VEtkM9jHbzFBsVSKaI4inRzaUGaKEt5NJEbM2pd/r/LtLYv
 LTt2xab22IQ83GsZt7N/Puq7MX15ayo8l7oF/C8Gvf/6iQJNi3sCCtmMIH5c9xCEghVpb3QR0cs
 tDWtu/F7zhTz74YUjdZDTwzDMjHZqLqGZci+To9/6+bLAuD7HwL14NQtFnWGM8jv0Hed53BELG7
 oM/WEy5aGtiOr9gDpurJNlBjPw1lTWtJqBpV5wHACpSyyMyXMuCLHdzvwtpYbfelcZWnhm8GGaP
 /6oWFc46gGp0vdl3HcgwI6bh6kS4WQIkBB6+4B
X-Received: by 2002:a05:600c:34d4:b0:4a2:d7e:5ccb with SMTP id
 5b1f17b1804b1-4ac182dca99mr124679905e9.15.1793452015598; 
 Sat, 31 Oct 2026 06:06:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a66caefsm102321375e9.5.2026.10.31.06.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 06:06:55 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 13:06:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: c8572113a1bc19f64d5e09a9e1d362e87611c823
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 13:06:53 +0000
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2502b2dadb6cf44b857cc8907c62cc6f39ff6d2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xN8nW-000000003pV-16BK
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: port-share: do not
 follow symlinks when writing journal file
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4288351190336734353=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4288351190336734353==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UmHS1nFQF/s="; charset=UTF-8

--UmHS1nFQF/s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Gert Doering=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail )

Change subject=
: port-share: do not follow symlinks when writing journal file
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment=
)

Patchset:

PS1: 
> It does not claim to=2E=2E=2E [=E2=80=A6]
Right=2E So=
mething like:

```
unlink(jfn);
int fd =3D platform_open(jfn, O_CREAT | O_E=
XCL | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
```

would, I think, cover bo=
th cases=2E

Does that break something subtle I'm missing?



-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885=
f0a7bb8b
Gerrit-Change-Number: 2074
Gerrit-PatchSet: 1
Gerrit-Owner: Gert D=
oering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Do=
ering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sat, 31 Oct 2026 13:06=
:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Gert Do=
ering <gert@greenie=2Emuc=2Ede>

--UmHS1nFQF/s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Gert Doering=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2074?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">It d=
oes not claim to=2E=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Right=2E Something l=
ike:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">```<br>unlink(jfn);<br>int fd =3D platform_open(jfn, O_CREAT | O_E=
XCL | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);<br>```</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">would, I think, co=
ver both cases=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Does that break something subtle I&#39;m missing?</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2074?usp=3Demail">change 2074</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be=
6885f0a7bb8b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2074=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Sat, 31 Oct 2026 13:06:53 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--UmHS1nFQF/s=--


--===============4288351190336734353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4288351190336734353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4288351190336734353==--

