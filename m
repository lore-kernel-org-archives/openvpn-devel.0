Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF80EC61DBE
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=HBVisUElYSigz4u3trDV25FMXT+VnJmrKUpvHmJW8FY=; b=PrtMAQ0ZF8/Cm6
	UZdPRmfYJ8wJVSXatAf5sXN0Vs6wesTN51erDpOQO1cNGalCqmbkxUChmKg709iDbzbUiblsTfXjQ
	u/awB5FAHdqmzUSbsNgn6Ena7Jo8WBGmJdp4HG/aaDLWkOCiBq+Zlm/aq+PexYXmMZse1M2Ze+4cc
	Iv0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytLU-0006Uq-Ih;
	Tue, 25 Aug 2026 15:45:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytLT-0006Uh-OP
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Nj86mbLx7EOlX0AfheX3eeD/Id6XwUYNBueXEwMAX0=; b=XKUALreLeFgq7bBQMD9Git3l6c
 2WEL9I7DyX9m69JZLlh5aWW6145D4RQ2gY+Tcu5k5KReu+4+UDxxVvdOso56DojtvBg+m/Zi8T1s3
 JqOv/Y/33tlTkaYC/5DOf7fQEiDL9baZPQoio65oSMrv29XnZYA+y/fOJIlz71dm+wCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3Nj86mbLx7EOlX0AfheX3eeD/Id6XwUYNBueXEwMAX0=; b=d
 S0F3grL3t5MKugFGwYbcakdmf7uVcO1eDNjRp+9LCfYfOZEx2bdd59n4M+FqAdQQnfY/y7u4OMfjR
 bNqw411KZywDieFpJIot0ZlTCTx7Nd+ka1O4SDhtYV0Kcekv4Py81WMLjUsQsHNOO4LKnQ45TT8e9
 a1V7kHhPFHN5RyAQ=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytLS-0002Cz-JP for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:52 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a41191c9a9so9614542a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672744; x=1788277544; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3Nj86mbLx7EOlX0AfheX3eeD/Id6XwUYNBueXEwMAX0=;
 b=UJPIR6ScQQfGbw/77iRMamsPd0unTNXRXAaB4CpdhPygCyw7dfE2rlcToSpZPFzHtd
 7+iUCo5RRk+BWIyduCK/PjLG0K4xPENTlfaRmlvLRGVvTZIThkt+958Fpn92GHjaliue
 dW3Z38E/CvThVIhedj7SpujahMLb2Q/poboSMvYXU1xwOVaNIYIuuwVnoZjNmodzQv9H
 3L7gI8Br16Hzy9AwWzmtqR4dXI53mryH/Evq2GYM1fGyrwp+Ny/izBZs/OQ9kQgGvR/c
 e1grat6fYPoFtVHqS67yISsbUv32R8BSNW6dRcxp27neI0P2k/oI9pbTLJ2sXPOmFrHC
 agjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672744; x=1788277544;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Nj86mbLx7EOlX0AfheX3eeD/Id6XwUYNBueXEwMAX0=;
 b=OTUon4LXYf10fM1su1OvAFoZgAoJMrrJRRAnxkAoZnpcRg8coPaEAr3bKJAA+MM6xT
 9cSJzOlSmfHBDDETjckllqKQyaRdnorHQR8uEiu3fJ0Sqg3zwXZEZ9B45nFHgm4pi83T
 5f60K1jrALc/gwvg/8iE2xGc2UOsfPaHxDJLRn9H8XfiIzVx83/rQtWZPteYa/Ov8IuV
 ktaBZdEwva+Aaga3LBcOIJs5S8+vI2djIe9C5pWVQU/RPjoWcjibA5d9AD7/UiaWT+p4
 wBMFAYi96c2dvUVXwt5fqWDAU2iQplA08DjKGgogqy+pQNbtc9RAXeJMD8nW4vMsHXVP
 l2rg==
X-Gm-Message-State: AFuF++mRnrEAiP0200bAM8CcU9pMrcneky5bK6fqtvPu6fONBYcf3h/w
 FNFw23B2fwdHPbE9Xxpkh+meOhU8MyuF+cfl2FKoggDy4EgVzVa3IWfDVKZpmkb1FrWaF3389oq
 sezxGmwPOVjHsLbbtpVoxhIKU4NLYh+ruI480MdvCw+y9q/fh3XkCEBWGfGtqpYfM0iipwkpP92
 SUEXeubw==
X-Gm-Gg: AR+sD13c+ktD5a75oj6cYDG1+yJJlapUrUMKMD8BbcVlmxskXJPDnQMPbi5SOTkTCdI
 yy39L79WigGJiFrK/KjOw3CRPTbSXIPi7+VWTHnQmHAWINaRaiYukql2EWU6BUz8oWa7u7SuiWS
 oVgB1WpTKWoMQ6+ctVjOhVDBIz8Pw6c4RUW3CWWO2F+Nx74L9NGWYDJC8851eTJ0tjmxlj5ZKLf
 Ls1yNx0UxaPF8/U0bxO7XfjNqjUirGhCnLp0iY9JhTy1fEbXki3GLHU039fPLoTfxxFTdQlT+fW
 yg6EVGUrtGu59ZXsX00+U3y9y6XXFV1KJdPDnvJcyzjfSibLnmywSuKE5Q72c6tsjSbHyOqmHvz
 TkZHMPq/jTH1+BmCbca3HOViz+U8CkdVbDCdCfDne8N1UDCup3tAnEJUR+umeu3UdFvEOjiJKW4
 pPThMxpznEdUWlR/3xCZjuUVvM9qI1eqlYg3qRnEOwbd34lfgsRUs0fMb54WHENP4u7qtQViRG1
 bnGZciolRUQja18XQtiIs8w5YsSdhj7c6UIWxBqfAkOFmJUlg8LuE7jL4W/L/t5CvjvOg5bVrAi
 1Hsx6NCmw+jrAmF+ni8nkyWEwrnzHFGdtAuLRLjclKSFMfT9/A97JlZn/Umlfg==
X-Received: by 2002:a17:907:f509:b0:c19:49ee:19b9 with SMTP id
 a640c23a62f3a-c246a654f4emr4367478366b.15.1787672743738; 
 Tue, 25 Aug 2026 08:45:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ad70sm14607166b.38.2026.08.25.08.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:45:41 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:45:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: 5666e7ada4aee52a1277fc8f24614b6d9f2f418e
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <90776f3c56f5578b80955511c01f16c3b7299a5d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytLS-0002Cz-JP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: run-cppcheck.sh:
 Make it more configurable
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8684714299751479825=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8684714299751479825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ttLjPMZJAM4="; charset=UTF-8

--ttLjPMZJAM4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1868?usp=3Demail

to review the following change=2E


Chang=
e subject: run-cppcheck=2Esh: Make it more configurable
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

run-cppcheck=2Esh: Make it more=
 configurable

- Allow to easily control verbosity and automatically
  adju=
st to the verbosity of the Make run
- Allow to easily control check level=
=2E With exhaustive the
  check can take hours (due to options=2Ec), so we =
couldn't
  use that in CI

Change-Id: I65beb37a2d822333aa888de1baf11dfcb849=
0e90
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M Makef=
ile=2Eam
M dev-tools/run-cppcheck=2Esh
2 files changed, 19 insertions(+), 3=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/68/1868/1

diff --git a/Makefile=2Eam b/Makefile=2Eam
index feeaab=
b=2E=2Ed97a982 100644
--- a/Makefile=2Eam
+++ b/Makefile=2Eam
@@ -96,4 +96,=
5 @@
 	BUILD_DIR=3D"$(abs_top_builddir)" \
 	SOURCE_DIR=3D"$(abs_top_srcdir=
)" \
 	INCLUDE_FLAGS=3D"$(LIBNL_GENL_CFLAGS)" \
+	CPPCHECK_VERBOSITY=3D"$(V=
)" \
 		"$(top_srcdir)/dev-tools/run-cppcheck=2Esh"
diff --git a/dev-tools/=
run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index a7aa3c4=2E=2Ec666bb5 =
100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
=
@@ -2,22 +2,37 @@
 
 set -eu
 
+: ${CPPCHECK_VERBOSITY:=3D0}
+: ${CPPCHECK_=
CHECK_LEVEL:=3Dexhaustive}
+
+if [ "${CPPCHECK_VERBOSITY}" -eq 0 ]; then
+ =
   verbosity_arg=3D"-q"
+else
+    verbosity_arg=3D"-v"
+fi
+
+disable_arg=
=3D
+if [ "${CPPCHECK_CHECK_LEVEL}" !=3D exhaustive ]; then
+    # suppress=
 all the information that we should use exhaustive
+    disable_arg=3D"--di=
sable=3Dinformation"
+fi
+
 SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SO=
URCE[0]}"))
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$PWD}
=
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_DIR}/cppcheck_build_dir"
-=
COMMON_ARGS=3D"-j$(nproc) -q \
+COMMON_ARGS=3D"-j$(nproc) ${verbosity_arg} =
\
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
  -I=
=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
  -I=2E/src/compat/ -I=2E/sr=
c/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \
  -I${BUILD=
_DIR} -I${BUILD_DIR}/include/ \
- --enable=3Dall \
+ --enable=3Dall ${disab=
le_arg} \
  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \
  --=
library=3Dopenssl=2Ecfg \
  --suppressions-list=3D${SCRIPT_DIR}/cppcheck-su=
ppression \
  --cppcheck-build-dir=3D${CPPCHECK_DIR} \
- --check-level=3Dex=
haustive --max-configs=3D10 \
+ --check-level=3D${CPPCHECK_CHECK_LEVEL} --m=
ax-configs=3D10 \
  --error-exitcode=3D1"
 
 set -x

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
=
Gerrit-Change-Number: 1868
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ttLjPMZJAM4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">run-cppcheck=2Esh: Make it more configurable<br><br>- Allow to easily =
control verbosity and automatically<br>  adjust to the verbosity of the Mak=
e run<br>- Allow to easily control check level=2E With exhaustive the<br>  =
check can take hours (due to options=2Ec), so we couldn&#39;t<br>  use that=
 in CI<br><br>Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M Mak=
efile=2Eam<br>M dev-tools/run-cppcheck=2Esh<br>2 files changed, 19 insertio=
ns(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/68/1868/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Makef=
ile=2Eam b/Makefile=2Eam</span><br><span>index feeaabb=2E=2Ed97a982 100644<=
/span><br><span>--- a/Makefile=2Eam</span><br><span>+++ b/Makefile=2Eam</sp=
an><br><span>@@ -96,4 +96,5 @@</span><br><span> 	BUILD_DIR=3D&quot;$(abs_to=
p_builddir)&quot; \</span><br><span> 	SOURCE_DIR=3D&quot;$(abs_top_srcdir)&=
quot; \</span><br><span> 	INCLUDE_FLAGS=3D&quot;$(LIBNL_GENL_CFLAGS)&quot; =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CPPCHECK_VERBOSIT=
Y=3D&quot;$(V)&quot; \</span><br><span> 		&quot;$(top_srcdir)/dev-tools/run=
-cppcheck=2Esh&quot;</span><br><span>diff --git a/dev-tools/run-cppcheck=2E=
sh b/dev-tools/run-cppcheck=2Esh</span><br><span>index a7aa3c4=2E=2Ec666bb5=
 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+=
++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -2,22 +2,37 @@</span><b=
r><span> </span><br><span> set -eu</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+: ${CPPCHECK_VERBOSITY:=3D0}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+: ${CPPCHECK_CHECK_LEVEL:=3Dexha=
ustive}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;${CPPCHECK_VERBOSITY=
}&quot; -eq 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    verbosity_arg=3D&quot;-q&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    verbosity_arg=3D&quot;-v&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+disable_arg=3D</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;${CPPCHECK_CH=
ECK_LEVEL}&quot; !=3D exhaustive ]; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    # suppress all the information that we should use =
exhaustive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    disab=
le_arg=3D&quot;--disable=3Dinformation&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH=
_SOURCE[0]}&quot;))</span><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}<=
/span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br><span> : ${INCLUDE_FLAGS:=
=3D}</span><br><span> CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-COMMON_ARGS=3D&q=
uot;-j$(nproc) -q \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
COMMON_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \</span><br><span>  -DMBEDT=
LS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \</span><br><span>=
  -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \</span><br><span>  -I=2E/=
src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/aut=
h-pam/ \</span><br><span>  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- --enable=3Dall \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ --enable=3Dall ${disable_arg} =
\</span><br><span>  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecf=
g \</span><br><span>  --library=3Dopenssl=2Ecfg \</span><br><span>  --suppr=
essions-list=3D${SCRIPT_DIR}/cppcheck-suppression \</span><br><span>  --cpp=
check-build-dir=3D${CPPCHECK_DIR} \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- --check-level=3Dexhaustive --max-configs=3D10 \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ --check-level=3D${CPPCHECK_CHEC=
K_LEVEL} --max-configs=3D10 \</span><br><span>  --error-exitcode=3D1&quot;<=
/span><br><span> </span><br><span> set -x</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868=
?usp=3Demail">change 1868</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1868?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1868 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--ttLjPMZJAM4=--


--===============8684714299751479825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8684714299751479825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8684714299751479825==--

