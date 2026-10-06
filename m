Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54966CA5FF0
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=5HG8V/mMOmhDs8LHdKqncnpPw3wcZRumLw2tAhXxLK4=; b=O+y8Oyaeu6q3Ef
	IG+bkbDJLaXVjMFj+qftLEdXyaDdjpHJVmenk7o3HjvuXFqV1L/ReWHBygL1Mceqct9/m/wRAovxZ
	QjHf5PLuTkpN9r/laojhtdIuuAdtj+o0ZGBxef38nuqh7NDFSeCJwlS1XJSlA2EBXjGkGE/VMXWm2
	Yok=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE48g-0005t8-PF;
	Tue, 06 Oct 2026 12:19:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE48e-0005t1-Ov
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cPAhKP5mCZu8I426RTG6KRQNWEEJwUPUWmaxhIgto2U=; b=LhC7tM85VPNVRcvu/X4f/tfjn9
 9qNh/tAcZdT1GVdhu68cuOGGxih/10TatMmAwKW0h/YKptpHotu2u+TawNiFKCLYAZQwK+js8rEHW
 GiETrpjswIUNsqehRfC/HyZQ5Cu+REFtWDo3JyYQB2dAy5/5VHyXUCBbrl6pMSmrBhzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cPAhKP5mCZu8I426RTG6KRQNWEEJwUPUWmaxhIgto2U=; b=M
 raI5YL1FmAPz7eQf6eUAQNUtcIDjGzyfHk4szFxZAXtCbPb6pXZ3RTwnMo5DcIpTP3vokYschlVW1
 DXqhC8NyUXNncXhdhj9MdU+sHWkAMl77H94+tyyJL3HGuVQVJ+NKcjvfHsk7EFNbmLXaRwkOgRFUA
 O66ee9rbj9IFuFDE=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE48Y-0006sp-Nt for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:19:16 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so20225905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791289148; x=1791893948; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cPAhKP5mCZu8I426RTG6KRQNWEEJwUPUWmaxhIgto2U=;
 b=VRPpDBE1bEhGGM+cYwx0827IwttHwnAzf9V3tS8J0Ff2z1gTTGwgI/2q+yFYa8TRu7
 HY/EXlTwKSn7754xB+DSHQv116/l7X3DkwwIDsxaDk6PUhaYJNoQXdOVOCCq1GGqeBBa
 BlIuTOR5Yl19vRgJ8oeOD4mNluSAm5dPvzP9P7MxiyrlipKD9zR6WoiXcwGCwRSOYRyb
 nQiH8sIulCpVwSHs92i4w95mB1NHIjnuQaD+MNqJ6NBo7QM7xEpVVt17FBfGaztbTYFU
 /shwkukBNm3CVw7aVASvomhMh26fmO4TcF9SBccEXd9cvZnfxM6Yu32KiKnToOntbb+9
 +psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791289148; x=1791893948;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cPAhKP5mCZu8I426RTG6KRQNWEEJwUPUWmaxhIgto2U=;
 b=2kkK20UnzcZhyVoSKgXFnl/QDnbuY9C8bzL9yuxsJYy5osltdR1xbIjz2yzBVgcxxb
 YTmLjdL7nHr3B1gOcl36jsgOjZHEghU/deXM+WDC9S+7hXS8R5vyjDiVxhxhvCCVIDkR
 RFP44x7GNGzpdRAdizDPNw29CPxPLYakvlViCD17m07lpIkk2U3LfrJ9W/4860V9hFUJ
 k9PSRb2V9sx+7V/yozE2l6SA65T27beINSdA0orcWoexCCSt0w+iWNtC8K9cg+fOH8vU
 59eUS3nAsB9lSuMLe+6w4h582wFIp1qzkfZ4GUFnwVvgCdwLB132yZHABa0RIhJVwl7m
 iqwA==
X-Gm-Message-State: AFuF++lGbwpo8QwsSbRpKYIkBt3rGowqRR3EMMYov4mTPLD+QxmsWk36
 adqTIxc72IBtfu+YJGLXT9jhp+x+04C6bSMmkp/QSdzXXNJjk1l4OJlSCQn/ztCqHVUKYxJa4rq
 viHp6HsV/kL6mh7TMb1R3BOLqUnHhgCwHWIZtrb7L/WKUNH7K+bHX7u6QmIah0DSgMtzNzhjgCJ
 G41opE7g==
X-Gm-Gg: AYBFou0fE65CuDE9yebWeXihFF6yARfLP0wodVdSyW8aHA6HDwg3b1bYHZcD/1FlGlM
 Ln/QxkyUnItqKfVxhxuVqKuSF2xyNMZrjyauEJImVAfkKM4S7nOBwC9oAMTKeNGBNaaX1cmHE7Q
 pyribOebEQOFABsCcTWo5MBhDdM70GBMvCzJZTWO9KGM2gWuKmE8N0jTVJBybquD9G9LAf1kTHr
 LtE3hkolFGewUV+mX82735NKzUHVO+SUiQeFdh26s/Epz9RbWFe0q5Ge1MeyDccwItl4qNm8W04
 xKGjaI8TN9c8oBIOn4GyrUOPb15MnyJKJeLm5lmpYo9f/jBEX2sBL7ByNXib7+cV763LyVkrLov
 AcsycC2pFGKosUd/rojcj9SXVD0dRXML2hyDmsbftNoOM3+CE9IqBnXHQ2L0Hmv9O4Nop0DIKGD
 0y98gNQQMi+aPQeBbNk5Kw1N1ITFn48sId4sEuu3W8HcZMYF7IFgGbsZiifNYLh2S0iqhwz5lVD
 7WsqOc5QFl3niXN8diblGQ322bc3PUj2zCw8vjVvcmrZ6BPJ3/914YNpg0+8X0KoGcYCl9g2q8L
 wqc+9OguWuwGcj1RCkPNRxZMkTD1ADQ0ld6FpgxVeuwIf0nAmj4FI4hyOZWt
X-Received: by 2002:a05:600c:1f91:b0:4a0:25c:8af2 with SMTP id
 5b1f17b1804b1-4a1680f1924mr163486235e9.17.1791289147901; 
 Tue, 06 Oct 2026 05:19:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a166bfaf73sm223156885e9.4.2026.10.06.05.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 05:19:07 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 12:19:06 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
X-Gerrit-Change-Number: 1984
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1984?usp=email>
X-Gerrit-Commit: 93486a08242cea5ca542ef1af4957bac518a0e70
References: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg5MTM2MDAwLkkzM2IyNDZkZWE5ZWI5MzgzZTFjYTkyOGUxMzMwYmE4NDBiN2Y5OTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1ce2f181f44d8e77b957f46cd5a9c957210e6e5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE48Y-0006sp-Nt
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0915261932025561439=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0915261932025561439==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mTIsQmNB4eU="; charset=UTF-8

--mTIsQmNB4eU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1984?usp=3Demail

to review the following change=2E
=


Change subject: Add missing includes for C files and their own headers
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add missing i=
ncludes for C files and their own headers

We don't strictly need those, bu=
t it is much better to
have them since the compiler will then ensure that w=
e
do not have subtle differences between declarations and
definitions=2E

A=
lso fix
- socks=2Eh not being able to be included on its own
- open_tun_afu=
nix stub for Windows having wrong
  parameters

Change-Id: I33b246dea9eb938=
3e1ca928e1330ba840b7f990c
Signed-off-by: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
---
M src/openvpn/comp-lz4=2Ec
M src/openvpn/cryptoapi=2Ec
M src/=
openvpn/dco_win=2Ec
M src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/o=
penvpn/tun_afunix=2Ec
M tests/unit_tests/openvpn/siphash_openssl=2Ec
7 file=
s changed, 9 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/84/1984/1

diff --git a/src/openvpn/c=
omp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec
index 48797b0=2E=2E57c6bb3 100644
--=
- a/src/openvpn/comp-lz4=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -31,6 +31,7 =
@@
 #include <lz4=2Eh>
 
 #include "comp=2Eh"
+#include "comp-lz4=2Eh"
 #in=
clude "error=2Eh"
 
 #include "memdbg=2Eh"
diff --git a/src/openvpn/cryptoa=
pi=2Ec b/src/openvpn/cryptoapi=2Ec
index ad2706c=2E=2Eef3c94c 100644
--- a/=
src/openvpn/cryptoapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -47,6 +47,7 @@=

 #include <ctype=2Eh>
 
 #include "buffer=2Eh"
+#include "cryptoapi=2Eh"
 =
#include "openssl_compat=2Eh"
 #include "win32=2Eh"
 #include "xkey_common=
=2Eh"
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index =
c230a90=2E=2E6e5e295 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn=
/dco_win=2Ec
@@ -27,6 +27,7 @@
 #include "syshead=2Eh"
 
 #include "dco=2Eh=
"
+#include "dco_win=2Eh"
 #include "forward=2Eh"
 #include "tun=2Eh"
 #inc=
lude "crypto=2Eh"
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2E=
c
index 65ecb3c=2E=2Eb84da24 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/o=
penvpn/socks=2Ec
@@ -34,6 +34,7 @@
 
 #include "syshead=2Eh"
 
+#include "s=
ocks=2Eh"
 #include "common=2Eh"
 #include "misc=2Eh"
 #include "win32=2Eh"=

diff --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh
index 846113d=
=2E=2Ecaed18c 100644
--- a/src/openvpn/socks=2Eh
+++ b/src/openvpn/socks=2E=
h
@@ -29,6 +29,8 @@
 #define SOCKS_H
 
 #include "buffer=2Eh"
+#include "in=
terval=2Eh"
+#include "sig=2Eh"
 
 struct openvpn_sockaddr;
 struct link_so=
cket_actual;
diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afun=
ix=2Ec
index a67a472=2E=2Ef494d42 100644
--- a/src/openvpn/tun_afunix=2Ec
+=
++ b/src/openvpn/tun_afunix=2Ec
@@ -35,6 +35,7 @@
 #include "argv=2Eh"
 #in=
clude "options=2Eh"
 #include "socket=2Eh"
+#include "tun_afunix=2Eh"
 
 #i=
fndef WIN32
 /* Windows does implement some AF_UNIX functionality but key f=
eatures
@@ -172,8 +173,7 @@
 }
 #else  /* ifndef WIN32 */
 void
-open_tun_a=
funix(const char *dev, const char *dev_type, int mtu, struct tuntap *tt,
- =
               struct env_set env)
+open_tun_afunix(struct options *o, int =
mtu, struct tuntap *tt, struct env_set *orig_env)
 {
     msg(M_ERR, "AF_UN=
IX socket support not available on this platform");
 }
diff --git a/tests/u=
nit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_op=
enssl=2Ec
index 99a7763=2E=2E52f13b8 100644
--- a/tests/unit_tests/openvpn/=
siphash_openssl=2Ec
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec
@@ -=
26,6 +26,7 @@
 #endif
 
 #include "siphash=2Eh"
+#include "siphash_openssl=
=2Eh"
 
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include <openssl/opensslv=2Eh>

-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33b246dea9eb9383e1ca=
928e1330ba840b7f990c
Gerrit-Change-Number: 1984
Gerrit-PatchSet: 1
Gerrit-O=
wner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>

--mTIsQmNB4eU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Add missing includes for C files and their own headers<br>=
<br>We don&#39;t strictly need those, but it is much better to<br>have them=
 since the compiler will then ensure that we<br>do not have subtle differen=
ces between declarations and<br>definitions=2E<br><br>Also fix<br>- socks=
=2Eh not being able to be included on its own<br>- open_tun_afunix stub for=
 Windows having wrong<br>  parameters<br><br>Change-Id: I33b246dea9eb9383e1=
ca928e1330ba840b7f990c<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>---<br>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/crypt=
oapi=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/socks=2Ec<br>M src/o=
penvpn/socks=2Eh<br>M src/openvpn/tun_afunix=2Ec<br>M tests/unit_tests/open=
vpn/siphash_openssl=2Ec<br>7 files changed, 9 insertions(+), 2 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/84/1984/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/comp-lz4=2Ec b=
/src/openvpn/comp-lz4=2Ec</span><br><span>index 48797b0=2E=2E57c6bb3 100644=
</span><br><span>--- a/src/openvpn/comp-lz4=2Ec</span><br><span>+++ b/src/o=
penvpn/comp-lz4=2Ec</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #inc=
lude &lt;lz4=2Eh&gt;</span><br><span> </span><br><span> #include &quot;comp=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;comp-lz4=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</s=
pan><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br>=
<span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec</s=
pan><br><span>index ad2706c=2E=2Eef3c94c 100644</span><br><span>--- a/src/o=
penvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=2Ec</span>=
<br><span>@@ -47,6 +47,7 @@</span><br><span> #include &lt;ctype=2Eh&gt;</sp=
an><br><span> </span><br><span> #include &quot;buffer=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;cryptoapi=2Eh&qu=
ot;</span><br><span> #include &quot;openssl_compat=2Eh&quot;</span><br><spa=
n> #include &quot;win32=2Eh&quot;</span><br><span> #include &quot;xkey_comm=
on=2Eh&quot;</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/ope=
nvpn/dco_win=2Ec</span><br><span>index c230a90=2E=2E6e5e295 100644</span><b=
r><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco=
_win=2Ec</span><br><span>@@ -27,6 +27,7 @@</span><br><span> #include &quot;=
syshead=2Eh&quot;</span><br><span> </span><br><span> #include &quot;dco=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;dco_win=2Eh&quot;</span><br><span> #include &quot;forward=2Eh&quot;</span=
><br><span> #include &quot;tun=2Eh&quot;</span><br><span> #include &quot;cr=
ypto=2Eh&quot;</span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/ope=
nvpn/socks=2Ec</span><br><span>index 65ecb3c=2E=2Eb84da24 100644</span><br>=
<span>--- a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=
=2Ec</span><br><span>@@ -34,6 +34,7 @@</span><br><span> </span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;socks=2Eh&quot;</span><br><spa=
n> #include &quot;common=2Eh&quot;</span><br><span> #include &quot;misc=2Eh=
&quot;</span><br><span> #include &quot;win32=2Eh&quot;</span><br><span>diff=
 --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh</span><br><span>inde=
x 846113d=2E=2Ecaed18c 100644</span><br><span>--- a/src/openvpn/socks=2Eh</=
span><br><span>+++ b/src/openvpn/socks=2Eh</span><br><span>@@ -29,6 +29,8 @=
@</span><br><span> #define SOCKS_H</span><br><span> </span><br><span> #incl=
ude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;interval=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;sig=2Eh&quot;</span><br><span> </span><=
br><span> struct openvpn_sockaddr;</span><br><span> struct link_socket_actu=
al;</span><br><span>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/t=
un_afunix=2Ec</span><br><span>index a67a472=2E=2Ef494d42 100644</span><br><=
span>--- a/src/openvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tun=
_afunix=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include &qu=
ot;argv=2Eh&quot;</span><br><span> #include &quot;options=2Eh&quot;</span><=
br><span> #include &quot;socket=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;tun_afunix=2Eh&quot;</span><br><span> =
</span><br><span> #ifndef WIN32</span><br><span> /* Windows does implement =
some AF_UNIX functionality but key features</span><br><span>@@ -172,8 +173,=
7 @@</span><br><span> }</span><br><span> #else  /* ifndef WIN32 */</span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_tun=
_afunix(const char *dev, const char *dev_type, int mtu, struct tuntap *tt,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct=
 env_set env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_t=
un_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *or=
ig_env)</span><br><span> {</span><br><span>     msg(M_ERR, &quot;AF_UNIX so=
cket support not available on this platform&quot;);</span><br><span> }</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tes=
ts/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>index 99a7763=2E=
=2E52f13b8 100644</span><br><span>--- a/tests/unit_tests/openvpn/siphash_op=
enssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2E=
c</span><br><span>@@ -26,6 +26,7 @@</span><br><span> #endif</span><br><span=
> </span><br><span> #include &quot;siphash=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash_openssl=2Eh&quot;<=
/span><br><span> </span><br><span> #ifdef ENABLE_CRYPTO_OPENSSL</span><br><=
span> #include &lt;openssl/opensslv=2Eh&gt;</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail">=
change 1984</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
4?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1984 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--mTIsQmNB4eU=--


--===============0915261932025561439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0915261932025561439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0915261932025561439==--

