Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCDDCA6002
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSdety17mJbz8EiIeB+UdVJCiKKuccX4XPG5qyV/my0=; b=DkQfURpRFBuVzyjU6ZgsZFyltu
	rnC4J3+SUcshM6tSMdEDmZYeA0jfLy05CZzrmfL4vOY9WpD016hZi5rtHGjmwjOj35gr/3YWXgJAy
	wdQMsCGyNyRHFfzj5ifQmc3dsTxxoYmKuBM3tgpWI4iIOLvGJ1Q7zoyEVZW8hHrLU8XY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xETb1-0001vN-Sq;
	Wed, 07 Oct 2026 15:30:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xETb0-0001vG-Bp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 15:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VhezKp/uX4NT6ExqWSRTbPQNldFfG/uJU1xaP0sD8TU=; b=Yk977l2I7JYN2WpVtHzzihpGiY
 17HDnVEWhImArtKYRZOeBzkJFgGt2OVeE4LxdBhOQynigRQKcgmlYq/a1BsMoxaD2HZLcm3bYQLmV
 su/OFygn7pnGw6Gk42WLbYp6QZ7Dflx120Gu/BF75o9rMw1JKojIY4bw8nPdueLaHWso=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VhezKp/uX4NT6ExqWSRTbPQNldFfG/uJU1xaP0sD8TU=; b=D
 QNnHkzsaPEMg+wQT0oKcq3gkKniez+ym7oMZXNcneDOJDYKt11ddGz1ZLaPg27ykg2uoCOLqWDO7W
 8cSBa5ZclP9Xd1llz8IbJ5D1/3qYCW5NvNngsSJ0LHbtawPyBCaYfXn2Dc8PNF37u40K/hyWxjMR4
 ytvneqOF/VhewbmQ=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xETav-0006Ws-Se for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 15:30:15 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c4207ac26so1454107f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791387007; x=1791991807; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VhezKp/uX4NT6ExqWSRTbPQNldFfG/uJU1xaP0sD8TU=;
 b=DqAaUwOZw9Tc+Eml15aMbxUeuv9dMhFQqVLH+55LAgM98UEIO+2U43Pr/mO+N+1fJe
 arI1z2ePLkRUDu0js4DVvvArFjdk9Grc+3Layhx9acJH2fGGgUC+bXCh4zzINdPj/u42
 8tHGXuusK4G0MVd/sn/ziyKLBQGXFwt0yoaMF1Ovcv3Gch2dU/lMTcZheBRw6MKL1TZX
 htkGVQZqln5NzGYuGXIwlU+g53yr+AzzoY/smk4/pgAK+WQLriEnT/oInhjR/q6wlR8e
 fST+9FfLDH5GIj938K5XJYLt3oP+bIyIf+Uv4kPekwUmSq/ZHPOdTGv6vCSRoykndopd
 8+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791387007; x=1791991807;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VhezKp/uX4NT6ExqWSRTbPQNldFfG/uJU1xaP0sD8TU=;
 b=HFO790g2/WHjCFEQPi8Nz+iFQFaHyVPJ58HGt+slTEjMp3Xu2jFQcUJM9ErrvMHJVT
 6pm95yS1ATiTFcGxsBKaOgzMBLCwSakzL9qpeSAlSm8QIhrIMSTMNGILiHskRyYdysi5
 YkOa9prmI0QjGK78Khnt2ZMo3SVugRbt8PBqGtV/7AULiA2XbUE24SbRQe5jbTwgHNOu
 tH8rDyjdAOH1a38aTqY3pxQNmg4F3RtjOPyMQr4Ny/Ggy9IGMv8oBn4D6g8536HF+CXV
 WO9AG8gDHur7c5b3fFMWRCpJw2/xn9L8JhY6fDM0MdUu8Nhg9x4upUDIAb4/kg9tgX2B
 mKeQ==
X-Gm-Message-State: AFq9FYIdQuTJdPMQiy8hXnYyhyycnNbow2NzPR5/sscbqk0wz34dFLd3
 liKEXRp0uPkewIrh1WsSy/mFZHjIOWTQT9e/JtoJxCYbJmBFr7XrS4DmnfCNxck5nPa10eAedVB
 Ej/aUqllM3Qk/TLIMzky/b6dCr1gvPy7qcwB/J4GO8IoV2wvCCrlRFT8mtN5IusLn1ETpBy+8K3
 BVsNGzRw==
X-Gm-Gg: AYBFou3OB7PkF8LuhKrXCJtJEQ+mT8kOuTztw8n1xMvIIuaeHGOR1qWbZdHd2vTMdov
 +GL5EJCmF5Rj6d7SJGjYo/mlCQu2yrAaa4hWKacjh2iFe72OIfQr3IOiWaS7dhzEWID7QE5BG62
 1uN2yKVu3nYgZ9S9arhB7+HwJAtO+Cxls8Lo44ZEqU9BC4OrEMmKEaKWmkPxlh8umawZYN+BA4f
 N7kwHlodPbzu2cpoE4trw29K37SUAV5OsN/T0me6EImhxt5+xV/fNJODlUKsGrrQ7jNMD7CDxtW
 HH3k6gFXI4OmhAvDAimR3atmjSLY25G0wQ0qaXOstB15ymDsW+fajlzMYExesFZ8y1beoCzykhe
 Tyj4zBjlrDvwGyeaKw6kzz025NMSAMBaOXclqNW6UZlyiHcwSZeEz9TKGChbv8eBz1u0TiyFNih
 nSyEvLplkrnl30IB4YZVA5NZ34zeXv588fjG5GcD9+/5BIMHrRHoy/NoiYKV5nlkOEO6ASFZY0b
 t7HxaYDo2o6PscLhoCEAzfKwEXFTvRcp9wW1vMTQT7/Ny+E5fKEoYok+0j4ERDG2PQYhuIFOwqq
 RsOWMewFfviYMBwLGw/YPr2y4CO26s0M8tfAIDTAgTXkCp4itrvtQ4lrnA3y
X-Received: by 2002:adf:e186:0:b0:48b:1b6:3df8 with SMTP id
 ffacd0b85a97d-48c7288e4bemr5412688f8f.35.1791387006710; 
 Wed, 07 Oct 2026 08:30:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c7256434bsm5666394f8f.15.2026.10.07.08.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 08:30:05 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 15:30:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
X-Gerrit-Change-Number: 1984
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1984?usp=email>
X-Gerrit-Commit: 84f915fba8ac11629f5a9845013a41e0ec000dd5
In-Reply-To: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
References: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg5MTM2MDAwLkkzM2IyNDZkZWE5ZWI5MzgzZTFjYTkyOGUxMzMwYmE4NDBiN2Y5OTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f32d5b381898d634d136a0bc5d34b1789cc949f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xETav-0006Ws-Se
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7143279967028489605=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7143279967028489605==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XmPXFhlxl90="; charset=UTF-8

--XmPXFhlxl90=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=
=3Demail

to look at the new patch set (#2)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: A=
dd missing includes for C files and their own headers
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add missing includes for C files a=
nd their own headers

We don't strictly need those, but it is much better t=
o
have them since the compiler will then ensure that we
do not have subtle =
differences between declarations and
definitions=2E

Also fix
- socks=2Eh n=
ot being able to be included on its own
- open_tun_afunix stub for Windows =
having wrong
  parameters

Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f=
990c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/o=
penvpn/comp-lz4=2Ec
M src/openvpn/cryptoapi=2Ec
M src/openvpn/dco_win=2Ec
M=
 src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/openvpn/tun_afunix=2Ec=

M tests/unit_tests/openvpn/siphash_openssl=2Ec
7 files changed, 9 insertio=
ns(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/84/1984/2

diff --git a/src/openvpn/comp-lz4=2Ec b/src/open=
vpn/comp-lz4=2Ec
index 48797b0=2E=2E57c6bb3 100644
--- a/src/openvpn/comp-l=
z4=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -31,6 +31,7 @@
 #include <lz4=2Eh>=

 
 #include "comp=2Eh"
+#include "comp-lz4=2Eh"
 #include "error=2Eh"
 
 #=
include "memdbg=2Eh"
diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/c=
ryptoapi=2Ec
index ad2706c=2E=2Eef3c94c 100644
--- a/src/openvpn/cryptoapi=
=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -47,6 +47,7 @@
 #include <ctype=2Eh=
>
 
 #include "buffer=2Eh"
+#include "cryptoapi=2Eh"
 #include "openssl_com=
pat=2Eh"
 #include "win32=2Eh"
 #include "xkey_common=2Eh"
diff --git a/src=
/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index c230a90=2E=2E6e5e295 1=
00644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -27,6 =
+27,7 @@
 #include "syshead=2Eh"
 
 #include "dco=2Eh"
+#include "dco_win=
=2Eh"
 #include "forward=2Eh"
 #include "tun=2Eh"
 #include "crypto=2Eh"
di=
ff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index 65ecb3c=2E=
=2Eb84da24 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@=
@ -34,6 +34,7 @@
 
 #include "syshead=2Eh"
 
+#include "socks=2Eh"
 #includ=
e "common=2Eh"
 #include "misc=2Eh"
 #include "win32=2Eh"
diff --git a/src/=
openvpn/socks=2Eh b/src/openvpn/socks=2Eh
index 846113d=2E=2Ecaed18c 100644=

--- a/src/openvpn/socks=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -29,6 +29,8 @@
=
 #define SOCKS_H
 
 #include "buffer=2Eh"
+#include "interval=2Eh"
+#includ=
e "sig=2Eh"
 
 struct openvpn_sockaddr;
 struct link_socket_actual;
diff --=
git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index a67a472=
=2E=2Ef494d42 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/openvpn/tun=
_afunix=2Ec
@@ -35,6 +35,7 @@
 #include "argv=2Eh"
 #include "options=2Eh"
=
 #include "socket=2Eh"
+#include "tun_afunix=2Eh"
 
 #ifndef WIN32
 /* Wind=
ows does implement some AF_UNIX functionality but key features
@@ -172,8 +1=
73,7 @@
 }
 #else  /* ifndef WIN32 */
 void
-open_tun_afunix(const char *de=
v, const char *dev_type, int mtu, struct tuntap *tt,
-                struc=
t env_set env)
+open_tun_afunix(struct options *o, int mtu, struct tuntap *=
tt, struct env_set *orig_env)
 {
     msg(M_ERR, "AF_UNIX socket support no=
t available on this platform");
 }
diff --git a/tests/unit_tests/openvpn/si=
phash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=2Ec
index 99a7=
763=2E=2E52f13b8 100644
--- a/tests/unit_tests/openvpn/siphash_openssl=2Ec
=
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec
@@ -26,6 +26,7 @@
 #endi=
f
 
 #include "siphash=2Eh"
+#include "siphash_openssl=2Eh"
 
 #ifdef ENABL=
E_CRYPTO_OPENSSL
 #include <openssl/opensslv=2Eh>

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990=
c
Gerrit-Change-Number: 1984
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>

--XmPXFhlxl90=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #2</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Add missing includes for C files an=
d their own headers<br><br>We don&#39;t strictly need those, but it is much=
 better to<br>have them since the compiler will then ensure that we<br>do n=
ot have subtle differences between declarations and<br>definitions=2E<br><b=
r>Also fix<br>- socks=2Eh not being able to be included on its own<br>- ope=
n_tun_afunix stub for Windows having wrong<br>  parameters<br><br>Change-Id=
: I33b246dea9eb9383e1ca928e1330ba840b7f990c<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/comp-lz4=2Ec<b=
r>M src/openvpn/cryptoapi=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn=
/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src/openvpn/tun_afunix=2Ec<br>M =
tests/unit_tests/openvpn/siphash_openssl=2Ec<br>7 files changed, 9 insertio=
ns(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/84/1984/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec</span><br><span>index 48797b=
0=2E=2E57c6bb3 100644</span><br><span>--- a/src/openvpn/comp-lz4=2Ec</span>=
<br><span>+++ b/src/openvpn/comp-lz4=2Ec</span><br><span>@@ -31,6 +31,7 @@<=
/span><br><span> #include &lt;lz4=2Eh&gt;</span><br><span> </span><br><span=
> #include &quot;comp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;comp-lz4=2Eh&quot;</span><br><span> #include &qu=
ot;error=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=
=2Eh&quot;</span><br><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/ope=
nvpn/cryptoapi=2Ec</span><br><span>index ad2706c=2E=2Eef3c94c 100644</span>=
<br><span>--- a/src/openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn=
/cryptoapi=2Ec</span><br><span>@@ -47,6 +47,7 @@</span><br><span> #include =
&lt;ctype=2Eh&gt;</span><br><span> </span><br><span> #include &quot;buffer=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;cryptoapi=2Eh&quot;</span><br><span> #include &quot;openssl_compat=2E=
h&quot;</span><br><span> #include &quot;win32=2Eh&quot;</span><br><span> #i=
nclude &quot;xkey_common=2Eh&quot;</span><br><span>diff --git a/src/openvpn=
/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index c230a90=2E=2E6=
e5e295 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span=
>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -27,6 +27,7 @@</span><br>=
<span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span> =
#include &quot;dco=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;dco_win=2Eh&quot;</span><br><span> #include &quot;f=
orward=2Eh&quot;</span><br><span> #include &quot;tun=2Eh&quot;</span><br><s=
pan> #include &quot;crypto=2Eh&quot;</span><br><span>diff --git a/src/openv=
pn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index 65ecb3c=2E=2Eb84=
da24 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+++=
 b/src/openvpn/socks=2Ec</span><br><span>@@ -34,6 +34,7 @@</span><br><span>=
 </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socks=2Eh&=
quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><span> #in=
clude &quot;misc=2Eh&quot;</span><br><span> #include &quot;win32=2Eh&quot;<=
/span><br><span>diff --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh<=
/span><br><span>index 846113d=2E=2Ecaed18c 100644</span><br><span>--- a/src=
/openvpn/socks=2Eh</span><br><span>+++ b/src/openvpn/socks=2Eh</span><br><s=
pan>@@ -29,6 +29,8 @@</span><br><span> #define SOCKS_H</span><br><span> </s=
pan><br><span> #include &quot;buffer=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;interval=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sig=2Eh&quot;</span=
><br><span> </span><br><span> struct openvpn_sockaddr;</span><br><span> str=
uct link_socket_actual;</span><br><span>diff --git a/src/openvpn/tun_afunix=
=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index a67a472=2E=2Ef494d4=
2 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</span><br><span>+=
++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br=
><span> #include &quot;argv=2Eh&quot;</span><br><span> #include &quot;optio=
ns=2Eh&quot;</span><br><span> #include &quot;socket=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tun_afunix=2Eh&quo=
t;</span><br><span> </span><br><span> #ifndef WIN32</span><br><span> /* Win=
dows does implement some AF_UNIX functionality but key features</span><br><=
span>@@ -172,8 +173,7 @@</span><br><span> }</span><br><span> #else  /* ifnd=
ef WIN32 */</span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-open_tun_afunix(const char *dev, const char *dev_type, int mtu,=
 struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              struct env_set env)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+open_tun_afunix(struct options *o, int mtu, struct tuntap *tt=
, struct env_set *orig_env)</span><br><span> {</span><br><span>     msg(M_E=
RR, &quot;AF_UNIX socket support not available on this platform&quot;);</sp=
an><br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/sipha=
sh_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><sp=
an>index 99a7763=2E=2E52f13b8 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/siphash_openssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/siphash_openssl=2Ec</span><br><span>@@ -26,6 +26,7 @@</span><br><span> #en=
dif</span><br><span> </span><br><span> #include &quot;siphash=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash_=
openssl=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_CRYPTO_O=
PENSSL</span><br><span> #include &lt;openssl/opensslv=2Eh&gt;</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1984?usp=3Demail">change 1984</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1984?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newp=
atchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1984 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</bod=
y></html>
--XmPXFhlxl90=--


--===============7143279967028489605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7143279967028489605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7143279967028489605==--

