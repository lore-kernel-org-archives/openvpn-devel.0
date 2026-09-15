Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9895C88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=28EhwXd716rT8tWOA+OlUVW8xczqUpquGmRIMZfHXQk=; b=i0x2+lJTRvdIWgzM3Hsb5W3EM6
	tLQ7iueh9XzCiicFFNfrJys9MEc8fbfwB4PxSrFozY2FuP7KiDAvRg+R7+bdo0yUH6oapSsLLq6ww
	x2z9fWrj+z4/TEiLGi4uqxi9P91LtNzHc8ca8GkfOPt4x5Sq7VPZxXnAGHRRoxYPH+4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6SgB-0006bg-Lr;
	Tue, 15 Sep 2026 12:54:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6Sg9-0006bZ-Uh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:54:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KOlOlqn3F6cYxcA43eb53o7oslILy0EoaFfRsWzbr4k=; b=HPyKlf0cNgYbKIHoxs1JXaGVJE
 1Puxgf3G2I1Gn46/5sYGg0SE+b+IA2RAB1gN7BayNxjZLV8LH2obDdWe6c3hNrxWMKaA3CiLyDZ5I
 Y/io7asYam8P3PQp5vwJOiuNmT6VG7wBwMYmumXteYswAjMqP5G75JiCDw5FTtnvXyBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KOlOlqn3F6cYxcA43eb53o7oslILy0EoaFfRsWzbr4k=; b=g
 JYhWmVlR0XPvFm/UbjlJTBqxLTiCD33Har67OU3eUzi7xQYCZCENcRkeArCWcvOPManZK5g/W0aaJ
 4BchhBNObOAu4eRspaJLX0Z1Kwka7XyDITQKTTF//VJNIUk2x3cmGRTt5sUEpm/OXX3D/OVaQeBlm
 22YFi/jr3RLRHSBk=;
Received: from mail-ej2-f12.google.com ([74.125.228.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Sfz-0002b0-Lp for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:54:27 +0000
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c29703cb470so591193166b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789476853; x=1790081653; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KOlOlqn3F6cYxcA43eb53o7oslILy0EoaFfRsWzbr4k=;
 b=PVD1EH5p7byz9goe8I7/robhYtvBOexBLudNn44odCt/FptwXjnDtIMH8XP8XKWaEv
 dnvmZgdkXvffMGbsKuGAVZ6DU9D7TxZwcpSVB7yzSD5SlfuQ8NWqNEQgAXb7BR5X4Zib
 biRE45q7ysKIO/gzip4sbFFfIFEgMaqnGTNlU08XTt0Opmni3jLrO+kD2NC1lnakj9MQ
 OX8dB3pyv8Pd48tuI5o+cYDWS36s5ZgSVKZf+62rR/BR5Rm4XPozCA/p8Eyip9EwFJgt
 mzjWQaV1Xq6MIq9HxXk0nbTU9W7ZSUmGYdMAwVn6/ldw72FN9+0NmnR4b5pM+Tv69Lz6
 +Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476853; x=1790081653;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KOlOlqn3F6cYxcA43eb53o7oslILy0EoaFfRsWzbr4k=;
 b=hYroi3PMUPI0GaWm0meDu8cDwKRr0uWCRM6xdslHO3A+Nnexfv1PcFVHy68zrkspiN
 o/vyQM4CP9070kmS1apeZt8rCArSJw7++Y9fKGGh+mm6Ii/gv9AMeLdlRuZ39kZVizNC
 nwgkhWFMfT2M8TDGykEzRqgS1knD0Mk1YiiO3fcK04qf6Jzea8g7m9S0MpzuMX8nRRQA
 XbEcdRD5bX+P9hicv7l9heDhFyho7N7rusS++pzJx/7pqxLL2kw896MS6YX9AruYwA43
 MconKE4/xA1hPRy7TIdqIj3vEkoacW6DPh6PC9Dhv+Wi1rzONsqMFGS1WybpSmTL/ci6
 TZKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1gRdS3J6tAgrcQWiESrR7i+HjH4nxzfFiicCSJf52QkFU3rH724DmWa3W66eXrEmgn7pTsr7r/fk0/Nds@lists.sourceforge.net
X-Gm-Message-State: AFuF++nxkarOcz0bUgKserERTtv2B6bjTgVQXvsQwAXK9eJNhvqmhZ+3
 qfxYLxVYr7iQ3RYWUnolwbPGwcD8yrluyFHuoDpfGfKk65nRz4WcYRFXI9011mAY3CPYj94VmOA
 MLR97jPJO20f2Y0pKidA/3nBnwAwL0vGUBjbo9Kb2eE18fp7om3fUTdcBkE5eSy+AmtE+
X-Gm-Gg: AYBFou26N7IfoOsm40nwhyNrq37Dza2ngFkJ+FshcBE7uJEvDlqNTZ3NWyFMBmt3OCC
 1KzsZC+EMXAgkaq9ZT5w9OyGCPRbVRDWrCYX+7bIX/sVIC+CnX9p2WWuJkz3EwemO1PkYqMIA6H
 OhhUWT/BGYMoe6z38kv5BD48QpDXCLit6y468Gpsj0y8OfGeOU91ApdXjNglcGB1N0tG7/RgP7j
 ZZTUxpZBH5cMRMmOKhebmYBTXAW+bs7Uu8B3B1oaWgfY37eaWrt5o3+yo8oQ2KYFm+k0ruAbm2s
 FaRvgYh2+wyGH20ZWxipPU7zJW2sujBZ0g0WpZaslONNP/6O9ojPEt33f6+bXS6jnsP5Jzu6Erz
 IVX66dhqZ4KgZGv74CKIrrT372dko86tRBD33viWAJW2hAqRZCcRIFxW/oec8uPt9DkrkSl7mRm
 VYTH8NvkUL4GSvYYXSk6EkK2YZJcnmh0xEok4muXvs4jb9pHJ+LVxJ60vXitjcglTGy/wdFYJNf
 PtYoV4fEZw7KU/y7BCKJRu8f3LJ3jK8ok80b6QMnqGQTGlx5d7wjYWe5JzeeMRUwu99/DoroV/W
 sOQu/KFcQfF5XPB0A63O1/OgzqvOEJ6/1cEG4RfZatqjO2rtDLEBXkXTVWeQhA==
X-Received: by 2002:a17:906:c112:b0:c29:450f:bdbe with SMTP id
 a640c23a62f3a-c29b8712bbemr887096666b.16.1789476852298; 
 Tue, 15 Sep 2026 05:54:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29852497b0sm455668366b.38.2026.09.15.05.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:54:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:54:09 +0000
To: flichtenheld <frank@lichtenheld.com>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 041f266f134ebc625810c269c2749f5571cca225
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <319716615cf05e6ec57f8f378c84596bdc688b01-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Sfz-0002b0-Lp
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6959708439418581008=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6959708439418581008==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wbMi+1Fllbw="; charset=UTF-8

--wbMi+1Fllbw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, razvanc=2E

Hello=
 MaxF, flichtenheld, 

I'd like you to reexamine a change=2E Please visit

=
    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail

to look at th=
e new patch set (#11)=2E


Change subject: Implement initial packet reflect=
ion protection using bloom filter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Implement initial packet reflection protection using=
 bloom filter

When an OpenVPN server is used/tried to be used in a reflect=
ion attack
the protection with the simple --connect-freq-initial also block=
s legitimate
clients from other networks that are not attacked by a reflect=
ion attack=2E

To allow a server to still reply to these clients, we need t=
o make the counts
rather more detailed and count per subnet or IP address=
=2E On the other hand
when we keep all this state, we eliminate the advanta=
ge of having a stateless
cookie based initial packet handshake=2E

As compr=
omise we use a bloom filter to store the information=2E This data
structure=
 is probabilistic and can have false positive and more packets
being droppe=
d but since it is a constant size and the size of this map
is small enough =
for non-embedded systems (tests were done with a 2MB
bloom filter), it is a=
 good compromise=2E

The code is split into the bloom filter implementation=
 and the actual logic
implementing tracking the subnets, so the bloom filte=
r should be relatively
easily be exchangable by another data structure=2E

=
As hash function SIPHASH has been chosen since it was designed for this kin=
d
of application=2E

Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
S=
igned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M =2Egithub/workflows/b=
uild=2Eyaml
M CMakeLists=2Etxt
M Changes=2Emd
M doc/man-sections/server-opt=
ions=2Erst
M src/openvpn/Makefile=2Eam
A src/openvpn/bloom=2Ec
A src/openvp=
n/bloom=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/op=
tions=2Ec
M src/openvpn/options=2Eh
M src/openvpn/ovpn_dco_linux=2Eh
M src/=
openvpn/reflect_filter=2Ec
M src/openvpn/reflect_filter=2Eh
M tests/unit_te=
sts/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_reflect=2Ec
A tes=
ts/unit_tests/openvpn/test_reflect=2Eh
M tests/unit_tests/openvpn/test_ssl=
=2Ec
18 files changed, 1,431 insertions(+), 98 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/30/11

diff --git =
a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index=
 56dd3ed=2E=2E1a22f0f 100644
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
index cfb7226=2E=2Ec6e26ee 100644
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
c/openvpn/check_file_access=2Ec
@@ -812,8 +813,11 @@
             tests/uni=
t_tests/openvpn/mock_management=2Ec
             tests/unit_tests/openvpn/m=
ock_ssl_dependencies=2Ec
             tests/unit_tests/openvpn/mock_win32_e=
xecve=2Ec
+            tests/unit_tests/openvpn/test_reflect=2Ec
+         =
   tests/unit_tests/openvpn/test_reflect=2Eh
             src/openvpn/argv=
=2Ec
             src/openvpn/base64=2Ec
+            src/openvpn/bloom=2Ec=

             src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_=
mbedtls=2Ec
             src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -826,7 +8=
30,11 @@
             src/openvpn/options_util=2Ec
             src/openvpn=
/otime=2Ec
             src/openvpn/packet_id=2Ec
+            src/openvpn/=
reflect_filter=2Ec
             src/openvpn/run_command=2Ec
+            sr=
c/openvpn/siphash=2Ec
+            src/openvpn/siphash=2Eh
+            src=
/openvpn/siphash_reference=2Ec
             src/openvpn/ssl_mbedtls=2Ec
   =
          src/openvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec=

diff --git a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2E10467f5 100644=

--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,14 @@
   the characters=
 mentioned above were already escaped=2E However, the behavior of
   Mbed T=
LS is slightly different from OpenSSL in that it also escapes "=3D"=2E
 
+*=
 **Bloom filter based reflection protection**
+
+  To avoid the limitation =
of ``--connect-freq-initial`` to block legimitate
+  clients when an OpenVP=
N server is tried to be used in a reflection attack,
+  the new ``--connect=
-freq-initial-bloom-limit`` can impose limit on a
+  per-subnet basis=2E Se=
e the manual for more details=2E Note: this option
+  requires 2MB of extra=
 memory in the default configuration=2E
+
 # Overview of changes in 2=2E7
 =

 ## New features
diff --git a/doc/man-sections/server-options=2Erst b/doc/=
man-sections/server-options=2Erst
index 9dfa6bd=2E=2E05f30bf 100644
--- a/d=
oc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-options=
=2Erst
@@ -226,6 +226,77 @@
   will not be counted against the limit=2E The=
 default is to allow
   100 initial connection per 10s=2E
 
+
+--connect-fr=
eq-initial-bloom-size args
+
+   Valid syntax:
+   ::
+
+      connect-freq=
-initial-bloom-size size [numhashes]
+
+   Configures the size of the bloom=
 filter used for the initial connection
+   packet responses=2E See `--conn=
ect-freq-initial-bloom-limit` for a full
+   description of the feature=2E
=
+
+   Bloom filters are probabilistic by their nature and the larger the si=
ze
+   of the bloom filter is, the more accurate they are=2E This option co=
nfigures
+   the number of buckets in the bloom filter=2E Each bucket takes=
 up 4 bits=2E
+   E=2Eg=2E the default of  8336608 (8 * 2^20) when the opti=
on is not set
+   will require 2MB of memory=2E The numhashes will control =
the number of hash
+   functions that are used for the bloom filter=2E The =
default is 7=2E
+
+--connect-freq-initial-bloom-limit arg
+
+   Valid synta=
x:
+   ::
+
+      connect-freq-initial-bloom-limit inet netmask limit
+   =
   connect-freq-initial-bloom-limit inet6 netmask limit
+
+   This option i=
mplements a rate limiting function for initial packet like
+   ``--connect-=
freq-initial`` but takes the source of the initial packet into
+   account=
=2E This function shares the the reset after a time period and
+   enabling=
 this function will not disable the overall limit of
+   ``--conect-freq-in=
itial``=2E
+
+   To avoid resource exhaustion on the OpenVPN server side fr=
om reflection
+   attacks and also trying to avoid blocking legitimate clie=
nts when an
+   attacker tries to use an OpenVPN server, the limits are not=
 applied globally
+   but rather a per netmask granularity=2E Each line of =
this command configures
+   a separate granularity=2E As example, the follo=
wing configuration,
+
+   ::
+
+        connect-freq-initial 1000 60
+     =
   connect-freq-initial-bloom-limit inet 24 50
+        connect-freq-initia=
l-bloom-limit inet 8 100
+        connect-freq-initial-bloom-limit inet6 56=
 50
+        connect-freq-initial-bloom-limit inet6 32 100
+
+    will limi=
t the number of (unanswered) replies per /24 network to 50
+    packets=2E =
After 50 packets from the same /24, the server will
+    drop any further p=
ackets=2E Similarly, if a /16 network receives more than
+    100 connectio=
n requests, the server will drop further packets=2E
+    If the count of al=
l packets exceeds 1000, further packets will be
+    completely dropped reg=
ardless of their origin=2E
+
+   The implementation uses a counting bloom f=
ilter to store information of how
+   many packets the server has seen per =
subnet=2E A bloom filter is a
+   probabilistic data structure can yield fa=
lse positives=2E In this case, the
+   server will drop packets even though=
 the limit
+   for that particular subnet is not yet reached=2E Since we ar=
e using a
+   counting bloom filter, a reply from a client that triggers a =
removal of an
+   entry can also lead to a false negative=2E However, this =
is limited in the
+   sense a reply can at most trigger one false negative=
=2E
+
+   Every limit configured with this option will put more more entrie=
s into
+   the bloomfilter since per limit (per family), one entry is put i=
nto the
+   bloom filter=2E So a large number of entries requires a larger =
bloom filter
+   to avoid too many false positives=2E
+
+   IPv6 mapped IPv=
4 addresses (::ffff:0:0/96) are treated as IPv4 addresses
+   for these lim=
its=2E
+
 --duplicate-cn
   Allow multiple clients with the same common nam=
e to concurrently
   connect=2E In the absence of this option, OpenVPN will=
 disconnect a client
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/M=
akefile=2Eam
index 7ecddff=2E=2E950a74c 100644
--- a/src/openvpn/Makefile=
=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -46,6 +46,7 @@
 	auth_token=2Ec au=
th_token=2Eh \
 	base64=2Ec base64=2Eh \
 	basic=2Eh \
+	bloom=2Ec bloom=2E=
h \
 	buffer=2Ec buffer=2Eh \
 	check_file_access=2Ec check_file_access=2Eh=
 \
 	circ_list=2Eh \
diff --git a/src/openvpn/bloom=2Ec b/src/openvpn/bloom=
=2Ec
new file mode 100644
index 0000000=2E=2Efabb7ad
--- /dev/null
+++ b/sr=
c/openvpn/bloom=2Ec
@@ -0,0 +1,248 @@
+/*
+ *  OpenVPN -- An application to=
 securely tunnel IP networks
+ *             over a single TCP/UDP port, wi=
th support for SSL/TLS-based
+ *             session authentication and key=
 exchange,
+ *             packet encryption, packet authentication, and
+ =
*             packet compression=2E
+ *
+ *  Copyright (C) 2023-2026 OpenVP=
N Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne Schwabe <arne=
@rfc2549=2Eorg>
+ *
+ *  This program is free software; you can redistribut=
e it and/or modify
+ *  it under the terms of the GNU General Public Licens=
e version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  T=
his program is distributed in the hope that it will be useful,
+ *  but WIT=
HOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILIT=
Y or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public L=
icense for more details=2E
+ *
+ *  You should have received a copy of the =
GNU General Public License along
+ *  with this program; if not, see <https=
://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/* This file implements a speciali=
sed counting bloom filter implementation
+ * used in OpenVPN to mitigate it=
 being used in reflection attacks=2E The bloom
+ * implementation should be=
 general enough to be used in other contexts
+ * however */
+
+#ifdef HAVE_=
CONFIG_H
+#include "config=2Eh"
+#elif defined(_MSC_VER)
+#include "config-=
msvc=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+
+#include <stdint=2Eh>
+#in=
clude <stddef=2Eh>
+#include <stdlib=2Eh>
+#include <string=2Eh>
+#include =
<stdbool=2Eh>
+#include "siphash=2Eh"
+#include "crypto=2Eh"
+
+#include "b=
loom=2Eh"
+
+
+static size_t
+calc_ceil_log2(size_t num)
+{
+    /* Figure =
out how many bits we have in our hash by doing
+     * ceil(log2(bf->size) =
*/
+
+    size_t numbits =3D 0;
+    while (num >>=3D 1)
+    {
+        nu=
mbits++;
+    }
+    return numbits;
+}
+
+/**
+ * Calculate number of byte=
s needed for each hash function in the bloom filter
+ *
+ */
+static inline=
 size_t
+calculate_num_bytes_hashfun(size_t size)
+{
+    size_t hash_bits =
=3D calc_ceil_log2(size);
+    /* round up to the nearest byte size */
+   =
 size_t hash_bytes =3D (hash_bits + 7) / 8;
+    return hash_bytes;
+}
+
+/=
**
+ * A bloom filter uses a number of hashes to perform its functionality=
=2E
+ *
+ * Instead of using the same number of siphash function we split t=
he bytes of
+ * the siphash to the different hashes=2E
+ *
+ * We could als=
o optimise this further by splitting at the bit level but that
+ * crates a=
 lot of extra code for bit shifting, etc=2E so we waste some bits
+ *
+ * @=
param bf
+ * @param num_hashes
+ * @return
+ */
+size_t
+calculate_num_sip_=
hash_hashes(struct bloom_filter *bf)
+{
+    size_t hash_bytes =3D calculat=
e_num_bytes_hashfun(bf->size);
+    size_t total_bytes =3D bf->num_hashes *=
 hash_bytes;
+
+    /* Round up to next SIPHASH_HASH_SIZE */
+    size_t nu=
m_siphash =3D (total_bytes + BLOOM_HASH_SIZE - 1) / BLOOM_HASH_SIZE;
+
+   =
 return num_siphash;
+}
+
+/**
+ * Calculates the number of bytes we need f=
or storing a bloom filter of size
+ * size=2E */
+static inline size_t
+blo=
om_get_filter_byte_count(size_t size)
+{
+    size_t bits_required =3D size=
 * BLOOM_FILTER_BITS_COUNT;
+    /* Add 7 round up to the next byte */
+   =
 return (bits_required + 7) / 8;
+}
+
+
+static inline size_t
+bloom_get_fi=
lter_bit_offset(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_BITS_C=
OUNT) % (8 * sizeof(bloom_counter_t));
+}
+
+static inline size_t
+bloom_ge=
t_filter_array_index(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_B=
ITS_COUNT) / (8 * sizeof(bloom_counter_t));
+}
+
+static inline bloom_count=
er_t
+bloom_get_filter_get_counter(struct bloom_filter *bf, size_t bucket)
=
+{
+    static_assert((BLOOM_FILTER_BITS_MASK + 1) =3D=3D (1 << BLOOM_FILTE=
R_BITS_COUNT),
+                  "BLOOM_FILTER_BITMASK and BLOOM_FILTER_BI=
T_COUNT are inconsistent");
+
+    bloom_counter_t counter =3D bf->buckets[=
bloom_get_filter_array_index(bucket)];
+    size_t bitoffset =3D bloom_get_=
filter_bit_offset(bucket);
+
+    return (counter >> bitoffset) & BLOOM_FIL=
TER_BITS_MASK;
+}
+
+static inline void
+bloom_set_filter_counter(struct bl=
oom_filter *bf, size_t bucket, bloom_counter_t value)
+{
+    bloom_counter=
_t data =3D bf->buckets[bloom_get_filter_array_index(bucket)];
+    size_t =
bitoffset =3D bloom_get_filter_bit_offset(bucket);
+
+    data =3D data & ~=
(BLOOM_FILTER_BITS_MASK << bitoffset);
+
+    data =3D data | ((value & BLO=
OM_FILTER_BITS_MASK) << bitoffset);
+
+    bf->buckets[bloom_get_filter_arr=
ay_index(bucket)] =3D data;
+}
+
+/**
+ * Creates a new bloom filter struct=
ure
+ * @param size the number of buckets=2E
+ * @return  the newly created=
 bloom filter structure
+ */
+struct bloom_filter *
+bloom_create(size_t si=
ze, size_t num_hashes, struct gc_arena *gc)
+{
+    size_t bloomfilter_byte=
s =3D bloom_get_filter_byte_count(size);
+    struct bloom_filter *bf =3D g=
c_malloc(sizeof(struct bloom_filter) + bloomfilter_bytes,
+                =
                        false, gc);
+    bf->size =3D size;
+    bf->num_ha=
shes =3D num_hashes;
+
+    bf->hash_bytes =3D calculate_num_bytes_hashfun(=
size);
+    bf->num_siphash =3D calculate_num_sip_hash_hashes(bf);
+
+    A=
LLOC_ARRAY_GC(bf->siphash_keys, struct siphash_key, bf->num_siphash, gc);
+=
    bloom_clear(bf);
+    return bf;
+}
+
+/**
+ * Clear the bloom filter, =
making it empty again as if it were freshly created
+ * @param bf the bloom=
 structure to clear
+ */
+void
+bloom_clear(struct bloom_filter *bf)
+{
+  =
  memset(bf->buckets, 0, bloom_get_filter_byte_count(bf->size));
+
+    /* =
We randomise the bloom filter keys on every clear of the bloom filter
+    =
 * to avoid scenarios where an attacker might learn specific pattern
+     =
* that could exploit false positives in the bloom filter */
+    for (size_=
t i =3D 0; i < bf->num_siphash; i++)
+    {
+        prng_bytes(bf->siphash=
_keys[i]=2Ekey, SIPHASH_KEY_SIZE);
+    }
+}
+
+
+static bloom_counter_t
+b=
loom_add_test(struct bloom_filter *bf, const uint8_t *item, size_t len, blo=
om_counter_t inc)
+{
+    uint8_t result[BLOOM_HASH_SIZE];
+    size_t j =
=3D 0;
+    size_t idx =3D 0;
+    bloom_counter_t ret =3D bloom_counter_ma=
x;
+
+    for (size_t i =3D 0; i < bf->num_hashes; i++)
+    {
+        siz=
e_t bucket =3D 0;
+        for (size_t k =3D 0; k < bf->hash_bytes; k++)
+ =
       {
+            if (idx =3D=3D 0)
+            {
+                /* =
We have no longer unused bytes in result, generate the next hash */
+      =
          siphash(item, len, bf->siphash_keys[j++]=2Ekey, result, BLOOM_HAS=
H_SIZE);
+            }
+
+            bucket =3D bucket << 8;
+           =
 bucket |=3D result[idx];
+
+            idx =3D (idx + 1) % BLOOM_HASH_SIZ=
E;
+        }
+
+        bucket =3D bucket % bf->size;
+        bloom_count=
er_t value =3D bloom_get_filter_get_counter(bf, bucket);
+
+        ret =3D=
 min_bloom_counter(ret, value);
+
+        if (inc)
+        {
+           =
 value =3D min_bloom_counter(bloom_counter_max, value + 1);
+            bl=
oom_set_filter_counter(bf, bucket, value);
+        }
+    }
+    return re=
t;
+}
+
+
+bloom_counter_t
+bloom_add(struct bloom_filter *bf, const uint8_=
t *item, size_t len)
+{
+    return bloom_add_test(bf, item, len, 1);
+}
+
=
+bloom_counter_t
+bloom_remove(struct bloom_filter *bf, const uint8_t *item=
, size_t len)
+{
+    return bloom_add_test(bf, item, len, -1);
+}
+
+
+blo=
om_counter_t
+bloom_test(struct bloom_filter *bf, const uint8_t *item, size=
_t len)
+{
+    return bloom_add_test(bf, item, len, 0);
+}
diff --git a/sr=
c/openvpn/bloom=2Eh b/src/openvpn/bloom=2Eh
new file mode 100644
index 0000=
000=2E=2E8d814d5
--- /dev/null
+++ b/src/openvpn/bloom=2Eh
@@ -0,0 +1,147 @=
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
+#ifndef BLOOM_H
+#define BLOOM_H
+
+#include <stdint=2Eh>
+#include "s=
iphash=2Eh"
+#include "buffer=2Eh"
+
+/* This is the type we use for the bu=
ckets=2E This is split into small buckets
+ * with BLOOM_FILTER_BITS_COUNT =
size */
+typedef uint32_t bloom_counter_t;
+#define BLOOM_FILTER_BITS_COUNT=
 4
+#define BLOOM_FILTER_BITS_MASK  0x0f
+#define bloom_counter_max       0=
x0f
+
+/* we want bloom_counter_t bits to be a multiple of BLOOM_FILTER_BIT=
S_COUNT to
+ * allow our operations to calculate bucket indexes to assume t=
hat that a bucket
+ * is always inside a single index bloom_counter_t and n=
ever stretches over
+ * two adjacent bloom_counter_t */
+static_assert((siz=
eof(bloom_counter_t) * 8) % BLOOM_FILTER_BITS_COUNT =3D=3D 0,
+            =
  "bloom_counter_t must be a multiple of BLOOM_FILTER_BIT_COUNT");
+
+/* We=
 use 64 bit output from siphash for the bloom filter */
+#define BLOOM_HASH=
_SIZE 8
+
+static inline bloom_counter_t
+min_bloom_counter(bloom_counter_t=
 x, bloom_counter_t y)
+{
+    if (x < y)
+    {
+        return x;
+    }
=
+    else
+    {
+        return y;
+    }
+}
+
+struct siphash_key
+{
+   =
 uint8_t key[SIPHASH_KEY_SIZE];
+};
+
+/**
+ * A structure holding a bloom =
filter=2E A bloom filter is a probabilistic
+ * data structure used to test=
 whether an element is a member of a set=2E
+ * It may return false positiv=
es but never false negatives=2E
+ *
+ * A bloom filter has a size N of entr=
ies, and each entry or bucket is a
+ * counter=2E E=2Eg=2E a bloom filer of=
 size 1024 with entries of 4 bits each
+ * will have 4096 bits or 512 bytes=
 in total size=2E
+ *
+ * Whenever an entry is added to the bloom filter, n=
 hash function are
+ * calculated=2E These map a key -> [0, size of bloom f=
ilter]=2E For each of
+ * hash function use the result as index for the buc=
ket to increase the
+ * counter=2E
+ *
+ * For our example of a bloom filte=
r with 1024 entries and 5 hash functions,
+ * hashing an entry might yield =
77,323, 662, 789, and 8=2E That would then
+ * increase the buckets (bit co=
unters) at the the index positions 77, 323,
+ * 662, 789, and 8=2E If an en=
try is at its maximum (15 for 4 bits counters)
+ * it will stop increasing =
the counter=2E
+ *
+ * To test if an entry is in the bloom filter we do the=
 same hashing and
+ * check if all the counters positions have at least a v=
alue of 1=2E
+ *
+ * Removing an entry is similar to adding an entry, we de=
crement the
+ * counter at each bit position=2E But with the caveat that bu=
ckets with
+ * already at maximum, the counter is not decremented in order =
to preserve
+ * the property of never false negatives=2E
+ *
+ * Instead of=
 using n separate hash functions that map to output log(N) bits,
+ * our im=
plementation uses multiple siphash functions with 64 bit output
+ * and sli=
ces them into multiple hash functions of log(N) bits=2E
+ *
+ * E=2Eg=2E wh=
en using a bloom filter of size 1048576 (1024 * 1024),
+ * we need 20 bits =
output for each of the hash functions=2E We round up
+ * to bytes, So that =
are 3 bytes=2E To realize 7 hash function we need
+ * then 21 bytes or thre=
e siphash function each with 8 byte (64 bit)
+ */
+struct bloom_filter
+{
+=
    /** Size (N) of the bloom filter in entries
+     * This is also equal =
to (total bits)/(bits per counter) */
+    size_t size;
+
+    /** Number o=
f bytes used by each hash function=2E
+     *
+     * log2(size * 8) bits r=
ounded up to the next byte
+     *
+     * This is a cached value since log=
2 is surprisingly slow
+     * (5% of total time of if we do not cache it) =
*/
+    size_t hash_bytes;
+
+    /** number of hashes (n) we use to determ=
ine the bit positions */
+    size_t num_hashes;
+
+    /** number of sipha=
sh functions needed to calculate=2E This can be
+     * calculated from the=
 other members of the struct but we store it
+     * in the struct for fast=
 access */
+    size_t num_siphash;
+
+    /** keys for the siphash functio=
ns */
+    struct siphash_key *siphash_keys;
+
+    /** the actual buckets =
that hold the data */
+    bloom_counter_t buckets[];
+};
+
+
+struct bloom=
_filter *
+bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc=
);
+
+bloom_counter_t
+bloom_test(struct bloom_filter *bf, const uint8_t *i=
tem, size_t len);
+
+bloom_counter_t
+bloom_add(struct bloom_filter *bf, co=
nst uint8_t *item, size_t len);
+
+bloom_counter_t
+bloom_remove(struct blo=
om_filter *bf, const uint8_t *item, size_t len);
+
+void
+bloom_clear(struc=
t bloom_filter *bf);
+#endif /* ifndef BLOOM_H */
diff --git a/src/openvpn/=
mudp=2Ec b/src/openvpn/mudp=2Ec
index 73e1386=2E=2E60ea823 100644
--- a/src=
/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -33,6 +33,7 @@
 #include "m=
emdbg=2Eh"
 #include "ssl_pkt=2Eh"
 #include "sid_hash=2Eh"
+#include "refl=
ect_filter=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@=
 -129,7 +130,7 @@
     {
         /* Check if we are still below our limit =
for sending out
          * responses */
-        if (!reflect_filter_rate_=
limit_check(m->initial_rate_limiter))
+        if (!reflect_filter_check(m-=
>initial_rate_limiter, from))
         {
             return PRE_DECRYPT_NO=
_ACTION;
         }
@@ -268,9 +269,10 @@
 
         if (frequency_limit_eve=
nt_allowed(m->new_connection_limiter))
         {
+            struct link_=
socket_actual *from =3D &m->top=2Ec2=2Efrom;
             /* a successful t=
hree-way handshake only counts against
              * connect-freq but not=
 against connect-freq-initial */
-            reflect_filter_rate_limit_dec=
rease(m->initial_rate_limiter);
+            reflect_filter_rate_limit_decr=
ease(m->initial_rate_limiter, &from->dest);
 
             mi =3D multi_cre=
ate_instance(m, real, sock);
             if (mi)
@@ -284,7 +286,7 @@
     =
            {
                     ASSERT(session_id_defined(&state=2Epeer_=
session_id));
                     mi->context=2Ec2=2Etls_multi->n_sessions=
++;
-                    session_skip_to_pre_start(session, &state, &m->top=
=2Ec2=2Efrom);
+                    session_skip_to_pre_start(session, &sta=
te, from);
                 }
                 multi_hash_sid_add(m, &state=
=2Epeer_session_id, mi);
             }
diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec
index 486210e=2E=2E0127b48 100644
--- a/src/openvpn=
/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -330,9 +330,12 @@
      * Limit f=
requency of incoming connections to control
      * DoS=2E
      */
-    m-=
>new_connection_limiter =3D frequency_limit_init(t->options=2Ecf_max, t->op=
tions=2Ecf_per);
-    m->initial_rate_limiter =3D
-        initial_rate_lim=
it_init(t->options=2Ecf_initial_max, t->options=2Ecf_initial_per);
+    m->=
new_connection_limiter =3D frequency_limit_init(t->options=2Ecf_max,
+     =
                                                t->options=2Ecf_per);
+    =
m->initial_rate_limiter =3D initial_rate_limit_init(t->options=2Ecf_initial=
_max,
+                                                      t->options=2Ec=
f_initial_per,
+                                                      &t->o=
ptions=2Einitial_cf_bloom_config);
+
 
     /*
      * Allocate broadcast/m=
ulticast buffer list
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opt=
ions=2Ec
index f9d60f6=2E=2E7b066c1 100644
--- a/src/openvpn/options=2Ec
++=
+ b/src/openvpn/options=2Ec
@@ -2638,6 +2638,23 @@
 }
 
 static void
+check=
_filter_tier_under_global_limit(struct filter_tier *ft, int limit,
+       =
                              const char *family)
+{
+    while (ft)
+    {=

+        if (ft->limit < limit)
+        {
+            msg(M_WARN, "Note:=
 --connect-freq-initial-bloom-limit %s %d %d "
+                        "ha=
s a larger limit than connect-freq-limit-initial "
+                       =
 "limit (%d)=2E",
+                family, ft->netmask, ft->limit, limit);
=
+        }
+        ft =3D ft->next;
+    }
+}
+
+static void
 options_post=
process_verify(const struct options *o)
 {
     if (o->connection_list)
@@ =
-2672,6 +2689,18 @@
                         "Ignoring these options=2E");
=
         }
     }
+
+    if ((bool)(o->initial_cf_bloom_config=2Einet_tiers=
)
+            + (bool)(o->initial_cf_bloom_config=2Einet6_tiers)
+        =
=3D=3D 1)
+    {
+        msg(M_FATAL, "connect-freq-initial-bloom-limit mu=
st be provided for "
+                     "both inet and inet6");
+    }
+=
    check_filter_tier_under_global_limit(o->initial_cf_bloom_config=2Einet_=
tiers,
+                                         o->cf_initial_max, "inet")=
;
+    check_filter_tier_under_global_limit(o->initial_cf_bloom_config=2Ein=
et6_tiers,
+                                         o->cf_initial_max, "in=
et6");
 }
 
 static void
@@ -5991,6 +6020,73 @@
         options->cf_initia=
l_max =3D cf_max;
         options->cf_initial_per =3D cf_per;
     }
+    =
else if (streq(p[0], "connect-freq-initial-bloom-size") && p[1] && !p[3])
+=
    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+
+        int cf_bloom_si=
ze =3D atoi(p[1]);
+
+        if (cf_bloom_size <=3D 0)
+        {
+       =
     msg(msglevel, "--connect-freq-initial-bloom-size size must be > 0");
+=
            goto err;
+        }
+        options->initial_cf_bloom_config=
=2Esize =3D cf_bloom_size;
+        if (p[2])
+        {
+            int n=
um_hash =3D atoi(p[1]);
+            if (num_hash <=3D 0)
+            {
+ =
               msg(msglevel, "--connect-freq-initial-bloom-size number of h=
ash "
+                              "functions must be > 0");
+           =
     goto err;
+            }
+            options->initial_cf_bloom_config=
=2Enum_hashes =3D num_hash;
+        }
+    }
+    else if (streq(p[0], "co=
nnect-freq-initial-bloom-limit") && p[1] && p[2]
+             && p[3] && !=
p[4])
+    {
+        int netmask =3D atoi(p[2]);
+        int limit =3D at=
oi(p[3]);
+
+        if (limit <=3D 0)
+        {
+            msg(msglevel=
, "Limit parameter to %s must be > 0", p[0]);
+            goto err;
+     =
   }
+
+        if (streq(p[1], "inet"))
+        {
+            if (netmas=
k < 0 || netmask > 32)
+            {
+                msg(msglevel, "Netma=
sk parameter (%s) for IPv4 for %s must be "
+                              =
"between 0 and 32",
+                    p[2], p[0]);
+                goto=
 err;
+            }
+            reflect_add_filter_tier(&options->initial=
_cf_bloom_config,
+                                    &options->gc, false,=
 netmask, limit);
+        }
+        else if (streq(p[1], "inet6"))
+     =
   {
+            if (netmask < 0 || netmask > 128)
+            {
+       =
         msg(msglevel, "Netmask parameter (%s) for IPv6 for %s must be "
+ =
                             "between 0 and 128",
+                    p[2]=
, p[0]);
+                goto err;
+            }
+            reflect_add=
_filter_tier(&options->initial_cf_bloom_config,
+                          =
          &options->gc, true, netmask, limit);
+        }
+        else
+  =
      {
+            msg(msglevel, "Unknown parameter %s for %s=2E Must be =
inet or inet6",
+                p[1], p[0]);
+            goto err;
+     =
   }
+    }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
    =
 {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/opti=
ons=2Eh b/src/openvpn/options=2Eh
index 3c05cd5=2E=2E7e24ef7 100644
--- a/s=
rc/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -42,6 +42,7 @@
 #in=
clude "clinat=2Eh"
 #include "crypto_backend=2Eh"
 #include "dns=2Eh"
+#inc=
lude "reflect_filter=2Eh"
 
 
 /*
@@ -533,6 +534,8 @@
     int cf_initial_m=
ax;
     int cf_initial_per;
 
+    struct bloom_filter_conf initial_cf_blo=
om_config;
+
     uint32_t max_clients;
     int max_routes_per_client;
   =
  int stale_routes_check_interval;
diff --git a/src/openvpn/ovpn_dco_linux=
=2Eh b/src/openvpn/ovpn_dco_linux=2Eh
index b3c9ff0=2E=2E7366177 100644
---=
 a/src/openvpn/ovpn_dco_linux=2Eh
+++ b/src/openvpn/ovpn_dco_linux=2Eh
@@ -=
6,105 +6,113 @@
 #ifndef _UAPI_LINUX_OVPN_H
 #define _UAPI_LINUX_OVPN_H
 
-=
#define OVPN_FAMILY_NAME	"ovpn"
-#define OVPN_FAMILY_VERSION	1
+#define OVP=
N_FAMILY_NAME    "ovpn"
+#define OVPN_FAMILY_VERSION 1
 
-#define OVPN_NONC=
E_TAIL_SIZE	8
+#define OVPN_NONCE_TAIL_SIZE 8
 
-enum ovpn_cipher_alg {
-	O=
VPN_CIPHER_ALG_NONE,
-	OVPN_CIPHER_ALG_AES_GCM,
-	OVPN_CIPHER_ALG_CHACHA20_=
POLY1305,
+enum ovpn_cipher_alg
+{
+    OVPN_CIPHER_ALG_NONE,
+    OVPN_CIP=
HER_ALG_AES_GCM,
+    OVPN_CIPHER_ALG_CHACHA20_POLY1305,
 };
 
-enum ovpn_d=
el_peer_reason {
-	OVPN_DEL_PEER_REASON_TEARDOWN,
-	OVPN_DEL_PEER_REASON_US=
ERSPACE,
-	OVPN_DEL_PEER_REASON_EXPIRED,
-	OVPN_DEL_PEER_REASON_TRANSPORT_E=
RROR,
-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+enum ovpn_del_peer_reas=
on
+{
+    OVPN_DEL_PEER_REASON_TEARDOWN,
+    OVPN_DEL_PEER_REASON_USERSPA=
CE,
+    OVPN_DEL_PEER_REASON_EXPIRED,
+    OVPN_DEL_PEER_REASON_TRANSPORT_=
ERROR,
+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
 };
 
-enum ovpn_key=
_slot {
-	OVPN_KEY_SLOT_PRIMARY,
-	OVPN_KEY_SLOT_SECONDARY,
+enum ovpn_key_=
slot
+{
+    OVPN_KEY_SLOT_PRIMARY,
+    OVPN_KEY_SLOT_SECONDARY,
 };
 
-en=
um {
-	OVPN_A_PEER_ID =3D 1,
-	OVPN_A_PEER_REMOTE_IPV4,
-	OVPN_A_PEER_REMOT=
E_IPV6,
-	OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
-	OVPN_A_PEER_REMOTE_PORT,
-	OV=
PN_A_PEER_SOCKET,
-	OVPN_A_PEER_SOCKET_NETNSID,
-	OVPN_A_PEER_VPN_IPV4,
-	O=
VPN_A_PEER_VPN_IPV6,
-	OVPN_A_PEER_LOCAL_IPV4,
-	OVPN_A_PEER_LOCAL_IPV6,
-	=
OVPN_A_PEER_LOCAL_PORT,
-	OVPN_A_PEER_KEEPALIVE_INTERVAL,
-	OVPN_A_PEER_KEE=
PALIVE_TIMEOUT,
-	OVPN_A_PEER_DEL_REASON,
-	OVPN_A_PEER_VPN_RX_BYTES,
-	OVP=
N_A_PEER_VPN_TX_BYTES,
-	OVPN_A_PEER_VPN_RX_PACKETS,
-	OVPN_A_PEER_VPN_TX_P=
ACKETS,
-	OVPN_A_PEER_LINK_RX_BYTES,
-	OVPN_A_PEER_LINK_TX_BYTES,
-	OVPN_A_=
PEER_LINK_RX_PACKETS,
-	OVPN_A_PEER_LINK_TX_PACKETS,
+enum
+{
+    OVPN_A_P=
EER_ID =3D 1,
+    OVPN_A_PEER_REMOTE_IPV4,
+    OVPN_A_PEER_REMOTE_IPV6,
+=
    OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+    OVPN_A_PEER_REMOTE_PORT,
+    OV=
PN_A_PEER_SOCKET,
+    OVPN_A_PEER_SOCKET_NETNSID,
+    OVPN_A_PEER_VPN_IPV=
4,
+    OVPN_A_PEER_VPN_IPV6,
+    OVPN_A_PEER_LOCAL_IPV4,
+    OVPN_A_PEER=
_LOCAL_IPV6,
+    OVPN_A_PEER_LOCAL_PORT,
+    OVPN_A_PEER_KEEPALIVE_INTERV=
AL,
+    OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+    OVPN_A_PEER_DEL_REASON,
+    O=
VPN_A_PEER_VPN_RX_BYTES,
+    OVPN_A_PEER_VPN_TX_BYTES,
+    OVPN_A_PEER_VP=
N_RX_PACKETS,
+    OVPN_A_PEER_VPN_TX_PACKETS,
+    OVPN_A_PEER_LINK_RX_BYT=
ES,
+    OVPN_A_PEER_LINK_TX_BYTES,
+    OVPN_A_PEER_LINK_RX_PACKETS,
+    =
OVPN_A_PEER_LINK_TX_PACKETS,
 
-	__OVPN_A_PEER_MAX,
-	OVPN_A_PEER_MAX =3D (=
__OVPN_A_PEER_MAX - 1)
+    __OVPN_A_PEER_MAX,
+    OVPN_A_PEER_MAX =3D (__=
OVPN_A_PEER_MAX - 1)
 };
 
-enum {
-	OVPN_A_KEYCONF_PEER_ID =3D 1,
-	OVPN_A=
_KEYCONF_SLOT,
-	OVPN_A_KEYCONF_KEY_ID,
-	OVPN_A_KEYCONF_CIPHER_ALG,
-	OVPN=
_A_KEYCONF_ENCRYPT_DIR,
-	OVPN_A_KEYCONF_DECRYPT_DIR,
+enum
+{
+    OVPN_A_=
KEYCONF_PEER_ID =3D 1,
+    OVPN_A_KEYCONF_SLOT,
+    OVPN_A_KEYCONF_KEY_ID=
,
+    OVPN_A_KEYCONF_CIPHER_ALG,
+    OVPN_A_KEYCONF_ENCRYPT_DIR,
+    OVP=
N_A_KEYCONF_DECRYPT_DIR,
 
-	__OVPN_A_KEYCONF_MAX,
-	OVPN_A_KEYCONF_MAX =3D=
 (__OVPN_A_KEYCONF_MAX - 1)
+    __OVPN_A_KEYCONF_MAX,
+    OVPN_A_KEYCONF_=
MAX =3D (__OVPN_A_KEYCONF_MAX - 1)
 };
 
-enum {
-	OVPN_A_KEYDIR_CIPHER_KEY=
 =3D 1,
-	OVPN_A_KEYDIR_NONCE_TAIL,
+enum
+{
+    OVPN_A_KEYDIR_CIPHER_KEY =
=3D 1,
+    OVPN_A_KEYDIR_NONCE_TAIL,
 
-	__OVPN_A_KEYDIR_MAX,
-	OVPN_A_KEY=
DIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)
+    __OVPN_A_KEYDIR_MAX,
+    OVPN_A=
_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)
 };
 
-enum {
-	OVPN_A_IFINDEX =
=3D 1,
-	OVPN_A_PEER,
-	OVPN_A_KEYCONF,
+enum
+{
+    OVPN_A_IFINDEX =3D 1,=

+    OVPN_A_PEER,
+    OVPN_A_KEYCONF,
 
-	__OVPN_A_MAX,
-	OVPN_A_MAX =3D =
(__OVPN_A_MAX - 1)
+    __OVPN_A_MAX,
+    OVPN_A_MAX =3D (__OVPN_A_MAX - 1=
)
 };
 
-enum {
-	OVPN_CMD_PEER_NEW =3D 1,
-	OVPN_CMD_PEER_SET,
-	OVPN_CMD_=
PEER_GET,
-	OVPN_CMD_PEER_DEL,
-	OVPN_CMD_PEER_DEL_NTF,
-	OVPN_CMD_KEY_NEW,=

-	OVPN_CMD_KEY_GET,
-	OVPN_CMD_KEY_SWAP,
-	OVPN_CMD_KEY_SWAP_NTF,
-	OVPN_C=
MD_KEY_DEL,
-	OVPN_CMD_PEER_FLOAT_NTF,
+enum
+{
+    OVPN_CMD_PEER_NEW =3D =
1,
+    OVPN_CMD_PEER_SET,
+    OVPN_CMD_PEER_GET,
+    OVPN_CMD_PEER_DEL,
=
+    OVPN_CMD_PEER_DEL_NTF,
+    OVPN_CMD_KEY_NEW,
+    OVPN_CMD_KEY_GET,
+=
    OVPN_CMD_KEY_SWAP,
+    OVPN_CMD_KEY_SWAP_NTF,
+    OVPN_CMD_KEY_DEL,
+=
    OVPN_CMD_PEER_FLOAT_NTF,
 
-	__OVPN_CMD_MAX,
-	OVPN_CMD_MAX =3D (__OVPN=
_CMD_MAX - 1)
+    __OVPN_CMD_MAX,
+    OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - =
1)
 };
 
-#define OVPN_MCGRP_PEERS	"peers"
+#define OVPN_MCGRP_PEERS "peers=
"
 
 #endif /* _UAPI_LINUX_OVPN_H */
diff --git a/src/openvpn/reflect_filte=
r=2Ec b/src/openvpn/reflect_filter=2Ec
index e5226e4=2E=2E88def88 100644
--=
- a/src/openvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filter=2Ec
@@ =
-5,7 +5,8 @@
  *             packet encryption, packet authentication, and
=
  *             packet compression=2E
  *
- *  Copyright (C) 2022-2026 Open=
VPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne Schwabe <arne@rfc2549=
=2Eorg>
  *
  *  This program is free software; you can redistribute it and=
/or modify
  *  it under the terms of the GNU General Public License versio=
n 2
@@ -37,8 +38,7 @@
 #include "crypto=2Eh"
 #include "reflect_filter=2Eh"=

 
-
-bool
+static bool
 reflect_filter_rate_limit_check(struct initial_pac=
ket_rate_limit *irl)
 {
     if (now > irl->last_period_reset + irl->period=
_length)
@@ -73,34 +73,380 @@
     return !over_limit;
 }
 
-void
-reflect_=
filter_rate_limit_decrease(struct initial_packet_rate_limit *irl)
+static v=
oid
+reset_filter_tier(struct initial_packet_rate_limit *irl,
+            =
      struct filter_tier *tier, const char *prefix)
 {
+    for (; tier !=
=3D NULL; tier =3D tier->next)
+    {
+        if (tier->dropped > 0)
+    =
    {
+            msg(D_TLS_DEBUG_LOW, "Dropped %zu initial handshake pack=
ets due to "
+                                 "--connect-freq-initial-bloo=
m-limit %s %d %d",
+                tier->dropped, prefix, tier->netmask, t=
ier->limit);
+            tier->dropped =3D 0;
+        }
+    }
+}
+
+stat=
ic void
+bloom_filter_check_reset(struct initial_packet_rate_limit *irl)
+{=

+    if (now > irl->last_period_reset + irl->period_length)
+    {
+      =
  reset_filter_tier(irl, irl->bloom_conf=2Einet_tiers, "inet");
+        re=
set_filter_tier(irl, irl->bloom_conf=2Einet6_tiers, "inet6");
+
+        bl=
oom_clear(irl->bf);
+    }
+}
+
+
+/**
+ * structure used as lookup key for=
 the bloom structure=2E We used the
+ * netmask as part of the structure to=
 avoid the look for the first
+ * IP of a subnet and the subnet to be same =
key=2E
+ */
+struct bloom_filter_key
+{
+    union
+    {
+        struct i=
n_addr in;
+        struct in6_addr in6;
+    };
+    int netmask;
+    /* =
we keep the count in the key instead of in the bloom filter table as
+     =
* can then keep the counter in the bloom filter itself small (2 bits)
+    =
 * and bloom filter usage is the same for 20000 request from the same IP
+ =
    * (20k entries with different count but same IP) and from 20000 random =
ips
+     * (20k entries with count 1 but different IP) */
+    int count;
=
+};
+
+static inline struct bloom_filter_key
+filter_mask_inet6(const struc=
t openvpn_sockaddr *addr, int netmask)
+{
+    struct bloom_filter_key ret =
=3D { 0 };
+    ret=2Ein6 =3D addr->addr=2Ein6=2Esin6_addr;
+
+    int bits=
_to_clear =3D 128 - netmask;
+    int bytes_to_clear =3D bits_to_clear / 8;=

+    bits_to_clear =3D bits_to_clear % 8;
+
+    memset(&ret=2Ein6=2Es6_ad=
dr[15 - bytes_to_clear], 0x00, bytes_to_clear);
+
+    ret=2Ein6=2Es6_addr[=
15 - bytes_to_clear - 1] &=3D (0xff << bits_to_clear);
+
+    ret=2Enetmask=
 =3D netmask;
+
+    return ret;
+}
+
+static inline struct bloom_filter_ke=
y
+filter_mask_inet(const struct openvpn_sockaddr *addr, int netmask)
+{
+ =
   struct bloom_filter_key ret =3D { 0 };
+    ret=2Ein =3D addr->addr=2Ein=
4=2Esin_addr;
+    ret=2Ein=2Es_addr &=3D htonl(0xffffffff << (32 - netmask=
));
+    ret=2Enetmask =3D netmask;
+    return ret;
+}
+
+/* We use one fu=
nction and an action argument to avoid repeating
+ * the code to iterate to=
 the tiers and the creating the lookup
+ * keys */
+enum bloom_filter_actio=
n
+{
+    REFLECT_CHECK,
+    REFLECT_INCREASE,
+    REFLECT_DECREASE,
+};
=
+
+static int
+reflect_lookup_bf_key(struct bloom_filter *bf, struct bloom_=
filter_key *key, int limit)
+{
+    /* we do a lookup for 1,2,3, and 4 and =
the limit first
+     * and after that do regular binary search=2E This is =
meant to optimise
+     * the common case where just a small number of requ=
ests are coming from
+     * each IP */
+    key->count =3D limit;
+    if =
(bloom_test(bf, (const uint8_t *)key, sizeof(struct bloom_filter_key)) > 0)=

+    {
+        return limit;
+    }
+
+    key->count =3D 4;
+    if (blo=
om_test(bf, (const uint8_t *)key, sizeof(struct bloom_filter_key)) =3D=3D 0=
)
+    {
+        /* The value for 4 has not been found, so the real value =
might be 1, 2, or 3=2E */
+        for (int i =3D 3; i > 0; i--)
+        {=

+            key->count =3D i;
+            if (bloom_test(bf, (const uint=
8_t *)key, sizeof(struct bloom_filter_key)) > 0)
+            {
+          =
      return i;
+            }
+        }
+
+        /* 4 was no in the map=
 and 1-3 are also not there, so assume the key is not in the map */
+      =
  return 0;
+    }
+
+    int low =3D 3;
+    int high =3D limit;
+
+    wh=
ile (low < high)
+    {
+        key->count =3D (high + low + 1) / 2;
+    =
    bloom_counter_t count =3D bloom_test(bf, (const uint8_t *)key, sizeof(s=
truct bloom_filter_key));
+        if (count > 0)
+        {
+            l=
ow =3D key->count;
+        }
+        else
+        {
+            high =
=3D key->count - 1;
+        }
+    }
+
+    if (low =3D=3D 4)
+    {
+    =
    /* we reached the lower end of our binary search have not found the
+  =
       * key and we know that 4 is in the map */
+        return 4;
+    }
=
+    else
+    {
+        return low;
+    }
+}
+
+/**
+ * Convert a mapped=
 IPv6 mapped IPv4 address (::ffff:0:0/96) to an
+ * equivalent IPv4 adress=
=2E
+ *
+ * @note: This function only converts the IP itself and ignores ot=
her
+ * parts of the \c from structure like port or protocol=2E
+ */
+stati=
c struct openvpn_sockaddr
+convert_mapped_inet_sockaddr(const struct openvp=
n_sockaddr *from)
+{
+    struct openvpn_sockaddr from_mapped =3D { 0 };
+ =
   /* we ignore the fields like port that the key in the bloom filter
+    =
 * ignores too=2E This makes this function non-generic */
+
+    from_mappe=
d=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+
+    memcpy(&from_mapped=2Eaddr=
=2Ein4=2Esin_addr=2Es_addr,
+           &from->addr=2Ein6=2Esin6_addr=2Es6_=
addr[12],
+           sizeof(from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_addr))=
;
+
+    return from_mapped;
+}
+
+static bool
+bloom_filter_action(struct =
initial_packet_rate_limit *irl,
+                    const struct openvpn_s=
ockaddr *from,
+                    enum bloom_filter_action action)
+{
+  =
  bool found =3D false;
+    struct filter_tier *tier =3D NULL;
+
+    stru=
ct openvpn_sockaddr from_mapped;
+
+    if (from->addr=2Esa=2Esa_family =3D=
=3D AF_INET6
+        && IN6_IS_ADDR_V4MAPPED(&from->addr=2Ein6=2Esin6_addr=
))
+    {
+        from_mapped =3D convert_mapped_inet_sockaddr(from);
+   =
     from =3D &from_mapped;
+    }
+
+    if (from->addr=2Esa=2Esa_family =
=3D=3D AF_INET)
+    {
+        tier =3D irl->bloom_conf=2Einet_tiers;
+   =
 }
+    else if (from->addr=2Esa=2Esa_family =3D=3D AF_INET6)
+    {
+     =
   tier =3D irl->bloom_conf=2Einet6_tiers;
+    }
+
+    while (tier)
+    =
{
+        struct filter_tier *next_tier =3D tier->next;
+        struct bl=
oom_filter_key key;
+
+        if (from->addr=2Esa=2Esa_family =3D=3D AF_IN=
ET6)
+        {
+            key =3D filter_mask_inet6(from, tier->netmask)=
;
+        }
+        else
+        {
+            key =3D filter_mask_inet=
(from, tier->netmask);
+        }
+
+        /* fetch the current count of =
the key in the bloom filter */
+        int result =3D reflect_lookup_bf_ke=
y(irl->bf, &key, tier->limit);
+        struct gc_arena gc =3D gc_new();
+ =
       gc_free(&gc);
+
+        switch (action)
+        {
+            cas=
e REFLECT_CHECK:
+                if (result >=3D tier->limit)
+           =
     {
+                    found =3D true;
+                    tier->drop=
ped++;
+                    if (tier->dropped =3D=3D 1)
+                  =
  {
+                        msg(M_WARN, "Note: --connect-freq-initial-bloo=
m-limit "
+                                    "limit for netmask /%d excee=
ded=2E Expect additional "
+                                    "initial pa=
cket drops for the next %d seconds",
+                            tier->net=
mask,
+                            (int)(irl->last_period_reset + irl->peri=
od_length - now));
+                    }
+                }
+             =
   break;
+
+            case REFLECT_INCREASE:
+                ASSERT(res=
ult < tier->limit);
+                key=2Ecount =3D result + 1;
+         =
       bloom_add(irl->bf, (const uint8_t *)&key, sizeof(key));
+           =
     break;
+
+            case REFLECT_DECREASE:
+                key=2Eco=
unt =3D result - 1;
+                bloom_remove(irl->bf, (const uint8_t *=
)&key, sizeof(key));
+                break;
+        }
+
+        tier =3D=
 next_tier;
+    }
+    if (!found && action =3D=3D REFLECT_CHECK)
+    {
+=
        /* We only want to increase the counters if the IP is not already
+=
         * in the set=2E */
+        bloom_filter_action(irl, from, REFLECT=
_INCREASE);
+    }
+    return found;
+}
+
+static bool
+bloom_filter_check=
(struct initial_packet_rate_limit *irl,
+                   const struct op=
envpn_sockaddr *from)
+{
+    if (now > irl->last_period_reset + irl->perio=
d_length)
+    {
+        bloom_filter_check_reset(irl);
+        bloom_cle=
ar(irl->bf);
+    }
+
+    return bloom_filter_action(irl, from, REFLECT_CH=
ECK);
+}
+
+
+bool
+reflect_filter_check(struct initial_packet_rate_limit *=
irl,
+                     const struct openvpn_sockaddr *from)
+{
+    /* =
We are doing the bloom filter check first so packets that are already
+    =
 * rejected by the bloom filter do not count against the limit of the
+    =
 * simple rate limiter */
+    if (irl->bf && bloom_filter_check(irl, from)=
)
+    {
+        return false;
+    }
+
+    if (!reflect_filter_rate_limi=
t_check(irl))
+    {
+        return false;
+    }
+
+    return true;
+}
+=

+
+void
+reflect_filter_rate_limit_decrease(struct initial_packet_rate_lim=
it *irl, struct openvpn_sockaddr *from)
+{
+    if (irl->bf && bloom_filter=
_action(irl, from, REFLECT_CHECK))
+    {
+        /* Only remove if it is =
actually present=2E This might be a packet
+         * coming from an early=
 period or be relayed */
+        bloom_filter_action(irl, from, REFLECT_DE=
CREASE);
+    }
+
     if (irl->curr_period_counter > 0)
     {
         ir=
l->curr_period_counter--;
     }
 }
 
+void
+reflect_add_filter_tier(struct=
 bloom_filter_conf *bfconf, struct gc_arena *gc,
+                        b=
ool ipv6, int netmask, int limit)
+{
+    struct filter_tier *ftnew =3D gc_=
malloc(sizeof(struct filter_tier), true, gc);
+
+    ftnew->netmask =3D net=
mask;
+    ftnew->limit =3D limit;
+
+    if (ipv6)
+    {
+        ftnew->=
next =3D bfconf->inet6_tiers;
+        bfconf->inet6_tiers =3D ftnew;
+    =
}
+    else
+    {
+        ftnew->next =3D bfconf->inet_tiers;
+        bf=
conf->inet_tiers =3D ftnew;
+    }
+}
+
+void
+init_bloom_filter(struct ini=
tial_packet_rate_limit *irl)
+{
+    if (!irl->bloom_conf=2Esize)
+    {
+ =
       /* the default allocates 2MB for bloom filter entries */
+        ir=
l->bloom_conf=2Esize =3D 1024ul * 1024 * 8;
+    }
+    if (!irl->bloom_con=
f=2Enum_hashes)
+    {
+        irl->bloom_conf=2Enum_hashes =3D 7;
+    }
=
+
+    irl->bf =3D bloom_create(irl->bloom_conf=2Esize, irl->bloom_conf=2En=
um_hashes,
+                           &irl->gc);
+    bloom_clear(irl->bf)=
;
+}
 
 struct initial_packet_rate_limit *
-initial_rate_limit_init(int max=
_per_period, int period_length)
+initial_rate_limit_init(int max_per_period=
, int period_length,
+                        struct bloom_filter_conf *bco=
nf)
 {
-    struct initial_packet_rate_limit *irl;
+    struct initial_pack=
et_rate_limit *irl =3D NULL;
+    ALLOC_OBJ_CLEAR(irl, struct initial_packe=
t_rate_limit);
 
-
-    ALLOC_OBJ(irl, struct initial_packet_rate_limit);
+=
    irl->gc =3D gc_new();
 
     irl->max_per_period =3D max_per_period;
  =
   irl->period_length =3D period_length;
     irl->curr_period_counter =3D =
0;
     irl->last_period_reset =3D 0;
 
+    if (bconf)
+    {
+        irl=
->bloom_conf =3D *bconf;
+        init_bloom_filter(irl);
+    }
+
     ret=
urn irl;
 }
 
 void
 initial_rate_limit_free(struct initial_packet_rate_lim=
it *irl)
 {
+    gc_free(&irl->gc);
     free(irl);
+    irl =3D NULL;
 }
d=
iff --git a/src/openvpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh=

index 84915e8c6=2E=2Ebe2b926 100644
--- a/src/openvpn/reflect_filter=2Eh
+=
++ b/src/openvpn/reflect_filter=2Eh
@@ -23,6 +23,30 @@
 #define REFLECT_FIL=
TER_H
 
 #include <limits=2Eh>
+#include "socket=2Eh"
+#include "bloom=2Eh"=

+
+struct filter_tier
+{
+    struct filter_tier *next;
+
+    int limit;
=
+    int netmask;
+
+    /** The number of packets we dropped since we went=
 over this limit */
+    size_t dropped;
+};
+
+struct bloom_filter_conf
+{=

+    struct filter_tier *inet_tiers;
+    struct filter_tier *inet6_tiers;=

+
+    /* Configuration of the bloom filter */
+    size_t num_hashes;
+  =
  size_t size;
+};
+
 
 /** struct that handles all the rate limiting logic=
 for initial
  * responses */
@@ -35,7 +59,7 @@
     int period_length;
 
 =
    /** Number of packets in the current period=2E We use int64_t here
-   =
  * to avoid any potiential issues with overflow */
+     * to avoid any po=
tential issues with overflow */
     int64_t curr_period_counter;
 
     /*=
 Last time we reset our timer */
@@ -44,29 +68,57 @@
     /* we want to war=
n once per period that packets are being started to
      * be dropped */
 =
    bool warning_displayed;
+
+    struct bloom_filter_conf bloom_conf;
+  =
  struct bloom_filter *bf;
+
+    /* gc_arena used for the various allocati=
ons by this struct */
+    struct gc_arena gc;
 };
 
+/**
+ * Adds a bloom =
filter tier to the bloom filter config=2E
+ */
+void
+reflect_add_filter_ti=
er(struct bloom_filter_conf *bfconf, struct gc_arena *gc,
+                =
        bool ipv6, int netmask, int limit);
 
 /**
  * checks if the connec=
tion is still allowed to connect under the rate
  * limit=2E This also incr=
eases the internal counter at the same time
  */
-bool reflect_filter_rate_=
limit_check(struct initial_packet_rate_limit *irl);
+bool
+reflect_filter_c=
heck(struct initial_packet_rate_limit *irl,
+                     const str=
uct openvpn_sockaddr *from);
+
 
 /**
  * decreases the counter of initial =
packets seen, so connections that
  * successfully completed the three-way =
handshake do not count against
  * the counter of initial connection attemp=
ts
  */
-void reflect_filter_rate_limit_decrease(struct initial_packet_rate=
_limit *irl);
+void
+reflect_filter_rate_limit_decrease(struct initial_pack=
et_rate_limit *irl,
+                                   struct openvpn_sock=
addr *from);
 
 /**
  * allocate and initialize the initial-packet rate lim=
iter structure
+ *
+ * Note: this function does not copy bconf's contents=
=2E
  */
-struct initial_packet_rate_limit *initial_rate_limit_init(int max=
_per_period, int period_length);
+struct initial_packet_rate_limit *
+initi=
al_rate_limit_init(int max_per_period, int period_length,
+                =
        struct bloom_filter_conf *bconf);
 
 /**
  * free the initial-packe=
t rate limiter structure
  */
 void initial_rate_limit_free(struct initial_=
packet_rate_limit *irl);
+
+/**
+ * Initialises the bloom filter with the c=
onfiguration values of
+ * irl->bloom_conf
+ */
+void
+init_bloom_filter(st=
ruct initial_packet_rate_limit *irl);
 #endif /* ifndef REFLECT_FILTER_H */=

diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/ope=
nvpn/Makefile=2Eam
index 5430ecb=2E=2Ed86bcf8 100644
--- a/tests/unit_tests=
/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -103=
,6 +103,7 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(=
OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
+	test_ref=
lect=2Ec test_reflect=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 =
	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
=
diff --git a/tests/unit_tests/openvpn/test_reflect=2Ec b/tests/unit_tests/o=
penvpn/test_reflect=2Ec
new file mode 100644
index 0000000=2E=2Ed0d11c6
---=
 /dev/null
+++ b/tests/unit_tests/openvpn/test_reflect=2Ec
@@ -0,0 +1,293 @=
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
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ * =
 This program is free software; you can redistribute it and/or modify
+ *  =
it under the terms of the GNU General Public License version 2
+ *  as publ=
ished by the Free Software Foundation=2E
+ *
+ *  This program is distribut=
ed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#elif define=
d(_MSC_VER)
+#include "config-msvc=2Eh"
+#endif
+
+#include "syshead=2Eh"
+=

+#include "bloom=2Eh"
+#include "buffer=2Eh"
+#include "reflect_filter=2Eh=
"
+#include "test_common=2Eh"
+
+#include <setjmp=2Eh>
+#include <stdarg=2E=
h>
+#include <cmocka=2Eh>
+
+#include <stdio=2Eh>
+
+static_assert(BLOOM_FI=
LTER_BITS_COUNT =3D=3D 4, "unit test not in sync");
+static_assert(BLOOM_FI=
LTER_BITS_MASK =3D=3D 0xf, "unit test not in sync");
+
+void
+test_bloom(vo=
id **state)
+{
+    static const int present_mod =3D 77;
+
+    struct gc_a=
rena gc =3D gc_new();
+    /* Use a bloom filter with 1M entries (256kB) fo=
r the unit test */
+    struct bloom_filter *bf =3D bloom_create(1024ul * 1=
024, 8, &gc);
+
+    for (int32_t i =3D 0; i < 20000; i +=3D present_mod)
+=
    {
+        bloom_add(bf, (const uint8_t *)&i, sizeof(i));
+    }
+
+   =
 /* all these should be positive, for the small unit test we do not expect
=
+     * false positive */
+    for (int32_t i =3D 0; i < 20000; i++)
+    {=

+        int present =3D (i % present_mod =3D=3D 0) ? 1 : 0;
+        /* c=
ast to bool to only get 1 and 0 for present/not present and not */
+       =
 assert_int_equal((bool)bloom_test(bf, (const uint8_t *)&i, sizeof(i)), pre=
sent);
+    }
+
+    gc_free(&gc);
+}
+
+void
+test_reflect_ddos(void **sta=
te)
+{
+    /* This tests if the bloom filter implementation does actually =
work with
+     * the goal of dropping packets to a reflected /24 while sti=
ll allowing
+     * other clients */
+
+    /* Disable the normal fallback =
that puts a hard cap on the reflection filter */
+    struct initial_packet=
_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    re=
flect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 24, 5);
+    refle=
ct_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 8, 20);
+    init_blo=
om_filter(irl);
+
+    int num_legimate_reject =3D 0;
+    int num_legimate=
_accepted =3D 0;
+
+    int num_ddos_rejected =3D 0;
+    int num_ddos_acce=
pted =3D 0;
+
+
+    /* /24 net addresses in host byte order */
+    in_add=
r_t net_attack[4];
+    for (int i =3D 0; i < 3; i++)
+    {
+        net_a=
ttack[i] =3D random() % 0xff;
+    }
+
+    /* The 4th network is close eno=
ugh to the 3rd to fall in the same /16 */
+    /* XOR the 3rd byte to achie=
ve this */
+    net_attack[3] =3D net_attack[2] ^ 00002300;
+
+    /* Assum=
e 200000 packets, including roughly 200 legitimate packets,
+     * the uni=
t test works also with 20 millions packet but takes too long*/
+    static =
const int total_packets =3D 200 * 1000;
+
+    for (int i =3D 0; i < total_=
packets; i++)
+    {
+        struct openvpn_sockaddr from =3D { 0 };
+    =
    from=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+        from=2Eaddr=2Ein4=
=2Esin_addr=2Es_addr =3D (in_addr_t)random();
+        from=2Eaddr=2Ein4=2E=
sin_port =3D (uint16_t)random();
+
+        if (i % 1023 =3D=3D 0)
+       =
 {
+            /* roughly 200 legitimate clients with random addresses */
=
+            from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t)random();=

+
+            bool allowed =3D reflect_filter_check(irl, &from);
+       =
     if (allowed)
+            {
+                num_legimate_accepted++;
=
+            }
+            else
+            {
+                num_legima=
te_reject++;
+            }
+        }
+        else
+        {
+          =
  /* We attack the 4 networks at random */
+            from=2Eaddr=2Ein4=
=2Esin_addr=2Es_addr =3D (in_addr_t)(net_attack[random() % 4] + (random() %=
 256));
+
+            bool allowed =3D reflect_filter_check(irl, &from);
+=
            if (allowed)
+            {
+                num_ddos_accepted+=
+;
+            }
+            else
+            {
+                num_ddo=
s_rejected++;
+            }
+        }
+    }
+
+    assert_int_equal(num_=
legimate_reject + num_legimate_accepted + num_ddos_accepted + num_ddos_reje=
cted, total_packets);
+
+    /* We assume that most legitimate made it thro=
ugh but a few were unfortunate to be in an attacked network */
+    assert_=
int_in_range(num_legimate_reject, 0, 10);
+
+    /* We disabled total numbe=
r of packets, so we expect all /8 to have their
+     * 20 packets, which i=
s 5120=2E */
+    assert_int_in_range(num_ddos_accepted, 0, 256 * 20);
+
+ =
   initial_rate_limit_free(irl);
+}
+
+
+void
+test_bloom_minimal(void **st=
ate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bloom_filter *bf =
=3D bloom_create(2048, 3, &gc);
+
+    int item =3D 0xbabe;
+
+    bloom_ad=
d(bf, (const uint8_t *)&item, sizeof(item));
+    assert_int_equal(bloom_te=
st(bf, (const uint8_t *)&item, sizeof(item)), 1);
+
+    item =3D 0xf00f;
+=
    assert_int_equal(bloom_test(bf, (const uint8_t *)&item, sizeof(item)), =
0);
+
+    gc_free(&gc);
+}
+
+void
+test_reflect_reflect_bloom_simple(void=
 **state)
+{
+    struct initial_packet_rate_limit *irl =3D initial_rate_li=
mit_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_co=
nf, &irl->gc, true, 32, 50);
+    reflect_add_filter_tier(&irl->bloom_conf,=
 &irl->gc, true, 56, 200);
+    init_bloom_filter(irl);
+
+    struct openv=
pn_sockaddr from =3D { 0 };
+    from=2Eaddr=2Ein6=2Esin6_family =3D AF_INE=
T6;
+    from=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();
+    from=2E=
addr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */
+
+    /* There are 5=
0 attempts that should work until one fails */
+    for (int i =3D 0; i < 5=
0; i++)
+    {
+        assert_true(reflect_filter_check(irl, &from));
+   =
 }
+
+    /* 2002::1 */
+    struct openvpn_sockaddr from2 =3D from;
+    f=
rom2=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[0] =3D 0x7;
+    from2=2Eaddr=2Ein6=
=2Esin6_addr=2Es6_addr[1] =3D 0x7;
+
+    assert_true(reflect_filter_check(=
irl, &from2));
+
+    /* Any more attempts from ::1 should fail */
+    ass=
ert_false(reflect_filter_check(irl, &from));
+
+    initial_rate_limit_free=
(irl);
+}
+
+void
+test_reflect_bloom_netmask_masking(void **state)
+{
+   =
 struct initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_MAX,=
 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, tru=
e, 45, 10);
+    init_bloom_filter(irl);
+
+    struct openvpn_sockaddr fro=
m =3D { 0 };
+    from=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;
+    from=
=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();
+    for (int i =3D 0; i =
< 15; i++)
+    {
+        from=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[i] =3D (=
uint8_t)random();
+    }
+
+    for (int i =3D 0; i < 10; i++)
+    {
+    =
    /* /45 means that if we leave the leave first 8 bytes and 5 bits
+     =
    * untouched, it is still the same subnet  */
+        for (int j =3D 8;=
 j < 15; j++)
+        {
+            from=2Eaddr=2Ein6=2Esin6_addr=2Es6_ad=
dr[j] =3D (uint8_t)random();
+            from=2Eaddr=2Ein6=2Esin6_addr=2Es=
6_addr[7] ^=3D (uint8_t)(random() & 0x7);
+        }
+        assert_true(r=
eflect_filter_check(irl, &from));
+    }
+
+    /* testing the last IP agai=
n should give us a negative result */
+    assert_false(reflect_filter_chec=
k(irl, &from));
+
+    initial_rate_limit_free(irl);
+}
+
+
+void
+test_ref=
lect_reflect_bloom_mapped(void **state)
+{
+    struct initial_packet_rate_=
limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_=
add_filter_tier(&irl->bloom_conf, &irl->gc, false, 24, 50);
+    reflect_ad=
d_filter_tier(&irl->bloom_conf, &irl->gc, false, 8, 80);
+    init_bloom_fi=
lter(irl);
+
+    /* Our OpenVPN server will not receive IPv4 as well as IP=
v4 mapped
+     * addresses in the same process but for the unit test it is=
 convient
+     * to see if they actually mapped to the same entries */
+
+=
    struct openvpn_sockaddr mapped_v4 =3D { 0 };
+    mapped_v4=2Eaddr=2Ein=
6=2Esin6_family =3D AF_INET6;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_port =3D (=
uint16_t)random();
+    /* ::ffff:192=2E168=2E0=2E99 */
+    mapped_v4=2Ead=
dr=2Ein6=2Esin6_addr=2Es6_addr[10] =3D 0xff;
+    mapped_v4=2Eaddr=2Ein6=2E=
sin6_addr=2Es6_addr[11] =3D 0xff;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=
=2Es6_addr[12] =3D 192;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[1=
3] =3D 168;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[14] =3D 0;
+ =
   mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 99;
+
+    assert_t=
rue(IN6_IS_ADDR_V4MAPPED(&mapped_v4=2Eaddr=2Ein6=2Esin6_addr));
+
+    /* N=
ot the same address but in the same /8 */
+    struct openvpn_sockaddr v4ad=
dr =3D { 0 };
+    v4addr=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+    v4add=
r=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)random();
+    /* 192=2E168=2E123=
=2E244 */
+    v4addr=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(0xc0a87bf4=
);
+
+    /* check that we run into the 50 limit with our mapped address */=

+    for (int i =3D 0; i < 50; i++)
+    {
+        assert_true(reflect_fi=
lter_check(irl, &mapped_v4));
+    }
+    assert_false(reflect_filter_check=
(irl, &mapped_v4));
+
+
+    /* Check that the non-mapped IPv4 address uses=
 the same /8 subnet limit */
+    for (int i =3D 0; i < 30; i++)
+    {
+  =
      assert_true(reflect_filter_check(irl, &v4addr));
+    }
+    assert_f=
alse(reflect_filter_check(irl, &v4addr));
+
+    initial_rate_limit_free(ir=
l);
+}
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/te=
st_reflect=2Eh b/tests/unit_tests/openvpn/test_reflect=2Eh
new file mode 10=
0644
index 0000000=2E=2E0dc1e4c
--- /dev/null
+++ b/tests/unit_tests/openvp=
n/test_reflect=2Eh
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks
+ *             over a single TCP/UDP port, with=
 support for SSL/TLS-based
+ *             session authentication and key e=
xchange,
+ *             packet encryption, packet authentication, and
+ * =
            packet compression=2E
+ *
+ *  Copyright (C) 2023-2026 OpenVPN =
Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne Schwabe <arne@r=
fc2549=2Eorg>
+ *
+ *  This program is free software; you can redistribute =
it and/or modify
+ *  it under the terms of the GNU General Public License =
version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Thi=
s program is distributed in the hope that it will be useful,
+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lic=
ense for more details=2E
+ *
+ *  You should have received a copy of the GN=
U General Public License along
+ *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_REFLECT_H
+#define TEST=
_REFLECT_H
+void test_reflect_ddos(void **state);
+
+void test_bloom(void *=
*state);
+
+void test_bloom_minimal(void **state);
+
+void test_reflect_ref=
lect_bloom_simple(void **state);
+
+void test_reflect_bloom_netmask_masking=
(void **state);
+
+void test_reflect_reflect_bloom_mapped(void **state);
+#=
endif
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/tes=
t_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2E398bd5=
6 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests=
/openvpn/test_ssl=2Ec
@@ -51,6 +51,7 @@
 #include "ssl_util=2Eh"
 #include =
"ssl_verify=2Eh"
 #include "openvpn=2Eh"
+#include "test_reflect=2Eh"
 
 /*=
 Mock function to be allowed to include win32=2Ec which is required for
  *=
 getting the temp directory */
@@ -1111,8 +1112,13 @@
         cmocka_unit_=
test(ssl_test_extract_last_matching_field),
         cmocka_unit_test(ssl_t=
est_reject_null_in_cert_subject),
         cmocka_unit_test(ssl_test_escape=
_rfc_2253_chars_in_subject),
-        cmocka_unit_test(ssl_test_extract_pee=
r_info)
-
+        cmocka_unit_test(ssl_test_extract_peer_info),
+        c=
mocka_unit_test(test_bloom),
+        cmocka_unit_test(test_bloom_minimal),=

+        cmocka_unit_test(test_reflect_reflect_bloom_simple),
+        cmo=
cka_unit_test(test_reflect_reflect_bloom_mapped),
+        cmocka_unit_test=
(test_reflect_bloom_netmask_masking),
+        cmocka_unit_test(test_reflec=
t_ddos)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b=
9
Gerrit-Change-Number: 30
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: MaxF <max@m=
ax-fillinger=2Enet>

--wbMi+1Fllbw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld, razvanc=2E </p>
<p>plaisthos <str=
ong>uploaded patch set #11</strong> to this change=2E</p><p><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">Implement initial packet reflection protection using bloom filt=
er<br><br>When an OpenVPN server is used/tried to be used in a reflection a=
ttack<br>the protection with the simple --connect-freq-initial also blocks =
legitimate<br>clients from other networks that are not attacked by a reflec=
tion attack=2E<br><br>To allow a server to still reply to these clients, we=
 need to make the counts<br>rather more detailed and count per subnet or IP=
 address=2E On the other hand<br>when we keep all this state, we eliminate =
the advantage of having a stateless<br>cookie based initial packet handshak=
e=2E<br><br>As compromise we use a bloom filter to store the information=2E=
 This data<br>structure is probabilistic and can have false positive and mo=
re packets<br>being dropped but since it is a constant size and the size of=
 this map<br>is small enough for non-embedded systems (tests were done with=
 a 2MB<br>bloom filter), it is a good compromise=2E<br><br>The code is spli=
t into the bloom filter implementation and the actual logic<br>implementing=
 tracking the subnets, so the bloom filter should be relatively<br>easily b=
e exchangable by another data structure=2E<br><br>As hash function SIPHASH =
has been chosen since it was designed for this kind<br>of application=2E<br=
><br>Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9<br>Signed-off-by:=
 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M =2Egithub/workflows/bu=
ild=2Eyaml<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>M doc/man-sections/se=
rver-options=2Erst<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/bloom=2E=
c<br>A src/openvpn/bloom=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/mul=
ti=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/o=
penvpn/ovpn_dco_linux=2Eh<br>M src/openvpn/reflect_filter=2Ec<br>M src/open=
vpn/reflect_filter=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tes=
ts/unit_tests/openvpn/test_reflect=2Ec<br>A tests/unit_tests/openvpn/test_r=
eflect=2Eh<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>18 files changed, =
1,431 insertions(+), 98 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/30/11</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyam=
l</span><br><span>index 56dd3ed=2E=2E1a22f0f 100644</span><br><span>--- a/=
=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/=
build=2Eyaml</span><br><span>@@ -155,6 +155,9 @@</span><br><span>         e=
nv:</span><br><span>           srcdir: &quot;${{ github=2Eworkspace }}/test=
s/unit_tests/openvpn&quot;</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - name: Run reflect unit test</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        run: =2E/unittests/test_re=
flect=2Eexe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>   ubuntu:</span><br><span>     strategy:</span><br><span>       f=
ail-fast: false</span><br><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index cfb7226=2E=2Ec6e26ee 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -429,6 +429,7 @@</span><br><span>     src/openvpn/base64=2Ec</span><br>=
<span>     src/openvpn/base64=2Eh</span><br><span>     src/openvpn/basic=2E=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/bl=
oom=2Ec</span><br><span>     src/openvpn/buffer=2Ec</span><br><span>     sr=
c/openvpn/buffer=2Eh</span><br><span>     src/openvpn/check_file_access=2Ec=
</span><br><span>@@ -812,8 +813,11 @@</span><br><span>             tests/un=
it_tests/openvpn/mock_management=2Ec</span><br><span>             tests/uni=
t_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>             test=
s/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/test_reflect=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests/=
unit_tests/openvpn/test_reflect=2Eh</span><br><span>             src/openvp=
n/argv=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/bloom=2E=
c</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br><span=
>             src/openvpn/crypto_mbedtls=2Ec</span><br><span>             s=
rc/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -826,7 +830,11 @@</=
span><br><span>             src/openvpn/options_util=2Ec</span><br><span>  =
           src/openvpn/otime=2Ec</span><br><span>             src/openvpn/p=
acket_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     src/openvpn/reflect_filter=2Ec</span><br><span>             src/openvp=
n/run_command=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          src/openvpn/siphash=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            src/openvpn/siphash=2Eh</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            src/openvpn/siphash_reference=2Ec=
</span><br><span>             src/openvpn/ssl_mbedtls=2Ec</span><br><span> =
            src/openvpn/ssl_openssl=2Ec</span><br><span>             src/op=
envpn/ssl_util=2Ec</span><br><span>diff --git a/Changes=2Emd b/Changes=2Emd=
</span><br><span>index 2684251=2E=2E10467f5 100644</span><br><span>--- a/Ch=
anges=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,=
14 @@</span><br><span>   the characters mentioned above were already escape=
d=2E However, the behavior of</span><br><span>   Mbed TLS is slightly diffe=
rent from OpenSSL in that it also escapes &quot;=3D&quot;=2E</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Bloom filter=
 based reflection protection**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  To avo=
id the limitation of ``--connect-freq-initial`` to block legimitate</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  clients when an OpenVPN s=
erver is tried to be used in a reflection attack,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  the new ``--connect-freq-initial-bloom-limi=
t`` can impose limit on a</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  per-subnet basis=2E See the manual for more details=2E Note: this o=
ption</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  requires 2MB=
 of extra memory in the default configuration=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> # Overview of changes in 2=
=2E7</span><br><span> </span><br><span> ## New features</span><br><span>dif=
f --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-o=
ptions=2Erst</span><br><span>index 9dfa6bd=2E=2E05f30bf 100644</span><br><s=
pan>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc/m=
an-sections/server-options=2Erst</span><br><span>@@ -226,6 +226,77 @@</span=
><br><span>   will not be counted against the limit=2E The default is to al=
low</span><br><span>   100 initial connection per 10s=2E</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+--connect-freq-initial-bloom-size args<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+   Valid syntax:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   ::</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      connect-freq-initial-bloom-size size [numhashes]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+   Configures the size of the bloom filter used for the in=
itial connection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
packet responses=2E See `--connect-freq-initial-bloom-limit` for a full</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+   description of the f=
eature=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   Bloom filters are probabil=
istic by their nature and the larger the size</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+   of the bloom filter is, the more accurate they=
 are=2E This option configures</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+   the number of buckets in the bloom filter=2E Each bucket take=
s up 4 bits=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   E=
=2Eg=2E the default of  8336608 (8 * 2^20) when the option is not set</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+   will require 2MB of me=
mory=2E The numhashes will control the number of hash</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   functions that are used for the bloom =
filter=2E The default is 7=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--connect=
-freq-initial-bloom-limit arg</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Valid =
syntax:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ::</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      connect-freq-initial-bloom-limit inet n=
etmask limit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      c=
onnect-freq-initial-bloom-limit inet6 netmask limit</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   This option implements a rate limiting function for initi=
al packet like</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``=
--connect-freq-initial`` but takes the source of the initial packet into</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+   account=2E This fun=
ction shares the the reset after a time period and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   enabling this function will not disable t=
he overall limit of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
   ``--conect-freq-initial``=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   To a=
void resource exhaustion on the OpenVPN server side from reflection</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   attacks and also trying =
to avoid blocking legitimate clients when an</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+   attacker tries to use an OpenVPN server, the li=
mits are not applied globally</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   but rather a per netmask granularity=2E Each line of this comm=
and configures</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   a =
separate granularity=2E As example, the following configuration,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+   ::</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 connect-freq-initial 1000 60</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        connect-freq-initial-bloom-limit inet 24 50</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        connect-freq-initial-bloo=
m-limit inet 8 100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       connect-freq-initial-bloom-limit inet6 56 50</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        connect-freq-initial-bloom-limit =
inet6 32 100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    will limit the number =
of (unanswered) replies per /24 network to 50</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    packets=2E After 50 packets from the same /24=
, the server will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  drop any further packets=2E Similarly, if a /16 network receives more tha=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    100 connection=
 requests, the server will drop further packets=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    If the count of all packets exceeds 1000=
, further packets will be</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    completely dropped regardless of their origin=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   The implementation uses a counting bloom filter to s=
tore information of how</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+   many packets the server has seen per subnet=2E A bloom filter is a</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+   probabilistic data=
 structure can yield false positives=2E In this case, the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   server will drop packets even thou=
gh the limit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   for =
that particular subnet is not yet reached=2E Since we are using a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   counting bloom filter, a r=
eply from a client that triggers a removal of an</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   entry can also lead to a false negative=2E =
However, this is limited in the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   sense a reply can at most trigger one false negative=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   Every limit configured with this optio=
n will put more more entries into</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+   the bloomfilter since per limit (per family), one entry is=
 put into the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   blo=
om filter=2E So a large number of entries requires a larger bloom filter</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+   to avoid too many f=
alse positives=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+   IPv6 mapped IPv4 a=
ddresses (::ffff:0:0/96) are treated as IPv4 addresses</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   for these limits=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --duplicate-cn</spa=
n><br><span>   Allow multiple clients with the same common name to concurre=
ntly</span><br><span>   connect=2E In the absence of this option, OpenVPN w=
ill disconnect a client</span><br><span>diff --git a/src/openvpn/Makefile=
=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7ecddff=2E=2E950a74=
c 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>++=
+ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -46,6 +46,7 @@</span><br><=
span> 	auth_token=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=
=2Eh \</span><br><span> 	basic=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	bloom=2Ec bloom=2Eh \</span><br><span> 	buffer=2Ec buffer=
=2Eh \</span><br><span> 	check_file_access=2Ec check_file_access=2Eh \</spa=
n><br><span> 	circ_list=2Eh \</span><br><span>diff --git a/src/openvpn/bloo=
m=2Ec b/src/openvpn/bloom=2Ec</span><br><span>new file mode 100644</span><b=
r><span>index 0000000=2E=2Efabb7ad</span><br><span>--- /dev/null</span><br>=
<span>+++ b/src/openvpn/bloom=2Ec</span><br><span>@@ -0,0 +1,248 @@</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023=
-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne=
@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s free software; you can redistribute it and/or modify</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Genera=
l Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  as published by the Free Software Foundation=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is distributed in the hope that it w=
ill be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  b=
ut WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  GNU General Public License for more details=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/li=
censes/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* This file implements a specialised co=
unting bloom filter implementation</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * used in OpenVPN to mitigate it being used in reflection a=
ttacks=2E The bloom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * implementation should be general enough to be used in other contexts</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * however */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-msvc=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;cr=
ypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;bloom=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static size_t</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+calc_ceil_log2(size_t num)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Figure out how many bits we have in our hash by doing</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * ceil(log2(bf-&gt;siz=
e) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    size_t numbits =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    while (num &gt;&gt;=3D =
1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        numbits++;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return numbits;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calculate number of b=
ytes needed for each hash function in the bloom filter</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+calculate_num_bytes_hashfun(size_t size)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    size_t hash_bits =3D calc_ceil_log2(size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* round up to the nearest byte size =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t hash_b=
ytes =3D (hash_bits + 7) / 8;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return hash_bytes;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * A bloom filter uses a number of hashe=
s to perform its functionality=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Instead of using the same number of siphash function we split the bytes of<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the siphash to th=
e different hashes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * We could als=
o optimise this further by splitting at the bit level but that</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * crates a lot of extra code fo=
r bit shifting, etc=2E so we waste some bits</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param bf</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param num_hashes</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+calculate_num_sip_hash_hashes(struct=
 bloom_filter *bf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t hash_byt=
es =3D calculate_num_bytes_hashfun(bf-&gt;size);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    size_t total_bytes =3D bf-&gt;num_hashes *=
 hash_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Round up to next SI=
PHASH_HASH_SIZE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t num_siphash =3D (total_bytes + BLOOM_HASH_SIZE - 1) / BLOOM_HASH_=
SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return num_siphash;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calc=
ulates the number of bytes we need for storing a bloom filter of size</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * size=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bloom_get_filter_byte_count(si=
ze_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t bits_required =
=3D size * BLOOM_FILTER_BITS_COUNT;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Add 7 round up to the next byte */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return (bits_required + 7) / 8;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
loom_get_filter_bit_offset(size_t bucket)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return (bucket * BLOOM_FILTER_BITS_COUNT) % (8 * sizeof(bloom_count=
er_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static inline size_t</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bloom_get_filter_array_index(size_t bucket)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (bucket * BLOOM_FILTER_BITS_CO=
UNT) / (8 * sizeof(bloom_counter_t));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bloom=
_counter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_get=
_filter_get_counter(struct bloom_filter *bf, size_t bucket)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    static_assert((BLOOM_FILTER_BITS_MASK + 1) =3D=3D=
 (1 &lt;&lt; BLOOM_FILTER_BITS_COUNT),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  &quot;BLOOM_FILTER_BITMASK and BLOOM_F=
ILTER_BIT_COUNT are inconsistent&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bloom_counter_t counter =3D bf-&gt;buckets[bloom_get_filter_array_ind=
ex(bucket)];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siz=
e_t bitoffset =3D bloom_get_filter_bit_offset(bucket);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return (counter &gt;&gt; bitoffset) &amp; BLOOM_FILTER_=
BITS_MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static inline void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bloom_set_filter_counter(struct bloom_filter *b=
f, size_t bucket, bloom_counter_t value)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bloom_counter_t data =3D bf-&gt;buckets[bloom_get_filter_array_index=
(bucket)];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t bitoffset =3D bloom_get_filter_bit_offset(bucket);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    data =3D data &amp; ~(BLOOM_FILTER_BITS_MASK &lt;&lt; bi=
toffset);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    data =3D data | ((value &=
amp; BLOOM_FILTER_BITS_MASK) &lt;&lt; bitoffset);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bf-&gt;buckets[bloom_get_filter_array_index(bucket)] =3D dat=
a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Creates a new bloom filter structure</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param size the number of buckets=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return  the newly created =
bloom filter structure</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct bloom_=
filter *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_creat=
e(size_t size, size_t num_hashes, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    size_t bloomfilter_bytes =3D bloom_get_filter_byte_cou=
nt(size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 bloom_filter *bf =3D gc_malloc(sizeof(struct bloom_filter) + bloomfilter_b=
ytes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                          false, gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bf-&gt;size =3D size;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bf-&gt;num_hashes =3D num_hashes;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bf-&gt;hash_bytes =3D calculate_num_bytes_hashfu=
n(size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;=
num_siphash =3D calculate_num_sip_hash_hashes(bf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ALLOC_ARRAY_GC(bf-&gt;siphash_keys, struct siphash_key, bf-=
&gt;num_siphash, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bloom_clear(bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return bf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Clear the bloom filter, making it empty again as if =
it were freshly created</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param bf the bloom structure to clear</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom=
_clear(struct bloom_filter *bf)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    me=
mset(bf-&gt;buckets, 0, bloom_get_filter_byte_count(bf-&gt;size));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* We randomise the bloom filter keys on ev=
ery clear of the bloom filter</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * to avoid scenarios where an attacker might learn specific =
pattern</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * that =
could exploit false positives in the bloom filter */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; bf-&gt;nu=
m_siphash; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prng_bytes=
(bf-&gt;siphash_keys[i]=2Ekey, SIPHASH_KEY_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static bloom_counter_t</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bloom_add_test(struct bloom_filter *b=
f, const uint8_t *item, size_t len, bloom_counter_t inc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint8_t result[BLOOM_HASH_SIZE];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t j =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t idx =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t ret =3D bloom_cou=
nter_max;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &l=
t; bf-&gt;num_hashes; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 size_t bucket =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        for (size_t k =3D 0; k &lt; bf-&gt;hash_bytes; k++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (idx =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                /* We have no longer =
unused bytes in result, generate the next hash */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                siphash(item, len, bf-&gt;sip=
hash_keys[j++]=2Ekey, result, BLOOM_HASH_SIZE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            bucket =3D bucket &lt;&lt; 8;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            bucket |=3D result[idx];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            idx =3D (idx + 1) % BLOOM_HASH_SIZE;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        bucket =3D bucket % bf-&gt;size;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        bloom_counter_t value =
=3D bloom_get_filter_get_counter(bf, bucket);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ret =3D min_bloom_counter(ret, value);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (inc)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            value =3D min_bloom_counter(bloom_counter_max, value + 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            bloom_set_=
filter_counter(bf, bucket, value);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bloom_counter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bloom_add(struct bloom_filter *bf, const uint8_t *item, size_t len)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return bloom_add_test(bf, item, len, =
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bloom_remove(struct bloom_filter *bf, const uint8_t *item=
, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return bloom_add_tes=
t(bf, item, len, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bloom_test(struct bloom_filter *bf, const uint8_t *item, s=
ize_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return bloom_add_test(b=
f, item, len, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span>diff --git a/src/openvpn/bloom=2Eh b/src/openvpn/bloom=2Eh<=
/span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E8d8=
14d5</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/bloom=
=2Eh</span><br><span>@@ -0,0 +1,147 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2023-2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  This program is free software; you can redi=
stribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  it under the terms of the GNU General Public License version 2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by th=
e Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is distributed in the hope that it will be useful,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Genera=
l Public License for more details=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef BLOOM_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define BLOOM_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Th=
is is the type we use for the buckets=2E This is split into small buckets</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with BLOOM_FILTER_=
BITS_COUNT size */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
ypedef uint32_t bloom_counter_t;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define BLOOM_FILTER_BITS_COUNT 4</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define BLOOM_FILTER_BITS_MASK  0x0f</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define bloom_counter_max      =
 0x0f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* we want bloom_counter_t bits t=
o be a multiple of BLOOM_FILTER_BITS_COUNT to</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * allow our operations to calculate bucket index=
es to assume that that a bucket</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * is always inside a single index bloom_counter_t and never st=
retches over</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * two =
adjacent bloom_counter_t */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static_assert((sizeof(bloom_counter_t) * 8) % BLOOM_FILTER_BITS_COU=
NT =3D=3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
       &quot;bloom_counter_t must be a multiple of BLOOM_FILTER_BIT_COUNT&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* We use 64 bit output from sip=
hash for the bloom filter */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define BLOOM_HASH_SIZE 8</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic inline bloom_counter_t</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+min_bloom_counter(bloom_counter_t x, bloom_counter_t y)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (x &lt; y)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return x;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return y;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct siph=
ash_key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SI=
ZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * A structure holding a bloom filter=2E A bloom filter is a probab=
ilistic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * data stru=
cture used to test whether an element is a member of a set=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * It may return false positives =
but never false negatives=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A blo=
om filter has a size N of entries, and each entry or bucket is a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * counter=2E E=2Eg=2E a bloom=
 filer of size 1024 with entries of 4 bits each</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * will have 4096 bits or 512 bytes in total si=
ze=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Whenever an entry is added t=
o the bloom filter, n hash function are</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * calculated=2E These map a key -&gt; [0, size of bloo=
m filter]=2E For each of</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * hash function use the result as index for the bucket to increase th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * counter=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * For our example of a bloom filter with=
 1024 entries and 5 hash functions,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * hashing an entry might yield 77,323, 662, 789, and 8=2E =
That would then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * i=
ncrease the buckets (bit counters) at the the index positions 77, 323,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 662, 789, and 8=2E If=
 an entry is at its maximum (15 for 4 bits counters)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * it will stop increasing the counter=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * To test if an entry is in the blo=
om filter we do the same hashing and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * check if all the counters positions have at least a val=
ue of 1=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Removing an entry is si=
milar to adding an entry, we decrement the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * counter at each bit position=2E But with the cave=
at that buckets with</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * already at maximum, the counter is not decremented in order to preserve=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the property of =
never false negatives=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Instead o=
f using n separate hash functions that map to output log(N) bits,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * our implementation uses mu=
ltiple siphash functions with 64 bit output</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * and slices them into multiple hash functions of =
log(N) bits=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * E=2Eg=2E when using=
 a bloom filter of size 1048576 (1024 * 1024),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * we need 20 bits output for each of the hash f=
unctions=2E We round up</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * to bytes, So that are 3 bytes=2E To realize 7 hash function we need<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * then 21 bytes or =
three siphash function each with 8 byte (64 bit)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+struct bloom_filter</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
** Size (N) of the bloom filter in entries</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * This is also equal to (total bits)/(bits per =
counter) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
_t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /** Number of bytes used b=
y each hash function=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * lo=
g2(size * 8) bits rounded up to the next byte</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * This is a cached value since log2 is surprisingly slow<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (5% of total =
time of if we do not cache it) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t hash_bytes;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /** number of hashes (n) we use to determine the bit positions */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t num_hashes;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** number of siphash functions neede=
d to calculate=2E This can be</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * calculated from the other members of the struct but we sto=
re it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in the =
struct for fast access */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    size_t num_siphash;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** k=
eys for the siphash functions */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct siphash_key *siphash_keys;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /** the actual buckets that hold the data */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t buckets[];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+str=
uct bloom_filter *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
loom_create(size_t size, size_t num_hashes, struct gc_arena *gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bloom_test(struct bloom_filter *bf, const uint8_t *i=
tem, size_t len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_add(struct bloom_fi=
lter *bf, const uint8_t *item, size_t len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bloom_counter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bloom_remove(struct bloom_filter *bf, const uint8_t *item, size_t len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bloom_clear(struct bloom_filter *bf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef BLOOM_H */</span><br>=
<span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><s=
pan>index 73e1386=2E=2E60ea823 100644</span><br><span>--- a/src/openvpn/mud=
p=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -33,6 +=
33,7 @@</span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #=
include &quot;ssl_pkt=2Eh&quot;</span><br><span> #include &quot;sid_hash=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;reflect_filter=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_=
SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><=
span>@@ -129,7 +130,7 @@</span><br><span>     {</span><br><span>         /*=
 Check if we are still below our limit for sending out</span><br><span>    =
      * responses */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (!reflect_filter_rate_limit_check(m-&gt;initial_rate_limiter))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!reflect_f=
ilter_check(m-&gt;initial_rate_limiter, from))</span><br><span>         {</=
span><br><span>             return PRE_DECRYPT_NO_ACTION;</span><br><span> =
        }</span><br><span>@@ -268,9 +269,10 @@</span><br><span> </span><br>=
<span>         if (frequency_limit_event_allowed(m-&gt;new_connection_limit=
er))</span><br><span>         {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            struct link_socket_actual *from =3D &amp;m-&gt;top=
=2Ec2=2Efrom;</span><br><span>             /* a successful three-way handsh=
ake only counts against</span><br><span>              * connect-freq but no=
t against connect-freq-initial */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            reflect_filter_rate_limit_decrease(m-&gt;initial_ra=
te_limiter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     reflect_filter_rate_limit_decrease(m-&gt;initial_rate_limiter, &amp;fr=
om-&gt;dest);</span><br><span> </span><br><span>             mi =3D multi_c=
reate_instance(m, real, sock);</span><br><span>             if (mi)</span><=
br><span>@@ -284,7 +286,7 @@</span><br><span>                 {</span><br><=
span>                     ASSERT(session_id_defined(&amp;state=2Epeer_sessi=
on_id));</span><br><span>                     mi-&gt;context=2Ec2=2Etls_mul=
ti-&gt;n_sessions++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   session_skip_to_pre_start(session, &amp;state, &amp;m-&g=
t;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    session_skip_to_pre_start(session, &amp;state, from);</=
span><br><span>                 }</span><br><span>                 multi_ha=
sh_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span>          =
   }</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index 486210e=2E=2E0127b48 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -330,9 +330,12 @@</span><br><span>      * Limit frequency of in=
coming connections to control</span><br><span>      * DoS=2E</span><br><spa=
n>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;n=
ew_connection_limiter =3D frequency_limit_init(t-&gt;options=2Ecf_max, t-&g=
t;options=2Ecf_per);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   m-&gt;initial_rate_limiter =3D</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        initial_rate_limit_init(t-&gt;options=2Ecf_initial_max,=
 t-&gt;options=2Ecf_initial_per);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    m-&gt;new_connection_limiter =3D frequency_limit_init(t-&=
gt;options=2Ecf_max,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                                     t-&gt;options=2Ecf_pe=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;initia=
l_rate_limiter =3D initial_rate_limit_init(t-&gt;options=2Ecf_initial_max,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                  t-&gt;options=2Ecf_initial_per,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                         &amp;t-&gt;options=2Einitial_cf_bloom_config);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </spa=
n><br><span>     /*</span><br><span>      * Allocate broadcast/multicast bu=
ffer list</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec</span><br><span>index f9d60f6=2E=2E7b066c1 100644</span><br><=
span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/option=
s=2Ec</span><br><span>@@ -2638,6 +2638,23 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+check_filter_tier_under_global_limit(struct filter_tier *ft=
, int limit,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                              const char *family)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    while (ft)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (ft-&gt;limit &lt; limit)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(M_WARN, &quot;Note: --connect-freq-initial-bloom-limit %s %=
d %d &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                &quot;has a larger limit than connect-freq-limit-initial &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;limit (%d)=2E&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                family, ft-&gt;netmask, ft-&gt;limit, limit=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ft =3D ft-&gt;next;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span> options_postprocess_verify(const struct o=
ptions *o)</span><br><span> {</span><br><span>     if (o-&gt;connection_lis=
t)</span><br><span>@@ -2672,6 +2689,18 @@</span><br><span>                 =
        &quot;Ignoring these options=2E&quot;);</span><br><span>         }<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((bool)(o=
-&gt;initial_cf_bloom_config=2Einet_tiers)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            + (bool)(o-&gt;initial_cf_bloom_config=
=2Einet6_tiers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,=
 &quot;connect-freq-initial-bloom-limit must be provided for &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     &quot;=
both inet and inet6&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
eck_filter_tier_under_global_limit(o-&gt;initial_cf_bloom_config=2Einet_tie=
rs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                         o-&gt;cf_initial_max, &quot;inet&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    check_filter_tier_under_g=
lobal_limit(o-&gt;initial_cf_bloom_config=2Einet6_tiers,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
   o-&gt;cf_initial_max, &quot;inet6&quot;);</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span>@@ -5991,6 +6020,73 @@<=
/span><br><span>         options-&gt;cf_initial_max =3D cf_max;</span><br><=
span>         options-&gt;cf_initial_per =3D cf_per;</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(=
p[0], &quot;connect-freq-initial-bloom-size&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSIO=
N(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int cf_bloom_=
size =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (cf_blo=
om_size &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(msglevel, &quot;--connect-freq-initial-bloom-size size must be &gt; 0&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;=
initial_cf_bloom_config=2Esize =3D cf_bloom_size;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (p[2])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            int num_hash =3D atoi(p[1]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (num_hash &lt;=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglev=
el, &quot;--connect-freq-initial-bloom-size number of hash &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 &quot;functions must be &gt; 0&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                goto err;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            options-&gt;initial_cf_bloom_config=2Enum_h=
ashes =3D num_hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0],=
 &quot;connect-freq-initial-bloom-limit&quot;) &amp;&amp; p[1] &amp;&amp; p=
[2]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             &am=
p;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     int netmask =3D atoi(p[2]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int limit =3D atoi(p[3]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (limit &lt;=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(msglevel, &quot;Limit parameter to %s must be &gt; 0=
&quot;, p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[1], &quot;in=
et&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (net=
mask &lt; 0 || netmask &gt; 32)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(msglevel, &quot;Netmask parameter (%s) for IPv4 f=
or %s must be &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              &quot;between 0 and 32&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    p[2], p[0]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto =
err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            reflect_a=
dd_filter_tier(&amp;options-&gt;initial_cf_bloom_config,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                    &a=
mp;options-&gt;gc, false, netmask, limit);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else if (streq(p[1], &quot;inet6&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (netmask &lt; 0 || netmask=
 &gt; 128)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 msg(msglevel, &quot;Netmask parameter (%s) for IPv6 for %s must be &quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
          &quot;between 0 and 128&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    p[2], p[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            reflect_add_filter_tier(&amp;=
options-&gt;initial_cf_bloom_config,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                    &amp;options-&gt;gc, t=
rue, netmask, limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel,=
 &quot;Unknown parameter %s for %s=2E Must be inet or inet6&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                p[1], p[0]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     =
else if (streq(p[0], &quot;max-clients&quot;) &amp;&amp; p[1] &amp;&amp; !p=
[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_=
P_GENERAL);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/open=
vpn/options=2Eh</span><br><span>index 3c05cd5=2E=2E7e24ef7 100644</span><br=
><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/opti=
ons=2Eh</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;c=
linat=2Eh&quot;</span><br><span> #include &quot;crypto_backend=2Eh&quot;</s=
pan><br><span> #include &quot;dns=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;reflect_filter=2Eh&quot;</span><br><=
span> </span><br><span> </span><br><span> /*</span><br><span>@@ -533,6 +534=
,8 @@</span><br><span>     int cf_initial_max;</span><br><span>     int cf_=
initial_per;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct bloom_filter_conf initial_cf_bloom_config;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     uint32_t=
 max_clients;</span><br><span>     int max_routes_per_client;</span><br><sp=
an>     int stale_routes_check_interval;</span><br><span>diff --git a/src/o=
penvpn/ovpn_dco_linux=2Eh b/src/openvpn/ovpn_dco_linux=2Eh</span><br><span>=
index b3c9ff0=2E=2E7366177 100644</span><br><span>--- a/src/openvpn/ovpn_dc=
o_linux=2Eh</span><br><span>+++ b/src/openvpn/ovpn_dco_linux=2Eh</span><br>=
<span>@@ -6,105 +6,113 @@</span><br><span> #ifndef _UAPI_LINUX_OVPN_H</span=
><br><span> #define _UAPI_LINUX_OVPN_H</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define OVPN_FAMILY_NAME	&quot;ovpn&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OVPN_FAMILY_=
VERSION	1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OV=
PN_FAMILY_NAME    &quot;ovpn&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define OVPN_FAMILY_VERSION 1</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define OVPN_NONCE_TAIL_SIZE	8</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_NONCE_TAIL=
_SIZE 8</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-enum ovpn_cipher_alg {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_CIPHER_ALG_NONE,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_CIPHER_ALG_AES_GCM,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	OVPN_CIPHER_ALG_CHACHA20_POLY1305,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+enum ovpn_cipher_alg</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    OVPN_CIPHER_ALG_NONE,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_CIPHER_ALG_AES_GCM,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    OVPN_CIPHER_ALG_CHACHA20_POLY1305,</span><br><s=
pan> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-enum ovpn_del_peer_reason {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	OVPN_DEL_PEER_REASON_TEARDOWN,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_USERSPACE,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_EXPIRED,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TRANSPORT_ER=
ROR,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_RE=
ASON_TRANSPORT_DISCONNECT,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+enum ovpn_del_peer_reason</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_DEL_PEER_REASON_TEARDOWN,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_DEL_PEER_REASON_USERSPACE,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_=
ERROR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_=
PEER_REASON_TRANSPORT_DISCONNECT,</span><br><span> };</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_key_slot {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_SLOT_PRIMARY,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_SLOT_SECONDARY=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum ovpn_key_slot=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_SLOT_PRIMARY,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_SLOT_SECONDARY,</=
span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-enum {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	OVPN_A_PEER_ID =3D 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_A_PEER_REMOTE_IPV4,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_A_PEER_REMOTE_IPV6,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_PORT,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	OVPN_A_PEER_SOCKET,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	OVPN_A_PEER_SOCKET_NETNSID,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_IPV4,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_IPV6,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LOCAL_IPV4,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LOCAL_IPV6,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LOCAL_PORT,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_KEEPALIVE_INTERVAL,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_KEEPALIV=
E_TIMEOUT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEE=
R_DEL_REASON,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_=
PEER_VPN_RX_BYTES,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OV=
PN_A_PEER_VPN_TX_BYTES,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	OVPN_A_PEER_VPN_RX_PACKETS,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	OVPN_A_PEER_VPN_TX_PACKETS,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	OVPN_A_PEER_LINK_RX_BYTES,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_A_PEER_LINK_TX_BYTES,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LINK_RX_PACKETS,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LINK_TX_PACKETS,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+enum</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_A_PEER_ID =3D 1,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_A_PEER_REMOTE_IPV4,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_A_PEER_REMOTE_IPV6,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_REMO=
TE_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_=
PEER_SOCKET,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_A_PEER_SOCKET_NETNSID,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_A_PEER_VPN_IPV4,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_A_PEER_VPN_IPV6,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_A_PEER_LOCAL_IPV4,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LOCAL_IPV6,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LOCAL_PORT,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_KEEPALIVE_INTERVA=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_K=
EEPALIVE_TIMEOUT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OVPN_A_PEER_DEL_REASON,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_A_PEER_VPN_RX_BYTES,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    OVPN_A_PEER_VPN_TX_BYTES,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_RX_PACKETS,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_TX_PACKETS,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LINK_RX_B=
YTES,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEE=
R_LINK_TX_BYTES,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 OVPN_A_PEER_LINK_RX_PACKETS,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_A_PEER_LINK_TX_PACKETS,</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_A_PEER_MAX,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_MAX =3D (__OVPN_A_PEER_MA=
X - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_A_=
PEER_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A=
_PEER_MAX =3D (__OVPN_A_PEER_MAX - 1)</span><br><span> };</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_PEER_ID =3D 1,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_SLOT,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_KEY_ID,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_CIPHER_AL=
G,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_ENC=
RYPT_DIR,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYC=
ONF_DECRYPT_DIR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enu=
m</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF_PEER_ID =3D 1,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF_SLO=
T,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCON=
F_KEY_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A=
_KEYCONF_CIPHER_ALG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    OVPN_A_KEYCONF_ENCRYPT_DIR,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_A_KEYCONF_DECRYPT_DIR,</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_A_KEYCONF_MAX,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_MAX =3D (__OVPN_A=
_KEYCONF_MAX - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  __OVPN_A_KEYCONF_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_A_KEYCONF_MAX =3D (__OVPN_A_KEYCONF_MAX - 1)</span><br><span> =
};</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-e=
num {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYDIR_C=
IPHER_KEY =3D 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN=
_A_KEYDIR_NONCE_TAIL,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYDIR_CIPHER_KEY =
=3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KE=
YDIR_NONCE_TAIL,</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	__OVPN_A_KEYDIR_MAX,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	OVPN_A_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_A_KEYDIR_MAX,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYDIR_MAX =3D (_=
_OVPN_A_KEYDIR_MAX - 1)</span><br><span> };</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-enum {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	OVPN_A_IFINDEX =3D 1,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	OVPN_A_PEER,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_A_KEYCONF,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_IFINDEX=
 =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_P=
EER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYC=
ONF,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	__OVPN_A_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_=
A_MAX =3D (__OVPN_A_MAX - 1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    __OVPN_A_MAX,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_A_MAX =3D (__OVPN_A_MAX - 1)</span><br><span> };</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_NEW =3D 1,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_SET,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_GET,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_DEL,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_DEL_NTF,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_NEW,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_GET,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_SWAP,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_SWAP_NTF,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_KEY_DEL,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_PEER_FLOAT_NTF,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+enum</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_CMD_PEER_NEW =3D 1,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_CMD_PEER_SET,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_CMD_PEER_GET,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_DEL,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_DEL_NTF,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_NEW,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_GET,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_SWAP,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_SWAP_NTF,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_KEY_DEL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_FLOAT_=
NTF,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	__OVPN_CMD_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVP=
N_CMD_MAX =3D (__OVPN_CMD_MAX - 1)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    __OVPN_CMD_MAX,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)</span><br><span> }=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine OVPN_MCGRP_PEERS	&quot;peers&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OVPN_MCGRP_PEERS &quot;peers&quot;</span><br><=
span> </span><br><span> #endif /* _UAPI_LINUX_OVPN_H */</span><br><span>dif=
f --git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/reflect_filter=2Ec</=
span><br><span>index e5226e4=2E=2E88def88 100644</span><br><span>--- a/src/=
openvpn/reflect_filter=2Ec</span><br><span>+++ b/src/openvpn/reflect_filter=
=2Ec</span><br><span>@@ -5,7 +5,8 @@</span><br><span>  *             packet=
 encryption, packet authentication, and</span><br><span>  *             pac=
ket compression=2E</span><br><span>  *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  Copyright (C) 2022-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2023-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 Arne Sch=
wabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span>  *</span><br><span>  *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span>  *  it under the terms of the GNU General Public License version 2=
</span><br><span>@@ -37,8 +38,7 @@</span><br><span> #include &quot;crypto=
=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static bool</span><br><span> reflect_filter_rat=
e_limit_check(struct initial_packet_rate_limit *irl)</span><br><span> {</sp=
an><br><span>     if (now &gt; irl-&gt;last_period_reset + irl-&gt;period_l=
ength)</span><br><span>@@ -73,34 +73,380 @@</span><br><span>     return !ov=
er_limit;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit=
 *irl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_filter_tier(str=
uct initial_packet_rate_limit *irl,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                  struct filter_tier *tier, const char *pre=
fix)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (; tier !=3D NULL; tier =3D tier-&gt;next)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (tier-&gt;dropped &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(D_TLS_DEBUG_LOW, &quot;Dropped =
%zu initial handshake packets due to &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                 &quot;--connect-fr=
eq-initial-bloom-limit %s %d %d&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                tier-&gt;dropped, prefix, tier-&gt;netma=
sk, tier-&gt;limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            tier-&gt;dropped =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bloom_filter_check_reset(struct initial_packet_rate_=
limit *irl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (now &gt; irl-&gt;l=
ast_period_reset + irl-&gt;period_length)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        reset_filter_tier(irl, irl-&gt;bloom_conf=2Einet_tiers, &qu=
ot;inet&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    reset_filter_tier(irl, irl-&gt;bloom_conf=2Einet6_tiers, &quot;inet6&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        bloom_clear(irl-&gt;bf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * structure used as lookup key=
 for the bloom structure=2E We used the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * netmask as part of the structure to avoid the look f=
or the first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * IP o=
f a subnet and the subnet to be same key=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct bloom_filter_key</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct in_addr in;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr=
 in6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int netmask;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* we keep the count in th=
e key instead of in the bloom filter table as</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * can then keep the counter in the bloom fil=
ter itself small (2 bits)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * and bloom filter usage is the same for 20000 request from the =
same IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (20k =
entries with different count but same IP) and from 20000 random ips</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * (20k entries with co=
unt 1 but different IP) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int count;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static inline struct bloom_filter_=
key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+filter_mask_inet=
6(const struct openvpn_sockaddr *addr, int netmask)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct bloom_filter_key ret =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ret=2Ein6 =3D addr-&gt;addr=2Ein=
6=2Esin6_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int bits_to_clear =
=3D 128 - netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int bytes_to_clear =3D bits_to_clear / 8;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bits_to_clear =3D bits_to_clear % 8;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    memset(&amp;ret=2Ein6=2Es6_addr[15 - bytes_t=
o_clear], 0x00, bytes_to_clear);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
t=2Ein6=2Es6_addr[15 - bytes_to_clear - 1] &amp;=3D (0xff &lt;&lt; bits_to_=
clear);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ret=2Enetmask =3D netmask;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline struct bloom_filter_key</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+filter_mask_inet(const struct openvpn_sockaddr *addr, int ne=
tmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter_key ret=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
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
0%);">+convert_mapped_inet_sockaddr(const struct openvpn_sockaddr *from)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from_mapped =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we=
 ignore the fields like port that the key in the bloom filter</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * ignores too=2E This makes =
this function non-generic */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from_m=
apped=2Eaddr=2Ein4=2Esin_family =3D AF_INET;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    memcpy(&amp;from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_addr,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;from-&gt;ad=
dr=2Ein6=2Esin6_addr=2Es6_addr[12],</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           sizeof(from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_a=
ddr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return from_mapped;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bloom_filter_action(struct initial_packet_rate_limit *irl,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    const struct o=
penvpn_sockaddr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    enum bloom_filter_action action)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool found =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct filter_tier *tier =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from_mapped;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (from-&gt;addr=2Esa=2Esa_family =3D=3D AF_=
INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&=
amp; IN6_IS_ADDR_V4MAPPED(&amp;from-&gt;addr=2Ein6=2Esin6_addr))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        from_mapped =3D convert_mapped_inet_=
sockaddr(from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    from =3D &amp;from_mapped;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (from-&gt;addr=
=2Esa=2Esa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        tier =3D irl-&gt;bloom_conf=2Einet_tiers;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (from-&gt;addr=2Esa=2Esa_family =3D=3D AF_INET6=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tier =3D irl-&gt;bloom_c=
onf=2Einet6_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    while (tier)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct filter_tier *next_tier =3D tier-&gt;=
next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 bloom_filter_key key;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (from=
-&gt;addr=2Esa=2Esa_family =3D=3D AF_INET6)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            key =3D filter_mask_inet6(from, tier-&gt;netmask)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            key =3D filter_mask_inet(from, ti=
er-&gt;netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* fetch the current cou=
nt of the key in the bloom filter */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        int result =3D reflect_lookup_bf_key(irl-&gt;bf, &=
amp;key, tier-&gt;limit);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        switch (action)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            case REFLECT_CHECK:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if (result &gt;=3D tier-&gt;limit)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    found=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           tier-&gt;dropped++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    if (tier-&gt;dropped =3D=3D 1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        msg(M_W=
ARN, &quot;Note: --connect-freq-initial-bloom-limit &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
&quot;limit for netmask /%d exceeded=2E Expect additional &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
      &quot;initial packet drops for the next %d seconds&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            tie=
r-&gt;netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       (int)(irl-&gt;last_period_reset + irl-&gt;period_len=
gth - now));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            case REFLEC=
T_INCREASE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        ASSERT(result &lt; tier-&gt;limit);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                key=2Ecount =3D result + 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                bloom_add(i=
rl-&gt;bf, (const uint8_t *)&amp;key, sizeof(key));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            case REFLECT_DECREASE:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                key=2Ecount =3D result - =
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                b=
loom_remove(irl-&gt;bf, (const uint8_t *)&amp;key, sizeof(key));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                break;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        tier =3D next_tier;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!found &amp;&amp; action =3D=3D REFLECT_CHECK)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* We only want to increase the c=
ounters if the IP is not already</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * in the set=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        bloom_filter_action(irl, from, REFLECT_INCREAS=
E);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return found;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bl=
oom_filter_check(struct initial_packet_rate_limit *irl,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   const struct openvpn=
_sockaddr *from)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (now &gt; irl-=
&gt;last_period_reset + irl-&gt;period_length)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        bloom_filter_check_reset(irl);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        bloom_clear(irl-&gt;bf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return bloom_filter_action(irl, from, REFLECT_CHECK);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect_filter_che=
ck(struct initial_packet_rate_limit *irl,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     const struct openvpn_sockaddr *f=
rom)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* We are doing the bloom fil=
ter check first so packets that are already</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * rejected by the bloom filter do not count ag=
ainst the limit of the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * simple rate limiter */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (irl-&gt;bf &amp;&amp; bloom_filter_check(irl, from))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!reflect_filter_rate_limit_check(irl))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect_=
filter_rate_limit_decrease(struct initial_packet_rate_limit *irl, struct op=
envpn_sockaddr *from)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (irl-&gt;=
bf &amp;&amp; bloom_filter_action(irl, from, REFLECT_CHECK))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* Only remove if it is actually present=
=2E This might be a packet</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * coming from an early period or be relayed */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        bloom_filter_action(irl,=
 from, REFLECT_DECREASE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     if (irl-&gt;curr_period_counter &gt; 0)</span><br><span>     =
{</span><br><span>         irl-&gt;curr_period_counter--;</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc=
_arena *gc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                bool ipv6, int netmask, int limit)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct filter_tier *ftnew =3D gc_malloc(sizeof(struct filt=
er_tier), true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ftnew-&gt;netm=
ask =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ftnew-&gt;limit =3D limit;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ipv=
6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ftnew-&gt;next =3D bfco=
nf-&gt;inet6_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        bfconf-&gt;inet6_tiers =3D ftnew;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ftnew-&gt=
;next =3D bfconf-&gt;inet_tiers;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        bfconf-&gt;inet_tiers =3D ftnew;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+init_bloom_filter(struct initial=
_packet_rate_limit *irl)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!irl-=
&gt;bloom_conf=2Esize)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
the default allocates 2MB for bloom filter entries */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        irl-&gt;bloom_conf=2Esize =3D 102=
4ul * 1024 * 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!irl-&gt;b=
loom_conf=2Enum_hashes)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ir=
l-&gt;bloom_conf=2Enum_hashes =3D 7;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    irl-&gt;bf =
=3D bloom_create(irl-&gt;bloom_conf=2Esize, irl-&gt;bloom_conf=2Enum_hashes=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
         &amp;irl-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bloom_clear(irl-&gt;bf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span> </span><br><span> struct initial_packet_=
rate_limit *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-initial_r=
ate_limit_init(int max_per_period, int period_length)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+initial_rate_limit_init(int max_per_perio=
d, int period_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        struct bloom_filter_conf *bconf)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct initial_=
packet_rate_limit *irl;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct initial_packet_rate_limit *irl =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(irl, struct initial=
_packet_rate_limit);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ALLOC_OBJ(irl, struct initial_packet_rate_limit);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    irl-&gt;gc =3D gc_new();</span><br><span>=
 </span><br><span>     irl-&gt;max_per_period =3D max_per_period;</span><br=
><span>     irl-&gt;period_length =3D period_length;</span><br><span>     i=
rl-&gt;curr_period_counter =3D 0;</span><br><span>     irl-&gt;last_period_=
reset =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (bconf)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
irl-&gt;bloom_conf =3D *bconf;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        init_bloom_filter(irl);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     return irl;</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span> initial_rate_limit_free(struct =
initial_packet_rate_limit *irl)</span><br><span> {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;irl-&gt;gc);</span><br><spa=
n>     free(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  irl =3D NULL;</span><br><span> }</span><br><span>diff --git a/src/openvpn=
/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh</span><br><span>index =
84915e8c6=2E=2Ebe2b926 100644</span><br><span>--- a/src/openvpn/reflect_fil=
ter=2Eh</span><br><span>+++ b/src/openvpn/reflect_filter=2Eh</span><br><spa=
n>@@ -23,6 +23,30 @@</span><br><span> #define REFLECT_FILTER_H</span><br><s=
pan> </span><br><span> #include &lt;limits=2Eh&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;socket=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;bloom=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+struct filter_tier</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct filter_tier *next;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int limit;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The number o=
f packets we dropped since we went over this limit */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t dropped;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
ruct bloom_filter_conf</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct filt=
er_tier *inet_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct filter_tier *inet6_tiers;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Configuration of the bloom filter */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    size_t num_hashes;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> </span><br><span> /** struct that handles all the r=
ate limiting logic for initial</span><br><span>  * responses */</span><br><=
span>@@ -35,7 +59,7 @@</span><br><span>     int period_length;</span><br><s=
pan> </span><br><span>     /** Number of packets in the current period=2E W=
e use int64_t here</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * to avoid any potiential issues with overflow */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * to avoid any potential issues with=
 overflow */</span><br><span>     int64_t curr_period_counter;</span><br><s=
pan> </span><br><span>     /* Last time we reset our timer */</span><br><sp=
an>@@ -44,29 +68,57 @@</span><br><span>     /* we want to warn once per per=
iod that packets are being started to</span><br><span>      * be dropped */=
</span><br><span>     bool warning_displayed;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct bloom_filter_conf bloom_conf;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct bloom_filter *bf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* gc_arena used for the various allocations by this =
struct */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc;</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Adds a bloom filter tier to the bloom filter config=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+reflect_add_filter_tier(struct bloom_filter_conf *=
bfconf, struct gc_arena *gc,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        bool ipv6, int netmask, int limit);</span>=
<br><span> </span><br><span> /**</span><br><span>  * checks if the connecti=
on is still allowed to connect under the rate</span><br><span>  * limit=2E =
This also increases the internal counter at the same time</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool reflect_filte=
r_rate_limit_check(struct initial_packet_rate_limit *irl);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+reflect_filter_check(struct initial_packet_rate_lim=
it *irl,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          const struct openvpn_sockaddr *from);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /**</span><=
br><span>  * decreases the counter of initial packets seen, so connections =
that</span><br><span>  * successfully completed the three-way handshake do =
not count against</span><br><span>  * the counter of initial connection att=
empts</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void reflect_filter_rate_limit_decrease(struct initial_packet_rate_lim=
it *irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect_filter_rate_limit=
_decrease(struct initial_packet_rate_limit *irl,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                   struct open=
vpn_sockaddr *from);</span><br><span> </span><br><span> /**</span><br><span=
>  * allocate and initialize the initial-packet rate limiter structure</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Note: this function does not copy bcon=
f&#39;s contents=2E</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-struct initial_packet_rate_limit *initial_rate_limit_ini=
t(int max_per_period, int period_length);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+struct initial_packet_rate_limit *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+initial_rate_limit_init(int max_per_pe=
riod, int period_length,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        struct bloom_filter_conf *bconf);</span><br><s=
pan> </span><br><span> /**</span><br><span>  * free the initial-packet rate=
 limiter structure</span><br><span>  */</span><br><span> void initial_rate_=
limit_free(struct initial_packet_rate_limit *irl);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * I=
nitialises the bloom filter with the configuration values of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * irl-&gt;bloom_conf</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+init_bloom_filter(struct initial_packet_rate_limit *irl);</span=
><br><span> #endif /* ifndef REFLECT_FILTER_H */</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>index 5430ecb=2E=2Ed86bcf8 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam</span><br><span>@@ -103,6 +103,7 @@</span><br=
><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D=
 test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	tes=
t_reflect=2Ec test_reflect=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2E=
h test_common=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><span=
> 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_reflect=2Ec b/tests/unit_tests/openvpn=
/test_reflect=2Ec</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000=2E=2Ed0d11c6</span><br><span>--- /dev/null</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_reflect=2Ec</span><br><span>@@ -0,0 +1,293 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to sec=
urely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet encryption, packet authentication=
, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;config-msvc=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;bloom=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;reflect_filter=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static_assert(BLOOM_FILTER_BITS_COUNT =3D=3D 4, =
&quot;unit test not in sync&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static_assert(BLOOM_FILTER_BITS_MASK =3D=3D 0xf, &quot;unit=
 test not in sync&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_bloom(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static const int present_mod =3D 77;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Use a bloom fil=
ter with 1M entries (256kB) for the unit test */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct bloom_filter *bf =3D bloom_create(1=
024ul * 1024, 8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int=
32_t i =3D 0; i &lt; 20000; i +=3D present_mod)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        bloom_add(bf, (const uint8_t *)&amp;i, sizeof(i));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* all these should be positive, for the small unit=
 test we do not expect</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * false positive */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (int32_t i =3D 0; i &lt; 20000; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        int present =3D (i % present_mod =3D=3D 0) ? 1 =
: 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* cast=
 to bool to only get 1 and 0 for present/not present and not */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal((bool)=
bloom_test(bf, (const uint8_t *)&amp;i, sizeof(i)), present);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_reflect_ddos(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* This tests if the bloom filter implement=
ation does actually work with</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * the goal of dropping packets to a reflected /24 while stil=
l allowing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ot=
her clients */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Disable the norma=
l fallback that puts a hard cap on the reflection filter */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct initial_packet_rate_limi=
t *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;=
irl-&gt;gc, false, 24, 5);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc=
, false, 8, 20);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 init_bloom_filter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int num_le=
gimate_reject =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int num_legimate_accepted =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int num_ddos_rejected =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int num_ddos_accepted =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /24 ne=
t addresses in host byte order */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in_addr_t net_attack[4];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 3; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        net_attack[i] =3D random() % 0xff;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* The 4th network is close enough to the 3rd to fall i=
n the same /16 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* XOR the 3rd byte to achieve this */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    net_attack[3] =3D net_attack[2] ^ 00002300;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Assume 200000 packets, including rough=
ly 200 legitimate packets,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * the unit test works also with 20 millions packet but takes to=
o long*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static =
const int total_packets =3D 200 * 1000;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int i =3D 0; i &lt; total_packets; i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct openvpn_sockaddr from =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        from=2Eaddr=2Ein4=2Esin=
_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t)random();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        from=2Eaddr=2Ei=
n4=2Esin_port =3D (uint16_t)random();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (i % 1023 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* roughly 200 legitimate clients with random addresses */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            from=2Eaddr=
=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t)random();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            bool allowed =3D reflect_filter_check(irl, &amp;=
from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (allowed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  num_legimate_accepted++;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        num_legimate_reject++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* We atta=
ck the 4 networks at random */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t=
)(net_attack[random() % 4] + (random() % 256));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            bool allowed =3D reflect_filter_check(irl, &amp;from);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (all=
owed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                num_=
ddos_accepted++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                nu=
m_ddos_rejected++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(num_legimate_reject + num_leg=
imate_accepted + num_ddos_accepted + num_ddos_rejected, total_packets);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* We assume that most legitimate mad=
e it through but a few were unfortunate to be in an attacked network */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range=
(num_legimate_reject, 0, 10);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We=
 disabled total number of packets, so we expect all /8 to have their</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * 20 packets, which i=
s 5120=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_in_range(num_ddos_accepted, 0, 256 * 20);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    initial_rate_limit_free(irl);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_bloom_minimal(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter *bf =3D bl=
oom_create(2048, 3, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i=
tem =3D 0xbabe;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_add(bf, (cons=
t uint8_t *)&amp;item, sizeof(item));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(bloom_test(bf, (const uint8_t *)&amp=
;item, sizeof(item)), 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    item =3D =
0xf00f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(bloom_test(bf, (const uint8_t *)&amp;item, sizeof(item)), 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reflect_ref=
lect_bloom_simple(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 30=
0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&=
amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true, 32, 50);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&g=
t;bloom_conf, &amp;irl-&gt;gc, true, 56, 200);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    init_bloom_filter(irl);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct openvpn_sockaddr from =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    from=2Eaddr=2Ein6=2Esin6_family=
 =3D AF_INET6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
rom=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    from=2Eaddr=2Ein6=2Esin6_addr=2Es6_ad=
dr[15] =3D 1; /* ::1 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* There ar=
e 50 attempts that should work until one fails */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 50; i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_true(reflect_filter_check(=
irl, &amp;from));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* 2002::1 */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from2 =3D=
 from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from2=2Ea=
ddr=2Ein6=2Esin6_addr=2Es6_addr[0] =3D 0x7;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    from2=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[1] =3D=
 0x7;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reflect_filter_ch=
eck(irl, &amp;from2));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Any more =
attempts from ::1 should fail */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(reflect_filter_check(irl, &amp;from));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    initial_rate_limit_free(irl);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ref=
lect_bloom_netmask_masking(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct initial_packet_rate_limit *irl =3D initial_rate_limit_init(IN=
T_MAX, 300, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reflect_add_filt=
er_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true, 45, 10);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    init_bloom_filter(irl);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from=2Eaddr=
=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    from=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; 15; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        from=2Eadd=
r=2Ein6=2Esin6_addr=2Es6_addr[i] =3D (uint8_t)random();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; 10; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* /45 means that if we leave the leave first 8 bytes and 5 =
bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * unto=
uched, it is still the same subnet  */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (int j =3D 8; j &lt; 15; j++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            from=2Eaddr=2Ein6=2Esin6_addr=2E=
s6_addr[j] =3D (uint8_t)random();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            from=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[7] ^=3D (=
uint8_t)(random() &amp; 0x7);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        assert_true(reflect_filter_check(irl, &amp;from));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* testing the last IP again should give us a negative result */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ref=
lect_filter_check(irl, &amp;from));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 initial_rate_limit_free(irl);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_reflect_reflect_bloom_mapped(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct initial_packet_rate_limit *irl =3D init=
ial_rate_limit_init(INT_MAX, 300, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, fal=
se, 24, 50);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ref=
lect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, false, 8, 80=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_bloom_fi=
lter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Our OpenVPN server wi=
ll not receive IPv4 as well as IPv4 mapped</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * addresses in the same process but for the uni=
t test it is convient</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * to see if they actually mapped to the same entries */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct openvpn_sockaddr mapped_v4 =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=
=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ::ffff:192=
=2E168=2E0=2E99 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[10] =3D 0xff;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6=
_addr=2Es6_addr[11] =3D 0xff;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[12] =3D 192;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2E=
in6=2Esin6_addr=2Es6_addr[13] =3D 168;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[14] =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2E=
addr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 99;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(IN6_IS_ADDR_V4MAPPED(&amp;mapped_v4=2Eaddr=2Ein6=2Esi=
n6_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Not the same address =
but in the same /8 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct openvpn_sockaddr v4addr =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    v4addr=2Eaddr=2Ein4=2Esin_family =3D AF_INE=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v4addr=2Eaddr=
=2Ein4=2Esin_port =3D (uint16_t)random();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* 192=2E168=2E123=2E244 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    v4addr=2Eaddr=2Ein4=2Esin_addr=2Es_ad=
dr =3D htonl(0xc0a87bf4);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check =
that we run into the 50 limit with our mapped address */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 50; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        assert_true(reflect_filter=
_check(irl, &amp;mapped_v4));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(reflect_filter_check(irl, &amp;mapped_v4));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Check that the non-mapped IPv4 address uses the same /8 subnet limit =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; 30; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ass=
ert_true(reflect_filter_check(irl, &amp;v4addr));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_false(reflect_filter_check(irl, &amp;v4addr));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    initial_rate_limit_free(irl);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No new=
line at end of file</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_reflect=2Eh b/tests/unit_tests/openvpn/test_reflect=2Eh</span><br><span=
>new file mode 100644</span><br><span>index 0000000=2E=2E0dc1e4c</span><br>=
<span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_ref=
lect=2Eh</span><br><span>@@ -0,0 +1,37 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 OpenVPN Inc &lt;sale=
s@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is free software; you can r=
edistribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by=
 the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
This program is distributed in the hope that it will be useful,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  You should have received a copy of the GNU General Public License al=
ong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef TEST_REFLECT_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define TEST_REFLECT_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_reflect_ddos(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_bloom(void **state);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void test_bloom_minimal(void **state);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void test_reflect_reflect_bloom_simple(void **state);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void test_reflect_bloom_netmask_masking(void **state)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void test_reflect_reflect_bloom_mappe=
d(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span>\ No newline at end of file</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>index 4baf8cc=2E=2E398bd56 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_ssl=2Ec</span><br><span>@@ -51,6 +51,7 @@</span><br><span>=
 #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;ssl_veri=
fy=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_reflect=2Eh&=
quot;</span><br><span> </span><br><span> /* Mock function to be allowed to =
include win32=2Ec which is required for</span><br><span>  * getting the tem=
p directory */</span><br><span>@@ -1111,8 +1112,13 @@</span><br><span>     =
    cmocka_unit_test(ssl_test_extract_last_matching_field),</span><br><span=
>         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),</span><br=
><span>         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject)=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_=
test(ssl_test_extract_peer_info)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(ssl_test_extract_peer_info),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_bloom),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_b=
loom_minimal),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_reflect_reflect_bloom_simple),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reflect_r=
eflect_bloom_mapped),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_reflect_bloom_netmask_masking),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_r=
eflect_ddos)</span><br><span>     };</span><br><span> </span><br><span> #if=
 defined(ENABLE_CRYPTO_OPENSSL)</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail=
">change 30</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;m=
ax@max-fillinger=2Enet&gt; </div>

</body></html>
--wbMi+1Fllbw=--


--===============6959708439418581008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6959708439418581008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6959708439418581008==--

