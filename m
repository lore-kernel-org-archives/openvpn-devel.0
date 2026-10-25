Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D692606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DmUbaRv6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N8HXNtLz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mdjzubnl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GIvtPBi5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JiF7aH1TGBZ1YH/whseTkp2QWKXD8Kj7qOKbXVKoUB0=; b=DmUbaRv6JOSPgM1NG4ZhUecfYS
	B+z5PiNvsxNLIinOAdVvOJmL6ta7fzxPexwteroQCKp62AXiZfE2G7Kv8L/Sh6l6apZJGF5bplGv4
	PDz17NNr47gtIIVwgB29a5xTeC2zAgzIuXKdjGbZLJuffcdFBA8oaTU2zYwb55/PDeOU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL3EH-000000005rK-3fXN;
	Sun, 25 Oct 2026 18:46:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL3EG-000000005r6-1NwX
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lKDJwwqMe3+D+gn8D7KtAgSP5bZ1xLM3S0VmjNEfD4k=; b=N8HXNtLzurYK4eAf7hOxHehCcQ
 KIhQn7VKMy8+yPKG/aJhH3IEkIi9RGclPoK8loYU7UeW8elsgfCRLrNMruLhy9mbt+AIJOJGQUJJV
 ymwCcF74LizKVbVVj8CTslyZLtH0njasPTcfc+e0E1+MXl5WoztCc0gfPvTnhbe3wFFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lKDJwwqMe3+D+gn8D7KtAgSP5bZ1xLM3S0VmjNEfD4k=; b=mdjzubnlvRru+Ry2w7uXRrq+U4
 svSxaEsVM6iPyIZbXvZOEP7Hf2efxFLCTMKWr0fJT5uB0vY7HNzUK6VW+b8ztv+pUkiZEm9Q2Kxmd
 KPcCCx3ELVXN3P3hpObdZYst3Y0LIrtAdK34ccJFGkCzPOnsVDfz6z2HZN1r9qBfkuXY=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL3EF-000000002MN-2PEI for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:46:00 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2172611f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792953953; x=1793558753; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lKDJwwqMe3+D+gn8D7KtAgSP5bZ1xLM3S0VmjNEfD4k=;
 b=GIvtPBi5MRr8pDSvdTbSSvbmdBD6DWHv2FU25+DJUhyV1IbmfYhTL1+KLh30Q/osqH
 MR0WSy5o1adePt5NeEH0+9/fo8PpDnaoPcqcFnf/qKdaYTFmM1CMCtB8mP+A8fbCiM+a
 wwkZqBAQyaVSFThae5tSUku227ziuhfIeLciNzD+/NE37S+Dfu28EmtWYXWM3G4LH7d6
 id1BWejznJWGuvoxEWRJDIk6AxcjsqdTJzsPWanvkr2GyBRrheqqkE7kVkxyllzy3dEw
 vuXP5+UCwl2yxjJzlEmUOtU6936nAK7EQEmPnmJbDYBwmptgp5Tkzf6WmQnph8odcmRp
 VxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792953953; x=1793558753;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lKDJwwqMe3+D+gn8D7KtAgSP5bZ1xLM3S0VmjNEfD4k=;
 b=u4h+CDUZyeuIFLXqkKzWjRH+RWeIcyJXxCIvQBJP2kBaBABG20oQaLE7WCmhmbz1Gk
 podhzXg8JeKAMkZW1mHkRxlksgJuE+36FxH4+Qzf910YwGWqA0Tl0J3V2iixCAVXkJ7p
 rt5o4nW3dtooTNpfK56YaY5AxLKkp+h9txNZcMxmbWoVtF5RqVNA5qgQXg7Wb2bL3RCn
 cqUuTXhbUqRHqJCG5UAr/OXpvYOqcRCfXDzGzi8zyS8WBOb29b2HW+zUsASoFWDVhb3b
 uqehdkJXj8oYpvQaY/17NEySh2wDQ5UMbuMUqA/ecm/ir8NSKmTzPI4b52TLET0nYkYA
 8nbw==
X-Gm-Message-State: AFq9FYLJLrydDiehZmBzaY3lJ9Wl9Lt2VKxOvECkIJSC26vepcw8TwgP
 wMv7wh+1XvvXhJg4yh8vsr/ZGST9yS+SI3nJ4mNUpSn+AjoBSEzzPwOvpbE+Eby3Ej1EbxpoiZJ
 0xJqlGSZJvpB4nVrni06d+c3bLOhX8xd9j5VsNN3FUKn5weMU/qfIh8U1dww7Mcyk3PBGs6Xj8I
 WkDOr0JQ==
X-Gm-Gg: AYBFou3vxwLrBT6GLjfLTlmurSBNCYo+Q89G77A4ZFRCpQ8i9O7Pgys8magpVdYTfLX
 7+jRtOVSR8dUlu7JhfACeY3Xzll5ueloGf8zGuhCFN6794+hxk7BK1ac6lPeZNEgXJbjUJ2Yi2+
 +0CfBQJrnLbJwhiCSALoPOMkaUfL0phExLMPvNN9dEOcBoBf/2KXL/LLt//6DVMgJ27BxWn2t9g
 +KhcIUJHQiEmI7Fa+YBpw1aO+Wgcj1l2cuk5JZYKXNoPMRkYXxNzAUm84Wf2Jjg6ZgUzHZTLxMP
 w+Xh0MvYrubqVNpO2nnHqB79ZgL33Yojc7LZ5TsB+OCZ9YNFCRW95Aslc/fBQdwoGips/XXZ1T7
 StrUFDG+jHloWaWeLAX1eBJ1WRpB0cbZoy/vIIT5WzUjQigI8b0Uwiuc4ga9pLzhIb7qiKu/V2K
 Xz8+IvLL7FUvxtEgf7VtGrAzIVf/jBtTJEqx+N4CTrwITsZOZ1eYuPn4dDReu3aCXps98xKKMBw
 ZvuCzxj+XO0bGqmXgR8sBZEahVJURhEodWvvYX4zIK2sp1TL20TxK1SbfrMAP/6TIDyUkKL+BT6
 r3c6rIpGg8jIl2wC/RkR/PqGIfBm8cDN76IXiFX+XwFC/DpvT1DcJx12c9WKNPPmCAoW4phlu7X
 4BBacYPUNzmp8pB7XCPiSx29AcxFE0fNnGb+wVbYaoA==
X-Received: by 2002:a05:6000:2404:b0:48d:f7ef:cd1d with SMTP id
 ffacd0b85a97d-48e3eb780bbmr7415928f8f.9.1792953952873; 
 Sun, 25 Oct 2026 11:45:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4be6sm10458053f8f.37.2026.10.25.11.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 11:45:52 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 18:45:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
X-Gerrit-Change-Number: 2018
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2018?usp=email>
X-Gerrit-Commit: ccd058e75be6af15c8a2427acb76be3a7a641213
In-Reply-To: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
References: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzMxMzQyMDAwLkk0MWJjMGZjZDQ3NTk0NGYzYzQ3MDE3MDVhNDZmNWE5MTE0ODBiMjgzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9bdf2ae57fbe40639f6d2816bc0ab43eca13a382-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xL3EF-000000002MN-2PEI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make run-cppcheck.sh
 run on FreeBSD and macOS
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3375165878025314695=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3375165878025314695==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bMA6y/uxNIk="; charset=UTF-8

--bMA6y/uxNIk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2018?usp=3Demail )

Change subject: Make run-cppcheck=2Esh run =
on FreeBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Make run-cppcheck=2Esh run on FreeBSD and macOS

FreeBSD has no /bi=
n/bash, while macOS has an old 3=2E2=2E57 version from 2007=2E

Also work a=
round the differences in readlink and different methods to
get the number o=
f cpu cores=2E

Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/201=
8
Message-Id: <20261022170411=2E20830-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4010=
3=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-to=
ols/run-cppcheck=2Esh
1 file changed, 9 insertions(+), 3 deletions(-)




d=
iff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index=
 3c71c83=2E=2E58609b2 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-to=
ols/run-cppcheck=2Esh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 
 =
set -eu
 
@@ -17,12 +17,18 @@
     disable_arg=3D"--disable=3Dinformation"
=
 fi
 
-SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+if [ $(u=
name) =3D "Darwin" ] || [ $(uname) =3D "FreeBSD" ]; then
+    SCRIPT_DIR=3D=
$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
+    num_procs=3D$(sysctl -n =
hw=2Encpu)
+else
+    SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0=
]}"))
+    num_procs=3D$(nprocs)
+fi
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}=

 : ${BUILD_DIR:=3D$PWD}
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_D=
IR}/cppcheck_build_dir"
-COMMON_ARGS=3D"-j$(nproc) ${verbosity_arg} \
+COMM=
ON_ARGS=3D"-j${num_procs} ${verbosity_arg} \
  -DMBEDTLS_SSL_PROTO_TLS1_3 -=
DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
  -I=2E/include/ -I=2E/tests/unit_tes=
ts/openvpn/ \
  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/=
 -I=2E/src/plugins/auth-pam/ \

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2018?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
Gerrit-Change-Number: =
2018
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--bMA6y/uxNIk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2018?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Make run-cppcheck=2Esh run on Free=
BSD and macOS<br><br>FreeBSD has no /bin/bash, while macOS has an old 3=2E2=
=2E57 version from 2007=2E<br><br>Also work around the differences in readl=
ink and different methods to<br>get the number of cpu cores=2E<br><br>Chang=
e-Id: I41bc0fcd475944f3c4701705a46f5a911480b283<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
018<br>Message-Id: &lt;20261022170411=2E20830-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg40103=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M dev-tools/run-cppcheck=2Esh<br>1 file changed, 9 ins=
ertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/run-cppc=
heck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index 3c71c83=2E=2E=
58609b2 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br>=
<span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -1,4 +1,4 @@</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/bash</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env bash</span><br><sp=
an> </span><br><span> set -eu</span><br><span> </span><br><span>@@ -17,12 +=
17,18 @@</span><br><span>     disable_arg=3D&quot;--disable=3Dinformation&q=
uot;</span><br><span> fi</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOUR=
CE[0]}&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ =
$(uname) =3D &quot;Darwin&quot; ] || [ $(uname) =3D &quot;FreeBSD&quot; ]; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SCRIPT_DIR=
=3D$(dirname $(readlink -f &quot;${BASH_SOURCE[0]}&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    num_procs=3D$(sysctl -n hw=2Encp=
u)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SCRIPT_DIR=3D$(dirname $(rea=
dlink -e &quot;${BASH_SOURCE[0]}&quot;))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    num_procs=3D$(nprocs)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+fi</span><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DI=
R/=2E=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br><span> : ${INCL=
UDE_FLAGS:=3D}</span><br><span> CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_=
build_dir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-COMMON=
_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+COMMON_ARGS=3D&quot;-j${num_procs} ${verbosity_arg}=
 \</span><br><span>  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERI=
AL_EXPORT \</span><br><span>  -I=2E/include/ -I=2E/tests/unit_tests/openvpn=
/ \</span><br><span>  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvp=
nserv/ -I=2E/src/plugins/auth-pam/ \</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demail">change =
2018</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I41bc0fcd475944f3c4701705a46f5a911480b283 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2018 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--bMA6y/uxNIk=--


--===============3375165878025314695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3375165878025314695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3375165878025314695==--

