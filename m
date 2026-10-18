Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C09CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=MMNS6KSzgnREj15Su2ZGJq1QzMx/XO8/1qc2ZamWbNY=; b=A7ybzBcqVwAbXa
	Fd/res458wcJ0ggCqFAxQdPoi0qwJJKEMiFbFIo0Uv6DimhJxQp9P4qEaXPpR1teNw0FPQEeg5RWJ
	8VOQGpPEkHczPGVBvTI0iZW3e8sCAd9V2xufMzy1KRglKR7MLPyoORsKvmPIPPKS+aWXnzbaZvBsX
	6S8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRGG-00035Z-E6;
	Sun, 18 Oct 2026 13:49:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIRGF-00035Q-F7
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XfcJ1GXsq/C5PAMAbguD8TCTVJT1hHyN8l1UzeTN7VU=; b=jR4Z6G5fSBZNMFlzLX4+3qy2Sd
 7ezbg9gF+ga6DaVb/+etTFT0O/gcgmS8M9WEO2UhwMKEIpUzomeYbBvxnSSSZliDKE/bTiKvP1mCZ
 KL9Z6H+h45pWhZdmKgGio2pUPIyErLBkWEnktJMWHExz4cbMprfhj6SPFswOEmQGGqrc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XfcJ1GXsq/C5PAMAbguD8TCTVJT1hHyN8l1UzeTN7VU=; b=b
 NXhJ7WnEwydSLHJnbLWMKbUhdDmfLtvajqbTmH2/nEv2VdlWQ4RKIUxGRtGvoRPeopt7n1/43C6Fn
 kIxxHOS2IoWTi6o0GlBgRnxrgYszWHIr6d1cDNIyjFtKhaBzOjUO8GcM/eRflM2dYLdBBu0R6N8Cz
 Mok/dZhpJtn8IHFQ=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIRGF-0005Jb-IB for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:49:16 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso701576f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792331349; x=1792936149; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XfcJ1GXsq/C5PAMAbguD8TCTVJT1hHyN8l1UzeTN7VU=;
 b=E6UbXu+6Mcj20CR+9kz7ZUXdwa5YYbsfJTghHxAQVa5DIgHHBnZnOUy/8NF4xMQ3NZ
 rC8rC0jvD1OzJLzuRJDy2niF1A/sje7YRb2rt6SSuztubAA/tphiad7v34Bk/JnV79j0
 Vy3qfuh6W7M9I5QwQqGS+IKuuBgj3b+fzpajCp2y15aftHQXH932xBlS2XaBbX12qlYP
 cxfg9T8uxrX+Lm/IJ93VpI2FERpHzkIj3yaHTP8olqvvcbWJHwc8NRmRloMFGnlNN0wF
 wrYogT559UjF0ac0S7LVZN/LL/UA4ZZTltSbBis/B7U0r9w9I0RtdxeUfdHQqIItFpCd
 kMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792331349; x=1792936149;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XfcJ1GXsq/C5PAMAbguD8TCTVJT1hHyN8l1UzeTN7VU=;
 b=x5IsgqtlwdhISH7ZR1TET7bY5zEA8R4Jj5Kn5C7czzJGza/FcRrFvYNgsNo2sQaJMR
 yDCqB5ZRKvgRhseSA//tvndkewSFAlTV1GeXiwBlli1bh4kb4soAhFgBrvRmJ/JAlugG
 uPeLcr6UNNzL2mw0fa8rp/KM+pPtBI6PFchNLi8UqJWYxUvpu4010ON24x6QqBTtjP40
 JDWiBGbYUcSg7JD1t+Ekae8ZbwEtj+7x5YwWpukZD3wfUZfvPGdGjxdHBXbOgv7zvU5U
 AMO0VOMIHQEchARlwFKdcJvRO58efDRHeiSqS270de1YQDFS8YK/1qHJcoBCLX+DV4WA
 gaxw==
X-Gm-Message-State: AFq9FYKfQXHQr1GQ4IdWQvziEYF93p0rbpes+fX7ZjYJtfjSvRM54ij8
 vRRyMmPyJrXep1aRsY3SSiIzwyqqQv+6e2lohIA6VShWnhkxHcRAKSh1cMXXhnsSS1bjzp6DolR
 szBjYglHKjp5wbi7CRbt02wnlee8+m6dBQWX3ob42SCEokbbyAH+jAMOJalZ7P9SyQTk0s1TxGw
 4NYYce/Q==
X-Gm-Gg: AYBFou3vF6Wa9z4peJhhXcAPN/gcuRQ+OOIY2qCb/65yYhozQczI1zb9ncNYXXa1cUO
 v6DQFgSswng55/7xqzsNiNUC3eGc0vmFaIAlheRa0MHwOinwRZapvPuS/40jBjf6Lute5RiMEcr
 1y0vxTUYPsuN2FsoJb92S46y0VnpWwW96p5+vhBmULHXU3Jkcc55RHVkXgzbkAWEb+4tu9K2zhI
 ido80dkIEblSbcxFEh5nqZBMIzk54o6u/jDJoD5jm5ZX7nfbbRtSHWgxGsDoyoueFP9zZdAEVgI
 onP5kuldeY4JcP2LhaUqReCgFv7/XoryhkNZOG68aEaWRlvDqcW61kY2MsWpCmA6WOOhUKpHNfH
 ooESRiPs7JHiBFj1dR+0wOWvKwexWh+xmo+joO6EZpJoQsBJuir1lJbpYkFQx90Ki6AVDZQVk9H
 5wIIMQIF+lokZV6Rv+crOfOc9O9cxtmKLUYDE+m5PZJBBlJ3O/MrD0Ay6eHX1SN5VDfWTTlEfXU
 /O72euLfd22UYth9c7HzA7Y2yQWWAfmIHyxWByqiNZN/ebSPMCEYnzxUb0qDMaZbXKCsONc6pLY
 SQ8551nC0GtaB1LcngnsII72FEhaJ+0J+YmUE6CrpN8poOjQs6fCZNgdAP2o
X-Received: by 2002:a05:6000:46d9:b0:48d:f14a:9173 with SMTP id
 ffacd0b85a97d-48e07976b65mr6205030f8f.8.1792331345455; 
 Sun, 18 Oct 2026 06:49:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a72sm18616655f8f.4.2026.10.18.06.49.05
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:49:05 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:49:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
X-Gerrit-Change-Number: 2018
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2018?usp=email>
X-Gerrit-Commit: 659ff909be1177fb261859de333b0c411d8e04fe
References: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzMxMzQyMDAwLkk0MWJjMGZjZDQ3NTk0NGYzYzQ3MDE3MDVhNDZmNWE5MTE0ODBiMjgzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <78f6e5ba2ec09ad8679961e9cf5f0428368f17ae-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIRGF-0005Jb-IB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make run-cppcheck.sh
 run on FreeBSD and macOS
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2294584196001710874=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2294584196001710874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8ICmk04t8ps="; charset=UTF-8

--8ICmk04t8ps=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2018?usp=3Demail )


Change subject: Make run-cppchec=
k=2Esh run on FreeBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Make run-cppcheck=2Esh run on FreeBSD and macOS

FreeBS=
D has no /bin/bash, while macOS has an old 3=2E2=2E57 version from 2007=2E
=

Also work around the differences in readlink and different methods to
get =
the number of cpu cores=2E

Change-Id: I41bc0fcd475944f3c4701705a46f5a91148=
0b283
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M dev-tools/run-=
cppcheck=2Esh
1 file changed, 9 insertions(+), 3 deletions(-)



  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2018/1

diff --=
git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 3c71c=
83=2E=2E58609b2 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/ru=
n-cppcheck=2Esh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 
 set -e=
u
 
@@ -17,12 +17,18 @@
     disable_arg=3D"--disable=3Dinformation"
 fi
 
=
-SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+if [ $(uname) =
=3D "Darwin" ] || [ $(uname) =3D "FreeBSD" ]; then
+    SCRIPT_DIR=3D$(dirn=
ame $(readlink -f "${BASH_SOURCE[0]}"))
+    num_procs=3D$(sysctl -n hw=2En=
cpu)
+else
+    SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
=
+    num_procs=3D$(nprocs)
+fi
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 : ${=
BUILD_DIR:=3D$PWD}
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_DIR}/cp=
pcheck_build_dir"
-COMMON_ARGS=3D"-j$(nproc) ${verbosity_arg} \
+COMMON_ARG=
S=3D"-j${num_procs} ${verbosity_arg} \
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDT=
LS_SSL_KEYING_MATERIAL_EXPORT \
  -I=2E/include/ -I=2E/tests/unit_tests/ope=
nvpn/ \
  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E=
/src/plugins/auth-pam/ \

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2018?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
Gerrit-Change-Number: 201=
8
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8ICmk04t8ps=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Make run-cppcheck=2Esh run on FreeBSD and macOS<br><br>FreeBSD=
 has no /bin/bash, while macOS has an old 3=2E2=2E57 version from 2007=2E<b=
r><br>Also work around the differences in readlink and different methods to=
<br>get the number of cpu cores=2E<br><br>Change-Id: I41bc0fcd475944f3c4701=
705a46f5a911480b283<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;<br>---<br>M dev-tools/run-cppcheck=2Esh<br>1 file changed, 9 insertions(=
+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/18/2018/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tool=
s/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index 3c7=
1c83=2E=2E58609b2 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh<=
/span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -1,4 +=
1,4 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/bash</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env bash</sp=
an><br><span> </span><br><span> set -eu</span><br><span> </span><br><span>@=
@ -17,12 +17,18 @@</span><br><span>     disable_arg=3D&quot;--disable=3Dinf=
ormation&quot;</span><br><span> fi</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-SCRIPT_DIR=3D$(dirname $(readlink -e &quot;=
${BASH_SOURCE[0]}&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+if [ $(uname) =3D &quot;Darwin&quot; ] || [ $(uname) =3D &quot;FreeBS=
D&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SCRIPT_DIR=3D$(dirname $(readlink -f &quot;${BASH_SOURCE[0]}&quot;))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    num_procs=3D$(sysctl -=
n hw=2Encpu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SCRIPT_DIR=3D$(dir=
name $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    num_procs=3D$(nprocs)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span> : ${SOURCE_DIR:=3D=
$SCRIPT_DIR/=2E=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br><span=
> : ${INCLUDE_FLAGS:=3D}</span><br><span> CPPCHECK_DIR=3D&quot;${BUILD_DIR}=
/cppcheck_build_dir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-COMMON_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+COMMON_ARGS=3D&quot;-j${num_procs} ${verb=
osity_arg} \</span><br><span>  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEY=
ING_MATERIAL_EXPORT \</span><br><span>  -I=2E/include/ -I=2E/tests/unit_tes=
ts/openvpn/ \</span><br><span>  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/=
src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demai=
l">change 2018</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2018?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2018 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--8ICmk04t8ps=--


--===============2294584196001710874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2294584196001710874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2294584196001710874==--

