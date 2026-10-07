Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3B7CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rA4EbPlmMoyLaU10wIUKK3ZPgEssNgx2Fxh7vMCkjeA=; b=Kj2MN4VV0CErhI6pjAD08LI6gm
	YDt5lbrKpLiJjV00CQcB+usydq32PRHZK7EsQ1OQlNiME8HC5sK6CJnipa/E6OzFwOQ+BTzUlIG8E
	TMhc8lOr4NstVhe7Yzkd3rXTLH4Z1Zzwqkzc1NN//Njjfob/SXU+AbPF0y8/0Ru08AaU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEVH6-0004fO-JQ;
	Wed, 07 Oct 2026 17:17:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEVH4-0004fA-Or
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=B0NwSNBx2JLImDX1L/GX8e5OrGZ30NF4xL3Xin5Pnfo=; b=N9AVn8Tpq30xF4CUzHUJh1g8vS
 0Dm6+3s9x1dbQ3X4Dnm5x0Q6WI5LyrDMOq4CXrt7DWFnvwn3mpAijFpplqtr934Lw5pMg/2mEbZGx
 wdAAGKzXVMRMqHNSl7+4uboEsEJ1sjqscEth/b4yrffNNzq4L/dKchOFFiXTp7YcpN0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B0NwSNBx2JLImDX1L/GX8e5OrGZ30NF4xL3Xin5Pnfo=; b=G
 vHgL4uFel4lwFoxvzYvNJjGnG3MQgZnwmOUsTsHshCLBaO7danbBBXSx9KwUYUV2Nvi1EwWXgABic
 X4m4h6yisOE2ed0ygT5juh0BdPMevq2aAkbRI2rrhX4Nzu3NPZbA5CCUMjZ0YKqhOcqQqWru3QiPv
 pfEHinFnKsvBnliU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEVH3-0004dT-4a for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:50 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso16001645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791393462; x=1791998262; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B0NwSNBx2JLImDX1L/GX8e5OrGZ30NF4xL3Xin5Pnfo=;
 b=F3NZgvnie38GktkV4x/vr3k6to0QZORgdKroL0VxeBVxT6CR63pl9kz4LqTDRheLss
 b5i5x2kQ6N99BYCfrDmsVKJPMxSYQZ7T6jABH4Ka/QF0B3opO3aYJJbFGW4hlZI1hMdc
 K/dPLSwAsycLB4YGt803lo6lBXU52YWAJ+ID7pBzaSLPfbBbYgCc2ulFf9sn/vATl2YC
 tEpqYnuHlExqGZimiSmOSlV0HRJxA0O5b0f2WKNy53cvoqDreUf1SrJsSpz+ih0/mUeT
 qZB01UOZWHGLRgg4iKy9iSIjK9oJd1dLVgiq0Ke02uXJjClNqN0VoHhElMzHTP3/jRCO
 js1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393462; x=1791998262;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B0NwSNBx2JLImDX1L/GX8e5OrGZ30NF4xL3Xin5Pnfo=;
 b=xBcPuACz5q/x4OkTNPuAv35OPvmXsjXCqHi68TpPJqE3LGoNeOJJb7tTeJkZo0yrTZ
 nV1eJn1in156yC+OouD9tEPTvpCCTauNXlGsPlVlFh74LI5ACDjRcMiSU9Rq2/61+2w2
 hT+ZSo0eBMgYbK8Ncts9OmPum/FaP9k9j2TIpbJtbHddSyNCXvBNQcUQ5LeqjxmbQjBb
 GsRKcIbExmjR1WB27UBrxCXIZVzgnqOOOid7cYkcrjTJdopo38cPfLz9ljO9eZs6jivr
 mAx2DVOhYERrozb7cWpgpOpJwVky9ekdBKwC0ZIf3xEDuYF3eyPvyaiKd06W2x7UJir3
 Kmxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPWrUGkIdDAL+upWc5uUexJJfkJ0yDKKKwZ3DVfXKuVKXXhz7LLEG5lln4hgRqS7YSBol81NGvjLUAAnnM@lists.sourceforge.net
X-Gm-Message-State: AFuF++ktP4bne3iyoLs+ZVvHdeQ36gxTt3wkB1QAhwbYvEL7qL2K9aKH
 V2vK4VhFLJlK8CPNmowknvTcjr+TRenJbEtPuxUH8eXFw6FbjLouYv4B5LrCWN0Ad8mfF7/aPiB
 zyL/KNJat884Y+Zn7QC/POPUmPhDl06T9pmbEi4aaL2NEUfdekpqVwIOzeH++lDMKb69u
X-Gm-Gg: AYBFou0y+V4ho/HH9VqStf4iRGCzFu0fDZk4RlGI7McfUKhw8nmXH0zEDoG324gAbFZ
 fR782t42KPv2qEbNN+o5UO/lakvgT0w63p6a3/y7/zObmHIHWALOwUyTYZq/jgDSxWrZaEV3Hct
 riRaOn9ayCtN8Mrki15A6UO+zyqP92E9u/akWMLNCx93Wl1BA84+DqP3jzrYBG5blQ3oFgyfw2T
 5+CsU88wmeTYLv2XFaKUi3FD/HExazZ3PrpRPfRtGPZWNtklKqh2m3hreJUezo0vjhE7svrI+ay
 bGOqpR7ewpIeTLCjX8NMkvLQFjJbEPQFD7umC1tBgv481Pkq7Lhh3/AnhEVguAHyXA6v74bf2pb
 K7QjxtL7WraQGIOYw893lin6KTorDRLyNI2bu+07zlaKEMLiO675kqFcF9BDm3jFRNGIAP4jb62
 0HA3IznBqZe9iGCSs0F/EMtGrTBS+zWgBstZorWl8FFigSfvdcO1UUr1T3Tt9w/vPeKaVir+R/x
 p1k1KYLL9kXk2V+huqb9Vz4cQEUpyoUZLFGEjby90R1rbxVMYPMOHjzGJfHcw4TJbgwt0hIT9lz
 HhKaCbKeEPJraR3gH5mWQlmtnzZV+EcALWklyuGuH6vLMg2TFMyGAiPbvE9f
X-Received: by 2002:a05:600c:8b51:b0:4a0:2488:71cc with SMTP id
 5b1f17b1804b1-4a18066c82cmr49316685e9.32.1791393462389; 
 Wed, 07 Oct 2026 10:17:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843d8997sm5379715e9.10.2026.10.07.10.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:17:42 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 17:17:41 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
X-Gerrit-Change-Number: 1984
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1984?usp=email>
X-Gerrit-Commit: a1c4187364f14dc267becbcbdf60f16354d9d70b
In-Reply-To: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
References: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg5MTM2MDAwLkkzM2IyNDZkZWE5ZWI5MzgzZTFjYTkyOGUxMzMwYmE4NDBiN2Y5OTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1fb53f368f225e3ef30d15d4c7434217347c5a85-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEVH3-0004dT-4a
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add missing includes
 for C files and their own headers
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0642057385740307788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0642057385740307788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IhOTEMK7z1Y="; charset=UTF-8

--IhOTEMK7z1Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1984?usp=3Demail )

Change subject: Add missing includes for C =
files and their own headers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Add missing includes for C files and their own headers

We=
 don't strictly need those, but it is much better to
have them since the co=
mpiler will then ensure that we
do not have subtle differences between decl=
arations and
definitions=2E

Also fix
- socks=2Eh not being able to be incl=
uded on its own
- open_tun_afunix stub for Windows having wrong
  parameter=
s

Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
Signed-off-by: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984
=
Message-Id: <20261006132012=2E30845-1-gert@greenie=2Emuc=2Ede>
URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39737=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/comp-lz4=2Ec
M src/openvpn/cryptoapi=2Ec
M src/openvpn/dco_win=2Ec
M s=
rc/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/openvpn/tun_afunix=2Ec
M=
 tests/unit_tests/openvpn/siphash_openssl=2Ec
7 files changed, 9 insertions=
(+), 2 deletions(-)




diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn=
/comp-lz4=2Ec
index 48797b0=2E=2E57c6bb3 100644
--- a/src/openvpn/comp-lz4=
=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -31,6 +31,7 @@
 #include <lz4=2Eh>
 =

 #include "comp=2Eh"
+#include "comp-lz4=2Eh"
 #include "error=2Eh"
 
 #in=
clude "memdbg=2Eh"
diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cry=
ptoapi=2Ec
index ad2706c=2E=2Eef3c94c 100644
--- a/src/openvpn/cryptoapi=2E=
c
+++ b/src/openvpn/cryptoapi=2Ec
@@ -47,6 +47,7 @@
 #include <ctype=2Eh>
 =

 #include "buffer=2Eh"
+#include "cryptoapi=2Eh"
 #include "openssl_compat=
=2Eh"
 #include "win32=2Eh"
 #include "xkey_common=2Eh"
diff --git a/src/op=
envpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index c230a90=2E=2E6e5e295 1006=
44
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -27,6 +27=
,7 @@
 #include "syshead=2Eh"
 
 #include "dco=2Eh"
+#include "dco_win=2Eh"=

 #include "forward=2Eh"
 #include "tun=2Eh"
 #include "crypto=2Eh"
diff --=
git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index 65ecb3c=2E=2Eb84d=
a24 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -34,6=
 +34,7 @@
 
 #include "syshead=2Eh"
 
+#include "socks=2Eh"
 #include "comm=
on=2Eh"
 #include "misc=2Eh"
 #include "win32=2Eh"
diff --git a/src/openvpn=
/socks=2Eh b/src/openvpn/socks=2Eh
index 846113d=2E=2Ecaed18c 100644
--- a/=
src/openvpn/socks=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -29,6 +29,8 @@
 #defin=
e SOCKS_H
 
 #include "buffer=2Eh"
+#include "interval=2Eh"
+#include "sig=
=2Eh"
 
 struct openvpn_sockaddr;
 struct link_socket_actual;
diff --git a/=
src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index a67a472=2E=2E=
f494d42 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/openvpn/tun_afuni=
x=2Ec
@@ -35,6 +35,7 @@
 #include "argv=2Eh"
 #include "options=2Eh"
 #incl=
ude "socket=2Eh"
+#include "tun_afunix=2Eh"
 
 #ifndef WIN32
 /* Windows do=
es implement some AF_UNIX functionality but key features
@@ -172,8 +173,7 @=
@
 }
 #else  /* ifndef WIN32 */
 void
-open_tun_afunix(const char *dev, con=
st char *dev_type, int mtu, struct tuntap *tt,
-                struct env_=
set env)
+open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, st=
ruct env_set *orig_env)
 {
     msg(M_ERR, "AF_UNIX socket support not avai=
lable on this platform");
 }
diff --git a/tests/unit_tests/openvpn/siphash_=
openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=2Ec
index 99a7763=2E=
=2E52f13b8 100644
--- a/tests/unit_tests/openvpn/siphash_openssl=2Ec
+++ b/=
tests/unit_tests/openvpn/siphash_openssl=2Ec
@@ -26,6 +26,7 @@
 #endif
 
 #=
include "siphash=2Eh"
+#include "siphash_openssl=2Eh"
 
 #ifdef ENABLE_CRYP=
TO_OPENSSL
 #include <openssl/opensslv=2Eh>

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
Gerrit-=
Change-Number: 1984
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--IhOTEMK7z1Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1984?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Add missing includes for C files a=
nd their own headers<br><br>We don&#39;t strictly need those, but it is muc=
h better to<br>have them since the compiler will then ensure that we<br>do =
not have subtle differences between declarations and<br>definitions=2E<br><=
br>Also fix<br>- socks=2Eh not being able to be included on its own<br>- op=
en_tun_afunix stub for Windows having wrong<br>  parameters<br><br>Change-I=
d: I33b246dea9eb9383e1ca928e1330ba840b7f990c<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1984<br>Message-Id: &lt;20261006132012=2E30845-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg39737=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/cryp=
toapi=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/socks=2Ec<br>M src/=
openvpn/socks=2Eh<br>M src/openvpn/tun_afunix=2Ec<br>M tests/unit_tests/ope=
nvpn/siphash_openssl=2Ec<br>7 files changed, 9 insertions(+), 2 deletions(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp=
-lz4=2Ec</span><br><span>index 48797b0=2E=2E57c6bb3 100644</span><br><span>=
--- a/src/openvpn/comp-lz4=2Ec</span><br><span>+++ b/src/openvpn/comp-lz4=
=2Ec</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #include &lt;lz4=2E=
h&gt;</span><br><span> </span><br><span> #include &quot;comp=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;comp-lz4=
=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span>=
 </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span>diff --g=
it a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec</span><br><span>=
index ad2706c=2E=2Eef3c94c 100644</span><br><span>--- a/src/openvpn/cryptoa=
pi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=2Ec</span><br><span>@@ -=
47,6 +47,7 @@</span><br><span> #include &lt;ctype=2Eh&gt;</span><br><span> =
</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;cryptoapi=2Eh&quot;</span><br>=
<span> #include &quot;openssl_compat=2Eh&quot;</span><br><span> #include &q=
uot;win32=2Eh&quot;</span><br><span> #include &quot;xkey_common=2Eh&quot;</=
span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=
=2Ec</span><br><span>index c230a90=2E=2E6e5e295 100644</span><br><span>--- =
a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</sp=
an><br><span>@@ -27,6 +27,7 @@</span><br><span> #include &quot;syshead=2Eh&=
quot;</span><br><span> </span><br><span> #include &quot;dco=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco_win=2E=
h&quot;</span><br><span> #include &quot;forward=2Eh&quot;</span><br><span> =
#include &quot;tun=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quo=
t;</span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=
=2Ec</span><br><span>index 65ecb3c=2E=2Eb84da24 100644</span><br><span>--- =
a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><=
br><span>@@ -34,6 +34,7 @@</span><br><span> </span><br><span> #include &quo=
t;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;socks=2Eh&quot;</span><br><span> #include =
&quot;common=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;</span=
><br><span> #include &quot;win32=2Eh&quot;</span><br><span>diff --git a/src=
/openvpn/socks=2Eh b/src/openvpn/socks=2Eh</span><br><span>index 846113d=2E=
=2Ecaed18c 100644</span><br><span>--- a/src/openvpn/socks=2Eh</span><br><sp=
an>+++ b/src/openvpn/socks=2Eh</span><br><span>@@ -29,6 +29,8 @@</span><br>=
<span> #define SOCKS_H</span><br><span> </span><br><span> #include &quot;bu=
ffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;interval=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;sig=2Eh&quot;</span><br><span> </span><br><span> st=
ruct openvpn_sockaddr;</span><br><span> struct link_socket_actual;</span><b=
r><span>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2E=
c</span><br><span>index a67a472=2E=2Ef494d42 100644</span><br><span>--- a/s=
rc/openvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tun_afunix=2Ec<=
/span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include &quot;argv=2Eh&=
quot;</span><br><span> #include &quot;options=2Eh&quot;</span><br><span> #i=
nclude &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;tun_afunix=2Eh&quot;</span><br><span> </span><br><=
span> #ifndef WIN32</span><br><span> /* Windows does implement some AF_UNIX=
 functionality but key features</span><br><span>@@ -172,8 +173,7 @@</span><=
br><span> }</span><br><span> #else  /* ifndef WIN32 */</span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_tun_afunix(cons=
t char *dev, const char *dev_type, int mtu, struct tuntap *tt,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                struct env_set env=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(st=
ruct options *o, int mtu, struct tuntap *tt, struct env_set *orig_env)</spa=
n><br><span> {</span><br><span>     msg(M_ERR, &quot;AF_UNIX socket support=
 not available on this platform&quot;);</span><br><span> }</span><br><span>=
diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_test=
s/openvpn/siphash_openssl=2Ec</span><br><span>index 99a7763=2E=2E52f13b8 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Ec</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><=
span>@@ -26,6 +26,7 @@</span><br><span> #endif</span><br><span> </span><br>=
<span> #include &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;siphash_openssl=2Eh&quot;</span><br><spa=
n> </span><br><span> #ifdef ENABLE_CRYPTO_OPENSSL</span><br><span> #include=
 &lt;openssl/opensslv=2Eh&gt;</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail">change 1984</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33b2=
46dea9eb9383e1ca928e1330ba840b7f990c </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1984 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--IhOTEMK7z1Y=--


--===============0642057385740307788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0642057385740307788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0642057385740307788==--

