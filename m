Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6631CCC6B1D
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEQ9sLY+CfsQAKSODYFqEIY6nO4KMoJRPCr3iXqbM8E=; b=W+XMiqAs0v7ZZXYSOtQnc/Mo69
	hD0s10B0LxXxIvV8r6F+PJtFPiP6avsK7RwJDD297r2zrgViOEOd5TEe8u4xaFJGLAeApjGZtxazW
	8GOvGT/TU0RaUfTEBI1buxRU9FZ3p8/9HY/maeKr31KXrSp79ZpHt/DDa62fPH5QJ2uU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGz1J-00005G-U3;
	Wed, 14 Oct 2026 13:27:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGz1I-000058-5b
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:27:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I7+ArsZLTM9Iv/sNjTJ7NoZ+OupQ00BF3pqAolhT6Bw=; b=ihLtoa7wm4yQz8rEcD7OtqWEff
 Y8n4bfm4iSFsRJ/XYK4H0x17oZhDHSX3SBbOUf1TBg+FakvrY/BVf4reAhQDoBNnImst8oOmTFOc9
 uapWcGoB0sEuLxjDZcHrsDo3Qn7bAjQnYqg2/mVrpy+wTFqHYgD5OOpw2bP2ekcHR5Z0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I7+ArsZLTM9Iv/sNjTJ7NoZ+OupQ00BF3pqAolhT6Bw=; b=e
 JMFa9+xjw2+yP4c50ATj2bWxOEFu0wocCEl7ZCq1lhhCgZ+l+YsucDxnsZiViE3HYqpI8+mY05krf
 qiHkdDVTTG6dFrmmzb6KrE7TMfm4GRcRuTXtYzzh8b9HmFhQaI1FfHI0xfW/6oUVqn79x/02UX68I
 E/1zszhHFocMeV78=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGz18-00027H-N7 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:27:45 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso11414185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791984452; x=1792589252; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I7+ArsZLTM9Iv/sNjTJ7NoZ+OupQ00BF3pqAolhT6Bw=;
 b=GA0Wutca/2gq70QJxIzgOXBSWRAln9AGRc8/bYk6SUJrjJfr4OVNCuBgejwuYJMWq0
 xBbfM2NhmHYxCAoWf51Kn/8oBuxmvQ1PWzlfko3+nw6dvbCkK/I2A7beXq9b7PNWvWjx
 KAkYo4UduBHpNKdnQxqmV2n4ny8JGkGeIfMXTVdJaVyArpSECUpLFWd9YDa9VOnmVLY9
 m6WIJwHQhxLTjXKqVmwmIHBJMQz7f0A87/YCrgyEYOEquagEgOv66fU0mNtSxlJIVVZr
 AYgSFVWKV9jLXIJWSN2ysEMHKAsjk1A+U2ffhWyjSgz1vk9/CSTyXpNxiNDDYBN9h6/4
 QX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791984452; x=1792589252;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I7+ArsZLTM9Iv/sNjTJ7NoZ+OupQ00BF3pqAolhT6Bw=;
 b=P25PwkxaQC/bjHaEDmwbTxq3ZalsPz/nezxoxKbq3kqs27B7gWe7mW16O4eBBSIZkL
 OvTkn7odKstm9+97VVyL/DU25stFey7DmJrzEbKlhZSMcyYG7P9i+YZ20jku5CIgR7TA
 n7ylEsOfPIHkqq/5r3uXv+kxWbcEM6hYV3LJe88GuXo7k49WuvymvO124hgio7D8lZu+
 3suJAEoK37SEdJVZNdq3gXFI+lb2C+j4LUb5w9qK0py+PhjoaFJwLRPr3Nn2pGuuyFds
 sqv/BCZZhe9+jo4zj+yjQl4NgP7cXgy+YRYMZK39FRCoNNIpfvn5/qIzxMXHxmcWwadT
 fOAA==
X-Gm-Message-State: AFq9FYLZ2vpSCB5bxB3QwAaUF9fkNAnL5BB2nJ3X51U4kowQZe0oqz6p
 OGwmvrum7AJzj66YEu6OCaz7YYq+jObx7Wojl7KiXBpLRvQEGV2suaS394bJHk08ByLQ14Ow9KG
 FhvhrJoqH9BZY2O01cUR4YCBLsgXA5kTB7HifO/KLzbM96EqMN+VbDoX6WxaQWpo98I26
X-Gm-Gg: AYBFou2izps/B8VrTHcrcQljPKT/g/s1sYWuLE7TK3M3PAqT9Dag/iuPrQOwBjnNrJr
 DmV3Cx81RVbxRu7XGc5BCpRwpr6/9Fsd+jD1+C8PaZRay+5WaB5JJ6ntTEL9aJzw5lGVz41OS6m
 xCUznHjkKFqx78ovTPq74jmU+qDl0phQ/qznrVMzBzbdbzs9DOcLMtRHCReoE2lzVXX5E4UbnsC
 8CRDrhHM60IWZObT+yCKdGlx2KlWPHvhgOYo5zJXtP8IpNg7Ena0gmGlkgFQWP5fusCYBfvWMb7
 y6fGWH4+ksiemMspQJngy+JBqc5AflkNUj4V/DWznG/OBhoinLWLq4LmXgwtor0E7SLEnGnAgHe
 SAlp4+pZBJWncpkYCzO4Du3sHjU3nNnlFNXzSTui2S1t/DcZ1ymwp5Yl4WySG0pOX4ZX1j0+SFd
 HY6APhxrtzG9TIb7an1jWYrrMIOLWmEFVWvBs0SNwAGxGTpkHdAiMY9vudCi5qByYc2+EHihxt8
 5EuKnPNH3RDkET1RT8X1azSKv4ApOFzGx2ysBnazRVbazi5ViED6/VZVGG+KJR8iX2I2VKtyMps
 ZH52MWY8oHZwPbSXp64G0GfO0f37r94LqvzwKMFamK8yZVzKImCDzATa2WpE
X-Received: by 2002:a05:600c:8b64:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-4a18e498851mr335758375e9.19.1791984450380; 
 Wed, 14 Oct 2026 06:27:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72c7e36sm6482286f8f.37.2026.10.14.06.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:27:29 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 13:27:26 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: ac97057771001f56bd1c49200febaae4bf0a43ee
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a3cb619da279bad84c75acbe87a4e437e3a7617-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGz18-00027H-N7
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2961069873694241227=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2961069873694241227==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ww8JveovDX0="; charset=UTF-8

--Ww8JveovDX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1663?usp=3Demail

to look at the new patch set (#32)=2E

The =
following approvals got outdated and were removed:
Code-Review+2 by R=C4=83=
zvan Cojocaru

The change is no longer submittable: Code-Review and checks~=
ChecksSubmitRule are unsatisfied now=2E


Change subject: Remove instances =
of constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove instances of constParameterPointer c=
ppcheck warnings

This requires a few suppressions since cppcheck
doesn't q=
uite understand the different code-paths
implemented by preprocessor define=
s=2E

Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Signed-off-by: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/cppcheck-suppres=
sions=2Exml
M sample/sample-plugins/client-connect/sample-client-connect=2E=
c
M sample/sample-plugins/defer/multi-auth=2Ec
M sample/sample-plugins/keyi=
ng-material-exporter-demo/keyingmaterialexporter=2Ec
M src/openvpn/buffer=
=2Eh
M src/openvpn/clinat=2Ec
M src/openvpn/comp=2Ec
M src/openvpn/comp=2Eh=

M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/dco=2Ec
M =
src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_interna=
l=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn/e=
rror=2Ec
M src/openvpn/error=2Eh
M src/openvpn/event=2Ec
M src/openvpn/even=
t=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/ini=
t=2Ec
M src/openvpn/init=2Eh
M src/openvpn/interval=2Eh
M src/openvpn/list=
=2Ec
M src/openvpn/list=2Eh
M src/openvpn/manage=2Ec
M src/openvpn/manage=
=2Eh
M src/openvpn/mbuf=2Ec
M src/openvpn/mbuf=2Eh
M src/openvpn/mss=2Ec
M =
src/openvpn/mss=2Eh
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/ope=
nvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn=
/multi_io=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/networking_iproute=
2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/occ=2Eh
M src/openvp=
n/openssl_compat=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options_parse=
=2Ec
M src/openvpn/otime=2Ec
M src/openvpn/otime=2Eh
M src/openvpn/proto=2E=
h
M src/openvpn/proxy=2Ec
M src/openvpn/proxy=2Eh
M src/openvpn/ps=2Ec
M sr=
c/openvpn/ps=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvp=
n/push_util=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M src=
/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/openvpn/socket=2Ec
M sr=
c/openvpn/socket=2Eh
M src/openvpn/socket_util=2Eh
M src/openvpn/socks=2Ec
=
M src/openvpn/socks=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
M src/o=
penvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_open=
ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M src/openvpn/s=
sl_verify=2Ec
M src/openvpn/ssl_verify=2Eh
M src/openvpn/status=2Ec
M src/o=
penvpn/status=2Eh
M src/openvpn/tun=2Ec
M src/openvpn/tun=2Eh
M src/openvpn=
/tun_afunix=2Ec
M src/openvpn/tun_afunix=2Eh
M src/openvpn/vlan=2Ec
M src/o=
penvpn/vlan=2Eh
M src/openvpn/win32=2Eh
M src/openvpnmsica/openvpnmsica=2Ec=

M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/mock_manageme=
nt=2Ec
M tests/unit_tests/openvpn/siphash_openssl=2Ec
M tests/unit_tests/op=
envpn/siphash_openssl=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
M tests/=
unit_tests/openvpn/test_user_pass=2Ec
90 files changed, 401 insertions(+), =
287 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/63/1663/32

diff --git a/dev-tools/cppcheck-suppressions=2Exml b=
/dev-tools/cppcheck-suppressions=2Exml
index 9d8c202=2E=2Ebd24c3b 100644
--=
- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cppcheck-suppress=
ions=2Exml
@@ -9,9 +9,6 @@
     <id>constParameterCallback</id>
   </suppre=
ss>
   <suppress>
-    <id>constParameterPointer</id>
-  </suppress>
-  <su=
ppress>
     <id>unusedFunction</id>
   </suppress>
   <suppress>
@@ -65,6 =
+62,97 @@
     <id>badBitmaskCheck</id>
     <fileName>tests/unit_tests/ope=
nvpn/test_pkt=2Ec</fileName>
   </suppress>
+  <!-- IGN: we use casts to re=
move const -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <file=
Name>src/openvpn/buffer=2Eh</fileName>
+    <symbolName>buf</symbolName>
+ =
 </suppress>
+  <!-- FP: const silently removed due to pointer arithmetic -=
->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/ope=
nvpn/buffer=2Ec</fileName>
+    <symbolName>buf</symbolName>
+  </suppress>=

+  <!-- IGN: external -->
+  <suppress>
+    <id>constParameterPointer</id=
>
+    <fileName>/usr/include/*</fileName>
+  </suppress>
+  <!-- IGN: too =
many false-positives due to stubs -->
+  <suppress>
+    <id>constParameter=
Pointer</id>
+    <fileName>tests/unit_tests/openvpn*/test_*</fileName>
+  =
</suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileNam=
e>tests/unit_tests/openvpn/mock_*</fileName>
+  </suppress>
+  <!-- IGN: to=
o many false-positives due to library/platform-specific code -->
+  <suppre=
ss>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/crypto*<=
/fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>=

+    <fileName>src/openvpn/ssl_*</fileName>
+  </suppress>
+  <suppress>
+=
    <id>constParameterPointer</id>
+    <fileName>src/openvpn/dco*</fileNam=
e>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <f=
ileName>src/openvpn/socket=2E*</fileName>
+  </suppress>
+  <!-- FP: const =
is only possible on some platforms
+       These might easily hide valid is=
sues but we need to compromise
+       for developer sanity=2E
+       Inli=
ne suppressions are often too ugly since they need to go in
+       between=
 our return type line and the function name=2E=2E=2E
+  -->
+  <suppress>
+=
    <id>constParameterPointer</id>
+    <fileName>src/openvpn/dns=2Ec</file=
Name>
+    <symbolName>duri</symbolName>
+  </suppress>
+  <suppress>
+    =
<id>constParameterPointer</id>
+    <fileName>src/openvpn/error=2Ec</fileNa=
me>
+    <symbolName>gc</symbolName>
+  </suppress>
+  <suppress>
+    <id>=
constParameterPointer</id>
+    <fileName>src/openvpn/forward=2Ec</fileName=
>
+    <symbolName>dco</symbolName>
+  </suppress>
+  <suppress>
+    <id>c=
onstParameterPointer</id>
+    <fileName>src/openvpn/manage=2Ec</fileName>
=
+    <symbolName>man</symbolName>
+  </suppress>
+  <suppress>
+    <id>con=
stParameterPointer</id>
+    <fileName>src/openvpn/misc=2Ec</fileName>
+   =
 <symbolName>up</symbolName>
+  </suppress>
+  <suppress>
+    <id>constPar=
ameterPointer</id>
+    <fileName>src/openvpn/options=2Ec</fileName>
+    <=
symbolName>options</symbolName>
+  </suppress>
+  <suppress>
+    <id>const=
ParameterPointer</id>
+    <fileName>src/openvpn/tun=2Ec</fileName>
+    <s=
ymbolName>gc</symbolName>
+  </suppress>
+  <!-- IGN: weird issue with MinG=
W debug build throwing -Werror=3Dmaybe-uninitialized
+       for no good re=
ason -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>s=
rc/openvpn/buffer=2Eh</fileName>
+    <symbolName>p</symbolName>
+  </suppr=
ess>
   <!-- FP: cppcheck seems to have wrong signature of DeviceIoControl(=
) -->
   <suppress>
     <id>constVariablePointer</id>
diff --git a/sample/=
sample-plugins/client-connect/sample-client-connect=2Ec b/sample/sample-plu=
gins/client-connect/sample-client-connect=2Ec
index 420de61=2E=2Ecbd98e8 10=
0644
--- a/sample/sample-plugins/client-connect/sample-client-connect=2Ec
+=
++ b/sample/sample-plugins/client-connect/sample-client-connect=2Ec
@@ -344=
,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_connect(struct plugin_context=
 *context, const char **argv, const char **envp)
+openvpn_plugin_client_con=
nect(const struct plugin_context *context, const char **argv, const char **=
envp)
 {
     /* log environment variables handed to us by OpenVPN, but
   =
   * only if "setenv verb" is 3 or higher (arbitrary number)
@@ -465,7 +465=
,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v2(struct plugin_context =
*context,
-                                       struct plugin_per_client_=
context *pcc,
+                                       const struct plugin_p=
er_client_context *pcc,
                                        struct open=
vpn_plugin_string_list **return_list)
 {
     time_t time_left =3D pcc->sle=
ep_until - time(NULL);
diff --git a/sample/sample-plugins/defer/multi-auth=
=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec
index bacf557=2E=2Ecdd616=
f 100644
--- a/sample/sample-plugins/defer/multi-auth=2Ec
+++ b/sample/samp=
le-plugins/defer/multi-auth=2Ec
@@ -255,7 +255,7 @@
 }
 
 static bool
-do_a=
uth_user_pass(struct plugin_context *context, const char *username, const c=
har *password)
+do_auth_user_pass(const struct plugin_context *context, con=
st char *username, const char *password)
 {
     plog(context, PLOG_NOTE, "=
expect_user=3D%s, received_user=3D%s, expect_passw=3D%s, received_passw=3D%=
s",
          np(context->test_valid_user), np(username), np(context->test_=
valid_pass), np(password));
@@ -279,7 +279,7 @@
 
 
 static int
-auth_user_=
pass_verify(struct plugin_context *context, struct plugin_per_client_contex=
t *pcc,
+auth_user_pass_verify(const struct plugin_context *context, struct=
 plugin_per_client_context *pcc,
                       const char *argv[],=
 const char *envp[])
 {
     /* get username/password from envp string arra=
y */
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyin=
gmaterialexporter=2Ec b/sample/sample-plugins/keying-material-exporter-demo=
/keyingmaterialexporter=2Ec
index 204374b=2E=2E41c5c4f 100644
--- a/sample/=
sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec
+++=
 b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexport=
er=2Ec
@@ -187,7 +187,7 @@
 }
 
 static void
-file_store(char *file, char *=
content)
+file_store(const char *file, const char *content)
 {
     FILE *f=
;
     if (!(f =3D fopen(file, "w+")))
@@ -203,7 +203,7 @@
 server_store(st=
ruct openvpn_plugin_args_func_in const *args)
 {
     struct plugin *plugin=
 =3D (struct plugin *)args->handle;
-    struct session *sess =3D (struct s=
ession *)args->per_client_context;
+    const struct session *sess =3D args=
->per_client_context;
 
     char file[MAXPATH];
     snprintf(file, sizeof=
(file) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ -215,7 +215,7 @@
 client_=
store(struct openvpn_plugin_args_func_in const *args)
 {
     struct plugin=
 *plugin =3D (struct plugin *)args->handle;
-    struct session *sess =3D (=
struct session *)args->per_client_context;
+    const struct session *sess =
=3D args->per_client_context;
 
     char *file =3D "/tmp/openvpn_sso_user"=
;
     ovpn_note("app session file: %s", file);
diff --git a/src/openvpn/bu=
ffer=2Eh b/src/openvpn/buffer=2Eh
index 58e10f0=2E=2E063a2d4 100644
--- a/s=
rc/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1920,7 +1920,7 @@
  =
* @param a  The arena to test=2E
  */
 static inline bool
-gc_defined(struc=
t gc_arena *a)
+gc_defined(const struct gc_arena *a)
 {
     return a->list=
 !=3D NULL;
 }
diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec=

index dcef924=2E=2Ed72d42a 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/o=
penvpn/clinat=2Ec
@@ -158,7 +158,7 @@
 #endif
 
 static void
-print_pkt(str=
uct openvpn_iphdr *iph, const char *prefix, const int direction, const msgl=
vl_t msglevel)
+print_pkt(const struct openvpn_iphdr *iph, const char *pref=
ix, const int direction, const msglvl_t msglevel)
 {
     struct gc_arena g=
c =3D gc_new();
 
diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec
=
index b88b79f=2E=2E387a7c4 100644
--- a/src/openvpn/comp=2Ec
+++ b/src/open=
vpn/comp=2Ec
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */
 
 bool
-check_comp=
ression_settings_valid(struct compress_options *info, msglvl_t msglevel)
+c=
heck_compression_settings_valid(const struct compress_options *info, msglvl=
_t msglevel)
 {
     /*
      * We also allow comp-stub-v2 here as it techn=
ically allows escaping of
diff --git a/src/openvpn/comp=2Eh b/src/openvpn/c=
omp=2Eh
index 29a90a2=2E=2Ead80243 100644
--- a/src/openvpn/comp=2Eh
+++ b/=
src/openvpn/comp=2Eh
@@ -91,7 +91,7 @@
  * flags of allow-compression and a=
lso the whether algorithms are compiled
  * in
  */
-bool check_compression=
_settings_valid(struct compress_options *info, msglvl_t msglevel);
+bool ch=
eck_compression_settings_valid(const struct compress_options *info, msglvl_=
t msglevel);
 
 #ifdef USE_COMP
 #include "buffer=2Eh"
diff --git a/src/ope=
nvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 1703d4d=2E=2E3d3ab0c 100644
=
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1105,7 +1105,=
7 @@
 }
 
 static bool
-key_is_zero(struct key *key, const struct key_type =
*kt)
+key_is_zero(const struct key *key, const struct key_type *kt)
 {
    =
 size_t cipher_length =3D cipher_kt_key_size(kt->cipher);
     for (size_t =
i =3D 0; i < cipher_length; ++i)
@@ -1123,7 +1123,7 @@
  * Make sure that c=
ipher key is a valid key for current key_type=2E
  */
 bool
-check_key(stru=
ct key *key, const struct key_type *kt)
+check_key(const struct key *key, c=
onst struct key_type *kt)
 {
     if (cipher_defined(kt->cipher))
     {
@@=
 -1196,7 +1196,7 @@
 }
 
 void
-test_crypto(struct crypto_options *co, stru=
ct frame *frame)
+test_crypto(struct crypto_options *co, const struct frame=
 *frame)
 {
     int i, j;
     struct gc_arena gc =3D gc_new();
diff --git=
 a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index ee5b50f=2E=2Ee3c1c=
6a 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -414=
,7 +414,7 @@
  */
 int write_key_file(const int nkeys, const char *filename=
);
 
-bool check_key(struct key *key, const struct key_type *kt);
+bool che=
ck_key(const struct key *key, const struct key_type *kt);
 
 /**
  * Initia=
lize a key_type structure with=2E
@@ -614,7 +614,7 @@
 /** Print a cipher l=
ist entry */
 void print_cipher(const char *cipher);
 
-void test_crypto(st=
ruct crypto_options *co, struct frame *f);
+void test_crypto(struct crypto_=
options *co, const struct frame *f);
 
 
 /* key direction functions */
dif=
f --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 9fc0e3b=2E=2Ef3b5=
d44 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -573,7 +5=
73,7 @@
 }
 
 static bool
-dco_multi_get_localaddr(struct multi_context *m,=
 struct multi_instance *mi,
+dco_multi_get_localaddr(const struct multi_con=
text *m, const struct multi_instance *mi,
                         struct s=
ockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
@@ -585,7 +585,7 @@
     =
    return false;
     }
 
-    struct link_socket_actual *actual =3D &c->c=
2=2Elink_socket_infos[0]->lsa->actual;
+    const struct link_socket_actual=
 *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
 
     switch (act=
ual->dest=2Eaddr=2Esa=2Esa_family)
     {
@@ -623,7 +623,7 @@
 }
 
 int
-dc=
o_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+d=
co_multi_add_new_peer(const struct multi_context *m, struct multi_instance =
*mi)
 {
     const struct context *c =3D &mi->context;
 
@@ -677,7 +677,7 @=
@
 }
 
 void
-dco_install_iroute(struct multi_context *m, struct multi_inst=
ance *mi, struct mroute_addr *addr)
+dco_install_iroute(struct multi_contex=
t *m, struct multi_instance *mi, const struct mroute_addr *addr)
 {
 #if de=
fined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (=
!dco_enabled(&m->top=2Eoptions))
diff --git a/src/openvpn/dco=2Eh b/src/ope=
nvpn/dco=2Eh
index 7ef75fee=2E=2Ec435f8c 100644
--- a/src/openvpn/dco=2Eh
+=
++ b/src/openvpn/dco=2Eh
@@ -204,7 +204,7 @@
  * @param mi        the clien=
t instance
  * @return          0 on success or a negative error code other=
wise
  */
-int dco_multi_add_new_peer(struct multi_context *m, struct multi=
_instance *mi);
+int dco_multi_add_new_peer(const struct multi_context *m, =
struct multi_instance *mi);
 
 /**
  * Install an iroute in DCO, which mean=
s adding a route to the system routing
@@ -215,7 +215,7 @@
  * @param addr =
     the route to add
  */
 void dco_install_iroute(struct multi_context *m=
, struct multi_instance *mi,
-                        struct mroute_addr *a=
ddr);
+                        const struct mroute_addr *addr);
 
 /**
  * =
Remove all routes added through the specified client
@@ -253,7 +253,7 @@
  =
* a 64 bit packet counter and AEAD tag at the end=2E
  */
 bool
-dco_suppor=
ts_epoch_data(struct context *c);
+dco_supports_epoch_data(const struct con=
text *c);
 #else  /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context=
_t;
@@ -350,7 +350,7 @@
 }
 
 static inline int
-dco_multi_add_new_peer(str=
uct multi_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(co=
nst struct multi_context *m, struct multi_instance *mi)
 {
     return 0;
 =
}
@@ -384,7 +384,7 @@
 }
 
 static inline bool
-dco_supports_epoch_data(str=
uct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     r=
eturn false;
 }
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_=
freebsd=2Ec
index 87eea55=2E=2E3148f10 100644
--- a/src/openvpn/dco_freebsd=
=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -929,7 +929,7 @@
 }
 
 bool
-dco_=
supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struc=
t context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_interna=
l=2Eh b/src/openvpn/dco_internal=2Eh
index fcf8aca=2E=2E1022e66 100644
--- =
a/src/openvpn/dco_internal=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -59,8 =
+59,9 @@
  * They are implemented by dco_linux=2Ec
  */
 
-int dco_new_peer=
(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct so=
ckaddr *localaddr,
-                 struct sockaddr *remoteaddr, const str=
uct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
+int dco_new_peer(=
dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd,
+         =
        struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+         =
        const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 =

 int dco_del_peer(dco_context_t *dco, unsigned int peerid);
 
diff --git a=
/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index a397fb8=2E=2E4=
412ad0 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=
=2Ec
@@ -104,7 +104,7 @@
 }
 
 static struct nl_msg *
-ovpn_dco_nlmsg_creat=
e(dco_context_t *dco, uint8_t cmd)
+ovpn_dco_nlmsg_create(const dco_context=
_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_msg =3D nlmsg_alloc();
    =
 if (!nl_msg)
@@ -842,7 +842,7 @@
 
 /* libnl < 3=2E11=2E0 does not impleme=
nt nla_get_uint() */
 static uint64_t
-ovpn_nla_get_uint(struct nlattr *att=
r)
+ovpn_nla_get_uint(const struct nlattr *attr)
 {
     if (nla_len(attr) =
=3D=3D sizeof(uint32_t))
     {
@@ -954,7 +954,7 @@
 }
 
 static bool
-ovpn=
_iface_check(dco_context_t *dco, struct nlattr *attrs[])
+ovpn_iface_check(=
const dco_context_t *dco, struct nlattr *attrs[])
 {
     /* we must know w=
hich interface this message is referring to in order to
      * avoid mixin=
g messages for other instances
@@ -1381,7 +1381,7 @@
 }
 
 bool
-dco_suppor=
ts_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct cont=
ext *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_win=2Ec b/src=
/openvpn/dco_win=2Ec
index 6e5e295=2E=2E12b0666 100644
--- a/src/openvpn/dc=
o_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -1092,7 +1092,7 @@
 }
 
 bool
-d=
co_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const st=
ruct context *c)
 {
     OVPN_VERSION ver =3D { 0 };
     return dco_get_ve=
rsion(&ver) && ((ver=2EMajor =3D=3D 2 && ver=2EMinor >=3D 8) || (ver=2EMajo=
r > 2));
diff --git a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec
index 2=
6d4c7c=2E=2E32d819d 100644
--- a/src/openvpn/error=2Ec
+++ b/src/openvpn/er=
ror=2Ec
@@ -623,7 +623,7 @@
  * from the OS=2E
  */
 void
-x_check_status(s=
size_t status, const char *description, struct link_socket *sock, struct tu=
ntap *tt)
+x_check_status(ssize_t status, const char *description, struct l=
ink_socket *sock, const struct tuntap *tt)
 {
     const char *extended_msg=
 =3D NULL;
 
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
ind=
ex 9f39572=2E=2E373cbc1 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvp=
n/error=2Eh
@@ -304,10 +304,10 @@
 void set_check_status(unsigned int info_=
level, unsigned int verbose_level);
 
 void x_check_status(ssize_t status, =
const char *description, struct link_socket *sock,
-                    str=
uct tuntap *tt);
+                    const struct tuntap *tt);
 
 static i=
nline void
-check_status(ssize_t status, const char *description, struct li=
nk_socket *sock, struct tuntap *tt)
+check_status(ssize_t status, const cha=
r *description, struct link_socket *sock, const struct tuntap *tt)
 {
     =
if (status < 0 || check_debug_level(x_cs_verbose_level))
     {
diff --git =
a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 4089401=2E=2E5e17ea1 =
100644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -1012,7 +=
1012,7 @@
 }
 
 static int
-se_wait_return(struct se_set *ses, fd_set *read=
, fd_set *write, struct event_set_return *out,
+se_wait_return(struct se_se=
t *ses, const fd_set *read, const fd_set *write, struct event_set_return *o=
ut,
                int outlen)
 {
     int i, j =3D 0;
diff --git a/src/op=
envpn/event=2Eh b/src/openvpn/event=2Eh
index b784dfe=2E=2E0940a1d 100644
-=
-- a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@@ -204,7 +204,7 @@
=
 #else /* ifdef _WIN32 */
 
 static inline void
-wait_signal(struct event_s=
et *es, void *arg)
+wait_signal(const struct event_set *es, const void *arg=
)
 {
 }
 
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
in=
dex b97fb7a=2E=2E681210d 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/ope=
nvpn/forward=2Ec
@@ -237,7 +237,7 @@
 }
 
 static void
-parse_incoming_cont=
rol_channel_command(struct context *c, struct buffer *buf)
+parse_incoming_=
control_channel_command(struct context *c, const struct buffer *buf)
 {
   =
  if (buf_string_match_head_str(buf, "AUTH_FAILED"))
     {
@@ -507,7 +507,=
7 @@
 }
 
 int
-get_server_poll_remaining_time(struct event_timeout *server=
_poll_timeout)
+get_server_poll_remaining_time(const struct event_timeout *=
server_poll_timeout)
 {
     update_time();
     int remaining =3D event_ti=
meout_remaining(server_poll_timeout);
@@ -621,7 +621,7 @@
  * Buffer reallo=
cation, for use with null encryption=2E
  */
 static inline void
-buffer_tu=
rnover(const uint8_t *orig_buf, struct buffer *dest_stub, struct buffer *sr=
c_stub,
+buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub,=
 const struct buffer *src_stub,
                 struct buffer *storage)
 {=

     if (orig_buf =3D=3D src_stub->data && src_stub->data !=3D storage->da=
ta)
@@ -908,7 +908,7 @@
  */
 
 static inline void
-socks_postprocess_incom=
ing_link(struct context *c, struct link_socket *sock)
+socks_postprocess_in=
coming_link(struct context *c, const struct link_socket *sock)
 {
     if (=
sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
     {
@@ -1005,7=
 +1005,7 @@
 }
 
 bool
-process_incoming_link_part1(struct context *c, stru=
ct link_socket_info *lsi, bool floated)
+process_incoming_link_part1(struct=
 context *c, const struct link_socket_info *lsi, bool floated)
 {
     stru=
ct gc_arena gc =3D gc_new();
     bool decrypt_status =3D false;
@@ -1555,7=
 +1555,7 @@
  * @param client    Determines whether to the send packet back=
 via tun or link
  */
 void
-ipv6_send_icmp_unreachable(struct context *c, =
struct buffer *buf, bool client)
+ipv6_send_icmp_unreachable(struct context=
 *c, const struct buffer *buf, bool client)
 {
 #define MAX_ICMPV6LEN 1280
=
     struct openvpn_icmp6hdr icmp6out;
diff --git a/src/openvpn/forward=2Eh=
 b/src/openvpn/forward=2Eh
index 0309725=2E=2E375635b 100644
--- a/src/open=
vpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -126,7 +126,7 @@
  */
 voi=
d encrypt_sign(struct context *c, bool comp_frag);
 
-int get_server_poll_r=
emaining_time(struct event_timeout *server_poll_timeout);
+int get_server_p=
oll_remaining_time(const struct event_timeout *server_poll_timeout);
 
 /**=
********************************************************************/
 /**
=
@@ -177,7 +177,7 @@
  *
  * @return true if packet is authenticated, false =
otherwise=2E
  */
-bool process_incoming_link_part1(struct context *c, stru=
ct link_socket_info *lsi, bool floated);
+bool process_incoming_link_part1(=
struct context *c, const struct link_socket_info *lsi, bool floated);
 
 /*=
*
  * Continues processing a packet read from the external network interfac=
e=2E
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 9306a96=
=2E=2E3c2ebf9 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -803,7 +803,7 @@
 }
 
 static void
-init_port_share(struct context *c)
+=
init_port_share(const struct context *c)
 {
     if (!port_share && (c->opt=
ions=2Eport_share_host && c->options=2Eport_share_port))
     {
@@ -1245,7 =
+1245,7 @@
  * prepending to msg() output=2E
  */
 const char *
-format_com=
mon_name(struct context *c, struct gc_arena *gc)
+format_common_name(const =
struct context *c, struct gc_arena *gc)
 {
     struct buffer out =3D alloc=
_buf_gc(256, gc);
     if (c->c2=2Etls_multi)
@@ -1731,7 +1731,7 @@
 
 
 st=
atic bool
-can_preserve_tun(struct tuntap *tt)
+can_preserve_tun(const stru=
ct tuntap *tt)
 {
     if (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
 =
    {
@@ -1753,7 +1753,7 @@
  * @param c pointer to the connection context
=
  */
 static void
-add_wfp_block(struct context *c)
+add_wfp_block(const st=
ruct context *c)
 {
 #if defined(_WIN32)
     /* Fortify 'redirect-gateway =
block-local' with firewall rules? */
@@ -1779,7 +1779,7 @@
  * @param adapt=
er_index the VPN adapter index
  */
 static void
-del_wfp_block(struct cont=
ext *c, unsigned long adapter_index)
+del_wfp_block(const struct context *c=
, unsigned long adapter_index)
 {
 #if defined(_WIN32)
     if (c->options=
=2Eblock_outside_dns || block_local_needed(c->c1=2Eroute_list))
diff --git =
a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index ce8f74e=2E=2Ec486158 10=
0644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -91,7 +91,7 @=
@
 
 uint64_t pull_permission_mask(const struct context *c);
 
-const char =
*format_common_name(struct context *c, struct gc_arena *gc);
+const char *f=
ormat_common_name(const struct context *c, struct gc_arena *gc);
 
 void re=
set_coarse_timers(struct context *c);
 
diff --git a/src/openvpn/interval=
=2Eh b/src/openvpn/interval=2Eh
index 59051bd=2E=2E0cfe202 100644
--- a/src=
/openvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -89,7 +89,7 @@
 }
 =

 static inline void
-interval_schedule_wakeup(struct interval *top, interv=
al_t *wakeup)
+interval_schedule_wakeup(const struct interval *top, interva=
l_t *wakeup)
 {
     const time_t local_now =3D now;
     interval_earliest=
_wakeup(wakeup, top->last_test_true + top->refresh, local_now);
@@ -214,7 +=
214,7 @@
  * This function does not check if the timeout is actually valid=
=2E
  */
 static inline interval_t
-event_timeout_remaining(struct event_ti=
meout *et)
+event_timeout_remaining(const struct event_timeout *et)
 {
    =
 return (interval_t)((et->last + et->n) - now);
 }
diff --git a/src/openvpn=
/list=2Ec b/src/openvpn/list=2Ec
index e51dcd0=2E=2Edcd59d7 100644
--- a/sr=
c/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -164,7 +164,7 @@
 }
 
 voi=
d
-hash_remove_by_value(struct hash *hash, void *value)
+hash_remove_by_val=
ue(struct hash *hash, const void *value)
 {
     struct hash_iterator hi;
 =
    const struct hash_element *he;
diff --git a/src/openvpn/list=2Eh b/src/=
openvpn/list=2Eh
index 55bc3c8=2E=2E23267d0 100644
--- a/src/openvpn/list=
=2Eh
+++ b/src/openvpn/list=2Eh
@@ -78,7 +78,7 @@
 
 bool hash_remove_fast(=
struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv=
);
 
-void hash_remove_by_value(struct hash *hash, void *value);
+void hash=
_remove_by_value(struct hash *hash, const void *value);
 
 struct hash_iter=
ator
 {
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index =
0aef2d4=2E=2E1e74f09 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/=
manage=2Ec
@@ -330,7 +330,7 @@
 }
 
 static void
-man_delete_unix_socket(st=
ruct management *man)
+man_delete_unix_socket(const struct management *man)=

 {
 #if UNIX_SOCK_SUPPORT
     if ((man->settings=2Eflags & (MF_UNIX_SOCK =
| MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
@@ -676,7 +676,7 @@
  * for t=
he log and echo commands=2E
  */
 static void
-man_history(struct managemen=
t *man, const char *parm, const char *type, struct log_history *log,
+man_h=
istory(struct management *man, const char *parm, const char *type, const st=
ruct log_history *log,
             bool *realtime, const unsigned int lep_=
flags)
 {
     struct gc_arena gc =3D gc_new();
@@ -852,7 +852,7 @@
 }
 
 s=
tatic void
-man_net(struct management *man)
+man_net(const struct managemen=
t *man)
 {
     if (man->persist=2Ecallback=2Eshow_net)
     {
@@ -888,7 +8=
88,7 @@
 #ifdef ENABLE_PKCS11
 
 static void
-man_pkcs11_id_count(struct ma=
nagement *man)
+man_pkcs11_id_count(const struct management *man)
 {
     m=
sg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count());
 }
@@ -23=
66,7 +2366,7 @@
  * the route/ifconfig/open tun command=2E   See doc/androi=
d=2Etxt for details=2E
  */
 bool
-management_android_control(struct manage=
ment *man, const char *command, const char *msg)
+management_android_contro=
l(const struct management *man, const char *command, const char *msg)
 {
  =
   if (!man)
     {
@@ -3013,7 +3013,7 @@
 }
 
 void
-management_up_down(st=
ruct management *man, const char *updown, const struct env_set *es)
+manage=
ment_up_down(const struct management *man, const char *updown, const struct=
 env_set *es)
 {
     if (man->settings=2Eflags & MF_UP_DOWN)
     {
@@ -32=
08,7 +3208,7 @@
 }
 
 void
-management_auth_failure(struct management *man,=
 const char *type, const char *reason)
+management_auth_failure(const struc=
t management *man, const char *type, const char *reason)
 {
     if (reason=
)
     {
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index=
 1e7855d=2E=2Ef2c6916 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn=
/manage=2Eh
@@ -368,7 +368,7 @@
                                 const unsi=
gned int flags, const char *static_challenge);
 
 #ifdef TARGET_ANDROID
-bo=
ol management_android_control(struct management *man, const char *command, =
const char *msg);
+bool management_android_control(const struct management =
*man, const char *command, const char *msg);
 
 #define ANDROID_KEEP_OLD_TU=
N      1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -382,7 +382,7 @@
 
 void m=
anagement_event_loop_n_seconds(struct management *man, int sec);
 
-void ma=
nagement_up_down(struct management *man, const char *updown, const struct e=
nv_set *es);
+void management_up_down(const struct management *man, const c=
har *updown, const struct env_set *es);
 
 void management_notify(const cha=
r *severity, const char *type,
                        const char *text);
@=
@ -482,7 +482,7 @@
  * OpenVPN calls here to indicate a password failure
  =
*/
 
-void management_auth_failure(struct management *man, const char *type=
, const char *reason);
+void management_auth_failure(const struct managemen=
t *man, const char *type, const char *reason);
 
 /*
  * Echo an authentica=
tion token to management interface
diff --git a/src/openvpn/mbuf=2Ec b/src/=
openvpn/mbuf=2Ec
index 5bb397f=2E=2E163251c 100644
--- a/src/openvpn/mbuf=
=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -165,7 +165,7 @@
 }
 
 void
-mbuf_derefe=
rence_instance(struct mbuf_set *ms, struct multi_instance *mi)
+mbuf_derefe=
rence_instance(struct mbuf_set *ms, const struct multi_instance *mi)
 {
   =
  if (ms)
     {
diff --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh
i=
ndex cfe698c=2E=2Ee368054 100644
--- a/src/openvpn/mbuf=2Eh
+++ b/src/openv=
pn/mbuf=2Eh
@@ -75,7 +75,7 @@
 
 bool mbuf_extract_item(struct mbuf_set *ms=
, struct mbuf_item *item);
 
-void mbuf_dereference_instance(struct mbuf_se=
t *ms, struct multi_instance *mi);
+void mbuf_dereference_instance(struct m=
buf_set *ms, const struct multi_instance *mi);
 
 static inline bool
 mbuf_=
defined(const struct mbuf_set *ms)
diff --git a/src/openvpn/mss=2Ec b/src/o=
penvpn/mss=2Ec
index 36bbb43=2E=2E0cfa272d 100644
--- a/src/openvpn/mss=2Ec=

+++ b/src/openvpn/mss=2Ec
@@ -239,8 +239,8 @@
 }
 
 static void
-frame_cal=
culate_fragment(struct frame *frame, struct key_type *kt, const struct opti=
ons *options,
-                         struct link_socket_info *lsi)
+fram=
e_calculate_fragment(struct frame *frame, const struct key_type *kt, const =
struct options *options,
+                         const struct link_socket=
_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
     size_t overhead;
@@ -269,=
8 +269,8 @@
 }
 
 static void
-frame_calculate_mssfix(struct frame *frame, =
struct key_type *kt, const struct options *options,
-                      =
 struct link_socket_info *lsi)
+frame_calculate_mssfix(struct frame *frame,=
 const struct key_type *kt, const struct options *options,
+               =
        const struct link_socket_info *lsi)
 {
     if (options->ce=2Emssfi=
x_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
 void
-frame_calculate_dynamic(str=
uct frame *frame, struct key_type *kt, const struct options *options,
-    =
                    struct link_socket_info *lsi)
+frame_calculate_dynamic(=
struct frame *frame, const struct key_type *kt, const struct options *optio=
ns,
+                        const struct link_socket_info *lsi)
 {
     if=
 (options->ce=2Efragment > 0)
     {
diff --git a/src/openvpn/mss=2Eh b/src=
/openvpn/mss=2Eh
index 1d092bb=2E=2E2eab55a 100644
--- a/src/openvpn/mss=2E=
h
+++ b/src/openvpn/mss=2Eh
@@ -36,8 +36,8 @@
 void mss_fixup_dowork(struct=
 buffer *buf, uint16_t maxmss);
 
 /** Set the --mssfix option=2E */
-void =
frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
-        =
                     const struct options *options, struct link_socket_info=
 *lsi);
+void frame_calculate_dynamic(struct frame *frame, const struct key=
_type *kt,
+                             const struct options *options, con=
st struct link_socket_info *lsi);
 
 /**
  * Checks and adjusts the fragmen=
t and mssfix value according to the
diff --git a/src/openvpn/mtcp=2Ec b/src=
/openvpn/mtcp=2Ec
index 4d173c4=2E=2Ec744638 100644
--- a/src/openvpn/mtcp=
=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -67,7 +67,7 @@
 }
 
 bool
-multi_tcp_ins=
tance_specific_init(struct multi_context *m, struct multi_instance *mi)
+mu=
lti_tcp_instance_specific_init(const struct multi_context *m, struct multi_=
instance *mi)
 {
     /* buffer for queued TCP socket output packets */
   =
  mi->tcp_link_out_deferred =3D mbuf_init(m->top=2Eoptions=2En_bcast_buf);
=
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh
index 9b7d1d2=2E=
=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ =
-35,7 +35,7 @@
 
 void multi_tcp_dereference_instance(struct multi_io *mult=
i_io, struct multi_instance *mi);
 
-bool multi_tcp_instance_specific_init(=
struct multi_context *m, struct multi_instance *mi);
+bool multi_tcp_instan=
ce_specific_init(const struct multi_context *m, struct multi_instance *mi);=

 
 void multi_tcp_instance_specific_free(struct multi_instance *mi);
 
dif=
f --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 69e30e5=2E=2E20=
1d756 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -54,8=
 +54,9 @@
  * @param sock    the socket to send the reply on
  */
 static v=
oid
-send_standalone_reply(struct multi_context *m, struct buffer *buf, con=
st char *prefix,
-                      const char *detail, struct link_soc=
ket *sock)
+send_standalone_reply(struct multi_context *m, const struct buf=
fer *buf,
+                      const char *prefix, const char *detail,
+ =
                     struct link_socket *sock)
 {
     struct context *c =
=3D &m->top;
 
@@ -75,7 +76,7 @@
 
 static void
 send_hmac_reset_packet(str=
uct multi_context *m, struct tls_pre_decrypt_state *state,
-               =
        struct tls_auth_standalone *tas, struct session_id *sid,
+         =
              const struct tls_auth_standalone *tas, const struct session_i=
d *sid,
                        bool request_resend_wkc, struct link_socket=
 *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);
@@ -117,11 +118,11 @@
 
     enum first_packet_verdict verdict;
 =

-    struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_auth_standalone=
;
+    const struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_auth_sta=
ndalone;
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m->top=2Ec2=
=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    uint8_t *hmac_key =3D m->top=2Ec2=2Ese=
ssion_id_key;
+    const uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_key=
;
     const struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
=
     int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@ -240,7 +2=
41,7 @@
 static struct multi_instance *
 handle_connection_attempt(struct m=
ulti_context *m,
                           struct link_socket *sock,
-    =
                      struct mroute_addr *real)
+                          =
const struct mroute_addr *real)
 {
     struct gc_arena gc =3D gc_new();
 
=
@@ -308,7 +309,7 @@
  * @return      instance matching the address, NULL ot=
herwise
  */
 static struct multi_instance *
-multi_get_instance_udp_real(s=
truct multi_context *m, struct mroute_addr *real)
+multi_get_instance_udp_r=
eal(struct multi_context *m, const struct mroute_addr *real)
 {
     struct=
 hash *hash =3D m->hash;
     const uint64_t hv =3D hash_value(hash, real);=

@@ -353,7 +354,9 @@
  * maintaining real address hash table atomicity=2E
 =
 */
 struct multi_instance *
-multi_get_instance_udp_data(struct multi_cont=
ext *m, bool *floated, struct mroute_addr *real, struct link_socket *sock)
=
+multi_get_instance_udp_data(struct multi_context *m, bool *floated,
+     =
                       const struct mroute_addr *real,
+                   =
         const struct link_socket *sock)
 {
     struct multi_instance *mi =
=3D NULL;
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
inde=
x dda9232=2E=2Ea2cfdbf 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn=
/multi=2Ec
@@ -58,7 +58,7 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const=
 char *
-id(struct multi_instance *mi)
+id(const struct multi_instance *mi)=

 {
     if (mi)
     {
@@ -1336,7 +1336,7 @@
  * same common name=2E
  */
=
 static void
-multi_delete_dup(struct multi_context *m, struct multi_instan=
ce *new_mi)
+multi_delete_dup(struct multi_context *m, const struct multi_i=
nstance *new_mi)
 {
     if (new_mi)
     {
@@ -2281,7 +2281,7 @@
 }
 
 sta=
tic bool
-multi_client_setup_dco_initial(struct multi_context *m, struct mu=
lti_instance *mi,
+multi_client_setup_dco_initial(const struct multi_contex=
t *m, struct multi_instance *mi,
                                struct gc_=
arena *gc)
 {
     if (!dco_enabled(&mi->context=2Eoptions))
@@ -2479,7 +24=
79,7 @@
 }
 
 static bool
-multi_check_dest_addr_allowed(struct multi_conte=
xt *m, struct multi_instance *mi, struct mroute_addr *real);
+multi_check_d=
est_addr_allowed(struct multi_context *m, struct multi_instance *mi, const =
struct mroute_addr *real);
 
 /**
  * This sets up the client real address =
(outer tunnel addr) in the
@@ -3130,7 +3130,8 @@
  * positive=2E
  */
 stat=
ic bool
-multi_check_dest_addr_allowed(struct multi_context *m, struct mult=
i_instance *mi, struct mroute_addr *real)
+multi_check_dest_addr_allowed(st=
ruct multi_context *m, struct multi_instance *mi,
+                        =
      const struct mroute_addr *real)
 {
     struct hash *hash =3D m->hash=
;
     const uint64_t hv =3D hash_value(hash, real);
@@ -3289,7 +3290,7 @@
=
 
 #if defined(ENABLE_DCO)
 static void
-process_incoming_del_peer(struct m=
ulti_context *m, struct multi_instance *mi, dco_context_t *dco)
+process_in=
coming_del_peer(struct multi_context *m, struct multi_instance *mi, const d=
co_context_t *dco)
 {
     const char *reason =3D "ovpn-dco: unknown reason=
";
     switch (dco->dco_del_peer_reason)
@@ -4342,7 +4343,7 @@
 
 /* Searc=
hes for the address and deletes it if it is owned by the multi_instance */
=
 static void
-multi_unlearn_addr(struct multi_context *m, struct multi_inst=
ance *mi, const struct mroute_addr *addr)
+multi_unlearn_addr(struct multi_=
context *m, const struct multi_instance *mi, const struct mroute_addr *addr=
)
 {
     struct hash_element *he;
     const uint64_t hv =3D hash_value(m-=
>vhash, addr);
@@ -4377,7 +4378,7 @@
  * @param a     The new IPv4 address =
in network byte order
  */
 static void
-multi_unlearn_in_addr_t(struct mul=
ti_context *m, struct multi_instance *mi, in_addr_t a)
+multi_unlearn_in_ad=
dr_t(struct multi_context *m, const struct multi_instance *mi, in_addr_t a)=

 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4395,7 +4396,7 @@
 =
 * @param a6    The new IPv6 address
  */
 static void
-multi_unlearn_in6_a=
ddr(struct multi_context *m, struct multi_instance *mi, struct in6_addr a6)=

+multi_unlearn_in6_addr(struct multi_context *m, const struct multi_instan=
ce *mi, struct in6_addr a6)
 {
     struct mroute_addr addr;
     CLEAR(add=
r);
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index c424ad=
3=2E=2E5db7147 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=
=2Eh
@@ -529,7 +529,7 @@
  */
 
 static inline void
-set_prefix(struct mult=
i_instance *mi)
+set_prefix(const struct multi_instance *mi)
 {
 #ifdef MUL=
TI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
diff --git a/src/openvpn/mu=
lti_io=2Ec b/src/openvpn/multi_io=2Ec
index 348e424=2E=2Ebb5dde58 100644
--=
- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -159,7 +159,=
7 @@
  * a point-to-multipoint tunnel=2E
  */
 static unsigned int
-p2mp_io=
w_flags(const struct multi_context *m, struct link_socket *sock)
+p2mp_iow_=
flags(const struct multi_context *m, const struct link_socket *sock)
 {
   =
  unsigned int flags =3D IOW_WAIT_SIGNAL;
 
diff --git a/src/openvpn/networ=
king=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=2E25233c8 100644
---=
 a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -44,7 +44=
,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inline int
-net_ctx_init(s=
truct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct contex=
t *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (void)ctx;
@@ -75,7 +75=
,7 @@
  *
  * @return          0 on success, a negative error code otherwis=
e
  */
-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);
+int n=
et_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);
 
 /**
  * Re=
lease resources allocated by the internal garbage collector
@@ -102,7 +102,=
7 @@
  * @return          0 on success, negative error code on error
  */
 =
int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,=
 const char *type,
-                  void *arg);
+                  const =
void *arg);
 
 /**
  * Retrieve the interface type
diff --git a/src/openvpn=
/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index a1f352=
5=2E=2Ef091fb3 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/o=
penvpn/networking_iproute2=2Ec
@@ -36,7 +36,7 @@
 #include <netinet/in=2Eh>=

 
 int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_i=
nit(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es =3D NU=
LL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface_new(openvpn_net_ctx_=
t *ctx, const char *iface, const char *type, void *arg)
+net_iface_new(open=
vpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 =
{
     struct argv argv =3D argv_new();
 
diff --git a/src/openvpn/networki=
ng_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 83915db=2E=2E49de664 =
100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_=
sitnl=2Ec
@@ -1007,7 +1007,7 @@
 }
 
 static int
-sitnl_addr_del(sa_family_=
t af_family, const char *iface, inet_address_t *addr, int prefixlen)
+sitnl=
_addr_del(sa_family_t af_family, const char *iface, const inet_address_t *a=
ddr, int prefixlen)
 {
     int ifindex;
 
@@ -1250,8 +1250,8 @@
 }
 
 stat=
ic int
-sitnl_route_del(const char *iface, sa_family_t af_family, inet_addr=
ess_t *dst, int prefixlen,
-                inet_address_t *gw, uint32_t ta=
ble, int metric)
+sitnl_route_del(const char *iface, sa_family_t af_family,=
 const inet_address_t *dst, int prefixlen,
+                const inet_addr=
ess_t *gw, uint32_t table, int metric)
 {
     int ifindex =3D 0;
 
@@ -132=
8,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *=
iface, const char *type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, =
const char *iface, const char *type, const void *arg)
 {
     struct sitnl_=
link_req req =3D {};
     int ret =3D -1;
diff --git a/src/openvpn/occ=2Eh =
b/src/openvpn/occ=2Eh
index bda4f18=2E=2E49def4d 100644
--- a/src/openvpn/o=
cc=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * via control channe=
l=2E
  * @return control channel exit message should be used */
 static inl=
ine bool
-cc_exit_notify_enabled(struct context *c)
+cc_exit_notify_enabled=
(const struct context *c)
 {
     /* Check if we have TLS active at all */
=
     if (!c->c2=2Etls_multi)
diff --git a/src/openvpn/openssl_compat=2Eh b/=
src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E1a934db 100644
--- a/src/=
openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -127,7 +=
127,7 @@
 /* Mimics the functions but only when the default context without=

  * options is chosen */
 static inline const EVP_CIPHER *
-EVP_CIPHER_fet=
ch(void *ctx, const char *algorithm, const char *properties)
+EVP_CIPHER_fe=
tch(const void *ctx, const char *algorithm, const char *properties)
 {
    =
 ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +135,7 @@
 }
 
 static i=
nline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *algorithm, const =
char *properties)
+EVP_MD_fetch(const void *ctx, const char *algorithm, con=
st char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 6664c73=2E=
=2Ee7585ad 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -2429,7 +2429,7 @@
 }
 
 static void
-options_postprocess_mutate_le=
(struct connection_entry *ce, struct local_entry *le, int mode)
+options_po=
stprocess_mutate_le(const struct connection_entry *ce, struct local_entry *=
le, int mode)
 {
     /* use the global port if none is specified */
     i=
f (!le->port)
@@ -3589,7 +3589,7 @@
 static bool
 verify_permission(const c=
har *name, const char *file, int line, const uint64_t type,
               =
    const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,
-    =
              struct options *options, bool is_inline)
+                  c=
onst struct options *options, bool is_inline)
 {
     if (!(type & allowed)=
)
     {
@@ -3665,7 +3665,7 @@
 }
 
 static inline msglvl_t
-msglevel_forwa=
rd_compatible(struct options *options, const msglvl_t msglevel)
+msglevel_f=
orward_compatible(const struct options *options, const msglvl_t msglevel)
 =
{
     return options->forward_compatible ? M_WARN : msglevel;
 }
@@ -4154,=
7 +4154,7 @@
 }
 
 static void
-show_compression_warning(struct compress_op=
tions *info)
+show_compression_warning(const struct compress_options *info)=

 {
     if (comp_non_stub_enabled(info))
     {
diff --git a/src/openvpn/o=
ptions_parse=2Ec b/src/openvpn/options_parse=2Ec
index 12934ab=2E=2E79b8098=
 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=
=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inline_file(struct in_sr=
c *is, const char *close_tag, int *num_lines, struct gc_arena *gc)
+read_in=
line_file(const struct in_src *is, const char *close_tag, int *num_lines, s=
truct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer=
 buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,7 @@
 }
 
 static =
int
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+=
check_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)
=
 {
     int num_inline_lines =3D 0;
 
diff --git a/src/openvpn/otime=2Ec b/=
src/openvpn/otime=2Ec
index 1608458=2E=2E5d3633c 100644
--- a/src/openvpn/o=
time=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@
 }
 
 void
-update_n=
ow_usec(struct timeval *tv)
+update_now_usec(const struct timeval *tv)
 {
 =
    const time_t last =3D now;
     update_now(tv->tv_sec);
diff --git a/sr=
c/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index d14f01e=2E=2E74d21ff 1006=
44
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -65,7 +65,7 @=
@
 void update_now(const time_t system_time);
 
 extern time_t now_usec;
-v=
oid update_now_usec(struct timeval *tv);
+void update_now_usec(const struct=
 timeval *tv);
 
 static inline int
 openvpn_gettimeofday(struct timeval *t=
v, void *tz)
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
ind=
ex 9bb0866=2E=2E1665751 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvp=
n/proto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP header (via parameter)=
=2E
  */
 static inline int
-get_tun_ip_ver(int tunnel_type, struct buffer =
*buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type, const struct buf=
fer *buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -1;
 
diff --git a/src=
/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 74a6cf9=2E=2Ec3ad7de 10064=
4
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -527,8 +527,9 =
@@
 }
 
 static bool
-add_proxy_headers(struct http_proxy_info *p, socket_d=
escriptor_t sd, /* already open to proxy */
-                  const char *=
host                                   /* openvpn server remote */
+add_pro=
xy_headers(const struct http_proxy_info *p,
+                  socket_descr=
iptor_t sd, /* already open to proxy */
+                  const char *host=
        /* openvpn server remote */
 )
 {
     char buf[512];
@@ -597,8 +59=
8,8 @@
                               socket_descriptor_t sd, /* already op=
en to proxy */
                               const char *host,       /* op=
envpn server remote */
                               const char *port,    =
   /* openvpn server port */
-                              struct event_ti=
meout *server_poll_timeout, struct buffer *lookahead,
-                    =
          struct signal_info *sig_info)
+                              cons=
t struct event_timeout *server_poll_timeout,
+                             =
 struct buffer *lookahead, struct signal_info *sig_info)
 {
     struct gc_=
arena gc =3D gc_new();
     char buf[512];
diff --git a/src/openvpn/proxy=
=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47 100644
--- a/src/op=
envpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +89,7 @@
             =
                       socket_descriptor_t sd, /* already open to proxy */
=
                                    const char *host,       /* openvpn serv=
er remote */
                                    const char *port,       /*=
 openvpn server port */
-                                   struct event_ti=
meout *server_poll_timeout,
+                                   const struc=
t event_timeout *server_poll_timeout,
                                    s=
truct buffer *lookahead, struct signal_info *sig_info);
 
 uint8_t *make_ba=
se64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);
diff --=
git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 08c2673=2E=2E2679c4d5 1=
00644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -334,7 +334,7 @@=

  * the proxy can determine true client origin=2E
  */
 static void
-journ=
al_add(const char *journal_dir, struct proxy_connection *pc, struct proxy_c=
onnection *cp)
+journal_add(const char *journal_dir, const struct proxy_con=
nection *pc, struct proxy_connection *cp)
 {
     struct openvpn_sockaddr f=
rom, to;
 
@@ -412,7 +412,7 @@
 static bool
 proxy_entry_new(struct proxy_c=
onnection **list, struct event_set *es,
                 const struct openv=
pn_sockaddr server_addr, const socket_descriptor_t sd_client,
-            =
    struct buffer *initial_data, const char *journal_dir)
+                =
const struct buffer *initial_data, const char *journal_dir)
 {
     socket_=
descriptor_t sd_server;
     int status;
@@ -1015,7 +1015,7 @@
  * call=2E
=
  */
 void
-port_share_redirect(struct port_share *ps, const struct buffer =
*head, socket_descriptor_t sd)
+port_share_redirect(const struct port_share=
 *ps, const struct buffer *head, socket_descriptor_t sd)
 {
     if (ps)
  =
   {
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh
index 557ecf5=2E=
=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/openvpn/ps=2Eh
@@ -49,=
7 +49,7 @@
 
 bool is_openvpn_protocol(const struct buffer *buf);
 
-void p=
ort_share_redirect(struct port_share *ps, const struct buffer *head, socket=
_descriptor_t sd);
+void port_share_redirect(const struct port_share *ps, c=
onst struct buffer *head, socket_descriptor_t sd);
 
 #endif /* if PORT_SHA=
RE */
 #endif /* ifndef PS_H */
diff --git a/src/openvpn/push=2Ec b/src/ope=
nvpn/push=2Ec
index 0e281d2=2E=2E8dfe0d5 100644
--- a/src/openvpn/push=2Ec
=
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
 }
 
 bool
-send_auth_pendin=
g_messages(struct tls_multi *tls_multi, struct tls_session *session,
+send_=
auth_pending_messages(const struct tls_multi *tls_multi, struct tls_session=
 *session,
                            const char *extra, unsigned int time=
out)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
diff --git=
 a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E39302f6 1=
00644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -117,7 +117,=
7 @@
  * doc/management-notes=2Etxt under client-pending-auth for
  * more =
details on message format
  */
-bool send_auth_pending_messages(struct tls_=
multi *tls_multi, struct tls_session *session,
+bool send_auth_pending_mess=
ages(const struct tls_multi *tls_multi, struct tls_session *session,
      =
                           const char *extra, unsigned int timeout);
 
 voi=
d send_restart(struct context *c, const char *kill_msg);
diff --git a/src/o=
penvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 0213041=2E=2E7fa5987=
 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ =
-222,7 +222,7 @@
 
 /* Return true if the client supports push-update */
 s=
tatic bool
-support_push_update(struct multi_instance *mi)
+support_push_up=
date(const struct multi_instance *mi)
 {
     ASSERT(mi->context=2Ec2=2Etls=
_multi);
     const unsigned int iv_proto_peer =3D extract_iv_proto(mi->con=
text=2Ec2=2Etls_multi->peer_info);
diff --git a/src/openvpn/reliable=2Ec b/=
src/openvpn/reliable=2Ec
index c268cce=2E=2E7b5b17c 100644
--- a/src/openvp=
n/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -59,7 +59,7 @@
 
 /* check=
 if a particular packet_id is present in ack */
 static inline bool
-reliab=
le_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
+rel=
iable_ack_packet_id_present(const struct reliable_ack *ack, packet_id_type =
pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
     {
@@ -752,7 +752,7 @=
@
  */
 
 void
-reliable_mark_active_incoming(struct reliable *rel, struct =
buffer *buf, packet_id_type pid,
+reliable_mark_active_incoming(struct reli=
able *rel, const struct buffer *buf, packet_id_type pid,
                  =
             int opcode)
 {
     for (int i =3D 0; i < rel->size; ++i)
@@ -=
812,7 +812,7 @@
 
 /* delete a buffer previously activated by reliable_mark=
_active() */
 void
-reliable_mark_deleted(struct reliable *rel, struct buff=
er *buf)
+reliable_mark_deleted(struct reliable *rel, const struct buffer *=
buf)
 {
     for (int i =3D 0; i < rel->size; ++i)
     {
diff --git a/src/=
openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index 534feb3=2E=2E7b6fced =
100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -18=
4,7 +184,7 @@
  * @li False, if there are packet IDs to be acknowledged=2E
=
  */
 static inline bool
-reliable_ack_empty(struct reliable_ack *ack)
+rel=
iable_ack_empty(const struct reliable_ack *ack)
 {
     return !ack->len;
 =
}
@@ -213,7 +213,7 @@
  * @returns the number of outstanding acks
  */
 sta=
tic inline int
-reliable_ack_outstanding(struct reliable_ack *ack)
+reliabl=
e_ack_outstanding(const struct reliable_ack *ack)
 {
     return ack->len;
=
 }
@@ -369,7 +369,7 @@
  * @param pid The packet's packet ID=2E
  * @param =
opcode The packet's opcode=2E
  */
-void reliable_mark_active_incoming(stru=
ct reliable *rel, struct buffer *buf, packet_id_type pid,
+void reliable_ma=
rk_active_incoming(struct reliable *rel, const struct buffer *buf, packet_i=
d_type pid,
                                    int opcode);
 
 /**
@@ -422=
,7 +422,7 @@
  * @param rel The reliable structure associated with the give=
n buffer=2E
  * @param buf The buffer of the reliable entry which is to be =
removed=2E
  */
-void reliable_mark_deleted(struct reliable *rel, struct bu=
ffer *buf);
+void reliable_mark_deleted(struct reliable *rel, const struct =
buffer *buf);
 
 /** @} name Functions for extracting incoming packets */
 =

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 33b2387=
=2E=2E4830a5b 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(struct route_byp=
ass *rb, in_addr_t gateway, const struct tuntap *tt,
-                  uns=
igned int flags, const struct route_gateway_info *rgi,
+add_bypass_routes(c=
onst struct route_bypass *rb, in_addr_t gateway,
+                  const s=
truct tuntap *tt, unsigned int flags,
+                  const struct route=
_gateway_info *rgi,
                   const struct env_set *es, openvpn_ne=
t_ctx_t *ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9 @@
 }
 
 static vo=
id
-del_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const str=
uct tuntap *tt,
-                  unsigned int flags, const struct route_g=
ateway_info *rgi,
+del_bypass_routes(const struct route_bypass *rb, in_addr=
_t gateway,
+                  const struct tuntap *tt, unsigned int flags,=

+                  const struct route_gateway_info *rgi,
                 =
  const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int i;
@@ -3939=
,7 +3941,8 @@
 #else  /* if defined(_WIN32) */
 
 static void
-get_bypass_a=
ddresses(struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPE=
CIFIC */
+// cppcheck-suppress constParameterPointer ; stub
+get_bypass_add=
resses(struct route_bypass *rb, const unsigned int flags)
 {
 }
 
diff --gi=
t a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6c60dc2=2E=2E=
ff243dc 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2E=
c
@@ -389,4 +389,4 @@
 {
     s->earliest_wakeup =3D NULL; /* invalidate ca=
che */
     schedule_remove_node(s, e);
-}
\ No newline at end of file
+}
d=
iff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 33def4e=
=2E=2Edf8e400 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=
=2Ec
@@ -620,7 +620,7 @@
 }
 
 static void
-bind_local(struct link_socket *=
sock)
+bind_local(const struct link_socket *sock)
 {
     /* bind to local =
address/port */
     if (sock->bind_local)
@@ -916,8 +916,8 @@
 }
 
 void
-=
socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_family, =
const char *prefix,
-            bool ipv6only)
+socket_bind(socket_descrip=
tor_t sd, const struct addrinfo *local, int ai_family,
+            const c=
har *prefix, bool ipv6only)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -=
1125,8 +1125,8 @@
  * such as TCP=2E
  */
 
-static void stream_buf_init(st=
ruct stream_buf *sb, struct buffer *buf, const unsigned int sockflags,
-   =
                         const int proto);
+static void stream_buf_init(str=
uct stream_buf *sb, const struct buffer *buf,
+                            =
const unsigned int sockflags, const int proto);
 
 static void stream_buf_c=
lose(struct stream_buf *sb);
 
@@ -1479,7 +1479,7 @@
 }
 
 static void
-pha=
se2_set_socket_flags(struct link_socket *sock)
+phase2_set_socket_flags(con=
st struct link_socket *sock)
 {
     /* TCP_NODELAY is enabled by default o=
n every TCP socket; dco-win is
      * skipped as it manages its own socket=
 */
@@ -2075,7 +2075,7 @@
 }
 
 static void
-stream_buf_init(struct stream_=
buf *sb, struct buffer *buf, const unsigned int sockflags,
+stream_buf_init=
(struct stream_buf *sb, const struct buffer *buf, const unsigned int sockfl=
ags,
                 const int proto)
 {
     sb->buf_init =3D *buf;
@@ -2=
341,7 +2341,7 @@
 #endif
 
 static ssize_t
-link_socket_read_udp_posix_recv=
msg(struct link_socket *sock, struct buffer *buf,
+link_socket_read_udp_pos=
ix_recvmsg(const struct link_socket *sock, struct buffer *buf,
            =
                        struct link_socket_actual *from, socklen_t *fromlen=
)
 {
     struct iovec iov;
@@ -2413,7 +2413,7 @@
 #endif /* if ENABLE_IP_P=
KTINFO */
 
 ssize_t
-link_socket_read_udp_posix(struct link_socket *sock, =
struct buffer *buf,
+link_socket_read_udp_posix(const struct link_socket *s=
ock, struct buffer *buf,
                            struct link_socket_act=
ual *from)
 {
     ssize_t recvlen;
@@ -2476,7 +2476,7 @@
 #if ENABLE_IP_PK=
TINFO
 
 ssize_t
-link_socket_write_udp_posix_sendmsg(struct link_socket *s=
ock, struct buffer *buf,
+link_socket_write_udp_posix_sendmsg(const struct =
link_socket *sock, const struct buffer *buf,
                              =
       struct link_socket_actual *to)
 {
     struct iovec iov;
@@ -2672,7 =
+2672,7 @@
 }
 
 int
-socket_send_queue(struct link_socket *sock, struct bu=
ffer *buf, const struct link_socket_actual *to)
+socket_send_queue(struct l=
ink_socket *sock, const struct buffer *buf, const struct link_socket_actual=
 *to)
 {
     if (sock->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ =
-2772,8 +2772,8 @@
     return sock->writes=2Eiostate;
 }
 
-void
-read_soc=
kaddr_from_overlapped(struct overlapped_io *io, struct sockaddr *dst, int o=
verlapped_ret)
+static void
+read_sockaddr_from_overlapped(const struct ove=
rlapped_io *io, struct sockaddr *dst, int overlapped_ret)
 {
     if (overl=
apped_ret >=3D 0 && io->addr_defined)
     {
diff --git a/src/openvpn/socke=
t=2Eh b/src/openvpn/socket=2Eh
index 46fa29c=2E=2Ecbcdeef 100644
--- a/src/=
openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -268,7 +268,7 @@
 
 int =
socket_recv_queue(struct link_socket *sock, int maxsize);
 
-int socket_sen=
d_queue(struct link_socket *sock, struct buffer *buf,
+int socket_send_queu=
e(struct link_socket *sock, const struct buffer *buf,
                     =
  const struct link_socket_actual *to);
 
 typedef struct
@@ -348,8 +348,8 =
@@
 
 struct link_socket *link_socket_new(void);
 
-void socket_bind(socket=
_descriptor_t sd, struct addrinfo *local, int af_family, const char *prefix=
,
-                 bool ipv6only);
+void socket_bind(socket_descriptor_t s=
d, const struct addrinfo *local, int af_family,
+                 const cha=
r *prefix, bool ipv6only);
 
 int openvpn_connect(socket_descriptor_t sd, c=
onst struct sockaddr *remote, int connect_timeout,
                     vol=
atile int *signal_received);
@@ -496,7 +496,7 @@
 }
 
 static inline bool
-=
link_socket_verify_incoming_addr(struct buffer *buf, const struct link_sock=
et_info *info,
+link_socket_verify_incoming_addr(const struct buffer *buf, =
const struct link_socket_info *info,
                                  cons=
t struct link_socket_actual *from_addr)
 {
     if (buf->len > 0)
@@ -620,7=
 +620,7 @@
 
 #else  /* ifdef _WIN32 */
 
-ssize_t link_socket_read_udp_pos=
ix(struct link_socket *sock, struct buffer *buf,
+ssize_t link_socket_read_=
udp_posix(const struct link_socket *sock, struct buffer *buf,
             =
                       struct link_socket_actual *from);
 
 #endif /* ifdef=
 _WIN32 */
@@ -706,12 +706,12 @@
 
 #else /* ifdef _WIN32 */
 
-ssize_t lin=
k_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *b=
uf,
+ssize_t link_socket_write_udp_posix_sendmsg(const struct link_socket *=
sock, const struct buffer *buf,
                                           =
  struct link_socket_actual *to);
 
 
 static inline ssize_t
-link_socket_w=
rite_udp_posix(struct link_socket *sock, struct buffer *buf,
+link_socket_w=
rite_udp_posix(const struct link_socket *sock, const struct buffer *buf,
  =
                           struct link_socket_actual *to)
 {
 #if ENABLE_IP=
_PKTINFO
@@ -727,7 +727,7 @@
 }
 
 static inline ssize_t
-link_socket_write=
_tcp_posix(struct link_socket *sock, struct buffer *buf)
+link_socket_write=
_tcp_posix(const struct link_socket *sock, const struct buffer *buf)
 {
   =
  return send(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
@@ -785,7=
 +785,7 @@
  * from tunnel packet=2E
  */
 static inline void
-link_socket_=
set_tos(struct link_socket *sock)
+link_socket_set_tos(const struct link_so=
cket *sock)
 {
     if (sock && sock->ptos_defined)
     {
diff --git a/src=
/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13f5962=2E=2Ea=
dd08ba 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_ut=
il=2Eh
@@ -439,7 +439,7 @@
 
 
 static inline bool
-addrlist_match_proto(co=
nst struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int prot=
o)
+addrlist_match_proto(const struct openvpn_sockaddr *a1, const struct ad=
drinfo *addr_list, const int proto)
 {
     return link_socket_proto_connec=
tion_oriented(proto) ? addrlist_match(a1, addr_list)
                      =
                                   : addrlist_port_match(a1, addr_list);
di=
ff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index b84da24=2E=
=2E0296349 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@=
@ -83,7 +83,7 @@
 
 static bool
 socks_proxy_recv_char(uint8_t *c, const ch=
ar *name, socket_descriptor_t sd,
-                      struct event_timeo=
ut *server_poll_timeout,
+                      const struct event_timeout =
*server_poll_timeout,
                       volatile int *signal_received)=

 {
     fd_set reads;
@@ -98,8 +98,8 @@
 }
 
 static bool
-socks_username_=
password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,
-        =
                     struct event_timeout *server_poll_timeout,
+socks_user=
name_password_auth(const struct socks_proxy_info *p, socket_descriptor_t sd=
,
+                             const struct event_timeout *server_poll_tim=
eout,
                              volatile int *signal_received)
 {
     =
char to_send[516];
@@ -157,8 +157,8 @@
 }
 
 static bool
-socks_handshake(s=
truct socks_proxy_info *p, socket_descriptor_t sd,
-                struct =
event_timeout *server_poll_timeout, volatile int *signal_received)
+socks_h=
andshake(const struct socks_proxy_info *p, socket_descriptor_t sd,
+       =
         const struct event_timeout *server_poll_timeout, volatile int *sig=
nal_received)
 {
     uint8_t buf[2];
     int len =3D 0;
@@ -232,7 +232,7 =
@@
 
 static bool
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_=
sockaddr *addr,
-                 struct event_timeout *server_poll_timeout=
, volatile int *signal_received)
+                 const struct event_timeo=
ut *server_poll_timeout, volatile int *signal_received)
 {
     uint8_t aty=
p =3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@
 }
 
 void
-establish_s=
ocks_proxy_passthru(struct socks_proxy_info *p,
+establish_socks_proxy_pass=
thru(const struct socks_proxy_info *p,
                                sock=
et_descriptor_t sd, /* already open to proxy */
                           =
     const char *host,       /* openvpn server remote */
                  =
              const char *servname,   /* openvpn server port */
-          =
                     struct event_timeout *server_poll_timeout,
+          =
                     const struct event_timeout *server_poll_timeout,
     =
                           struct signal_info *sig_info)
 {
     char buf[2=
70];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_socks_proxy_udpassoc(struc=
t socks_proxy_info *p,
+establish_socks_proxy_udpassoc(const struct socks_p=
roxy_info *p,
                                socket_descriptor_t ctrl_sd, =
/* already open to proxy */
                                struct openvpn_=
sockaddr *relay_addr,
-                               struct event_timeout =
*server_poll_timeout,
+                               const struct event_ti=
meout *server_poll_timeout,
                                struct signal_i=
nfo *sig_info)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_timeout=
, &sig_info->signal_received))
diff --git a/src/openvpn/socks=2Eh b/src/ope=
nvpn/socks=2Eh
index caed18c=2E=2E7434bbf 100644
--- a/src/openvpn/socks=2E=
h
+++ b/src/openvpn/socks=2Eh
@@ -49,17 +49,17 @@
 
 void socks_proxy_close=
(struct socks_proxy_info *sp);
 
-void establish_socks_proxy_passthru(struc=
t socks_proxy_info *p,
+void establish_socks_proxy_passthru(const struct so=
cks_proxy_info *p,
                                     socket_descriptor_t=
 sd, /* already open to proxy */
                                     const=
 char *host,       /* openvpn server remote */
                            =
         const char *servname,   /* openvpn server port */
-               =
                     struct event_timeout *server_poll_timeout,
+          =
                          const struct event_timeout *server_poll_timeout,
=
                                     struct signal_info *sig_info);
 
-void=
 establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void establish=
_socks_proxy_udpassoc(const struct socks_proxy_info *p,
                   =
                  socket_descriptor_t ctrl_sd, /* already open to proxy */
=
                                     struct openvpn_sockaddr *relay_addr,
-=
                                    struct event_timeout *server_poll_timeo=
ut,
+                                    const struct event_timeout *server=
_poll_timeout,
                                     struct signal_info *sig=
_info);
 
 void socks_process_incoming_udp(struct buffer *buf, struct link_=
socket_actual *from);
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c
index aeec020=2E=2E3594871 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/ope=
nvpn/ssl=2Ec
@@ -1171,7 +1171,7 @@
 }
 
 struct tls_multi *
-tls_multi_init=
(struct tls_options *tls_options)
+tls_multi_init(const struct tls_options =
*tls_options)
 {
     struct tls_multi *ret;
 
@@ -1212,7 +1212,7 @@
  */
 =

 struct tls_auth_standalone *
-tls_auth_standalone_init(struct tls_options=
 *tls_options, struct gc_arena *gc)
+tls_auth_standalone_init(const struct =
tls_options *tls_options, struct gc_arena *gc)
 {
     struct tls_auth_stan=
dalone *tas;
 
@@ -1631,8 +1631,9 @@
 
 bool
 tls_session_update_crypto_par=
ams_do_work(struct tls_multi *multi, struct tls_session *session,
-        =
                                 struct options *options, struct frame *fra=
me,
-                                         struct frame *frame_fragment,=
 struct link_socket_info *lsi,
+                                         co=
nst struct options *options, struct frame *frame,
+                        =
                 struct frame *frame_fragment,
+                           =
              const struct link_socket_info *lsi,
                         =
                 dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY]=
=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1704,7 +1705,7 @@
 bool
 =
tls_session_update_crypto_params(struct tls_multi *multi, struct tls_sessio=
n *session,
                                  struct options *options, stru=
ct frame *frame,
-                                 struct frame *frame_frag=
ment, struct link_socket_info *lsi,
+                                 struc=
t frame *frame_fragment, const struct link_socket_info *lsi,
              =
                    dco_context_t *dco)
 {
     if (!check_session_cipher(s=
ession, options))
@@ -1920,7 +1921,8 @@
 }
 
 static bool
-push_peer_info_p=
eerid(struct buffer *out, struct tls_multi *multi, struct tls_session *sess=
ion)
+push_peer_info_peerid(struct buffer *out, const struct tls_multi *mul=
ti,
+                      const struct tls_session *session)
 {
     if (m=
ulti->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
     {
@@=
 -1955,7 +1957,7 @@
  * @return          true if no error was encountered
 =
 */
 static bool
-push_peer_info(struct buffer *buf, struct tls_multi *mult=
i, struct tls_session *session)
+push_peer_info(struct buffer *buf, const s=
truct tls_multi *multi, struct tls_session *session)
 {
     struct gc_aren=
a gc =3D gc_new();
     bool ret =3D false;
@@ -2599,8 +2601,8 @@
 }
 
 boo=
l
-session_skip_to_pre_start(struct tls_session *session, struct tls_pre_de=
crypt_state *state,
-                          struct link_socket_actual *f=
rom)
+session_skip_to_pre_start(struct tls_session *session, const struct t=
ls_pre_decrypt_state *state,
+                          const struct link_s=
ocket_actual *from)
 {
     struct key_state *ks =3D &session->key[KS_PRIMA=
RY];
     ks->session_id_remote =3D state->peer_session_id;
@@ -2829,7 +283=
1,7 @@
 
 static bool
 check_outgoing_ciphertext(struct key_state *ks, stru=
ct tls_session *session,
-                          struct buffer *to_link,=
 bool *continue_tls_process)
+                          const struct buffer=
 *to_link, bool *continue_tls_process)
 {
     if (to_link->len)
     {
@@ =
-4193,7 +4195,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, st=
ruct buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, const struct b=
uffer *buf)
 {
     struct key_state *ks =3D multi->save_ks;
     multi->sa=
ve_ks =3D NULL;
@@ -4324,7 +4326,7 @@
  * into a garbage collectable string=
 which is returned=2E
  */
 const char *
-protocol_dump(struct buffer *buff=
er, unsigned int flags, struct gc_arena *gc)
+protocol_dump(const struct bu=
ffer *buffer, unsigned int flags, struct gc_arena *gc)
 {
     struct buffe=
r out =3D alloc_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
diff -=
-git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 5483fbb=2E=2E76c3610=
 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,=
7 @@
  *
  * @return A newly allocated and initialized \c tls_multi structu=
re=2E
  */
-struct tls_multi *tls_multi_init(struct tls_options *tls_option=
s);
+struct tls_multi *tls_multi_init(const struct tls_options *tls_options=
);
 
 /**
  * Finalize initialization of a \c tls_multi structure=2E
@@ -18=
7,7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verification object=
=2E
  */
-struct tls_auth_standalone *tls_auth_standalone_init(struct tls_o=
ptions *tls_options,
+struct tls_auth_standalone *tls_auth_standalone_init(=
const struct tls_options *tls_options,
                                    =
                  struct gc_arena *gc);
 
 /**
@@ -373,7 +373,7 @@
  * @par=
am multi - The TLS state for this packet's destination VPN tunnel=2E
  * @p=
aram buf - The buffer containing the outgoing packet=2E
  */
-void tls_post=
_encrypt(struct tls_multi *multi, struct buffer *buf);
+void tls_post_encry=
pt(struct tls_multi *multi, const struct buffer *buf);
 
 /** @} name Funct=
ions for managing security parameter state for data channel packets */
 
@@=
 -463,7 +463,8 @@
  */
 bool tls_session_update_crypto_params(struct tls_mu=
lti *multi, struct tls_session *session,
                                  =
     struct options *options, struct frame *frame,
-                       =
               struct frame *frame_fragment, struct link_socket_info *lsi,
=
+                                      struct frame *frame_fragment,
+     =
                                 const struct link_socket_info *lsi,
      =
                                 dco_context_t *dco);
 
 /*
@@ -527,7 +528,=
7 @@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT   =
            (1 << 11)
 
-const char *protocol_dump(struct buffer *buffer, u=
nsigned int flags, struct gc_arena *gc);
+const char *protocol_dump(const s=
truct buffer *buffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  * d=
ebugging code
@@ -566,7 +567,7 @@
 /* Special method to skip the three way =
handshake RESET stages=2E This is
  * used by the HMAC code when seeing a p=
acket that matches the previous
  * HMAC based stateless server state */
-b=
ool session_skip_to_pre_start(struct tls_session *session, struct tls_pre_d=
ecrypt_state *state,
-                               struct link_socket_act=
ual *from);
+bool session_skip_to_pre_start(struct tls_session *session, co=
nst struct tls_pre_decrypt_state *state,
+                               co=
nst struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
=
diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
inde=
x a6d57f2=2E=2E2150d81 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/o=
penvpn/ssl_backend=2Eh
@@ -137,7 +137,7 @@
  *
  * @return      true if the=
 context is initialised, false if not=2E
  */
-bool tls_ctx_initialised(str=
uct tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx=
 *ctx);
 
 /**
  * Set any library specific options=2E
diff --git a/src/ope=
nvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 9983742=2E=2E965ec=
db 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=
=2Ec
@@ -146,7 +146,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_ct=
x *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* eit=
her this should be NULL or should be non-null and then have a
      * valid=
 TLS ctx inside as well */
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/o=
penvpn/ssl_openssl=2Ec
index 96e90f82=2E=2E7805d43 100644
--- a/src/openvpn=
/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -129,7 +129,7 @@
 }
 =

 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(=
const struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or sh=
ould be non-null and then have a
      * valid TLS ctx inside as well */
@@=
 -2025,7 +2025,7 @@
 }
 
 static void
-bio_debug_data(const char *mode, BIO=
 *bio, const uint8_t *buf, int len, const char *desc)
+bio_debug_data(const=
 char *mode, const BIO *bio, const uint8_t *buf, int len, const char *desc)=

 {
     struct gc_arena gc =3D gc_new();
     if (len > 0)
@@ -2039,7 +203=
9,7 @@
 }
 
 static void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_deb=
ug_oc(const char *mode, const BIO *bio)
 {
     open_biofp();
     fprintf(=
biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (int64_t)t=
ime(NULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
i=
ndex e9afda4=2E=2Ef78782f 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/op=
envpn/ssl_pkt=2Ec
@@ -119,7 +119,7 @@
  */
 static void
 tls_wrap_control(s=
truct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-             =
    struct session_id *session_id)
+                 const struct session_i=
d *session_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=
=3D TLS_WRAP_NONE)
     {
@@ -403,9 +403,9 @@
 
 
 struct buffer
-tls_reset=
_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-   =
                  struct session_id *own_sid, struct session_id *remote_sid=
, uint8_t header,
-                     bool request_resend_wkc)
+tls_reset=
_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas=
,
+                     const struct session_id *own_sid, const struct sess=
ion_id *remote_sid,
+                     uint8_t header, bool request_rese=
nd_wkc)
 {
     /* Copy buffer here to point at the same data but allow tls=
_wrap_control
      * to potentially change buf to point to another buffer =
without
@@ -490,7 +490,7 @@
 bool
 check_session_hmac_and_pkt_id(struct tls=
_pre_decrypt_state *state,
                               const struct open=
vpn_sockaddr *from,
-                              uint8_t *key,
+         =
                     const uint8_t *key,
                               int=
 handwindow,
                               bool pkt_is_ack)
 {
diff --git =
a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2E8203=
e4a 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -=
183,7 +183,7 @@
  * @return              the expected server session id
  *=
/
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, =
const struct openvpn_sockaddr *from,
-                                   ui=
nt8_t *key, int handwindow, bool pkt_is_ack);
+                            =
       const uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Writ=
e a control channel authentication record=2E
@@ -210,8 +210,9 @@
  * from t=
he tls pre decrypt state=2E
  *
  */
-struct buffer tls_reset_standalone(st=
ruct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                 =
                  struct session_id *own_sid, struct session_id *remote_sid=
,
+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struc=
t tls_auth_standalone *tas,
+                                   const struc=
t session_id *own_sid,
+                                   const struct ses=
sion_id *remote_sid,
                                    uint8_t header, bo=
ol request_resend_wkc);
 
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/o=
penvpn/ssl_verify=2Ec
index 6631718=2E=2E0acba2b 100644
--- a/src/openvpn/s=
sl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1140,7 +1140,7 @@
  * ca=
che=2E
  */
 static bool
-tls_authentication_status_use_cache(struct tls_mu=
lti *multi)
+tls_authentication_status_use_cache(const struct tls_multi *mu=
lti)
 {
     unsigned int idx =3D min_uint(multi->tas_cache_num_updates, SI=
ZE(cache_intervals) - 1);
     time_t latency =3D cache_intervals[idx];
@@ =
-1284,7 +1284,7 @@
  * Check if the script/plugin left a message in the aut=
h failed message
  * file and relay it to the user */
 static void
-check_f=
or_client_reason(struct tls_multi *multi, struct auth_deferred_status *stat=
us)
+check_for_client_reason(struct tls_multi *multi, const struct auth_def=
erred_status *status)
 {
     struct gc_arena gc =3D gc_new();
     const c=
har *msg =3D key_state_check_auth_failed_message_file(status, &gc);
@@ -155=
3,7 +1553,7 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_ve=
rify_user_pass_env(struct user_pass *up, struct tls_multi *multi, struct tl=
s_session *session)
+set_verify_user_pass_env(const struct user_pass *up, s=
truct tls_multi *multi, struct tls_session *session)
 {
     /* Is username=
 defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTION=
AL) || strlen(up->username))
@@ -1581,7 +1581,7 @@
 }
 
 bool
-ssl_verify_u=
sername_length(struct tls_session *session, const char *username)
+ssl_veri=
fy_username_length(const struct tls_session *session, const char *username)=

 {
     if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
     =
    && strlen(username) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_ve=
rify=2Eh b/src/openvpn/ssl_verify=2Eh
index 3176d76=2E=2Ee77bc4a 100644
---=
 a/src/openvpn/ssl_verify=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +2=
02,7 @@
  * @return              true if name is under limit or username-as=
-common-name
  *                      is not active
  */
-bool ssl_verify_u=
sername_length(struct tls_session *session, const char *username);
+bool ss=
l_verify_username_length(const struct tls_session *session, const char *use=
rname);
 
 /**
  * Runs the --client-crresponse script if one is defined=2E=

@@ -275,7 +275,7 @@
 void auth_set_client_reason(struct tls_multi *multi, =
const char *client_reason);
 
 static inline const char *
-tls_client_reaso=
n(struct tls_multi *multi)
+tls_client_reason(const struct tls_multi *multi=
)
 {
     return multi->client_reason;
 }
diff --git a/src/openvpn/status=
=2Ec b/src/openvpn/status=2Ec
index c7d375b=2E=2Ecfbc38d 100644
--- a/src/o=
penvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 vo=
id
-status_reset(struct status_output *so)
+status_reset(const struct statu=
s_output *so)
 {
     if (so && so->fd >=3D 0)
     {
diff --git a/src/open=
vpn/status=2Eh b/src/openvpn/status=2Eh
index 7953a4e=2E=2E4c01d75 100644
-=
-- a/src/openvpn/status=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69,7 +69,7 @@
=
 
 bool status_trigger(struct status_output *so);
 
-void status_reset(stru=
ct status_output *so);
+void status_reset(const struct status_output *so);
=
 
 void status_flush(struct status_output *so);
 
diff --git a/src/openvpn/=
tun=2Ec b/src/openvpn/tun=2Ec
index 133f670=2E=2Ef191a6b 100644
--- a/src/o=
penvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
          cons=
t char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
        =
  int ifconfig_ipv6_netbits_parm,
          const char *ifconfig_ipv6_remot=
e_parm,    /* --ifconfig parm 2 IPv6 */
-         struct addrinfo *local_pu=
blic, struct addrinfo *remote_public, const bool strict_warn,
+         con=
st struct addrinfo *local_public, const struct addrinfo *remote_public, con=
st bool strict_warn,
          struct env_set *es, openvpn_net_ctx_t *ctx, =
struct tuntap *tt)
 {
     if (!tt)
@@ -978,7 +978,7 @@
  * -> helper funct=
ion to simplify code below
  */
 static void
-add_route_connected_v6_net(st=
ruct tuntap *tt, const struct env_set *es)
+add_route_connected_v6_net(cons=
t struct tuntap *tt, const struct env_set *es)
 {
     struct route_ipv6 r6=
;
 
@@ -1020,7 +1020,7 @@
  */
 
 in_addr_t
-create_arbitrary_remote(struct=
 tuntap *tt)
+create_arbitrary_remote(const struct tuntap *tt)
 {
     in_a=
ddr_t remote;
 
@@ -1592,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv4=
(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struc=
t tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     in=
t netbits =3D netmask_to_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 @=
@
 }
 
 static void
-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_=
t *ctx)
+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx=
)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_na=
me, &tt->local_ipv6, tt->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 voi=
d
-undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(=
const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_dr=
iver !=3D DRIVER_NULL && tt->backend_driver !=3D DRIVER_AFUNIX)
     {
@@ -=
1720,13 +1720,13 @@
 }
 
 static ssize_t
-write_tun_header(struct tuntap *t=
t, uint8_t *buf, int len)
+write_tun_header(const struct tuntap *tt, const =
uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
   =
      u_int32_t type;
         struct iovec iv[2];
-        const struct ip=
 *iph =3D (struct ip *)buf;
+        const struct ip *iph =3D (const struct=
 ip *)buf;
 
         if (iph->ip_v =3D=3D 6)
         {
@@ -1737,9 +1737,1=
1 @@
             type =3D htonl(AF_INET);
         }
 
+        /* argumen=
t to writev is a pointer to const but we still need to drop
+         * the=
 const from buf pointer here */
         iv[0]=2Eiov_base =3D &type;
      =
   iv[0]=2Eiov_len =3D sizeof(type);
-        iv[1]=2Eiov_base =3D buf;
+  =
      iv[1]=2Eiov_base =3D (void *)buf;
         iv[1]=2Eiov_len =3D len;
 =

         return header_modify_read_write_return(writev(tt->fd, iv, 2));
@@=
 -1751,7 +1753,7 @@
 }
 
 static ssize_t
-read_tun_header(struct tuntap *tt=
, uint8_t *buf, int len)
+read_tun_header(const struct tuntap *tt, uint8_t =
*buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1777,13=
 +1779,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct t=
untap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const=
 uint8_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }
 =

 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(con=
st struct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header=
(tt, buf, len);
 }
@@ -1799,7 +1801,7 @@
 
 #if defined(TARGET_LINUX) || de=
fined(TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun=
_dco_enabled(const struct tuntap *tt)
 {
     return tt->backend_driver =3D=
=3D DRIVER_DCO;
 }
@@ -2047,13 +2049,13 @@
 }
 
 ssize_t
-write_tun(struct =
tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, cons=
t uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssiz=
e_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const str=
uct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len=
);
 }
@@ -2252,13 +2254,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, u=
int8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *bu=
f, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun=
(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *t=
t, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -258=
8,7 +2590,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, in=
t len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
=
     struct strbuf sbuf;
     sbuf=2Elen =3D len;
@@ -2597,7 +2599,7 @@
 }
=
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(co=
nst struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
 =
    int f =3D 0;
@@ -3095,7 +3097,7 @@
 }
 
 ssize_t
-write_tun(struct tunt=
ap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const ui=
nt8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
   =
  {
@@ -3108,7 +3110,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_=
t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
=
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3243,13 +3245=
,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+=
write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     ret=
urn write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uin=
t8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int le=
n)
 {
     return read(tt->fd, buf, len);
 }
@@ -3311,7 +3313,7 @@
 }
 
 in=
t
-tun_write_queue(struct tuntap *tt, struct buffer *buf)
+tun_write_queue(=
struct tuntap *tt, const struct buffer *buf)
 {
     if (tt->writes=2Eiosta=
te =3D=3D IOSTATE_INITIAL)
     {
@@ -3365,7 +3367,7 @@
 }
 
 int
-tun_writ=
e_win32(struct tuntap *tt, struct buffer *buf)
+tun_write_win32(struct tunt=
ap *tt, const struct buffer *buf)
 {
     int err =3D 0;
     int status =
=3D 0;
@@ -5370,7 +5372,7 @@
 }
 
 void
-fork_register_dns_action(struct tu=
ntap *tt)
+fork_register_dns_action(const struct tuntap *tt)
 {
     if (tt=
 && tt->options=2Eregister_dns && tt->options=2Emsg_channel)
     {
@@ -546=
0,7 +5462,7 @@
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)
+tuntap=
_get_mtu(const struct tuntap *tt)
 {
     ULONG mtu =3D 0;
     DWORD len;
=
@@ -6035,7 +6037,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)
+tun_sh=
ow_debug(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D WIN=
DOWS_DRIVER_TAP_WINDOWS6)
     {
@@ -6295,13 +6297,13 @@
 }
 
 ssize_t
-wri=
te_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tu=
ntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, le=
n);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read=
_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt=
->fd, buf, len);
 }
diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
=
index 7340e7e=2E=2E61fe943 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openv=
pn/tun=2Eh
@@ -272,9 +272,9 @@
 
 void close_tun_handle(struct tuntap *tt);=

 
-ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t w=
rite_tun(const struct tuntap *tt, const uint8_t *buf, int len);
 
-ssize_t =
read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(const=
 struct tuntap *tt, uint8_t *buf, int len);
 
 #ifdef ENABLE_FEATURE_TUN_PE=
RSIST
 void tuncfg(const char *dev, const char *dev_type, const char *dev_n=
ode, int persist_mode,
@@ -293,7 +293,7 @@
                         const c=
har *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */
         =
                int ifconfig_ipv6_netbits_parm,           /* --ifconfig par=
m 1 / bits */
                         const char *ifconfig_ipv6_remote_par=
m,    /* --ifconfig parm 2 / IPv6 */
-                        struct addrin=
fo *local_public, struct addrinfo *remote_public,
+                        =
const struct addrinfo *local_public, const struct addrinfo *remote_public,
=
                         const bool strict_warn, struct env_set *es, openvp=
n_net_ctx_t *ctx,
                         struct tuntap *tt);
 
@@ -320,7 =
+320,7 @@
  * @param tt    the tuntap interface context
  * @param ctx   th=
e networking API opaque context
  */
-void undo_ifconfig(struct tuntap *tt,=
 openvpn_net_ctx_t *ctx);
+void undo_ifconfig(const struct tuntap *tt, open=
vpn_net_ctx_t *ctx);
 
 bool is_dev_type(const char *dev, const char *dev_t=
ype, const char *match_type);
 
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAU=
LT IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconfig_order(struct tunt=
ap *tt)
+ifconfig_order(const struct tuntap *tt)
 {
     if (tt->backend_dr=
iver =3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_=
DEFAULT ROUTE_AFTER_TUN
 
 static inline int
-route_order(struct tuntap *tt=
)
+route_order(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=
=3D DRIVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 const char *tap_win_geti=
nfo(const struct tuntap *tt, struct gc_arena *gc);
 
-void tun_show_debug(s=
truct tuntap *tt);
+void tun_show_debug(const struct tuntap *tt);
 
 bool d=
hcp_release_by_adapter_index(const DWORD adapter_index);
 
 bool dhcp_renew=
_by_adapter_index(const DWORD adapter_index);
 
-void fork_register_dns_act=
ion(struct tuntap *tt);
+void fork_register_dns_action(const struct tuntap =
*tt);
 
 void ipconfig_register_dns(const struct env_set *es);
 
@@ -470,7 =
+470,7 @@
 
 int tun_read_queue(struct tuntap *tt, int maxsize);
 
-int tun=
_write_queue(struct tuntap *tt, struct buffer *buf);
+int tun_write_queue(s=
truct tuntap *tt, const struct buffer *buf);
 
 static inline bool
 tuntap_=
stop(int status)
@@ -499,7 +499,7 @@
     return false;
 }
 
-int tun_write=
_win32(struct tuntap *tt, struct buffer *buf);
+int tun_write_win32(struct =
tuntap *tt, const struct buffer *buf);
 
 static inline bool
 is_ip_packet_=
valid(const struct buffer *buf)
@@ -529,19 +529,21 @@
 }
 
 static inline b=
ool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct t=
untap *tt)
 {
     return tt && tt->backend_driver =3D=3D DRIVER_DCO;
 }
 
=
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t s=
tatus)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)
=
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() =
=3D=3D ERROR_NETNAME_DELETED);
 }
 
 #else  /* ifdef _WIN32 */
 
+// cppche=
ck-suppress-begin constParameterPointer ; stubs
+
 static inline bool
 tunt=
ap_stop(int status)
 {
@@ -565,19 +567,20 @@
     return true;
 }
 
-
 stat=
ic inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(con=
st struct tuntap *tt)
 {
     return false;
 }
 
 static inline bool
-tunta=
p_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_=
timeout(const struct tuntap *tt, ssize_t status)
 {
     return false;
 }
 =

+// cppcheck-suppress-end constParameterPointer
+
 #endif /* ifdef _WIN32 =
*/
 
 /*
diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=
=2Ec
index f494d42=2E=2E79d706a 100644
--- a/src/openvpn/tun_afunix=2Ec
+++=
 b/src/openvpn/tun_afunix=2Ec
@@ -49,7 +49,7 @@
 
 
 static void
-tun_afuni=
x_exec_child(const char *dev_node, struct tuntap *tt, struct env_set *env)
=
+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, const struc=
t env_set *env)
 {
     const char *msgprefix =3D "ERROR: failure executing=
 process for tun:";
     struct argv argv =3D argv_new();
@@ -74,7 +74,7 @@=

 }
 
 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt,=
 struct env_set *orig_env)
+open_tun_afunix(const struct options *o, int mt=
u, struct tuntap *tt, const struct env_set *orig_env)
 {
     struct gc_are=
na gc =3D gc_new();
 
@@ -146,7 +146,7 @@
 }
 
 ssize_t
-write_tun_afunix(s=
truct tuntap *tt, uint8_t *buf, int len)
+write_tun_afunix(struct tuntap *t=
t, const uint8_t *buf, int len)
 {
     const char *msg =3D "ERROR: failure=
 during write to AF_UNIX socket: ";
     if (!openvpn_waitpid_check(tt->afu=
nix=2Echildprocess, msg, M_WARN))
@@ -172,8 +172,11 @@
     return read(tt-=
>fd, buf, len);
 }
 #else  /* ifndef WIN32 */
+
+// cppcheck-suppress-begin=
 constParameterPointer ; stubs
+
 void
-open_tun_afunix(struct options *o, =
int mtu, struct tuntap *tt, struct env_set *orig_env)
+open_tun_afunix(cons=
t struct options *o, int mtu, struct tuntap *tt, const struct env_set *orig=
_env)
 {
     msg(M_ERR, "AF_UNIX socket support not available on this plat=
form");
 }
@@ -186,7 +189,7 @@
 }
 
 ssize_t
-write_tun_afunix(struct tunta=
p *tt, uint8_t *buf, int len)
+write_tun_afunix(struct tuntap *tt, const ui=
nt8_t *buf, int len)
 {
     /* should never be called as open_tun_afunix a=
lways fails */
     ASSERT(0);
@@ -199,4 +202,6 @@
     ASSERT(0);
 }
 
+//=
 cppcheck-suppress-end constParameterPointer
+
 #endif /* ifndef WIN32 */
d=
iff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh
index 5=
b6a8e0=2E=2E5307e31 100644
--- a/src/openvpn/tun_afunix=2Eh
+++ b/src/openv=
pn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
  * the user provided taking care of im=
plementing the actual tun
  * device=2E
  */
-void open_tun_afunix(struct o=
ptions *o, int mtu, struct tuntap *tt, struct env_set *env);
+void open_tun=
_afunix(const struct options *o, int mtu, struct tuntap *tt, const struct e=
nv_set *env);
 
 
 /**
@@ -43,7 +43,7 @@
 /**
  * Writes a packet to a AF_U=
NIX based tun device=2E
  */
-ssize_t write_tun_afunix(struct tuntap *tt, u=
int8_t *buf, int len);
+ssize_t write_tun_afunix(struct tuntap *tt, const u=
int8_t *buf, int len);
 
 /**
  * Reads a packet from a AF_UNIX based tun d=
evice=2E
diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index 69a=
c10d=2E=2E04e18d6 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=
=2Ec
@@ -288,7 +288,7 @@
 }
 
 void
-vlan_process_outgoing_tun(struct multi=
_context *m, struct multi_instance *mi)
+vlan_process_outgoing_tun(const st=
ruct multi_context *m, struct multi_instance *mi)
 {
     if (!m->top=2Eopt=
ions=2Evlan_tagging)
     {
diff --git a/src/openvpn/vlan=2Eh b/src/openvpn=
/vlan=2Eh
index 9389f89=2E=2Ecd2f66f 100644
--- a/src/openvpn/vlan=2Eh
+++ =
b/src/openvpn/vlan=2Eh
@@ -35,6 +35,6 @@
 
 bool vlan_is_tagged(const struc=
t buffer *buf);
 
-void vlan_process_outgoing_tun(struct multi_context *m, =
struct multi_instance *mi);
+void vlan_process_outgoing_tun(const struct mu=
lti_context *m, struct multi_instance *mi);
 
 #endif /* VLAN_H */
diff --g=
it a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh
index 8be3d96=2E=2E39ff7=
d8 100644
--- a/src/openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -227,7=
 +227,7 @@
 void overlapped_io_close(struct overlapped_io *o);
 
 static in=
line bool
-overlapped_io_active(struct overlapped_io *o)
+overlapped_io_act=
ive(const struct overlapped_io *o)
 {
     return o->iostate =3D=3D IOSTATE=
_QUEUED || o->iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;
 }
diff --git a/src/=
openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 1a1=
7d95=2E=2Ed2fd9af 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/=
openvpnmsica/openvpnmsica=2Ec
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS o=
n success; An error code otherwise
  */
 static UINT
-setup_sequence(_In_ M=
SIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *se=
q)
+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_=
 const struct msica_arg_seq *seq)
 {
     UINT uiResult;
     LPWSTR szSequ=
ence =3D msica_arg_seq_join(seq);
diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 9a68bbb=2E=2Ed8cf6e1 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -522,7 +522,7 @@
 
 
 static SOCKADDR_INET
-sockaddr_inet(short family, i=
net_address_t *addr)
+sockaddr_inet(short family, const inet_address_t *add=
r)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet)=
);
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_t=
ests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2Efff4c2b 100644
--- a/te=
sts/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/m=
ock_management=2Ec
@@ -36,7 +36,7 @@
 struct management *management; /* GLO=
BAL */
 
 void
-management_auth_failure(struct management *man, const char =
*type, const char *reason)
+management_auth_failure(const struct management=
 *man, const char *type, const char *reason)
 {
     ASSERT(false);
 }
diff=
 --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/op=
envpn/siphash_openssl=2Ec
index 52f13b8=2E=2Ee7282b2 100644
--- a/tests/uni=
t_tests/openvpn/siphash_openssl=2Ec
+++ b/tests/unit_tests/openvpn/siphash_=
openssl=2Ec
@@ -100,7 +100,7 @@
 }
 
 bool
-siphash_openssl_available(void =
*sip_context)
+siphash_openssl_available(const void *sip_context)
 {
     c=
onst struct siphash_context *sip =3D sip_context;
 
@@ -117,6 +117,8 @@
 }
=
 #else
 /* Do avoid a lot more ifdefs in the test we put dummy functions he=
re */
+// cppcheck-suppress-begin constParameterPointer ; stubs
+
 int
 sip=
hash_openssl(void *sip_context, const void *in, const size_t inlen,
       =
          const void *k, uint8_t *out, const size_t outlen)
@@ -125,7 +127,=
7 @@
 }
 
 bool
-siphash_openssl_available(void *sip_context)
+siphash_open=
ssl_available(const void *sip_context)
 {
     return false;
 }
@@ -141,5 +=
143,6 @@
 {
 }
 
+// cppcheck-suppress-end constParameterPointer
 
 #endif =
/* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000=
000L */
diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/u=
nit_tests/openvpn/siphash_openssl=2Eh
index 0f1d329=2E=2Ea44457e 100644
---=
 a/tests/unit_tests/openvpn/siphash_openssl=2Eh
+++ b/tests/unit_tests/open=
vpn/siphash_openssl=2Eh
@@ -60,5 +60,5 @@
  *
  */
 bool
-siphash_openssl_a=
vailable(void *sip_context);
-#endif /* ifndef SIPHASH_OPENSSL_H */
\ No ne=
wline at end of file
+siphash_openssl_available(const void *sip_context);
+=
#endif /* ifndef SIPHASH_OPENSSL_H */
diff --git a/tests/unit_tests/openvpn=
/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 8d88943=2E=2E=
aea40f0 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/uni=
t_tests/openvpn/test_misc=2Ec
@@ -146,7 +146,7 @@
 }
 
 static struct hash_=
element *
-hash_lookup_by_value(struct hash *hash, void *value)
+hash_looku=
p_by_value(struct hash *hash, const void *value)
 {
     struct hash_iterat=
or hi;
     struct hash_element *he;
diff --git a/tests/unit_tests/openvpn/=
test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index c0a0=
866=2E=2E7636a33 100644
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+=
++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -59,7 +59,7 @@
     ret=
urn mock();
 }
 void
-management_auth_failure(struct management *man, const=
 char *type, const char *reason)
+management_auth_failure(const struct mana=
gement *man, const char *type, const char *reason)
 {
     assert_true(0);
=
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d1=
99c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: =
32
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--Ww8JveovDX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #32</strong> to th=
is change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
63?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is=
 no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatis=
fied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove instances of constParameterPointer cppc=
heck warnings<br><br>This requires a few suppressions since cppcheck<br>doe=
sn&#39;t quite understand the different code-paths<br>implemented by prepro=
cessor defines=2E<br><br>Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f=
58<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>-=
--<br>M dev-tools/cppcheck-suppressions=2Exml<br>M sample/sample-plugins/cl=
ient-connect/sample-client-connect=2Ec<br>M sample/sample-plugins/defer/mul=
ti-auth=2Ec<br>M sample/sample-plugins/keying-material-exporter-demo/keying=
materialexporter=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/clinat=2E=
c<br>M src/openvpn/comp=2Ec<br>M src/openvpn/comp=2Eh<br>M src/openvpn/cryp=
to=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/dco=2Ec<br>M src/openvp=
n/dco=2Eh<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_internal=2E=
h<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/open=
vpn/error=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/event=2Ec<br>M sr=
c/openvpn/event=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=
=2Eh<br>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/openvpn/i=
nterval=2Eh<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/op=
envpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/mbuf=2Ec<br>M=
 src/openvpn/mbuf=2Eh<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mss=2Eh<br>=
M src/openvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<=
br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/mult=
i_io=2Ec<br>M src/openvpn/networking=2Eh<br>M src/openvpn/networking_iprout=
e2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/occ=2Eh<br>M =
src/openvpn/openssl_compat=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvp=
n/options_parse=2Ec<br>M src/openvpn/otime=2Ec<br>M src/openvpn/otime=2Eh<b=
r>M src/openvpn/proto=2Eh<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/proxy=
=2Eh<br>M src/openvpn/ps=2Ec<br>M src/openvpn/ps=2Eh<br>M src/openvpn/push=
=2Ec<br>M src/openvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>M src/open=
vpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M src/openvpn/route=2Ec<b=
r>M src/openvpn/schedule=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/s=
ocket=2Eh<br>M src/openvpn/socket_util=2Eh<br>M src/openvpn/socks=2Ec<br>M =
src/openvpn/socks=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>=
M src/openvpn/ssl_backend=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/ope=
nvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=
=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_verify=2Eh<br>M s=
rc/openvpn/status=2Ec<br>M src/openvpn/status=2Eh<br>M src/openvpn/tun=2Ec<=
br>M src/openvpn/tun=2Eh<br>M src/openvpn/tun_afunix=2Ec<br>M src/openvpn/t=
un_afunix=2Eh<br>M src/openvpn/vlan=2Ec<br>M src/openvpn/vlan=2Eh<br>M src/=
openvpn/win32=2Eh<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/openvpnse=
rv/interactive=2Ec<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>M t=
ests/unit_tests/openvpn/siphash_openssl=2Ec<br>M tests/unit_tests/openvpn/s=
iphash_openssl=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/u=
nit_tests/openvpn/test_user_pass=2Ec<br>90 files changed, 401 insertions(+)=
, 287 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/63/1663/32</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-too=
ls/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</spa=
n><br><span>index 9d8c202=2E=2Ebd24c3b 100644</span><br><span>--- a/dev-too=
ls/cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-sup=
pressions=2Exml</span><br><span>@@ -9,9 +9,6 @@</span><br><span>     &lt;id=
&gt;constParameterCallback&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;<=
/span><br><span>   &lt;suppress&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br><span>   =
  &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;<=
/span><br><span>   &lt;suppress&gt;</span><br><span>@@ -65,6 +62,97 @@</spa=
n><br><span>     &lt;id&gt;badBitmaskCheck&lt;/id&gt;</span><br><span>     =
&lt;fileName&gt;tests/unit_tests/openvpn/test_pkt=2Ec&lt;/fileName&gt;</spa=
n><br><span>   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;!-- IGN: we use casts to remove const --&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPoin=
ter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;fileName&gt;src/openvpn/buffer=2Eh&lt;/fileName&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;buf&lt;/symbolName=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: c=
onst silently removed due to pointer arithmetic --&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/openvpn/buffer=2Ec&lt;/fileName&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;buf&lt;/symbolName&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: external =
--&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppres=
s&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;=
constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;fileName&gt;/usr/include/*&lt;/fileName&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: too many false-=
positives due to stubs --&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/unit_tests/op=
envpn*/test_*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/unit_tests/o=
penvpn/mock_*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;!-- IGN: too many false-positives due to library/platform-=
specific code --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/crypto*&lt;/file=
Name&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppr=
ess&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&g=
t;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &lt;fileName&gt;src/openvpn/ssl_*&lt;/fileName&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParamet=
erPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;fileName&gt;src/openvpn/dco*&lt;/fileName&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/openvpn/socket=2E*&lt;/fileName&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;!-- FP: const is only possible on some plat=
forms</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       These m=
ight easily hide valid issues but we need to compromise</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+       for developer sanity=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+       Inline suppressions a=
re often too ugly since they need to go in</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+       between our return type line and the function=
 name=2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  --&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;con=
stParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;fileName&gt;src/openvpn/dns=2Ec&lt;/fileName&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;duri&l=
t;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/error=2Ec&lt;/fileN=
ame&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symb=
olName&gt;gc&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/forwa=
rd=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;symbolName&gt;dco&lt;/symbolName&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;=
src/openvpn/manage=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;symbolName&gt;man&lt;/symbolName&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPoi=
nter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&lt;fileName&gt;src/openvpn/misc=2Ec&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;up&lt;/symbolName&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;cons=
tParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;fileName&gt;src/openvpn/options=2Ec&lt;/fileName&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;opt=
ions&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/tun=2Ec&lt;/f=
ileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
symbolName&gt;gc&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;!-- IGN: weird issue with MinGW debug build throwing =
-Werror=3Dmaybe-uninitialized</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+       for no good reason --&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/op=
envpn/buffer=2Eh&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;symbolName&gt;p&lt;/symbolName&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span>  =
 &lt;!-- FP: cppcheck seems to have wrong signature of DeviceIoControl() --=
&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;con=
stVariablePointer&lt;/id&gt;</span><br><span>diff --git a/sample/sample-plu=
gins/client-connect/sample-client-connect=2Ec b/sample/sample-plugins/clien=
t-connect/sample-client-connect=2Ec</span><br><span>index 420de61=2E=2Ecbd9=
8e8 100644</span><br><span>--- a/sample/sample-plugins/client-connect/sampl=
e-client-connect=2Ec</span><br><span>+++ b/sample/sample-plugins/client-con=
nect/sample-client-connect=2Ec</span><br><span>@@ -344,7 +344,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-openvpn_plugin_client_connect(struct plugin_con=
text *context, const char **argv, const char **envp)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_client_connect(const struc=
t plugin_context *context, const char **argv, const char **envp)</span><br>=
<span> {</span><br><span>     /* log environment variables handed to us by =
OpenVPN, but</span><br><span>      * only if &quot;setenv verb&quot; is 3 o=
r higher (arbitrary number)</span><br><span>@@ -465,7 +465,7 @@</span><br><=
span> </span><br><span> int</span><br><span> openvpn_plugin_client_connect_=
defer_v2(struct plugin_context *context,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                       struct plugin_per=
_client_context *pcc,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                       const struct plugin_per_client_con=
text *pcc,</span><br><span>                                        struct o=
penvpn_plugin_string_list **return_list)</span><br><span> {</span><br><span=
>     time_t time_left =3D pcc-&gt;sleep_until - time(NULL);</span><br><spa=
n>diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/sample-p=
lugins/defer/multi-auth=2Ec</span><br><span>index bacf557=2E=2Ecdd616f 1006=
44</span><br><span>--- a/sample/sample-plugins/defer/multi-auth=2Ec</span><=
br><span>+++ b/sample/sample-plugins/defer/multi-auth=2Ec</span><br><span>@=
@ -255,7 +255,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_auth_user=
_pass(struct plugin_context *context, const char *username, const char *pas=
sword)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_auth_user_=
pass(const struct plugin_context *context, const char *username, const char=
 *password)</span><br><span> {</span><br><span>     plog(context, PLOG_NOTE=
, &quot;expect_user=3D%s, received_user=3D%s, expect_passw=3D%s, received_p=
assw=3D%s&quot;,</span><br><span>          np(context-&gt;test_valid_user),=
 np(username), np(context-&gt;test_valid_pass), np(password));</span><br><s=
pan>@@ -279,7 +279,7 @@</span><br><span> </span><br><span> </span><br><span=
> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-auth_user=
_pass_verify(struct plugin_context *context, struct plugin_per_client_conte=
xt *pcc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_user_p=
ass_verify(const struct plugin_context *context, struct plugin_per_client_c=
ontext *pcc,</span><br><span>                       const char *argv[], con=
st char *envp[])</span><br><span> {</span><br><span>     /* get username/pa=
ssword from envp string array */</span><br><span>diff --git a/sample/sample=
-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec b/sample/=
sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec</sp=
an><br><span>index 204374b=2E=2E41c5c4f 100644</span><br><span>--- a/sample=
/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec</s=
pan><br><span>+++ b/sample/sample-plugins/keying-material-exporter-demo/key=
ingmaterialexporter=2Ec</span><br><span>@@ -187,7 +187,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-file_store(char *file, char *content)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+file_store(const char *file,=
 const char *content)</span><br><span> {</span><br><span>     FILE *f;</spa=
n><br><span>     if (!(f =3D fopen(file, &quot;w+&quot;)))</span><br><span>=
@@ -203,7 +203,7 @@</span><br><span> server_store(struct openvpn_plugin_arg=
s_func_in const *args)</span><br><span> {</span><br><span>     struct plugi=
n *plugin =3D (struct plugin *)args-&gt;handle;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct session *sess =3D (struct session *)ar=
gs-&gt;per_client_context;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct session *sess =3D args-&gt;per_client_context;</spa=
n><br><span> </span><br><span>     char file[MAXPATH];</span><br><span>    =
 snprintf(file, sizeof(file) - 1, &quot;/tmp/openvpn_sso_%s&quot;, sess-&gt=
;key);</span><br><span>@@ -215,7 +215,7 @@</span><br><span> client_store(st=
ruct openvpn_plugin_args_func_in const *args)</span><br><span> {</span><br>=
<span>     struct plugin *plugin =3D (struct plugin *)args-&gt;handle;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session *sess =
=3D (struct session *)args-&gt;per_client_context;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const struct session *sess =3D args-&gt;=
per_client_context;</span><br><span> </span><br><span>     char *file =3D &=
quot;/tmp/openvpn_sso_user&quot;;</span><br><span>     ovpn_note(&quot;app =
session file: %s&quot;, file);</span><br><span>diff --git a/src/openvpn/buf=
fer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 58e10f0=2E=2E063a2d4=
 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/=
src/openvpn/buffer=2Eh</span><br><span>@@ -1920,7 +1920,7 @@</span><br><spa=
n>  * @param a  The arena to test=2E</span><br><span>  */</span><br><span> =
static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_=
defined(struct gc_arena *a)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+gc_defined(const struct gc_arena *a)</span><br><span> {</span><br><=
span>     return a-&gt;list !=3D NULL;</span><br><span> }</span><br><span>d=
iff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span=
>index dcef924=2E=2Ed72d42a 100644</span><br><span>--- a/src/openvpn/clinat=
=2Ec</span><br><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -158,7=
 +158,7 @@</span><br><span> #endif</span><br><span> </span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_pkt(struc=
t openvpn_iphdr *iph, const char *prefix, const int direction, const msglvl=
_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_p=
kt(const struct openvpn_iphdr *iph, const char *prefix, const int direction=
, const msglvl_t msglevel)</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span> </span><br><span>diff --git a/src=
/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><br><span>index b88b79f=2E=
=2E387a7c4 100644</span><br><span>--- a/src/openvpn/comp=2Ec</span><br><spa=
n>+++ b/src/openvpn/comp=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br>=
<span> #endif /* USE_COMP */</span><br><span> </span><br><span> bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-check_compression_settings_v=
alid(struct compress_options *info, msglvl_t msglevel)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_compression_settings_valid(const s=
truct compress_options *info, msglvl_t msglevel)</span><br><span> {</span><=
br><span>     /*</span><br><span>      * We also allow comp-stub-v2 here as=
 it technically allows escaping of</span><br><span>diff --git a/src/openvpn=
/comp=2Eh b/src/openvpn/comp=2Eh</span><br><span>index 29a90a2=2E=2Ead80243=
 100644</span><br><span>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/sr=
c/openvpn/comp=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span>  * fl=
ags of allow-compression and also the whether algorithms are compiled</span=
><br><span>  * in</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool check_compression_settings_valid(struct compress_opti=
ons *info, msglvl_t msglevel);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool check_compression_settings_valid(const struct compress_opti=
ons *info, msglvl_t msglevel);</span><br><span> </span><br><span> #ifdef US=
E_COMP</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span>dif=
f --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>i=
ndex 1703d4d=2E=2E3d3ab0c 100644</span><br><span>--- a/src/openvpn/crypto=
=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1105,=
7 +1105,7 @@</span><br><span> }</span><br><span> </span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_is_zero(struct=
 key *key, const struct key_type *kt)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+key_is_zero(const struct key *key, const struct key_type =
*kt)</span><br><span> {</span><br><span>     size_t cipher_length =3D ciphe=
r_kt_key_size(kt-&gt;cipher);</span><br><span>     for (size_t i =3D 0; i &=
lt; cipher_length; ++i)</span><br><span>@@ -1123,7 +1123,7 @@</span><br><sp=
an>  * Make sure that cipher key is a valid key for current key_type=2E</sp=
an><br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-check_key(struct key *key, const struct key_type *kt)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_key(const struct =
key *key, const struct key_type *kt)</span><br><span> {</span><br><span>   =
  if (cipher_defined(kt-&gt;cipher))</span><br><span>     {</span><br><span=
>@@ -1196,7 +1196,7 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_crypto(str=
uct crypto_options *co, struct frame *frame)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+test_crypto(struct crypto_options *co, const struc=
t frame *frame)</span><br><span> {</span><br><span>     int i, j;</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/s=
rc/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index ee5b50=
f=2E=2Ee3c1c6a 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><b=
r><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</s=
pan><br><span>  */</span><br><span> int write_key_file(const int nkeys, con=
st char *filename);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-bool check_key(struct key *key, const struct key_type *kt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_key(cons=
t struct key *key, const struct key_type *kt);</span><br><span> </span><br>=
<span> /**</span><br><span>  * Initialize a key_type structure with=2E</spa=
n><br><span>@@ -614,7 +614,7 @@</span><br><span> /** Print a cipher list en=
try */</span><br><span> void print_cipher(const char *cipher);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void test_crypto=
(struct crypto_options *co, struct frame *f);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void test_crypto(struct crypto_options *co, const=
 struct frame *f);</span><br><span> </span><br><span> </span><br><span> /* =
key direction functions */</span><br><span>diff --git a/src/openvpn/dco=2Ec=
 b/src/openvpn/dco=2Ec</span><br><span>index 9fc0e3b=2E=2Ef3b5d44 100644</s=
pan><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/d=
co=2Ec</span><br><span>@@ -573,7 +573,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_multi_get_localaddr(struct multi_context *m, struct multi_i=
nstance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_mul=
ti_get_localaddr(const struct multi_context *m, const struct multi_instance=
 *mi,</span><br><span>                         struct sockaddr_storage *loc=
al)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><sp=
an>@@ -585,7 +585,7 @@</span><br><span>         return false;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket=
_infos[0]-&gt;lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct link_socket_actual *actual =3D &amp;c-&gt;c2=2El=
ink_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span> =
    switch (actual-&gt;dest=2Eaddr=2Esa=2Esa_family)</span><br><span>     {=
</span><br><span>@@ -623,7 +623,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dc=
o_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer=
(const struct multi_context *m, struct multi_instance *mi)</span><br><span>=
 {</span><br><span>     const struct context *c =3D &amp;mi-&gt;context;</s=
pan><br><span> </span><br><span>@@ -677,7 +677,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dco_install_iroute(struct multi_context *m, struct multi_inst=
ance *mi, struct mroute_addr *addr)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_install_iroute(struct multi_context *m, struct multi_in=
stance *mi, const struct mroute_addr *addr)</span><br><span> {</span><br><s=
pan> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32=
)</span><br><span>     if (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><b=
r><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><s=
pan>index 7ef75fee=2E=2Ec435f8c 100644</span><br><span>--- a/src/openvpn/dc=
o=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -204,7 +=
204,7 @@</span><br><span>  * @param mi        the client instance</span><br=
><span>  * @return          0 on success or a negative error code otherwise=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_multi_a=
dd_new_peer(const struct multi_context *m, struct multi_instance *mi);</spa=
n><br><span> </span><br><span> /**</span><br><span>  * Install an iroute in=
 DCO, which means adding a route to the system routing</span><br><span>@@ -=
215,7 +215,7 @@</span><br><span>  * @param addr      the route to add</span=
><br><span>  */</span><br><span> void dco_install_iroute(struct multi_conte=
xt *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        struct mroute_addr *addr);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        const st=
ruct mroute_addr *addr);</span><br><span> </span><br><span> /**</span><br><=
span>  * Remove all routes added through the specified client</span><br><sp=
an>@@ -253,7 +253,7 @@</span><br><span>  * a 64 bit packet counter and AEAD=
 tag at the end=2E</span><br><span>  */</span><br><span> bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct cont=
ext *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_support=
s_epoch_data(const struct context *c);</span><br><span> #else  /* if define=
d(ENABLE_DCO) */</span><br><span> </span><br><span> typedef void *dco_conte=
xt_t;</span><br><span>@@ -350,7 +350,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static inline int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_context *m, struct mul=
ti_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco=
_multi_add_new_peer(const struct multi_context *m, struct multi_instance *m=
i)</span><br><span> {</span><br><span>     return 0;</span><br><span> }</sp=
an><br><span>@@ -384,7 +384,7 @@</span><br><span> }</span><br><span> </span=
><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct cont=
ext *c)</span><br><span> {</span><br><span>     return false;</span><br><sp=
an> }</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvp=
n/dco_freebsd=2Ec</span><br><span>index 87eea55=2E=2E3148f10 100644</span><=
br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvp=
n/dco_freebsd=2Ec</span><br><span>@@ -929,7 +929,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct=
 context *c)</span><br><span> {</span><br><span>     return false;</span><b=
r><span> }</span><br><span>diff --git a/src/openvpn/dco_internal=2Eh b/src/=
openvpn/dco_internal=2Eh</span><br><span>index fcf8aca=2E=2E1022e66 100644<=
/span><br><span>--- a/src/openvpn/dco_internal=2Eh</span><br><span>+++ b/sr=
c/openvpn/dco_internal=2Eh</span><br><span>@@ -59,8 +59,9 @@</span><br><spa=
n>  * They are implemented by dco_linux=2Ec</span><br><span>  */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_new_pe=
er(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct =
sockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4=
, const struct in6_addr *vpn_ipv6);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int dco_new_peer(dco_context_t *dco, unsigned int peerid, s=
ocket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 c=
onst struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br>=
<span> </span><br><span> int dco_del_peer(dco_context_t *dco, unsigned int =
peerid);</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_lin=
ux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index a397fb8=2E=2E4412a=
d0 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+=
++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -104,7 +104,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> static struct nl_msg *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_co=
ntext_t *dco, uint8_t cmd)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)</span><=
br><span> {</span><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc();</=
span><br><span>     if (!nl_msg)</span><br><span>@@ -842,7 +842,7 @@</span>=
<br><span> </span><br><span> /* libnl &lt; 3=2E11=2E0 does not implement nl=
a_get_uint() */</span><br><span> static uint64_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-ovpn_nla_get_uint(struct nlattr *attr)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_get_uint(const struc=
t nlattr *attr)</span><br><span> {</span><br><span>     if (nla_len(attr) =
=3D=3D sizeof(uint32_t))</span><br><span>     {</span><br><span>@@ -954,7 +=
954,7 @@</span><br><span> }</span><br><span> </span><br><span> static bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_iface_check(dco_c=
ontext_t *dco, struct nlattr *attrs[])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ovpn_iface_check(const dco_context_t *dco, struct nlattr=
 *attrs[])</span><br><span> {</span><br><span>     /* we must know which in=
terface this message is referring to in order to</span><br><span>      * av=
oid mixing messages for other instances</span><br><span>@@ -1381,7 +1381,7 =
@@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct cont=
ext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports=
_epoch_data(const struct context *c)</span><br><span> {</span><br><span>   =
  return false;</span><br><span> }</span><br><span>diff --git a/src/openvpn=
/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index 6e5e295=2E=2E1=
2b0666 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span=
>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -1092,7 +1092,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_d=
ata(const struct context *c)</span><br><span> {</span><br><span>     OVPN_V=
ERSION ver =3D { 0 };</span><br><span>     return dco_get_version(&amp;ver)=
 &amp;&amp; ((ver=2EMajor =3D=3D 2 &amp;&amp; ver=2EMinor &gt;=3D 8) || (ve=
r=2EMajor &gt; 2));</span><br><span>diff --git a/src/openvpn/error=2Ec b/sr=
c/openvpn/error=2Ec</span><br><span>index 26d4c7c=2E=2E32d819d 100644</span=
><br><span>--- a/src/openvpn/error=2Ec</span><br><span>+++ b/src/openvpn/er=
ror=2Ec</span><br><span>@@ -623,7 +623,7 @@</span><br><span>  * from the OS=
=2E</span><br><span>  */</span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-x_check_status(ssize_t status, const char *descrip=
tion, struct link_socket *sock, struct tuntap *tt)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+x_check_status(ssize_t status, const char *d=
escription, struct link_socket *sock, const struct tuntap *tt)</span><br><s=
pan> {</span><br><span>     const char *extended_msg =3D NULL;</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/error=2Eh b/src/openvpn/erro=
r=2Eh</span><br><span>index 9f39572=2E=2E373cbc1 100644</span><br><span>---=
 a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</span>=
<br><span>@@ -304,10 +304,10 @@</span><br><span> void set_check_status(unsi=
gned int info_level, unsigned int verbose_level);</span><br><span> </span><=
br><span> void x_check_status(ssize_t status, const char *description, stru=
ct link_socket *sock,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    struct tuntap *tt);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    const struct tuntap *tt);</span><br=
><span> </span><br><span> static inline void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-check_status(ssize_t status, const char *description=
, struct link_socket *sock, struct tuntap *tt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+check_status(ssize_t status, const char *descrip=
tion, struct link_socket *sock, const struct tuntap *tt)</span><br><span> {=
</span><br><span>     if (status &lt; 0 || check_debug_level(x_cs_verbose_l=
evel))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/even=
t=2Ec b/src/openvpn/event=2Ec</span><br><span>index 4089401=2E=2E5e17ea1 10=
0644</span><br><span>--- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/=
openvpn/event=2Ec</span><br><span>@@ -1012,7 +1012,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> static int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-se_wait_return(struct se_set *ses, fd_set *read, fd=
_set *write, struct event_set_return *out,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+se_wait_return(struct se_set *ses, const fd_set *rea=
d, const fd_set *write, struct event_set_return *out,</span><br><span>     =
           int outlen)</span><br><span> {</span><br><span>     int i, j =3D=
 0;</span><br><span>diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=
=2Eh</span><br><span>index b784dfe=2E=2E0940a1d 100644</span><br><span>--- =
a/src/openvpn/event=2Eh</span><br><span>+++ b/src/openvpn/event=2Eh</span><=
br><span>@@ -204,7 +204,7 @@</span><br><span> #else /* ifdef _WIN32 */</spa=
n><br><span> </span><br><span> static inline void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-wait_signal(struct event_set *es, void *arg)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+wait_signal(const stru=
ct event_set *es, const void *arg)</span><br><span> {</span><br><span> }</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/=
openvpn/forward=2Ec</span><br><span>index b97fb7a=2E=2E681210d 100644</span=
><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/=
forward=2Ec</span><br><span>@@ -237,7 +237,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-parse_incoming_control_channel_command(struct context *c, =
struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
parse_incoming_control_channel_command(struct context *c, const struct buff=
er *buf)</span><br><span> {</span><br><span>     if (buf_string_match_head_=
str(buf, &quot;AUTH_FAILED&quot;))</span><br><span>     {</span><br><span>@=
@ -507,7 +507,7 @@</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_server_poll_rema=
ining_time(struct event_timeout *server_poll_timeout)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+get_server_poll_remaining_time(const stru=
ct event_timeout *server_poll_timeout)</span><br><span> {</span><br><span> =
    update_time();</span><br><span>     int remaining =3D event_timeout_rem=
aining(server_poll_timeout);</span><br><span>@@ -621,7 +621,7 @@</span><br>=
<span>  * Buffer reallocation, for use with null encryption=2E</span><br><s=
pan>  */</span><br><span> static inline void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-buffer_turnover(const uint8_t *orig_buf, struct buff=
er *dest_stub, struct buffer *src_stub,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+buffer_turnover(const uint8_t *orig_buf, struct buffer =
*dest_stub, const struct buffer *src_stub,</span><br><span>                =
 struct buffer *storage)</span><br><span> {</span><br><span>     if (orig_b=
uf =3D=3D src_stub-&gt;data &amp;&amp; src_stub-&gt;data !=3D storage-&gt;d=
ata)</span><br><span>@@ -908,7 +908,7 @@</span><br><span>  */</span><br><sp=
an> </span><br><span> static inline void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-socks_postprocess_incoming_link(struct context *c, struc=
t link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+socks_postprocess_incoming_link(struct context *c, const struct link_socke=
t *sock)</span><br><span> {</span><br><span>     if (sock-&gt;socks_proxy &=
amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><br><span>     {</s=
pan><br><span>@@ -1005,7 +1005,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pr=
ocess_incoming_link_part1(struct context *c, struct link_socket_info *lsi, =
bool floated)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proces=
s_incoming_link_part1(struct context *c, const struct link_socket_info *lsi=
, bool floated)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     bool decrypt_status =3D false;</span><br=
><span>@@ -1555,7 +1555,7 @@</span><br><span>  * @param client    Determine=
s whether to the send packet back via tun or link</span><br><span>  */</spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ipv6=
_send_icmp_unreachable(struct context *c, struct buffer *buf, bool client)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6_send_icmp_unrea=
chable(struct context *c, const struct buffer *buf, bool client)</span><br>=
<span> {</span><br><span> #define MAX_ICMPV6LEN 1280</span><br><span>     s=
truct openvpn_icmp6hdr icmp6out;</span><br><span>diff --git a/src/openvpn/f=
orward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 0309725=2E=2E375=
635b 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span><br><span>+=
++ b/src/openvpn/forward=2Eh</span><br><span>@@ -126,7 +126,7 @@</span><br>=
<span>  */</span><br><span> void encrypt_sign(struct context *c, bool comp_=
frag);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int get_server_poll_remaining_time(struct event_timeout *server_poll_tim=
eout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int get_serve=
r_poll_remaining_time(const struct event_timeout *server_poll_timeout);</sp=
an><br><span> </span><br><span> /******************************************=
****************************/</span><br><span> /**</span><br><span>@@ -177,=
7 +177,7 @@</span><br><span>  *</span><br><span>  * @return true if packet =
is authenticated, false otherwise=2E</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-bool process_incoming_link_part1(struct=
 context *c, struct link_socket_info *lsi, bool floated);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool process_incoming_link_part1(stru=
ct context *c, const struct link_socket_info *lsi, bool floated);</span><br=
><span> </span><br><span> /**</span><br><span>  * Continues processing a pa=
cket read from the external network interface=2E</span><br><span>diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 9306a9=
6=2E=2E3c2ebf9 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br>=
<span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -803,7 +803,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-init_port_share(struct context *c)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+init_port_share(const =
struct context *c)</span><br><span> {</span><br><span>     if (!port_share =
&amp;&amp; (c-&gt;options=2Eport_share_host &amp;&amp; c-&gt;options=2Eport=
_share_port))</span><br><span>     {</span><br><span>@@ -1245,7 +1245,7 @@<=
/span><br><span>  * prepending to msg() output=2E</span><br><span>  */</spa=
n><br><span> const char *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-format_common_name(struct context *c, struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+format_common_name(const struct =
context *c, struct gc_arena *gc)</span><br><span> {</span><br><span>     st=
ruct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>     if (c-&gt;c=
2=2Etls_multi)</span><br><span>@@ -1731,7 +1731,7 @@</span><br><span> </spa=
n><br><span> </span><br><span> static bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-can_preserve_tun(struct tuntap *tt)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+can_preserve_tun(const struct tuntap *=
tt)</span><br><span> {</span><br><span>     if (tt &amp;&amp; tt-&gt;backen=
d_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -1=
753,7 +1753,7 @@</span><br><span>  * @param c pointer to the connection con=
text</span><br><span>  */</span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-add_wfp_block(struct context *c)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block(const struct co=
ntext *c)</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br=
><span>     /* Fortify &#39;redirect-gateway block-local&#39; with firewall=
 rules? */</span><br><span>@@ -1779,7 +1779,7 @@</span><br><span>  * @param=
 adapter_index the VPN adapter index</span><br><span>  */</span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-del_wfp_bl=
ock(struct context *c, unsigned long adapter_index)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+del_wfp_block(const struct context *c, un=
signed long adapter_index)</span><br><span> {</span><br><span> #if defined(=
_WIN32)</span><br><span>     if (c-&gt;options=2Eblock_outside_dns || block=
_local_needed(c-&gt;c1=2Eroute_list))</span><br><span>diff --git a/src/open=
vpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index ce8f74e=2E=2Ec486=
158 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++ b=
/src/openvpn/init=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span> </=
span><br><span> uint64_t pull_permission_mask(const struct context *c);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const c=
har *format_common_name(struct context *c, struct gc_arena *gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+const char *format_common_name=
(const struct context *c, struct gc_arena *gc);</span><br><span> </span><br=
><span> void reset_coarse_timers(struct context *c);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/interval=2Eh b/src/openvpn/interval=2E=
h</span><br><span>index 59051bd=2E=2E0cfe202 100644</span><br><span>--- a/s=
rc/openvpn/interval=2Eh</span><br><span>+++ b/src/openvpn/interval=2Eh</spa=
n><br><span>@@ -89,7 +89,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-interval_schedule_wakeup(struct interval *top, interval_t *wakeup)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+interval_schedule_wake=
up(const struct interval *top, interval_t *wakeup)</span><br><span> {</span=
><br><span>     const time_t local_now =3D now;</span><br><span>     interv=
al_earliest_wakeup(wakeup, top-&gt;last_test_true + top-&gt;refresh, local_=
now);</span><br><span>@@ -214,7 +214,7 @@</span><br><span>  * This function=
 does not check if the timeout is actually valid=2E</span><br><span>  */</s=
pan><br><span> static inline interval_t</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-event_timeout_remaining(struct event_timeout *et)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+event_timeout_remaining(con=
st struct event_timeout *et)</span><br><span> {</span><br><span>     return=
 (interval_t)((et-&gt;last + et-&gt;n) - now);</span><br><span> }</span><br=
><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><=
span>index e51dcd0=2E=2Edcd59d7 100644</span><br><span>--- a/src/openvpn/li=
st=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -164,7=
 +164,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_remove_by_value(struct=
 hash *hash, void *value)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+hash_remove_by_value(struct hash *hash, const void *value)</span><br>=
<span> {</span><br><span>     struct hash_iterator hi;</span><br><span>    =
 const struct hash_element *he;</span><br><span>diff --git a/src/openvpn/li=
st=2Eh b/src/openvpn/list=2Eh</span><br><span>index 55bc3c8=2E=2E23267d0 10=
0644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/o=
penvpn/list=2Eh</span><br><span>@@ -78,7 +78,7 @@</span><br><span> </span><=
br><span> bool hash_remove_fast(struct hash *hash, struct hash_bucket *buck=
et, const void *key, uint64_t hv);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void hash_remove_by_value(struct hash *hash=
, void *value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 hash_remove_by_value(struct hash *hash, const void *value);</span><br><spa=
n> </span><br><span> struct hash_iterator</span><br><span> {</span><br><spa=
n>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><s=
pan>index 0aef2d4=2E=2E1e74f09 100644</span><br><span>--- a/src/openvpn/man=
age=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -33=
0,7 +330,7 @@</span><br><span> }</span><br><span> </span><br><span> static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_delete_unix_s=
ocket(struct management *man)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+man_delete_unix_socket(const struct management *man)</span><br><s=
pan> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>     if ((man=
-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D M=
F_UNIX_SOCK)</span><br><span>@@ -676,7 +676,7 @@</span><br><span>  * for th=
e log and echo commands=2E</span><br><span>  */</span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_history(struct m=
anagement *man, const char *parm, const char *type, struct log_history *log=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_history(struct=
 management *man, const char *parm, const char *type, const struct log_hist=
ory *log,</span><br><span>             bool *realtime, const unsigned int l=
ep_flags)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span>@@ -852,7 +852,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-man_net(struct management *man)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+man_net(const struct management *man)</span><br><s=
pan> {</span><br><span>     if (man-&gt;persist=2Ecallback=2Eshow_net)</spa=
n><br><span>     {</span><br><span>@@ -888,7 +888,7 @@</span><br><span> #if=
def ENABLE_PKCS11</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id_count(struct manag=
ement *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_pkcs=
11_id_count(const struct management *man)</span><br><span> {</span><br><spa=
n>     msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_i=
d_count());</span><br><span> }</span><br><span>@@ -2366,7 +2366,7 @@</span>=
<br><span>  * the route/ifconfig/open tun command=2E   See doc/android=2Etx=
t for details=2E</span><br><span>  */</span><br><span> bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-management_android_control(struct man=
agement *man, const char *command, const char *msg)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+management_android_control(const struct m=
anagement *man, const char *command, const char *msg)</span><br><span> {</s=
pan><br><span>     if (!man)</span><br><span>     {</span><br><span>@@ -301=
3,7 +3013,7 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_up_down(stru=
ct management *man, const char *updown, const struct env_set *es)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_up_down(const stru=
ct management *man, const char *updown, const struct env_set *es)</span><br=
><span> {</span><br><span>     if (man-&gt;settings=2Eflags &amp; MF_UP_DOW=
N)</span><br><span>     {</span><br><span>@@ -3208,7 +3208,7 @@</span><br><=
span> }</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-management_auth_failure(struct management *man, c=
onst char *type, const char *reason)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+management_auth_failure(const struct management *man, cons=
t char *type, const char *reason)</span><br><span> {</span><br><span>     i=
f (reason)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 1e7855d=2E=2Ef2c6=
916 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++=
 b/src/openvpn/manage=2Eh</span><br><span>@@ -368,7 +368,7 @@</span><br><sp=
an>                                 const unsigned int flags, const char *s=
tatic_challenge);</span><br><span> </span><br><span> #ifdef TARGET_ANDROID<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool management_androi=
d_control(struct management *man, const char *command, const char *msg);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool management_androi=
d_control(const struct management *man, const char *command, const char *ms=
g);</span><br><span> </span><br><span> #define ANDROID_KEEP_OLD_TUN      1<=
/span><br><span> #define ANDROID_OPEN_BEFORE_CLOSE 2</span><br><span>@@ -38=
2,7 +382,7 @@</span><br><span> </span><br><span> void management_event_loop=
_n_seconds(struct management *man, int sec);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void management_up_down(struct man=
agement *man, const char *updown, const struct env_set *es);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void management_up_down(const stru=
ct management *man, const char *updown, const struct env_set *es);</span><b=
r><span> </span><br><span> void management_notify(const char *severity, con=
st char *type,</span><br><span>                        const char *text);</=
span><br><span>@@ -482,7 +482,7 @@</span><br><span>  * OpenVPN calls here t=
o indicate a password failure</span><br><span>  */</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void management_auth_failure=
(struct management *man, const char *type, const char *reason);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void management_auth_failure(co=
nst struct management *man, const char *type, const char *reason);</span><b=
r><span> </span><br><span> /*</span><br><span>  * Echo an authentication to=
ken to management interface</span><br><span>diff --git a/src/openvpn/mbuf=
=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>index 5bb397f=2E=2E163251c 1006=
44</span><br><span>--- a/src/openvpn/mbuf=2Ec</span><br><span>+++ b/src/ope=
nvpn/mbuf=2Ec</span><br><span>@@ -165,7 +165,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-mbuf_dereference_instance(struct mbuf_set *ms, struct multi_ins=
tance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbuf_dere=
ference_instance(struct mbuf_set *ms, const struct multi_instance *mi)</spa=
n><br><span> {</span><br><span>     if (ms)</span><br><span>     {</span><b=
r><span>diff --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh</span><br>=
<span>index cfe698c=2E=2Ee368054 100644</span><br><span>--- a/src/openvpn/m=
buf=2Eh</span><br><span>+++ b/src/openvpn/mbuf=2Eh</span><br><span>@@ -75,7=
 +75,7 @@</span><br><span> </span><br><span> bool mbuf_extract_item(struct =
mbuf_set *ms, struct mbuf_item *item);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void mbuf_dereference_instance(struct mb=
uf_set *ms, struct multi_instance *mi);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void mbuf_dereference_instance(struct mbuf_set *ms, con=
st struct multi_instance *mi);</span><br><span> </span><br><span> static in=
line bool</span><br><span> mbuf_defined(const struct mbuf_set *ms)</span><b=
r><span>diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><s=
pan>index 36bbb43=2E=2E0cfa272d 100644</span><br><span>--- a/src/openvpn/ms=
s=2Ec</span><br><span>+++ b/src/openvpn/mss=2Ec</span><br><span>@@ -239,8 +=
239,8 @@</span><br><span> }</span><br><span> </span><br><span> static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_fragme=
nt(struct frame *frame, struct key_type *kt, const struct options *options,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
    struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+frame_calculate_fragment(struct frame *frame, const struct ke=
y_type *kt, const struct options *options,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         const struct link_socket_in=
fo *lsi)</span><br><span> {</span><br><span> #if defined(ENABLE_FRAGMENT)</=
span><br><span>     size_t overhead;</span><br><span>@@ -269,8 +269,8 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_mssfix(struct fra=
me *frame, struct key_type *kt, const struct options *options,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                       struct link=
_socket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
rame_calculate_mssfix(struct frame *frame, const struct key_type *kt, const=
 struct options *options,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                       const struct link_socket_info *lsi)</span><br>=
<span> {</span><br><span>     if (options-&gt;ce=2Emssfix_fixed)</span><br>=
<span>     {</span><br><span>@@ -314,8 +314,8 @@</span><br><span> }</span><=
br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-frame_calculate_dynamic(struct frame *frame, struct key_type *kt=
, const struct options *options,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        struct link_socket_info *lsi)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_dynamic(struct=
 frame *frame, const struct key_type *kt, const struct options *options,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  const struct link_socket_info *lsi)</span><br><span> {</span><br><span>  =
   if (options-&gt;ce=2Efragment &gt; 0)</span><br><span>     {</span><br><=
span>diff --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh</span><br><span=
>index 1d092bb=2E=2E2eab55a 100644</span><br><span>--- a/src/openvpn/mss=2E=
h</span><br><span>+++ b/src/openvpn/mss=2Eh</span><br><span>@@ -36,8 +36,8 =
@@</span><br><span> void mss_fixup_dowork(struct buffer *buf, uint16_t maxm=
ss);</span><br><span> </span><br><span> /** Set the --mssfix option=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void frame_calculate_dy=
namic(struct frame *frame, struct key_type *kt,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                             const struct options=
 *options, struct link_socket_info *lsi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void frame_calculate_dynamic(struct frame *frame, con=
st struct key_type *kt,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                             const struct options *options, const struc=
t link_socket_info *lsi);</span><br><span> </span><br><span> /**</span><br>=
<span>  * Checks and adjusts the fragment and mssfix value according to the=
</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</=
span><br><span>index 4d173c4=2E=2Ec744638 100644</span><br><span>--- a/src/=
openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span=
>@@ -67,7 +67,7 @@</span><br><span> }</span><br><span> </span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_instance_=
specific_init(struct multi_context *m, struct multi_instance *mi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_tcp_instance_specific_i=
nit(const struct multi_context *m, struct multi_instance *mi)</span><br><sp=
an> {</span><br><span>     /* buffer for queued TCP socket output packets *=
/</span><br><span>     mi-&gt;tcp_link_out_deferred =3D mbuf_init(m-&gt;top=
=2Eoptions=2En_bcast_buf);</span><br><span>diff --git a/src/openvpn/mtcp=2E=
h b/src/openvpn/mtcp=2Eh</span><br><span>index 9b7d1d2=2E=2Ebb117fa 100644<=
/span><br><span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/openvp=
n/mtcp=2Eh</span><br><span>@@ -35,7 +35,7 @@</span><br><span> </span><br><s=
pan> void multi_tcp_dereference_instance(struct multi_io *multi_io, struct =
multi_instance *mi);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool multi_tcp_instance_specific_init(struct multi_context=
 *m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool multi_tcp_instance_specific_init(const struct multi_conte=
xt *m, struct multi_instance *mi);</span><br><span> </span><br><span> void =
multi_tcp_instance_specific_free(struct multi_instance *mi);</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2E=
c</span><br><span>index 69e30e5=2E=2E201d756 100644</span><br><span>--- a/s=
rc/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><s=
pan>@@ -54,8 +54,9 @@</span><br><span>  * @param sock    the socket to send=
 the reply on</span><br><span>  */</span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-send_standalone_reply(struct mult=
i_context *m, struct buffer *buf, const char *prefix,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      const char *detail, s=
truct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+send_standalone_reply(struct multi_context *m, const struct buffer *bu=
f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
     const char *prefix, const char *detail,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                      struct link_socket *sock)</s=
pan><br><span> {</span><br><span>     struct context *c =3D &amp;m-&gt;top;=
</span><br><span> </span><br><span>@@ -75,7 +76,7 @@</span><br><span> </spa=
n><br><span> static void</span><br><span> send_hmac_reset_packet(struct mul=
ti_context *m, struct tls_pre_decrypt_state *state,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       struct tls_auth_stan=
dalone *tas, struct session_id *sid,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       const struct tls_auth_standalone *t=
as, const struct session_id *sid,</span><br><span>                        b=
ool request_resend_wkc, struct link_socket *sock)</span><br><span> {</span>=
<br><span>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epac=
ket_id=2Esend);</span><br><span>@@ -117,11 +118,11 @@</span><br><span> </sp=
an><br><span>     enum first_packet_verdict verdict;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_auth_standa=
lone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct tls_auth_standalone *tas=
 =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span> </span><br><spa=
n>     verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Ef=
rom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Eses=
sion_id_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span> =
    const struct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Ede=
st;</span><br><span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake=
_window;</span><br><span> </span><br><span>@@ -240,7 +241,7 @@</span><br><s=
pan> static struct multi_instance *</span><br><span> handle_connection_atte=
mpt(struct multi_context *m,</span><br><span>                           str=
uct link_socket *sock,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                          struct mroute_addr *real)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          const struct mr=
oute_addr *real)</span><br><span> {</span><br><span>     struct gc_arena gc=
 =3D gc_new();</span><br><span> </span><br><span>@@ -308,7 +309,7 @@</span>=
<br><span>  * @return      instance matching the address, NULL otherwise</s=
pan><br><span>  */</span><br><span> static struct multi_instance *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_real(st=
ruct multi_context *m, struct mroute_addr *real)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_get_instance_udp_real(struct multi_conte=
xt *m, const struct mroute_addr *real)</span><br><span> {</span><br><span> =
    struct hash *hash =3D m-&gt;hash;</span><br><span>     const uint64_t h=
v =3D hash_value(hash, real);</span><br><span>@@ -353,7 +354,9 @@</span><br=
><span>  * maintaining real address hash table atomicity=2E</span><br><span=
>  */</span><br><span> struct multi_instance *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-multi_get_instance_udp_data(struct multi_context *=
m, bool *floated, struct mroute_addr *real, struct link_socket *sock)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_da=
ta(struct multi_context *m, bool *floated,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                            const struct mroute_addr=
 *real,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                const struct link_socket *sock)</span><br><span> {</span><b=
r><span>     struct multi_instance *mi =3D NULL;</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><b=
r><span>index dda9232=2E=2Ea2cfdbf 100644</span><br><span>--- a/src/openvpn=
/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -=
58,7 +58,7 @@</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_L=
OOP</span><br><span> static const char *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-id(struct multi_instance *mi)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+id(const struct multi_instance *mi)</span><br>=
<span> {</span><br><span>     if (mi)</span><br><span>     {</span><br><spa=
n>@@ -1336,7 +1336,7 @@</span><br><span>  * same common name=2E</span><br><=
span>  */</span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_delete_dup(struct multi_context *m, struct multi_ins=
tance *new_mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi=
_delete_dup(struct multi_context *m, const struct multi_instance *new_mi)</=
span><br><span> {</span><br><span>     if (new_mi)</span><br><span>     {</=
span><br><span>@@ -2281,7 +2281,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-multi_client_setup_dco_initial(struct multi_context *m, struct multi_=
instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
client_setup_dco_initial(const struct multi_context *m, struct multi_instan=
ce *mi,</span><br><span>                                struct gc_arena *gc=
)</span><br><span> {</span><br><span>     if (!dco_enabled(&amp;mi-&gt;cont=
ext=2Eoptions))</span><br><span>@@ -2479,7 +2479,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-multi_check_dest_addr_allowed(struct multi_context *=
m, struct multi_instance *mi, struct mroute_addr *real);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct m=
ulti_context *m, struct multi_instance *mi, const struct mroute_addr *real)=
;</span><br><span> </span><br><span> /**</span><br><span>  * This sets up t=
he client real address (outer tunnel addr) in the</span><br><span>@@ -3130,=
7 +3130,8 @@</span><br><span>  * positive=2E</span><br><span>  */</span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mu=
lti_check_dest_addr_allowed(struct multi_context *m, struct multi_instance =
*mi, struct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, struct mu=
lti_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                            const struct mroute_addr *real)</span><br><span=
> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>=
     const uint64_t hv =3D hash_value(hash, real);</span><br><span>@@ -3289=
,7 +3290,7 @@</span><br><span> </span><br><span> #if defined(ENABLE_DCO)</s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-process_incoming_del_peer(struct multi_context *m, struct multi_instan=
ce *mi, dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+process_incoming_del_peer(struct multi_context *m, struct multi_ins=
tance *mi, const dco_context_t *dco)</span><br><span> {</span><br><span>   =
  const char *reason =3D &quot;ovpn-dco: unknown reason&quot;;</span><br><s=
pan>     switch (dco-&gt;dco_del_peer_reason)</span><br><span>@@ -4342,7 +4=
343,7 @@</span><br><span> </span><br><span> /* Searches for the address and=
 deletes it if it is owned by the multi_instance */</span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_ad=
dr(struct multi_context *m, struct multi_instance *mi, const struct mroute_=
addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_un=
learn_addr(struct multi_context *m, const struct multi_instance *mi, const =
struct mroute_addr *addr)</span><br><span> {</span><br><span>     struct ha=
sh_element *he;</span><br><span>     const uint64_t hv =3D hash_value(m-&gt=
;vhash, addr);</span><br><span>@@ -4377,7 +4378,7 @@</span><br><span>  * @p=
aram a     The new IPv4 address in network byte order</span><br><span>  */<=
/span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-multi_unlearn_in_addr_t(struct multi_context *m, struct multi_instan=
ce *mi, in_addr_t a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+multi_unlearn_in_addr_t(struct multi_context *m, const struct multi_instan=
ce *mi, in_addr_t a)</span><br><span> {</span><br><span>     struct mroute_=
addr addr;</span><br><span>     CLEAR(addr);</span><br><span>@@ -4395,7 +43=
96,7 @@</span><br><span>  * @param a6    The new IPv6 address</span><br><sp=
an>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_unlearn_in6_addr(struct multi_context *m, struct multi=
_instance *mi, struct in6_addr a6)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_unlearn_in6_addr(struct multi_context *m, const struct=
 multi_instance *mi, struct in6_addr a6)</span><br><span> {</span><br><span=
>     struct mroute_addr addr;</span><br><span>     CLEAR(addr);</span><br>=
<span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br>=
<span>index c424ad3=2E=2E5db7147 100644</span><br><span>--- a/src/openvpn/m=
ulti=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -52=
9,7 +529,7 @@</span><br><span>  */</span><br><span> </span><br><span> stati=
c inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_pref=
ix(struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+set_prefix(const struct multi_instance *mi)</span><br><span> {</s=
pan><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     if (mi-&g=
t;msg_prefix[0])</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/sr=
c/openvpn/multi_io=2Ec</span><br><span>index 348e424=2E=2Ebb5dde58 100644</=
span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/ope=
nvpn/multi_io=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span>  * a=
 point-to-multipoint tunnel=2E</span><br><span>  */</span><br><span> static=
 unsigned int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow=
_flags(const struct multi_context *m, struct link_socket *sock)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct mul=
ti_context *m, const struct link_socket *sock)</span><br><span> {</span><br=
><span>     unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span> </span=
><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=
=2Eh</span><br><span>index bce0c19=2E=2E25233c8 100644</span><br><span>--- =
a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=
=2Eh</span><br><span>@@ -44,7 +44,7 @@</span><br><span>  */</span><br><span=
> #if !defined(ENABLE_IPROUTE)</span><br><span> static inline int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct context *c,=
 openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)</span><b=
r><span> {</span><br><span>     (void)c;</span><br><span>     (void)ctx;</s=
pan><br><span>@@ -75,7 +75,7 @@</span><br><span>  *</span><br><span>  * @re=
turn          0 on success, a negative error code otherwise</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_ctx_init=
(struct context *c, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int net_ctx_init(const struct context *c, openvpn_=
net_ctx_t *ctx);</span><br><span> </span><br><span> /**</span><br><span>  *=
 Release resources allocated by the internal garbage collector</span><br><s=
pan>@@ -102,7 +102,7 @@</span><br><span>  * @return          0 on success, =
negative error code on error</span><br><span>  */</span><br><span> int net_=
iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const c=
har *type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
       void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                 const void *arg);</span><br><span> </span><br><span> /**</=
span><br><span>  * Retrieve the interface type</span><br><span>diff --git a=
/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec<=
/span><br><span>index a1f3525=2E=2Ef091fb3 100644</span><br><span>--- a/src=
/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networki=
ng_iproute2=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><span> #include=
 &lt;netinet/in=2Eh&gt;</span><br><span> </span><br><span> int</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct context *c, op=
envpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)</span><br><=
span> {</span><br><span>     ctx-&gt;es =3D NULL;</span><br><span>     if (=
c)</span><br><span>@@ -61,7 +61,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ne=
t_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, vo=
id *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_n=
ew(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void =
*arg)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new=
();</span><br><span> </span><br><span>diff --git a/src/openvpn/networking_s=
itnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index 83915db=
=2E=2E49de664 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec=
</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ =
-1007,7 +1007,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_de=
l(sa_family_t af_family, const char *iface, inet_address_t *addr, int prefi=
xlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del=
(sa_family_t af_family, const char *iface, const inet_address_t *addr, int =
prefixlen)</span><br><span> {</span><br><span>     int ifindex;</span><br><=
span> </span><br><span>@@ -1250,8 +1250,8 @@</span><br><span> }</span><br><=
span> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-sitnl_route_del(const char *iface, sa_family_t af_family, inet=
_address_t *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                inet_address_t *gw, uint32_t table, int metric)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(const=
 char *iface, sa_family_t af_family, const inet_address_t *dst, int prefixl=
en,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
const inet_address_t *gw, uint32_t table, int metric)</span><br><span> {</s=
pan><br><span>     int ifindex =3D 0;</span><br><span> </span><br><span>@@ =
-1328,7 +1328,7 @@</span><br><span> </span><br><span> </span><br><span> int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn=
_net_ctx_t *ctx, const char *iface, const char *type, void *arg)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_=
t *ctx, const char *iface, const char *type, const void *arg)</span><br><sp=
an> {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><spa=
n>     int ret =3D -1;</span><br><span>diff --git a/src/openvpn/occ=2Eh b/s=
rc/openvpn/occ=2Eh</span><br><span>index bda4f18=2E=2E49def4d 100644</span>=
<br><span>--- a/src/openvpn/occ=2Eh</span><br><span>+++ b/src/openvpn/occ=
=2Eh</span><br><span>@@ -156,7 +156,7 @@</span><br><span>  * via control ch=
annel=2E</span><br><span>  * @return control channel exit message should be=
 used */</span><br><span> static inline bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-cc_exit_notify_enabled(struct context *c)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+cc_exit_notify_enabled(const s=
truct context *c)</span><br><span> {</span><br><span>     /* Check if we ha=
ve TLS active at all */</span><br><span>     if (!c-&gt;c2=2Etls_multi)</sp=
an><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/open=
ssl_compat=2Eh</span><br><span>index 098bdd5=2E=2E1a934db 100644</span><br>=
<span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvp=
n/openssl_compat=2Eh</span><br><span>@@ -127,7 +127,7 @@</span><br><span> /=
* Mimics the functions but only when the default context without</span><br>=
<span>  * options is chosen */</span><br><span> static inline const EVP_CIP=
HER *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_CIPHER_fetch=
(void *ctx, const char *algorithm, const char *properties)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+EVP_CIPHER_fetch(const void *ctx, co=
nst char *algorithm, const char *properties)</span><br><span> {</span><br><=
span>     ASSERT(!ctx);</span><br><span>     ASSERT(!properties);</span><br=
><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </span><br><=
span> static inline const EVP_MD *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-EVP_MD_fetch(void *ctx, const char *algorithm, const char *pro=
perties)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_MD_fetc=
h(const void *ctx, const char *algorithm, const char *properties)</span><br=
><span> {</span><br><span>     ASSERT(!ctx);</span><br><span>     ASSERT(!p=
roperties);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec</span><br><span>index 6664c73=2E=2Ee7585ad 100644</span><br=
><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opti=
ons=2Ec</span><br><span>@@ -2429,7 +2429,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-options_postprocess_mutate_le(struct connection_entry *ce, s=
truct local_entry *le, int mode)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+options_postprocess_mutate_le(const struct connection_entry *c=
e, struct local_entry *le, int mode)</span><br><span> {</span><br><span>   =
  /* use the global port if none is specified */</span><br><span>     if (!=
le-&gt;port)</span><br><span>@@ -3589,7 +3589,7 @@</span><br><span> static =
bool</span><br><span> verify_permission(const char *name, const char *file,=
 int line, const uint64_t type,</span><br><span>                   const ui=
nt64_t allowed, uint64_t *found, const msglvl_t msglevel,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                  struct options *optio=
ns, bool is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                  const struct options *options, bool is_inline)</span><br>=
<span> {</span><br><span>     if (!(type &amp; allowed))</span><br><span>  =
   {</span><br><span>@@ -3665,7 +3665,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static inline msglvl_t</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-msglevel_forward_compatible(struct options *options,=
 const msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+msglevel_forward_compatible(const struct options *options, const msgl=
vl_t msglevel)</span><br><span> {</span><br><span>     return options-&gt;f=
orward_compatible ? M_WARN : msglevel;</span><br><span> }</span><br><span>@=
@ -4154,7 +4154,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_compr=
ession_warning(struct compress_options *info)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+show_compression_warning(const struct compress_op=
tions *info)</span><br><span> {</span><br><span>     if (comp_non_stub_enab=
led(info))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
options_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index 129=
34ab=2E=2E79b8098 100644</span><br><span>--- a/src/openvpn/options_parse=2E=
c</span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@ -2=
58,7 +258,7 @@</span><br><span> }</span><br><span> </span><br><span> static=
 char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_inline_fi=
le(struct in_src *is, const char *close_tag, int *num_lines, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_inline_f=
ile(const struct in_src *is, const char *close_tag, int *num_lines, struct =
gc_arena *gc)</span><br><span> {</span><br><span>     char line[OPTION_LINE=
_SIZE];</span><br><span>     struct buffer buf =3D alloc_buf(8 * OPTION_LIN=
E_SIZE);</span><br><span>@@ -302,7 +302,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-check_inline_file(struct in_src *is, char *p[], struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_inline_=
file(const struct in_src *is, char *p[], struct gc_arena *gc)</span><br><sp=
an> {</span><br><span>     int num_inline_lines =3D 0;</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/otime=2Ec b/src/openvpn/otime=2Ec</s=
pan><br><span>index 1608458=2E=2E5d3633c 100644</span><br><span>--- a/src/o=
penvpn/otime=2Ec</span><br><span>+++ b/src/openvpn/otime=2Ec</span><br><spa=
n>@@ -66,7 +66,7 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_now_usec(st=
ruct timeval *tv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+up=
date_now_usec(const struct timeval *tv)</span><br><span> {</span><br><span>=
     const time_t last =3D now;</span><br><span>     update_now(tv-&gt;tv_s=
ec);</span><br><span>diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=
=2Eh</span><br><span>index d14f01e=2E=2E74d21ff 100644</span><br><span>--- =
a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/otime=2Eh</span><=
br><span>@@ -65,7 +65,7 @@</span><br><span> void update_now(const time_t sy=
stem_time);</span><br><span> </span><br><span> extern time_t now_usec;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void update_now_usec(struc=
t timeval *tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 update_now_usec(const struct timeval *tv);</span><br><span> </span><br><sp=
an> static inline int</span><br><span> openvpn_gettimeofday(struct timeval =
*tv, void *tz)</span><br><span>diff --git a/src/openvpn/proto=2Eh b/src/ope=
nvpn/proto=2Eh</span><br><span>index 9bb0866=2E=2E1665751 100644</span><br>=
<span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/proto=
=2Eh</span><br><span>@@ -248,7 +248,7 @@</span><br><span>  * and offset of =
IP header (via parameter)=2E</span><br><span>  */</span><br><span> static i=
nline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_tun_ip_v=
er(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+get_tun_ip_ver(int tunnel_type, con=
st struct buffer *buf, int *ip_hdr_offset)</span><br><span> {</span><br><sp=
an>     int ip_ver =3D -1;</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 74a6cf9=
=2E=2Ec3ad7de 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br>=
<span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -527,8 +527,9 @@</span=
><br><span> }</span><br><span> </span><br><span> static bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-add_proxy_headers(struct http_proxy_=
info *p, socket_descriptor_t sd, /* already open to proxy */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                  const char *host  =
                                 /* openvpn server remote */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+add_proxy_headers(const struct htt=
p_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               socket_descriptor_t sd, /* already open to proxy */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  const char=
 *host        /* openvpn server remote */</span><br><span> )</span><br><spa=
n> {</span><br><span>     char buf[512];</span><br><span>@@ -597,8 +598,8 @=
@</span><br><span>                               socket_descriptor_t sd, /*=
 already open to proxy */</span><br><span>                               co=
nst char *host,       /* openvpn server remote */</span><br><span>         =
                      const char *port,       /* openvpn server port */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
     struct event_timeout *server_poll_timeout, struct buffer *lookahead,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
       struct signal_info *sig_info)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                              const struct event_timeout *=
server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              struct buffer *lookahead, struct signal_info=
 *sig_info)</span><br><span> {</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     char buf[512];</span><br><span>diff --git a/=
src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</span><br><span>index e662e7d=
=2E=2Ea2f4e47 100644</span><br><span>--- a/src/openvpn/proxy=2Eh</span><br>=
<span>+++ b/src/openvpn/proxy=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><=
br><span>                                    socket_descriptor_t sd, /* alr=
eady open to proxy */</span><br><span>                                    c=
onst char *host,       /* openvpn server remote */</span><br><span>        =
                            const char *port,       /* openvpn server port =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                struct event_timeout *server_poll_timeout,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                   c=
onst struct event_timeout *server_poll_timeout,</span><br><span>           =
                         struct buffer *lookahead, struct signal_info *sig_=
info);</span><br><span> </span><br><span> uint8_t *make_base64_string2(cons=
t uint8_t *str, int str_len, struct gc_arena *gc);</span><br><span>diff --g=
it a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 08c2673=
=2E=2E2679c4d5 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><s=
pan>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -334,7 +334,7 @@</span><br>=
<span>  * the proxy can determine true client origin=2E</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-journal_add(const char *journal_dir, struct proxy_connection *pc, =
struct proxy_connection *cp)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+journal_add(const char *journal_dir, const struct proxy_connection=
 *pc, struct proxy_connection *cp)</span><br><span> {</span><br><span>     =
struct openvpn_sockaddr from, to;</span><br><span> </span><br><span>@@ -412=
,7 +412,7 @@</span><br><span> static bool</span><br><span> proxy_entry_new(=
struct proxy_connection **list, struct event_set *es,</span><br><span>     =
            const struct openvpn_sockaddr server_addr, const socket_descrip=
tor_t sd_client,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           struct buffer *initial_data, const char *journal_dir)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                const struct b=
uffer *initial_data, const char *journal_dir)</span><br><span> {</span><br>=
<span>     socket_descriptor_t sd_server;</span><br><span>     int status;<=
/span><br><span>@@ -1015,7 +1015,7 @@</span><br><span>  * call=2E</span><br=
><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-port_share_redirect(struct port_share *ps, const struct buffer =
*head, socket_descriptor_t sd)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+port_share_redirect(const struct port_share *ps, const struct bu=
ffer *head, socket_descriptor_t sd)</span><br><span> {</span><br><span>    =
 if (ps)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ps=
=2Eh b/src/openvpn/ps=2Eh</span><br><span>index 557ecf5=2E=2E918ceb6 100644=
</span><br><span>--- a/src/openvpn/ps=2Eh</span><br><span>+++ b/src/openvpn=
/ps=2Eh</span><br><span>@@ -49,7 +49,7 @@</span><br><span> </span><br><span=
> bool is_openvpn_protocol(const struct buffer *buf);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void port_share_redirect(=
struct port_share *ps, const struct buffer *head, socket_descriptor_t sd);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void port_share_redi=
rect(const struct port_share *ps, const struct buffer *head, socket_descrip=
tor_t sd);</span><br><span> </span><br><span> #endif /* if PORT_SHARE */</s=
pan><br><span> #endif /* ifndef PS_H */</span><br><span>diff --git a/src/op=
envpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 0e281d2=2E=2E8d=
fe0d5 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++=
 b/src/openvpn/push=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><br><span=
> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-send_auth_pending_messages(struct tls_multi *tls_mult=
i, struct tls_session *session,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+send_auth_pending_messages(const struct tls_multi *tls_multi, s=
truct tls_session *session,</span><br><span>                            con=
st char *extra, unsigned int timeout)</span><br><span> {</span><br><span>  =
   struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><sp=
an>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span=
>index dff945f=2E=2E39302f6 100644</span><br><span>--- a/src/openvpn/push=
=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -117,7 +=
117,7 @@</span><br><span>  * doc/management-notes=2Etxt under client-pendin=
g-auth for</span><br><span>  * more details on message format</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool send_auth=
_pending_messages(struct tls_multi *tls_multi, struct tls_session *session,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool send_auth_pend=
ing_messages(const struct tls_multi *tls_multi, struct tls_session *session=
,</span><br><span>                                 const char *extra, unsig=
ned int timeout);</span><br><span> </span><br><span> void send_restart(stru=
ct context *c, const char *kill_msg);</span><br><span>diff --git a/src/open=
vpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 0213041=
=2E=2E7fa5987 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span>=
<br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -222,7 +222,7 =
@@</span><br><span> </span><br><span> /* Return true if the client supports=
 push-update */</span><br><span> static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-support_push_update(struct multi_instance *mi)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+support_push_update(const=
 struct multi_instance *mi)</span><br><span> {</span><br><span>     ASSERT(=
mi-&gt;context=2Ec2=2Etls_multi);</span><br><span>     const unsigned int i=
v_proto_peer =3D extract_iv_proto(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_=
info);</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/=
reliable=2Ec</span><br><span>index c268cce=2E=2E7b5b17c 100644</span><br><s=
pan>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliab=
le=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><br><span> </span><br><span>=
 /* check if a particular packet_id is present in ack */</span><br><span> s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reli=
able_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_packet_id=
_present(const struct reliable_ack *ack, packet_id_type pid)</span><br><spa=
n> {</span><br><span>     for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span>=
<br><span>     {</span><br><span>@@ -752,7 +752,7 @@</span><br><span>  */</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-reliable_mark_active_incoming(struct reliable *rel, struct=
 buffer *buf, packet_id_type pid,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+reliable_mark_active_incoming(struct reliable *rel, const str=
uct buffer *buf, packet_id_type pid,</span><br><span>                      =
         int opcode)</span><br><span> {</span><br><span>     for (int i =3D=
 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -812,7 +812,7 @@</span><br=
><span> </span><br><span> /* delete a buffer previously activated by reliab=
le_mark_active() */</span><br><span> void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-reliable_mark_deleted(struct reliable *rel, struct buff=
er *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ma=
rk_deleted(struct reliable *rel, const struct buffer *buf)</span><br><span>=
 {</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><=
br><span>     {</span><br><span>diff --git a/src/openvpn/reliable=2Eh b/src=
/openvpn/reliable=2Eh</span><br><span>index 534feb3=2E=2E7b6fced 100644</sp=
an><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/openv=
pn/reliable=2Eh</span><br><span>@@ -184,7 +184,7 @@</span><br><span>  * @li=
 False, if there are packet IDs to be acknowledged=2E</span><br><span>  */<=
/span><br><span> static inline bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-reliable_ack_empty(struct reliable_ack *ack)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_empty(const struct reli=
able_ack *ack)</span><br><span> {</span><br><span>     return !ack-&gt;len;=
</span><br><span> }</span><br><span>@@ -213,7 +213,7 @@</span><br><span>  *=
 @returns the number of outstanding acks</span><br><span>  */</span><br><sp=
an> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
reliable_ack_outstanding(struct reliable_ack *ack)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+reliable_ack_outstanding(const struct reliab=
le_ack *ack)</span><br><span> {</span><br><span>     return ack-&gt;len;</s=
pan><br><span> }</span><br><span>@@ -369,7 +369,7 @@</span><br><span>  * @p=
aram pid The packet&#39;s packet ID=2E</span><br><span>  * @param opcode Th=
e packet&#39;s opcode=2E</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void reliable_mark_active_incoming(struct reliable =
*rel, struct buffer *buf, packet_id_type pid,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void reliable_mark_active_incoming(struct reliabl=
e *rel, const struct buffer *buf, packet_id_type pid,</span><br><span>     =
                               int opcode);</span><br><span> </span><br><sp=
an> /**</span><br><span>@@ -422,7 +422,7 @@</span><br><span>  * @param rel =
The reliable structure associated with the given buffer=2E</span><br><span>=
  * @param buf The buffer of the reliable entry which is to be removed=2E</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id reliable_mark_deleted(struct reliable *rel, struct buffer *buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_deleted(=
struct reliable *rel, const struct buffer *buf);</span><br><span> </span><b=
r><span> /** @} name Functions for extracting incoming packets */</span><br=
><span> </span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/r=
oute=2Ec</span><br><span>index 33b2387=2E=2E4830a5b 100644</span><br><span>=
--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</sp=
an><br><span>@@ -898,8 +898,9 @@</span><br><span> }</span><br><span> </span=
><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-add_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const struc=
t tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
          unsigned int flags, const struct route_gateway_info *rgi,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+add_bypass_routes(const str=
uct route_bypass *rb, in_addr_t gateway,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  const struct tuntap *tt, unsigned in=
t flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
       const struct route_gateway_info *rgi,</span><br><span>              =
     const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</=
span><br><span>     int ret =3D true;</span><br><span>@@ -916,8 +917,9 @@</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-del_bypass_routes(struct route_b=
ypass *rb, in_addr_t gateway, const struct tuntap *tt,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                  unsigned int flags, cons=
t struct route_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+del_bypass_routes(const struct route_bypass *rb, in_addr_t ga=
teway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
     const struct tuntap *tt, unsigned int flags,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                  const struct route_gateway_=
info *rgi,</span><br><span>                   const struct env_set *es, ope=
nvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     int i;</span><=
br><span>@@ -3939,7 +3941,8 @@</span><br><span> #else  /* if defined(_WIN32=
) */</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-get_bypass_addresses(struct route_bypass *r=
b, const unsigned int flags) /* PLATFORM-SPECIFIC */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress constParameterPointe=
r ; stub</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_bypass_=
addresses(struct route_bypass *rb, const unsigned int flags)</span><br><spa=
n> {</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/=
openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index 6c60d=
c2=2E=2Eff243dc 100644</span><br><span>--- a/src/openvpn/schedule=2Ec</span=
><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -389,4 +389,4 =
@@</span><br><span> {</span><br><span>     s-&gt;earliest_wakeup =3D NULL; =
/* invalidate cache */</span><br><span>     schedule_remove_node(s, e);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ No ne=
wline at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=
=2Ec</span><br><span>index 33def4e=2E=2Edf8e400 100644</span><br><span>--- =
a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span=
><br><span>@@ -620,7 +620,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
bind_local(struct link_socket *sock)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bind_local(const struct link_socket *sock)</span><br><span=
> {</span><br><span>     /* bind to local address/port */</span><br><span> =
    if (sock-&gt;bind_local)</span><br><span>@@ -916,8 +916,8 @@</span><br>=
<span> }</span><br><span> </span><br><span> void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-socket_bind(socket_descriptor_t sd, struct addri=
nfo *local, int ai_family, const char *prefix,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            bool ipv6only)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+socket_bind(socket_descriptor_t sd, const=
 struct addrinfo *local, int ai_family,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            const char *prefix, bool ipv6only)</span><b=
r><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span> </span><br><span>@@ -1125,8 +1125,8 @@</span><br><span>  * such as T=
CP=2E</span><br><span>  */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static void stream_buf_init(struct stream_buf *sb, s=
truct buffer *buf, const unsigned int sockflags,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                            const int proto);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void stream_buf=
_init(struct stream_buf *sb, const struct buffer *buf,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                            const unsign=
ed int sockflags, const int proto);</span><br><span> </span><br><span> stat=
ic void stream_buf_close(struct stream_buf *sb);</span><br><span> </span><b=
r><span>@@ -1479,7 +1479,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p=
hase2_set_socket_flags(struct link_socket *sock)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+phase2_set_socket_flags(const struct link_sock=
et *sock)</span><br><span> {</span><br><span>     /* TCP_NODELAY is enabled=
 by default on every TCP socket; dco-win is</span><br><span>      * skipped=
 as it manages its own socket */</span><br><span>@@ -2075,7 +2075,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-stream_buf_init(struct stream_buf *=
sb, struct buffer *buf, const unsigned int sockflags,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+stream_buf_init(struct stream_buf *sb, co=
nst struct buffer *buf, const unsigned int sockflags,</span><br><span>     =
            const int proto)</span><br><span> {</span><br><span>     sb-&gt=
;buf_init =3D *buf;</span><br><span>@@ -2341,7 +2341,7 @@</span><br><span> =
#endif</span><br><span> </span><br><span> static ssize_t</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_posix_recvmsg(struc=
t link_socket *sock, struct buffer *buf,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+link_socket_read_udp_posix_recvmsg(const struct link_s=
ocket *sock, struct buffer *buf,</span><br><span>                          =
          struct link_socket_actual *from, socklen_t *fromlen)</span><br><s=
pan> {</span><br><span>     struct iovec iov;</span><br><span>@@ -2413,7 +2=
413,7 @@</span><br><span> #endif /* if ENABLE_IP_PKTINFO */</span><br><span=
> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-link_socket_read_udp_posix(struct link_socket *sock, struct buffer *b=
uf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_read=
_udp_posix(const struct link_socket *sock, struct buffer *buf,</span><br><s=
pan>                            struct link_socket_actual *from)</span><br>=
<span> {</span><br><span>     ssize_t recvlen;</span><br><span>@@ -2476,7 +=
2476,7 @@</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span> </span><b=
r><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_=
socket_write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_=
udp_posix_sendmsg(const struct link_socket *sock, const struct buffer *buf,=
</span><br><span>                                     struct link_socket_ac=
tual *to)</span><br><span> {</span><br><span>     struct iovec iov;</span><=
br><span>@@ -2672,7 +2672,7 @@</span><br><span> }</span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_s=
end_queue(struct link_socket *sock, struct buffer *buf, const struct link_s=
ocket_actual *to)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+so=
cket_send_queue(struct link_socket *sock, const struct buffer *buf, const s=
truct link_socket_actual *to)</span><br><span> {</span><br><span>     if (s=
ock-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</sp=
an><br><span>@@ -2772,8 +2772,8 @@</span><br><span>     return sock-&gt;wri=
tes=2Eiostate;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-read_sockaddr_from_overlapped(struct overlapped_io *io, stru=
ct sockaddr *dst, int overlapped_ret)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+read_sockaddr_from_overlapped(const struct overlapped_io *io, str=
uct sockaddr *dst, int overlapped_ret)</span><br><span> {</span><br><span> =
    if (overlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br>=
<span>     {</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/open=
vpn/socket=2Eh</span><br><span>index 46fa29c=2E=2Ecbcdeef 100644</span><br>=
<span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=
=2Eh</span><br><span>@@ -268,7 +268,7 @@</span><br><span> </span><br><span>=
 int socket_recv_queue(struct link_socket *sock, int maxsize);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int socket_send_=
queue(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int socket_send_queue(struct link_socket =
*sock, const struct buffer *buf,</span><br><span>                       con=
st struct link_socket_actual *to);</span><br><span> </span><br><span> typed=
ef struct</span><br><span>@@ -348,8 +348,8 @@</span><br><span> </span><br><=
span> struct link_socket *link_socket_new(void);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void socket_bind(socket_descri=
ptor_t sd, struct addrinfo *local, int af_family, const char *prefix,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                 bool ipv6o=
nly);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void socket_bi=
nd(socket_descriptor_t sd, const struct addrinfo *local, int af_family,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const =
char *prefix, bool ipv6only);</span><br><span> </span><br><span> int openvp=
n_connect(socket_descriptor_t sd, const struct sockaddr *remote, int connec=
t_timeout,</span><br><span>                     volatile int *signal_receiv=
ed);</span><br><span>@@ -496,7 +496,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static inline bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-link_socket_verify_incoming_addr(struct buffer *buf, const=
 struct link_socket_info *info,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+link_socket_verify_incoming_addr(const struct buffer *buf, cons=
t struct link_socket_info *info,</span><br><span>                          =
        const struct link_socket_actual *from_addr)</span><br><span> {</spa=
n><br><span>     if (buf-&gt;len &gt; 0)</span><br><span>@@ -620,7 +620,7 @=
@</span><br><span> </span><br><span> #else  /* ifdef _WIN32 */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_soc=
ket_read_udp_posix(struct link_socket *sock, struct buffer *buf,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_read_udp_p=
osix(const struct link_socket *sock, struct buffer *buf,</span><br><span>  =
                                  struct link_socket_actual *from);</span><=
br><span> </span><br><span> #endif /* ifdef _WIN32 */</span><br><span>@@ -7=
06,12 +706,12 @@</span><br><span> </span><br><span> #else /* ifdef _WIN32 *=
/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ss=
ize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct =
buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t=
 link_socket_write_udp_posix_sendmsg(const struct link_socket *sock, const =
struct buffer *buf,</span><br><span>                                       =
      struct link_socket_actual *to);</span><br><span> </span><br><span> </=
span><br><span> static inline ssize_t</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-link_socket_write_udp_posix(struct link_socket *sock, struc=
t buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_=
socket_write_udp_posix(const struct link_socket *sock, const struct buffer =
*buf,</span><br><span>                             struct link_socket_actua=
l *to)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br>=
<span>@@ -727,7 +727,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static inline ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-link_socket_write_tcp_posix(struct link_socket *sock, struct buffer *b=
uf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_writ=
e_tcp_posix(const struct link_socket *sock, const struct buffer *buf)</span=
><br><span> {</span><br><span>     return send(sock-&gt;sd, CBPTR(buf), BLE=
NZ(buf), MSG_NOSIGNAL);</span><br><span> }</span><br><span>@@ -785,7 +785,7=
 @@</span><br><span>  * from tunnel packet=2E</span><br><span>  */</span><b=
r><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-link_socket_set_tos(struct link_socket *sock)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_set_tos(const struct link_soc=
ket *sock)</span><br><span> {</span><br><span>     if (sock &amp;&amp; sock=
-&gt;ptos_defined)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index=
 13f5962=2E=2Eadd08ba 100644</span><br><span>--- a/src/openvpn/socket_util=
=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -=
439,7 +439,7 @@</span><br><span> </span><br><span> </span><br><span> static=
 inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-addrlist_=
match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, =
const int proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add=
rlist_match_proto(const struct openvpn_sockaddr *a1, const struct addrinfo =
*addr_list, const int proto)</span><br><span> {</span><br><span>     return=
 link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_lis=
t)</span><br><span>                                                        =
 : addrlist_port_match(a1, addr_list);</span><br><span>diff --git a/src/ope=
nvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index b84da24=2E=2E0=
296349 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+=
++ b/src/openvpn/socks=2Ec</span><br><span>@@ -83,7 +83,7 @@</span><br><spa=
n> </span><br><span> static bool</span><br><span> socks_proxy_recv_char(uin=
t8_t *c, const char *name, socket_descriptor_t sd,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                      struct event_timeout *se=
rver_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                     const struct event_timeout *server_poll_timeout,</span=
><br><span>                       volatile int *signal_received)</span><br>=
<span> {</span><br><span>     fd_set reads;</span><br><span>@@ -98,8 +98,8 =
@@</span><br><span> }</span><br><span> </span><br><span> static bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-socks_username_password_auth=
(struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             struct event_t=
imeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+socks_username_password_auth(const struct socks_proxy_info *p, soc=
ket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                             const struct event_timeout *server_poll_timeo=
ut,</span><br><span>                              volatile int *signal_rece=
ived)</span><br><span> {</span><br><span>     char to_send[516];</span><br>=
<span>@@ -157,8 +157,8 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks=
_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                struct event_timeo=
ut *server_poll_timeout, volatile int *signal_received)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+socks_handshake(const struct socks_prox=
y_info *p, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                const struct event_timeout *server_poll_time=
out, volatile int *signal_received)</span><br><span> {</span><br><span>    =
 uint8_t buf[2];</span><br><span>     int len =3D 0;</span><br><span>@@ -23=
2,7 +232,7 @@</span><br><span> </span><br><span> static bool</span><br><spa=
n> recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 struc=
t event_timeout *server_poll_timeout, volatile int *signal_received)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 const str=
uct event_timeout *server_poll_timeout, volatile int *signal_received)</spa=
n><br><span> {</span><br><span>     uint8_t atyp =3D 0;</span><br><span>   =
  int alen =3D 0;</span><br><span>@@ -334,11 +334,11 @@</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-establish_socks_proxy_passthru(struct socks_proxy_info *p=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+establish_socks_pr=
oxy_passthru(const struct socks_proxy_info *p,</span><br><span>            =
                    socket_descriptor_t sd, /* already open to proxy */</sp=
an><br><span>                                const char *host,       /* ope=
nvpn server remote */</span><br><span>                                const=
 char *servname,   /* openvpn server port */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                               struct event_timeout =
*server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                               const struct event_timeout *server_poll_ti=
meout,</span><br><span>                                struct signal_info *=
sig_info)</span><br><span> {</span><br><span>     char buf[270];</span><br>=
<span>@@ -392,10 +392,10 @@</span><br><span> }</span><br><span> </span><br>=
<span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-establish_=
socks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+establish_socks_proxy_udpassoc(const struct so=
cks_proxy_info *p,</span><br><span>                                socket_d=
escriptor_t ctrl_sd, /* already open to proxy */</span><br><span>          =
                      struct openvpn_sockaddr *relay_addr,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                               struct =
event_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                               const struct event_timeout *=
server_poll_timeout,</span><br><span>                                struct=
 signal_info *sig_info)</span><br><span> {</span><br><span>     if (!socks_=
handshake(p, ctrl_sd, server_poll_timeout, &amp;sig_info-&gt;signal_receive=
d))</span><br><span>diff --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=
=2Eh</span><br><span>index caed18c=2E=2E7434bbf 100644</span><br><span>--- =
a/src/openvpn/socks=2Eh</span><br><span>+++ b/src/openvpn/socks=2Eh</span><=
br><span>@@ -49,17 +49,17 @@</span><br><span> </span><br><span> void socks_=
proxy_close(struct socks_proxy_info *sp);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void establish_socks_proxy_passthru(s=
truct socks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void establish_socks_proxy_passthru(const struct socks_proxy_info *p=
,</span><br><span>                                     socket_descriptor_t =
sd, /* already open to proxy */</span><br><span>                           =
          const char *host,       /* openvpn server remote */</span><br><sp=
an>                                     const char *servname,   /* openvpn =
server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                             struct event_timeout *server_poll_timeout,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
             const struct event_timeout *server_poll_timeout,</span><br><sp=
an>                                     struct signal_info *sig_info);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void est=
ablish_socks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void establish_socks_proxy_udpassoc(con=
st struct socks_proxy_info *p,</span><br><span>                            =
         socket_descriptor_t ctrl_sd, /* already open to proxy */</span><br=
><span>                                     struct openvpn_sockaddr *relay_=
addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                    struct event_timeout *server_poll_timeout,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
    const struct event_timeout *server_poll_timeout,</span><br><span>      =
                               struct signal_info *sig_info);</span><br><sp=
an> </span><br><span> void socks_process_incoming_udp(struct buffer *buf, s=
truct link_socket_actual *from);</span><br><span>diff --git a/src/openvpn/s=
sl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index aeec020=2E=2E3594871 100=
644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl=2Ec</span><br><span>@@ -1171,7 +1171,7 @@</span><br><span> }</span=
><br><span> </span><br><span> struct tls_multi *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-tls_multi_init(struct tls_options *tls_options)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_multi_init(const=
 struct tls_options *tls_options)</span><br><span> {</span><br><span>     s=
truct tls_multi *ret;</span><br><span> </span><br><span>@@ -1212,7 +1212,7 =
@@</span><br><span>  */</span><br><span> </span><br><span> struct tls_auth_=
standalone *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_auth_=
standalone_init(struct tls_options *tls_options, struct gc_arena *gc)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_auth_standalone_init(=
const struct tls_options *tls_options, struct gc_arena *gc)</span><br><span=
> {</span><br><span>     struct tls_auth_standalone *tas;</span><br><span> =
</span><br><span>@@ -1631,8 +1631,9 @@</span><br><span> </span><br><span> b=
ool</span><br><span> tls_session_update_crypto_params_do_work(struct tls_mu=
lti *multi, struct tls_session *session,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                         struct options =
*options, struct frame *frame,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                         struct frame *frame_fragm=
ent, struct link_socket_info *lsi,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                         const struct option=
s *options, struct frame *frame,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                         struct frame *frame_f=
ragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                              const struct link_socket_info *lsi,</span><br=
><span>                                          dco_context_t *dco)</span>=
<br><span> {</span><br><span>     if (session-&gt;key[KS_PRIMARY]=2Ecrypto_=
options=2Ekey_ctx_bi=2Einitialized)</span><br><span>@@ -1704,7 +1705,7 @@</=
span><br><span> bool</span><br><span> tls_session_update_crypto_params(stru=
ct tls_multi *multi, struct tls_session *session,</span><br><span>         =
                         struct options *options, struct frame *frame,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
       struct frame *frame_fragment, struct link_socket_info *lsi,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     struct frame *frame_fragment, const struct link_socket_info *lsi,</spa=
n><br><span>                                  dco_context_t *dco)</span><br=
><span> {</span><br><span>     if (!check_session_cipher(session, options))=
</span><br><span>@@ -1920,7 +1921,8 @@</span><br><span> }</span><br><span> =
</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-push_peer_info_peerid(struct buffer *out, struct tls_multi *multi, =
struct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+push_peer_info_peerid(struct buffer *out, const struct tls_multi *=
multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
         const struct tls_session *session)</span><br><span> {</span><br><s=
pan>     if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt=
;dco_enabled)</span><br><span>     {</span><br><span>@@ -1955,7 +1957,7 @@<=
/span><br><span>  * @return          true if no error was encountered</span=
><br><span>  */</span><br><span> static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struct tls_multi =
*multi, struct tls_session *session)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+push_peer_info(struct buffer *buf, const struct tls_multi =
*multi, struct tls_session *session)</span><br><span> {</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span>     bool ret =3D false;=
</span><br><span>@@ -2599,8 +2601,8 @@</span><br><span> }</span><br><span> =
</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decr=
ypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                      struct link_socket_actual *from)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start(struct tls_ses=
sion *session, const struct tls_pre_decrypt_state *state,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                          const struc=
t link_socket_actual *from)</span><br><span> {</span><br><span>     struct =
key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span>     ks=
-&gt;session_id_remote =3D state-&gt;peer_session_id;</span><br><span>@@ -2=
829,7 +2831,7 @@</span><br><span> </span><br><span> static bool</span><br><=
span> check_outgoing_ciphertext(struct key_state *ks, struct tls_session *s=
ession,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
            struct buffer *to_link, bool *continue_tls_process)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                          const=
 struct buffer *to_link, bool *continue_tls_process)</span><br><span> {</sp=
an><br><span>     if (to_link-&gt;len)</span><br><span>     {</span><br><sp=
an>@@ -4193,7 +4195,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_post_encr=
ypt(struct tls_multi *multi, struct buffer *buf)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tls_post_encrypt(struct tls_multi *multi, cons=
t struct buffer *buf)</span><br><span> {</span><br><span>     struct key_st=
ate *ks =3D multi-&gt;save_ks;</span><br><span>     multi-&gt;save_ks =3D N=
ULL;</span><br><span>@@ -4324,7 +4326,7 @@</span><br><span>  * into a garba=
ge collectable string which is returned=2E</span><br><span>  */</span><br><=
span> const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pro=
tocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+protocol_dump(const =
struct buffer *buffer, unsigned int flags, struct gc_arena *gc)</span><br><=
span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</=
span><br><span>     struct buffer buf =3D *buffer;</span><br><span>diff --g=
it a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 5483fb=
b=2E=2E76c3610 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><=
span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -166,7 +166,7 @@</span><b=
r><span>  *</span><br><span>  * @return A newly allocated and initialized \=
c tls_multi structure=2E</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-struct tls_multi *tls_multi_init(struct tls_options=
 *tls_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stru=
ct tls_multi *tls_multi_init(const struct tls_options *tls_options);</span>=
<br><span> </span><br><span> /**</span><br><span>  * Finalize initializatio=
n of a \c tls_multi structure=2E</span><br><span>@@ -187,7 +187,7 @@</span>=
<br><span> /*</span><br><span>  * Initialize a standalone tls-auth verifica=
tion object=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct tls_auth_standalone *tls_auth_standalone_init(struct t=
ls_options *tls_options,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct tls_auth_standalone *tls_auth_standalone_init(const struct tls_=
options *tls_options,</span><br><span>                                     =
                 struct gc_arena *gc);</span><br><span> </span><br><span> /=
**</span><br><span>@@ -373,7 +373,7 @@</span><br><span>  * @param multi - T=
he TLS state for this packet&#39;s destination VPN tunnel=2E</span><br><spa=
n>  * @param buf - The buffer containing the outgoing packet=2E</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_pos=
t_encrypt(struct tls_multi *multi, struct buffer *buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void tls_post_encrypt(struct tls_multi =
*multi, const struct buffer *buf);</span><br><span> </span><br><span> /** @=
} name Functions for managing security parameter state for data channel pac=
kets */</span><br><span> </span><br><span>@@ -463,7 +463,8 @@</span><br><sp=
an>  */</span><br><span> bool tls_session_update_crypto_params(struct tls_m=
ulti *multi, struct tls_session *session,</span><br><span>                 =
                      struct options *options, struct frame *frame,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
         struct frame *frame_fragment, struct link_socket_info *lsi,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
            struct frame *frame_fragment,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                      const struct li=
nk_socket_info *lsi,</span><br><span>                                      =
 dco_context_t *dco);</span><br><span> </span><br><span> /*</span><br><span=
>@@ -527,7 +528,7 @@</span><br><span> #define PD_VERBOSE                 (1=
 &lt;&lt; 10)</span><br><span> #define PD_TLS_CRYPT               (1 &lt;&l=
t; 11)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-const char *protocol_dump(struct buffer *buffer, unsigned int flags, str=
uct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst char *protocol_dump(const struct buffer *buffer, unsigned int flags, s=
truct gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><span>=
  * debugging code</span><br><span>@@ -566,7 +567,7 @@</span><br><span> /* =
Special method to skip the three way handshake RESET stages=2E This is</spa=
n><br><span>  * used by the HMAC code when seeing a packet that matches the=
 previous</span><br><span>  * HMAC based stateless server state */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool session_skip_to_pre_start=
(struct tls_session *session, struct tls_pre_decrypt_state *state,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
 struct link_socket_actual *from);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool session_skip_to_pre_start(struct tls_session *session, =
const struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                               const struct link_soc=
ket_actual *from);</span><br><span> </span><br><span> #endif /* ifndef OPEN=
VPN_SSL_H */</span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/src=
/openvpn/ssl_backend=2Eh</span><br><span>index a6d57f2=2E=2E2150d81 100644<=
/span><br><span>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/src=
/openvpn/ssl_backend=2Eh</span><br><span>@@ -137,7 +137,7 @@</span><br><spa=
n>  *</span><br><span>  * @return      true if the context is initialised, =
false if not=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool tls_ctx_initialised(struct tls_root_ctx *ctx);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool tls_ctx_initialised(con=
st struct tls_root_ctx *ctx);</span><br><span> </span><br><span> /**</span>=
<br><span>  * Set any library specific options=2E</span><br><span>diff --gi=
t a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><sp=
an>index 9983742=2E=2E965ecdb 100644</span><br><span>--- a/src/openvpn/ssl_=
mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><sp=
an>@@ -146,7 +146,7 @@</span><br><span> }</span><br><span> </span><br><span=
> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initial=
ised(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_ctx_initialised(const struct tls_root_ctx *ctx)</span><br><s=
pan> {</span><br><span>     /* either this should be NULL or should be non-=
null and then have a</span><br><span>      * valid TLS ctx inside as well *=
/</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ss=
l_openssl=2Ec</span><br><span>index 96e90f82=2E=2E7805d43 100644</span><br>=
<span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/s=
sl_openssl=2Ec</span><br><span>@@ -129,7 +129,7 @@</span><br><span> }</span=
><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls=
_root_ctx *ctx)</span><br><span> {</span><br><span>     /* either this shou=
ld be NULL or should be non-null and then have a</span><br><span>      * va=
lid TLS ctx inside as well */</span><br><span>@@ -2025,7 +2025,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bio_debug_data(const char *mode, BIO *=
bio, const uint8_t *buf, int len, const char *desc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bio_debug_data(const char *mode, const BI=
O *bio, const uint8_t *buf, int len, const char *desc)</span><br><span> {</=
span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     i=
f (len &gt; 0)</span><br><span>@@ -2039,7 +2039,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-bio_debug_oc(const char *mode, BIO *bio)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bio_debug_oc(const char *mode, c=
onst BIO *bio)</span><br><span> {</span><br><span>     open_biofp();</span>=
<br><span>     fprintf(biofp, &quot;BIO %s time=3D%&quot; PRIi64 &quot; bio=
=3D&quot; ptr_format &quot;\n&quot;, mode, (int64_t)time(NULL),</span><br><=
span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><=
br><span>index e9afda4=2E=2Ef78782f 100644</span><br><span>--- a/src/openvp=
n/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span=
>@@ -119,7 +119,7 @@</span><br><span>  */</span><br><span> static void</spa=
n><br><span> tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, str=
uct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
            struct session_id *session_id)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 const struct session_id *session_id=
)</span><br><span> {</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRAP_=
AUTH || ctx-&gt;mode =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span><br=
><span>@@ -403,9 +403,9 @@</span><br><span> </span><br><span> </span><br><s=
pan> struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls=
_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
 struct session_id *own_sid, struct session_id *remote_sid, uint8_t header,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
bool request_resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_s=
tandalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 const struct session_id *own_sid, const struct session_id =
*remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              uint8_t header, bool request_resend_wkc)</span><br><span> {</=
span><br><span>     /* Copy buffer here to point at the same data but allow=
 tls_wrap_control</span><br><span>      * to potentially change buf to poin=
t to another buffer without</span><br><span>@@ -490,7 +490,7 @@</span><br><=
span> bool</span><br><span> check_session_hmac_and_pkt_id(struct tls_pre_de=
crypt_state *state,</span><br><span>                               const st=
ruct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                              uint8_t *key,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              const uint8_t =
*key,</span><br><span>                               int handwindow,</span>=
<br><span>                               bool pkt_is_ack)</span><br><span> =
{</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pk=
t=2Eh</span><br><span>index 03e8930=2E=2E8203e4a 100644</span><br><span>---=
 a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</s=
pan><br><span>@@ -183,7 +183,7 @@</span><br><span>  * @return              =
the expected server session id</span><br><span>  */</span><br><span> bool c=
heck_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const str=
uct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                   uint8_t *key, int handwindow, bool=
 pkt_is_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                             const uint8_t *key, int handwindow, bool pkt_i=
s_ack);</span><br><span> </span><br><span> /*</span><br><span>  * Write a c=
ontrol channel authentication record=2E</span><br><span>@@ -210,8 +210,9 @@=
</span><br><span>  * from the tls pre decrypt state=2E</span><br><span>  *<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
truct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth=
_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                               struct session_id *own_sid, struct session_i=
d *remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struc=
t buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_au=
th_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                   const struct session_id *own_sid,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
         const struct session_id *remote_sid,</span><br><span>             =
                       uint8_t header, bool request_resend_wkc);</span><br>=
<span> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_veri=
fy=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 6631718=2E=2E0acb=
a2b 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1140,7 +1140,7 @@</sp=
an><br><span>  * cache=2E</span><br><span>  */</span><br><span> static bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_authentication_st=
atus_use_cache(struct tls_multi *multi)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+tls_authentication_status_use_cache(const struct tls_mu=
lti *multi)</span><br><span> {</span><br><span>     unsigned int idx =3D mi=
n_uint(multi-&gt;tas_cache_num_updates, SIZE(cache_intervals) - 1);</span><=
br><span>     time_t latency =3D cache_intervals[idx];</span><br><span>@@ -=
1284,7 +1284,7 @@</span><br><span>  * Check if the script/plugin left a mes=
sage in the auth failed message</span><br><span>  * file and relay it to th=
e user */</span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_for_client_reason(struct tls_multi *multi, struct au=
th_deferred_status *status)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+check_for_client_reason(struct tls_multi *multi, const struct auth_=
deferred_status *status)</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     const char *msg =3D key_state_c=
heck_auth_failed_message_file(status, &amp;gc);</span><br><span>@@ -1553,7 =
+1553,7 @@</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br>=
<span> </span><br><span> static bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-set_verify_user_pass_env(struct user_pass *up, struct tls_mu=
lti *multi, struct tls_session *session)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+set_verify_user_pass_env(const struct user_pass *up, s=
truct tls_multi *multi, struct tls_session *session)</span><br><span> {</sp=
an><br><span>     /* Is username defined? */</span><br><span>     if ((sess=
ion-&gt;opt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-=
&gt;username))</span><br><span>@@ -1581,7 +1581,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-ssl_verify_username_length(struct tls_session *session, cons=
t char *username)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ss=
l_verify_username_length(const struct tls_session *session, const char *use=
rname)</span><br><span> {</span><br><span>     if ((session-&gt;opt-&gt;ssl=
_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span>         &amp;&a=
mp; strlen(username) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/sr=
c/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>index=
 3176d76=2E=2Ee77bc4a 100644</span><br><span>--- a/src/openvpn/ssl_verify=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -2=
02,7 +202,7 @@</span><br><span>  * @return              true if name is und=
er limit or username-as-common-name</span><br><span>  *                    =
  is not active</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool ssl_verify_username_length(struct tls_session *session,=
 const char *username);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool ssl_verify_username_length(const struct tls_session *session, cons=
t char *username);</span><br><span> </span><br><span> /**</span><br><span> =
 * Runs the --client-crresponse script if one is defined=2E</span><br><span=
>@@ -275,7 +275,7 @@</span><br><span> void auth_set_client_reason(struct tl=
s_multi *multi, const char *client_reason);</span><br><span> </span><br><sp=
an> static inline const char *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-tls_client_reason(struct tls_multi *multi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_client_reason(const struct tls_multi =
*multi)</span><br><span> {</span><br><span>     return multi-&gt;client_rea=
son;</span><br><span> }</span><br><span>diff --git a/src/openvpn/status=2Ec=
 b/src/openvpn/status=2Ec</span><br><span>index c7d375b=2E=2Ecfbc38d 100644=
</span><br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/ope=
nvpn/status=2Ec</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-status_reset(struct status_output *so)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+status_reset(const struct status_output *=
so)</span><br><span> {</span><br><span>     if (so &amp;&amp; so-&gt;fd &gt=
;=3D 0)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/sta=
tus=2Eh b/src/openvpn/status=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75=
 100644</span><br><span>--- a/src/openvpn/status=2Eh</span><br><span>+++ b/=
src/openvpn/status=2Eh</span><br><span>@@ -69,7 +69,7 @@</span><br><span> <=
/span><br><span> bool status_trigger(struct status_output *so);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void status_res=
et(struct status_output *so);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void status_reset(const struct status_output *so);</span><br><spa=
n> </span><br><span> void status_flush(struct status_output *so);</span><br=
><span> </span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=
=2Ec</span><br><span>index 133f670=2E=2Ef191a6b 100644</span><br><span>--- =
a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><=
span>@@ -835,7 +835,7 @@</span><br><span>          const char *ifconfig_ipv=
6_local_parm,     /* --ifconfig parm 1 IPv6 */</span><br><span>          in=
t ifconfig_ipv6_netbits_parm,</span><br><span>          const char *ifconfi=
g_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         struct addrinfo *local_public, str=
uct addrinfo *remote_public, const bool strict_warn,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         const struct addrinfo *local_pub=
lic, const struct addrinfo *remote_public, const bool strict_warn,</span><b=
r><span>          struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap=
 *tt)</span><br><span> {</span><br><span>     if (!tt)</span><br><span>@@ -=
978,7 +978,7 @@</span><br><span>  * -&gt; helper function to simplify code =
below</span><br><span>  */</span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-add_route_connected_v6_net(struct tuntap =
*tt, const struct env_set *es)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+add_route_connected_v6_net(const struct tuntap *tt, const struct=
 env_set *es)</span><br><span> {</span><br><span>     struct route_ipv6 r6;=
</span><br><span> </span><br><span>@@ -1020,7 +1020,7 @@</span><br><span>  =
*/</span><br><span> </span><br><span> in_addr_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-create_arbitrary_remote(struct tuntap *tt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+create_arbitrary_remote(co=
nst struct tuntap *tt)</span><br><span> {</span><br><span>     in_addr_t re=
mote;</span><br><span> </span><br><span>@@ -1592,7 +1592,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv4(struct tuntap *tt, openv=
pn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
ndo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><b=
r><span> {</span><br><span> #if defined(TARGET_LINUX)</span><br><span>     =
int netbits =3D netmask_to_netbits2(tt-&gt;remote_netmask);</span><br><span=
>@@ -1627,7 +1627,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifc=
onfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv6(const struct tuntap *t=
t, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if defined(=
TARGET_LINUX)</span><br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_n=
ame, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@=
@ -1652,7 +1652,7 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig(str=
uct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_=
t *ctx)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver !=
=3D DRIVER_NULL &amp;&amp; tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span>=
<br><span>     {</span><br><span>@@ -1720,13 +1720,13 @@</span><br><span> }=
</span><br><span> </span><br><span> static ssize_t</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-write_tun_header(struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_t=
un_header(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br=
><span>     {</span><br><span>         u_int32_t type;</span><br><span>    =
     struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const struct ip *iph =3D (struct ip *)buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct ip *iph =3D (const s=
truct ip *)buf;</span><br><span> </span><br><span>         if (iph-&gt;ip_v=
 =3D=3D 6)</span><br><span>         {</span><br><span>@@ -1737,9 +1737,11 @=
@</span><br><span>             type =3D htonl(AF_INET);</span><br><span>   =
      }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* argument to writev is a pointer to const but we still need=
 to drop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
the const from buf pointer here */</span><br><span>         iv[0]=2Eiov_bas=
e =3D &amp;type;</span><br><span>         iv[0]=2Eiov_len =3D sizeof(type);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1]=2Eiov_b=
ase =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 iv[1]=2Eiov_base =3D (void *)buf;</span><br><span>         iv[1]=2Eiov_len=
 =3D len;</span><br><span> </span><br><span>         return header_modify_r=
ead_write_return(writev(tt-&gt;fd, iv, 2));</span><br><span>@@ -1751,7 +175=
3,7 @@</span><br><span> }</span><br><span> </span><br><span> static ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun_header(struc=
t tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+read_tun_header(const struct tuntap *tt, uint8_t *buf, int=
 len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TY=
PE_TUN)</span><br><span>     {</span><br><span>@@ -1777,13 +1779,13 @@</spa=
n><br><span>  */</span><br><span> #if !defined(TARGET_DARWIN)</span><br><sp=
an> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(=
struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf=
, int len)</span><br><span> {</span><br><span>     return write_tun_header(=
tt, buf, len);</span><br><span> }</span><br><span> </span><br><span> ssize_=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tunt=
ap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><=
br><span> {</span><br><span>     return read_tun_header(tt, buf, len);</spa=
n><br><span> }</span><br><span>@@ -1799,7 +1801,7 @@</span><br><span> </spa=
n><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
n_dco_enabled(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tun_dco_enabled(const struct tuntap *tt)</span><br><span> {</s=
pan><br><span>     return tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><b=
r><span> }</span><br><span>@@ -2047,13 +2049,13 @@</span><br><span> }</span=
><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tunt=
ap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>   =
  return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </=
span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     return read(tt-&gt;=
fd, buf, len);</span><br><span> }</span><br><span>@@ -2252,13 +2254,13 @@</=
span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+writ=
e_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><span=
> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span=
> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const stru=
ct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>  =
   return read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ =
-2588,7 +2590,7 @@</span><br><span> }</span><br><span> </span><br><span> ss=
ize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int =
len)</span><br><span> {</span><br><span>     struct strbuf sbuf;</span><br>=
<span>     sbuf=2Elen =3D len;</span><br><span>@@ -2597,7 +2599,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf,=
 int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(c=
onst struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br=
><span>     struct strbuf sbuf;</span><br><span>     int f =3D 0;</span><br=
><span>@@ -3095,7 +3097,7 @@</span><br><span> }</span><br><span> </span><br=
><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_=
tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t =
*buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;backend_d=
river =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span>@@ -3108,7=
 +3110,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br>=
<span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)=
</span><br><span>     {</span><br><span>@@ -3243,13 +3245,13 @@</span><br><=
span> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int=
 len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(cons=
t struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span>=
<br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</span>=
<br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     return =
read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ -3311,7 +3=
313,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap =
*tt, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+tun_write_queue(struct tuntap *tt, const struct buffer *buf)</span><br=
><span> {</span><br><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_I=
NITIAL)</span><br><span>     {</span><br><span>@@ -3365,7 +3367,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tun_write_win32(struct tuntap *tt, struct b=
uffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_writ=
e_win32(struct tuntap *tt, const struct buffer *buf)</span><br><span> {</sp=
an><br><span>     int err =3D 0;</span><br><span>     int status =3D 0;</sp=
an><br><span>@@ -5370,7 +5372,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for=
k_register_dns_action(struct tuntap *tt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fork_register_dns_action(const struct tuntap *tt)</spa=
n><br><span> {</span><br><span>     if (tt &amp;&amp; tt-&gt;options=2Eregi=
ster_dns &amp;&amp; tt-&gt;options=2Emsg_channel)</span><br><span>     {</s=
pan><br><span>@@ -5460,7 +5462,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tuntap_get_mtu(struct tuntap *tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tuntap_get_mtu(const struct tuntap *tt)</span><br><span>=
 {</span><br><span>     ULONG mtu =3D 0;</span><br><span>     DWORD len;</s=
pan><br><span>@@ -6035,7 +6037,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
n_show_debug(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tun_show_debug(const struct tuntap *tt)</span><br><span> {</spa=
n><br><span>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOW=
S6)</span><br><span>     {</span><br><span>@@ -6295,13 +6297,13 @@</span><b=
r><span> }</span><br><span> </span><br><span> ssize_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, =
int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(c=
onst struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</sp=
an><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</sp=
an><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tunt=
ap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     retu=
rn read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>diff --git=
 a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 7340e7e=
=2E=2E61fe943 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><br><s=
pan>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br=
><span> </span><br><span> void close_tun_handle(struct tuntap *tt);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t wri=
te_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ssize_t write_tun(const struct tuntap *tt, co=
nst uint8_t *buf, int len);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, i=
nt len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t rea=
d_tun(const struct tuntap *tt, uint8_t *buf, int len);</span><br><span> </s=
pan><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span> void tunc=
fg(const char *dev, const char *dev_type, const char *dev_node, int persist=
_mode,</span><br><span>@@ -293,7 +293,7 @@</span><br><span>                =
         const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / I=
Pv6 */</span><br><span>                         int ifconfig_ipv6_netbits_p=
arm,           /* --ifconfig parm 1 / bits */</span><br><span>             =
            const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 =
/ IPv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            struct addrinfo *local_public, struct addrinfo *remote_public,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    const struct addrinfo *local_public, const struct addrinfo *remote_publ=
ic,</span><br><span>                         const bool strict_warn, struct=
 env_set *es, openvpn_net_ctx_t *ctx,</span><br><span>                     =
    struct tuntap *tt);</span><br><span> </span><br><span>@@ -320,7 +320,7 =
@@</span><br><span>  * @param tt    the tuntap interface context</span><br>=
<span>  * @param ctx   the networking API opaque context</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(=
struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void undo_ifconfig(const struct tuntap *tt, openvpn=
_net_ctx_t *ctx);</span><br><span> </span><br><span> bool is_dev_type(const=
 char *dev, const char *dev_type, const char *match_type);</span><br><span>=
 </span><br><span>@@ -351,7 +351,7 @@</span><br><span> #define IFCONFIG_DEF=
AULT IFCONFIG_AFTER_TUN_OPEN</span><br><span> </span><br><span> static inli=
ne int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(=
struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
fconfig_order(const struct tuntap *tt)</span><br><span> {</span><br><span> =
    if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {<=
/span><br><span>@@ -381,7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DE=
FAULT ROUTE_AFTER_TUN</span><br><span> </span><br><span> static inline int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_order(struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_order=
(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&g=
t;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><sp=
an>@@ -454,13 +454,13 @@</span><br><span> </span><br><span> const char *tap=
_win_getinfo(const struct tuntap *tt, struct gc_arena *gc);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug=
(struct tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void tun_show_debug(const struct tuntap *tt);</span><br><span> </span><br>=
<span> bool dhcp_release_by_adapter_index(const DWORD adapter_index);</span=
><br><span> </span><br><span> bool dhcp_renew_by_adapter_index(const DWORD =
adapter_index);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void fork_register_dns_action(struct tuntap *tt);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void fork_register_dns_action(con=
st struct tuntap *tt);</span><br><span> </span><br><span> void ipconfig_reg=
ister_dns(const struct env_set *es);</span><br><span> </span><br><span>@@ -=
470,7 +470,7 @@</span><br><span> </span><br><span> int tun_read_queue(struc=
t tuntap *tt, int maxsize);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-int tun_write_queue(struct tuntap *tt, struct buffe=
r *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int tun_wri=
te_queue(struct tuntap *tt, const struct buffer *buf);</span><br><span> </s=
pan><br><span> static inline bool</span><br><span> tuntap_stop(int status)<=
/span><br><span>@@ -499,7 +499,7 @@</span><br><span>     return false;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int tun_write_win32(struct tuntap *tt, struct buffer *buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_win32(stru=
ct tuntap *tt, const struct buffer *buf);</span><br><span> </span><br><span=
> static inline bool</span><br><span> is_ip_packet_valid(const struct buffe=
r *buf)</span><br><span>@@ -529,19 +529,21 @@</span><br><span> }</span><br>=
<span> </span><br><span> static inline bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win(const struct tunta=
p *tt)</span><br><span> {</span><br><span>     return tt &amp;&amp; tt-&gt;=
backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span><br><span> </spa=
n><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeou=
t(const struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><sp=
an>     return tuntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; =
(openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><b=
r><span> </span><br><span> #else  /* ifdef _WIN32 */</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-beg=
in constParameterPointer ; stubs</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> static inline bool</span><br><span> tuntap_s=
top(int status)</span><br><span> {</span><br><span>@@ -565,19 +567,20 @@</s=
pan><br><span>     return true;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inl=
ine bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco=
_win(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><span> {</span><br=
><span>     return false;</span><br><span> }</span><br><span> </span><br><s=
pan> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const =
struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>     =
return false;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-end constParameterPoint=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 #endif /* ifdef _WIN32 */</span><br><span> </span><br><span> /*</span><br>=
<span>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec<=
/span><br><span>index f494d42=2E=2E79d706a 100644</span><br><span>--- a/src=
/openvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tun_afunix=2Ec</s=
pan><br><span>@@ -49,7 +49,7 @@</span><br><span> </span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_s=
et *env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_=
exec_child(const char *dev_node, struct tuntap *tt, const struct env_set *e=
nv)</span><br><span> {</span><br><span>     const char *msgprefix =3D &quot=
;ERROR: failure executing process for tun:&quot;;</span><br><span>     stru=
ct argv argv =3D argv_new();</span><br><span>@@ -74,7 +74,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-open_tun_afunix(struct options *o, int mtu, struct=
 tuntap *tt, struct env_set *orig_env)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+open_tun_afunix(const struct options *o, int mtu, struct=
 tuntap *tt, const struct env_set *orig_env)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><spa=
n>@@ -146,7 +146,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun_afu=
nix(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+write_tun_afunix(struct tuntap *tt, const uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     const char *msg =3D=
 &quot;ERROR: failure during write to AF_UNIX socket: &quot;;</span><br><sp=
an>     if (!openvpn_waitpid_check(tt-&gt;afunix=2Echildprocess, msg, M_WAR=
N))</span><br><span>@@ -172,8 +172,11 @@</span><br><span>     return read(t=
t-&gt;fd, buf, len);</span><br><span> }</span><br><span> #else  /* ifndef W=
IN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-begin cons=
tParameterPointer ; stubs</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struc=
t env_set *orig_env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const=
 struct env_set *orig_env)</span><br><span> {</span><br><span>     msg(M_ER=
R, &quot;AF_UNIX socket support not available on this platform&quot;);</spa=
n><br><span> }</span><br><span>@@ -186,7 +189,7 @@</span><br><span> }</span=
><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun_afunix(str=
uct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><=
span>     /* should never be called as open_tun_afunix always fails */</spa=
n><br><span>     ASSERT(0);</span><br><span>@@ -199,4 +202,6 @@</span><br><=
span>     ASSERT(0);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-end constParamet=
erPointer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> #endif /* ifndef WIN32 */</span><br><span>diff --git a/src/openvpn/=
tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8e0=
=2E=2E5307e31 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</span=
><br><span>+++ b/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,7 =
@@</span><br><span>  * the user provided taking care of implementing the ac=
tual tun</span><br><span>  * device=2E</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void open_tun_afunix(struct options *=
o, int mtu, struct tuntap *tt, struct env_set *env);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void open_tun_afunix(const struct options=
 *o, int mtu, struct tuntap *tt, const struct env_set *env);</span><br><spa=
n> </span><br><span> </span><br><span> /**</span><br><span>@@ -43,7 +43,7 @=
@</span><br><span> /**</span><br><span>  * Writes a packet to a AF_UNIX bas=
ed tun device=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-ssize_t write_tun_afunix(struct tuntap *tt, uint8_t *buf, i=
nt len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t wri=
te_tun_afunix(struct tuntap *tt, const uint8_t *buf, int len);</span><br><s=
pan> </span><br><span> /**</span><br><span>  * Reads a packet from a AF_UNI=
X based tun device=2E</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/s=
rc/openvpn/vlan=2Ec</span><br><span>index 69ac10d=2E=2E04e18d6 100644</span=
><br><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vla=
n=2Ec</span><br><span>@@ -288,7 +288,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-vlan_process_outgoing_tun(struct multi_context *m, struct multi_instanc=
e *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vlan_process_=
outgoing_tun(const struct multi_context *m, struct multi_instance *mi)</spa=
n><br><span> {</span><br><span>     if (!m-&gt;top=2Eoptions=2Evlan_tagging=
)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/vlan=2Eh =
b/src/openvpn/vlan=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 100644</s=
pan><br><span>--- a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/openvpn/=
vlan=2Eh</span><br><span>@@ -35,6 +35,6 @@</span><br><span> </span><br><spa=
n> bool vlan_is_tagged(const struct buffer *buf);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void vlan_process_outgoing_tu=
n(struct multi_context *m, struct multi_instance *mi);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void vlan_process_outgoing_tun(const str=
uct multi_context *m, struct multi_instance *mi);</span><br><span> </span><=
br><span> #endif /* VLAN_H */</span><br><span>diff --git a/src/openvpn/win3=
2=2Eh b/src/openvpn/win32=2Eh</span><br><span>index 8be3d96=2E=2E39ff7d8 10=
0644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/src/=
openvpn/win32=2Eh</span><br><span>@@ -227,7 +227,7 @@</span><br><span> void=
 overlapped_io_close(struct overlapped_io *o);</span><br><span> </span><br>=
<span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-overlapped_io_active(struct overlapped_io *o)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+overlapped_io_active(const struct overlapped_=
io *o)</span><br><span> {</span><br><span>     return o-&gt;iostate =3D=3D =
IOSTATE_QUEUED || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</span><br>=
<span> }</span><br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/s=
rc/openvpnmsica/openvpnmsica=2Ec</span><br><span>index 1a17d95=2E=2Ed2fd9af=
 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><=
span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -77,7 +77,7=
 @@</span><br><span>  * @return ERROR_SUCCESS on success; An error code oth=
erwise</span><br><span>  */</span><br><span> static UINT</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE hInstall, =
_In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+setup_sequence(_In_ MSIHANDLE hInsta=
ll, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *seq)</span>=
<br><span> {</span><br><span>     UINT uiResult;</span><br><span>     LPWST=
R szSequence =3D msica_arg_seq_join(seq);</span><br><span>diff --git a/src/=
openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><sp=
an>index 9a68bbb=2E=2Ed8cf6e1 100644</span><br><span>--- a/src/openvpnserv/=
interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span=
><br><span>@@ -522,7 +522,7 @@</span><br><span> </span><br><span> </span><b=
r><span> static SOCKADDR_INET</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-sockaddr_inet(short family, inet_address_t *addr)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+sockaddr_inet(short family, const ine=
t_address_t *addr)</span><br><span> {</span><br><span>     SOCKADDR_INET sa=
_inet;</span><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tes=
ts/unit_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=
=2Efff4c2b 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_manag=
ement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2E=
c</span><br><span>@@ -36,7 +36,7 @@</span><br><span> struct management *man=
agement; /* GLOBAL */</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct mana=
gement *man, const char *type, const char *reason)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+management_auth_failure(const struct managem=
ent *man, const char *type, const char *reason)</span><br><span> {</span><b=
r><span>     ASSERT(false);</span><br><span> }</span><br><span>diff --git a=
/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/si=
phash_openssl=2Ec</span><br><span>index 52f13b8=2E=2Ee7282b2 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -100=
,7 +100,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash_openssl_available=
(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_openssl_available(const void *sip_context)</span><br><span> {</span=
><br><span>     const struct siphash_context *sip =3D sip_context;</span><b=
r><span> </span><br><span>@@ -117,6 +117,8 @@</span><br><span> }</span><br>=
<span> #else</span><br><span> /* Do avoid a lot more ifdefs in the test we =
put dummy functions here */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+// cppcheck-suppress-begin constParameterPointer ; stubs</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><b=
r><span> siphash_openssl(void *sip_context, const void *in, const size_t in=
len,</span><br><span>                 const void *k, uint8_t *out, const si=
ze_t outlen)</span><br><span>@@ -125,7 +127,7 @@</span><br><span> }</span><=
br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-siphash_openssl_available(void *sip_context)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_available(const void *s=
ip_context)</span><br><span> {</span><br><span>     return false;</span><br=
><span> }</span><br><span>@@ -141,5 +143,6 @@</span><br><span> {</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+// cppcheck-suppress-end constParameterPointer</span><br><span> </sp=
an><br><span> #endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSS=
L_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span>diff --git a/tests/=
unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_o=
penssl=2Eh</span><br><span>index 0f1d329=2E=2Ea44457e 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>+++ b/=
tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>@@ -60,5 +60,5=
 @@</span><br><span>  *</span><br><span>  */</span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-siphash_openssl_available(void=
 *sip_context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
 /* ifndef SIPHASH_OPENSSL_H */</span><br><span>\ No newline at end of file=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_ava=
ilable(const void *sip_context);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test=
_misc=2Ec</span><br><span>index 8d88943=2E=2Eaea40f0 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static struct hash_element *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_value(=
struct hash *hash, void *value)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+hash_lookup_by_value(struct hash *hash, const void *value)</spa=
n><br><span> {</span><br><span>     struct hash_iterator hi;</span><br><spa=
n>     struct hash_element *he;</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec=
</span><br><span>index c0a0866=2E=2E7636a33 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><b=
r><span>     return mock();</span><br><span> }</span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(stru=
ct management *man, const char *type, const char *reason)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+management_auth_failure(const struct =
management *man, const char *type, const char *reason)</span><br><span> {</=
span><br><span>     assert_true(0);</span><br><span> }</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?us=
p=3Demail">change 1663</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--Ww8JveovDX0=--


--===============2961069873694241227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2961069873694241227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2961069873694241227==--

