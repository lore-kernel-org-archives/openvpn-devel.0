Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB3C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1zuGjZCoqrk/qNrYFlbgOMuHbC++cxDrOvunHW1iz4s=; b=Y/4bU6EWOz3jZTdFpXdPfeRCrl
	BVCca7hAWHMTeM4D/b2nfkxIYJZLNqsqxSYK5obOiwbzXyhhmFV8aOrdu/pkdcW4ueRSfecbexgWp
	tzAgFCx0LMDwJz3KgcohHy3jUW0k03ka7IjQrxrTbf8RduhjN0tqGqBz8hqlRl72Y1Fw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKlQ-0002VN-D7;
	Sat, 15 Aug 2026 20:13:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvKlO-0002VC-7U
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 20:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TXjEYy7X8yjesFul+15r3sn/G63vQxmmwJPwIQc+m0g=; b=L09CH4TmC1D1maUblWl6oIpEz1
 AOJTSG20SE9jGIWGYf1ji2JEi07rHt5VTWBziTD7jPIahSjUdVZg++RcfxNcDvf1Kdy2MQboDnUti
 FyXIYh4xwPyy2fB/jV1p5DEWAQwc6EH+2+42cL7yyrGgytTI2fwJLeRtcP3GyFdM05bA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TXjEYy7X8yjesFul+15r3sn/G63vQxmmwJPwIQc+m0g=; b=j
 C/gQT7SgOrJf7bGFtlE1mHi5u+ejCohZLE1NitY/TGGEEnlHqDdHiPhD5ZG5E2vHdkCTcZ6T8LAGx
 Gyf4N67AyBwyLSUoihNpFALSlKa1ntB5YyG7o4AUGKJxmGp60VyaQ68QS6G3wFOKnHbyV/K9iZwfv
 hav0WtAjAUKClbm4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvKlR-0003If-E6 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 20:13:54 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so17284355e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786824827; x=1787429627; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TXjEYy7X8yjesFul+15r3sn/G63vQxmmwJPwIQc+m0g=;
 b=RSZfeSfDT5jRHrjH0GioZ9engU1F2JvgzbDc2NI/B2wR9Wd/gsnur1kfZvJjPReUrt
 1t4fIxW7E5BUDsxSMCZOOwqQTbVH62D9TZ2GfFCZKuotUO8qDhlyKF5tU4c6SRGnxSfS
 kGU0vwN0I2wfNme0JMm3+S4yQjYaHIw5zsxAMv4scfMXvebxY8t5kdwL3dQ76ikO51DR
 cvw6NnjrIMjq2DypizHqLdo09PZ5FNcwgVfv/J1W4hILwt07NCmS+Kxa4lrLQSD20YYc
 dLUUlOIvKREKWKJ1ZGSwM2yxyy3t3uySO4v+hQBR1XB2HP/6ox+vJf5mWbbhhbOvgXru
 qmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786824827; x=1787429627;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TXjEYy7X8yjesFul+15r3sn/G63vQxmmwJPwIQc+m0g=;
 b=ihHik8zJd+GNEhYOKb9EVv4EFVebACKYB5KUuyinc0/2d8KQ7Rub3qtigir5cNJWAy
 tmKlyYnXZzTe9oIS6q+GrT1w9Fg+OdUMcol+mTpGaWYGqPsMWOCawAEzI8E6+SSokPf2
 yR7HXHN2RPAcRhtQN3NC7EaHFunwqEhz0rrb4HQi4aFwiy4pYfLaZtYqB+nSs8nEZ9L0
 acs5uqJgT6tQiYtydn5BObZ8cDPprwfEWm+jIdyb4j/WmrXiFFYSrbOyC9GPdpVQHMQX
 flwdkmkuR0jB1QUKAy3Vt5ThzDHCLRyHRw4K8NQMu9NvBxUjmVISJU7Y3jRwTDWGkLPP
 cpAQ==
X-Gm-Message-State: AOJu0YyQkI/QgQ2Xs1zBylFCYAu7Rn7Nh12iEuasgRkqDW6WgtNmmgnq
 n3gT5d2cklWzNOuBNmTQWkZ/vA228l+dEHU1+FsSbUesgVxsryyq7hJKMth/dyPHqfB3CqxgarY
 vDrBc/vbEePZXmYQEQl1t0M25fAbpd7kQT/0MDxSstJUicVMRymRUlvqIH8wjb2NnkqPBkk+S1+
 ZZpohPvw==
X-Gm-Gg: AR+sD13s70Ixpzq7ZmLFUk6mp/sMrGi/MwemxGox/vt8Ce7sa9D2H6tpvcvvptMnmc5
 nQ0K0MRIKb14AH0/AzWD3zJRAKbhiz+PxTdDRAf395qGxSq1wrfvg6P17QlTmSCL4JTTSoOl5TK
 l9P7aeWg66PQu+leWBXhE3HmzvRtsCphW2fkZEr35n76FeFojQqFtMn9nMUHCeFtueJAumfD/Mg
 MMybL2GGj5PhxI3Qbh12C8/6tSY8XibdzvTF7Fi4mOfo67v0UjqAG3CKUfAzeTXDIYkRVhCorxb
 N6EShd7BxSnogxQR0/B3ex1/wrkvgyhtf1W3WOB9FX8cSnfz9/SrTM1MIyExrDx7Jz2sLaY1SFr
 LX4HxUGbreVMHJWitYbEEQTAv3LtJnUlUiijHed4FgJh8QA9acsN/X8sVbXwO+OtSY0lKnKK3QS
 Bdm+k2FrT4bT6cOgXW/UtNT23d/0Qfz25Fy338Awhxz85RdtBqfRn/RrqbLYhIx5Ur8vWY1X6nS
 ZwLh7A7LKaxRbqKRqA8fMUYQrnrzLeVLSfDN2wU9K+3mMH4Dy13PFS7pLOHSXGlsS6cfaSKtzwN
 T6jk0kgvKI2jgH4JnASb9N66F2AeKgDTafufwe+V9VWHIq0e7uR4jI6UNmhUXQ==
X-Received: by 2002:a05:600c:c289:b0:496:c18c:f9a3 with SMTP id
 5b1f17b1804b1-4998794ce58mr152251505e9.5.1786824827180; 
 Sat, 15 Aug 2026 13:13:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49989ae14f7sm134849865e9.10.2026.08.15.13.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:13:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 15 Aug 2026 20:13:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
X-Gerrit-Change-Number: 1757
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1757?usp=email>
X-Gerrit-Commit: 4acebd72c1c6bc0a4a2ee2b4288c18214fead278
In-Reply-To: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
References: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQ0ODc0MDAwLkkwODI4MWNiNTExZGFjYjJhNjlmZjRhOTYwN2M1ZGFmMDkxNTczMzdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e165a2899e3e8dc098647cab66d05c28a35fa14a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvKlR-0003If-E6
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix compiling with
 mbed TLS 3 and cmake
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1589172493704372543=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1589172493704372543==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4QV5Co3U8no="; charset=UTF-8

--4QV5Co3U8no=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Fix compiling with mbed TLS 3 and cmake
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix compiling wi=
th mbed TLS 3 and cmake

The crypto_mbedtls_legacy=2Ec has been added to th=
e Makefile=2Eam files
but was forgotten in the Cmake build system=2E

Chang=
e-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
Signed-off-by: Arne Schwabe=
 <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757
Message-Id: <2=
0260815130008=2E19708-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38406=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
1 fil=
e changed, 9 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/57/1757/2

diff --git a/CMakeLists=2Et=
xt b/CMakeLists=2Etxt
index ad7de6e=2E=2Eaae264e 100644
--- a/CMakeLists=2E=
txt
+++ b/CMakeLists=2Etxt
@@ -452,6 +452,8 @@
     src/openvpn/crypto_open=
ssl=2Eh
     src/openvpn/crypto_mbedtls=2Ec
     src/openvpn/crypto_mbedtls=
=2Eh
+    src/openvpn/crypto_mbedtls_legacy=2Ec
+    src/openvpn/crypto_mbe=
dtls_legacy=2Eh
     src/openvpn/cryptoapi=2Ec
     src/openvpn/cryptoapi=
=2Eh
     src/openvpn/dco=2Ec
@@ -774,6 +776,7 @@
         src/openvpn/base=
64=2Ec
         src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_mb=
edtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
         src/openv=
pn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         src/openvpn/=
otime=2Ec
@@ -787,6 +790,7 @@
     target_sources(test_crypto PRIVATE
     =
    tests/unit_tests/openvpn/siphash_openssl=2Ec
         src/openvpn/crypt=
o_mbedtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
         src/o=
penvpn/crypto_openssl=2Ec
         src/openvpn/crypto_epoch=2Ec
         sr=
c/openvpn/crypto=2Ec
@@ -805,6 +809,7 @@
             src/openvpn/base64=2E=
c
             src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto=
_mbedtls=2Ec
+            src/openvpn/crypto_mbedtls_legacy=2Ec
           =
  src/openvpn/crypto_openssl=2Ec
             src/openvpn/crypto=2Ec
      =
       src/openvpn/cryptoapi=2Ec
@@ -843,6 +848,7 @@
     target_sources(te=
st_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
         src/openvpn/c=
rypto_mbedtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
         s=
rc/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         src/=
openvpn/otime=2Ec
@@ -871,6 +877,7 @@
         src/openvpn/base64=2Ec
     =
    src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_mbedtls=2Ec
+ =
       src/openvpn/crypto_mbedtls_legacy=2Ec
         src/openvpn/crypto_op=
enssl=2Ec
         src/openvpn/crypto=2Ec
         src/openvpn/env_set=2Ec
=
@@ -947,6 +954,7 @@
             src/openvpn/networking_sitnl=2Ec
         =
    src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=2E=
c
+            src/openvpn/crypto_mbedtls_legacy=2Ec
             src/openv=
pn/crypto_openssl=2Ec
             src/openvpn/crypto=2Ec
             src/=
openvpn/crypto_epoch=2Ec
@@ -968,6 +976,7 @@
             src/openvpn/base6=
4=2Ec
             src/openvpn/crypto_epoch=2Ec
             src/openvpn/cr=
ypto_mbedtls=2Ec
+            src/openvpn/crypto_mbedtls_legacy=2Ec
       =
      src/openvpn/crypto_openssl=2Ec
             src/openvpn/crypto=2Ec
  =
           src/openvpn/env_set=2Ec

-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1757?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
Gerrit-Change-N=
umber: 1757
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--4QV5Co3U8no=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Fix compiling with m=
bed TLS 3 and cmake<br><br>The crypto_mbedtls_legacy=2Ec has been added to =
the Makefile=2Eam files<br>but was forgotten in the Cmake build system=2E<b=
r><br>Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1757<br>Message-Id: &lt;20260815130008=2E19708-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38406=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>1 file changed, 9=
 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/1757/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index ad7de6e=2E=
=2Eaae264e 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>++=
+ b/CMakeLists=2Etxt</span><br><span>@@ -452,6 +452,8 @@</span><br><span>  =
   src/openvpn/crypto_openssl=2Eh</span><br><span>     src/openvpn/crypto_m=
bedtls=2Ec</span><br><span>     src/openvpn/crypto_mbedtls=2Eh</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/crypto_mbedtls_l=
egacy=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/op=
envpn/crypto_mbedtls_legacy=2Eh</span><br><span>     src/openvpn/cryptoapi=
=2Ec</span><br><span>     src/openvpn/cryptoapi=2Eh</span><br><span>     sr=
c/openvpn/dco=2Ec</span><br><span>@@ -774,6 +776,7 @@</span><br><span>     =
    src/openvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_epoc=
h=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_mbedtl=
s_legacy=2Ec</span><br><span>         src/openvpn/crypto_openssl=2Ec</span>=
<br><span>         src/openvpn/crypto=2Ec</span><br><span>         src/open=
vpn/otime=2Ec</span><br><span>@@ -787,6 +790,7 @@</span><br><span>     targ=
et_sources(test_crypto PRIVATE</span><br><span>         tests/unit_tests/op=
envpn/siphash_openssl=2Ec</span><br><span>         src/openvpn/crypto_mbedt=
ls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpn/crypto_mbedtls_legacy=2Ec</span><br><span>         src/openvpn/crypt=
o_openssl=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><=
br><span>         src/openvpn/crypto=2Ec</span><br><span>@@ -805,6 +809,7 @=
@</span><br><span>             src/openvpn/base64=2Ec</span><br><span>     =
        src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openv=
pn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>       =
      src/openvpn/crypto_openssl=2Ec</span><br><span>             src/openv=
pn/crypto=2Ec</span><br><span>             src/openvpn/cryptoapi=2Ec</span>=
<br><span>@@ -843,6 +848,7 @@</span><br><span>     target_sources(test_ncp =
PRIVATE</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><sp=
an>         src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        src/openvpn/crypto_mbedtls_legacy=2Ec</span>=
<br><span>         src/openvpn/crypto_openssl=2Ec</span><br><span>         =
src/openvpn/crypto=2Ec</span><br><span>         src/openvpn/otime=2Ec</span=
><br><span>@@ -871,6 +877,7 @@</span><br><span>         src/openvpn/base64=
=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>=
         src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        src/openvpn/crypto_mbedtls_legacy=2Ec</span><br=
><span>         src/openvpn/crypto_openssl=2Ec</span><br><span>         src=
/openvpn/crypto=2Ec</span><br><span>         src/openvpn/env_set=2Ec</span>=
<br><span>@@ -947,6 +954,7 @@</span><br><span>             src/openvpn/netw=
orking_sitnl=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec<=
/span><br><span>             src/openvpn/crypto_mbedtls=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/crypto_mbed=
tls_legacy=2Ec</span><br><span>             src/openvpn/crypto_openssl=2Ec<=
/span><br><span>             src/openvpn/crypto=2Ec</span><br><span>       =
      src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -968,6 +976,7 @@</spa=
n><br><span>             src/openvpn/base64=2Ec</span><br><span>           =
  src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/cry=
pto_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>             =
src/openvpn/crypto_openssl=2Ec</span><br><span>             src/openvpn/cry=
pto=2Ec</span><br><span>             src/openvpn/env_set=2Ec</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1757?usp=3Demail">change 1757</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5da=
f09157337b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1757 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--4QV5Co3U8no=--


--===============1589172493704372543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1589172493704372543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1589172493704372543==--

