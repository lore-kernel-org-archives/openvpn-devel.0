Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BC606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q+0ObW5Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HvG48U6i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QXfdyfdt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FFg6QZhk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q/6PGBh9gE3eeGlj7JL5NpQu0HXS+Trfv6tUWXRuSsk=; b=Q+0ObW5ZGaU6AHj7fssnMSzxiy
	EEWca7SNMhF1XyYbjZ6MiOB3gdcTljLayMfGaTzFuwLRAlBGqLDJnsE1SjE6m0qiSgd3u1rstbPvc
	li8ZGsmEaX2MLIzMzHmOje8CYnOKhtfbyu5p0hKOU4dS6OTB5pCvpdhAs7UbpjgWGu18=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL3EG-0000000015X-3D8e;
	Sun, 25 Oct 2026 18:46:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL3EF-0000000015L-31iO
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:45:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Svn24vuMLpYLQ0cjgqPL89HcPr/eOoDEarK/4TpJEQ=; b=HvG48U6iMMXxQGOQJAOWzDAjYS
 p6G2AlFNRdPodxALsjtnMjl/TkZypUO7YB0gKfFVHi8Cg+Thmu2skDTBBnZmwhpko8P2YXgwVUwRW
 dP6jZz8L2T1t4bfwFhhDz02Ix3dEhK275adONZtO7TN5lyPH4nBDsovOCx4Fed1jT468=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Svn24vuMLpYLQ0cjgqPL89HcPr/eOoDEarK/4TpJEQ=; b=QXfdyfdtmU+jXJ0ZRNIhx7HkDx
 fl5ZA7Xvt1idrE5PZKGLZ+B9zPwlJKiswVh5MYLeVVHxY446SF7jpOGFXziI5IdrONJ7ZutIBI7Eg
 3iouzwt/2ZUE0DmwhZ1LyL5w91MVP8qh89NNGtptTwXV5zGBf24XtEhOKaIERsKIEgb4=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL3EE-000000000EC-44Rh for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:45:59 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so950814f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792953952; x=1793558752; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0Svn24vuMLpYLQ0cjgqPL89HcPr/eOoDEarK/4TpJEQ=;
 b=FFg6QZhkI9BCdZ4Bzf0F+TbzBj6Wdfli3O6hvF7BERsV5OFMBVN8fS6czTEffczOtB
 KOWjRqvMr9Mz433X4fO0M2RO7O8JuLEermGx7KsSuk6RI8hA9vcHoHeQr/09NT6R+u+A
 U16bH5zXLWUu85+ZM79kym7Af+0JSrE159JBxRqzvJFxe0fK2vPsBgDctZUuTh1pc7qq
 hO8HBc9M+Yo4Oi7noVvX9gaZXsOP4q8FjWom9e4foq5U/IhaO+y0+2IwpwKuCXbm+9UV
 I+4BkKVFgx2zDYxBFRiegHdiR3ok/ABoBzt/b9MdDP2+fPG5s3g+z7kcuuftiH1vj3CJ
 bnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792953952; x=1793558752;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0Svn24vuMLpYLQ0cjgqPL89HcPr/eOoDEarK/4TpJEQ=;
 b=Y3tneMqXcWE20IQ62b34wPlFIP7+E/ARcDf+Zgk1/YzE9k8wIfrYkr8vQLJJnkLoV4
 WFxHQWbl8lt6JSOPDh2YfmniK/Giipf2m+Ef4UvZksTyG/HQcQitge8yNk9msQfBRE3D
 CGNKNLulUrt7fZmU1wWfvRwvoY5pAA4B43JQC+z8h71AdsOHoLYgKwmWoXbjMceDyD3B
 6UPKHzS3+JAeDf8HU0oxRTiSL/tQk/ooTuiE8NEV0kFuKExB9B/RNE8VCs/CxChshwRa
 P9v7r9zlxRwLpXG6GVbds6zq75P5hVSAyhD+QccwgeAwAzhCMuDousFGhhRoZNdNBVlJ
 GLhQ==
X-Gm-Message-State: AFq9FYLZ1Hj1B74UAYeVIG/RifM9XaHk29GC5Bcv7rx1txDk5dyIrAyl
 dWmXbuokQHdMIRmeHKMMyW48RGbvc38r4sVfKa6NCdM1BNQp4FdPArpahL50xaackmN8cHtNmLM
 iiDQUS1Z2te9j9gJ+RBs1aoqtSvzs+nvpJIIFy5Y0NjlD0qgeeTTFylpAP5NYHhz+iadi
X-Gm-Gg: AYBFou1ffsY55yRd7Nn6+bxwz5wgBENUFkac3X1mHhKq/LvFpHCdpPnmgTi+/29ZeO9
 HquA6u6l3hvhbsPALishrLYCDl6S77qsZmu2Jo9iZK5Bu9hkOmKcE2WdUW2FoNDv0U0cVu53xA3
 miZM988IcX1uadMA7NkxoU5E9YO3/2cqa3hKBedhmW5+/gtw096tu9WGFP4mO8EQHh1usar5sva
 VaA47Q971X8YCUNrUFSYFR0tHUKb9j8XXGcwszuaxCDqCPOdW3FPH2PqJuCrGt4lK1xMCGtXyr6
 TWu7S347EBAX5rc8aXm/wn7ri+WDFXQYGLavTcZwbVSLrQhQNcZqKylauJCef2cURpDBz+2ft43
 f3QZBVlVN7TbUP5SXFjU8h8H27uHHhsrJGfIhODRc4dCgnKYFztiju3X32Ab/2gqIrvbJVcHz9A
 2Z8MQmLN9YSBH18aNj4qlBPh5dF/azFZuinfqNzBirt0x4pSNc7oFIkp4BSFiIyn05JNm2SSrZk
 cYJx7czxPUSaSplc9y+TaJIyoFV/lVKkCpYT4O5OnbS55XKMrEzzuMQ/4m1ckoQHW+iYEI2edFg
 xsBD2RvN4j1LvF5CPJ5nwv7LN8j0ILqYrfuQtyj/oOYHZVZIqKSEqnskrB9ugHGSnF/jyT4F+pX
 OE4iB/nS6b8Wk9EGuVxXfoqpc0HedrjlGuPkTh9S1zw==
X-Received: by 2002:a05:600c:3b9b:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a35acaffa9mr93198915e9.19.1792953951773; 
 Sun, 25 Oct 2026 11:45:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ae28sm143248235e9.2.2026.10.25.11.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 11:45:51 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 18:45:49 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
X-Gerrit-Change-Number: 2018
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2018?usp=email>
X-Gerrit-Commit: ccd058e75be6af15c8a2427acb76be3a7a641213
In-Reply-To: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
References: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzMxMzQyMDAwLkk0MWJjMGZjZDQ3NTk0NGYzYzQ3MDE3MDVhNDZmNWE5MTE0ODBiMjgzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9bdf2ae57fbe40639f6d2816bc0ab43eca13a382-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xL3EE-000000000EC-44Rh
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
Content-Type: multipart/mixed; boundary="===============2366832899981135867=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2366832899981135867==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dldcbywyunw="; charset=UTF-8

--Dldcbywyunw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Gert Doering


Change subject: Make run-cppcheck=2Esh run on Fre=
eBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Make run-cppcheck=2Esh run on FreeBSD and macOS

FreeBSD has no /bin/bash=
, while macOS has an old 3=2E2=2E57 version from 2007=2E

Also work around =
the differences in readlink and different methods to
get the number of cpu =
cores=2E

Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
Signed-off-b=
y: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018
Me=
ssage-Id: <20261022170411=2E20830-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40103=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/=
run-cppcheck=2Esh
1 file changed, 9 insertions(+), 3 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2018/2

diff=
 --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 3c=
71c83=2E=2E58609b2 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools=
/run-cppcheck=2Esh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 
 set=
 -eu
 
@@ -17,12 +17,18 @@
     disable_arg=3D"--disable=3Dinformation"
 fi=

 
-SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+if [ $(unam=
e) =3D "Darwin" ] || [ $(uname) =3D "FreeBSD" ]; then
+    SCRIPT_DIR=3D$(d=
irname $(readlink -f "${BASH_SOURCE[0]}"))
+    num_procs=3D$(sysctl -n hw=
=2Encpu)
+else
+    SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}=
"))
+    num_procs=3D$(nprocs)
+fi
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 =
: ${BUILD_DIR:=3D$PWD}
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_DIR=
}/cppcheck_build_dir"
-COMMON_ARGS=3D"-j$(nproc) ${verbosity_arg} \
+COMMON=
_ARGS=3D"-j${num_procs} ${verbosity_arg} \
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DM=
BEDTLS_SSL_KEYING_MATERIAL_EXPORT \
  -I=2E/include/ -I=2E/tests/unit_tests=
/openvpn/ \
  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -=
I=2E/src/plugins/auth-pam/ \

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2018?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
Gerrit-Change-Num=
ber: 2018
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Dldcbywyunw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/201=
8?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">Make run-cp=
pcheck=2Esh run on FreeBSD and macOS<br><br>FreeBSD has no /bin/bash, while=
 macOS has an old 3=2E2=2E57 version from 2007=2E<br><br>Also work around t=
he differences in readlink and different methods to<br>get the number of cp=
u cores=2E<br><br>Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283<br>S=
igned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2018<br>Message-Id: &lt;20261022170411=2E20830-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40103=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/run-cppcheck=2Esh<br>=
1 file changed, 9 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2018/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=
=2Esh</span><br><span>index 3c71c83=2E=2E58609b2 100755</span><br><span>---=
 a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=
=2Esh</span><br><span>@@ -1,4 +1,4 @@</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#!/bin/bash</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#!/usr/bin/env bash</span><br><span> </span><br><span> set -eu</spa=
n><br><span> </span><br><span>@@ -17,12 +17,18 @@</span><br><span>     disa=
ble_arg=3D&quot;--disable=3Dinformation&quot;</span><br><span> fi</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-SCRIPT_DIR=3D=
$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+if [ $(uname) =3D &quot;Darwin&quot; ] =
|| [ $(uname) =3D &quot;FreeBSD&quot; ]; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SCRIPT_DIR=3D$(dirname $(readlink -f &quot;${=
BASH_SOURCE[0]}&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    num_procs=3D$(sysctl -n hw=2Encpu)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&qu=
ot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    num_procs=
=3D$(nprocs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</spa=
n><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}</span><br><span> : ${BUI=
LD_DIR:=3D$PWD}</span><br><span> : ${INCLUDE_FLAGS:=3D}</span><br><span> CP=
PCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-COMMON_ARGS=3D&quot;-j$(nproc) ${verbosi=
ty_arg} \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMON_ARG=
S=3D&quot;-j${num_procs} ${verbosity_arg} \</span><br><span>  -DMBEDTLS_SSL=
_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \</span><br><span>  -I=
=2E/include/ -I=2E/tests/unit_tests/openvpn/ \</span><br><span>  -I=2E/src/=
compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pa=
m/ \</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2018?usp=3Demail">change 2018</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I41bc0fcd475944f3c4701705=
a46f5a911480b283 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2018 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--Dldcbywyunw=--


--===============2366832899981135867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2366832899981135867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2366832899981135867==--

