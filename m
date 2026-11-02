Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63C606EE97
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U2NVD9Bf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CAnSYG6/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m/q5ErL5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NO0qPwDs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jamX38RChmOZ0BgSI8qnqEB2OkDytnvRTBFwbpde9PA=; b=U2NVD9Bf9FTUOx5DgsuJAzFVkk
	WWoDrH3H89K+1/n4TKOy0wEdis8DpkLKRyZu51ea4LPyyDqR7xjuUuHFZ3q/QhSGAL4vaMFU9jVxF
	29ZTDdHRmoNuUvS8cEYC1RVDexiJjbd9SQfZQQOyP+zAhY5RpVzw89H+BbbSxgcw2Mqk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzkW-000000002sc-0bD6;
	Mon, 02 Nov 2026 21:39:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzkV-000000002sW-0UJh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tMIuS326ypc8Fo39oQEhy8d494mtMqxs1FjiTPBsMg0=; b=CAnSYG6/RiNPRG6CE4CD4yaHfy
 Whx8mWKFs9+v2JY3d2KzLMIpXWA1mGK4LmXfgKD3JNJstCZwyDu9WxnEpjfqtBVpVq/yfRrLUxR1o
 zMZEKM2lKaKMYiHjov9gSXWASEeLh3cZJqwP0A65z07h4BJvRSzEz5St6diXwmGe3gnc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tMIuS326ypc8Fo39oQEhy8d494mtMqxs1FjiTPBsMg0=; b=m/q5ErL581MHtlvxG2JUSVR37A
 ud4sBbr8L1IKcLkelgPnM3T9T4qpapaAk6cLhwGVxf3i2xq77aTnOcQFg0sfvW3+R87vGcCTBKj40
 1IdSSVCUheBNV0CUuouWHoczK2ZBb5NIJcrKEQysc5GIHWK7S+Zpmb9LE0Mdpp6mppJo=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzkU-000000005rv-1zdZ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:39:27 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so22537205e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793655560; x=1794260360; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tMIuS326ypc8Fo39oQEhy8d494mtMqxs1FjiTPBsMg0=;
 b=NO0qPwDsovj1a0DVXG2W/8EoP4hRRy7ww3M+K+YTMDdp7ntoHeiHwmbSQa1q/hwnLB
 UJEOW7YRpIT54bMbLU2gy7P7kSPbtYEwJ/mwjUQjOj1x4qa6qlSbVmiNPMj6GA4Vc91q
 8T28z1HFum7Cvlqxkf9znfetk/IR2qSW+o1ws5EUCzvFlyCS80ZaHGfC6rhctDNJB/3X
 Nnd/0SNgIlmOjXlgG/RAa5hHMkCLkGGaiXBsXncDgaflC96V+cOF6n35JvFrov9N97MG
 R6TXNZD7vUyH/ksthmYLQ51zZGNXNt+9D9XCUIF9+BEVCDI4spJpHhvgwogsveX8NVeJ
 fo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793655560; x=1794260360;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tMIuS326ypc8Fo39oQEhy8d494mtMqxs1FjiTPBsMg0=;
 b=dn8cwHdQxvA9K365ABnMXIjfUV+3Mk+9gRICSx3LkZ+hTu1I/IaEIMe/oTmXF7sfCa
 19OqNAW2yrXs4D3HsE+IGYe23tLWIlf/tLZ7IX+jtLV0unZZmIUVsVogM3y+sEhYz4MB
 GICeR1Sq0KLLuWHSFkSZ3/Lj2VcHf/zZ3yxK2B6UYpKyo8dBtQNxzL9cY5AV65Ye8kzr
 QKg1+inV9r0fxIJkCta9fuPpb9VAN9XTzKrIwQbYFFhDLuCYer/DV68dSnxZAoE23X8T
 e4zfN6cRvAS41BM/YldmQfSLNRI7ajRPi6dMi7Hmvv780M+/mujoyy5WxWrINl29+ugk
 9S+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNL1CzVfgOWKoFvT6Zr60Iv98BBuc1O/y3PbaZ/R4RfQAWLX1yQWlslyvPIoip5L56uBVcAXJomrPM22BD@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI7zTHU+P6h6hkyCmyi0Xae3ViG836pWUv1QF9sOw/mOBlEFWyx
 RkXGHSGFtBGpCA8XhlujnzU04fXAWYpAo3QCqwpPxLvIFAyRDkGjYiSTFdHXrBCvNcFl2qL0ckS
 kLr73hNEQcpkTaSZqUu9B81X/BIKGQXvcoevAyOd89E+2Y1dQcsTSYFUKE8GWXnzHpEcA
X-Gm-Gg: AYBFou34TFSTOytEAv8hK9Ma1Ic52r3Etm2Hu23U9uRYju/HQ0LmrkR4+13QDmqbz2l
 7h+QpzkxeMZLh8LZ+yUvEbFMjgH3MrRuEOtz32oT9AqUuEr5s39hyl5tr59OxGdTpQxmm4ACRpw
 7pM5+k8wnUGpnKOytEmqmF/KzoumYR3ZOZiNK1ckv3GiG0q8Vn65AviY+ubLY0mD7COPjuMvl+6
 4/L3dTyXzXcG7+xcqDCHzwRy2lYHjCOe/QLoG7cDw+UCeA5DkZICh21ocK4VWk/ACghyTNdqOSf
 EjwpL0h9Sf/oB82w2hxxnc3VLt1ADb5wG2e6ethjbGeMwN4Og6kGObS4raFkYMLkG0anfOLaHUE
 /epGstU5/SN/EDo4YG+3wFtXUA7bXPU8BflZoS/qm/SDTM2vQgpqB6PS0VH7slb0wR/yUWxSv0l
 0SlGcb/OCeq5JH3VcGq1DAZpIifSRJ22+GSB0MGWF/N9wp6+cqyLGfWYob7Ex8JDIh/jlkv0AS9
 wIH6LHclzEVMA/Ae6B+SA55GPPgBs/um9IMPx1Sv6heagFl9yAPazS6SUtqPV7E/qs+h2tTnq65
 mEept6R58O8eNKTiIqQREyHc3FC2HCkyjIosnpVjg9+B1dSBoYwfVNbur+dU47+LwoOS1xuMEc5
 3SPhTAXdgbRwO1ehD4sh0adKBFMMn+7ujW35UWCNnPdwDEIvydKWudTKbtwOXjCPO8iv26Pw0ar
 UIMPkmCkdjCHo3CEJhONmJYwMZX2szWaSZ1FE=
X-Received: by 2002:a05:600c:3b29:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4ac17d19aeamr235337865e9.21.1793655559766; 
 Mon, 02 Nov 2026 13:39:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725a2sm20566871f8f.13.2026.11.02.13.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:39:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:39:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 672bb8080dde7a781ca6000f014c241b6009e283
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 21:39:18 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <719c36284eebafc024e41828afceef097c59849e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzkU-000000005rv-1zdZ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2933622808923580268=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2933622808923580268==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yo/TvNMBDvo="; charset=UTF-8

--Yo/TvNMBDvo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Arne Schwabe=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail )

Change subject: Rem=
ove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review-1

(1 comment)

Patchset:

PS3: 
cppcheck=
 failure

```
+ cppcheck -j36 -q -DMBEDTLS_SSL_PROTO_TLS1_3 -I=2E/include/ =
-I=2E/tests/unit_tests/openvpn/ -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/=
src/openvpnserv/ -I=2E/src/plugins/auth-pam/ -I/build/debian-unstable-cppch=
eck/build -I/build/debian-unstable-cppcheck/build/include/ --enable=3Dall -=
-disable=3Dinformation --library=3D/build/debian-unstable-cppcheck/build/de=
v-tools/openvpn-cppcheck-library=2Ecfg --library=3Dopenssl=2Ecfg --suppress=
-xml=3D/build/debian-unstable-cppcheck/build/dev-tools/cppcheck-suppression=
s=2Exml --inline-suppr --cppcheck-build-dir=3D/build/debian-unstable-cppche=
ck/build/cppcheck_build_dir --check-level=3Dnormal --max-configs=3D10 --err=
or-exitcode=3D1 --platform=3Dwin64 --library=3Dwindows=2Ecfg --library=3D/b=
uild/debian-unstable-cppcheck/build/dev-tools/openvpn-cppcheck-windows=2Ecf=
g -D_WIN32 -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD=
 -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY -UTAR=
GET_AIX -UOPENSSL_NO_EC src/openvpn src/openvpnmsica src/openvpnserv src/co=
mpat/ tests/unit_tests/example_test/ tests/unit_tests/openvpn tests/unit_te=
sts/openvpnserv
src/openvpn/init=2Ec:2945:33: style: Parameter 'c' can be d=
eclared as pointer to const [constParameterPointer]
init_crypto_pre(struct =
context *c, const unsigned int flags)
                                ^
```=




-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e=
6406f1f4c12cd6c6e0fce93815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 3
Ge=
rrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 02=
 Nov 2026 21:39:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Yo/TvNMBDvo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Arne Schwabe=2E</p><p>Patch set 3:=
<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pa=
dding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2082?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">cppcheck failur=
e</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">```<br>+ cppcheck -j36 -q -DMBEDTLS_SSL_PROTO_TLS1_3 -I=
=2E/include/ -I=2E/tests/unit_tests/openvpn/ -I=2E/src/compat/ -I=2E/src/op=
envpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ -I/build/debian-u=
nstable-cppcheck/build -I/build/debian-unstable-cppcheck/build/include/ --e=
nable=3Dall --disable=3Dinformation --library=3D/build/debian-unstable-cppc=
heck/build/dev-tools/openvpn-cppcheck-library=2Ecfg --library=3Dopenssl=2Ec=
fg --suppress-xml=3D/build/debian-unstable-cppcheck/build/dev-tools/cppchec=
k-suppressions=2Exml --inline-suppr --cppcheck-build-dir=3D/build/debian-un=
stable-cppcheck/build/cppcheck_build_dir --check-level=3Dnormal --max-confi=
gs=3D10 --error-exitcode=3D1 --platform=3Dwin64 --library=3Dwindows=2Ecfg -=
-library=3D/build/debian-unstable-cppcheck/build/dev-tools/openvpn-cppcheck=
-windows=2Ecfg -D_WIN32 -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -U=
TARGET_NETBSD -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DR=
AGONFLY -UTARGET_AIX -UOPENSSL_NO_EC src/openvpn src/openvpnmsica src/openv=
pnserv src/compat/ tests/unit_tests/example_test/ tests/unit_tests/openvpn =
tests/unit_tests/openvpnserv<br>src/openvpn/init=2Ec:2945:33: style: Parame=
ter &#39;c&#39; can be declared as pointer to const [constParameterPointer]=
<br>init_crypto_pre(struct context *c, const unsigned int flags)<br>       =
                         ^<br>```</pre></li></ul></li></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">c=
hange 2082</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2082 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 21:39:18 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Yo/TvNMBDvo=--


--===============2933622808923580268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2933622808923580268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2933622808923580268==--

