Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8DCC61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KyB3lFaj7m7z8+5Ggj1z87GNgnx1WiJ3CZon70F0C30=; b=V5/aVRBrh0OL2E0yoaIjI62jrW
	o37NfhfPTWKDIx+UFzDJ71mY0k76/hQJ9OqJmRNGDOP7iPXL+B5vH3TfrNMPYJjcSLiw/EOCJbug5
	VIhgmHhMP6MVosqXqeSRA2eoG/GdwclAJd5BQLSvID0uS+0ZzZtn/ESwiY/8xJ7/icJw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzwyc-0002H8-Ld;
	Fri, 28 Aug 2026 13:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzwyT-0002Gu-3F
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZqIqZfCR9UkgkgBSM9omh6VJacdN627oLIMAJw4v0Z8=; b=Gu40Xy6eRD/j3Q4wGfztDDeVA2
 VV0ZQwAE8HS5dtRWv7g2Zfw8f+90JJgVFskvhrPa4pTk1RcF6m2QiO+ozseo9Qc22s087X+HT0x8U
 YDWwZxVy/BrwZdK26TWasy+lT89+QoDJiNyEp1m3ORpOvlfu9yhDgMB/lOC9pUrW6bog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZqIqZfCR9UkgkgBSM9omh6VJacdN627oLIMAJw4v0Z8=; b=L
 bYVDCyJg1D5izHhqhuo0+8IGJkYRz0QfjhLb7ue7fM7/bfDHfHcpmjjdpSNY4SxV6f3i5sTxXY+IU
 0SC35VYOkTVrFTJOHQM/Ps6Ve1bpvwMTWVV5waDKVNP/LPfcbtb/Ax6wxE09nm5kFwkqyfCTmJlPV
 pNhs/YNarFFDLgCs=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzwyM-0004fi-5e for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:50:29 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so11862655e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787925015; x=1788529815; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZqIqZfCR9UkgkgBSM9omh6VJacdN627oLIMAJw4v0Z8=;
 b=QBWPnSa6EOqnaMgEykf8XZO6ETjbVUoAsTw3kNwTMj4zXI8fe5G4ApAq5VSYfEU6NB
 X0UMR+H/14DDcZW2CRei//yxugqbNMLsvpaHJt2lvweIPV1UNBcdywg/gbb/JaO4yR8N
 7qQDoRwcuRWilfDF0XcalYznfoijEYCG3FVN1KLw8w2GJOJ4RbtxyvtTm/ar+zatedaj
 CiQLLt58uEVfHi7nGmR+uwwXalvIYCiM+crZyEimp++L6f0nbc2wDFOXUDBomPwGS4lM
 3SI0K/Ss2WKlncW89+jz4klyHokUkUweY08HLV2ikCST/5oMYSLSDYPBPDJE5tgHjzVh
 0usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925015; x=1788529815;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZqIqZfCR9UkgkgBSM9omh6VJacdN627oLIMAJw4v0Z8=;
 b=KSkCT/Pd7Kb00pN30Vor/r1GxxdM8L+yrOxG7QMqgpVaAZ1wZThdkQZOPyvcy9IgMM
 3/Dy21xjfXh4nGl3Md+Y3j4haFTEK4MRg62OvJ+LJ0XzE/XazQLy6Hdw+3DnTzGwvQaM
 gmS3s6uCjbSc8rFUTCCh+YfdUVITbVs51i8ke+slF75s8b4Cdwd/GpPrQ95DgEqD8Un1
 yOi6vbpcoxFnJk94L/BfAeNQMc8YTwquunaDpL5WRK/Jev1whGL33jGLwMXX9yCOteqU
 13hzSx0sLtLMRob6Tmi1fm5R3oPbUkWhzLtxnaCys84iFs8kj08XwMw8TqfsdoXnsVb+
 XXgQ==
X-Gm-Message-State: AFuF++lIGRzSbJIoDnyizs0z1/Gm1fOronhGeqPyfcEvkDy/hBOzIsjL
 ZSE/aFeUeC5KiMV/qNeY0YNOsmVw7nmA9q1FH4c/w65fkq1TAXhwsrBtlhOxGr1XHSWH9wiJYln
 w5OagW3TzImv69gJ6e2ANqqa30TYWgJCQ3RYWq+bx5SDon/+uRMofd+0e0p/1zbtZ6DzLK7nEea
 mZzj6UMg==
X-Gm-Gg: AR+sD11HMX2suV3sCIzh9mFJd10/9SB/sa5SkbAB+eJe/MvuP2x8/Uw8oiFwTuhgs6v
 godyKQXUMl+RihOkQLmQ+I8hGWW0WPdWMxuxGrCfvnYKQqWjAOujHw1HICoGLhME1f7gKEJt/In
 sboms7qSQ9VU/wOESC18y7DAhFwoHavtMLQNmEQ2bX3cBw+1yl+7IkjzTTXBs/ZxrK0EVwHP+2p
 WW4h8OQuLD1coKXX7CZpl++N9jvWCKoN9Y7/LBw5NBqq3vHvzvRTodiU9ACGSjpnlKwS9ahQ/3L
 rPT4x9hu7V1qm6tqoxPTpyaTfYzOQekpAE39+KFv5oGhNIu71Imz3SyHDrs0WTjuUN6XS7pmVg3
 npsKD+7CEaZPOVG2qaRRByhurtZ4baFG6TXaWMNiyb6k5oG17gwx2OfCTnROtDWVanXKf9eNH50
 fkzrLyhH5JC2K1i5oesHJEO5BEEEMJ/WQM3M6xIiLbqDwcdFI/kGDlR0V7lP4r16F08W6Z+dmWt
 5BzoVUGrEl2qmG5zfQnJmO5cmQohx7cgP7j0sRJAjb4zenz6/gCdfwdbhCHyLoL5Q0nL2DDG/PW
 YqQSudqjK7B0BD4nIrbWp3a8okO0MWXNM2Hp0eTMs86Katj9CPmd
X-Received: by 2002:a05:600c:4e14:b0:499:ae94:be05 with SMTP id
 5b1f17b1804b1-49b91bd78c0mr120314535e9.0.1787925014233; 
 Fri, 28 Aug 2026 06:50:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013ce4sm47693555e9.14.2026.08.28.06.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 06:50:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 13:50:11 +0000
To: flichtenheld <frank@lichtenheld.com>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 8f25090ead49b0c71eb783623d1309738e9a7b12
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83f2c0b8398e16eda9c97163c08e17a46eb2ebd1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzwyM-0004fi-5e
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, max@max-fillinger.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7702420481659638994=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7702420481659638994==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QVLs/fa+1E0="; charset=UTF-8

--QVLs/fa+1E0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos=2E

Hel=
lo MaxF, flichtenheld, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail

to look at =
the new patch set (#10)=2E

The following approvals got outdated and were r=
emoved:
Code-Review-1 by MaxF


Change subject: Implement initial packet re=
flection protection using bloom filter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Implement initial packet reflection protection us=
ing bloom filter

When an OpenVPN server is used/tried to be usedc in a ref=
lection attack
the protection with the simple --connect-freq-initial also b=
lock legimitate
client from other networks that are not attacked by a refle=
ction attack=2E

To allow a server to still reply to these clients, we need=
 to make the counts
rather more detailed and count per subnet or IP address=
=2E On the other hand
when we keep all this state, we eliminate the advanta=
ge of having a stateless
cookie based initial packet handshake=2E

As compr=
omoise we use a bloom filter to store the information=2E This data
structur=
e is probabilistic and can have false positive and more packets
being dropp=
ed but since it is a constant size and the size of this map
is small enough=
 for non-embedded systems (tests were done with a 2MB
bloom filter), it is =
a good compromise=2E

The code is split into the bloom filter implementatio=
n and the actual logic
implementing tracking the subnets, so the bloom filt=
er should be relatively
easily be exchangable by another data structure=2E
=

As hash funtion SIPHASH has been chosen since it was designed for this kin=
d
of application=2E

Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
S=
igned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M =2Egithub/workflows/b=
uild=2Eyaml
M CMakeLists=2Etxt
M Changes=2Erst
M doc/man-sections/server-op=
tions=2Erst
M src/openvpn/Makefile=2Eam
A src/openvpn/bloom=2Ec
A src/openv=
pn/bloom=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/o=
ptions=2Ec
M src/openvpn/options=2Eh
M src/openvpn/ovpn_dco_linux=2Eh
M src=
/openvpn/reflect_filter=2Ec
M src/openvpn/reflect_filter=2Eh
M tests/unit_t=
ests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_reflect=2Ec
A te=
sts/unit_tests/openvpn/test_reflect=2Eh
M tests/unit_tests/openvpn/test_ssl=
=2Ec
18 files changed, 1,431 insertions(+), 98 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/30/10

diff --git =
a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index=
 29e8be2a=2E=2Ea018e52 100644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=
=2Egithub/workflows/build=2Eyaml
@@ -155,6 +155,9 @@
         env:
        =
   srcdir: "${{ github=2Eworkspace }}/tests/unit_tests/openvpn"
 
+      - =
name: Run reflect unit test
+        run: =2E/unittests/test_reflect=2Eexe
=
+
   ubuntu:
     strategy:
       fail-fast: false
diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt
index 3eb0062=2E=2Efd8dda1 100644
--- a/CMakeList=
s=2Etxt
+++ b/CMakeLists=2Etxt
@@ -429,6 +429,7 @@
     src/openvpn/base64=
=2Ec
     src/openvpn/base64=2Eh
     src/openvpn/basic=2Eh
+    src/openvp=
n/bloom=2Ec
     src/openvpn/buffer=2Ec
     src/openvpn/buffer=2Eh
     sr=
c/openvpn/circ_list=2Eh
@@ -802,8 +803,11 @@
             tests/unit_tests/=
openvpn/mock_management=2Ec
             tests/unit_tests/openvpn/mock_ssl_=
dependencies=2Ec
             tests/unit_tests/openvpn/mock_win32_execve=2E=
c
+            tests/unit_tests/openvpn/test_reflect=2Ec
+            tests=
/unit_tests/openvpn/test_reflect=2Eh
             src/openvpn/argv=2Ec
    =
         src/openvpn/base64=2Ec
+            src/openvpn/bloom=2Ec
        =
     src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=
=2Ec
             src/openvpn/crypto_openssl=2Ec
@@ -815,7 +819,11 @@
     =
        src/openvpn/options_util=2Ec
             src/openvpn/otime=2Ec
   =
          src/openvpn/packet_id=2Ec
+            src/openvpn/reflect_filter=
=2Ec
             src/openvpn/run_command=2Ec
+            src/openvpn/siph=
ash=2Ec
+            src/openvpn/siphash=2Eh
+            src/openvpn/sipha=
sh_reference=2Ec
             src/openvpn/ssl_mbedtls=2Ec
             src/=
openvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
diff --git a/=
Changes=2Erst b/Changes=2Erst
index 1f992b2=2E=2E5ffd8c4 100644
--- a/Chang=
es=2Erst
+++ b/Changes=2Erst
@@ -120,6 +120,13 @@
     For more details see=

     `lwipovpn on Github <https://github=2Ecom/OpenVPN/lwipovpn>`_=2E
 
+B=
loom filter based reflection protection
+    To avoid the limitation of ``-=
-connect-freq-initial`` to block legimitate
+    clients when an OpenVPN se=
rver is tried to be used in a reflection attack,
+    the new ``--connect-f=
req-initial-bloom-limit`` can impose limit on a
+    per-subnet basis=2E Se=
e the manual for more details=2E Note: this option
+    requires 2MB of ext=
ra memory in the default configuration=2E
+
 Allow overriding username with=
 ``--override-username``
     This is intended to allow using ``--auth-gen-=
token`` in scenarios where the
     clients use certificates and multi-fact=
or authentication=2E  This will
diff --git a/doc/man-sections/server-option=
s=2Erst b/doc/man-sections/server-options=2Erst
index f420588=2E=2Efa9583a =
100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/s=
erver-options=2Erst
@@ -226,6 +226,77 @@
   will not be counted against the=
 limit=2E The default is to allow
   100 initial connection per 10s=2E
 
+
=
+--connect-freq-initial-bloom-size args
+
+   Valid syntax:
+   ::
+
+     =
 connect-freq-initial-bloom-size size [numhashes]
+
+   Configures the size=
 of the bloom filter used for the initial connection
+   packet responses=
=2E See `--connect-freq-initial-bloom-limit` for a full
+   description of =
the feature=2E
+
+   Bloom filters are probabilistic by their nature and th=
e larger the size
+   of the bloom filter is, the more accurate they are=2E=
 This option configures
+   the number of buckets in the bloom filter=2E Ea=
ch bucket takes up 4 bits=2E
+   E=2Eg=2E the default of  8336608 (8 * 2^20=
) when the option is not set
+   will require 2MB of memory=2E The numhashe=
s will control the number of hash
+   functions that are used for the bloom=
 filter=2E The default is 7=2E
+
+--connect-freq-initial-bloom-limit arg
+
=
+   Valid syntax:
+   ::
+
+      connect-freq-initial-bloom-limit inet net=
mask limit
+      connect-freq-initial-bloom-limit inet6 netmask limit
+
+ =
  This option implements a rate limiting function for initial packet like
+=
   ``--connect-freq-initial`` but takes the source of the initial packet in=
to
+   account=2E This function shares the the reset after a time period an=
d
+   enabling this function will not disable the overall limit of
+   ``--=
conect-freq-initial``=2E
+
+   To avoid resource exhaustion on the OpenVPN =
server side from reflection
+   attacks and also trying to avoid blocking l=
egitimate clients when an
+   attacker tries to use an OpenVPN server, the =
limits are not applied globally
+   but rather a per netmask granularity=2E=
 Each line of this command configures
+   a separate granularity=2E As exam=
ple, the following configuration,
+
+   ::
+
+        connect-freq-initial =
1000 60
+        connect-freq-initial-bloom-limit inet 24 50
+        conne=
ct-freq-initial-bloom-limit inet 8 100
+        connect-freq-initial-bloom-=
limit inet6 56 50
+        connect-freq-initial-bloom-limit inet6 32 100
+
=
+    will limit the number of (unanswered) replies per /24 network to 50
+ =
   packets=2E After 50 packets from the same /24, the server will
+    drop=
 any further packets=2E Similarly, if a /16 network receives more than
+   =
 100 connection requests, the server will drop further packets=2E
+    If t=
he count of all packets exceeds 1000, further packets will be
+    complete=
ly dropped regardless of their origin=2E
+
+   The implementation uses a co=
unting bloom filter to store information of how
+   many packets the server=
 has seen per subnet=2E A bloom filter is a
+   probabilistic data structur=
e can yield false positives=2E In this case, the
+   server will drop packe=
ts even though the limit
+   for that particular subnet is not yet reached=
=2E Since we are using a
+   counting bloom filter, a reply from a client t=
hat triggers a removal of an
+   entry can also lead to a false negative=2E=
 However, this is limited in the
+   sense a reply can at most trigger one =
false negative=2E
+
+   Every limit configured with this option will put mo=
re more entries into
+   the bloomfilter since per limit (per family), one =
entry is put into the
+   bloom filter=2E So a large number of entries requ=
ires a larger bloom filter
+   to avoid too many false positives=2E
+
+   I=
Pv6 mapped IPv4 addresses (::ffff:0:0/96) are treated as IPv4 addresses
+  =
 for these limits=2E
+
 --duplicate-cn
   Allow multiple clients with the s=
ame common name to concurrently
   connect=2E In the absence of this option=
, OpenVPN will disconnect a client
diff --git a/src/openvpn/Makefile=2Eam b=
/src/openvpn/Makefile=2Eam
index eb3533c=2E=2Ef85ed42 100644
--- a/src/open=
vpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -46,6 +46,7 @@
 	auth_=
token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
 	basic=2Eh \
+	bloom=
=2Ec bloom=2Eh \
 	buffer=2Ec buffer=2Eh \
 	circ_list=2Eh \
 	clinat=2Ec c=
linat=2Eh \
diff --git a/src/openvpn/bloom=2Ec b/src/openvpn/bloom=2Ec
new =
file mode 100644
index 0000000=2E=2Efabb7ad
--- /dev/null
+++ b/src/openvpn=
/bloom=2Ec
@@ -0,0 +1,248 @@
+/*
+ *  OpenVPN -- An application to securely=
 tunnel IP networks
+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based
+ *             session authentication and key exchange=
,
+ *             packet encryption, packet authentication, and
+ *        =
     packet compression=2E
+ *
+ *  Copyright (C) 2023-2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne Schwabe <arne@rfc2549=
=2Eorg>
+ *
+ *  This program is free software; you can redistribute it and=
/or modify
+ *  it under the terms of the GNU General Public License versio=
n 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This prog=
ram is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License f=
or more details=2E
+ *
+ *  You should have received a copy of the GNU Gene=
ral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/* This file implements a specialised co=
unting bloom filter implementation
+ * used in OpenVPN to mitigate it being=
 used in reflection attacks=2E The bloom
+ * implementation should be gener=
al enough to be used in other contexts
+ * however */
+
+#ifdef HAVE_CONFIG=
_H
+#include "config=2Eh"
+#elif defined(_MSC_VER)
+#include "config-msvc=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+
+#include <stdint=2Eh>
+#includ=
e <stddef=2Eh>
+#include <stdlib=2Eh>
+#include <string=2Eh>
+#include <std=
bool=2Eh>
+#include "siphash=2Eh"
+#include "crypto=2Eh"
+
+#include "bloom=
=2Eh"
+
+
+static size_t
+calc_ceil_log2(size_t num)
+{
+    /* Figure out =
how many bits we have in our hash by doing
+     * ceil(log2(bf->size) */
+=

+    size_t numbits =3D 0;
+    while (num >>=3D 1)
+    {
+        numbit=
s++;
+    }
+    return numbits;
+}
+
+/**
+ * Calculate number of bytes ne=
eded for each hash function in the bloom filter
+ *
+ */
+static inline siz=
e_t
+calculate_num_bytes_hashfun(size_t size)
+{
+    size_t hash_bits =3D =
calc_ceil_log2(size);
+    /* round up to the nearest byte size */
+    siz=
e_t hash_bytes =3D (hash_bits + 7) / 8;
+    return hash_bytes;
+}
+
+/**
+=
 * A bloom filter uses a number of hashes to perform its functionality=2E
+=
 *
+ * Instead of using the same number of siphash function we split the by=
tes of
+ * the siphash to the different hashes=2E
+ *
+ * We could also opt=
imise this further by splitting at the bit level but that
+ * crates a lot =
of extra code for bit shifting, etc=2E so we waste some bits
+ *
+ * @param=
 bf
+ * @param num_hashes
+ * @return
+ */
+size_t
+calculate_num_sip_hash_=
hashes(struct bloom_filter *bf)
+{
+    size_t hash_bytes =3D calculate_num=
_bytes_hashfun(bf->size);
+    size_t total_bytes =3D bf->num_hashes * hash=
_bytes;
+
+    /* Round up to next SIPHASH_HASH_SIZE */
+    size_t num_sip=
hash =3D (total_bytes + BLOOM_HASH_SIZE - 1) / BLOOM_HASH_SIZE;
+
+    retu=
rn num_siphash;
+}
+
+/**
+ * Calculates the number of bytes we need for st=
oring a bloom filter of size
+ * size=2E */
+static inline size_t
+bloom_ge=
t_filter_byte_count(size_t size)
+{
+    size_t bits_required =3D size * BL=
OOM_FILTER_BITS_COUNT;
+    /* Add 7 round up to the next byte */
+    retu=
rn (bits_required + 7) / 8;
+}
+
+
+static inline size_t
+bloom_get_filter_=
bit_offset(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_BITS_COUNT)=
 % (8 * sizeof(bloom_counter_t));
+}
+
+static inline size_t
+bloom_get_fil=
ter_array_index(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_BITS_C=
OUNT) / (8 * sizeof(bloom_counter_t));
+}
+
+static inline bloom_counter_t
=
+bloom_get_filter_get_counter(struct bloom_filter *bf, size_t bucket)
+{
+ =
   static_assert((BLOOM_FILTER_BITS_MASK + 1) =3D=3D (1 << BLOOM_FILTER_BIT=
S_COUNT),
+                  "BLOOM_FILTER_BITMASK and BLOOM_FILTER_BIT_COU=
NT are inconsistent");
+
+    bloom_counter_t counter =3D bf->buckets[bloom=
_get_filter_array_index(bucket)];
+    size_t bitoffset =3D bloom_get_filte=
r_bit_offset(bucket);
+
+    return (counter >> bitoffset) & BLOOM_FILTER_B=
ITS_MASK;
+}
+
+static inline void
+bloom_set_filter_counter(struct bloom_f=
ilter *bf, size_t bucket, bloom_counter_t value)
+{
+    bloom_counter_t da=
ta =3D bf->buckets[bloom_get_filter_array_index(bucket)];
+    size_t bitof=
fset =3D bloom_get_filter_bit_offset(bucket);
+
+    data =3D data & ~(BLOO=
M_FILTER_BITS_MASK << bitoffset);
+
+    data =3D data | ((value & BLOOM_FI=
LTER_BITS_MASK) << bitoffset);
+
+    bf->buckets[bloom_get_filter_array_in=
dex(bucket)] =3D data;
+}
+
+/**
+ * Creates a new bloom filter structure
+=
 * @param size the number of buckets=2E
+ * @return  the newly created bloo=
m filter structure
+ */
+struct bloom_filter *
+bloom_create(size_t size, s=
ize_t num_hashes, struct gc_arena *gc)
+{
+    size_t bloomfilter_bytes =3D=
 bloom_get_filter_byte_count(size);
+    struct bloom_filter *bf =3D gc_mal=
loc(sizeof(struct bloom_filter) + bloomfilter_bytes,
+                     =
                   false, gc);
+    bf->size =3D size;
+    bf->num_hashes =
=3D num_hashes;
+
+    bf->hash_bytes =3D calculate_num_bytes_hashfun(size)=
;
+    bf->num_siphash =3D calculate_num_sip_hash_hashes(bf);
+
+    ALLOC_=
ARRAY_GC(bf->siphash_keys, struct siphash_key, bf->num_siphash, gc);
+    b=
loom_clear(bf);
+    return bf;
+}
+
+/**
+ * Clear the bloom filter, makin=
g it empty again as if it were freshly created
+ * @param bf the bloom stru=
cture to clear
+ */
+void
+bloom_clear(struct bloom_filter *bf)
+{
+    mem=
set(bf->buckets, 0, bloom_get_filter_byte_count(bf->size));
+
+    /* We ra=
ndomise the bloom filter keys on every clear of the bloom filter
+     * to=
 avoid scenarios where an attacker might learn specific pattern
+     * tha=
t could exploit false positives in the bloom filter */
+    for (size_t i =
=3D 0; i < bf->num_siphash; i++)
+    {
+        prng_bytes(bf->siphash_key=
s[i]=2Ekey, SIPHASH_KEY_SIZE);
+    }
+}
+
+
+static bloom_counter_t
+bloom=
_add_test(struct bloom_filter *bf, const uint8_t *item, size_t len, bloom_c=
ounter_t inc)
+{
+    uint8_t result[BLOOM_HASH_SIZE];
+    size_t j =3D 0;=

+    size_t idx =3D 0;
+    bloom_counter_t ret =3D bloom_counter_max;
+
+=
    for (size_t i =3D 0; i < bf->num_hashes; i++)
+    {
+        size_t bu=
cket =3D 0;
+        for (size_t k =3D 0; k < bf->hash_bytes; k++)
+       =
 {
+            if (idx =3D=3D 0)
+            {
+                /* We hav=
e no longer unused bytes in result, generate the next hash */
+            =
    siphash(item, len, bf->siphash_keys[j++]=2Ekey, result, BLOOM_HASH_SIZE=
);
+            }
+
+            bucket =3D bucket << 8;
+            bucke=
t |=3D result[idx];
+
+            idx =3D (idx + 1) % BLOOM_HASH_SIZE;
+  =
      }
+
+        bucket =3D bucket % bf->size;
+        bloom_counter_t v=
alue =3D bloom_get_filter_get_counter(bf, bucket);
+
+        ret =3D min_b=
loom_counter(ret, value);
+
+        if (inc)
+        {
+            value=
 =3D min_bloom_counter(bloom_counter_max, value + 1);
+            bloom_se=
t_filter_counter(bf, bucket, value);
+        }
+    }
+    return ret;
+}
=
+
+
+bloom_counter_t
+bloom_add(struct bloom_filter *bf, const uint8_t *ite=
m, size_t len)
+{
+    return bloom_add_test(bf, item, len, 1);
+}
+
+bloom=
_counter_t
+bloom_remove(struct bloom_filter *bf, const uint8_t *item, size=
_t len)
+{
+    return bloom_add_test(bf, item, len, -1);
+}
+
+
+bloom_cou=
nter_t
+bloom_test(struct bloom_filter *bf, const uint8_t *item, size_t len=
)
+{
+    return bloom_add_test(bf, item, len, 0);
+}
diff --git a/src/open=
vpn/bloom=2Eh b/src/openvpn/bloom=2Eh
new file mode 100644
index 0000000=2E=
=2E8d814d5
--- /dev/null
+++ b/src/openvpn/bloom=2Eh
@@ -0,0 +1,147 @@
+/*
=
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *          =
   over a single TCP/UDP port, with support for SSL/TLS-based
+ *          =
   session authentication and key exchange,
+ *             packet encrypti=
on, packet authentication, and
+ *             packet compression=2E
+ *
+ =
*  Copyright (C) 2023-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright=
 (C) 2023-2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This program is f=
ree software; you can redistribute it and/or modify
+ *  it under the terms=
 of the GNU General Public License version 2
+ *  as published by the Free =
Software Foundation=2E
+ *
+ *  This program is distributed in the hope tha=
t it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  =
See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sh=
ould have received a copy of the GNU General Public License along
+ *  with=
 this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#=
ifndef BLOOM_H
+#define BLOOM_H
+
+#include <stdint=2Eh>
+#include "siphash=
=2Eh"
+#include "buffer=2Eh"
+
+/* This is the type we use for the buckets=
=2E This is split into small buckets
+ * with BLOOM_FILTER_BITS_COUNT size =
*/
+typedef uint32_t bloom_counter_t;
+#define BLOOM_FILTER_BITS_COUNT 4
+#=
define BLOOM_FILTER_BITS_MASK  0x0f
+#define bloom_counter_max       0x0f
+=

+/* we want bloom_counter_t bits to be a multiple of BLOOM_FILTER_BITS_COU=
NT to
+ * allow our operations to calculate bucket indexes to assume that t=
hat a bucket
+ * is always inside a single index bloom_counter_t and never =
stretches over
+ * two adjacent bloom_counter_t */
+static_assert((sizeof(b=
loom_counter_t) * 8) % BLOOM_FILTER_BITS_COUNT =3D=3D 0,
+              "bl=
oom_counter_t must be a multiple of BLOOM_FILTER_BIT_COUNT");
+
+/* We use =
64 bit output from siphash for the bloom filter */
+#define BLOOM_HASH_SIZE=
 8
+
+static inline bloom_counter_t
+min_bloom_counter(bloom_counter_t x, b=
loom_counter_t y)
+{
+    if (x < y)
+    {
+        return x;
+    }
+    =
else
+    {
+        return y;
+    }
+}
+
+struct siphash_key
+{
+    uint=
8_t key[SIPHASH_KEY_SIZE];
+};
+
+/**
+ * A structure holding a bloom filte=
r=2E A bloom filter is a probabilistic
+ * data structure used to test whet=
her an element is a member of a set=2E
+ * It may return false positives bu=
t never false negatives=2E
+ *
+ * A bloom filter has a size N of entries, =
and each entry or bucket is a
+ * counter=2E E=2Eg=2E a bloom filer of size=
 1024 with entries of 4 bits each
+ * will have 4096 bits or 512 bytes in t=
otal size=2E
+ *
+ * Whenever an entry is added to the bloom filter, n hash=
 function are
+ * calculated=2E These map a key -> [0, size of bloom filter=
]=2E For each of
+ * hash function use the result as index for the bucket t=
o increase the
+ * counter=2E
+ *
+ * For our example of a bloom filter wit=
h 1024 entries and 5 hash functions,
+ * hashing an entry might yield 77,32=
3, 662, 789, and 8=2E That would then
+ * increase the buckets (bit counter=
s) at the the index positions 77, 323,
+ * 662, 789, and 8=2E If an entry i=
s at its maximum (15 for 4 bits counters)
+ * it will stop increasing the c=
ounter=2E
+ *
+ * To test if an entry is in the bloom filter we do the same=
 hashing and
+ * check if all the counters positions have at least a value =
of 1=2E
+ *
+ * Removing an entry is similar to adding an entry, we decreme=
nt the
+ * counter at each bit position=2E But with the caveat that buckets=
 with
+ * already at maximum, the counter is not decremented in order to pr=
eserve
+ * the property of never false negatives=2E
+ *
+ * Instead of usin=
g n separate hash functions that map to output log(N) bits,
+ * our impleme=
ntation uses multiple siphash functions with 64 bit output
+ * and slices t=
hem into multiple hash functions of log(N) bits=2E
+ *
+ * E=2Eg=2E when us=
ing a bloom filter of size 1048576 (1024 * 1024),
+ * we need 20 bits outpu=
t for each of the hash functions=2E We round up
+ * to bytes, So that are 3=
 bytes=2E To realize 7 hash function we need
+ * then 21 bytes or three sip=
hash function each with 8 byte (64 bit)
+ */
+struct bloom_filter
+{
+    /=
** Size (N) of the bloom filter in entries
+     * This is also equal to (t=
otal bits)/(bits per counter) */
+    size_t size;
+
+    /** Number of byt=
es used by each hash function=2E
+     *
+     * log2(size * 8) bits rounde=
d up to the next byte
+     *
+     * This is a cached value since log2 is =
surprisingly slow
+     * (5% of total time of if we do not cache it) */
+ =
   size_t hash_bytes;
+
+    /** number of hashes (n) we use to determine t=
he bit positions */
+    size_t num_hashes;
+
+    /** number of siphash fu=
nctions needed to calculate=2E This can be
+     * calculated from the othe=
r members of the struct but we store it
+     * in the struct for fast acce=
ss */
+    size_t num_siphash;
+
+    /** keys for the siphash functions */=

+    struct siphash_key *siphash_keys;
+
+    /** the actual buckets that =
hold the data */
+    bloom_counter_t buckets[];
+};
+
+
+struct bloom_filt=
er *
+bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc);
+
=
+bloom_counter_t
+bloom_test(struct bloom_filter *bf, const uint8_t *item, =
size_t len);
+
+bloom_counter_t
+bloom_add(struct bloom_filter *bf, const u=
int8_t *item, size_t len);
+
+bloom_counter_t
+bloom_remove(struct bloom_fi=
lter *bf, const uint8_t *item, size_t len);
+
+void
+bloom_clear(struct blo=
om_filter *bf);
+#endif /* ifndef BLOOM_H */
diff --git a/src/openvpn/mudp=
=2Ec b/src/openvpn/mudp=2Ec
index e98b6de=2E=2E01219b3 100644
--- a/src/ope=
nvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -33,6 +33,7 @@
 #include "memdb=
g=2Eh"
 #include "ssl_pkt=2Eh"
 #include "sid_hash=2Eh"
+#include "reflect_=
filter=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -12=
5,7 +126,7 @@
     {
         /* Check if we are still below our limit for =
sending out
          * responses */
-        if (!reflect_filter_rate_limi=
t_check(m->initial_rate_limiter))
+        if (!reflect_filter_check(m->ini=
tial_rate_limiter, from))
         {
             return PRE_DECRYPT_NO_ACT=
ION;
         }
@@ -264,9 +265,10 @@
 
         if (frequency_limit_event_a=
llowed(m->new_connection_limiter))
         {
+            struct link_sock=
et_actual *from =3D &m->top=2Ec2=2Efrom;
             /* a successful three=
-way handshake only counts against
              * connect-freq but not aga=
inst connect-freq-initial */
-            reflect_filter_rate_limit_decreas=
e(m->initial_rate_limiter);
+            reflect_filter_rate_limit_decrease=
(m->initial_rate_limiter, &from->dest);
 
             mi =3D multi_create_=
instance(m, real, sock);
             if (mi)
@@ -280,7 +282,7 @@
         =
        {
                     ASSERT(session_id_defined(&state=2Epeer_sess=
ion_id));
                     mi->context=2Ec2=2Etls_multi->n_sessions++;
=
-                    session_skip_to_pre_start(session, &state, &m->top=2Ec=
2=2Efrom);
+                    session_skip_to_pre_start(session, &state, =
from);
                 }
                 multi_hash_sid_add(m, &state=2Ep=
eer_session_id, mi);
             }
diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec
index 60e89fb=2E=2E9da921a 100644
--- a/src/openvpn/mul=
ti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -330,9 +330,12 @@
      * Limit frequ=
ency of incoming connections to control
      * DoS=2E
      */
-    m->new=
_connection_limiter =3D frequency_limit_init(t->options=2Ecf_max, t->option=
s=2Ecf_per);
-    m->initial_rate_limiter =3D
-        initial_rate_limit_i=
nit(t->options=2Ecf_initial_max, t->options=2Ecf_initial_per);
+    m->new_=
connection_limiter =3D frequency_limit_init(t->options=2Ecf_max,
+         =
                                            t->options=2Ecf_per);
+    m->i=
nitial_rate_limiter =3D initial_rate_limit_init(t->options=2Ecf_initial_max=
,
+                                                      t->options=2Ecf_in=
itial_per,
+                                                      &t->optio=
ns=2Einitial_cf_bloom_config);
+
 
     /*
      * Allocate broadcast/multi=
cast buffer list
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 629652e=2E=2E84dff0f 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -3291,6 +3291,23 @@
 }
 
 static void
+check_fil=
ter_tier_under_global_limit(struct filter_tier *ft, int limit,
+           =
                          const char *family)
+{
+    while (ft)
+    {
+  =
      if (ft->limit < limit)
+        {
+            msg(M_WARN, "Note: --c=
onnect-freq-initial-bloom-limit %s %d %d "
+                        "has a =
larger limit than connect-freq-limit-initial "
+                        "li=
mit (%d)=2E",
+                family, ft->netmask, ft->limit, limit);
+   =
     }
+        ft =3D ft->next;
+    }
+}
+
+static void
 options_postproc=
ess_verify(const struct options *o)
 {
     if (o->connection_list)
@@ -332=
5,6 +3342,18 @@
                         "Ignoring these options=2E");
    =
     }
     }
+
+    if ((bool)(o->initial_cf_bloom_config=2Einet_tiers)
+ =
           + (bool)(o->initial_cf_bloom_config=2Einet6_tiers)
+        =3D=
=3D 1)
+    {
+        msg(M_FATAL, "connect-freq-initial-bloom-limit must =
be provided for "
+                     "both inet and inet6");
+    }
+   =
 check_filter_tier_under_global_limit(o->initial_cf_bloom_config=2Einet_tie=
rs,
+                                         o->cf_initial_max, "inet");
+=
    check_filter_tier_under_global_limit(o->initial_cf_bloom_config=2Einet6=
_tiers,
+                                         o->cf_initial_max, "inet6=
");
 }
 
 static void
@@ -7420,6 +7449,73 @@
         options->cf_initial_m=
ax =3D cf_max;
         options->cf_initial_per =3D cf_per;
     }
+    els=
e if (streq(p[0], "connect-freq-initial-bloom-size") && p[1] && !p[3])
+   =
 {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+
+        int cf_bloom_size =
=3D atoi(p[1]);
+
+        if (cf_bloom_size <=3D 0)
+        {
+          =
  msg(msglevel, "--connect-freq-initial-bloom-size size must be > 0");
+   =
         goto err;
+        }
+        options->initial_cf_bloom_config=2Es=
ize =3D cf_bloom_size;
+        if (p[2])
+        {
+            int num_h=
ash =3D atoi(p[1]);
+            if (num_hash <=3D 0)
+            {
+     =
           msg(msglevel, "--connect-freq-initial-bloom-size number of hash =
"
+                              "functions must be > 0");
+               =
 goto err;
+            }
+            options->initial_cf_bloom_config=2En=
um_hashes =3D num_hash;
+        }
+    }
+    else if (streq(p[0], "connec=
t-freq-initial-bloom-limit") && p[1] && p[2]
+             && p[3] && !p[4]=
)
+    {
+        int netmask =3D atoi(p[2]);
+        int limit =3D atoi(p=
[3]);
+
+        if (limit <=3D 0)
+        {
+            msg(msglevel, "L=
imit parameter to %s must be > 0", p[0]);
+            goto err;
+        }=

+
+        if (streq(p[1], "inet"))
+        {
+            if (netmask < =
0 || netmask > 32)
+            {
+                msg(msglevel, "Netmask p=
arameter (%s) for IPv4 for %s must be "
+                              "bet=
ween 0 and 32",
+                    p[2], p[0]);
+                goto err=
;
+            }
+            reflect_add_filter_tier(&options->initial_cf_=
bloom_config,
+                                    &options->gc, false, net=
mask, limit);
+        }
+        else if (streq(p[1], "inet6"))
+        {=

+            if (netmask < 0 || netmask > 128)
+            {
+           =
     msg(msglevel, "Netmask parameter (%s) for IPv6 for %s must be "
+     =
                         "between 0 and 128",
+                    p[2], p[=
0]);
+                goto err;
+            }
+            reflect_add_fil=
ter_tier(&options->initial_cf_bloom_config,
+                              =
      &options->gc, true, netmask, limit);
+        }
+        else
+      =
  {
+            msg(msglevel, "Unknown parameter %s for %s=2E Must be inet=
 or inet6",
+                p[1], p[0]);
+            goto err;
+        }=

+    }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
 =
        VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh
index c7825c7=2E=2E644280a 100644
--- a/src/=
openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -42,6 +42,7 @@
 #inclu=
de "clinat=2Eh"
 #include "crypto_backend=2Eh"
 #include "dns=2Eh"
+#includ=
e "reflect_filter=2Eh"
 
 
 /*
@@ -533,6 +534,8 @@
     int cf_initial_max;=

     int cf_initial_per;
 
+    struct bloom_filter_conf initial_cf_bloom_=
config;
+
     uint32_t max_clients;
     int max_routes_per_client;
     i=
nt stale_routes_check_interval;
diff --git a/src/openvpn/ovpn_dco_linux=2Eh=
 b/src/openvpn/ovpn_dco_linux=2Eh
index b3c9ff0=2E=2E7366177 100644
--- a/s=
rc/openvpn/ovpn_dco_linux=2Eh
+++ b/src/openvpn/ovpn_dco_linux=2Eh
@@ -6,10=
5 +6,113 @@
 #ifndef _UAPI_LINUX_OVPN_H
 #define _UAPI_LINUX_OVPN_H
 
-#def=
ine OVPN_FAMILY_NAME	"ovpn"
-#define OVPN_FAMILY_VERSION	1
+#define OVPN_FA=
MILY_NAME    "ovpn"
+#define OVPN_FAMILY_VERSION 1
 
-#define OVPN_NONCE_TA=
IL_SIZE	8
+#define OVPN_NONCE_TAIL_SIZE 8
 
-enum ovpn_cipher_alg {
-	OVPN_=
CIPHER_ALG_NONE,
-	OVPN_CIPHER_ALG_AES_GCM,
-	OVPN_CIPHER_ALG_CHACHA20_POLY=
1305,
+enum ovpn_cipher_alg
+{
+    OVPN_CIPHER_ALG_NONE,
+    OVPN_CIPHER_=
ALG_AES_GCM,
+    OVPN_CIPHER_ALG_CHACHA20_POLY1305,
 };
 
-enum ovpn_del_p=
eer_reason {
-	OVPN_DEL_PEER_REASON_TEARDOWN,
-	OVPN_DEL_PEER_REASON_USERSP=
ACE,
-	OVPN_DEL_PEER_REASON_EXPIRED,
-	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR=
,
-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+enum ovpn_del_peer_reason
+=
{
+    OVPN_DEL_PEER_REASON_TEARDOWN,
+    OVPN_DEL_PEER_REASON_USERSPACE,
=
+    OVPN_DEL_PEER_REASON_EXPIRED,
+    OVPN_DEL_PEER_REASON_TRANSPORT_ERRO=
R,
+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
 };
 
-enum ovpn_key_slo=
t {
-	OVPN_KEY_SLOT_PRIMARY,
-	OVPN_KEY_SLOT_SECONDARY,
+enum ovpn_key_slot=

+{
+    OVPN_KEY_SLOT_PRIMARY,
+    OVPN_KEY_SLOT_SECONDARY,
 };
 
-enum {=

-	OVPN_A_PEER_ID =3D 1,
-	OVPN_A_PEER_REMOTE_IPV4,
-	OVPN_A_PEER_REMOTE_IP=
V6,
-	OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
-	OVPN_A_PEER_REMOTE_PORT,
-	OVPN_A=
_PEER_SOCKET,
-	OVPN_A_PEER_SOCKET_NETNSID,
-	OVPN_A_PEER_VPN_IPV4,
-	OVPN_=
A_PEER_VPN_IPV6,
-	OVPN_A_PEER_LOCAL_IPV4,
-	OVPN_A_PEER_LOCAL_IPV6,
-	OVPN=
_A_PEER_LOCAL_PORT,
-	OVPN_A_PEER_KEEPALIVE_INTERVAL,
-	OVPN_A_PEER_KEEPALI=
VE_TIMEOUT,
-	OVPN_A_PEER_DEL_REASON,
-	OVPN_A_PEER_VPN_RX_BYTES,
-	OVPN_A_=
PEER_VPN_TX_BYTES,
-	OVPN_A_PEER_VPN_RX_PACKETS,
-	OVPN_A_PEER_VPN_TX_PACKE=
TS,
-	OVPN_A_PEER_LINK_RX_BYTES,
-	OVPN_A_PEER_LINK_TX_BYTES,
-	OVPN_A_PEER=
_LINK_RX_PACKETS,
-	OVPN_A_PEER_LINK_TX_PACKETS,
+enum
+{
+    OVPN_A_PEER_=
ID =3D 1,
+    OVPN_A_PEER_REMOTE_IPV4,
+    OVPN_A_PEER_REMOTE_IPV6,
+    =
OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+    OVPN_A_PEER_REMOTE_PORT,
+    OVPN_A=
_PEER_SOCKET,
+    OVPN_A_PEER_SOCKET_NETNSID,
+    OVPN_A_PEER_VPN_IPV4,
+=
    OVPN_A_PEER_VPN_IPV6,
+    OVPN_A_PEER_LOCAL_IPV4,
+    OVPN_A_PEER_LOC=
AL_IPV6,
+    OVPN_A_PEER_LOCAL_PORT,
+    OVPN_A_PEER_KEEPALIVE_INTERVAL,
=
+    OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+    OVPN_A_PEER_DEL_REASON,
+    OVPN_=
A_PEER_VPN_RX_BYTES,
+    OVPN_A_PEER_VPN_TX_BYTES,
+    OVPN_A_PEER_VPN_RX=
_PACKETS,
+    OVPN_A_PEER_VPN_TX_PACKETS,
+    OVPN_A_PEER_LINK_RX_BYTES,
=
+    OVPN_A_PEER_LINK_TX_BYTES,
+    OVPN_A_PEER_LINK_RX_PACKETS,
+    OVPN=
_A_PEER_LINK_TX_PACKETS,
 
-	__OVPN_A_PEER_MAX,
-	OVPN_A_PEER_MAX =3D (__OV=
PN_A_PEER_MAX - 1)
+    __OVPN_A_PEER_MAX,
+    OVPN_A_PEER_MAX =3D (__OVPN=
_A_PEER_MAX - 1)
 };
 
-enum {
-	OVPN_A_KEYCONF_PEER_ID =3D 1,
-	OVPN_A_KEY=
CONF_SLOT,
-	OVPN_A_KEYCONF_KEY_ID,
-	OVPN_A_KEYCONF_CIPHER_ALG,
-	OVPN_A_K=
EYCONF_ENCRYPT_DIR,
-	OVPN_A_KEYCONF_DECRYPT_DIR,
+enum
+{
+    OVPN_A_KEYC=
ONF_PEER_ID =3D 1,
+    OVPN_A_KEYCONF_SLOT,
+    OVPN_A_KEYCONF_KEY_ID,
+ =
   OVPN_A_KEYCONF_CIPHER_ALG,
+    OVPN_A_KEYCONF_ENCRYPT_DIR,
+    OVPN_A_=
KEYCONF_DECRYPT_DIR,
 
-	__OVPN_A_KEYCONF_MAX,
-	OVPN_A_KEYCONF_MAX =3D (__=
OVPN_A_KEYCONF_MAX - 1)
+    __OVPN_A_KEYCONF_MAX,
+    OVPN_A_KEYCONF_MAX =
=3D (__OVPN_A_KEYCONF_MAX - 1)
 };
 
-enum {
-	OVPN_A_KEYDIR_CIPHER_KEY =3D=
 1,
-	OVPN_A_KEYDIR_NONCE_TAIL,
+enum
+{
+    OVPN_A_KEYDIR_CIPHER_KEY =3D =
1,
+    OVPN_A_KEYDIR_NONCE_TAIL,
 
-	__OVPN_A_KEYDIR_MAX,
-	OVPN_A_KEYDIR_=
MAX =3D (__OVPN_A_KEYDIR_MAX - 1)
+    __OVPN_A_KEYDIR_MAX,
+    OVPN_A_KEY=
DIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)
 };
 
-enum {
-	OVPN_A_IFINDEX =3D 1,=

-	OVPN_A_PEER,
-	OVPN_A_KEYCONF,
+enum
+{
+    OVPN_A_IFINDEX =3D 1,
+    =
OVPN_A_PEER,
+    OVPN_A_KEYCONF,
 
-	__OVPN_A_MAX,
-	OVPN_A_MAX =3D (__OVP=
N_A_MAX - 1)
+    __OVPN_A_MAX,
+    OVPN_A_MAX =3D (__OVPN_A_MAX - 1)
 };
=
 
-enum {
-	OVPN_CMD_PEER_NEW =3D 1,
-	OVPN_CMD_PEER_SET,
-	OVPN_CMD_PEER_G=
ET,
-	OVPN_CMD_PEER_DEL,
-	OVPN_CMD_PEER_DEL_NTF,
-	OVPN_CMD_KEY_NEW,
-	OVP=
N_CMD_KEY_GET,
-	OVPN_CMD_KEY_SWAP,
-	OVPN_CMD_KEY_SWAP_NTF,
-	OVPN_CMD_KEY=
_DEL,
-	OVPN_CMD_PEER_FLOAT_NTF,
+enum
+{
+    OVPN_CMD_PEER_NEW =3D 1,
+  =
  OVPN_CMD_PEER_SET,
+    OVPN_CMD_PEER_GET,
+    OVPN_CMD_PEER_DEL,
+    O=
VPN_CMD_PEER_DEL_NTF,
+    OVPN_CMD_KEY_NEW,
+    OVPN_CMD_KEY_GET,
+    OV=
PN_CMD_KEY_SWAP,
+    OVPN_CMD_KEY_SWAP_NTF,
+    OVPN_CMD_KEY_DEL,
+    OV=
PN_CMD_PEER_FLOAT_NTF,
 
-	__OVPN_CMD_MAX,
-	OVPN_CMD_MAX =3D (__OVPN_CMD_M=
AX - 1)
+    __OVPN_CMD_MAX,
+    OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)
 };=

 
-#define OVPN_MCGRP_PEERS	"peers"
+#define OVPN_MCGRP_PEERS "peers"
 
 #=
endif /* _UAPI_LINUX_OVPN_H */
diff --git a/src/openvpn/reflect_filter=2Ec =
b/src/openvpn/reflect_filter=2Ec
index e5226e4=2E=2Ef543a0f 100644
--- a/sr=
c/openvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filter=2Ec
@@ -5,7 +=
5,8 @@
  *             packet encryption, packet authentication, and
  *   =
          packet compression=2E
  *
- *  Copyright (C) 2022-2026 OpenVPN In=
c <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 OpenVPN Inc <sales@ope=
nvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne Schwabe <arne@rfc2549=2Eorg>
=
  *
  *  This program is free software; you can redistribute it and/or modi=
fy
  *  it under the terms of the GNU General Public License version 2
@@ -=
37,8 +38,7 @@
 #include "crypto=2Eh"
 #include "reflect_filter=2Eh"
 
-
-bo=
ol
+static bool
 reflect_filter_rate_limit_check(struct initial_packet_rate=
_limit *irl)
 {
     if (now > irl->last_period_reset + irl->period_length)=

@@ -73,34 +73,380 @@
     return !over_limit;
 }
 
-void
-reflect_filter_r=
ate_limit_decrease(struct initial_packet_rate_limit *irl)
+static void
+res=
et_filter_tier(struct initial_packet_rate_limit *irl,
+                  st=
ruct filter_tier *tier, const char *prefix)
 {
+    for (; tier !=3D NULL; =
tier =3D tier->next)
+    {
+        if (tier->dropped > 0)
+        {
+   =
         msg(D_TLS_DEBUG_LOW, "Dropped %zu initial handshake packets due to=
 "
+                                 "--connect-freq-initial-bloom-limit %s=
 %d %d",
+                tier->dropped, prefix, tier->netmask, tier->limit=
);
+            tier->dropped =3D 0;
+        }
+    }
+}
+
+static void
+b=
loom_filter_check_reset(struct initial_packet_rate_limit *irl)
+{
+    if (=
now > irl->last_period_reset + irl->period_length)
+    {
+        reset_fi=
lter_tier(irl, irl->bloom_conf=2Einet_tiers, "inet");
+        reset_filter=
_tier(irl, irl->bloom_conf=2Einet6_tiers, "inet6");
+
+        bloom_clear(=
irl->bf);
+    }
+}
+
+
+/**
+ * structure used as lookup key for the bloom=
 structure=2E We used the
+ * netmask as part of the structure to avoid the=
 look for the first
+ * IP of a subnet and the subnet to be same key=2E
+ *=
/
+struct bloom_filter_key
+{
+    union
+    {
+        struct in_addr in;=

+        struct in6_addr in6;
+    };
+    int netmask;
+    /* we keep th=
e count in the key instead of in the bloom filter table as
+     * can then=
 keep the counter in the bloom filter itself small (2 bits)
+     * and blo=
om filter usage is the same for 20000 request from the same IP
+     * (20k=
 entries with different count but same IP) and from 20000 random ips
+     =
* (20k entries with count 1 but different IP) */
+    int count;
+};
+
+sta=
tic inline struct bloom_filter_key
+filter_mask_inet6(struct openvpn_sockad=
dr *addr, int netmask)
+{
+    struct bloom_filter_key ret =3D { 0 };
+    =
ret=2Ein6 =3D addr->addr=2Ein6=2Esin6_addr;
+
+    int bits_to_clear =3D 12=
8 - netmask;
+    int bytes_to_clear =3D bits_to_clear / 8;
+    bits_to_cl=
ear =3D bits_to_clear % 8;
+
+    memset(&ret=2Ein6=2Es6_addr[15 - bytes_to=
_clear], 0x00, bytes_to_clear);
+
+    ret=2Ein6=2Es6_addr[15 - bytes_to_cl=
ear - 1] &=3D (0xff << bits_to_clear);
+
+    ret=2Enetmask =3D netmask;
+
=
+    return ret;
+}
+
+static inline struct bloom_filter_key
+filter_mask_i=
net(struct openvpn_sockaddr *addr, int netmask)
+{
+    struct bloom_filter=
_key ret =3D { 0 };
+    ret=2Ein =3D addr->addr=2Ein4=2Esin_addr;
+    ret=
=2Ein=2Es_addr &=3D htonl(0xffffffff << (32 - netmask));
+    ret=2Enetmask=
 =3D netmask;
+    return ret;
+}
+
+/* We use one function and an action a=
rgument to avoid repeating
+ * the code to iterate to the tiers and the cre=
ating the lookup
+ * keys */
+enum bloom_filter_action
+{
+    REFLECT_CHEC=
K,
+    REFLECT_INCREASE,
+    REFLECT_DECREASE,
+};
+
+static int
+reflect=
_lookup_bf_key(struct bloom_filter *bf, struct bloom_filter_key *key, int l=
imit)
+{
+    /* we do a lookup for 1,2,3, and 4 and the limit first
+     =
* and after that do regular binary search=2E This is meant to optimise
+   =
  * the common case where just a small number of requests are coming from
+=
     * each IP */
+    key->count =3D limit;
+    if (bloom_test(bf, (const=
 uint8_t *)key, sizeof(struct bloom_filter_key)) > 0)
+    {
+        retur=
n limit;
+    }
+
+    key->count =3D 4;
+    if (bloom_test(bf, (const uin=
t8_t *)key, sizeof(struct bloom_filter_key)) =3D=3D 0)
+    {
+        /* T=
he value for 4 has not been found, so the real value might be 1, 2, or 3=2E=
 */
+        for (int i =3D 3; i > 0; i--)
+        {
+            key->cou=
nt =3D i;
+            if (bloom_test(bf, (const uint8_t *)key, sizeof(stru=
ct bloom_filter_key)) > 0)
+            {
+                return i;
+     =
       }
+        }
+
+        /* 4 was no in the map and 1-3 are also not =
there, so assume the key is not in the map */
+        return 0;
+    }
+
+=
    int low =3D 3;
+    int high =3D limit;
+
+    while (low < high)
+    =
{
+        key->count =3D (high + low + 1) / 2;
+        bloom_counter_t co=
unt =3D bloom_test(bf, (const uint8_t *)key, sizeof(struct bloom_filter_key=
));
+        if (count > 0)
+        {
+            low =3D key->count;
+  =
      }
+        else
+        {
+            high =3D key->count - 1;
+   =
     }
+    }
+
+    if (low =3D=3D 4)
+    {
+        /* we reached the lo=
wer end of our binary search have not found the
+         * key and we know=
 that 4 is in the map */
+        return 4;
+    }
+    else
+    {
+      =
  return low;
+    }
+}
+
+/**
+ * Convert a mapped IPv6 mapped IPv4 addres=
s (::ffff:0:0/96) to an
+ * equivalent IPv4 adress=2E
+ *
+ * @note: This f=
unction only converts the IP itself and ignores other
+ * parts of the \c f=
rom structure like port or protocol=2E
+ */
+static struct openvpn_sockaddr=

+convert_mapped_inet_sockaddr(struct openvpn_sockaddr *from)
+{
+    struc=
t openvpn_sockaddr from_mapped =3D { 0 };
+    /* we ignore the fields like=
 port that the key in the bloom filter
+     * ignores too=2E This makes th=
is function non-generic */
+
+    from_mapped=2Eaddr=2Ein4=2Esin_family =3D=
 AF_INET;
+
+    memcpy(&from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_addr,
+   =
        &from->addr=2Ein6=2Esin6_addr=2Es6_addr[12],
+           sizeof(fro=
m_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_addr));
+
+    return from_mapped;
+}
=
+
+static bool
+bloom_filter_action(struct initial_packet_rate_limit *irl,
=
+                    struct openvpn_sockaddr *from,
+                    en=
um bloom_filter_action action)
+{
+    bool found =3D false;
+    struct fi=
lter_tier *tier =3D NULL;
+
+    struct openvpn_sockaddr from_mapped;
+
+  =
  if (from->addr=2Esa=2Esa_family =3D=3D AF_INET6
+        && IN6_IS_ADDR_V=
4MAPPED(&from->addr=2Ein6=2Esin6_addr))
+    {
+        from_mapped =3D con=
vert_mapped_inet_sockaddr(from);
+        from =3D &from_mapped;
+    }
+
+=
    if (from->addr=2Esa=2Esa_family =3D=3D AF_INET)
+    {
+        tier =
=3D irl->bloom_conf=2Einet_tiers;
+    }
+    else if (from->addr=2Esa=2Esa=
_family =3D=3D AF_INET6)
+    {
+        tier =3D irl->bloom_conf=2Einet6_t=
iers;
+    }
+
+    while (tier)
+    {
+        struct filter_tier *next_t=
ier =3D tier->next;
+        struct bloom_filter_key key;
+
+        if (fr=
om->addr=2Esa=2Esa_family =3D=3D AF_INET6)
+        {
+            key =3D =
filter_mask_inet6(from, tier->netmask);
+        }
+        else
+        {=

+            key =3D filter_mask_inet(from, tier->netmask);
+        }
+
+=
        /* fetch the current count of the key in the bloom filter */
+     =
   int result =3D reflect_lookup_bf_key(irl->bf, &key, tier->limit);
+     =
   struct gc_arena gc =3D gc_new();
+        gc_free(&gc);
+
+        switc=
h (action)
+        {
+            case REFLECT_CHECK:
+                if =
(result >=3D tier->limit)
+                {
+                    found =3D=
 true;
+                    tier->dropped++;
+                    if (tier-=
>dropped =3D=3D 1)
+                    {
+                        msg(M_WA=
RN, "Note: --connect-freq-initial-bloom-limit "
+                          =
          "limit for netmask /%d exceeded=2E Expect additional "
+         =
                           "initial packet drops for the next %d seconds",
=
+                            tier->netmask,
+                            (i=
nt)(irl->last_period_reset + irl->period_length - now));
+                 =
   }
+                }
+                break;
+
+            case REFLECT=
_INCREASE:
+                ASSERT(result < tier->limit);
+                =
key=2Ecount =3D result + 1;
+                bloom_add(irl->bf, (const uint=
8_t *)&key, sizeof(key));
+                break;
+
+            case REFLE=
CT_DECREASE:
+                key=2Ecount =3D result - 1;
+                =
bloom_remove(irl->bf, (const uint8_t *)&key, sizeof(key));
+               =
 break;
+        }
+
+        tier =3D next_tier;
+    }
+    if (!found &&=
 action =3D=3D REFLECT_CHECK)
+    {
+        /* We only want to increase t=
he counters if the IP is not already
+         * in the set=2E */
+        =
bloom_filter_action(irl, from, REFLECT_INCREASE);
+    }
+    return found;=

+}
+
+static bool
+bloom_filter_check(struct initial_packet_rate_limit *ir=
l,
+                   struct openvpn_sockaddr *from)
+{
+    if (now > irl=
->last_period_reset + irl->period_length)
+    {
+        bloom_filter_chec=
k_reset(irl);
+        bloom_clear(irl->bf);
+    }
+
+    return bloom_fil=
ter_action(irl, from, REFLECT_CHECK);
+}
+
+
+bool
+reflect_filter_check(st=
ruct initial_packet_rate_limit *irl,
+                     struct openvpn_s=
ockaddr *from)
+{
+    /* We are doing the bloom filter check first so pack=
ets that are already
+     * rejected by the bloom filter do not count agai=
nst the limit of the
+     * simple rate limiter */
+    if (irl->bf && blo=
om_filter_check(irl, from))
+    {
+        return false;
+    }
+
+    if =
(!reflect_filter_rate_limit_check(irl))
+    {
+        return false;
+    =
}
+
+    return true;
+}
+
+
+void
+reflect_filter_rate_limit_decrease(stru=
ct initial_packet_rate_limit *irl, struct openvpn_sockaddr *from)
+{
+    i=
f (irl->bf && bloom_filter_action(irl, from, REFLECT_CHECK))
+    {
+      =
  /* Only remove if it is actually present=2E This might be a packet
+     =
    * coming from an early period or be relayed */
+        bloom_filter_ac=
tion(irl, from, REFLECT_DECREASE);
+    }
+
     if (irl->curr_period_count=
er > 0)
     {
         irl->curr_period_counter--;
     }
 }
 
+void
+refl=
ect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_arena *gc,
=
+                        bool ipv6, int netmask, int limit)
+{
+    struct =
filter_tier *ftnew =3D gc_malloc(sizeof(struct filter_tier), true, gc);
+
+=
    ftnew->netmask =3D netmask;
+    ftnew->limit =3D limit;
+
+    if (ipv=
6)
+    {
+        ftnew->next =3D bfconf->inet6_tiers;
+        bfconf->in=
et6_tiers =3D ftnew;
+    }
+    else
+    {
+        ftnew->next =3D bfcon=
f->inet_tiers;
+        bfconf->inet_tiers =3D ftnew;
+    }
+}
+
+void
+in=
it_bloom_filter(struct initial_packet_rate_limit *irl)
+{
+    if (!irl->bl=
oom_conf=2Esize)
+    {
+        /* the default allocates 2MB for bloom fil=
ter entries */
+        irl->bloom_conf=2Esize =3D 1024ul * 1024 * 8;
+    =
}
+    if (!irl->bloom_conf=2Enum_hashes)
+    {
+        irl->bloom_conf=
=2Enum_hashes =3D 7;
+    }
+
+    irl->bf =3D bloom_create(irl->bloom_conf=
=2Esize, irl->bloom_conf=2Enum_hashes,
+                           &irl->gc=
);
+    bloom_clear(irl->bf);
+}
 
 struct initial_packet_rate_limit *
-ini=
tial_rate_limit_init(int max_per_period, int period_length)
+initial_rate_l=
imit_init(int max_per_period, int period_length,
+                        s=
truct bloom_filter_conf *bconf)
 {
-    struct initial_packet_rate_limit *i=
rl;
+    struct initial_packet_rate_limit *irl =3D NULL;
+    ALLOC_OBJ_CLE=
AR(irl, struct initial_packet_rate_limit);
 
-
-    ALLOC_OBJ(irl, struct i=
nitial_packet_rate_limit);
+    irl->gc =3D gc_new();
 
     irl->max_per_p=
eriod =3D max_per_period;
     irl->period_length =3D period_length;
     i=
rl->curr_period_counter =3D 0;
     irl->last_period_reset =3D 0;
 
+    if=
 (bconf)
+    {
+        irl->bloom_conf =3D *bconf;
+        init_bloom_fi=
lter(irl);
+    }
+
     return irl;
 }
 
 void
 initial_rate_limit_free(st=
ruct initial_packet_rate_limit *irl)
 {
+    gc_free(&irl->gc);
     free(i=
rl);
+    irl =3D NULL;
 }
diff --git a/src/openvpn/reflect_filter=2Eh b/sr=
c/openvpn/reflect_filter=2Eh
index 84915e8c6=2E=2Edcccbde 100644
--- a/src/=
openvpn/reflect_filter=2Eh
+++ b/src/openvpn/reflect_filter=2Eh
@@ -23,6 +2=
3,30 @@
 #define REFLECT_FILTER_H
 
 #include <limits=2Eh>
+#include "socke=
t=2Eh"
+#include "bloom=2Eh"
+
+struct filter_tier
+{
+    struct filter_ti=
er *next;
+
+    int limit;
+    int netmask;
+
+    /** The number of pack=
ets we dropped since we went over this limit */
+    size_t dropped;
+};
+
=
+struct bloom_filter_conf
+{
+    struct filter_tier *inet_tiers;
+    stru=
ct filter_tier *inet6_tiers;
+
+    /* Configuration of the bloom filter */=

+    size_t num_hashes;
+    size_t size;
+};
+
 
 /** struct that handles=
 all the rate limiting logic for initial
  * responses */
@@ -35,7 +59,7 @@=

     int period_length;
 
     /** Number of packets in the current period=
=2E We use int64_t here
-     * to avoid any potiential issues with overflo=
w */
+     * to avoid any potential issues with overflow */
     int64_t cu=
rr_period_counter;
 
     /* Last time we reset our timer */
@@ -44,29 +68,=
57 @@
     /* we want to warn once per period that packets are being starte=
d to
      * be dropped */
     bool warning_displayed;
+
+    struct bloom=
_filter_conf bloom_conf;
+    struct bloom_filter *bf;
+
+    /* gc_arena u=
sed for the various allocations by this struct */
+    struct gc_arena gc;
=
 };
 
+/**
+ * Adds a bloom filter tier to the bloom filter config=2E
+ */
=
+void
+reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_=
arena *gc,
+                        bool ipv6, int netmask, int limit);
 
 =
/**
  * checks if the connection is still allowed to connect under the rate=

  * limit=2E This also increases the internal counter at the same time
  *=
/
-bool reflect_filter_rate_limit_check(struct initial_packet_rate_limit *i=
rl);
+bool
+reflect_filter_check(struct initial_packet_rate_limit *irl,
+  =
                   struct openvpn_sockaddr *from);
+
 
 /**
  * decreases t=
he counter of initial packets seen, so connections that
  * successfully co=
mpleted the three-way handshake do not count against
  * the counter of ini=
tial connection attempts
  */
-void reflect_filter_rate_limit_decrease(stru=
ct initial_packet_rate_limit *irl);
+void
+reflect_filter_rate_limit_decrea=
se(struct initial_packet_rate_limit *irl,
+                                =
   struct openvpn_sockaddr *from);
 
 /**
  * allocate and initialize the i=
nitial-packet rate limiter structure
+ *
+ * Note: this function does not c=
opy bconf's contents=2E
  */
-struct initial_packet_rate_limit *initial_rat=
e_limit_init(int max_per_period, int period_length);
+struct initial_packet=
_rate_limit *
+initial_rate_limit_init(int max_per_period, int period_lengt=
h,
+                        struct bloom_filter_conf *bconf);
 
 /**
  * fr=
ee the initial-packet rate limiter structure
  */
 void initial_rate_limit_=
free(struct initial_packet_rate_limit *irl);
+
+/**
+ * Initialises the blo=
om filter with the configuration values of
+ * irl->bloom_conf
+ */
+void
+=
init_bloom_filter(struct initial_packet_rate_limit *irl);
 #endif /* ifndef=
 REFLECT_FILTER_H */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam
index 7a8915b=2E=2Eea0822c 100644
--=
- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam
@@ -19,6 +19,7 @@
 	pkt_testdriver \
 	provider_testdriver \
 =
	push_update_msg_testdriver \
+	reflect_testdriver \
 	socket_testdriver \
=
 	ssl_testdriver \
 	user_pass_testdriver
@@ -103,6 +104,7 @@
 	@TEST_CFLAG=
S@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl=
_testdriver_SOURCES =3D test_ssl=2Ec \
+	test_reflect=2Ec test_reflect=2Eh =
\
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	m=
ock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
diff --git a/tests/unit_te=
sts/openvpn/test_reflect=2Ec b/tests/unit_tests/openvpn/test_reflect=2Ec
ne=
w file mode 100644
index 0000000=2E=2Ed0d11c6
--- /dev/null
+++ b/tests/uni=
t_tests/openvpn/test_reflect=2Ec
@@ -0,0 +1,293 @@
+/*
+ *  OpenVPN -- An a=
pplication to securely tunnel IP networks
+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based
+ *             session authentic=
ation and key exchange,
+ *             packet encryption, packet authentic=
ation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 200=
2-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free soft=
ware; you can redistribute it and/or modify
+ *  it under the terms of the =
GNU General Public License version 2
+ *  as published by the Free Software=
 Foundation=2E
+ *
+ *  This program is distributed in the hope that it wil=
l be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warran=
ty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
=
+ *  GNU General Public License for more details=2E
+ *
+ *  You should hav=
e received a copy of the GNU General Public License along
+ *  with this pr=
ogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HA=
VE_CONFIG_H
+#include "config=2Eh"
+#elif defined(_MSC_VER)
+#include "conf=
ig-msvc=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "bloom=2Eh"
+#in=
clude "buffer=2Eh"
+#include "reflect_filter=2Eh"
+#include "test_common=2E=
h"
+
+#include <setjmp=2Eh>
+#include <stdarg=2Eh>
+#include <cmocka=2Eh>
+=

+#include <stdio=2Eh>
+
+static_assert(BLOOM_FILTER_BITS_COUNT =3D=3D 4, "=
unit test not in sync");
+static_assert(BLOOM_FILTER_BITS_MASK =3D=3D 0xf, =
"unit test not in sync");
+
+void
+test_bloom(void **state)
+{
+    static =
const int present_mod =3D 77;
+
+    struct gc_arena gc =3D gc_new();
+    =
/* Use a bloom filter with 1M entries (256kB) for the unit test */
+    str=
uct bloom_filter *bf =3D bloom_create(1024ul * 1024, 8, &gc);
+
+    for (i=
nt32_t i =3D 0; i < 20000; i +=3D present_mod)
+    {
+        bloom_add(bf=
, (const uint8_t *)&i, sizeof(i));
+    }
+
+    /* all these should be pos=
itive, for the small unit test we do not expect
+     * false positive */
+=
    for (int32_t i =3D 0; i < 20000; i++)
+    {
+        int present =3D (=
i % present_mod =3D=3D 0) ? 1 : 0;
+        /* cast to bool to only get 1 a=
nd 0 for present/not present and not */
+        assert_int_equal((bool)blo=
om_test(bf, (const uint8_t *)&i, sizeof(i)), present);
+    }
+
+    gc_fre=
e(&gc);
+}
+
+void
+test_reflect_ddos(void **state)
+{
+    /* This tests i=
f the bloom filter implementation does actually work with
+     * the goal =
of dropping packets to a reflected /24 while still allowing
+     * other c=
lients */
+
+    /* Disable the normal fallback that puts a hard cap on the=
 reflection filter */
+    struct initial_packet_rate_limit *irl =3D initia=
l_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl-=
>bloom_conf, &irl->gc, false, 24, 5);
+    reflect_add_filter_tier(&irl->bl=
oom_conf, &irl->gc, false, 8, 20);
+    init_bloom_filter(irl);
+
+    int =
num_legimate_reject =3D 0;
+    int num_legimate_accepted =3D 0;
+
+    int=
 num_ddos_rejected =3D 0;
+    int num_ddos_accepted =3D 0;
+
+
+    /* /24=
 net addresses in host byte order */
+    in_addr_t net_attack[4];
+    for=
 (int i =3D 0; i < 3; i++)
+    {
+        net_attack[i] =3D random() % 0xf=
f;
+    }
+
+    /* The 4th network is close enough to the 3rd to fall in t=
he same /16 */
+    /* XOR the 3rd byte to achieve this */
+    net_attack[=
3] =3D net_attack[2] ^ 00002300;
+
+    /* Assume 200000 packets, including=
 roughly 200 legitimate packets,
+     * the unit test works also with 20 m=
illions packet but takes too long*/
+    static const int total_packets =3D=
 200 * 1000;
+
+    for (int i =3D 0; i < total_packets; i++)
+    {
+     =
   struct openvpn_sockaddr from =3D { 0 };
+        from=2Eaddr=2Ein4=2Esin=
_family =3D AF_INET;
+        from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in=
_addr_t)random();
+        from=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)rando=
m();
+
+        if (i % 1023 =3D=3D 0)
+        {
+            /* roughly 2=
00 legitimate clients with random addresses */
+            from=2Eaddr=2Ei=
n4=2Esin_addr=2Es_addr =3D (in_addr_t)random();
+
+            bool allowed=
 =3D reflect_filter_check(irl, &from);
+            if (allowed)
+         =
   {
+                num_legimate_accepted++;
+            }
+            =
else
+            {
+                num_legimate_reject++;
+            }
=
+        }
+        else
+        {
+            /* We attack the 4 network=
s at random */
+            from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_a=
ddr_t)(net_attack[random() % 4] + (random() % 256));
+
+            bool al=
lowed =3D reflect_filter_check(irl, &from);
+            if (allowed)
+    =
        {
+                num_ddos_accepted++;
+            }
+           =
 else
+            {
+                num_ddos_rejected++;
+            }
+=
        }
+    }
+
+    assert_int_equal(num_legimate_reject + num_legimate=
_accepted + num_ddos_accepted + num_ddos_rejected, total_packets);
+
+    /=
* We assume that most legitimate made it through but a few were unfortunate=
 to be in an attacked network */
+    assert_int_in_range(num_legimate_reje=
ct, 0, 10);
+
+    /* We disabled total number of packets, so we expect all=
 /8 to have their
+     * 20 packets, which is 5120=2E */
+    assert_int_i=
n_range(num_ddos_accepted, 0, 256 * 20);
+
+    initial_rate_limit_free(irl=
);
+}
+
+
+void
+test_bloom_minimal(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    struct bloom_filter *bf =3D bloom_create(2048, 3, &gc)=
;
+
+    int item =3D 0xbabe;
+
+    bloom_add(bf, (const uint8_t *)&item, =
sizeof(item));
+    assert_int_equal(bloom_test(bf, (const uint8_t *)&item,=
 sizeof(item)), 1);
+
+    item =3D 0xf00f;
+    assert_int_equal(bloom_tes=
t(bf, (const uint8_t *)&item, sizeof(item)), 0);
+
+    gc_free(&gc);
+}
+
=
+void
+test_reflect_reflect_bloom_simple(void **state)
+{
+    struct initi=
al_packet_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);
=
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 32, 50);
+=
    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 56, 200);
+  =
  init_bloom_filter(irl);
+
+    struct openvpn_sockaddr from =3D { 0 };
+ =
   from=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;
+    from=2Eaddr=2Ein6=2Es=
in6_port =3D (uint16_t)random();
+    from=2Eaddr=2Ein6=2Esin6_addr=2Es6_ad=
dr[15] =3D 1; /* ::1 */
+
+    /* There are 50 attempts that should work un=
til one fails */
+    for (int i =3D 0; i < 50; i++)
+    {
+        assert=
_true(reflect_filter_check(irl, &from));
+    }
+
+    /* 2002::1 */
+    s=
truct openvpn_sockaddr from2 =3D from;
+    from2=2Eaddr=2Ein6=2Esin6_addr=
=2Es6_addr[0] =3D 0x7;
+    from2=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[1] =3D=
 0x7;
+
+    assert_true(reflect_filter_check(irl, &from2));
+
+    /* Any =
more attempts from ::1 should fail */
+    assert_false(reflect_filter_chec=
k(irl, &from));
+
+    initial_rate_limit_free(irl);
+}
+
+void
+test_refle=
ct_bloom_netmask_masking(void **state)
+{
+    struct initial_packet_rate_l=
imit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_a=
dd_filter_tier(&irl->bloom_conf, &irl->gc, true, 45, 10);
+    init_bloom_f=
ilter(irl);
+
+    struct openvpn_sockaddr from =3D { 0 };
+    from=2Eaddr=
=2Ein6=2Esin6_family =3D AF_INET6;
+    from=2Eaddr=2Ein6=2Esin6_port =3D (=
uint16_t)random();
+    for (int i =3D 0; i < 15; i++)
+    {
+        from=
=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[i] =3D (uint8_t)random();
+    }
+
+   =
 for (int i =3D 0; i < 10; i++)
+    {
+        /* /45 means that if we lea=
ve the leave first 8 bytes and 5 bits
+         * untouched, it is still th=
e same subnet  */
+        for (int j =3D 8; j < 15; j++)
+        {
+     =
       from=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[j] =3D (uint8_t)random();
+ =
           from=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[7] ^=3D (uint8_t)(random=
() & 0x7);
+        }
+        assert_true(reflect_filter_check(irl, &from)=
);
+    }
+
+    /* testing the last IP again should give us a negative res=
ult */
+    assert_false(reflect_filter_check(irl, &from));
+
+    initial_=
rate_limit_free(irl);
+}
+
+
+void
+test_reflect_reflect_bloom_mapped(void =
**state)
+{
+    struct initial_packet_rate_limit *irl =3D initial_rate_lim=
it_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_con=
f, &irl->gc, false, 24, 50);
+    reflect_add_filter_tier(&irl->bloom_conf,=
 &irl->gc, false, 8, 80);
+    init_bloom_filter(irl);
+
+    /* Our OpenVP=
N server will not receive IPv4 as well as IPv4 mapped
+     * addresses in =
the same process but for the unit test it is convient
+     * to see if the=
y actually mapped to the same entries */
+
+    struct openvpn_sockaddr map=
ped_v4 =3D { 0 };
+    mapped_v4=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;
+=
    mapped_v4=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();
+    /* ::ff=
ff:192=2E168=2E0=2E99 */
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[=
10] =3D 0xff;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[11] =3D 0xf=
f;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[12] =3D 192;
+    mapp=
ed_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[13] =3D 168;
+    mapped_v4=2Eaddr=
=2Ein6=2Esin6_addr=2Es6_addr[14] =3D 0;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_=
addr=2Es6_addr[15] =3D 99;
+
+    assert_true(IN6_IS_ADDR_V4MAPPED(&mapped_=
v4=2Eaddr=2Ein6=2Esin6_addr));
+
+    /* Not the same address but in the sa=
me /8 */
+    struct openvpn_sockaddr v4addr =3D { 0 };
+    v4addr=2Eaddr=
=2Ein4=2Esin_family =3D AF_INET;
+    v4addr=2Eaddr=2Ein4=2Esin_port =3D (u=
int16_t)random();
+    /* 192=2E168=2E123=2E244 */
+    v4addr=2Eaddr=2Ein4=
=2Esin_addr=2Es_addr =3D htonl(0xc0a87bf4);
+
+    /* check that we run int=
o the 50 limit with our mapped address */
+    for (int i =3D 0; i < 50; i+=
+)
+    {
+        assert_true(reflect_filter_check(irl, &mapped_v4));
+   =
 }
+    assert_false(reflect_filter_check(irl, &mapped_v4));
+
+
+    /* Ch=
eck that the non-mapped IPv4 address uses the same /8 subnet limit */
+    =
for (int i =3D 0; i < 30; i++)
+    {
+        assert_true(reflect_filter_c=
heck(irl, &v4addr));
+    }
+    assert_false(reflect_filter_check(irl, &v4=
addr));
+
+    initial_rate_limit_free(irl);
+}
\ No newline at end of file=

diff --git a/tests/unit_tests/openvpn/test_reflect=2Eh b/tests/unit_tests/=
openvpn/test_reflect=2Eh
new file mode 100644
index 0000000=2E=2E0dc1e4c
--=
- /dev/null
+++ b/tests/unit_tests/openvpn/test_reflect=2Eh
@@ -0,0 +1,37 @=
@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *    =
         over a single TCP/UDP port, with support for SSL/TLS-based
+ *    =
         session authentication and key exchange,
+ *             packet en=
cryption, packet authentication, and
+ *             packet compression=2E
=
+ *
+ *  Copyright (C) 2023-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Cop=
yright (C) 2023-2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This progra=
m is free software; you can redistribute it and/or modify
+ *  it under the=
 terms of the GNU General Public License version 2
+ *  as published by the=
 Free Software Foundation=2E
+ *
+ *  This program is distributed in the ho=
pe that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the =
implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  =
You should have received a copy of the GNU General Public License along
+ *=
  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ *=
/
+
+#ifndef TEST_REFLECT_H
+#define TEST_REFLECT_H
+void test_reflect_ddos=
(void **state);
+
+void test_bloom(void **state);
+
+void test_bloom_minima=
l(void **state);
+
+void test_reflect_reflect_bloom_simple(void **state);
+=

+void test_reflect_bloom_netmask_masking(void **state);
+
+void test_refle=
ct_reflect_bloom_mapped(void **state);
+#endif
\ No newline at end of file
=
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openv=
pn/test_ssl=2Ec
index cb9c480=2E=2Ec03c422 100644
--- a/tests/unit_tests/op=
envpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -51,6 +51=
,7 @@
 #include "ssl_util=2Eh"
 #include "ssl_verify=2Eh"
 #include "openvp=
n=2Eh"
+#include "test_reflect=2Eh"
 
 /* Mock function to be allowed to in=
clude win32=2Ec which is required for
  * getting the temp directory */
@@ =
-973,8 +974,13 @@
         cmocka_unit_test(test_data_channel_known_vectors=
_epoch),
         cmocka_unit_test(test_data_channel_known_vectors_shortpkt=
id),
         cmocka_unit_test(crypto_test_print_cert_details),
-        cm=
ocka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_test(ssl_=
test_extract_peer_info),
+        cmocka_unit_test(test_bloom),
+        cm=
ocka_unit_test(test_bloom_minimal),
+        cmocka_unit_test(test_reflect_=
reflect_bloom_simple),
+        cmocka_unit_test(test_reflect_reflect_bloom=
_mapped),
+        cmocka_unit_test(test_reflect_bloom_netmask_masking),
+ =
       cmocka_unit_test(test_reflect_ddos)
     };
 
 #if defined(ENABLE_CR=
YPTO_OPENSSL)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/30?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a92=
74cab7fefce3b13c05052fb9a072e0bfa6b9
Gerrit-Change-Number: 30
Gerrit-PatchS=
et: 10
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: MaxF <max@=
max-fillinger=2Enet>

--QVLs/fa+1E0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld, plaisthos=2E </p>
<p>plaisthos <s=
trong>uploaded patch set #10</strong> to this change=2E</p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail">View Change</a></p>=
<p>The following approvals got outdated and were removed:
Code-Review-1 by =
MaxF</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Implement initial packet reflection protection using =
bloom filter<br><br>When an OpenVPN server is used/tried to be usedc in a r=
eflection attack<br>the protection with the simple --connect-freq-initial a=
lso block legimitate<br>client from other networks that are not attacked by=
 a reflection attack=2E<br><br>To allow a server to still reply to these cl=
ients, we need to make the counts<br>rather more detailed and count per sub=
net or IP address=2E On the other hand<br>when we keep all this state, we e=
liminate the advantage of having a stateless<br>cookie based initial packet=
 handshake=2E<br><br>As compromoise we use a bloom filter to store the info=
rmation=2E This data<br>structure is probabilistic and can have false posit=
ive and more packets<br>being dropped but since it is a constant size and t=
he size of this map<br>is small enough for non-embedded systems (tests were=
 done with a 2MB<br>bloom filter), it is a good compromise=2E<br><br>The co=
de is split into the bloom filter implementation and the actual logic<br>im=
plementing tracking the subnets, so the bloom filter should be relatively<b=
r>easily be exchangable by another data structure=2E<br><br>As hash funtion=
 SIPHASH has been chosen since it was designed for this kind<br>of applicat=
ion=2E<br><br>Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9<br>Signe=
d-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M =2Egithub/wor=
kflows/build=2Eyaml<br>M CMakeLists=2Etxt<br>M Changes=2Erst<br>M doc/man-s=
ections/server-options=2Erst<br>M src/openvpn/Makefile=2Eam<br>A src/openvp=
n/bloom=2Ec<br>A src/openvpn/bloom=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/o=
penvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<=
br>M src/openvpn/ovpn_dco_linux=2Eh<br>M src/openvpn/reflect_filter=2Ec<br>=
M src/openvpn/reflect_filter=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Ea=
m<br>A tests/unit_tests/openvpn/test_reflect=2Ec<br>A tests/unit_tests/open=
vpn/test_reflect=2Eh<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>18 files=
 changed, 1,431 insertions(+), 98 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/30/10</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/b=
uild=2Eyaml</span><br><span>index 29e8be2a=2E=2Ea018e52 100644</span><br><s=
pan>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/=
workflows/build=2Eyaml</span><br><span>@@ -155,6 +155,9 @@</span><br><span>=
         env:</span><br><span>           srcdir: &quot;${{ github=2Eworkspa=
ce }}/tests/unit_tests/openvpn&quot;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      - name: Run reflect unit test</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: =2E/unittes=
ts/test_reflect=2Eexe</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>   ubuntu:</span><br><span>     strategy:</span><br><spa=
n>       fail-fast: false</span><br><span>diff --git a/CMakeLists=2Etxt b/C=
MakeLists=2Etxt</span><br><span>index 3eb0062=2E=2Efd8dda1 100644</span><br=
><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span>=
<br><span>@@ -429,6 +429,7 @@</span><br><span>     src/openvpn/base64=2Ec</=
span><br><span>     src/openvpn/base64=2Eh</span><br><span>     src/openvpn=
/basic=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/bloom=2Ec</span><br><span>     src/openvpn/buffer=2Ec</span><br><spa=
n>     src/openvpn/buffer=2Eh</span><br><span>     src/openvpn/circ_list=2E=
h</span><br><span>@@ -802,8 +803,11 @@</span><br><span>             tests/u=
nit_tests/openvpn/mock_management=2Ec</span><br><span>             tests/un=
it_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>             tes=
ts/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/test_reflect=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tes=
ts/unit_tests/openvpn/test_reflect=2Eh</span><br><span>             src/ope=
nvpn/argv=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/bloom=
=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br><s=
pan>             src/openvpn/crypto_mbedtls=2Ec</span><br><span>           =
  src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -815,7 +819,11 @@</span=
><br><span>             src/openvpn/options_util=2Ec</span><br><span>      =
       src/openvpn/otime=2Ec</span><br><span>             src/openvpn/packe=
t_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 src/openvpn/reflect_filter=2Ec</span><br><span>             src/openvpn/ru=
n_command=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      src/openvpn/siphash=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            src/openvpn/siphash=2Eh</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            src/openvpn/siphash_reference=2Ec</sp=
an><br><span>             src/openvpn/ssl_mbedtls=2Ec</span><br><span>     =
        src/openvpn/ssl_openssl=2Ec</span><br><span>             src/openvp=
n/ssl_util=2Ec</span><br><span>diff --git a/Changes=2Erst b/Changes=2Erst</=
span><br><span>index 1f992b2=2E=2E5ffd8c4 100644</span><br><span>--- a/Chan=
ges=2Erst</span><br><span>+++ b/Changes=2Erst</span><br><span>@@ -120,6 +12=
0,13 @@</span><br><span>     For more details see</span><br><span>     `lwi=
povpn on Github &lt;https://github=2Ecom/OpenVPN/lwipovpn&gt;`_=2E</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Bloom filt=
er based reflection protection</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    To avoid the limitation of ``--connect-freq-initial`` to blo=
ck legimitate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cl=
ients when an OpenVPN server is tried to be used in a reflection attack,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    the new ``--connec=
t-freq-initial-bloom-limit`` can impose limit on a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    per-subnet basis=2E See the manual for m=
ore details=2E Note: this option</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    requires 2MB of extra memory in the default configuration=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> Allow overriding username with ``--override-username``</span><br><span>  =
   This is intended to allow using ``--auth-gen-token`` in scenarios where =
the</span><br><span>     clients use certificates and multi-factor authenti=
cation=2E  This will</span><br><span>diff --git a/doc/man-sections/server-o=
ptions=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index =
f420588=2E=2Efa9583a 100644</span><br><span>--- a/doc/man-sections/server-o=
ptions=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</s=
pan><br><span>@@ -226,6 +226,77 @@</span><br><span>   will not be counted a=
gainst the limit=2E The default is to allow</span><br><span>   100 initial =
connection per 10s=2E</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+--connect-freq-initial-bloom-size args</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   Valid syntax:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
 ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      connect-freq-initial-bloom-si=
ze size [numhashes]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Configures the s=
ize of the bloom filter used for the initial connection</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+   packet responses=2E See `--connect-f=
req-initial-bloom-limit` for a full</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+   description of the feature=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   Bloom filters are probabilistic by their nature and the larger=
 the size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   of the =
bloom filter is, the more accurate they are=2E This option configures</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+   the number of buckets =
in the bloom filter=2E Each bucket takes up 4 bits=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   E=2Eg=2E the default of  8336608 (8 * =
2^20) when the option is not set</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   will require 2MB of memory=2E The numhashes will control th=
e number of hash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
functions that are used for the bloom filter=2E The default is 7=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+--connect-freq-initial-bloom-limit arg</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   Valid syntax:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+   ::</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      c=
onnect-freq-initial-bloom-limit inet netmask limit</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      connect-freq-initial-bloom-limit inet6=
 netmask limit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+   This option implement=
s a rate limiting function for initial packet like</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   ``--connect-freq-initial`` but takes the =
source of the initial packet into</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+   account=2E This function shares the the reset after a time=
 period and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   enabl=
ing this function will not disable the overall limit of</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+   ``--conect-freq-initial``=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   To avoid resource exhaustion on the OpenVPN=
 server side from reflection</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+   attacks and also trying to avoid blocking legitimate clients wh=
en an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   attacker tr=
ies to use an OpenVPN server, the limits are not applied globally</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   but rather a per netmask g=
ranularity=2E Each line of this command configures</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   a separate granularity=2E As example, the=
 following configuration,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ::</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        connect-freq-initial 1000 60</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        connect-freq-initial-=
bloom-limit inet 24 50</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        connect-freq-initial-bloom-limit inet 8 100</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        connect-freq-initial-bloom-limit=
 inet6 56 50</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 connect-freq-initial-bloom-limit inet6 32 100</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    will limit the number of (unanswered) replies per /24 network t=
o 50</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packets=2E =
After 50 packets from the same /24, the server will</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    drop any further packets=2E Similarly=
, if a /16 network receives more than</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    100 connection requests, the server will drop further=
 packets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    If t=
he count of all packets exceeds 1000, further packets will be</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    completely dropped regardless=
 of their origin=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The implementati=
on uses a counting bloom filter to store information of how</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+   many packets the server has seen=
 per subnet=2E A bloom filter is a</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   probabilistic data structure can yield false positives=2E=
 In this case, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
  server will drop packets even though the limit</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   for that particular subnet is not yet reach=
ed=2E Since we are using a</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+   counting bloom filter, a reply from a client that triggers a remo=
val of an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   entry c=
an also lead to a false negative=2E However, this is limited in the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   sense a reply can at mos=
t trigger one false negative=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Ever=
y limit configured with this option will put more more entries into</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   the bloomfilter since pe=
r limit (per family), one entry is put into the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+   bloom filter=2E So a large number of entries=
 requires a larger bloom filter</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   to avoid too many false positives=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   IPv6 mapped IPv4 addresses (::ffff:0:0/96) are treated as=
 IPv4 addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   f=
or these limits=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> --duplicate-cn</span><br><span>   Allow multiple clients w=
ith the same common name to concurrently</span><br><span>   connect=2E In t=
he absence of this option, OpenVPN will disconnect a client</span><br><span=
>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><=
br><span>index eb3533c=2E=2Ef85ed42 100644</span><br><span>--- a/src/openvp=
n/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><=
span>@@ -46,6 +46,7 @@</span><br><span> 	auth_token=2Ec auth_token=2Eh \</s=
pan><br><span> 	base64=2Ec base64=2Eh \</span><br><span> 	basic=2Eh \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	bloom=2Ec bloom=2Eh \</s=
pan><br><span> 	buffer=2Ec buffer=2Eh \</span><br><span> 	circ_list=2Eh \</=
span><br><span> 	clinat=2Ec clinat=2Eh \</span><br><span>diff --git a/src/o=
penvpn/bloom=2Ec b/src/openvpn/bloom=2Ec</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2Efabb7ad</span><br><span>--- /dev/null=
</span><br><span>+++ b/src/openvpn/bloom=2Ec</span><br><span>@@ -0,0 +1,248=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             over a single TCP/UDP port, with support for SSL/TLS=
-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  session authentication and key exchange,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet encryption, packet authenticat=
ion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrig=
ht (C) 2023-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is free software; you can redistribute it and/or modify</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the=
 GNU General Public License version 2</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* This file implements a=
 specialised counting bloom filter implementation</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * used in OpenVPN to mitigate it being used =
in reflection attacks=2E The bloom</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * implementation should be general enough to be used in oth=
er contexts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * howev=
er */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MSC_V=
ER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
onfig-msvc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;stdint=2Eh&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;bloom=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static size_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+calc_ceil_log2(size_t num)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Figure out how many bits we have in our hash =
by doing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ceil=
(log2(bf-&gt;size) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t numbit=
s =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (=
num &gt;&gt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        numbits=
++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return numbits;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calcu=
late number of bytes needed for each hash function in the bloom filter</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline size_t</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+calculate_num_bytes_hashfun(size_t size)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    size_t hash_bits =3D calc_ceil_log2(size);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* round up to the nea=
rest byte size */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t hash_bytes =3D (hash_bits + 7) / 8;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return hash_bytes;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A bloom filter uses a =
number of hashes to perform its functionality=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Instead of using the same number of siphash function we spli=
t the bytes of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * th=
e siphash to the different hashes=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * We could also optimise this further by splitting at the bit level but th=
at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * crates a lot o=
f extra code for bit shifting, etc=2E so we waste some bits</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param bf</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param num_hashes</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+calculate_num_sip_has=
h_hashes(struct bloom_filter *bf)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
size_t hash_bytes =3D calculate_num_bytes_hashfun(bf-&gt;size);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t total_bytes =3D bf-&=
gt;num_hashes * hash_bytes;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Roun=
d up to next SIPHASH_HASH_SIZE */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t num_siphash =3D (total_bytes + BLOOM_HASH_SIZE - 1=
) / BLOOM_HASH_SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return num_sip=
hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Calculates the number of bytes we need for storing a bloom filte=
r of size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * size=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline si=
ze_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_get_filte=
r_byte_count(size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t b=
its_required =3D size * BLOOM_FILTER_BITS_COUNT;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Add 7 round up to the next byte */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (bits_require=
d + 7) / 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline size_t</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bloom_get_filter_bit_offset(size_t bucket)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return (bucket * BLOOM_FILTER_BITS_COUNT) % (8 * sizeo=
f(bloom_counter_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bloom_get_filter_array_index(size_t=
 bucket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return (bucket * BLOOM_FI=
LTER_BITS_COUNT) / (8 * sizeof(bloom_counter_t));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline bloom_counter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bloom_get_filter_get_counter(struct bloom_filter *bf, size_t bucket)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static_assert((BLOOM_FILTER_BITS_MASK=
 + 1) =3D=3D (1 &lt;&lt; BLOOM_FILTER_BITS_COUNT),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                  &quot;BLOOM_FILTER_BITMASK=
 and BLOOM_FILTER_BIT_COUNT are inconsistent&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bloom_counter_t counter =3D bf-&gt;buckets[bloom_get_fil=
ter_array_index(bucket)];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    size_t bitoffset =3D bloom_get_filter_bit_offset(bucket);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return (counter &gt;&gt; bitoffset) &amp; =
BLOOM_FILTER_BITS_MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bloom_set_filter_counter(struct bl=
oom_filter *bf, size_t bucket, bloom_counter_t value)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bloom_counter_t data =3D bf-&gt;buckets[bloom_get_filte=
r_array_index(bucket)];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    size_t bitoffset =3D bloom_get_filter_bit_offset(bucket);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    data =3D data &amp; ~(BLOOM_FILTER_BITS_MASK=
 &lt;&lt; bitoffset);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    data =3D data=
 | ((value &amp; BLOOM_FILTER_BITS_MASK) &lt;&lt; bitoffset);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bf-&gt;buckets[bloom_get_filter_array_index(buck=
et)] =3D data;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Creates a new bloom filter structure</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param size the number of buckets=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return  the =
newly created bloom filter structure</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct bloom_filter *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t bloomfilter_bytes =3D bloom_get_f=
ilter_byte_count(size);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct bloom_filter *bf =3D gc_malloc(sizeof(struct bloom_filter) +=
 bloomfilter_bytes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                        false, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;size =3D size;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;num_hashes =3D num_hashe=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;hash_bytes =3D calculate_=
num_bytes_hashfun(size);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bf-&gt;num_siphash =3D calculate_num_sip_hash_hashes(bf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_GC(bf-&gt;siphash_keys, struct =
siphash_key, bf-&gt;num_siphash, gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bloom_clear(bf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return bf;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Clear the bloom filter, making it em=
pty again as if it were freshly created</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param bf the bloom structure to clear</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bloom_clear(struct bloom_filter *bf)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    memset(bf-&gt;buckets, 0, bloom_get_filter_byte_count(bf-&gt;=
size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* We randomise the bloom f=
ilter keys on every clear of the bloom filter</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * to avoid scenarios where an attacker might=
 learn specific pattern</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * that could exploit false positives in the bloom filter */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i=
 &lt; bf-&gt;num_siphash; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     prng_bytes(bf-&gt;siphash_keys[i]=2Ekey, SIPHASH_KEY_SIZE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bloom_counter_t</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_add_test(struct =
bloom_filter *bf, const uint8_t *item, size_t len, bloom_counter_t inc)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t result[BLOOM_HASH_SIZE];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t j =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t idx =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t re=
t =3D bloom_counter_max;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_=
t i =3D 0; i &lt; bf-&gt;num_hashes; i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        size_t bucket =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        for (size_t k =3D 0; k &lt; bf-&gt;hash_bytes; k++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (idx =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* We ha=
ve no longer unused bytes in result, generate the next hash */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                siphash(item, le=
n, bf-&gt;siphash_keys[j++]=2Ekey, result, BLOOM_HASH_SIZE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            bucket =3D bucket &lt;&lt; 8;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            bucket |=3D result[idx];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            idx =3D (idx + 1) % BLOOM_H=
ASH_SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        bucket =3D bucket % bf-&gt;size=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bloom_coun=
ter_t value =3D bloom_get_filter_get_counter(bf, bucket);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ret =3D min_bloom_counter(ret, value);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (inc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            value =3D min_bloom_counter(bloom_counter_max, va=
lue + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  bloom_set_filter_counter(bf, bucket, value);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bloom_add(struct bloom_filter *bf, const uint8_t *item, size_=
t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return bloom_add_test(bf, i=
tem, len, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bloom_remove(struct bloom_filter *bf, const u=
int8_t *item, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return b=
loom_add_test(bf, item, len, -1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bloom_test(struct bloom_filter *bf, const uin=
t8_t *item, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return blo=
om_add_test(bf, item, len, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span>diff --git a/src/openvpn/bloom=2Eh b/src/openv=
pn/bloom=2Eh</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2E8d814d5</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/bloom=2Eh</span><br><span>@@ -0,0 +1,147 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  This program is distributed in the hope that it will be useful,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  GNU General Public License for more details=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  You should have received a copy of the GNU General Public L=
icense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef BLOOM_H</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define BLOOM_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* This is the type we use for the buckets=2E This is split into small=
 buckets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with BLO=
OM_FILTER_BITS_COUNT size */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef uint32_t bloom_counter_t;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define BLOOM_FILTER_BITS_COUNT 4</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define BLOOM_FILTER_BITS_MASK  0x0f</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define bloom_counter=
_max       0x0f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* we want bloom_counte=
r_t bits to be a multiple of BLOOM_FILTER_BITS_COUNT to</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * allow our operations to calculate bu=
cket indexes to assume that that a bucket</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * is always inside a single index bloom_counter_t an=
d never stretches over</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * two adjacent bloom_counter_t */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static_assert((sizeof(bloom_counter_t) * 8) % BLOOM_FILTE=
R_BITS_COUNT =3D=3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+              &quot;bloom_counter_t must be a multiple of BLOOM_FILTER_B=
IT_COUNT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* We use 64 bit outpu=
t from siphash for the bloom filter */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define BLOOM_HASH_SIZE 8</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline bloom_counter_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+min_bloom_counter(bloom_counter_t x, bloom_counter_t y)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (x &lt; y)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return x;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return y;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct siphash_key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SI=
PHASH_KEY_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * A structure holding a bloom filter=2E A bloom filter=
 is a probabilistic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * data structure used to test whether an element is a member of a set=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It may return fals=
e positives but never false negatives=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * A bloom filter has a size N of entries, and each entry or bucket is =
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * counter=2E E=2E=
g=2E a bloom filer of size 1024 with entries of 4 bits each</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * will have 4096 bits or 512 bytes=
 in total size=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Whenever an entr=
y is added to the bloom filter, n hash function are</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * calculated=2E These map a key -&gt; [0=
, size of bloom filter]=2E For each of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * hash function use the result as index for the bucket =
to increase the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c=
ounter=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * For our example of a blo=
om filter with 1024 entries and 5 hash functions,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * hashing an entry might yield 77,323, 662, =
789, and 8=2E That would then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * increase the buckets (bit counters) at the the index positions=
 77, 323,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 662, 78=
9, and 8=2E If an entry is at its maximum (15 for 4 bits counters)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * it will stop increasing t=
he counter=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * To test if an entry =
is in the bloom filter we do the same hashing and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * check if all the counters positions have a=
t least a value of 1=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Removing a=
n entry is similar to adding an entry, we decrement the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * counter at each bit position=2E But =
with the caveat that buckets with</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * already at maximum, the counter is not decremented in orde=
r to preserve</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
 property of never false negatives=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Instead of using n separate hash functions that map to output log(N) bi=
ts,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * our implement=
ation uses multiple siphash functions with 64 bit output</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * and slices them into multiple hash =
functions of log(N) bits=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * E=2Eg=
=2E when using a bloom filter of size 1048576 (1024 * 1024),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * we need 20 bits output for each=
 of the hash functions=2E We round up</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * to bytes, So that are 3 bytes=2E To realize 7 hash fun=
ction we need</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
n 21 bytes or three siphash function each with 8 byte (64 bit)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct bloom_filter</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /** Size (N) of the bloom filter in entries</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * This is also equal to (total bi=
ts)/(bits per counter) */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    size_t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Number o=
f bytes used by each hash function=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * log2(size * 8) bits rounded up to the next byte</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * This is a cached value since log2 is surp=
risingly slow</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 (5% of total time of if we do not cache it) */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    size_t hash_bytes;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /** number of hashes (n) we use to determine the bit positi=
ons */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t nu=
m_hashes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /** number of siphash fun=
ctions needed to calculate=2E This can be</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * calculated from the other members of the struc=
t but we store it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * in the struct for fast access */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    size_t num_siphash;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /** keys for the siphash functions */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct siphash_key *siphash_keys;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /** the actual buckets that hold the data */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t bu=
ckets[];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct bloom_filter *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bloom_test(struct bloom_filter *bf, cons=
t uint8_t *item, size_t len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_cou=
nter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_add(str=
uct bloom_filter *bf, const uint8_t *item, size_t len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bloom_remove(struct bloom_filter *bf, const uint8_t *item, siz=
e_t len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bloom_clear(struct bloom_filter *bf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef BLOOM_H *=
/</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec<=
/span><br><span>index e98b6de=2E=2E01219b3 100644</span><br><span>--- a/src=
/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><spa=
n>@@ -33,6 +33,7 @@</span><br><span> #include &quot;memdbg=2Eh&quot;</span>=
<br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #include &quot=
;sid_hash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;reflect_filter=2Eh&quot;</span><br><span> </span><br><span> =
#ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;=
</span><br><span>@@ -125,7 +126,7 @@</span><br><span>     {</span><br><span=
>         /* Check if we are still below our limit for sending out</span><b=
r><span>          * responses */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!reflect_filter_rate_limit_check(m-&gt;initial_rate_=
limiter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!reflect_filter_check(m-&gt;initial_rate_limiter, from))</span><br><span>=
         {</span><br><span>             return PRE_DECRYPT_NO_ACTION;</span=
><br><span>         }</span><br><span>@@ -264,9 +265,10 @@</span><br><span>=
 </span><br><span>         if (frequency_limit_event_allowed(m-&gt;new_conn=
ection_limiter))</span><br><span>         {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            struct link_socket_actual *from =3D &am=
p;m-&gt;top=2Ec2=2Efrom;</span><br><span>             /* a successful three=
-way handshake only counts against</span><br><span>              * connect-=
freq but not against connect-freq-initial */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            reflect_filter_rate_limit_decrease(m-&gt=
;initial_rate_limiter);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            reflect_filter_rate_limit_decrease(m-&gt;initial_rate_limit=
er, &amp;from-&gt;dest);</span><br><span> </span><br><span>             mi =
=3D multi_create_instance(m, real, sock);</span><br><span>             if (=
mi)</span><br><span>@@ -280,7 +282,7 @@</span><br><span>                 {<=
/span><br><span>                     ASSERT(session_id_defined(&amp;state=
=2Epeer_session_id));</span><br><span>                     mi-&gt;context=
=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    session_skip_to_pre_start(session, &amp;s=
tate, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    session_skip_to_pre_start(session, &amp;=
state, from);</span><br><span>                 }</span><br><span>          =
       multi_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><=
span>             }</span><br><span>diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec</span><br><span>index 60e89fb=2E=2E9da921a 100644</span=
><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mu=
lti=2Ec</span><br><span>@@ -330,9 +330,12 @@</span><br><span>      * Limit =
frequency of incoming connections to control</span><br><span>      * DoS=2E=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    m-&gt;new_connection_limiter =3D frequency_limit_init(t-&gt;options=
=2Ecf_max, t-&gt;options=2Ecf_per);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    m-&gt;initial_rate_limiter =3D</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        initial_rate_limit_init(t-&gt;options=2E=
cf_initial_max, t-&gt;options=2Ecf_initial_per);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    m-&gt;new_connection_limiter =3D frequency=
_limit_init(t-&gt;options=2Ecf_max,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                                     t-&gt;=
options=2Ecf_per);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   m-&gt;initial_rate_limiter =3D initial_rate_limit_init(t-&gt;options=2Ec=
f_initial_max,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                                 t-&gt;options=2Ecf_initial=
_per,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                                        &amp;t-&gt;options=2Einitial_cf_blo=
om_config);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> </span><br><span>     /*</span><br><span>      * Allocate broadca=
st/multicast buffer list</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 629652e=2E=2E84dff0f 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -3291,6 +3291,23 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_filter_tier_under_global_limit(stru=
ct filter_tier *ft, int limit,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                     const char *family)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    while (ft)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (ft-&gt;limit &lt; limit)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_WARN, &quot;Note: --connect-freq-initia=
l-bloom-limit %s %d %d &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        &quot;has a larger limit than connect-fre=
q-limit-initial &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        &quot;limit (%d)=2E&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                family, ft-&gt;netmask, f=
t-&gt;limit, limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
t =3D ft-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span> options_postprocess_ver=
ify(const struct options *o)</span><br><span> {</span><br><span>     if (o-=
&gt;connection_list)</span><br><span>@@ -3325,6 +3342,18 @@</span><br><span=
>                         &quot;Ignoring these options=2E&quot;);</span><br=
><span>         }</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if ((bool)(o-&gt;initial_cf_bloom_config=2Einet_tiers)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            + (bool)(o-&gt;initial=
_cf_bloom_config=2Einet6_tiers)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_FATAL, &quot;connect-freq-initial-bloom-limit must be provided fo=
r &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          &quot;both inet and inet6&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    check_filter_tier_under_global_limit(o-&gt;initial_cf_bloom_c=
onfig=2Einet_tiers,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                         o-&gt;cf_initial_max, &quot;inet&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_fil=
ter_tier_under_global_limit(o-&gt;initial_cf_bloom_config=2Einet6_tiers,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                   o-&gt;cf_initial_max, &quot;inet6&quot;);</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span>@@ -742=
0,6 +7449,73 @@</span><br><span>         options-&gt;cf_initial_max =3D cf_=
max;</span><br><span>         options-&gt;cf_initial_per =3D cf_per;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (streq(p[0], &quot;connect-freq-initial-bloom-size&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   int cf_bloom_size =3D atoi(p[1]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (cf_bloom_size &lt;=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(msglevel, &quot;--connect-freq-initial-bloom-size size=
 must be &gt; 0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    options-&gt;initial_cf_bloom_config=2Esize =3D cf_bloom_size;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[2])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            int num_hash =3D atoi(p[1]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (num_=
hash &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(msglevel, &quot;--connect-freq-initial-bloom-size number of hash =
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                 &quot;functions must be &gt; 0&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            options-&gt;initial_cf_bloo=
m_config=2Enum_hashes =3D num_hash;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (streq(p[0], &quot;connect-freq-initial-bloom-limit&quot;) &amp;&amp; p=
[1] &amp;&amp; p[2]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int netmask =3D atoi(p[2]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int limit =3D atoi(p[3]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (limit &lt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;Limit parameter to =
%s must be &gt; 0&quot;, p[0]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str=
eq(p[1], &quot;inet&quot;))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (netmask &lt; 0 || netmask &gt; 32)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                msg(msglevel, &quot;Netmask paramete=
r (%s) for IPv4 for %s must be &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                              &quot;between 0 and 32&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   p[2], p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        reflect_add_filter_tier(&amp;options-&gt;initial_cf_bloom_config,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
               &amp;options-&gt;gc, false, netmask, limit);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else if (streq(p[1], &quot;inet6&quot=
;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (netmask &l=
t; 0 || netmask &gt; 128)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(msglevel, &quot;Netmask parameter (%s) for IPv6 for %s =
must be &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                         &quot;between 0 and 128&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    p[2], p[0]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            reflect_add_fi=
lter_tier(&amp;options-&gt;initial_cf_bloom_config,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    &amp;=
options-&gt;gc, true, netmask, limit);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(msglevel, &quot;Unknown parameter %s for %s=2E Must be inet or inet=
6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     p[1], p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span>     else if (streq(p[0], &quot;max-clients&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/optio=
ns=2Eh b/src/openvpn/options=2Eh</span><br><span>index c7825c7=2E=2E644280a=
 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b=
/src/openvpn/options=2Eh</span><br><span>@@ -42,6 +42,7 @@</span><br><span>=
 #include &quot;clinat=2Eh&quot;</span><br><span> #include &quot;crypto_bac=
kend=2Eh&quot;</span><br><span> #include &quot;dns=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;reflect_filter=2Eh&=
quot;</span><br><span> </span><br><span> </span><br><span> /*</span><br><sp=
an>@@ -533,6 +534,8 @@</span><br><span>     int cf_initial_max;</span><br><=
span>     int cf_initial_per;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct bloom_filter_conf initial_cf_bloom_c=
onfig;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     uint32_t max_clients;</span><br><span>     int max_routes_per_clie=
nt;</span><br><span>     int stale_routes_check_interval;</span><br><span>d=
iff --git a/src/openvpn/ovpn_dco_linux=2Eh b/src/openvpn/ovpn_dco_linux=2Eh=
</span><br><span>index b3c9ff0=2E=2E7366177 100644</span><br><span>--- a/sr=
c/openvpn/ovpn_dco_linux=2Eh</span><br><span>+++ b/src/openvpn/ovpn_dco_lin=
ux=2Eh</span><br><span>@@ -6,105 +6,113 @@</span><br><span> #ifndef _UAPI_L=
INUX_OVPN_H</span><br><span> #define _UAPI_LINUX_OVPN_H</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OVPN_FAMILY_NAM=
E	&quot;ovpn&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine OVPN_FAMILY_VERSION	1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define OVPN_FAMILY_NAME    &quot;ovpn&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OVPN_FAMILY_VERSION 1</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OVPN_NO=
NCE_TAIL_SIZE	8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine OVPN_NONCE_TAIL_SIZE 8</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-enum ovpn_cipher_alg {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_NONE,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_AES_GCM,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_CHACHA20_POLY1305,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+enum ovpn_cipher_alg</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_CIPHER_ALG_NONE,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_CIPHER_ALG_AES_GCM,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CIPHER_ALG_CHACHA20_POL=
Y1305,</span><br><span> };</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-enum ovpn_del_peer_reason {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TEARDOWN,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_USERSPACE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_EXP=
IRED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_R=
EASON_TRANSPORT_ERROR,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+enum ovpn_del_peer_reason</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_DEL_PEER_REASON_TEARDOWN,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_USERSPACE,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_EXPIRE=
D,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER=
_REASON_TRANSPORT_ERROR,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,</span><br><span> };</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ov=
pn_key_slot {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KE=
Y_SLOT_PRIMARY,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_=
KEY_SLOT_SECONDARY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
enum ovpn_key_slot</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_SLOT_P=
RIMARY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY=
_SLOT_SECONDARY,</span><br><span> };</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-enum {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_A_PEER_ID =3D 1,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_IPV4,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_IPV6,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_PORT,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_SOCKET,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_SOCKET_NETNSID,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_IPV4,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_IPV6,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LOCAL_IPV4=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LOCAL_I=
PV6,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LOCA=
L_PORT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_K=
EEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OV=
PN_A_PEER_KEEPALIVE_TIMEOUT,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_A_PEER_DEL_REASON,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	OVPN_A_PEER_VPN_RX_BYTES,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	OVPN_A_PEER_VPN_TX_BYTES,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_RX_PACKETS,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_TX_PACKETS,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LINK_RX_BYTES,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LINK_TX_BYTES,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LINK_RX_PACKETS,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LINK_TX_=
PACKETS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_ID =3D 1,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_REMOTE_IPV4,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_REMOTE_IPV6,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_REMO=
TE_IPV6_SCOPE_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OVPN_A_PEER_REMOTE_PORT,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_A_PEER_SOCKET,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_A_PEER_SOCKET_NETNSID,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_IPV4,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_IPV6,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LOCAL_IPV4,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LOCAL_IPV6,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LOCAL_PO=
RT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_=
KEEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    OVPN_A_PEER_KEEPALIVE_TIMEOUT,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_A_PEER_DEL_REASON,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_RX_BYTES,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_TX_BYTES,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_RX_PACKETS,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN=
_TX_PACKETS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_A_PEER_LINK_RX_BYTES,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_A_PEER_LINK_TX_BYTES,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_A_PEER_LINK_RX_PACKETS,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LINK_TX_PACKETS,</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_A_PEER_MAX=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_MAX =3D=
 (__OVPN_A_PEER_MAX - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    __OVPN_A_PEER_MAX,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    OVPN_A_PEER_MAX =3D (__OVPN_A_PEER_MAX - 1)</span><br><span> };=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-enu=
m {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_PE=
ER_ID =3D 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_K=
EYCONF_SLOT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_K=
EYCONF_KEY_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A=
_KEYCONF_CIPHER_ALG,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
OVPN_A_KEYCONF_ENCRYPT_DIR,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_A_KEYCONF_DECRYPT_DIR,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF=
_PEER_ID =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OVPN_A_KEYCONF_SLOT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    OVPN_A_KEYCONF_KEY_ID,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    OVPN_A_KEYCONF_CIPHER_ALG,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_A_KEYCONF_ENCRYPT_DIR,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF_DECRYPT_DIR,</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_A_KEYCON=
F_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF=
_MAX =3D (__OVPN_A_KEYCONF_MAX - 1)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    __OVPN_A_KEYCONF_MAX,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_A_KEYCONF_MAX =3D (__OVPN_A_KEYCONF_MAX - 1)=
</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-enum {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	OVPN_A_KEYDIR_CIPHER_KEY =3D 1,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	OVPN_A_KEYDIR_NONCE_TAIL,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+enum</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KE=
YDIR_CIPHER_KEY =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_A_KEYDIR_NONCE_TAIL,</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	__OVPN_A_KEYDIR_MAX,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - =
1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_A_KEYD=
IR_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_K=
EYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)</span><br><span> };</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_IFINDEX =3D 1,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+enum</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OVPN_A_IFINDEX =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_A_PEER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    OVPN_A_KEYCONF,</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	__OVPN_A_MAX,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	OVPN_A_MAX =3D (__OVPN_A_MAX - 1)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    __OVPN_A_MAX,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OVPN_A_MAX =3D (__OVPN_A_MAX - 1)</span><br><spa=
n> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-enum {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEE=
R_NEW =3D 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD=
_PEER_SET,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_P=
EER_GET,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEE=
R_DEL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_=
DEL_NTF,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY=
_NEW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_GE=
T,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_SWAP,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_SWAP_NT=
F,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_DEL,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_FLOAT_N=
TF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_NEW =3D 1,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_SET,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_GET,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_DEL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_DEL_NTF,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_NEW,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_GET,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_SWA=
P,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_=
SWAP_NTF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_C=
MD_KEY_DEL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_CMD_PEER_FLOAT_NTF,</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	__OVPN_CMD_MAX,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    __OVPN_CMD_MAX,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define OVPN_MCGRP_PEERS	&quot;peers&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define OVPN_MCGRP_PEERS &quot;peers&q=
uot;</span><br><span> </span><br><span> #endif /* _UAPI_LINUX_OVPN_H */</sp=
an><br><span>diff --git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/refl=
ect_filter=2Ec</span><br><span>index e5226e4=2E=2Ef543a0f 100644</span><br>=
<span>--- a/src/openvpn/reflect_filter=2Ec</span><br><span>+++ b/src/openvp=
n/reflect_filter=2Ec</span><br><span>@@ -5,7 +5,8 @@</span><br><span>  *   =
          packet encryption, packet authentication, and</span><br><span>  *=
             packet compression=2E</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2022-2026 OpenVPN Inc &l=
t;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  Copyright (C) 2023-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 202=
3-2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span>  *</span><b=
r><span>  *  This program is free software; you can redistribute it and/or =
modify</span><br><span>  *  it under the terms of the GNU General Public Li=
cense version 2</span><br><span>@@ -37,8 +38,7 @@</span><br><span> #include=
 &quot;crypto=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&=
quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span> refle=
ct_filter_rate_limit_check(struct initial_packet_rate_limit *irl)</span><br=
><span> {</span><br><span>     if (now &gt; irl-&gt;last_period_reset + irl=
-&gt;period_length)</span><br><span>@@ -73,34 +73,380 @@</span><br><span>  =
   return !over_limit;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-reflect_filter_rate_limit_decrease(struct initial_pack=
et_rate_limit *irl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_fi=
lter_tier(struct initial_packet_rate_limit *irl,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  struct filter_tier *tier, co=
nst char *prefix)</span><br><span> {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (; tier !=3D NULL; tier =3D tier-&gt;next)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (tier-&gt;dropped &gt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_DEBUG_LOW, &=
quot;Dropped %zu initial handshake packets due to &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                 &quot=
;--connect-freq-initial-bloom-limit %s %d %d&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                tier-&gt;dropped, prefix,=
 tier-&gt;netmask, tier-&gt;limit);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            tier-&gt;dropped =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bloom_filter_check_reset(struct ini=
tial_packet_rate_limit *irl)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (n=
ow &gt; irl-&gt;last_period_reset + irl-&gt;period_length)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        reset_filter_tier(irl, irl-&gt;bloom_conf=
=2Einet_tiers, &quot;inet&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        reset_filter_tier(irl, irl-&gt;bloom_conf=2Einet6_tie=
rs, &quot;inet6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bloom_c=
lear(irl-&gt;bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * structure =
used as lookup key for the bloom structure=2E We used the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * netmask as part of the structure t=
o avoid the look for the first</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * IP of a subnet and the subnet to be same key=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct bloom_filter_key</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    union</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct in_addr in;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   struct in6_addr in6;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n=
etmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we ke=
ep the count in the key instead of in the bloom filter table as</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * can then keep the counte=
r in the bloom filter itself small (2 bits)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * and bloom filter usage is the same for 20000=
 request from the same IP</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * (20k entries with different count but same IP) and from 20000 =
random ips</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (2=
0k entries with count 1 but different IP) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int count;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline st=
ruct bloom_filter_key</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+filter_mask_inet6(struct openvpn_sockaddr *addr, int netmask)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct bloom_filter_key ret =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=2Ein6 =3D addr-&gt=
;addr=2Ein6=2Esin6_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int bits_t=
o_clear =3D 128 - netmask;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int bytes_to_clear =3D bits_to_clear / 8;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bits_to_clear =3D bits_to_clear % 8;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;ret=2Ein6=2Es6_addr[15 =
- bytes_to_clear], 0x00, bytes_to_clear);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ret=2Ein6=2Es6_addr[15 - bytes_to_clear - 1] &amp;=3D (0xff &lt;&lt;=
 bits_to_clear);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=2Enetmask =3D =
netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline struct bloom_filter_key</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+filter_mask_inet(struct openvpn_sockaddr *addr, int n=
etmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter_key re=
t =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
=2Ein =3D addr-&gt;addr=2Ein4=2Esin_addr;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ret=2Ein=2Es_addr &amp;=3D htonl(0xffffffff &lt;&=
lt; (32 - netmask));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ret=2Enetmask =3D netmask;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* We use one function and an=
 action argument to avoid repeating</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * the code to iterate to the tiers and the creating the lo=
okup</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * keys */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+enum bloom_filter_action=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    REFLECT_CHECK,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    REFLECT_INCREASE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    REFLECT_DECREASE,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+refl=
ect_lookup_bf_key(struct bloom_filter *bf, struct bloom_filter_key *key, in=
t limit)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* we do a lookup for 1,2=
,3, and 4 and the limit first</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * and after that do regular binary search=2E This is meant t=
o optimise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * th=
e common case where just a small number of requests are coming from</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * each IP */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    key-&gt;count =3D limit;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bloom_test(b=
f, (const uint8_t *)key, sizeof(struct bloom_filter_key)) &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return limit;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    key-&gt;count =3D 4;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (bloom_test(bf, (const uint8_t *)key, sizeof(struct bloom_fi=
lter_key)) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Th=
e value for 4 has not been found, so the real value might be 1, 2, or 3=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int =
i =3D 3; i &gt; 0; i--)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      key-&gt;count =3D i;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (bloom_test(bf, (const uint8_t *)key, sizeof(struct b=
loom_filter_key)) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                return i;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* 4 was no in the ma=
p and 1-3 are also not there, so assume the key is not in the map */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int low =3D 3;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int high =3D limit;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   while (low &lt; high)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        k=
ey-&gt;count =3D (high + low + 1) / 2;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        bloom_counter_t count =3D bloom_test(bf, (const =
uint8_t *)key, sizeof(struct bloom_filter_key));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (count &gt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            low =3D key-&gt;count;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            high =3D key-&gt;count - 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l=
ow =3D=3D 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* we reached=
 the lower end of our binary search have not found the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * key and we know that 4 is in =
the map */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return low;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Convert a mapped IPv6 mapped IPv4 addr=
ess (::ffff:0:0/96) to an</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * equivalent IPv4 adress=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @note: This function only converts the IP itself and ignores other</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * parts of the \c from str=
ucture like port or protocol=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic struct openvpn_sockaddr</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+convert_mapped_inet_sockaddr(struct openvpn_sockaddr *from)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from_mapped =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we ignor=
e the fields like port that the key in the bloom filter</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * ignores too=2E This makes this f=
unction non-generic */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from_mapped=
=2Eaddr=2Ein4=2Esin_family =3D AF_INET;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    memcpy(&amp;from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_addr,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+           &amp;from-&gt;addr=2E=
in6=2Esin6_addr=2Es6_addr[12],</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           sizeof(from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_addr))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return from_mapped;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+blo=
om_filter_action(struct initial_packet_rate_limit *irl,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    struct openvpn_sock=
addr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            enum bloom_filter_action action)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool found =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct filter_tier *tier =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct openvpn_sockaddr from_mapped;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (from-&gt;addr=2Esa=2Esa_family =3D=3D AF_INET6</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; IN6_=
IS_ADDR_V4MAPPED(&amp;from-&gt;addr=2Ein6=2Esin6_addr))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        from_mapped =3D convert_mapped_inet_sockaddr(=
from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        from =
=3D &amp;from_mapped;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (from-&gt;addr=2Esa=2Esa=
_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ti=
er =3D irl-&gt;bloom_conf=2Einet_tiers;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (from-&gt;addr=2Esa=2Esa_family =3D=3D AF_INET6)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tier =3D irl-&gt;bloom_conf=2Eine=
t6_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (tier)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct filter_tier *next_tier =3D tier-&gt;next;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct bloom_=
filter_key key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (from-&gt;ad=
dr=2Esa=2Esa_family =3D=3D AF_INET6)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            key =3D filter_mask_inet6(from, tier-&gt;netmask);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            key =3D filter_mask_inet(from, tier-&gt=
;netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* fetch the current count of =
the key in the bloom filter */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        int result =3D reflect_lookup_bf_key(irl-&gt;bf, &amp;ke=
y, tier-&gt;limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        switch (action)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            case REFLECT_CHECK:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (result &gt;=3D tier-&gt;limit)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    found =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    tier-&gt;dropped++;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    if (tier-&gt;dropped =3D=3D 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        msg(M_WARN, &q=
uot;Note: --connect-freq-initial-bloom-limit &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    &quot=
;limit for netmask /%d exceeded=2E Expect additional &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
 &quot;initial packet drops for the next %d seconds&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            tier-&gt=
;netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                  (int)(irl-&gt;last_period_reset + irl-&gt;period_length -=
 now));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            case REFLECT_INC=
REASE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   ASSERT(result &lt; tier-&gt;limit);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                key=2Ecount =3D result + 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                bloom_add(irl-&g=
t;bf, (const uint8_t *)&amp;key, sizeof(key));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            case REFLECT_DECREASE:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                key=2Ecount =3D result - 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                bloom_rem=
ove(irl-&gt;bf, (const uint8_t *)&amp;key, sizeof(key));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        tier =3D next_tier;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!found &amp;&amp; action =3D=3D REFLECT_CHECK)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* We only want to increase the counters =
if the IP is not already</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * in the set=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        bloom_filter_action(irl, from, REFLECT_INCREASE);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return found;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_filt=
er_check(struct initial_packet_rate_limit *irl,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                   struct openvpn_sockaddr *fro=
m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (now &gt; irl-&gt;last_perio=
d_reset + irl-&gt;period_length)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       bloom_filter_check_reset(irl);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        bloom_clear(irl-&gt;bf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return bloom_filter_action(irl, from, REFLECT_CHECK);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+reflect_filter_check(struct initial=
_packet_rate_limit *irl,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                     struct openvpn_sockaddr *from)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* We are doing the bloom filter check first so pack=
ets that are already</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * rejected by the bloom filter do not count against the limit of the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * simple rate l=
imiter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ir=
l-&gt;bf &amp;&amp; bloom_filter_check(irl, from))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!refle=
ct_filter_rate_limit_check(irl))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+reflect_filter_rate_limit_decre=
ase(struct initial_packet_rate_limit *irl, struct openvpn_sockaddr *from)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (irl-&gt;bf &amp;&amp; bloom_fil=
ter_action(irl, from, REFLECT_CHECK))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* Only remove if it is actually present=2E This might be a pac=
ket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * comin=
g from an early period or be relayed */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        bloom_filter_action(irl, from, REFLECT_DECREASE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (irl-&=
gt;curr_period_counter &gt; 0)</span><br><span>     {</span><br><span>     =
    irl-&gt;curr_period_counter--;</span><br><span>     }</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect_add_fil=
ter_tier(struct bloom_filter_conf *bfconf, struct gc_arena *gc,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        bool ip=
v6, int netmask, int limit)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 filter_tier *ftnew =3D gc_malloc(sizeof(struct filter_tier), true, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ftnew-&gt;netmask =3D netmask;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ftnew-&gt;limit =3D li=
mit;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (ipv6)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ftnew-&gt;next =3D bfconf-&gt;inet6_tiers;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        bfconf-&gt;inet=
6_tiers =3D ftnew;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ftnew-&gt;next =3D bfconf-&gt;in=
et_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bf=
conf-&gt;inet_tiers =3D ftnew;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+init_bloom_filter(struct initial_packet_rate_limit *irl=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!irl-&gt;bloom_conf=2Esize)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* the default allocates 2=
MB for bloom filter entries */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        irl-&gt;bloom_conf=2Esize =3D 1024ul * 1024 * 8;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!irl-&gt;bloom_conf=2Enum_hashes)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        irl-&gt;bloom_conf=2Enum_=
hashes =3D 7;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    irl-&gt;bf =3D bloom_create(irl-&gt=
;bloom_conf=2Esize, irl-&gt;bloom_conf=2Enum_hashes,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &amp;irl-&gt;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_clear(=
irl-&gt;bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span> </span><br><span> struct initial_packet_rate_limit *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-initial_rate_limit_init(int max_=
per_period, int period_length)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+initial_rate_limit_init(int max_per_period, int period_length,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   struct bloom_filter_conf *bconf)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct initial_packet_rate_limit *irl;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct initial_=
packet_rate_limit *irl =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ALLOC_OBJ_CLEAR(irl, struct initial_packet_rate_limit);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(irl, struct i=
nitial_packet_rate_limit);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    irl-&gt;gc =3D gc_new();</span><br><span> </span><br><span>     =
irl-&gt;max_per_period =3D max_per_period;</span><br><span>     irl-&gt;per=
iod_length =3D period_length;</span><br><span>     irl-&gt;curr_period_coun=
ter =3D 0;</span><br><span>     irl-&gt;last_period_reset =3D 0;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bcon=
f)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        irl-&gt;bloom_conf =3D =
*bconf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        init=
_bloom_filter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     return irl;</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span> initial_rate_limit_free(struct initial_packet_rate_lim=
it *irl)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;irl-&gt;gc);</span><br><span>     free(irl);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    irl =3D NULL;</span><=
br><span> }</span><br><span>diff --git a/src/openvpn/reflect_filter=2Eh b/s=
rc/openvpn/reflect_filter=2Eh</span><br><span>index 84915e8c6=2E=2Edcccbde =
100644</span><br><span>--- a/src/openvpn/reflect_filter=2Eh</span><br><span=
>+++ b/src/openvpn/reflect_filter=2Eh</span><br><span>@@ -23,6 +23,30 @@</s=
pan><br><span> #define REFLECT_FILTER_H</span><br><span> </span><br><span> =
#include &lt;limits=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;bloom=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct filter_tier</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct filter_tier *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int limit;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int netmask;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** The number of packets we dropped =
since we went over this limit */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t dropped;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct bloom_filter_con=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct filter_tier *inet_tiers;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct filter_ti=
er *inet6_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Configuration o=
f the bloom filter */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t num_hashes;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    size_t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> </span><br><span> /** struct that handles all the rate limiting logic fo=
r initial</span><br><span>  * responses */</span><br><span>@@ -35,7 +59,7 @=
@</span><br><span>     int period_length;</span><br><span> </span><br><span=
>     /** Number of packets in the current period=2E We use int64_t here</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * to avoid any poti=
ential issues with overflow */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * to avoid any potential issues with overflow */</span><br>=
<span>     int64_t curr_period_counter;</span><br><span> </span><br><span> =
    /* Last time we reset our timer */</span><br><span>@@ -44,29 +68,57 @@<=
/span><br><span>     /* we want to warn once per period that packets are be=
ing started to</span><br><span>      * be dropped */</span><br><span>     b=
ool warning_displayed;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom=
_filter_conf bloom_conf;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct bloom_filter *bf;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* gc_arena used for the various allocations by this struct */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc;</span><br=
><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Adds=
 a bloom filter tier to the bloom filter config=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_arena *=
gc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        bool ipv6, int netmask, int limit);</span><br><span> </span><br><sp=
an> /**</span><br><span>  * checks if the connection is still allowed to co=
nnect under the rate</span><br><span>  * limit=2E This also increases the i=
nternal counter at the same time</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool reflect_filter_rate_limit_check(struct=
 initial_packet_rate_limit *irl);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
eflect_filter_check(struct initial_packet_rate_limit *irl,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     struct openvpn_=
sockaddr *from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> </span><br><span> /**</span><br><span>  * decreases the coun=
ter of initial packets seen, so connections that</span><br><span>  * succes=
sfully completed the three-way handshake do not count against</span><br><sp=
an>  * the counter of initial connection attempts</span><br><span>  */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void reflect_filter_rate_l=
imit_decrease(struct initial_packet_rate_limit *irl);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+reflect_filter_rate_limit_decrease(struct initial_packet=
_rate_limit *irl,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                 struct openvpn_sockaddr *from);</span><br>=
<span> </span><br><span> /**</span><br><span>  * allocate and initialize th=
e initial-packet rate limiter structure</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Note: this function does not copy bconf&#39;s contents=2E</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct initi=
al_packet_rate_limit *initial_rate_limit_init(int max_per_period, int perio=
d_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct in=
itial_packet_rate_limit *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+initial_rate_limit_init(int max_per_period, int period_length,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        st=
ruct bloom_filter_conf *bconf);</span><br><span> </span><br><span> /**</spa=
n><br><span>  * free the initial-packet rate limiter structure</span><br><s=
pan>  */</span><br><span> void initial_rate_limit_free(struct initial_packe=
t_rate_limit *irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Initialises the bloom filter wit=
h the configuration values of</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * irl-&gt;bloom_conf</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_bloom_filter(s=
truct initial_packet_rate_limit *irl);</span><br><span> #endif /* ifndef RE=
FLECT_FILTER_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Mak=
efile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 7=
a8915b=2E=2Eea0822c 100644</span><br><span>--- a/tests/unit_tests/openvpn/M=
akefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</=
span><br><span>@@ -19,6 +19,7 @@</span><br><span> 	pkt_testdriver \</span><=
br><span> 	provider_testdriver \</span><br><span> 	push_update_msg_testdriv=
er \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	reflect_testdr=
iver \</span><br><span> 	socket_testdriver \</span><br><span> 	ssl_testdriv=
er \</span><br><span> 	user_pass_testdriver</span><br><span>@@ -103,6 +104,=
7 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAG=
S =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriv=
er_SOURCES =3D test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	test_reflect=2Ec test_reflect=2Eh \</span><br><span> 	mock_msg=
=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_management=2Ec \=
</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_reflect=2Ec b/tests/un=
it_tests/openvpn/test_reflect=2Ec</span><br><span>new file mode 100644</spa=
n><br><span>index 0000000=2E=2Ed0d11c6</span><br><span>--- /dev/null</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_reflect=2Ec</span><br><span>@=
@ -0,0 +1,293 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             session authentication and key exchange,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packe=
t authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet compression=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-msvc=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;bloom=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;reflect_filter=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;te=
st_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;s=
tdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static_assert(BLOOM_FILTER=
_BITS_COUNT =3D=3D 4, &quot;unit test not in sync&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static_assert(BLOOM_FILTER_BITS_MASK =
=3D=3D 0xf, &quot;unit test not in sync&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_b=
loom(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static const in=
t present_mod =3D 77;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Use a bloom filter with 1M entries (256kB) for the unit test */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter =
*bf =3D bloom_create(1024ul * 1024, 8, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int32_t i =3D 0; i &lt; 20000; i +=3D present_mod)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        bloom_add(bf, (const uint8_t *)=
&amp;i, sizeof(i));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* all these should be positi=
ve, for the small unit test we do not expect</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * false positive */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int32_t i =3D 0; i &lt; 20000; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int present =3D (i % prese=
nt_mod =3D=3D 0) ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* cast to bool to only get 1 and 0 for present/not present a=
nd not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        as=
sert_int_equal((bool)bloom_test(bf, (const uint8_t *)&amp;i, sizeof(i)), pr=
esent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reflect_ddos(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This tests if the=
 bloom filter implementation does actually work with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * the goal of dropping packets to a =
reflected /24 while still allowing</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * other clients */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Disable the normal fallback that puts a hard cap on the reflection f=
ilter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;i=
rl-&gt;bloom_conf, &amp;irl-&gt;gc, false, 24, 5);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;blo=
om_conf, &amp;irl-&gt;gc, false, 8, 20);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    init_bloom_filter(irl);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int num_legimate_reject =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int num_legimate_accepted =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int num_ddos_rejected =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int num_ddos_accepted =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* /24 net addresses in host byte order */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    in_addr_t net_attack[4];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=
 3; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        net_attack[i] =3D=
 random() % 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* The 4th network is close eno=
ugh to the 3rd to fall in the same /16 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* XOR the 3rd byte to achieve this */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    net_attack[3] =3D net_atta=
ck[2] ^ 00002300;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Assume 200000 =
packets, including roughly 200 legitimate packets,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * the unit test works also with 20 mill=
ions packet but takes too long*/</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    static const int total_packets =3D 200 * 1000;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; total_packets; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct openvpn_sockaddr fro=
m =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 from=2Eaddr=2Ein4=2Esin_family =3D AF_INET;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D =
(in_addr_t)random();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        from=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)random();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (i % 1023 =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* roughly 200 legitimate clients with =
random addresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t)random();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            bool allowed =3D reflect_fi=
lter_check(irl, &amp;from);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (allowed)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                num_legimate_accepted++;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                num_legimate_reject++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* We attack the 4 networks at random */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            from=2Eaddr=2Ein4=2Esin_addr=
=2Es_addr =3D (in_addr_t)(net_attack[random() % 4] + (random() % 256));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            bool allowed =3D reflect_filt=
er_check(irl, &amp;from);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (allowed)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                num_ddos_accepted++;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                num_ddos_rejected++;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(num_=
legimate_reject + num_legimate_accepted + num_ddos_accepted + num_ddos_reje=
cted, total_packets);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We assume =
that most legitimate made it through but a few were unfortunate to be in an=
 attacked network */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_in_range(num_legimate_reject, 0, 10);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* We disabled total number of packets, so we expect all=
 /8 to have their</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * 20 packets, which is 5120=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_in_range(num_ddos_accepted, 0, 256 * 20);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    initial_rate_limit_free(irl);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_bloom_minimal(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 bloom_filter *bf =3D bloom_create(2048, 3, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int item =3D 0xbabe;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bloom_add(bf, (const uint8_t *)&amp;item, sizeof(item));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(bloom_test(b=
f, (const uint8_t *)&amp;item, sizeof(item)), 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    item =3D 0xf00f;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(bloom_test(bf, (const uint8_t *)&amp;item,=
 sizeof(item)), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_reflect_reflect_bloom_simple(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct initial_packet_rate_limit *irl =3D initial_rate_=
limit_init(INT_MAX, 300, NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ref=
lect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true, 32, 50=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reflect_add_f=
ilter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true, 56, 200);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    init_bloom_filter(irl)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from=2Ead=
dr=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    from=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from=2Eaddr=2Ein=
6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* There are 50 attempts that should work until one fails */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i =
&lt; 50; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(=
reflect_filter_check(irl, &amp;from));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 2002::1=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openv=
pn_sockaddr from2 =3D from;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    from2=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[0] =3D 0x7;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    from2=2Eaddr=2Ein6=2Esin6_=
addr=2Es6_addr[1] =3D 0x7;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(reflect_filter_check(irl, &amp;from2));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Any more attempts from ::1 should fail */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(reflect_filter_check(irl=
, &amp;from));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    initial_rate_limit_f=
ree(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_reflect_bloom_netmask_masking(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct initial_packet_rate_limit *irl =3D initi=
al_rate_limit_init(INT_MAX, 300, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true=
, 45, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_=
bloom_filter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_s=
ockaddr from =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    from=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    from=2Eaddr=2Ein6=2Esin6_port =3D (ui=
nt16_t)random();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; 15; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        from=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[i] =3D (uint8_t)random();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 10; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* /45 means that if we leave the leave f=
irst 8 bytes and 5 bits</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * untouched, it is still the same subnet  */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 8; j &lt; 15; =
j++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            from=2Eaddr=
=2Ein6=2Esin6_addr=2Es6_addr[j] =3D (uint8_t)random();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            from=2Eaddr=2Ein6=2Esin6_add=
r=2Es6_addr[7] ^=3D (uint8_t)(random() &amp; 0x7);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        assert_true(reflect_filter_check(irl, &amp;fro=
m));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* testing the last IP again should give us =
a negative result */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(reflect_filter_check(irl, &amp;from));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    initial_rate_limit_free(irl);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_reflect_reflect_bloom_mapped(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct initial_packet_r=
ate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_con=
f, &amp;irl-&gt;gc, false, 24, 50);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;i=
rl-&gt;gc, false, 8, 80);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    init_bloom_filter(irl);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Our OpenVPN server will not receive IPv4 as well as IPv4 mapped</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * addresses in the same =
process but for the unit test it is convient</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * to see if they actually mapped to the same =
entries */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr =
mapped_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mapped_v4=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_port =
=3D (uint16_t)random();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* ::ffff:192=2E168=2E0=2E99 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[10] =
=3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapped=
_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[11] =3D 0xff;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2E=
s6_addr[12] =3D 192;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[13] =3D 168;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin=
6_addr=2Es6_addr[14] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 99;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(IN6_IS_ADDR_V4MAPPED(&amp;map=
ped_v4=2Eaddr=2Ein6=2Esin6_addr));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Not the same address but in the same /8 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr v4addr =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    v4addr=2Eaddr=2Ein4=
=2Esin_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    v4addr=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)random();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* 192=2E168=2E123=2E244 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v4addr=2Eaddr=
=2Ein4=2Esin_addr=2Es_addr =3D htonl(0xc0a87bf4);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* check that we run into the 50 limit with our mapped addre=
ss */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; 50; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        as=
sert_true(reflect_filter_check(irl, &amp;mapped_v4));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(reflect_filter_check(irl, &amp;mapped_=
v4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Check that the non-mapped IPv4 address uses t=
he same /8 subnet limit */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; 30; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        assert_true(reflect_filter_check(irl, &amp;v4addr));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(reflect_filter_check=
(irl, &amp;v4addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    initial_rate_l=
imit_free(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span>\ No newline at end of file</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_reflect=2Eh b/tests/unit_tests/openvpn/test_refle=
ct=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E0dc1e4c</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_reflect=2Eh</span><br><span>@@ -0,0 +1,37 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunn=
el IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session aut=
hentication and key exchange,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet encryption, packet authentication, and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet co=
mpression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2=
026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_REFLECT_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define TEST_REFLECT_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void test_reflect_ddos(void **state=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void test_bloom(void **state);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void test_bloom_minimal(void **state);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void test_reflect_reflect_bloom_simple(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_reflect_bloom_netma=
sk_masking(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_ref=
lect_reflect_bloom_mapped(void **state);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span>\ No newline at end of file</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/uni=
t_tests/openvpn/test_ssl=2Ec</span><br><span>index cb9c480=2E=2Ec03c422 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -51,6 +=
51,7 @@</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span>=
 #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;openvp=
n=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;test_reflect=2Eh&quot;</span><br><span> </span><br><span> /* Mock fu=
nction to be allowed to include win32=2Ec which is required for</span><br><=
span>  * getting the temp directory */</span><br><span>@@ -973,8 +974,13 @@=
</span><br><span>         cmocka_unit_test(test_data_channel_known_vectors_=
epoch),</span><br><span>         cmocka_unit_test(test_data_channel_known_v=
ectors_shortpktid),</span><br><span>         cmocka_unit_test(crypto_test_p=
rint_cert_details),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      cmocka_unit_test(ssl_test_extract_peer_info)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(ssl_test_extract_peer_info),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_b=
loom),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_bloom_minimal),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_reflect_reflect_bloom_simple),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_reflect_reflect_bloom_mapped),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_reflect_bloom_netmask_mas=
king),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_reflect_ddos)</span><br><span>     };</span><br><span> </s=
pan><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/30?usp=3Demail">change 30</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/30?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerr=
it-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

</body></html>
--QVLs/fa+1E0=--


--===============7702420481659638994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7702420481659638994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7702420481659638994==--

