Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F2CC6B34
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CM4wMvtaz0FsYaAebQgfMUnpAS0TNlLdU36JXNRJsw=; b=Ku2pCog/fNrGTd3uf1qX2W4mKh
	VQpSF6ZnJT+jxlvfBZeqZAUtOHuVV4wGp4HVhFOLBo2j9fTc+Q6H16eWBpdBEJAX7a6Pf4w8MOjV7
	t34LaEwNy8gs9whnO+jr/FFwPXYZ9Qs3EITPlq2w04abGn7JG3Vwqps21lAXxXUl5y2Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJur-0003d4-Tl;
	Thu, 15 Oct 2026 11:46:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHJur-0003cy-CE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cPMu8ff+36lpWUVo00hmKew3XSVAXR0TKgV8B+zyAaY=; b=PrZ4S6Ir73Hs0qWTC9Sl8XGNGr
 n+iBUUFoZ6bAuNQ30p0pg5iG7UtkQZs/AtInG01JQTgw4SE2dBUUpqml1DTSsHl88+jW+e62AV2XG
 jx2PwTF/8Sn0JdL3arU+e0MrwFe9RCKckfO1/breo3ORvXwpLYXjbqb8l5MdZRYDnsEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cPMu8ff+36lpWUVo00hmKew3XSVAXR0TKgV8B+zyAaY=; b=E
 r62Y3cEm+6PIN3+wL7bwgMOCbqrUTuy2TQKEcxlRYM7JNqgoQj8pYIZvkV0ALC3HcSJN2Ic9SlgzT
 4q/D5hC24h6M5svhNxVy0XIH+gkU0G/SGjGSQjBTlc0rlKvXhCaZ3sg/bjA7hzp4DXRTDLqs+qeH1
 Q8Mk/iJ2LleEtt/g=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHJuk-0005FK-Gz for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:46:33 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso353666f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792064780; x=1792669580; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cPMu8ff+36lpWUVo00hmKew3XSVAXR0TKgV8B+zyAaY=;
 b=WT8fsDyZjjeMPtB6MzD/zmY1mS24EoAtb1+ZqBHJAOxFJBjeJiFC7XXRzZYFTOM9ij
 lb+kv70P1eR2av1bT33uK6NV6IhnOPrc14lqp9fneFioGQX+DDk+hAWfdGGlutoaExSd
 jRt6weXb8PWNgl1tCwTw8YcQThsPEYjpfqkukZ0mPUpIGisuqOoG8MTU//GJeveintMP
 Sg6wpeIGPrDNWi3JmMgcXiRfH2VClRPnem4T7mk1qB3CGu26eMLzoYc7XoHMsWLAQBty
 5f+pXs9CrHh0IBdow1an0XhElIb4gLj2pfXhZm/GoyrHI0IGW4P4lAK8k/YOm4nltFbA
 IyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792064780; x=1792669580;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cPMu8ff+36lpWUVo00hmKew3XSVAXR0TKgV8B+zyAaY=;
 b=z9PJxbLmzssBuxvy+Oah4TUHew/HS9ZJghR1E3AFoU61Jywg/HsYbQcRp2nrwucMHx
 DmeHVOU87Py9E7TCGB5RDDE4/8HnhE0PMTOWDTM75EcFnhP+kXvFFOkMGp1j3tsci5VR
 442tN87EM1/nHOIPJQw7VpWO/U1uU0qxpoeYpaU1iT7Jj3UFXLGCSzKyGhcB7I9Wj2B6
 8GJdJWBCtGRRpEIp6AY4wDvXWqi1dNAbHR3lkJaubqaK7EbqSZbCoTJ07sTmbwrxu1eh
 LUYCfboS0WhTv+0WOIBEoIVw35rftJQf/k3ht+c+H7SowXhlTqpt0ekoYWjBln2+mdN4
 ZIDA==
X-Gm-Message-State: AFq9FYKnOYKH6yPzxLdXw59A3FdX3U2o6WymFuItujiyUhwMb207phPK
 yk5doOCpBxhfrvAtTUhC0CDDEzpTei6MrJNSFHGSPz/zyXAUH+aZEZrNgv9guSSbtxRGUdRIAsM
 BcTXTDY6tLs6XnkaVeqMBaweRO5ee+HCJ8w5HZA3AZ8GHnCiN0vMKRlcaLPTC+YkTn9X3d7pGph
 0tY8c9cQ==
X-Gm-Gg: AYBFou0NwJZGauVbPUlBbjfMVDkCEHsM9oOKv7I/COv9GeahC72Brj4nz/aiE5YjOqy
 B/OBeCj28QFXaYZfZAQSLidK9GdmLF3/lzw3SYlsUjcCmP54EkXbo7uJTGJdhWLzzPoCWHq9gzm
 AWnJbCwYuQipxyzu83hlnjVYEzwOEhIoDpw1mw8WphE7h47MXScIRwbG7othHaXEY1m5HmGsjh2
 QNrNIT4TzNBP3S0z7R4o08zj0KC2156vNZZBlG9SbPRgyBEs0WI8qZG+04ramycPrbCs/MC8GvD
 MEE6z/YbaBkT3qHy9NvfBLIj3J2RM45iOMQS+0ldfcJm+fAUnGQwtPlTYXfPZC8nlAXrDUOQBA9
 /pljdev1IOJ18MKNWXSzXuuVRXZ87HfYJ2FEqAEG/t93PfPOmRJsIGNTsrtViHcNIE0ijc2Vqsd
 H5/kc/7rcDKUA0Y1EEthV+a373uBWOWh4VRkn/v03h625m5PeJ+yNQd9P5MM3oMKSk24IzIh8XF
 nawlpZMTD7iU8C+4y6QwBAcjwPUukZ+HRiwXu+4upp163vASJxmtbzxJoXf2KsE/CGaZ5mARCd2
 wlD9+zaIO+GHsV8IGFYnq97HLaQq7ik0NqArZfnoh+3ZQ9mxsrr7VqF72gRe
X-Received: by 2002:a05:6000:4814:b0:48a:f929:e140 with SMTP id
 ffacd0b85a97d-48dbaadaa3cmr33975121f8f.10.1792064778703; 
 Thu, 15 Oct 2026 04:46:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm12605807f8f.13.2026.10.15.04.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 04:46:17 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 11:46:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 1ba9599657b52d3f96357d3972ba3edf9fea1cec
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b3246293fe7953d81079c4d150d5988c4b10af9f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHJuk-0005FK-Gz
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1304833802776153130=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1304833802776153130==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2lQ+kBKN0Ww="; charset=UTF-8

--2lQ+kBKN0Ww=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail

to look at the new patch set (#12)=2E
=

The following approvals got outdated and were removed:
Code-Review-1 by Fr=
ank Lichtenheld


Change subject: Implement sending/receiving app custom co=
ntrol protocol messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Implement sending/receiving app custom control protocol messages=


This allows openvpn GUI/front-ends and server via management
to use the O=
penVPN control channel to pass messages between each other
while OpenVPN ha=
ndles the marshalling/unmarshalling of these and
negotiate the common app c=
ustom control protocols=2E

This provides an easy to use secure channel tha=
t does not depend on
the network itself to work and can also used before fu=
lly authenticating
the client=2E See the management-notes=2Etxt for more de=
tails how to use
this feature=2E An upcoming patch will also add some examp=
le python
script that showcase this feature=2E

Change-Id: I4a6a6ef41e15896=
b8b79d795b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
=
---
M CMakeLists=2Etxt
M doc/man-sections/client-options=2Erst
M doc/man-se=
ctions/management-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/=
Makefile=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/for=
ward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/mana=
ge=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/opti=
ons=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/ssl=2Ec=

M src/openvpn/ssl_common=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M te=
sts/unit_tests/openvpn/mock_management=2Ec
A tests/unit_tests/openvpn/mock_=
management=2Eh
M tests/unit_tests/openvpn/mock_push_dependencies=2Ec
A test=
s/unit_tests/openvpn/test_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M=
 tests/unit_tests/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_m=
isc=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
27 files changed, 1,407 ins=
ertions(+), 25 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/58/1858/12

diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt
index bac4dd4=2E=2E38f2ba8 100644
--- a/CMakeLists=2Etxt
+++ b/CMak=
eLists=2Etxt
@@ -433,6 +433,8 @@
     src/compat/compat-gettimeofday=2Ec
  =
   src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
+    sr=
c/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/argv=2Ec
     s=
rc/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -569,8 +571,8 @@
     sr=
c/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/openvpn/push=2Ec
-    src=
/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
+    src/openvpn/push_util=
=2Ec
     src/openvpn/pushlist=2Eh
     src/openvpn/reflect_filter=2Ec
    =
 src/openvpn/reflect_filter=2Eh
@@ -821,7 +823,10 @@
             tests/uni=
t_tests/openvpn/mock_management=2Ec
             tests/unit_tests/openvpn/m=
ock_ssl_dependencies=2Ec
             tests/unit_tests/openvpn/mock_win32_e=
xecve=2Ec
+            tests/unit_tests/openvpn/test_acc=2Ec
+            s=
rc/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
+            src/openv=
pn/auth_token=2Ec
             src/openvpn/base64=2Ec
             src/open=
vpn/crypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=2Ec
@@ -835,8 =
+840,11 @@
             src/openvpn/options_util=2Ec
             src/openv=
pn/otime=2Ec
             src/openvpn/packet_id=2Ec
+            src/openvp=
n/reliable=2Ec
+            src/openvpn/session_id=2Ec
             src/ope=
nvpn/run_command=2Ec
             src/openvpn/ssl_mbedtls=2Ec
+            =
src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_openssl=2Ec
          =
   src/openvpn/ssl_util=2Ec
             src/openvpn/ssl_verify_mbedtls=2Ec=

@@ -853,6 +861,8 @@
     target_sources(test_misc PRIVATE
         tests/u=
nit_tests/openvpn/mock_get_random=2Ec
         tests/unit_tests/openvpn/tes=
t_schedule=2Ec
+        tests/unit_tests/openvpn/mock_management=2Ec
+     =
   src/openvpn/base64=2Ec
         src/openvpn/options_util=2Ec
         sr=
c/openvpn/otime=2Ec
         src/openvpn/ssl_util=2Ec
diff --git a/doc/man-=
sections/client-options=2Erst b/doc/man-sections/client-options=2Erst
index=
 87c138a=2E=2E6500be4 100644
--- a/doc/man-sections/client-options=2Erst
++=
+ b/doc/man-sections/client-options=2Erst
@@ -12,6 +12,17 @@
   When this o=
ption is set, OpenVPN will not drop incoming tun packets with
   same desti=
nation as host=2E
 
+--app-custom-control protocollist
+  Sets the list of =
supported app custom control protocols=2E
+  These protocols are announced =
to the server when this option is used
+  as a client=2E If the option is s=
et on a server it will negotiate the
+  common protocols with the client=2E=

+
+  The protocollist is a : separated list of protocol identifiers=2E
+
+=
  See management-notes=2Etxt in the OpenVPN distribution and the OpenVPN RF=
C
+  draft for a description of app custom control protocol support=2E
+
 -=
-auth-token token
   This is not an option to be used directly in any confi=
guration files,
   but rather push this option from a ``--client-connect`` =
script or a
@@ -437,6 +448,12 @@
         Additional authentication methods=
 supported by the client=2E
         This may be set by the client UI/GUI u=
sing ``--setenv``=2E
 
+  :code:`IV_ACC=3D<max_msg_len>,<flags>,<protocols>=

+        If the option ``--app-custom-control`` is set, the client will
+ =
       send the supported max ACC message length, the supported formats
+  =
      as (:code:`A:6`) and the list of configured protocols (e=2Eg=2E
+    =
    :code:`flower:happy:power`)
+
   The following flags depend on which co=
mpression formats are compiled in
   and whether compression is allowed by =
options=2E See `Protocol options`_
   for more details=2E
diff --git a/doc/=
man-sections/management-options=2Erst b/doc/man-sections/management-options=
=2Erst
index e2e0773=2E=2Ed62407d 100644
--- a/doc/man-sections/management-=
options=2Erst
+++ b/doc/man-sections/management-options=2Erst
@@ -144,3 +14=
4,9 @@
 
 --management-up-down
   Report tunnel up/down events to managemen=
t interface=2E
+
+--app-custom-control protocol-list
+  Sets the app custom=
 control protocols that are supported and should be
+  negotiated=2E protoc=
ol-list is a list of allowed protocols separated by :
+  A client will anno=
unced these protocols via the IV_ACC variable and the
+  server will notify=
 the client about the common protocols=2E
\ No newline at end of file
diff =
--git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 325f8=
bd=2E=2E565b1b8 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/managemen=
t-notes=2Etxt
@@ -798,6 +798,58 @@
 The client should return the response t=
o the crtext challenge
 using the cr-response command=2E
 
+app custom cont=
rol
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special=
 string "ACC" is passed as {EXTRA} OpenVPN will determine
+the common app c=
ustom protocols between the client and the server and instruct
+the client =
that the server will send control messages to the client using
+the ACC pro=
tocol=2E
+
+The server should then use acc-msg command to send app custom c=
ontrol messages
+to the client to facilitate the pending authentication=2E
=
+
+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher)
+-------------------=
-----------------------
+
+On an OpenVPN instance running in server mode th=
is command sends an
+app custom control message to a client=2E The format o=
f the command is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
=
+  {message}
+  END
+
+CID,KID -- client ID and Key ID=2E See documentation=
 for ">CLIENT:"
+notification for more info=2E
+
+protocol -- the ACC proto=
col identifier that this message should be
+            tagged with=2E
+
+f=
lags    -- a colon separated list of the encoding and the flag if
+        =
    the message is a fragment=2E E=2Eg=2E "6:F" for a base64 encoded
+     =
       message that is also a fragment and not complete yet=2E
+
+message  =
-- The message encoded in the encoding specified in flags
+
+
+COMMAND -- a=
cc-msg (OpenVPN 2=2E8 or higher)
+-----------------------------------------=
-
+
+When OpenVPN is running in --client mode this command sends an app
+cu=
stom command to the server=2E The format of the command is
+
+  acc-msg
+  =
{protocol}
+  {flags}
+  {message}
+  END
+
+See the client-acc-msg command=
 for more details about the format of the
+message=2E Since a client has on=
ly one peer there is no need to specify the
+client id and key id=2E
+
+
 C=
OMMAND -- client-deny  (OpenVPN 2=2E1 or higher)
 -------------------------=
----------------------
 
@@ -1272,6 +1324,40 @@
    response=2E Mechanisms =
that need multiple rounds or more complex answers
    should implement a di=
fferent response type than CR_RESPONSE=2E
 
+(6) App custom control message=

+
+    This message is an application specific payload message that is tra=
nsported
+    over the OpenVPN control channel=2E
+
+    In server mode:
+
=
+    >CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}
+
+    In c=
lient mode:
+
+    >ACC:{protocol},{fragment},{msg_base64}
+
+    The proto=
col is a short ascii string identifying the app specific custom
+    protoc=
ol=2E If fragment is set to 1, the message is not complete and the
+    nex=
t message should be concatenated to this message to form a complete
+    me=
ssage=2E
+
+(7) App custom control protocol message
+
+   This message info=
rm the server or client about the common ACC
+   protocols and the maximum =
message length for an ACC message=2E
+
+   In server mode:
+
+   >CLIENT:AC=
C_PROTOCOLS,{CID},protocols=3D{protocol_list},message_len=3D{max_msg_len}
+=

+   In client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protocol_list},messa=
ge_len=3D{max_msg_len}
+
+   protocol_list is a list of supported protocols=
 by the client=2E For example
+   flower:power:sys_info would indicate thes=
e three protocols to be supported=2E
+   max_msg_len specifies the maximum =
message length that the peer supports=2E
 
 Variables:
 
diff --git a/src/o=
penvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 7ecddff=2E=2Ec82e5af=
 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ =
-42,6 +42,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2E=
c acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	base6=
4=2Ec base64=2Eh \
@@ -121,7 +122,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec =
proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2E=
c push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec reflec=
t_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/acc=
=2Ec b/src/openvpn/acc=2Ec
new file mode 100644
index 0000000=2E=2E4af5ad4
=
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,404 @@
+/*
+ *  OpenVPN =
-- An application to securely tunnel IP networks
+ *             over a sin=
gle TCP/UDP port, with support for SSL/TLS-based
+ *             session au=
thentication and key exchange,
+ *             packet encryption, packet au=
thentication, and
+ *             packet compression=2E
+ *
+ *  Copyright =
(C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Sch=
wabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you c=
an redistribute it and/or modify
+ *  it under the terms of the GNU General=
 Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#i=
nclude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <string=
=2Eh>
+#include "buffer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#in=
clude "forward=2Eh"
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+=
#include "ssl_ncp=2Eh"
+#include "multi=2Eh"
+
+enum acc_message_flag
+{
+ =
   ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+   =
 ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+log_acc_message(st=
ruct context *c, const struct buffer *buf, int payload_len,
+              =
  const char *protocol, int flags)
+{
+    bool fragment =3D flags & ACC_ME=
SSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =3D=
 gc_new();
+    const char *payload_msg =3D NULL;
+
+    /* For simplicity,=
 we always encode payload to be base64 encoded
+     * if not already in ba=
se64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        ch=
ar *b64out =3D NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf), payl=
oad_len, &b64out) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
+    =
    payload_msg =3D b64out;
+    }
+    else
+    {
+        payload_msg =
=3D CBSTR(buf);
+    }
+
+    if (management)
+    {
+        struct tls_se=
ssion *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        struc=
t man_def_auth_context *mda =3D session->opt->mda_context;
+        if (c->=
options=2Emode =3D=3D MODE_SERVER)
+        {
+            /* server mode=
=2E Report client context */
+            unsigned int mda_key_id =3D get_p=
rimary_key(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLI=
ENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol, =
fragment, payload_msg);
+        }
+        else
+        {
+            /*=
 Client mode=2E Do not a report a CLIENT id */
+            msg(M_CLIENT, "=
>ACC:%s,%d,%s", protocol, fragment, payload_msg);
+        }
+    }
+    gc=
_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Receive=
d custom app control message (protocol '%s'%s)",
+        protocol, fragmen=
t ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses the flags field of an app c=
ontrol message and moves the
+ *  buffer past the flags string=2E If there =
is an
+ *  error parsing the flags field the method returns -1 and
+ *  put=
s the error reason in err_reason
+ */
+static int
+parse_acc_message_flags(=
struct buffer *buf, const char **err_reason, struct gc_arena *gc)
+{
+    c=
onst char *flags =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags)
+ =
   {
+        *err_reason =3D "could not extract flags field";
+        ret=
urn -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    for (const char *flag =
=3D flags; *flag !=3D '\0'; flag++)
+    {
+        if (*flag =3D=3D 'A')
+=
        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;
+        }
+=
        else if (*flag =3D=3D '6')
+        {
+            acc_flags |=3D A=
CC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (*flag =3D=3D 'F')
+  =
      {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
=
+        else
+        {
+            *err_reason =3D "Unknown flag in flag=
s";
+            return -1;
+        }
+    }
+    /* The message should be=
 encoded with exactly one encoding=2E Ensure that
+     * only one of the f=
lags is present */
+    bool asciienc =3D (bool)(acc_flags & ACC_MESSAGE_FL=
AGS_ASCII);
+    bool base64enc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_BA=
SE64);
+
+    if (base64enc + asciienc !=3D 1)
+    {
+        char *tmp =
=3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "number of encodings=
 must be exactly one "
+                           "(B64=3D%d, ASCII=3D%d)"=
,
+                 base64enc, asciienc);
+        *err_reason =3D tmp;
+  =
      return -1;
+    }
+
+    return acc_flags;
+}
+
+
+void
+receive_acc_=
message(struct context *c, const struct buffer *buffer)
+{
+    struct gc_a=
rena gc =3D gc_new();
+    const char *err_reason =3D "";
+
+    /* Example=
 message: ACC,muppets,15,A,I am Miss Piggy */
+    struct buffer buf =3D *b=
uffer;
+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf) !=
=3D ',')
+    {
+        err_reason =3D "missing , after ACC";
+        got=
o err;
+    }
+
+    /* extract protocol, payload length, flags substrings =
*/
+    char *protocol =3D buf_extract_field(&buf, ',', &gc);
+    if (!pro=
tocol)
+    {
+        err_reason =3D "could not extract protocol field";
+=
        goto err;
+    }
+
+    int payload_len;
+    char *payload_len_str=
 =3D buf_extract_field(&buf, ',', &gc);
+    if (!payload_len_str || !((pay=
load_len =3D atoi(payload_len_str))))
+    {
+        err_reason =3D "could=
 not extract payload length field";
+        goto err;
+    }
+
+    int fl=
ags =3D parse_acc_message_flags(&buf, &err_reason, &gc);
+
+    if (flags <=
 0)
+    {
+        goto err;
+    }
+
+    /* We should have a final NUL b=
yte in the control message buffer
+     * and thus the length of the buffer=
 should be payload_len + 1 */
+    if (buf_len(&buf) !=3D payload_len + 1)
=
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
+        snprintf(tmp=
, 512, "field length %d, payload length %d mismatch",
+                 pay=
load_len, buf_len(&buf) - 1);
+        err_reason =3D tmp;
+        goto er=
r;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, protocol, flags);
=
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: R=
eceived malformed custom app control channel "
+                       "(%s=
) message control message: %s",
+        err_reason,
+        format_hex(BP=
TR(&buf), BLEN(&buf), 80, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_acc_=
message(struct context *c,
+                 struct tls_multi *tls_multi,
+=
                 struct tls_session *session,
+                 const char =
*protocol, bool fragment,
+                 const char *msg, bool base64)
+=
{
+    /*
+     * length of the protocol string + one ','
+     * 2 for the=
 encoding (A or 6), potential F (fragment), and 1 for the ',',
+     * 4 fo=
r the message size itself and one comma
+     * 1 for the comma before the =
message itself */
+    const size_t max_header_size =3D strlen("ACC,") + st=
rlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_header_size + s=
trlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CL=
IENT, "message length (%zu) exceeds maximum possible message length (%d)", =
len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+    }
+
+    if ((int)l=
en > c->options=2Eacc_max_message_length)
+    {
+        msg(M_CLIENT, "he=
ader (%zu) + message size (%zu) length (%zu) exceeds "
+                   =
   "maximum allowed length negotiated with peer (%d)",
+            max_hea=
der_size, strlen(msg), len,
+            c->options=2Eacc_max_message_lengt=
h);
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+=
    /* add 1 for the final \0 */
+    struct buffer buf =3D alloc_buf_gc(le=
n + 1, &gc);
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */=

+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+               strl=
en(msg),
+               base64 ? "6" : "A",
+               fragment ? "F"=
 : "",
+               msg);
+
+    send_control_channel_string_dowork(sess=
ion, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
+    gc_free(&g=
c);
+    return true;
+}
+
+char *
+parse_acc_parameters(const char *capabi=
lities,
+                     const char *delim,
+                     int =
*max_acc_len,
+                     bool server,
+                     stru=
ct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc(capabilities, N=
ULL);
+    char *tmp_message_orig =3D tmp_message;
+    char *lasts =3D NUL=
L;
+
+    const char *token =3D strtok_r(tmp_message, delim, &lasts);
+
+  =
  int p =3D 0;
+    int acclen =3D 0;
+    const char *protocols =3D NULL;
=
+    char *ret =3D NULL;
+
+    /* In server mode we allow more capabilitie=
s than our own, in client
+     * mode we reject if we should use capabilit=
ies that we do not support */
+    int allowed_acc_len =3D server ? INT_MAX=
 : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if (p =3D=3D 0 && =
!atoi_constrained(token, &acclen, "ACC message length", ACC_MIN_MSG_LEN, al=
lowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto done;
+        =
}
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A", token) || !tl=
s_item_in_cipher_list("6", token)))
+        {
+            msg(D_PUSH_ERRO=
RS, "App custom control encoding must include base64 and ascii");
+        =
    goto done;
+        }
+
+        if (p =3D=3D 1 && !server && strcmp(to=
ken, "A:6") && strcmp(token, "6:A"))
+        {
+            msg(D_PUSH_ERR=
ORS, "App custom control encoding must exactly base64 and ascii");
+       =
     goto done;
+        }
+
+        if (p =3D=3D 2)
+        {
+         =
   protocols =3D token;
+        }
+
+        if (p =3D=3D 3)
+        {
+ =
           msg(D_PUSH_ERRORS, "Too many parameters for INFO ACC message/IV_=
ACC=2E");
+            goto done;
+        }
+
+        token =3D strtok_r(=
NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc_len =3D min_int(=
acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(protocols, gc);
+
+done=
:
+    free(tmp_message_orig);
+    return ret;
+}
+
+
+void
+determine_com=
mon_acc_protocols(struct multi_instance *mi)
+{
+    struct context *c =3D =
&mi->context;
+    if (!c->options=2Eacc_protocols)
+    {
+        /* No a=
pp custom protocols have been configured server-side=2E */
+        return;=

+    }
+
+    if (c->options=2Eacc_negotiated_protocols)
+    {
+        /=
* We already have determined the common protocols=2E Doing this
+         *=
 again would just add an extra string allocation to options->gc */
+       =
 return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    /* example I=
V_ACC: IV_ACC=3D2048,6:A,flower:power */
+    const char *peer_info =3D c->=
c2=2Etls_multi->peer_info;
+    char *iv_acc =3D extract_var_peer_info(peer=
_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);
+=
        return;
+    }
+
+    int max_acc_len =3D 0;
+    char *protocols =
=3D parse_acc_parameters(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if (=
!protocols)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARN=
ING: IV_ACC peer info variable of peer is malformed");
+        return;
+  =
  }
+
+    char *lasts =3D NULL;
+    const char *token =3D strtok_r(protoc=
ols, ":", &lasts);
+
+    struct buffer common_protocols =3D alloc_buf_gc(1=
024, &gc);
+
+    while (token)
+    {
+        if (tls_item_in_cipher_list=
(token, c->options=2Eacc_protocols))
+        {
+            /* protocol is=
 in both server and client list */
+            if (buf_len(&common_protoco=
ls) > 0)
+            {
+                buf_write_u8(&common_protocols, ':=
');
+            }
+            buf_printf(&common_protocols, "%s", token);=

+        }
+        token =3D strtok_r(NULL, ":", &lasts);
+    }
+
+    i=
f (buf_len(&common_protocols) =3D=3D 0)
+    {
+        gc_free(&gc);
+    =
    msg(D_PUSH_DEBUG, "WARNING: No common app custom control protocol=2E");=

+        return;
+    }
+
+    c->options=2Eacc_negotiated_protocols =3D s=
tring_alloc(buf_str(&common_protocols), &c->options=2Egc);
+    c->options=
=2Eacc_max_message_length =3D max_acc_len;
+#ifdef ENABLE_MANAGEMENT
+    m=
sg(M_CLIENT, ">CLIENT:ACC_PROTOCOLS,%lu,protocols=3D%s,message_len=3D%d",
+=
        mi->context=2Ec2=2Emda_context=2Ecid, c->options=2Eacc_negotiated_p=
rotocols,
+        max_acc_len);
+#endif
+    gc_free(&gc);
+}
\ No newline=
 at end of file
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new =
file mode 100644
index 0000000=2E=2Ea6112cd
--- /dev/null
+++ b/src/openvpn=
/acc=2Eh
@@ -0,0 +1,92 @@
+/*
+ *  OpenVPN -- An application to securely tu=
nnel IP networks
+ *             over a single TCP/UDP port, with support f=
or SSL/TLS-based
+ *             session authentication and key exchange,
+=
 *             packet encryption, packet authentication, and
+ *           =
  packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@open=
vpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ =
*
+ *  This program is free software; you can redistribute it and/or modify=

+ *  it under the terms of the GNU General Public License version 2
+ *  a=
s published by the Free Software Foundation=2E
+ *
+ *  This program is dis=
tributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more de=
tails=2E
+ *
+ *  You should have received a copy of the GNU General Public=
 License along
+ *  with this program; if not, write to the Free Software F=
oundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E
+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+=

+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This =
method parses an app custom control message and delivers it to the
+ * mana=
gement interface=2E We leave reassembly of fragmented messages to the
+ * m=
anagement interface=2E
+ *
+ * @param c            The context struct
+ * @=
param buffer       Buffer containing the control message with ACC
+ */
+voi=
d
+receive_acc_message(struct context *c, const struct buffer *buffer);
+
+=

+bool
+send_acc_message(struct context *c,
+                 struct tls_mu=
lti *tls_multi,
+                 struct tls_session *session,
+           =
      const char *protocol, bool fragment,
+                 const char *ms=
g, bool base64);
+
+
+/**
+ * Parses an info message from the server that c=
ontains app custom control info
+ * information prior to the PUSH_REPLY to =
be able to use app custom control
+ * protocols before sending
+ *
+ * In c=
lient mode only allow what we support ourselves=2E In server mode
+ * allow=
 also capabilities that we not support ourselves=2E
+ *
+ * @param capabili=
ties      The string to parse
+ * @param delim             The delimiter to=
 use when parsing the string=2E
+ *                          IV_ACC uses ",=
" as delimiter while the
+ *                          custom-control PUSH m=
essage uses " " as "," is
+ *                          already used to sepa=
rate different push directives
+ * @param max_acc_len       Set to the maxi=
mum ACC message length
+ * @param server            Whether we are server o=
r client
+ * @param gc                The gc arena to use for allocating th=
e resulting string
+ * @return                  The resulting protocol stri=
ng or NULL on error
+ */
+char *
+parse_acc_parameters(const char *capabili=
ties,
+                     const char *delim,
+                     int *m=
ax_acc_len,
+                     bool server,
+                     struct=
 gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets c->option=
s=2Eacc_negotiated_protocols
+ * to the common protocols of server and clie=
nt and
+ * c->options=2Eacc_max_message_length  to the maximum length of th=
e ACC message
+ * support by both server and client=2E
+ *
+ * If there is =
no common protocol or the client does not support any app custom
+ * protoc=
ol c->options=2Eacc_negotiated_protocols will be set to NULL=2E
+ *
+ * @pa=
ram mi     the client instance to use the set the app custom protocols=2E
+=
 */
+void
+determine_common_acc_protocols(struct multi_instance *mi);
+#end=
if
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index b97=
fb7a=2E=2Ed9e1979 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/fo=
rward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"
=
 #include "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@=
@ -257,11 +258,11 @@
     }
     else if (buf_string_match_head_str(buf, "I=
NFO_PRE"))
     {
-        server_pushed_info(buf, 8);
+        server_push=
ed_info(c, buf, 8);
     }
     else if (buf_string_match_head_str(buf, "IN=
FO"))
     {
-        server_pushed_info(buf, 4);
+        server_pushed_in=
fo(c, buf, 4);
     }
     else if (buf_string_match_head_str(buf, "CR_RESP=
ONSE"))
     {
@@ -271,6 +272,10 @@
     {
         receive_auth_pending(c,=
 buf);
     }
+    else if (buf_string_match_head_str(buf, "ACC"))
+    {
+=
        receive_acc_message(c, buf);
+    }
     else if (buf_string_match_=
head_str(buf, "EXIT"))
     {
         receive_exit_message(c);
diff --git =
a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index ac86f97=2E=2Eb4a8f1e 10=
0644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2277,6 +2277=
,10 @@
             buf_printf(&out, " aead-epoch");
         }
     }
+   =
 if (c->options=2Eacc_negotiated_protocols)
+    {
+        buf_printf(&out=
, " custom-control %d,A:6,%s", c->options=2Eacc_max_message_length, c->opti=
ons=2Eacc_negotiated_protocols);
+    }
 
     if (BLENZ(&out) > strlen(hea=
der))
     {
@@ -2521,6 +2525,11 @@
         flags |=3D (OPT_P_ROUTE | OPT_=
P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+    {
+        f=
lags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -2729,6 +2738,19 @=
@
         frame->tun_mtu =3D min_int(frame->tun_max_mtu, c->options=2Ece=
=2Etun_mtu);
     }
 
+    if (found & OPT_P_NCP)
+    {
+        msg(D_PUS=
H, "OPTIONS IMPORT: ACC protocols: %s, msg len: %d",
+            c->option=
s=2Eacc_negotiated_protocols, c->options=2Eacc_max_message_length);
+#ifdef=
 ENABLE_MANAGEMENT
+        if (management)
+        {
+            msg(M_C=
LIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d",
+                c=
->options=2Eacc_negotiated_protocols, c->options=2Eacc_max_message_length);=

+        }
+#endif
+    }
+
     return true;
 }
 
@@ -3350,6 +3372,7 @@
 =
    to=2Everify_hash_depth =3D options->verify_hash_depth;
     to=2Everify=
_hash_no_ca =3D options->verify_hash_no_ca;
     memcpy(to=2Ex509_username_=
field, options->x509_username_field, sizeof(to=2Ex509_username_field));
+  =
  to=2Eacc_protocols =3D options->acc_protocols;
     to=2Ees =3D c->c2=2Ee=
s;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4304,6 +4327,25 @@
 }
 #endif /=
* ifdef TARGET_ANDROID */
 
+static bool
+management_acc_msg(void *arg,
+  =
                 struct buffer_list *input) /* ownership transferred */
+{
=
+    struct context *c =3D arg;
+
+    bool ret =3D false;
+    if (buffer_=
list_defined(input) && c->c2=2Etls_multi)
+    {
+        struct tls_multi =
*multi =3D c->c2=2Etls_multi;
+        struct tls_session *session =3D &mul=
ti->session[TM_ACTIVE];
+        struct options *opt =3D &c->options;
+
+  =
      ret =3D management_send_acc_message(c, multi, session, opt->acc_negot=
iated_protocols, input);
+    }
+
+    buffer_list_free(input);
+    return=
 ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4320,6 +4362,7 @=
@
         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;
         cb=2E=
remote_cmd =3D management_callback_remote_cmd;
         cb=2Esend_cc_messag=
e =3D management_callback_send_cc_message;
+        cb=2Eacc_msg =3D manage=
ment_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_change =3D manag=
ement_callback_network_change;
 #endif
diff --git a/src/openvpn/manage=2Ec =
b/src/openvpn/manage=2Ec
index 1fa3738=2E=2Ead54999 100644
--- a/src/openvp=
n/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,9 +44,11 @@
 #include "dco=
=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#include "acc=2Eh"
 
 #in=
clude "memdbg=2Eh"
 #include "run_command=2Eh"
+#include "ssl_ncp=2Eh"
 
 #=
ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1081,6 +1083,35 @@
         =
    }
             break;
 
+        case IEC_CLIENT_ACC_MSG:
+            =
if (man->persist=2Ecallback=2Eclient_acc_msg)
+            {
+             =
   bool status =3D (*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=
=2Ecallback=2Earg,
+                                                       =
               man->connection=2Ein_extra_cid,
+                           =
                                           man->connection=2Ein_extra_kid,
=
+                                                                      man-=
>connection=2Ein_extra);
+                man->connection=2Ein_extra =3D NU=
LL;
+                report_command_status(status, "client-acc-msg");
+    =
        }
+            else
+            {
+                man_command_uns=
upported("client-acc-msg");
+            }
+            break;
+
+        c=
ase IEC_ACC_MSG:
+            if (man->persist=2Ecallback=2Eacc_msg)
+     =
       {
+                bool status =3D (*man->persist=2Ecallback=2Eacc_m=
sg)(man->persist=2Ecallback=2Earg,
+                                       =
                        man->connection=2Ein_extra);
+                man->=
connection=2Ein_extra =3D NULL;
+                report_command_status(stat=
us, "acc-msg");
+            }
+            else
+            {
+          =
      man_command_unsupported("acc-msg");
+            }
+            break=
;
         case IEC_PK_SIGN:
             man->connection=2Eext_key_state =
=3D EKS_READY;
             buffer_list_free(man->connection=2Eext_key_inpu=
t);
@@ -1205,6 +1236,29 @@
 }
 
 static void
+man_client_acc_msg(struct man=
agement *man, const char *cid_str,
+                   const char *kid_str)=

+{
+    struct man_connection *mc =3D &man->connection;
+    mc->in_extra_=
cid =3D 0;
+    mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in=
_extra_cid)
+        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+   =
 {
+        mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_rese=
t(mc, IER_NEW);
+    }
+}
+
+static void
+man_acc_msg(struct management *ma=
n)
+{
+    struct man_connection *mc =3D &man->connection;
+    mc->in_extr=
a_cmd =3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
=
 man_client_auth(struct management *man, const char *cid_str, const char *k=
id_str, const bool extra)
 {
     struct man_connection *mc =3D &man->conne=
ction;
@@ -1759,6 +1813,17 @@
             man_client_pending_auth(man, p[1=
], p[2], p[3], p[4]);
         }
     }
+    else if (streq(p[0], "client-a=
cc-msg"))
+    {
+        if (man_need(p, 2, 0))
+        {
+            ma=
n_client_acc_msg(man, p[1], p[2]);
+        }
+    }
+    else if (streq(p[=
0], "acc-msg"))
+    {
+        man_acc_msg(man);
+    }
     else if (stre=
q(p[0], "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -3132,6 =
+3197,7 @@
     }
 }
 
+
 void
 management_connection_established(struct ma=
nagement *man, struct man_def_auth_context *mdac,
                         =
          const struct env_set *es)
@@ -4372,6 +4438,62 @@
     }
 }
 
+boo=
l
+management_send_acc_message(struct context *c, struct tls_multi *multi, =
struct tls_session *session,
+                            const char *negot=
iated_protocols, struct buffer_list *input)
+{
+    /* also ensures that ar=
e enough inputs in the list to safely call
+     * buffer_list_peek without=
 extra NULL checks */
+    if (!input || input->size < 3)
+    {
+        m=
sg(M_CLIENT, "not enough input lines for sending acc message, "
+          =
            "missing protocol, flag and/or messages lines");
+        retur=
n false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    const struct=
 buffer *proto_buf =3D buffer_list_peek(input);
+    const char *protocol =
=3D string_alloc(CBSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+  =
  struct buffer *encoding_buf =3D buffer_list_peek(input);
+    char *encod=
ing =3D buf_str(encoding_buf);
+    const char *flag =3D NULL;
+    bool b6=
4encoding =3D false;
+    bool fragment =3D false;
+
+    while ((flag =3D =
strsep(&encoding, ":")))
+    {
+        if (!strcmp(flag, "6"))
+        {=

+            b64encoding =3D true;
+        }
+        else if (!strcmp(fl=
ag, "F"))
+        {
+            fragment =3D true;
+        }
+    }
+   =
 buffer_list_pop(input);
+
+    buffer_list_aggregate_separator(input, 1000=
0, "");
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);
=
+
+    if (!negotiated_protocols || !tls_item_in_cipher_list(protocol, nego=
tiated_protocols))
+    {
+        msg(M_CLIENT, "protocol not in the list =
of negotiated protocols: %s", np(negotiated_protocols));
+        goto erro=
r;
+    }
+
+    bool ret =3D send_acc_message(c, multi, session, protocol,=

+                                fragment, buf_cstr(acc_msg_buf),
+       =
                         b64encoding);
+    gc_free(&gc);
+    return ret;
=
+error:
+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef ENABLE_MAN=
AGEMENT */
 
 #include "win32=2Eh"
diff --git a/src/openvpn/manage=2Eh b/sr=
c/openvpn/manage=2Eh
index 31577e4=2E=2E4eebf75 100644
--- a/src/openvpn/ma=
nage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (*n_cl=
ients)(void *arg);
     bool (*send_cc_message)(void *arg, const char *mess=
age, const char *parameter);
     bool (*kill_by_cid)(void *arg, const unsi=
gned long cid, const char *kill_msg);
+
     bool (*client_auth)(void *arg,=
 const unsigned long cid, const unsigned int mda_key_id,
                  =
       const bool auth, const char *reason, const char *client_reason,
    =
                     struct buffer_list *cc_config); /* ownership transferr=
ed */
     bool (*client_pending_auth)(void *arg, const unsigned long cid, =
const unsigned int kid,
                                 const char *extra,=
 unsigned int timeout);
     char *(*get_peer_info)(void *arg, const unsign=
ed long cid);
+    bool (*client_acc_msg)(void *arg,
+                     =
      const unsigned long cid,
+                           const unsigned i=
nt mda_key_id,
+                           struct buffer_list *msg);
+    b=
ool (*acc_msg)(void *arg,
+                    struct buffer_list *msg);
  =
   bool (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cmd)(vo=
id *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
    =
 struct command_line *in;
     struct buffer_list *out;
 
-#define IEC_UNDE=
F       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#define=
 IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#=
define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN   =
  5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#define IEC_C=
ERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWORD       6=

+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int in_ex=
tra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid=
;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(struct management *=
man, struct context *c);
 
+/** Parses the ACC message from the input buffe=
r_list and send to the
+ * session identified by session and multi
+ */
+st=
ruct tls_session;
+struct tls_multi;
+bool
+management_send_acc_message(str=
uct context *c, struct tls_multi *multi, struct tls_session *session,
+    =
                        const char *negotiated_protocols, struct buffer_lis=
t *input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/op=
envpn/multi=2Ec b/src/openvpn/multi=2Ec
index dda9232=2E=2E26bb205 100644
-=
-- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #=
include "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+=
#include "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1735,8 +1736=
,9 @@
  * - peer id
  */
 static bool
-multi_client_set_protocol_options(st=
ruct context *c)
+multi_client_set_protocol_options(struct multi_instance *=
mi)
 {
+    struct context *c =3D &mi->context;
     struct tls_multi *tls_=
multi =3D c->c2=2Etls_multi;
     const char *const peer_info =3D tls_multi=
->peer_info;
     struct options *o =3D &c->options;
@@ -1795,6 +1797,13 @@=

         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }
 
+=
    if (o->acc_protocols)
+    {
+        /* If ACC is enabled server side =
call to find common acc protocols,
+         * will be pushed during push m=
essage */
+        determine_common_acc_protocols(mi);
+    }
+
     /* Sel=
ect cipher if client supports Negotiable Crypto Parameters */
 
     /* if =
we have already created our key, we cannot *change* our own
@@ -2380,7 +238=
9,7 @@
      * peer must be added before iroutes=2E For other platforms it =
doesn't matter=2E */
 
     /* authentication complete, calculate dynamic c=
lient specific options */
-    if (!multi_client_set_protocol_options(&mi->=
context))
+    if (!multi_client_set_protocol_options(mi))
     {
         =
mi->context=2Ec2=2Etls_multi->multi_state =3D CAS_FAILED;
     }
@@ -4084,6=
 +4093,26 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(=
struct multi_instance *mi, struct gc_arena *gc)
+{
+    struct context *c =
=3D &mi->context;
+    determine_common_acc_protocols(mi);
+
+    if (!c->o=
ptions=2Eacc_negotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No n=
egotiated protocols");
+        return NULL;
+    }
+
+    struct buffer bu=
f =3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", c->o=
ptions=2Eacc_max_message_length,
+               c->options=2Eacc_negotiate=
d_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 management_cl=
ient_pending_auth(void *arg, const unsigned long cid, const unsigned int md=
a_key_id,
                                const char *extra, unsigned int t=
imeout)
@@ -4094,10 +4123,22 @@
     if (mi)
     {
         struct tls_mul=
ti *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =
=3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+            e=
xtra =3D calculate_app_control_extra(mi, &gc);
+            if (!extra)
+  =
          {
+                gc_free(&gc);
+                return false;
+=
            }
+        }
         struct tls_session *session =3D lookup_se=
ssion_by_mda_key_id(multi, mda_key_id);
 
         if (!session)
         {=

+            gc_free(&gc);
             return false;
         }
 
@@ -410=
5,6 +4146,7 @@
         bool ret =3D send_auth_pending_messages(multi, sess=
ion, extra, timeout);
         reschedule_multi_process(&mi->context);
    =
     multi_schedule_context_wakeup(m, mi);
+        gc_free(&gc);
         =
return ret;
     }
     return false;
@@ -4148,6 +4190,39 @@
     return re=
t;
 }
 
+
+static bool
+management_client_acc_msg(void *arg,
+             =
             const unsigned long cid,
+                          const unsi=
gned int mda_key_id,
+                          struct buffer_list *input) =
/* ownership transferred */
+{
+    struct multi_context *m =3D (struct mul=
ti_context *)arg;
+    struct multi_instance *mi =3D lookup_by_cid(m, cid);=

+
+    bool ret =3D false;
+    if (mi && buffer_list_defined(input))
+   =
 {
+        struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+    =
    struct tls_session *session =3D lookup_session_by_mda_key_id(multi, mda=
_key_id);
+        if (!session)
+        {
+            msg(M_CLIENT, "cli=
ent session not found");
+            buffer_list_free(input);
+           =
 return false;
+        }
+
+        struct options *opt =3D &mi->context=
=2Eoptions;
+
+        ret =3D management_send_acc_message(&mi->context, mu=
lti, session, opt->acc_negotiated_protocols, input);
+        multi_schedul=
e_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(input);
+    return=
 ret;
+}
+
+
 static char *
 management_get_peer_info(void *arg, const unsi=
gned long cid)
 {
@@ -4184,6 +4259,7 @@
         cb=2En_clients =3D managem=
ent_callback_n_clients;
         cb=2Ekill_by_cid =3D management_kill_by_ci=
d;
         cb=2Eclient_auth =3D management_client_auth;
+        cb=2Eclie=
nt_acc_msg =3D management_client_acc_msg;
         cb=2Eclient_pending_auth=
 =3D management_client_pending_auth;
         cb=2Eget_peer_info =3D manage=
ment_get_peer_info;
         cb=2Epush_update_broadcast =3D management_call=
back_send_push_update_broadcast;
diff --git a/src/openvpn/options=2Ec b/src=
/openvpn/options=2Ec
index d839b59=2E=2E2589942 100644
--- a/src/openvpn/op=
tions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #include "sysh=
ead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include "error=2Eh"=

 #include "common=2Eh"
@@ -7133,6 +7134,28 @@
         VERIFY_PERMISSION(O=
PT_P_GENERAL);
         options->force_key_material_export =3D true;
     }=

+    else if (streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {
+=
        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->acc_protocols =
=3D p[1];
+    }
+    else if (streq(p[0], "custom-control") && p[1] && p[2=
] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC);
+
+      =
  if (!streq(p[2], "A:6") && !streq(p[2], "6:A"))
+        {
+            m=
sg(msglevel, "App custom control encoding must be base64 and ascii");
+    =
        goto err;
+        }
+
+        if (!atoi_constrained(p[1], &option=
s->acc_max_message_length,
+                              "app custom messa=
ge message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        {=

+            goto err;
+        }
+        options->acc_negotiated_protoco=
ls =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3])
   =
  {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG i=
s used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
i=
ndex 4cd9ef5=2E=2Ef603eb0 100644
--- a/src/openvpn/options=2Eh
+++ b/src/op=
envpn/options=2Eh
@@ -712,6 +712,16 @@
     /* force using TLS key material=
 export for data channel key generation */
     bool force_key_material_exp=
ort;
 
+    /** The app custom control protocols we should announce as supp=
orted */
+    const char *acc_protocols;
+
+    /** the protocols that are =
negotiated with the peer=2E As a client we
+     * trust the server pushed =
list here */
+    const char *acc_negotiated_protocols;
+
+    /** the maxi=
mum length of an ACC control channel message */
+    int acc_max_message_le=
ngth;
+
     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_accep=
t;
     uint16_t vlan_pvid;
@@ -763,8 +773,10 @@
 #define OPT_P_INLINE     =
     (1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_RO=
UTE_TABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
-#de=
fine OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x=
0ull))
+/* Options allowed in the normal configuration file (vs pushed opti=
ons or in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PU=
LL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((opt)->=
pull)
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 0e28=
1d2=2E=2E3ba2bd0 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=
=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh"
+
+#i=
nclude "acc=2Eh"
 #include "options=2Eh"
 #include "crypto=2Eh"
 #include "=
ssl=2Eh"
@@ -220,9 +222,37 @@
 #endif
 }
 
+static void
+parse_server_pushe=
d_info_acc(struct context *c, struct buffer *buf)
+{
+    int max_acc_len =
=3D 0;
+
+
+    /* example string to parse: ACC:1400 A:6 flower:happy */
+ =
   /* Skip over the ACC: prefix */
+    buf_advance(buf, 4);
+
+    char *p=
rotocols =3D parse_acc_parameters(buf_cstr(buf), " ", &max_acc_len, false, =
&c->options=2Egc);
+    if (protocols)
+    {
+        c->options=2Eacc_neg=
otiated_protocols =3D protocols;
+        c->options=2Eacc_max_message_leng=
th =3D max_acc_len;
+
+#ifdef ENABLE_MANAGEMENT
+        if (management)
+ =
       {
+            msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_=
len=3D%d", protocols, max_acc_len);
+        }
+#endif
+    }
+    else
+  =
  {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC info command with in=
valid parameters");
+    }
+}
 
 void
-server_pushed_info(const struct buff=
er *buffer, const int adv)
+server_pushed_info(struct context *c, const str=
uct buffer *buffer, const int adv)
 {
     const char *m =3D "";
     struc=
t buffer buf =3D *buffer;
@@ -232,6 +262,12 @@
         m =3D BSTR(&buf);
 =
    }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        parse_serv=
er_pushed_info_acc(c, &buf);
+        return;
+    }
+
 #ifdef ENABLE_MANAG=
EMENT
     struct gc_arena gc;
     if (management)
@@ -284,6 +320,7 @@
   =
  msg(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
+
 /**
  * =
Parse the keyword for the AUTH_PENDING request
  * @param buffer           =
     buffer containing the keywords, the buffer's
@@ -440,7 +477,6 @@
     =
const char *const peer_info =3D tls_multi->peer_info;
     unsigned int pro=
to =3D extract_iv_proto(peer_info);
 
-
     /* Calculate the maximum timeo=
ut and subtract the time we already waited */
     unsigned int max_timeout=
 =3D
         max_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi-=
>opt=2Ehandshake_window);
@@ -731,6 +767,11 @@
                 client_max_=
mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
     }
+
+    if (c->opt=
ions=2Eacc_negotiated_protocols)
+    {
+        push_option_fmt(gc, push_l=
ist, M_USAGE, "custom-control %d A:6 %s", c->options=2Eacc_max_message_leng=
th, c->options=2Eacc_negotiated_protocols);
+    }
 }
 
 #if defined(__GNUC=
__) || defined(__clang__)
diff --git a/src/openvpn/push=2Eh b/src/openvpn/p=
ush=2Eh
index dff945f=2E=2E3aca8a7 100644
--- a/src/openvpn/push=2Eh
+++ b/=
src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_incoming_push_request=
(struct context *c);
 
+
 /**
  * @brief Handles the receiving of a push-up=
date message and applies updates to the specified
  * options=2E
@@ -92,7 +=
93,7 @@
 
 void receive_exit_message(struct context *c);
 
-void server_pus=
hed_info(const struct buffer *buffer, const int adv);
+void server_pushed_i=
nfo(struct context *c, const struct buffer *buffer, const int adv);
 
 void=
 receive_cr_response(struct context *c, const struct buffer *buffer);
 
dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index aeec020=2E=2E73ca=
54c 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55=
,7 @@
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh=
"
 #include "ssl_verify=2Eh"
 #include "ssl_backend=2Eh"
 #include "ssl_ncp=
=2Eh"
@@ -2105,6 +2106,11 @@
                     }
                 }
    =
         }
+
+            if (session->opt->acc_protocols)
+            {
+=
                buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, s=
ession->opt->acc_protocols);
+            }
         }
     }
 
diff --git =
a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 6b86bc0=2E=
=2E0270c23 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_co=
mmon=2Eh
@@ -452,6 +452,9 @@
     size_t ekm_size;
 
     bool dco_enabled;=
 /**< Whether keys have to be installed in DCO or not */
+
+    /** The app=
 custom control protocols we should announce as supported */
+    const cha=
r *acc_protocols;
 };
 
 /** @addtogroup control_processor
diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m
index 5430ecb=2E=2Ec66036a 100644
--- a/tests/unit_tests/openvpn/Makefile=
=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -103,9 +103,11 @@
 	@=
TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_=
LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
+	test_acc=2Ec test_acc=2E=
h \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_management=2Ec \
 =
	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
+	$(top_srcdir)/src/open=
vpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/op=
envpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -127,6 +129,=
7 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/open=
vpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+	$(top=
_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec=
 \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdir)/src=
/openvpn/ssl_verify_openssl=2Ec \
@@ -375,8 +378,10 @@
 
 misc_testdriver_S=
OURCES =3D test_misc=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
+	mock_m=
anagement=2Ec mock_management=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	moc=
k_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)=
/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	=
$(top_srcdir)/src/openvpn/ssl_util=2Ec \
@@ -389,6 +394,7 @@
 	$(top_srcdir=
)/src/openvpn/siphash_reference=2Ec \
 	$(top_srcdir)/src/openvpn/session_i=
d=2Ec
 
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvp=
n \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openv=
pn \
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit=
_tests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2E5ae5dea 100644
--- a/=
tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn=
/mock_management=2Ec
@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 
+#includ=
e <stdlib=2Eh>
 #include "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
diff --gi=
t a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/unit_tests/openvpn=
/mock_management=2Eh
new file mode 100644
index 0000000=2E=2E80dcfc2
--- /d=
ev/null
+++ b/tests/unit_tests/openvpn/mock_management=2Eh
@@ -0,0 +1,29 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single UDP port, with support for SSL/TLS-based
+ *         =
    session authentication and key exchange,
+ *             packet encrypt=
ion, packet authentication, and
+ *             packet compression=2E
+ *
+=
 *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This=
 program is free software; you can redistribute it and/or modify
+ *  it un=
der the terms of the GNU General Public License version 2
+ *  as published=
 by the Free Software Foundation=2E
+ *
+ *  This program is distributed in=
 the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ =
*
+ *  You should have received a copy of the GNU General Public License al=
ong
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifndef MOCK_MANAGEMENT_H
+#define MOCK_MANAGEMENT_H
+void init=
_mock_management(void);
+
+void uninit_mock_management(void);
+
+#endif
dif=
f --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_=
tests/openvpn/mock_push_dependencies=2Ec
index 112bcfd=2E=2Ec16d0cb 100644
=
--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_=
tests/openvpn/mock_push_dependencies=2Ec
@@ -43,7 +43,8 @@
     uint64_t fl=
ags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
   =
                   | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP=
 | OPT_P_PERSIST
                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NO=
TIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                     | OPT_P_PEER_ID |=
 OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+               =
      | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DH=
CPDNS
+                     | OPT_P_ACC;
     return flags;
 }
 
diff --git=
 a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_ac=
c=2Ec
new file mode 100644
index 0000000=2E=2E42a79c6
--- /dev/null
+++ b/t=
ests/unit_tests/openvpn/test_acc=2Ec
@@ -0,0 +1,301 @@
+/*
+ *  OpenVPN -- =
An application to securely tunnel IP networks
+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwab=
e <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can =
redistribute it and/or modify
+ *  it under the terms of the GNU General Pu=
blic License version 2
+ *  as published by the Free Software Foundation=2E=

+ *
+ *  This program is distributed in the hope that it will be useful,
+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Gener=
al Public License for more details=2E
+ *
+ *  You should have received a c=
opy of the GNU General Public License along
+ *  with this program; if not,=
 write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fi=
fth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#incl=
ude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
=
+#include <stdlib=2Eh>
+#include <stdarg=2Eh>
+#include <string=2Eh>
+#incl=
ude <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "acc=2Eh"
+#include "te=
st_acc=2Eh"
+#include "test_common=2Eh"
+
+#include "mock_msg=2Eh"
+#includ=
e "multi=2Eh"
+
+char control_channel_mesage_sent[2048];
+
+/* Mock functio=
ns */
+bool
+send_control_channel_string_dowork(struct tls_session *session=
,
+                                   const char *str, unsigned int msgleve=
l)
+{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    memcpy(control=
_channel_mesage_sent, str, strlen(str));
+    return true;
+}
+
+void
+send=
_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_cli=
ent_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#define MS=
G_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+     =
               "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+=
                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP=
" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAW=
ABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuB=
AMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAw=
EDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz=
2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D"
+
=
+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENABLE_MANA=
GEMENT
+    skip();
+#else
+    /* ensure that the messages get to mock_msg=
 */
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678;
+    =
struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientHello=
 */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    struct =
buffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=2Emode =
=3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_m=
ulti, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=
=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->mda_c=
ontext =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void *)msg, =
sizeof(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_=
equal(mock_msg_buf, "Received custom app control message (protocol 'cck1')"=
);
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," M=
SG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIE=
tlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (v=
oid *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_bu=
f);
+    assert_string_equal(mock_msg_buf, "Received custom app control mes=
sage (protocol 'flower')");
+    assert_string_equal(mock_managment_buf, ">=
CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=
=3D");
+
+    CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[=
] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2V=
ybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, =
sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+    co=
nst char *error =3D "WARNING: Received malformed custom app control channel=
 "
+                        "(field length 62, payload length 64 mismatch) =
message "
+                        "control message: 496e7367 496d316c 496a=
6f67 496d5a79 "
+                        "62326369 4c434141 65475a6d 2f534a=
7[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+    as=
sert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment_buf)=
;
+    const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+ =
   buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));
+   =
 receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, =
"Received custom app control message (protocol 'power', fragment)");
+    a=
ssert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=
=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding pres=
ent */
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAA=
IEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, =
(void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive_acc=
_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custo=
m app control channel (number of "
+            "encodings must be exactly =
one (B64=3D1, ASCII=3D1)) message control "
+            "message: 53534268=
 62534141 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 3737=
2b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    as=
sert_string_equal(mock_managment_buf, "");
+
+    /* no encoding present */=

+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlcm1pd=
CD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)f=
lower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_message(&c=
, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom app contr=
ol channel (number of "
+            "encodings must be exactly one (B64=3D=
0, ASCII=3D0)) message control "
+            "message: 53534268 62534141 4=
945746c 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[more=2E=
=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_string=
_equal(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    management=
 =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_parameters=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* parameters =
to INFO message */
+    const char *info_acc_msg =3D "4096 A:6 flower:happy=
";
+
+    int max_len =3D 0;
+    const char *protocols =3D parse_acc_param=
eters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(pro=
tocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a =
client does not accept a length longer than it supports */
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    ass=
ert_null(protocols);
+
+    /* message with lower limit than our, should wo=
rk for client and server */
+    info_acc_msg =3D "1111 A:6 flower:happy";
=
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false,=
 &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int=
_equal(max_len, 1111);
+
+    protocols =3D parse_acc_parameters(info_acc_m=
sg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:=
happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more encodings tha=
n supported=2E Server should be okay, client should fail */
+    info_acc_m=
sg =3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc_parameters(i=
nfo_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+  =
  protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc=
);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equ=
al(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg =3D "1400=
 A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg=
, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    ass=
ert_null(protocols);
+
+
+    const char *iv_acc_capabilities =3D "1400,A:6=
,flower:happy:power";
+    protocols =3D parse_acc_parameters(iv_acc_capabi=
lities, ",", &max_len, true, &gc);
+    assert_string_equal(protocols, "flo=
wer:happy:power");
+
+    /* too small protocol length */
+    info_acc_msg=
 =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_ac=
c_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* no=
n-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flower:happy=
 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &max_len, =
true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical protocol l=
ength */
+    info_acc_msg =3D "abff A:6 flower:happy 77";
+    protocols =
=3D parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+    asse=
rt_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protoc=
ols(void **state)
+{
+    struct multi_instance mi =3D { 0 };
+    struct c=
ontext *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLO=
C_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+
+ =
   c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flo=
wer:happy:power";
+    c->options=2Eacc_protocols =3D "power:flower:star";
=
+
+    determine_common_acc_protocols(&mi);
+
+    assert_int_equal(c->opti=
ons=2Eacc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(c-=
>options=2Eacc_negotiated_protocols, "flower:power");
+
+    gc_free(&c->op=
tions=2Egc);
+}
+
+void
+test_acc_send_message(void **state)
+{
+    struct=
 multi_instance mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+  =
  c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi=
, struct tls_multi, &c->options=2Egc);
+    bool ret;
+
+    c->c2=2Etls_mu=
lti->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:pow=
er";
+    c->options=2Eacc_protocols =3D "power:flower:emergency";
+    det=
ermine_common_acc_protocols(&mi);
+
+
+    struct tls_session *session =3D =
&c->c2=2Etls_multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_message(c, =
c->c2=2Etls_multi, session, "emergency", true,
+                           =
"EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    assert=
_true(ret);
+    assert_string_equal(control_channel_mesage_sent,
+        =
                "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS =
NOT A DRILL:");
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, sessi=
on, "emergency", false,
+                           "THE GOVERNMENT HAS ISS=
UED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_true(re=
t);
+    assert_string_equal(control_channel_mesage_sent,
+                =
        "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED AL=
ERT FOR YOUR AREA=2E");
+
+
+    /* test a long message (> 1000) with fragm=
ent to get the maximum header size */
+    char long_message[1200] =3D { 0 =
};
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+        long_message[i] =
=3D (char)(' ' + (i % 95));
+    }
+
+    /* last char of the message is a =
i and then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    ass=
ert_int_equal(long_message[1024], '\0');
+
+    ret =3D send_acc_message(c,=
 c->c2=2Etls_multi, session, "emergency", true,
+                          =
 long_message, false);
+
+    assert_true(ret);
+    size_t cc_len =3D strl=
en(control_channel_mesage_sent);
+    assert_int_equal(control_channel_mesa=
ge_sent[cc_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC,emer=
gency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_=
channel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));
+
+    =
gc_free(&c->options=2Egc);
+}
\ No newline at end of file
diff --git a/test=
s/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
n=
ew file mode 100644
index 0000000=2E=2Ec9ca758
--- /dev/null
+++ b/tests/un=
it_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,33 @@
+/*
+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks
+ *             over a single UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 O=
penVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; yo=
u can redistribute it and/or modify
+ *  it under the terms of the GNU Gene=
ral Public License version 2
+ *  as published by the Free Software Foundat=
ion=2E
+ *
+ *  This program is distributed in the hope that it will be use=
ful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU=
 General Public License for more details=2E
+ *
+ *  You should have receiv=
ed a copy of the GNU General Public License along
+ *  with this program; i=
f not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+
+#ifndef TEST_AC=
C_H
+#define TEST_ACC_H
+void test_acc_parse_client_messages(void **state);=

+
+void test_parse_acc_parameters(void **state);
+
+void test_acc_common_p=
rotocols(void **state);
+
+void test_acc_send_message(void **state);
+#endi=
f
diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/=
openvpn/test_common=2Eh
index 8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_=
tests/openvpn/test_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2E=
h
@@ -43,11 +43,13 @@
 #define LargestIntegralType uintmax_t
 #endif
 /* re=
define 2=2Ex API in terms of 1=2Ex API */
-#define CMockaValueData         =
    LargestIntegralType
-#define check_expected_uint         check_expected=

-#define expect_uint_value           expect_value
-#define expect_check_da=
ta           expect_check
-#define cast_ptr_to_cmocka_value(x) (x)
+#define=
 CMockaValueData                       LargestIntegralType
+#define check_e=
xpected_uint                   check_expected
+#define expect_uint_value   =
                  expect_value
+#define expect_check_data                  =
   expect_check
+#define cast_ptr_to_cmocka_value(x)           (x)
+#define=
 assert_int_in_range(value, min, max)  assert_in_range((value), (min), (max=
))
+#define assert_uint_in_range(value, min, max) assert_in_range((value), =
(min), (max))
 #endif
 
 /**
diff --git a/tests/unit_tests/openvpn/test_mis=
c=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 8d88943=2E=2Eeba4e27 1=
00644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec
@@ -41,10 +41,34 @@
 #include "mock_msg=2Eh"
 #include=
 "crypto=2Eh"
 #include "sid_hash=2Eh"
+#include "test_schedule=2Eh"
+#incl=
ude "multi=2Eh"
+
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
-#inclu=
de "test_schedule=2Eh"
+
+/* extra mocks */
+bool
+apply_push_options(struc=
t context *c, struct options *options, struct buffer *buf,
+               =
    uint64_t permission_mask, uint64_t *option_types_found,
+              =
     struct env_set *es, bool is_update)
+{
+    return true;
+}
+
+bool
+s=
end_control_channel_string(struct context *c, const char *str, msglvl_t msg=
level)
+{
+    check_expected_ptr(str);
+    return true;
+}
+
+struct mult=
i_instance *
+lookup_by_cid(struct multi_context *m, const unsigned long ci=
d)
+{
+    return *(m->instances);
+}
 
 static void
 test_compat_lzo_strin=
g(void **state)
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/=
unit_tests/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2Ef4841cd 100644
--- a/tes=
ts/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=
=2Ec
@@ -52,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 =

+#include "test_acc=2Eh"
+
 /* Mock function to be allowed to include win3=
2=2Ec which is required for
  * getting the temp directory */
 #ifdef _WIN3=
2
@@ -86,6 +88,20 @@
 {
     return;
 }
+void
+reschedule_multi_process(str=
uct context *c)
+{
+}
+
+/* Define a dummy dco cipher option to avoid linki=
ng against all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
=
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AE=
S-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
=
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyo=
ut - \
@@ -1111,8 +1127,11 @@
         cmocka_unit_test(ssl_test_extract_la=
st_matching_field),
         cmocka_unit_test(ssl_test_reject_null_in_cert_=
subject),
         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subje=
ct),
-        cmocka_unit_test(ssl_test_extract_peer_info)
-
+        cmock=
a_unit_test(ssl_test_extract_peer_info),
+        cmocka_unit_test(test_acc=
_parse_client_messages),
+        cmocka_unit_test(test_parse_acc_parameter=
s),
+        cmocka_unit_test(test_acc_common_protocols),
+        cmocka_u=
nit_test(test_acc_send_message)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSS=
L)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e=
15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: =
12
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--2lQ+kBKN0Ww=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #12</strong> to this ch=
ange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?us=
p=3Demail">View Change</a></p><p>The following approvals got outdated and w=
ere removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Implement =
sending/receiving app custom control protocol messages<br><br>This allows o=
penvpn GUI/front-ends and server via management<br>to use the OpenVPN contr=
ol channel to pass messages between each other<br>while OpenVPN handles the=
 marshalling/unmarshalling of these and<br>negotiate the common app custom =
control protocols=2E<br><br>This provides an easy to use secure channel tha=
t does not depend on<br>the network itself to work and can also used before=
 fully authenticating<br>the client=2E See the management-notes=2Etxt for m=
ore details how to use<br>this feature=2E An upcoming patch will also add s=
ome example python<br>script that showcase this feature=2E<br><br>Change-Id=
: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sectio=
ns/client-options=2Erst<br>M doc/man-sections/management-options=2Erst<br>M=
 doc/management-notes=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn=
/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M src/openvpn/forward=2Ec<br>M src/ope=
nvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M =
src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=
=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/openvpn/s=
sl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/unit_tests/openvpn/Makefi=
le=2Eam<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>A tests/unit_t=
ests/openvpn/mock_management=2Eh<br>M tests/unit_tests/openvpn/mock_push_de=
pendencies=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit_t=
ests/openvpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<br>=
M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test=
_ssl=2Ec<br>27 files changed, 1,407 insertions(+), 25 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/58/1858/12</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etx=
t</span><br><span>index bac4dd4=2E=2E38f2ba8 100644</span><br><span>--- a/C=
MakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -=
433,6 +433,8 @@</span><br><span>     src/compat/compat-gettimeofday=2Ec</sp=
an><br><span>     src/compat/compat-strsep=2Ec</span><br><span>     src/com=
pat/compat-strtok_r=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    src/openvpn/acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/acc=2Eh</span><br><span>     src/openvpn/argv=2Ec</=
span><br><span>     src/openvpn/argv=2Eh</span><br><span>     src/openvpn/b=
ase64=2Ec</span><br><span>@@ -569,8 +571,8 @@</span><br><span>     src/open=
vpn/ps=2Ec</span><br><span>     src/openvpn/ps=2Eh</span><br><span>     src=
/openvpn/push=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
src/openvpn/push_util=2Ec</span><br><span>     src/openvpn/push=2Eh</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/push_util=
=2Ec</span><br><span>     src/openvpn/pushlist=2Eh</span><br><span>     src=
/openvpn/reflect_filter=2Ec</span><br><span>     src/openvpn/reflect_filter=
=2Eh</span><br><span>@@ -821,7 +823,10 @@</span><br><span>             test=
s/unit_tests/openvpn/mock_management=2Ec</span><br><span>             tests=
/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>             =
tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/test_acc=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/op=
envpn/acc=2Ec</span><br><span>             src/openvpn/argv=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/auth_to=
ken=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><br><span=
>             src/openvpn/crypto_epoch=2Ec</span><br><span>             src=
/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -835,8 +840,11 @@</span><br>=
<span>             src/openvpn/options_util=2Ec</span><br><span>           =
  src/openvpn/otime=2Ec</span><br><span>             src/openvpn/packet_id=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src=
/openvpn/reliable=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            src/openvpn/session_id=2Ec</span><br><span>             src/o=
penvpn/run_command=2Ec</span><br><span>             src/openvpn/ssl_mbedtls=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src=
/openvpn/ssl_ncp=2Ec</span><br><span>             src/openvpn/ssl_openssl=
=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec</span><br><span>=
             src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -853,6 +=
861,8 @@</span><br><span>     target_sources(test_misc PRIVATE</span><br><s=
pan>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span> =
        tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_manage=
ment=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src=
/openvpn/base64=2Ec</span><br><span>         src/openvpn/options_util=2Ec</=
span><br><span>         src/openvpn/otime=2Ec</span><br><span>         src/=
openvpn/ssl_util=2Ec</span><br><span>diff --git a/doc/man-sections/client-o=
ptions=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index =
87c138a=2E=2E6500be4 100644</span><br><span>--- a/doc/man-sections/client-o=
ptions=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</s=
pan><br><span>@@ -12,6 +12,17 @@</span><br><span>   When this option is set=
, OpenVPN will not drop incoming tun packets with</span><br><span>   same d=
estination as host=2E</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+--app-custom-control protocollist</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Sets the list of supported app custom c=
ontrol protocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  These protocols are announced to the server when this option is used</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  as a client=2E If the =
option is set on a server it will negotiate the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  common protocols with the client=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  The protocollist is a : separated list of prot=
ocol identifiers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See management-no=
tes=2Etxt in the OpenVPN distribution and the OpenVPN RFC</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  draft for a description of app cust=
om control protocol support=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> --auth-token token</span><br><span>   This is =
not an option to be used directly in any configuration files,</span><br><sp=
an>   but rather push this option from a ``--client-connect`` script or a</=
span><br><span>@@ -437,6 +448,12 @@</span><br><span>         Additional aut=
hentication methods supported by the client=2E</span><br><span>         Thi=
s may be set by the client UI/GUI using ``--setenv``=2E</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`IV_ACC=3D&lt=
;max_msg_len&gt;,&lt;flags&gt;,&lt;protocols&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        If the option ``--app-custom-control``=
 is set, the client will</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        send the supported max ACC message length, the supported forma=
ts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        as (:code=
:`A:6`) and the list of configured protocols (e=2Eg=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        :code:`flower:happy:power`)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The =
following flags depend on which compression formats are compiled in</span><=
br><span>   and whether compression is allowed by options=2E See `Protocol =
options`_</span><br><span>   for more details=2E</span><br><span>diff --git=
 a/doc/man-sections/management-options=2Erst b/doc/man-sections/management-=
options=2Erst</span><br><span>index e2e0773=2E=2Ed62407d 100644</span><br><=
span>--- a/doc/man-sections/management-options=2Erst</span><br><span>+++ b/=
doc/man-sections/management-options=2Erst</span><br><span>@@ -144,3 +144,9 =
@@</span><br><span> </span><br><span> --management-up-down</span><br><span>=
   Report tunnel up/down events to management interface=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+--app-custom-control protocol-list</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  Sets the app custom control protocols =
that are supported and should be</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  negotiated=2E protocol-list is a list of allowed protocols s=
eparated by :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A cl=
ient will announced these protocols via the IV_ACC variable and the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  server will notify the cl=
ient about the common protocols=2E</span><br><span>\ No newline at end of f=
ile</span><br><span>diff --git a/doc/management-notes=2Etxt b/doc/managemen=
t-notes=2Etxt</span><br><span>index 325f8bd=2E=2E565b1b8 100644</span><br><=
span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-=
notes=2Etxt</span><br><span>@@ -798,6 +798,58 @@</span><br><span> The clien=
t should return the response to the crtext challenge</span><br><span> using=
 the cr-response command=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+app custom control</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+If the specia=
l string &quot;ACC&quot; is passed as {EXTRA} OpenVPN will determine</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+the common app custom prot=
ocols between the client and the server and instruct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the client that the server will send cont=
rol messages to the client using</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+the ACC protocol=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The se=
rver should then use acc-msg command to send app custom control messages</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+to the client to facil=
itate the pending authentication=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COM=
MAND -- client-acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+------------------------------------------</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+On an OpenVPN instance running in server =
mode this command sends an</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+app custom control message to a client=2E The format of the command =
is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID=
 -- client ID and Key ID=2E See documentation for &quot;&gt;CLIENT:&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+notification for more=
 info=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+protocol -- the ACC protocol i=
dentifier that this message should be</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            tagged with=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+flags    -- a colon separated list of the encoding and the flag if</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            the messag=
e is a fragment=2E E=2Eg=2E &quot;6:F&quot; for a base64 encoded</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            message that is al=
so a fragment and not complete yet=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
essage  -- The message encoded in the encoding specified in flags</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+-----------------------------------------=
-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+When OpenVPN is running in --client m=
ode this command sends an app</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+custom command to the server=2E The format of the command is</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+See the client-acc-msg command for=
 more details about the format of the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+message=2E Since a client has only one peer there is no n=
eed to specify the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
lient id and key id=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><span> ------=
-----------------------------------------</span><br><span> </span><br><span=
>@@ -1272,6 +1324,40 @@</span><br><span>    response=2E Mechanisms that nee=
d multiple rounds or more complex answers</span><br><span>    should implem=
ent a different response type than CR_RESPONSE=2E</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+(6) App custom control mess=
age</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    This message is an application =
specific payload message that is transported</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    over the OpenVPN control channel=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    In server mode:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    In client mode:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &gt;ACC:{protocol},{fragment},{msg_base64}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    The protocol is a short ascii string identifying=
 the app specific custom</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    protocol=2E If fragment is set to 1, the message is not complete a=
nd the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    next mess=
age should be concatenated to this message to form a complete</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    message=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+(7) App custom control protocol message</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   This message inform the server or client about the co=
mmon ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protocol=
s and the maximum message length for an ACC message=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+   In server mode:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   &=
gt;CLIENT:ACC_PROTOCOLS,{CID},protocols=3D{protocol_list},message_len=3D{ma=
x_msg_len}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+   In client mode:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list}=
,message_len=3D{max_msg_len}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protoco=
l_list is a list of supported protocols by the client=2E For example</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   flower:power:sys_info w=
ould indicate these three protocols to be supported=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   max_msg_len specifies the maximum mes=
sage length that the peer supports=2E</span><br><span> </span><br><span> Va=
riables:</span><br><span> </span><br><span>diff --git a/src/openvpn/Makefil=
e=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7ecddff=2E=2Ec82e5=
af 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+=
++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -42,6 +42,7 @@</span><br>=
<span> sbin_PROGRAMS =3D openvpn</span><br><span> </span><br><span> openvpn=
_SOURCES =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=
=2Ec acc=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth=
_token=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span=
><br><span>@@ -121,7 +122,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</spa=
n><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec pus=
h=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec pu=
sh=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push_util=
=2Ec \</span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2E=
c reflect_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span>=
<br><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E4af5ad4</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><b=
r><span>@@ -0,0 +1,404 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN=
 -- An application to securely tunnel IP networks</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 202=
5 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pro=
gram is free software; you can redistribute it and/or modify</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU =
General Public License version 2</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope tha=
t it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITN=
ESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of t=
he GNU General Public License along</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  with this program; if not, write to the Free Software F=
oundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;st=
ring=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_=
util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
enum acc_message_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_=
FLAGS_ASCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+log_acc_message(struct contex=
t *c, const struct buffer *buf, int payload_len,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                const char *protocol, int flag=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D flags &amp; A=
CC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *payload_msg =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* For simplicity, we always encode payload=
 to be base64 encoded</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * if not already in base64 format */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        char *b64out =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(openvpn_base64=
_encode(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b64out, free, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pay=
load_msg =3D b64out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D CBSTR(buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (management)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt=
;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct man=
_def_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;options=2Emode =
=3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* server mode=2E Report client context */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            unsigned int mda_key_id =3D get_primar=
y_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,=
%u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               mda-&gt;cid, mda_key_id, protocol, fragment, payload_msg);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* Client mode=2E Do not a report a =
CLIENT id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payloa=
d_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &=
quot;Received custom app control message (protocol &#39;%s&#39;%s)&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        protocol, fra=
gment ? &quot;, fragment&quot; : &quot;&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Parses the flags field of an app control=
 message and moves the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  buffer past the flags string=2E If there is an</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  error parsing the flags field the met=
hod returns -1 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  puts the error reason in err_reason</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_=
acc_message_flags(struct buffer *buf, const char **err_reason, struct gc_ar=
ena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *flags =3D buf=
_extract_field(buf, &#39;,&#39;, gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *err_reason=
 =3D &quot;could not extract flags field&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int acc_flags =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (const char *flag =3D flags; *f=
lag !=3D &#39;\0&#39;; flag++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (*flag =3D=3D &#39;A&#39;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;6&#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MESS=
AGE_FLAGS_BASE64;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
 if (*flag =3D=3D &#39;F&#39;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            *err_reason =3D &quot;Unknown flag in flags&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* The message should be encoded with ex=
actly one encoding=2E Ensure that</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * only one of the flags is present */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool asciienc =3D (bool)(acc_flags=
 &amp; ACC_MESSAGE_FLAGS_ASCII);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool base64enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAG=
S_BASE64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (base64enc + asciienc=
 !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_=
malloc(512, 1, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        snprintf(tmp, 512, &quot;number of encodings must be exactly one &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            &quot;(B64=3D%d, ASCII=3D%d)&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                 base64enc, asciienc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D tmp;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return acc_flags;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, const st=
ruct buffer *buffer)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *err_reason =3D &quot;&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *bu=
ffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_advance(&amp;buf, st=
rlen(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;missing , af=
ter ACC&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* extract protocol, payload length,=
 flags substrings */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char *protocol =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!protocol)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could =
not extract protocol field&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int payload_len;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *payload_le=
n_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!payload_len_str || !((pay=
load_len =3D atoi(payload_len_str))))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        err_reason =3D &quot;could not extract payload length field&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message_flags(&amp;buf,=
 &amp;err_reason, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (fla=
gs &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* We should have a final NUL byte in the control mess=
age buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * an=
d thus the length of the buffer should be payload_len + 1 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf) !=3D pay=
load_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =
=3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        snprintf(tmp, 512, &quot;field length %d, payload lengt=
h %d mismatch&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 payload_len, buf_len(&amp;buf) - 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    log_acc=
_message(c, &amp;buf, payload_len, protocol, flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app control chann=
el &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
             &quot;(%s) message control message: %s&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        format_hex(BPTR(&amp;buf), B=
LEN(&amp;buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+send_acc_message(struct context *c,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi *tls_mu=
lti,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  struct tls_session *session,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                 const char *protocol, bool fragment,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                 const char *m=
sg, bool base64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * length of the protocol stri=
ng + one &#39;,&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * 2 for the encoding (A or 6), potential F (fragment), and 1 for the =
&#39;,&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
4 for the message size itself and one comma</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * 1 for the comma before the message itself */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t ma=
x_header_size =3D strlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 +=
 2 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t l=
en =3D max_header_size + strlen(msg);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_CLIENT, &quot;message length (%zu) exceeds maximum possib=
le message length (%d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if ((int)len &gt; c-&gt;options=2Eacc_max_message_length)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;header (%zu)=
 + message size (%zu) length (%zu) exceeds &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      &quot;maximum allowed l=
ength negotiated with peer (%d)&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            max_header_size, strlen(msg), len,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Ea=
cc_max_message_length);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* add=
 1 for the final \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer buf =3D alloc_buf_gc(len + 1, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Pi=
ggy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_print=
f(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+               strlen(msg),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+               base64 ? &quot;6&q=
uot; : &quot;A&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+               fragment ? &quot;F&quot; : &quot;&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+               msg);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    send_control_channel_string_dowork(session, BSTR(&a=
mp;buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  reschedule_multi_process(c);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabil=
ities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
        const char *delim,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     int *max_acc_len,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     bool server,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D strin=
g_alloc(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    char *tmp_message_orig =3D tmp_message;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_message, delim,=
 &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we =
allow more capabilities than our own, in client</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * mode we reject if we should use capabili=
ties that we do not support */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(tok=
en, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowed_a=
cc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp=
; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher_li=
st(&quot;6&quot;, token)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_PUSH_ERRORS, &quot;App custom control encoding must include =
base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            goto done;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D =
1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; s=
trcmp(token, &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_PUSH_ERRORS, &quot;App custom control encoding must exac=
tly base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            goto done;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=
=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            protocols =
=3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too man=
y parameters for INFO ACC message/IV_ACC=2E&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct mul=
ti_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c=
 =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!c-&gt;options=2Eacc_protocols)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* No app custom protocols have been configured server-=
side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protoco=
ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* We already have det=
ermined the common protocols=2E Doing this</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * again would just add an extra string allo=
cation to options-&gt;gc */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=
=3D2048,6:A,flower:power */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *peer_info =3D c-&gt;c2=2Etls_multi-&gt;peer_info;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *iv_acc =3D =
extract_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *protocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &a=
mp;max_acc_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_P=
USH_ERRORS, &quot;WARNING: IV_ACC peer info variable of peer is malformed&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(protocols=
, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer common_protocols =3D alloc_buf_gc(1024, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while (token)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (tls_item_in_cipher_list(token, c-&gt;options=2Eacc_protocol=
s))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* protocol is=
 in both server and client list */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (buf_len(&amp;common_protocols) &gt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                buf_write_u8(&a=
mp;common_protocols, &#39;:&#39;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            buf_printf(&amp;common_protocols, &quot;%s&quot;, toke=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r=
(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&a=
mp;common_protocols) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(D_PUSH_DEBUG, &quot;WARNING: No common app custom control pr=
otocol=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_negotiated_prot=
ocols =3D string_alloc(buf_str(&amp;common_protocols), &amp;c-&gt;options=
=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;op=
tions=2Eacc_max_message_length =3D max_acc_len;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;&gt;CLIENT:ACC_PR=
OTOCOLS,%lu,protocols=3D%s,message_len=3D%d&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Emda_context=2E=
cid, c-&gt;options=2Eacc_negotiated_protocols,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        max_acc_len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><=
span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><span=
>new file mode 100644</span><br><span>index 0000000=2E=2Ea6112cd</span><br>=
<span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><sp=
an>@@ -0,0 +1,92 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An=
 application to securely tunnel IP networks</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with sup=
port for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             session authentication and key exchange,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pa=
cket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet compression=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne=
 Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
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
, 40%);">+ *  with this program; if not, write to the Free Software Foundat=
ion, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_LEN 64</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN 12=
80</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * This method parses an app custom control message =
and delivers it to the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * management interface=2E We leave reassembly of fragmented messages to=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * management i=
nterface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c            Th=
e context struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param buffer       Buffer containing the control message with ACC</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+receive_acc_message(struct context *c, const struct buffer =
*buffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+send_acc_message(struct context *c,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                 struct tls_multi *tls_multi,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 stru=
ct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                 const char *protocol, bool fragment,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 const char *msg, bo=
ol base64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Parses an info message from the server that contains app cu=
stom control info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 information prior to the PUSH_REPLY to be able to use app custom control</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocols before s=
ending</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * In client mode only allow w=
hat we support ourselves=2E In server mode</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * allow also capabilities that we not support ourse=
lves=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param capabilities      T=
he string to parse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param delim             The delimiter to use when parsing the string=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                  =
        IV_ACC uses &quot;,&quot; as delimiter while the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *                          custom-con=
trol PUSH message uses &quot; &quot; as &quot;,&quot; is</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *                          already us=
ed to separate different push directives</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param max_acc_len       Set to the maximum ACC mes=
sage length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m server            Whether we are server or client</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param gc                The gc arena =
to use for allocating the resulting string</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return                  The resulting protocol s=
tring or NULL on error</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const=
 char *capabilities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     const char *delim,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     int *max_acc_len,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     bool server,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Parses the IV_ACC of the peer =
and sets c-&gt;options=2Eacc_negotiated_protocols</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * to the common protocols of server and clie=
nt and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c-&gt;opti=
ons=2Eacc_max_message_length  to the maximum length of the ACC message</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * support by both serve=
r and client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there is no com=
mon protocol or the client does not support any app custom</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * protocol c-&gt;options=2Eacc_nego=
tiated_protocols will be set to NULL=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param mi     the client instance to use the set the app custom proto=
cols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct mul=
ti_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/for=
ward=2Ec</span><br><span>index b97fb7a=2E=2Ed9e1979 100644</span><br><span>=
--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec=
</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&=
quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span>=
 #include &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><=
span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ =
-257,11 +258,11 @@</span><br><span>     }</span><br><span>     else if (buf=
_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_i=
nfo(buf, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 server_pushed_info(c, buf, 8);</span><br><span>     }</span><br><span>    =
 else if (buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server=
_pushed_info(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        server_pushed_info(c, buf, 4);</span><br><span>     }</span><br><=
span>     else if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))=
</span><br><span>     {</span><br><span>@@ -271,6 +272,10 @@</span><br><spa=
n>     {</span><br><span>         receive_auth_pending(c, buf);</span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (buf_string_match_head_str(buf, &quot;ACC&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        receive_acc_message(c, buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (bu=
f_string_match_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {</spa=
n><br><span>         receive_exit_message(c);</span><br><span>diff --git a/=
src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index ac86f97=
=2E=2Eb4a8f1e 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><=
span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2277,6 +2277,10 @@</spa=
n><br><span>             buf_printf(&amp;out, &quot; aead-epoch&quot;);</sp=
an><br><span>         }</span><br><span>     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protocols=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &qu=
ot; custom-control %d,A:6,%s&quot;, c-&gt;options=2Eacc_max_message_length,=
 c-&gt;options=2Eacc_negotiated_protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     if (BL=
ENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</span><br><span>@=
@ -2521,6 +2525,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OP=
T_P_DHCPDNS);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return flags;</sp=
an><br><span> }</span><br><span> </span><br><span>@@ -2729,6 +2738,19 @@</s=
pan><br><span>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_mtu,=
 c-&gt;options=2Ece=2Etun_mtu);</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (found &amp; OP=
T_P_NCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH, &quot=
;OPTIONS IMPORT: ACC protocols: %s, msg len: %d&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Eacc_negotiat=
ed_protocols, c-&gt;options=2Eacc_max_message_length);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (management)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC_P=
ROTOCOLS:protocols=3D%s,message_len=3D%d&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                c-&gt;options=2Eacc_negotiated_=
protocols, c-&gt;options=2Eacc_max_message_length);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     return true;</span><br><span> }</span><br><span> </span>=
<br><span>@@ -3350,6 +3372,7 @@</span><br><span>     to=2Everify_hash_depth=
 =3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_n=
o_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex5=
09_username_field, options-&gt;x509_username_field, sizeof(to=2Ex509_userna=
me_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=
=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><span>     to=2Ee=
s =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_c=
tx;</span><br><span> </span><br><span>@@ -4304,6 +4327,25 @@</span><br><spa=
n> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
struct buffer_list *input) /* ownership transferred */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_m=
ulti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *mu=
lti =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;session[TM=
_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct options *opt =3D &amp;c-&gt;options;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ret =3D management_send_acc_message(c, multi, session, opt-&gt;a=
cc_negotiated_protocols, input);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free=
(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span>=
 void</span><br><span>@@ -4320,6 +4362,7 @@</span><br><span>         cb=2Ep=
roxy_cmd =3D management_callback_proxy_cmd;</span><br><span>         cb=2Er=
emote_cmd =3D management_callback_remote_cmd;</span><br><span>         cb=
=2Esend_cc_message =3D management_callback_send_cc_message;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D management=
_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>         c=
b=2Enetwork_change =3D management_callback_network_change;</span><br><span>=
 #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/m=
anage=2Ec</span><br><span>index 1fa3738=2E=2Ead54999 100644</span><br><span=
>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec<=
/span><br><span>@@ -44,9 +44,11 @@</span><br><span> #include &quot;dco=2Eh&=
quot;</span><br><span> #include &quot;push=2Eh&quot;</span><br><span> #incl=
ude &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #incl=
ude &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;run_command=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_PKCS11<=
/span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span>@@ -1081,6=
 +1083,35 @@</span><br><span>             }</span><br><span>             br=
eak;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        case IEC_CLIENT_ACC_MSG:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Eclient_acc_msg=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                bool sta=
tus =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(man-&gt;persist=2Eca=
llback=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                                                man-&gt;con=
nection=2Ein_extra_cid,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                                                      m=
an-&gt;connection=2Ein_extra_kid,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                             =
         man-&gt;connection=2Ein_extra);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                man-&gt;connection=2Ein_extra =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                re=
port_command_status(status, &quot;client-acc-msg&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                man_command_unsupported(&quot;client-=
acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case IEC_ACC_MSG:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;=
persist=2Ecallback=2Eacc_msg)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                bool status =3D (*man-&gt;persist=2Ecallback=2Eacc_msg)=
(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                            =
   man-&gt;connection=2Ein_extra);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                man-&gt;connection=2Ein_extra =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                report_c=
ommand_status(status, &quot;acc-msg&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                man_command_unsupported(&quot;acc-msg&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><=
span>         case IEC_PK_SIGN:</span><br><span>             man-&gt;connec=
tion=2Eext_key_state =3D EKS_READY;</span><br><span>             buffer_lis=
t_free(man-&gt;connection=2Eext_key_input);</span><br><span>@@ -1205,6 +123=
6,29 @@</span><br><span> }</span><br><span> </span><br><span> static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_client_acc_msg(st=
ruct management *man, const char *cid_str,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   const char *kid_str)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt;con=
nection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;=
in_extra_cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mc-&gt;in_extra_kid =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in_extra_cid)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; parse_uint(k=
id_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IEC_CLIENT_ACC_MSG;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_extra_reset(=
mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+man_acc_msg(struct management *man)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct man_connection *mc =3D &amp;man-&gt;connection;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cmd =3D =
IEC_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_=
extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> ma=
n_client_auth(struct management *man, const char *cid_str, const char *kid_=
str, const bool extra)</span><br><span> {</span><br><span>     struct man_c=
onnection *mc =3D &amp;man-&gt;connection;</span><br><span>@@ -1759,6 +1813=
,17 @@</span><br><span>             man_client_pending_auth(man, p[1], p[2]=
, p[3], p[4]);</span><br><span>         }</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot=
;client-acc-msg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (man_need(p, 2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   man_client_acc_msg(man, p[1], p[2]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (streq(p[0], &quot;acc-msg&quot;))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        man_acc_msg(man);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;rsa-si=
g&quot;))</span><br><span>     {</span><br><span>         man_pk_sig(man, &=
quot;rsa-sig&quot;);</span><br><span>@@ -3132,6 +3197,7 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> management_=
connection_established(struct management *man, struct man_def_auth_context =
*mdac,</span><br><span>                                   const struct env_=
set *es)</span><br><span>@@ -4372,6 +4438,62 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ma=
nagement_send_acc_message(struct context *c, struct tls_multi *multi, struc=
t tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            const char *negotiated_protocols, struct bu=
ffer_list *input)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* also ensures =
that are enough inputs in the list to safely call</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * buffer_list_peek without extra NULL ch=
ecks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!inp=
ut || input-&gt;size &lt; 3)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_CLIENT, &quot;not enough input lines for sending acc message, &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
     &quot;missing protocol, flag and/or messages lines&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct buffer *proto_buf =3D buffer_list_peek(inpu=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
protocol =3D string_alloc(CBSTR(proto_buf), &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer *encoding_buf =3D buffer_list_peek=
(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *e=
ncoding =3D buf_str(encoding_buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *flag =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool b64encoding =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    while ((flag =3D strsep(&amp;encoding, &quo=
t;:&quot;)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(f=
lag, &quot;6&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   b64encoding =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else if (!strcmp(flag, &quot;F&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            fragment =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_l=
ist_aggregate_separator(input, 10000, &quot;&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *acc_msg_buf =3D =
buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!negot=
iated_protocols || !tls_item_in_cipher_list(protocol, negotiated_protocols)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;prot=
ocol not in the list of negotiated protocols: %s&quot;, np(negotiated_proto=
cols));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool ret =3D send_acc_message(c, multi, s=
ession, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                              fragment, buf_cstr(acc_msg_buf),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
b64encoding);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #e=
lse /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #inclu=
de &quot;win32=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2E=
h b/src/openvpn/manage=2Eh</span><br><span>index 31577e4=2E=2E4eebf75 10064=
4</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/op=
envpn/manage=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>    =
 int (*n_clients)(void *arg);</span><br><span>     bool (*send_cc_message)(=
void *arg, const char *message, const char *parameter);</span><br><span>   =
  bool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_=
msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     bool (*client_auth)(void *arg, const unsigned long cid, const unsig=
ned int mda_key_id,</span><br><span>                         const bool aut=
h, const char *reason, const char *client_reason,</span><br><span>         =
                struct buffer_list *cc_config); /* ownership transferred */=
</span><br><span>     bool (*client_pending_auth)(void *arg, const unsigned=
 long cid, const unsigned int kid,</span><br><span>                        =
         const char *extra, unsigned int timeout);</span><br><span>     cha=
r *(*get_peer_info)(void *arg, const unsigned long cid);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       const unsigned long cid,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                           const unsigned int mda_key_id,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  struct buffer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    struct buffer_list *msg);</span><br>=
<span>     bool (*proxy_cmd)(void *arg, const char **p);</span><br><span>  =
   bool (*remote_cmd)(void *arg, const char **p);</span><br><span> #ifdef T=
ARGET_ANDROID</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     st=
ruct command_line *in;</span><br><span>     struct buffer_list *out;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IE=
C_UNDEF       0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e IEC_CLIENT_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define IEC_UNDEF          0</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIEN=
T_PF   2 *REMOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD  =
     6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_C=
LIENT_ACC_MSG 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine IEC_ACC_MSG        8</span><br><span>     int in_extra_cmd;</span><br><=
span>     struct buffer_list *in_extra;</span><br><span>     unsigned long =
in_extra_cid;</span><br><span>@@ -503,6 +512,14 @@</span><br><span> </span>=
<br><span> void man_persist_client_stats(struct management *man, struct con=
text *c);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/** Parses the ACC message from the input buffer_list and send to t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * session identi=
fied by session and multi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls=
_session;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls=
_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message=
(struct context *c, struct tls_multi *multi, struct tls_session *session,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       const char *negotiated_protocols, struct buffer_list *input);</span>=
<br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br=
><span> /**</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index dda9232=2E=2E26bb205 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include &quot;ssl_util=
=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #=
include &quot;reflect_filter=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br=
><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><spa=
n>@@ -1735,8 +1736,9 @@</span><br><span>  * - peer id</span><br><span>  */<=
/span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-multi_client_set_protocol_options(struct context *c)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_client_set_protocol_options(s=
truct multi_instance *mi)</span><br><span> {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;context;</sp=
an><br><span>     struct tls_multi *tls_multi =3D c-&gt;c2=2Etls_multi;</sp=
an><br><span>     const char *const peer_info =3D tls_multi-&gt;peer_info;<=
/span><br><span>     struct options *o =3D &amp;c-&gt;options;</span><br><s=
pan>@@ -1795,6 +1797,13 @@</span><br><span>         o-&gt;imported_protocol=
_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;acc_p=
rotocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* If ACC is ena=
bled server side call to find common acc protocols,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * will be pushed during push mes=
sage */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dete=
rmine_common_acc_protocols(mi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     /* Select cipher if client supports Negotiable Crypto P=
arameters */</span><br><span> </span><br><span>     /* if we have already c=
reated our key, we cannot *change* our own</span><br><span>@@ -2380,7 +2389=
,7 @@</span><br><span>      * peer must be added before iroutes=2E For othe=
r platforms it doesn&#39;t matter=2E */</span><br><span> </span><br><span> =
    /* authentication complete, calculate dynamic client specific options *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!multi_clien=
t_set_protocol_options(&amp;mi-&gt;context))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!multi_client_set_protocol_options(mi))</s=
pan><br><span>     {</span><br><span>         mi-&gt;context=2Ec2=2Etls_mul=
ti-&gt;multi_state =3D CAS_FAILED;</span><br><span>     }</span><br><span>@=
@ -4084,6 +4093,26 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const =
char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+calculate_app=
_control_extra(struct multi_instance *mi, struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;context;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_ac=
c_protocols(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=
=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_CLIENT, &quot;ACC: No negotiated protocols&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf_gc(1024, gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, c-&g=
t;options=2Eacc_max_message_length,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+               c-&gt;options=2Eacc_negotiated_protocols);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&a=
mp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> m=
anagement_client_pending_auth(void *arg, const unsigned long cid, const uns=
igned int mda_key_id,</span><br><span>                                const=
 char *extra, unsigned int timeout)</span><br><span>@@ -4094,10 +4123,22 @@=
</span><br><span>     if (mi)</span><br><span>     {</span><br><span>      =
   struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &q=
uot;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ex=
tra =3D calculate_app_control_extra(mi, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (!extra)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
      struct tls_session *session =3D lookup_session_by_mda_key_id(multi, m=
da_key_id);</span><br><span> </span><br><span>         if (!session)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            gc_free(&amp;gc);</span><br><span>             return false;</=
span><br><span>         }</span><br><span> </span><br><span>@@ -4105,6 +414=
6,7 @@</span><br><span>         bool ret =3D send_auth_pending_messages(mul=
ti, session, extra, timeout);</span><br><span>         reschedule_multi_pro=
cess(&amp;mi-&gt;context);</span><br><span>         multi_schedule_context_=
wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   gc_free(&amp;gc);</span><br><span>         return ret;</span><br><span> =
    }</span><br><span>     return false;</span><br><span>@@ -4148,6 +4190,3=
9 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+management_client_acc_msg(void *arg,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                          cons=
t unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          const unsigned int mda_key_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                          struct buff=
er_list *input) /* ownership transferred */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D (struct multi_context *)arg;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *m=
i =3D lookup_by_cid(m, cid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool r=
et =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (mi &amp;&amp; buffer_list_defined(input))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct t=
ls_session *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!session)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quo=
t;client session not found&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buffer_list_free(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct options *opt =3D &amp;mi-&gt;context=2Eoptions;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_mess=
age(&amp;mi-&gt;context, multi, session, opt-&gt;acc_negotiated_protocols, =
input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mult=
i_schedule_context_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_fre=
e(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static char *</span><br><span> ma=
nagement_get_peer_info(void *arg, const unsigned long cid)</span><br><span>=
 {</span><br><span>@@ -4184,6 +4259,7 @@</span><br><span>         cb=2En_cl=
ients =3D management_callback_n_clients;</span><br><span>         cb=2Ekill=
_by_cid =3D management_kill_by_cid;</span><br><span>         cb=2Eclient_au=
th =3D management_client_auth;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cb=2Eclient_acc_msg =3D management_client_acc_msg;</span=
><br><span>         cb=2Eclient_pending_auth =3D management_client_pending_=
auth;</span><br><span>         cb=2Eget_peer_info =3D management_get_peer_i=
nfo;</span><br><span>         cb=2Epush_update_broadcast =3D management_cal=
lback_send_push_update_broadcast;</span><br><span>diff --git a/src/openvpn/=
options=2Ec b/src/openvpn/options=2Ec</span><br><span>index d839b59=2E=2E25=
89942 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>=
+++ b/src/openvpn/options=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><=
span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=
=2Eh&quot;</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span=
> #include &quot;error=2Eh&quot;</span><br><span> #include &quot;common=2Eh=
&quot;</span><br><span>@@ -7133,6 +7134,28 @@</span><br><span>         VERI=
FY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;force_ke=
y_material_export =3D true;</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;app-custom-co=
ntrol&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        options-&gt;acc_protocols =3D p[=
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot=
;custom-control&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp=
;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMI=
SSION(OPT_P_ACC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[=
2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custo=
m control encoding must be base64 and ascii&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;acc_max_message=
_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                   &quot;app custom message message length&quot;, ACC_MIN_M=
SG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;acc_negotiated_protocols =3D p[3];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq=
(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>=
     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --prng option ign=
ored (SSL library PRNG is used)&quot;);</span><br><span>diff --git a/src/op=
envpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 4cd9ef5=
=2E=2Ef603eb0 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><b=
r><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -712,6 +712,16 @@<=
/span><br><span>     /* force using TLS key material export for data channe=
l key generation */</span><br><span>     bool force_key_material_export;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/** The app custom control protocols we should announce as supported */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc_pro=
tocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols that are =
negotiated with the peer=2E As a client we</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * trust the server pushed list here */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc_negotiat=
ed_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the maximum lengt=
h of an ACC control channel message */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int acc_max_message_length;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     bool vlan_tagging;</sp=
an><br><span>     enum vlan_acceptable_frames vlan_accept;</span><br><span>=
     uint16_t vlan_pvid;</span><br><span>@@ -763,8 +773,10 @@</span><br><sp=
an> #define OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #define=
 OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUT=
E_TABLE     (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define OPT_P_ACC             (1ull &lt;&lt; 32)</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT=
 (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Options allowed in the norma=
l configuration file (vs pushed options or in ccd files) */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INST=
ANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </spa=
n><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </=
span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</sp=
an><br><span>index 0e281d2=2E=2E3ba2bd0 100644</span><br><span>--- a/src/op=
envpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@=
@ -27,6 +27,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><b=
r><span> </span><br><span> #include &quot;push=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &q=
uot;options=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</spa=
n><br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -220,9 +222,37=
 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+parse_server_pushed_info_acc(struct co=
ntext *c, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* example string to parse: ACC:140=
0 A:6 flower:happy */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Skip over the ACC: prefix */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buf_advance(buf, 4);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char *protocols =3D parse_acc_parameters(buf_cstr(buf), &quot; &quo=
t;, &amp;max_acc_len, false, &amp;c-&gt;options=2Egc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (protocols)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c-&gt;options=2Eacc_negotiated_protocols =3D pr=
otocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&=
gt;options=2Eacc_max_message_length =3D max_acc_len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (management)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC_PROTOCOLS:protocols=
=3D%s,message_len=3D%d&quot;, protocols, max_acc_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, =
&quot;WARNING: Received ACC info command with invalid parameters&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_in=
fo(const struct buffer *buffer, const int adv)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+server_pushed_info(struct context *c, const stru=
ct buffer *buffer, const int adv)</span><br><span> {</span><br><span>     c=
onst char *m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *=
buffer;</span><br><span>@@ -232,6 +262,12 @@</span><br><span>         m =3D=
 BSTR(&amp;buf);</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, =
4) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        parse_server_=
pushed_info_acc(c, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;=
</span><br><span>     if (management)</span><br><span>@@ -284,6 +320,7 @@</=
span><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;=
%s&#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>=
  * Parse the keyword for the AUTH_PENDING request</span><br><span>  * @par=
am buffer                buffer containing the keywords, the buffer&#39;s</=
span><br><span>@@ -440,7 +477,6 @@</span><br><span>     const char *const p=
eer_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int pro=
to =3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maxi=
mum timeout and subtract the time we already waited */</span><br><span>    =
 unsigned int max_timeout =3D</span><br><span>         max_uint(tls_multi-&=
gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</s=
pan><br><span>@@ -731,6 +767,11 @@</span><br><span>                 client_=
max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         =
}</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;=
options=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A=
:6 %s&quot;, c-&gt;options=2Eacc_max_message_length, c-&gt;options=2Eacc_ne=
gotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span> }</span><br><span> </span><br><span> #if defined(__=
GNUC__) || defined(__clang__)</span><br><span>diff --git a/src/openvpn/push=
=2Eh b/src/openvpn/push=2Eh</span><br><span>index dff945f=2E=2E3aca8a7 1006=
44</span><br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/ope=
nvpn/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</span><br><span> </span><br=
><span> int process_incoming_push_request(struct context *c);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> /**</span><br><span>  * @brief Handles the receiving of a push-update me=
ssage and applies updates to the specified</span><br><span>  * options=2E</=
span><br><span>@@ -92,7 +93,7 @@</span><br><span> </span><br><span> void re=
ceive_exit_message(struct context *c);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void server_pushed_info(const struct buf=
fer *buffer, const int adv);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void server_pushed_info(struct context *c, const struct buffer *bu=
ffer, const int adv);</span><br><span> </span><br><span> void receive_cr_re=
sponse(struct context *c, const struct buffer *buffer);</span><br><span> </=
span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span=
><br><span>index aeec020=2E=2E73ca54c 100644</span><br><span>--- a/src/open=
vpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -5=
5,6 +55,7 @@</span><br><span> </span><br><span> #include &quot;crypto_epoch=
=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br=
><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot=
;ssl_backend=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</s=
pan><br><span>@@ -2105,6 +2106,11 @@</span><br><span>                     }=
</span><br><span>                 }</span><br><span>             }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (session-&gt;opt-&gt;acc_protoco=
ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_pr=
intf(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&=
gt;opt-&gt;acc_protocols);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span>         }</span><br><span>     }</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src=
/openvpn/ssl_common=2Eh</span><br><span>index 6b86bc0=2E=2E0270c23 100644</=
span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/o=
penvpn/ssl_common=2Eh</span><br><span>@@ -452,6 +452,9 @@</span><br><span> =
    size_t ekm_size;</span><br><span> </span><br><span>     bool dco_enable=
d; /**&lt; Whether keys have to be installed in DCO or not */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /** The app custom control protocols we should a=
nnounce as supported */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *acc_protocols;</span><br><span> };</span><br><span> </s=
pan><br><span> /** @addtogroup control_processor</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>index 5430ecb=2E=2Ec66036a 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam</span><br><span>@@ -103,9 +103,11 @@</span><b=
r><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_L=
DFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =
=3D test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
test_acc=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh tes=
t_common=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><span> 	mo=
ck_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buff=
er=2Ec \</span><br><span>@@ -127,6 +129,7 @@</span><br><span> 	$(top_srcdir=
)/src/openvpn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/ssl_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl=
_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \=
</span><br><span>@@ -375,8 +378,10 @@</span><br><span> </span><br><span> mi=
sc_testdriver_SOURCES =3D test_misc=2Ec \</span><br><span> 	test_schedule=
=2Ec test_schedule=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	mock_management=2Ec mock_management=2Eh \</span><br><span> 	mock_msg=
=2Ec test_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base=
64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span>@@ -389,6 +394,7 @@</=
span><br><span> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> push_upd=
ate_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span=
> 	-I$(top_srcdir)/src/compat \</span><br><span> 	-I$(top_srcdir)/tests/uni=
t_tests/openvpn \</span><br><span>diff --git a/tests/unit_tests/openvpn/moc=
k_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><=
span>index 77f6ce2=2E=2E5ae5dea 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_tests/openv=
pn/mock_management=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><span> <=
/span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;=
</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> </span><=
br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/tests/unit_=
tests/openvpn/mock_management=2Eh b/tests/unit_tests/openvpn/mock_managemen=
t=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E80dcfc2</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_t=
ests/openvpn/mock_management=2Eh</span><br><span>@@ -0,0 +1,29 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunn=
el IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          over a single UDP port, with support for SSL/TLS-based</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             session authent=
ication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet encryption, packet authentication, and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compre=
ssion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 =
OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is free software; you can redistribute it and/or modify=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the te=
rms of the GNU General Public License version 2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundatio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed =
in the hope that it will be useful,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more=
 details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef MOCK_MANAGE=
MENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MOCK_=
MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void in=
it_mock_management(void);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void uninit_m=
ock_management(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/te=
sts/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>index 112=
bcfd=2E=2Ec16d0cb 100644</span><br><span>--- a/tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock=
_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,8 @@</span><br><span>  =
   uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P=
_SOCKFLAGS</span><br><span>                      | OPT_P_SETENV | OPT_P_SHA=
PER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span>            =
          | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PUL=
L_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
      | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DH=
CPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
        | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_=
DHCPDNS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         | OPT_P_ACC;</span><br><span>     return flags;</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E42a79c6</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</spa=
n><br><span>@@ -0,0 +1,301 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free Sof=
tware Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+char control_channel_mesage_=
sent[2048];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mock functions */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string_dowork(struct=
 tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                   const char *str, unsigned int msgleve=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range(strlen(str)=
, 0, 2048);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(control_channel_=
mesage_sent, str, strlen(str));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_token(struct tls_mul=
ti *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+auth=
_set_client_reason(struct tls_multi *multi, const char *reason)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MSG=
_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;               =
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &qu=
ot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;AJw=
BnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    &quot;QAXAB4AGQ=
AYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;ICAgaCBsIHAgJCA=
oICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;AUEAwQDAwAtAAIBAQAzAC=
YAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;93rQwityP9eKSijXgcQ=3D=3D&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_acc_parse_client_messages(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    skip();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* ensure that the messages get to mock_msg */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 3;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D =
(void *)0x12345678;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* contains a TLS 1=2E3 ClientHello */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC,cck1,384,6,&quot; M=
SG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer msg_buf;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context c=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
options=2Emode =3D MODE_SERVER;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALL=
OC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eop=
t =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;=
mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg, sizeof(m=
sg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_ac=
c_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(mock_msg_buf, &quot;Received custom app control message (=
protocol &#39;cck1&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:A=
CC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char flower_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0a=
GUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg, sizeof(fl=
ower_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rece=
ive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received cus=
tom app control message (protocol &#39;flower&#39;)&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managm=
ent_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+9=
4oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(=
mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char msg_incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjog=
ImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, =
(void *)msg_incorrect_len, sizeof(msg_incorrect_len));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg=
_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *error =3D &quot;WARNING: Received malformed custom app control channel &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          &quot;(field length 62, payload length 64 mismatch) message &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      &quot;control message: 496e7367 496d316c 496a6f67 496d5a79 &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 &quot;62326369 4c434141 65475a6d 2f534a7[more=2E=2E=2E]&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=
=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_set_read(&amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&=
amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(mock_msg_buf, &quot;Received custom app control m=
essage (protocol &#39;power&#39;, fragment)&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_bu=
f, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* check two encoding present */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_ms=
g_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oC=
PZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof(flo=
wer_msg_two_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    error =3D &quot;WARNING: Received malformed custom app control =
channel (number of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;encodings must be exactly one (B64=3D1, ASCII=3D1))=
 message control &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;message: 53534268 62534141 4945746c 636d3170 6443442f=
 2f534230 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, err=
or);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* no encoding present */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char flower_msg_no_encs[] =3D &quot;ACC,flower,48,=
,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (vo=
id *)flower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Rece=
ived malformed custom app control channel (number of &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;encodings must be=
 exactly one (B64=3D0, ASCII=3D0)) message control &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;message: 53534268 6=
2534141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &quot;61475567 37372b3[more=2E=
=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(mock_msg_buf, error);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_parse_a=
cc_parameters(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* parameters to INFO message */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &quot;4096 A:6 flo=
wer:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_len =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pro=
tocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, =
true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1280);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* a client does not accept a lengt=
h longer than it supports */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;=
, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* message with lower limit than our, should work for client and serv=
er */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_m=
sg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, =
&quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:h=
appy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto=
cols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tr=
ue, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than supported=2E S=
erver should be okay, client should fail */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B flower:happy&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols=
 =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D pa=
rse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flower:hap=
py 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pro=
tocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, =
true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =
=3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capabilities =3D =
&quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv_acc_capabili=
ties, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flo=
wer:happy:power&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* too smal=
l protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(i=
nfo_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* non-numerical protocol length */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;a=
bff A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quo=
t;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* non-numerical protocol length */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:happy 77&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols=
 =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_acc_common_protocols(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_instance mi =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=2Econtext;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-=
&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;I=
V_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_protocols =
=3D &quot;power:flower:star&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
determine_common_acc_protocols(&amp;mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(c-&gt;options=2Eacc_max_message_length, ACC_MAX_MSG_=
LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(c-&gt;options=2Eacc_negotiated_protocols, &quot;flower:power&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_acc_send_message(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct multi_instance mi =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=2Econtext;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt=
;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=
=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_protocols =3D =
&quot;power:flower:emergency&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    determine_common_acc_protocols(&amp;mi);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;sessio=
n[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_mess=
age(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, true,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           &=
quot;EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, false);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(control_channel=
_mesage_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - T=
HIS IS NOT A DRILL:&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D=
 send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, =
false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR =
YOUR AREA=2E&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(control_channel_mesage_sent,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        &quot;AC=
C,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOU=
R AREA=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* test a long message (&gt; 1000) w=
ith fragment to get the maximum header size */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char long_message[1200] =3D { 0 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        long_message[i] =3D (char)(&#39; =
&#39; + (i % 95));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* last char of the message is=
 a i and then a \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(long_message[1023], &#39;i&#39;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1024=
], &#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_=
message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, true,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
   long_message, false);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t c=
c_len =3D strlen(control_channel_mesage_sent);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(control_channel_mesage_sent=
[cc_len - 1], &#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *expected_start_cc =3D &quot;ACC,emergency,1024,AF, =
!\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_memory_equal(control_channel_mesage_sen=
t, expected_start_cc, sizeof(expected_start_cc));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/=
unit_tests/openvpn/test_acc=2Eh</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2Ec9ca758</span><br><span>--- /dev/null</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0=
 +1,33 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             over a single UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    session authentication and key exchange,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet encryption, packet authentic=
ation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is free software; you can redistribu=
te it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  it under the terms of the GNU General Public License version 2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free=
 Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publ=
ic License for more details=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if=
 not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_c=
lient_messages(void **state);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test=
_parse_acc_parameters(void **state);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id test_acc_common_protocols(void **state);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void test_acc_send_message(void **state);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</sp=
an><br><span>index 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_common=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span>=
 #define LargestIntegralType uintmax_t</span><br><span> #endif</span><br><s=
pan> /* redefine 2=2Ex API in terms of 1=2Ex API */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CMockaValueData             Largest=
IntegralType</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define c=
heck_expected_uint         check_expected</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define expect_uint_value           expect_value</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define expect_check_data   =
        expect_check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define cast_ptr_to_cmocka_value(x) (x)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CMockaValueData                       LargestInt=
egralType</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ch=
eck_expected_uint                   check_expected</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define expect_uint_value                   =
  expect_value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne expect_check_data                     expect_check</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x)      =
     (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ass=
ert_int_in_range(value, min, max)  assert_in_range((value), (min), (max))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_uint_i=
n_range(value, min, max) assert_in_range((value), (min), (max))</span><br><=
span> #endif</span><br><span> </span><br><span> /**</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/tes=
t_misc=2Ec</span><br><span>index 8d88943=2E=2Eeba4e27 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -41,10 +41,34 @@</span>=
<br><span> #include &quot;mock_msg=2Eh&quot;</span><br><span> #include &quo=
t;crypto=2Eh&quot;</span><br><span> #include &quot;sid_hash=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_sched=
ule=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #ifdef _WIN32</span><br><span> #include &quot;win32-=
util=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#include &quot;test_schedule=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* extra mocks */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
apply_push_options(struct context *c, struct options *options, struct buffe=
r *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       uint64_t permission_mask, uint64_t *option_types_found,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                   struct env_se=
t *es, bool is_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+send_control_channel_string(struct context *c, const char *str, msglvl=
_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(st=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct multi_instance *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+lookup_by_cid(struct multi_context *m, const unsigne=
d long cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return *(m-&gt;instanc=
es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an> </span><br><span> static void</span><br><span> test_compat_lzo_string(v=
oid **state)</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=
=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 4baf8cc=
=2E=2Ef4841cd 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ss=
l=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>@@ -52,6 +52,8 @@</span><br><span> #include &quot;ssl_verify=2Eh&quo=
t;</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /* Mock function to be allowed to include win32=2Ec which is requi=
red for</span><br><span>  * getting the temp directory */</span><br><span> =
#ifdef _WIN32</span><br><span>@@ -86,6 +88,20 @@</span><br><span> {</span><=
br><span>     return;</span><br><span> }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+reschedule_multi_process(struct context *c)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy dco cip=
her option to avoid linking against all the DCO</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * units */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM=
:CHACHA20-POLY1305&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span> </span><br><span> /* generated using</span><br><span>  * openss=
l req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</sp=
an><br><span>@@ -1111,8 +1127,11 @@</span><br><span>         cmocka_unit_te=
st(ssl_test_extract_last_matching_field),</span><br><span>         cmocka_u=
nit_test(ssl_test_reject_null_in_cert_subject),</span><br><span>         cm=
ocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_extr=
act_peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(s=
sl_test_extract_peer_info),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_acc_parse_client_messages),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_parse_acc_parameters),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_acc_common_protocols),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_send=
_message)</span><br><span>     };</span><br><span> </span><br><span> #if de=
fined(ENABLE_CRYPTO_OPENSSL)</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body><=
/html>
--2lQ+kBKN0Ww=--


--===============1304833802776153130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1304833802776153130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1304833802776153130==--

