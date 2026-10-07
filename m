Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEC3CA6007
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QIAObBCb47YbMsJNTgum2XOTsZgALCDis7xr5nVfNbM=; b=L89GUPVdBXTVYX27yNYYdmAc8A
	23Rv0fZPII8rqnXvLxci1Y+ICUrvWz0FmIMwi0HZnNvqf/+A/iK8R4ir731JaAMQy20R+3PO30aJN
	mObooggyN5+foSN2IyDCkNKQT35kZ2uqBRqGOUDt4FA+NrTfwTFcwHhE/uj6lb/HzIJU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEVH8-0003As-6n;
	Wed, 07 Oct 2026 17:17:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEVH6-0003Al-TP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6TRJ+g5za3zlBw9queJJHPJKNeLMQdKgldNR875mDJU=; b=YdxYEj8rLqbl9PW6QMJtR8uIQE
 GxICaaHva6vM8N5s2L9VnNDxrtQlq5R2VaOubjeNEuQkn7zsnEArSDbW+4y3/Ai9kRTbGRH6QvC76
 t+Q8aX7Vj3LH4nUg6KeDezH+H4NZNGeY68IN0U3VU1dhytjdnEgSJAjJlAcFf04IBnhY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6TRJ+g5za3zlBw9queJJHPJKNeLMQdKgldNR875mDJU=; b=i
 sx1SkirBWtYdLAmzdmVV5/JH8jsR0IX+/c9U0+uqy7nE4nOgCoGk+IKYK0KLn3flIqyosETGzH01B
 +gQ9YmRoMgBxILK7H4nQWByF59hwhTRfetm+nMzQx+HKhCoLGMjDsozk9lywBw5ic5y0TB5Uar7TM
 7UhbgKy4gt7nGS5k=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEVH4-0000Xa-4W for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:52 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so41898415e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791393463; x=1791998263; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6TRJ+g5za3zlBw9queJJHPJKNeLMQdKgldNR875mDJU=;
 b=LkI2+dOMNJ3yVLw139TdnNnylMga0acvEbi9beIqKv6ruQPNfZddz8YceKRHSNKEYE
 ODj4wIPL+Y/aij5PcuPfr2xkbCHdSxSoXlyOIgvXz9NREknbbdE468JDObkc0Jn260CY
 lKAnOw1Q99coiIo+lThZrCTso+epI43h7He+pgehcmhiq3+j3JF2PQiApBV5Qth1Vm+W
 oWlVS0XSZmhqWoHuzL6OnUacdmp1rKdS6vz1Ya8nnBlYbFk2KcARm6VHUQTL9WwJeJFi
 peOPxF+/Zan/fHQiAaysKWmJnHJiYCMxKtVj/KaOf3e8OebhnlUVYc7lcRrQ15kQZ635
 YWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393463; x=1791998263;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6TRJ+g5za3zlBw9queJJHPJKNeLMQdKgldNR875mDJU=;
 b=HJXDxkimeAKDu8eNgjsWeu8U7nzlffQ3f5AKwdehwGipqXFoiDfktMWPb3Zlhn6bdW
 KVUqPko5ISJmHqgSYyNbNeScubMwjhjthiBB+e6hF4ODG96kx8QAeH291X/luLTlH+hI
 mRgRUIU9YRkZrCSp8LXlWXmNhOmvLuJUAlyWNmoFCjkXMpZUGRsf6tVKs8jsGG7BgFUY
 wI9Z8vNQm5pWl/+q4qeJ4UPtflsM1/gd1mfJExq+6VZEU7lCpe7C2W43nJ/iKbkbKQnh
 dBBdvg5bsqtV/mpgJL19AjYWOOtjyy8rVEF7BFTO9hjvxioV9kOWsIbAaeyxBmJuNesB
 h8yQ==
X-Gm-Message-State: AFuF++lwV+cjm/ZGepzB4liti/WQSH90nDbxQxj7G6TMf/mXgkD5Fz8p
 sUTPcV/zQXEFsSslFz8i9deFMgBRKUHcuMvm6VUuI0S4I3aI6BEswS2t7qOSFUvUc8MEFo6DeC+
 BeAGA98IcQuJB8SsrcgJiRLXQbbEgceoYj1ea/+ASFuzIw573rdHMVTD7T4qkMMuEZcnA
X-Gm-Gg: AYBFou0lrt8q3rIk7YTvScX4xrhv3qF7UBqiJ8nmZ+sMlAayxUg/QaCSR2yrG8tE5H7
 +tlRnqaApQB6k7sjO+/JimQ2fVROpKzoT4l6GlovgkMwKvVoNIUBnooFajOaPn7pjlQGd/kQt0a
 ef1tPnTy7JxY+RkvGlA0eecOrYsIaAeaSY5mUL2HibTWRsOx1bARJIkqyXp1LUEyvUHSTFo5rYS
 6bVAW/bsnV0G8v7s+G1O31/FhAcgK2/3S/vgksn5emfFEMjR8SQkXl5tvFAomSmW2MzGygd2wJ+
 0LP1ql0WH15DKoxH7vFy1G2csZ3w05mTwuZ6hwog5tKDvD7G0BBsj4NaiyWmIxVn6Q1v/bopM70
 t82+NfyU32I48zCOvZLiFW++YwnAS5DADozt4ssqIjbUIOBKHE3Eg5Fngh7Zf6O6awDkCuIuhCf
 VO17KwHck9+LC0eETnrxjf101xsca+fsH6pE6Xy3+shD4811zK5uHQSw23nzbeMSKsPBf73irmx
 jKdCplAsTPITY5ay92tCbW8BpWFQlSEmRXx1RQsZqzJWK37M69/6CZsUg8qIqvHQrTTlb0hg2hX
 S/zfc3HMiiUaSnGWAc06/2GZ0Z/6yxez6j0nhJC8nm2OTa7Sc9I644ZiwWM4
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a180422c02mr51191635e9.10.1791393461570; 
 Wed, 07 Oct 2026 10:17:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1842a16b2sm6193185e9.3.2026.10.07.10.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:17:41 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 17:17:38 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
X-Gerrit-Change-Number: 1984
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1984?usp=email>
X-Gerrit-Commit: a1c4187364f14dc267becbcbdf60f16354d9d70b
In-Reply-To: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
References: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg5MTM2MDAwLkkzM2IyNDZkZWE5ZWI5MzgzZTFjYTkyOGUxMzMwYmE4NDBiN2Y5OTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1fb53f368f225e3ef30d15d4c7434217347c5a85-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEVH4-0000Xa-4W
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1868055366759315696=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1868055366759315696==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BtRSJlXQ+NA="; charset=UTF-8

--BtRSJlXQ+NA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
984?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Add missing includes=
 for C files and their own headers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Add missing includes for C files and their own heade=
rs

We don't strictly need those, but it is much better to
have them since =
the compiler will then ensure that we
do not have subtle differences betwee=
n declarations and
definitions=2E

Also fix
- socks=2Eh not being able to b=
e included on its own
- open_tun_afunix stub for Windows having wrong
  par=
ameters

Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
Signed-off-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1984
Message-Id: <20261006132012=2E30845-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
39737=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sr=
c/openvpn/comp-lz4=2Ec
M src/openvpn/cryptoapi=2Ec
M src/openvpn/dco_win=2E=
c
M src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/openvpn/tun_afunix=
=2Ec
M tests/unit_tests/openvpn/siphash_openssl=2Ec
7 files changed, 9 inse=
rtions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/84/1984/3

diff --git a/src/openvpn/comp-lz4=2Ec b/src/=
openvpn/comp-lz4=2Ec
index 48797b0=2E=2E57c6bb3 100644
--- a/src/openvpn/co=
mp-lz4=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -31,6 +31,7 @@
 #include <lz4=
=2Eh>
 
 #include "comp=2Eh"
+#include "comp-lz4=2Eh"
 #include "error=2Eh"=

 
 #include "memdbg=2Eh"
diff --git a/src/openvpn/cryptoapi=2Ec b/src/open=
vpn/cryptoapi=2Ec
index ad2706c=2E=2Eef3c94c 100644
--- a/src/openvpn/crypt=
oapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -47,6 +47,7 @@
 #include <ctype=
=2Eh>
 
 #include "buffer=2Eh"
+#include "cryptoapi=2Eh"
 #include "openssl=
_compat=2Eh"
 #include "win32=2Eh"
 #include "xkey_common=2Eh"
diff --git a=
/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index c230a90=2E=2E6e5e2=
95 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -2=
7,6 +27,7 @@
 #include "syshead=2Eh"
 
 #include "dco=2Eh"
+#include "dco_w=
in=2Eh"
 #include "forward=2Eh"
 #include "tun=2Eh"
 #include "crypto=2Eh"
=
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
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
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--BtRSJlXQ+NA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1984?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add missing includes for C files and their own headers<br><br>We don&#3=
9;t strictly need those, but it is much better to<br>have them since the co=
mpiler will then ensure that we<br>do not have subtle differences between d=
eclarations and<br>definitions=2E<br><br>Also fix<br>- socks=2Eh not being =
able to be included on its own<br>- open_tun_afunix stub for Windows having=
 wrong<br>  parameters<br><br>Change-Id: I33b246dea9eb9383e1ca928e1330ba840=
b7f990c<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984<br>Message-Id: &lt;20261006=
132012=2E30845-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39737=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/open=
vpn/comp-lz4=2Ec<br>M src/openvpn/cryptoapi=2Ec<br>M src/openvpn/dco_win=2E=
c<br>M src/openvpn/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src/openvpn/tu=
n_afunix=2Ec<br>M tests/unit_tests/openvpn/siphash_openssl=2Ec<br>7 files c=
hanged, 9 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/1984/3</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec</span><br>=
<span>index 48797b0=2E=2E57c6bb3 100644</span><br><span>--- a/src/openvpn/c=
omp-lz4=2Ec</span><br><span>+++ b/src/openvpn/comp-lz4=2Ec</span><br><span>=
@@ -31,6 +31,7 @@</span><br><span> #include &lt;lz4=2Eh&gt;</span><br><span=
> </span><br><span> #include &quot;comp=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;comp-lz4=2Eh&quot;</span><br><=
span> #include &quot;error=2Eh&quot;</span><br><span> </span><br><span> #in=
clude &quot;memdbg=2Eh&quot;</span><br><span>diff --git a/src/openvpn/crypt=
oapi=2Ec b/src/openvpn/cryptoapi=2Ec</span><br><span>index ad2706c=2E=2Eef3=
c94c 100644</span><br><span>--- a/src/openvpn/cryptoapi=2Ec</span><br><span=
>+++ b/src/openvpn/cryptoapi=2Ec</span><br><span>@@ -47,6 +47,7 @@</span><b=
r><span> #include &lt;ctype=2Eh&gt;</span><br><span> </span><br><span> #inc=
lude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;cryptoapi=2Eh&quot;</span><br><span> #include &quot;=
openssl_compat=2Eh&quot;</span><br><span> #include &quot;win32=2Eh&quot;</s=
pan><br><span> #include &quot;xkey_common=2Eh&quot;</span><br><span>diff --=
git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>ind=
ex c230a90=2E=2E6e5e295 100644</span><br><span>--- a/src/openvpn/dco_win=2E=
c</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -27,6 +2=
7,7 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;dco=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;dco_win=2Eh&quot;</span><br><span>=
 #include &quot;forward=2Eh&quot;</span><br><span> #include &quot;tun=2Eh&q=
uot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span>diff =
--git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index=
 65ecb3c=2E=2Eb84da24 100644</span><br><span>--- a/src/openvpn/socks=2Ec</s=
pan><br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -34,6 +34,7 @@=
</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;socks=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</sp=
an><br><span> #include &quot;misc=2Eh&quot;</span><br><span> #include &quot=
;win32=2Eh&quot;</span><br><span>diff --git a/src/openvpn/socks=2Eh b/src/o=
penvpn/socks=2Eh</span><br><span>index 846113d=2E=2Ecaed18c 100644</span><b=
r><span>--- a/src/openvpn/socks=2Eh</span><br><span>+++ b/src/openvpn/socks=
=2Eh</span><br><span>@@ -29,6 +29,8 @@</span><br><span> #define SOCKS_H</sp=
an><br><span> </span><br><span> #include &quot;buffer=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;interval=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;si=
g=2Eh&quot;</span><br><span> </span><br><span> struct openvpn_sockaddr;</sp=
an><br><span> struct link_socket_actual;</span><br><span>diff --git a/src/o=
penvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index a6=
7a472=2E=2Ef494d42 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec<=
/span><br><span>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -35,6 +=
35,7 @@</span><br><span> #include &quot;argv=2Eh&quot;</span><br><span> #in=
clude &quot;options=2Eh&quot;</span><br><span> #include &quot;socket=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
un_afunix=2Eh&quot;</span><br><span> </span><br><span> #ifndef WIN32</span>=
<br><span> /* Windows does implement some AF_UNIX functionality but key fea=
tures</span><br><span>@@ -172,8 +173,7 @@</span><br><span> }</span><br><spa=
n> #else  /* ifndef WIN32 */</span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-open_tun_afunix(const char *dev, const char *d=
ev_type, int mtu, struct tuntap *tt,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                struct env_set env)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+open_tun_afunix(struct options *o, int mtu, =
struct tuntap *tt, struct env_set *orig_env)</span><br><span> {</span><br><=
span>     msg(M_ERR, &quot;AF_UNIX socket support not available on this pla=
tform&quot;);</span><br><span> }</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=
=2Ec</span><br><span>index 99a7763=2E=2E52f13b8 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -26,6 +26,7 @@</s=
pan><br><span> #endif</span><br><span> </span><br><span> #include &quot;sip=
hash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;siphash_openssl=2Eh&quot;</span><br><span> </span><br><span> #ifd=
ef ENABLE_CRYPTO_OPENSSL</span><br><span> #include &lt;openssl/opensslv=2Eh=
&gt;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1984?usp=3Demail">change 1984</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I33b246dea9eb9383e1ca928e=
1330ba840b7f990c </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1984 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--BtRSJlXQ+NA=--


--===============1868055366759315696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1868055366759315696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1868055366759315696==--

