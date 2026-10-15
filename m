Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C09CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asWt44OxB3zK0isRhKq4lqdEHhijnzyQNH31LLnUIPk=; b=OjSZ5wIx7D5/nRNjvuwCAgZeKE
	wg9KjkkvEGmISMWj6OTcVrKuD50cTEzCxs0mQThMEOZdGVnC9CMXYirtOdqPquQdIROm6WQTWhZ9s
	xd7SsJKcUX3mK5rVwSa4b5vBWMFskIfsKMz/PgjJt54EDDZnyLfOvV8IFY3DABDE4oe8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHIhV-0003qb-QK;
	Thu, 15 Oct 2026 10:28:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHIhU-0003qO-Fn
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f8KQcrev/xeyTNVp+gXDNRUTyvemNRSf3yZWAXNW78U=; b=ihvc/cUtKJzoS827QG143qbtMA
 DRATVryVbOTxcYDd42orwRMrDkN5OyW6bMsfpJfLF2n8+tlrBpbajtetUBgRBFCfpssrzb0dxwMsc
 deETJyA4ZyZewictDDrw5QQGn4bMw2XvaRvz7KyoTSYFK8vKQnxIGpT7lqOUyIVW5bvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f8KQcrev/xeyTNVp+gXDNRUTyvemNRSf3yZWAXNW78U=; b=X
 vgm+RBz+TxtB3WGhtURLf6xFawyMFtGLdfkgOafdQwuFnWG0Oy3w3DobF29ngN52hUguftL4uq4SC
 BpiqWUOyBd4IWKlu/iuhBJ8UDctAyHP8F3hhUtSbYBvJSzjzDU52LQp2wM+3ljXVI5bAeGfzlatqq
 x+hWfjwdYBTkyryk=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHIhO-0003Tp-Vr for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:28:41 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso48133795e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792060108; x=1792664908; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f8KQcrev/xeyTNVp+gXDNRUTyvemNRSf3yZWAXNW78U=;
 b=VYcmTmtsBVl+um96eTMAK5VjGb7k1bytP5UzbOMJ4Yfrzha+PUSbt9htX/hTg7uDFF
 O77nSMw0OluTYGNxgo7DScGDEsyUPNF9sudNssHou6xFLzcIXq6XqFutkf7jl+zk7sKt
 4CrVU332jZSgDrd8snOvMxT7jiV33f1VbcEz+X0iWnsZmh45/k27vIf4+QqrU8XQdKXH
 BB8lBcIiIwy9kJPuwJoXICRWyxaZuZZJcUeQnqo9rSjDDpmHlwPo5nvyaDWG3hsTEVhm
 LBh+Xbs9k0i8Jv++AN8ab7cy8vgYGR3dSXTj83bJu21G3kuU9ZgjtFcctC/F/S/JxtdD
 pf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060108; x=1792664908;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f8KQcrev/xeyTNVp+gXDNRUTyvemNRSf3yZWAXNW78U=;
 b=FoGyc3vtp2jg/G2SLAEF3Sm24MlN0w87kngLnFKXyBpLHneuVFRK4pD9CheHP8H0hk
 Ty3cXhFVxh5LA15k3FYcMgwVEq9zmqFSEYjntkdRH6C5pdLDWVaJlQPf8qyTOU0/j1Rs
 AX0jCzgfvo1pKPbZPq32O3MuA5GajRqGfx6yRHwygGiwiWrK5eQ7GAs98f0Rb4zTeYuY
 XInM1ggWBph0LVgk2EzKiosQ4iEhL996nRHXxlTBrohN6an2xtuDvoL9FTSDJ+K9pbhc
 JnFY1YlXqPinkP/nevMhhGFmXXbR2CMwwjoGoa5LZzlrFgIaa8Qq/Lcu8Ersko1mA/jL
 X5wA==
X-Gm-Message-State: AFq9FYKf8E54/50FXQktrbC94rvqTNJFUdRQMNbeBnSM3F306u0pCh2q
 LzcxnQj5KHjii5Kf1LkBzu6o6Nz3lVlP5zCiwfWoOuyq7AttIWxtK7oG03KYOFRjQhL8Qf2agWd
 QB+jzaEHfZ8JoQvSsaxyTyyXRMDchzz64NAMtez2n3P173HALi3H1m7fcllUtAznutu1i
X-Gm-Gg: AYBFou3wU614dPwU5SphyEO2uR2d/CVENGJwREhLS2S3PhQtQ/EvDDlyCk/AnXRli+x
 4lSa/tD8kLRbhFT7m7SorVSucUaV7FGO/91xQ1xLUOkhaLlk0tANlXk46DLBQOzbOxBFlLAcLqF
 /VfV1LU3v3wQadS9+XK+QPNixxYJAxSr9Kml5UTCzKSH4o0t50zwW2RaIM0oaKRGoa67ceE9FTD
 +t7RefFUTOlm+SHriPUNlVfoBtscQe2hdvwD1JsjpoP3FLe2Iia0bPaUdkY+P/MamXPAnfrTVG5
 r0/1PR4qI38SNfyGHrBgz0UsJ+2vjLFo404fa+YVW4263M8c6NC2wzFUYQgjjmcQ21MPBiPhd1c
 sXIat6RW82ykpmjV5hd63cSLPZkpjmsR0uSWYGEHHdq1rZ1LTZLhtRdp/PkAvD9p9QjGoifsiP/
 qyP1fJrcgSyagp32HjzeGu/7ktW0QrlYfbyeNpgwoHI3FNfh1RFhfhHDf9TlaLauBYj/k9gnZEI
 e0M9stoJOxxUGxTe9a1tm4mhjRxb3PCC3FAM6qiGqqLxg4kF8TGJVehPFlLslqUg6g4wK2Lk/G2
 cZ+f0KkWEUh2KZEhV6aZOKBVGwu4HN54UdaNFPxF3TOEKDNPmh0+eVQtAIYKwg==
X-Received: by 2002:a05:600c:8217:b0:4a1:a496:fc17 with SMTP id
 5b1f17b1804b1-4a1a4bd3da9mr209238925e9.5.1792060106334; 
 Thu, 15 Oct 2026 03:28:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72c7e36sm11896528f8f.37.2026.10.15.03.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:28:25 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 10:28:13 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: e0ad2954187c30dbf99281a4172a3d6a14a5c231
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da9a5fc60b0fddece255ea9ecf5f4c073222b394-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHIhO-0003Tp-Vr
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
Content-Type: multipart/mixed; boundary="===============3755347948804108392=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3755347948804108392==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bCVN5Ejinos="; charset=UTF-8

--bCVN5Ejinos=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#11)=2E


Change subje=
ct: Implement sending/receiving app custom control protocol messages
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement sending/r=
eceiving app custom control protocol messages

This allows openvpn GUI/fron=
t-ends and server via management
to use the OpenVPN control channel to pass=
 messages between each other
while OpenVPN handles the marshalling/unmarsha=
lling of these and
negotiate the common app custom control protocols=2E

Th=
is provides an easy to use secure channel that does not depend on
the netwo=
rk itself to work and can also used before fully authenticating
the client=
=2E See the management-notes=2Etxt for more details how to use
this feature=
=2E An upcoming patch will also add some example python
script that showcas=
e this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Sig=
ned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/=
man-sections/client-options=2Erst
M doc/management-notes=2Etxt
M src/openvp=
n/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/f=
orward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/ma=
nage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/op=
tions=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_=
util=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_te=
sts/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
A =
tests/unit_tests/openvpn/mock_management=2Eh
M tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec
A tests/unit_tests/openvpn/test_acc=2Ec
A tests/uni=
t_tests/openvpn/test_acc=2Eh
M tests/unit_tests/openvpn/test_common=2Eh
M t=
ests/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_ssl=
=2Ec
27 files changed, 1,402 insertions(+), 28 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/11

diff --gi=
t a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index bac4dd4=2E=2Ed63d0ef 100644
-=
-- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -433,6 +433,8 @@
     src/c=
ompat/compat-gettimeofday=2Ec
     src/compat/compat-strsep=2Ec
     src/co=
mpat/compat-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
=
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=
=2Ec
@@ -569,9 +571,9 @@
     src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
  =
   src/openvpn/push=2Ec
-    src/openvpn/push_util=2Ec
     src/openvpn/pus=
h=2Eh
-    src/openvpn/pushlist=2Eh
+    src/openvpn/push_util=2Ec
+       =
 src/openvpn/pushlist=2Eh
     src/openvpn/reflect_filter=2Ec
     src/open=
vpn/reflect_filter=2Eh
     src/openvpn/reliable=2Ec
@@ -821,7 +823,10 @@
 =
            tests/unit_tests/openvpn/mock_management=2Ec
             tests=
/unit_tests/openvpn/mock_ssl_dependencies=2Ec
             tests/unit_tests=
/openvpn/mock_win32_execve=2Ec
+            tests/unit_tests/openvpn/test_a=
cc=2Ec
+            src/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
+=
            src/openvpn/auth_token=2Ec
             src/openvpn/base64=2Ec
=
             src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_m=
bedtls=2Ec
@@ -835,8 +840,11 @@
             src/openvpn/options_util=2Ec
 =
            src/openvpn/otime=2Ec
             src/openvpn/packet_id=2Ec
+ =
           src/openvpn/reliable=2Ec
+            src/openvpn/session_id=2Ec=

             src/openvpn/run_command=2Ec
             src/openvpn/ssl_mbed=
tls=2Ec
+            src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_o=
penssl=2Ec
             src/openvpn/ssl_util=2Ec
             src/openvpn/s=
sl_verify_mbedtls=2Ec
@@ -853,6 +861,8 @@
     target_sources(test_misc PRI=
VATE
         tests/unit_tests/openvpn/mock_get_random=2Ec
         tests/u=
nit_tests/openvpn/test_schedule=2Ec
+        tests/unit_tests/openvpn/mock_=
management=2Ec
+        src/openvpn/base64=2Ec
         src/openvpn/options=
_util=2Ec
         src/openvpn/otime=2Ec
         src/openvpn/ssl_util=2Ec
=
diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/clien=
t-options=2Erst
index 87c138a=2E=2E89ba7cf 100644
--- a/doc/man-sections/cl=
ient-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -12,6 +12=
,17 @@
   When this option is set, OpenVPN will not drop incoming tun packe=
ts with
   same destination as host=2E
 
+--app-custom-control protocollist=

+  Sets the list of supported app custom control protocols=2E
+  These pro=
tocols are announced to the server when this option is used
+  as a client=
=2E If the option is set on a server it will negotiate the
+  common protoc=
ols with the client=2E
+
+  The protocollist is a : separated list of proto=
col identifiers=2E
+
+  See management-notes=2Etxt in the OpenVPN distribut=
ion  and the OpenVPN RFC
+  draft for a description of app custom control p=
rotocol support=2E
+
 --auth-token token
   This is not an option to be use=
d directly in any configuration files,
   but rather push this option from =
a ``--client-connect`` script or a
diff --git a/doc/management-notes=2Etxt =
b/doc/management-notes=2Etxt
index 325f8bd=2E=2E565b1b8 100644
--- a/doc/ma=
nagement-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -798,6 +798,58 @@
=
 The client should return the response to the crtext challenge
 using the c=
r-response command=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed as {EXTRA} =
OpenVPN will determine
+the common app custom protocols between the client =
and the server and instruct
+the client that the server will send control m=
essages to the client using
+the ACC protocol=2E
+
+The server should then =
use acc-msg command to send app custom control messages
+to the client to f=
acilitate the pending authentication=2E
+
+COMMAND -- client-acc-msg (OpenV=
PN 2=2E8 or higher)
+------------------------------------------
+
+On an Op=
enVPN instance running in server mode this command sends an
+app custom con=
trol message to a client=2E The format of the command is:
+
+  client-acc-m=
sg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
+CID,KID -- c=
lient ID and Key ID=2E See documentation for ">CLIENT:"
+notification for m=
ore info=2E
+
+protocol -- the ACC protocol identifier that this message sh=
ould be
+            tagged with=2E
+
+flags    -- a colon separated list o=
f the encoding and the flag if
+            the message is a fragment=2E E=
=2Eg=2E "6:F" for a base64 encoded
+            message that is also a frag=
ment and not complete yet=2E
+
+message  -- The message encoded in the enco=
ding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)
+=
------------------------------------------
+
+When OpenVPN is running in --=
client mode this command sends an app
+custom command to the server=2E The =
format of the command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {message}=

+  END
+
+See the client-acc-msg command for more details about the format=
 of the
+message=2E Since a client has only one peer there is no need to sp=
ecify the
+client id and key id=2E
+
+
 COMMAND -- client-deny  (OpenVPN 2=
=2E1 or higher)
 -----------------------------------------------
 
@@ -1272=
,6 +1324,40 @@
    response=2E Mechanisms that need multiple rounds or more=
 complex answers
    should implement a different response type than CR_RES=
PONSE=2E
 
+(6) App custom control message
+
+    This message is an applic=
ation specific payload message that is transported
+    over the OpenVPN co=
ntrol channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{pro=
tocol},{fragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:{protocol=
},{fragment},{msg_base64}
+
+    The protocol is a short ascii string ident=
ifying the app specific custom
+    protocol=2E If fragment is set to 1, th=
e message is not complete and the
+    next message should be concatenated =
to this message to form a complete
+    message=2E
+
+(7) App custom contro=
l protocol message
+
+   This message inform the server or client about the=
 common ACC
+   protocols and the maximum message length for an ACC message=
=2E
+
+   In server mode:
+
+   >CLIENT:ACC_PROTOCOLS,{CID},protocols=3D{pr=
otocol_list},message_len=3D{max_msg_len}
+
+   In client mode:
+
+   >ACC_P=
ROTOCOLS:protocols=3D{protocol_list},message_len=3D{max_msg_len}
+
+   prot=
ocol_list is a list of supported protocols by the client=2E For example
+  =
 flower:power:sys_info would indicate these three protocols to be supported=
=2E
+   max_msg_len specifies the maximum message length that the peer supp=
orts=2E
 
 Variables:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvp=
n/Makefile=2Eam
index 7ecddff=2E=2Ec82e5af 100644
--- a/src/openvpn/Makefil=
e=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -42,6 +42,7 @@
 sbin_PROGRAMS =3D=
 openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \=

 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -121,7 +122=
,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	p=
ush=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	=
pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec rel=
iable=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file=
 mode 100644
index 0000000=2E=2Ec1eb0c4
--- /dev/null
+++ b/src/openvpn/acc=
=2Ec
@@ -0,0 +1,403 @@
+/*
+ *  OpenVPN -- An application to securely tunne=
l IP networks
+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based
+ *             session authentication and key exchange,
+ * =
            packet encryption, packet authentication, and
+ *             p=
acket compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+=
 *  This program is free software; you can redistribute it and/or modify
+ =
*  it under the terms of the GNU General Public License version 2
+ *  as p=
ublished by the Free Software Foundation=2E
+ *
+ *  This program is distri=
buted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PA=
RTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more detai=
ls=2E
+ *
+ *  You should have received a copy of the GNU General Public Li=
cense along
+ *  with this program; if not, write to the Free Software Foun=
dation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#inc=
lude "syshead=2Eh"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#includ=
e "error=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"
+#include "option=
s_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+#include "mul=
ti=2Eh"
+
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+  =
  ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+}=
;
+
+
+static void
+log_acc_message(struct context *c, const struct buffer =
*buf, int payload_len,
+                const char *protocol, int flags)
+{=

+    bool fragment =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_=
MANAGEMENT
+    struct gc_arena gc =3D gc_new();
+    const char *payload_m=
sg =3D NULL;
+
+    /* For simplicity, we always encode payload to be base6=
4 encoded
+     * if not already in base64 format */
+    if (flags & ACC_M=
ESSAGE_FLAGS_ASCII)
+    {
+        char *b64out =3D NULL;
+        ASSERT(=
openvpn_base64_encode(CBPTR(buf), payload_len, &b64out) >=3D 0);
+        g=
c_addspecial(b64out, free, &gc);
+        payload_msg =3D b64out;
+    }
+ =
   else
+    {
+        payload_msg =3D CBSTR(buf);
+    }
+
+    if (manag=
ement)
+    {
+        struct tls_session *session =3D &c->c2=2Etls_multi->=
session[TM_ACTIVE];
+
+        struct man_def_auth_context *mda =3D session=
->opt->mda_context;
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+   =
     {
+            /* server mode=2E Report client context */
+           =
 unsigned int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_id=
;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+              =
  mda->cid, mda_key_id, protocol, fragment, payload_msg);
+        }
+     =
   else
+        {
+            /* Client mode=2E Do not a report a CLIENT =
id */
+            msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, paylo=
ad_msg);
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAG=
EMENT */
+    msg(D_PUSH, "Received custom app control message (protocol '%=
s'%s)",
+        protocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *  =
Parses the flags field of an app control message and moves the
+ *  buffer =
past the flags string=2E If there is an
+ *  error parsing the flags field =
the method returns -1 and
+ *  puts the error reason in err_reason
+ */
+st=
atic int
+parse_acc_message_flags(struct buffer *buf, const char **err_reas=
on, struct gc_arena *gc)
+{
+    const char *flags =3D buf_extract_field(bu=
f, ',', gc);
+
+    if (!flags)
+    {
+        *err_reason =3D "could not =
extract flags field";
+        return -1;
+    }
+
+
+    int acc_flags =3D=
 0;
+
+    for (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {=

+        if (*flag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_=
MESSAGE_FLAGS_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+      =
  {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+     =
   else if (*flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_ME=
SSAGE_FLAGS_FRAGMENT;
+        }
+        else
+        {
+            *err=
_reason =3D "Unknown flag in flags";
+            return -1;
+        }
+  =
  }
+    /* The message should be encoded with exactly one encoding=2E Ensu=
re that
+     * only one of the flags is present */
+    bool asciienc =3D =
(bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)=
(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=
=3D 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, gc);
+        snprin=
tf(tmp, 512, "number of encodings must be exactly one "
+                  =
         "(B64=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc);
=
+        *err_reason =3D tmp;
+        return -1;
+    }
+
+    return acc_=
flags;
+}
+
+
+void
+receive_acc_message(struct context *c, const struct bu=
ffer *buffer)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *err=
_reason =3D "";
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy=
 */
+    struct buffer buf =3D *buffer;
+
+    if (!buf_advance(&buf, strle=
n("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "mi=
ssing , after ACC";
+        goto err;
+    }
+
+    /* extract protocol, p=
ayload length, flags substrings */
+    char *protocol =3D buf_extract_fiel=
d(&buf, ',', &gc);
+    if (!protocol)
+    {
+        err_reason =3D "coul=
d not extract protocol field";
+        goto err;
+    }
+
+    int payload=
_len;
+    char *payload_len_str =3D buf_extract_field(&buf, ',', &gc);
+  =
  if (!payload_len_str || !((payload_len =3D atoi(payload_len_str))))
+    =
{
+        err_reason =3D "could not extract payload length field";
+      =
  goto err;
+    }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_=
reason, &gc);
+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+   =
 /* We should have a final NUL byte in the control message buffer
+     * a=
nd thus the length of the buffer should be payload_len + 1 */
+    if (buf_=
len(&buf) !=3D payload_len + 1)
+    {
+        char *tmp =3D gc_malloc(512=
, 1, &gc);
+        snprintf(tmp, 512, "field length %d, payload length %d =
mismatch",
+                 payload_len, buf_len(&buf) - 1);
+        err_=
reason =3D tmp;
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf,=
 payload_len, protocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+  =
  msg(D_PUSH_ERRORS, "WARNING: Received malformed custom app control channe=
l "
+                       "(%s) message control message: %s",
+        er=
r_reason,
+        format_hex(BPTR(&buf), BLEN(&buf), 80, &gc));
+    gc_fr=
ee(&gc);
+}
+
+
+bool
+send_acc_message(struct context *c,
+               =
  struct tls_multi *tls_multi,
+                 struct tls_session *sessio=
n,
+                 const char *protocol, bool fragment,
+                =
 const char *msg, bool base64)
+{
+    /*
+     * length of the protocol st=
ring + one ','
+     * 2 for the encoding (A or 6), potential F (fragment),=
 and 1 for the ',',
+     * 4 for the message size itself and one comma
+  =
   * 1 for the comma before the message itself */
+    const size_t max_hea=
der_size =3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    si=
ze_t len =3D max_header_size + strlen(msg);
+
+    if (len > TLS_CHANNEL_BU=
F_SIZE)
+    {
+        msg(M_CLIENT, "message length (%zu) exceeds maximum=
 possible message length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return=
 false;
+    }
+
+    if ((int)len > c->options=2Eacc_max_message_length)
+=
    {
+        msg(M_CLIENT, "header (%zu) + message size (%zu) length (%zu=
) exceeds "
+                      "maximum allowed length negotiated with =
peer (%d)",
+            max_header_size, strlen(msg), len,
+            c-=
>options=2Eacc_max_message_length);
+        return false;
+    }
+
+    st=
ruct gc_arena gc =3D gc_new();
+    /* add 1 for the final \0 */
+    struc=
t buffer buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC=
,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s"=
, protocol,
+               strlen(msg),
+               base64 ? "6" : "A"=
,
+               fragment ? "F" : "",
+               msg);
+
+    send_co=
ntrol_channel_string_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_m=
ulti_process(c);
+    gc_free(&gc);
+    return true;
+}
+
+char *
+parse_a=
cc_parameters(const char *capabilities,
+                     const char *d=
elim,
+                     int *max_acc_len,
+                     bool se=
rver,
+                     struct gc_arena *gc)
+{
+    char *tmp_message =
=3D string_alloc(capabilities, NULL);
+    char *tmp_message_orig =3D tmp_m=
essage;
+    char *lasts =3D NULL;
+
+    const char *token =3D strtok_r(tm=
p_message, delim, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    =
const char *protocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In serve=
r mode we allow more capabilities than our own, in client
+     * mode we r=
eject if we should use capabilities that we do not support */
+    int allo=
wed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+ =
   {
+        if (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC mess=
age length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+=
            goto done;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_i=
n_cipher_list("A", token) || !tls_item_in_cipher_list("6", token)))
+      =
  {
+            msg(D_PUSH_ERRORS, "App custom control encoding must inclu=
de base64 and ascii");
+            goto done;
+        }
+
+        if (p =
=3D=3D 1 && !server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+     =
   {
+            msg(D_PUSH_ERRORS, "App custom control encoding must exac=
tly base64 and ascii");
+            goto done;
+        }
+
+        if (p=
 =3D=3D 2)
+        {
+            protocols =3D token;
+        }
+
+     =
   if (p =3D=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many par=
ameters for INFO ACC message/IV_ACC=2E");
+            goto done;
+        =
}
+
+        token =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
=
+
+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D stri=
ng_alloc(protocols, gc);
+
+done:
+    free(tmp_message_orig);
+    return =
ret;
+}
+
+
+void
+determine_common_acc_protocols(struct multi_instance *mi=
)
+{
+    struct context *c =3D &mi->context;
+    if (!c->options=2Eacc_pr=
otocols)
+    {
+        /* No app custom protocols have been configured se=
rver-side=2E */
+        return;
+    }
+
+    if (c->options=2Eacc_negotia=
ted_protocols)
+    {
+        /* We already have determined the common pro=
tocols=2E Doing this
+         * again would just add an extra string alloc=
ation to options->gc */
+        return;
+    }
+
+    struct gc_arena gc =
=3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+=
    const char *peer_info =3D c->c2=2Etls_multi->peer_info;
+    char *iv_a=
cc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc=
)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+    int max_acc_=
len =3D 0;
+    char *protocols =3D parse_acc_parameters(iv_acc, ",", &max_=
acc_len, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+=
        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of peer is m=
alformed");
+        return;
+    }
+
+    char *lasts =3D NULL;
+    const=
 char *token =3D strtok_r(protocols, ":", &lasts);
+
+    struct buffer com=
mon_protocols =3D alloc_buf_gc(1024, &gc);
+
+    while (token)
+    {
+   =
     if (tls_item_in_cipher_list(token, c->options=2Eacc_protocols))
+     =
   {
+            /* protocol is in both server and client list */
+       =
     if (buf_len(&common_protocols) > 0)
+            {
+                bu=
f_write_u8(&common_protocols, ':');
+            }
+            buf_printf(=
&common_protocols, "%s", token);
+        }
+        token =3D strtok_r(NUL=
L, ":", &lasts);
+    }
+
+    if (buf_len(&common_protocols) =3D=3D 0)
+  =
  {
+        gc_free(&gc);
+        msg(D_PUSH_DEBUG, "WARNING: No common a=
pp custom control protocol=2E");
+        return;
+    }
+
+    c->options=
=2Eacc_negotiated_protocols =3D string_alloc(buf_str(&common_protocols), &c=
->options=2Egc);
+    c->options=2Eacc_max_message_length =3D max_acc_len;
=
+
+    msg(M_CLIENT, ">CLIENT:ACC_PROTOCOLS,%lu,protocols=3D%s,message_len=
=3D%d",
+        mi->context=2Ec2=2Emda_context=2Ecid, c->options=2Eacc_neg=
otiated_protocols,
+        max_acc_len);
+    gc_free(&gc);
+}
\ No newlin=
e at end of file
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new=
 file mode 100644
index 0000000=2E=2Ea6112cd
--- /dev/null
+++ b/src/openvp=
n/acc=2Eh
@@ -0,0 +1,92 @@
+/*
+ *  OpenVPN -- An application to securely t=
unnel IP networks
+ *             over a single TCP/UDP port, with support =
for SSL/TLS-based
+ *             session authentication and key exchange,
=
+ *             packet encryption, packet authentication, and
+ *          =
   packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@ope=
nvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+=
 *
+ *  This program is free software; you can redistribute it and/or modif=
y
+ *  it under the terms of the GNU General Public License version 2
+ *  =
as published by the Free Software Foundation=2E
+ *
+ *  This program is di=
stributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more d=
etails=2E
+ *
+ *  You should have received a copy of the GNU General Publi=
c License along
+ *  with this program; if not, write to the Free Software =
Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-=
1301 USA=2E
+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
=
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This=
 method parses an app custom control message and delivers it to the
+ * man=
agement interface=2E We leave reassembly of fragmented messages to the
+ * =
management interface=2E
+ *
+ * @param c            The context struct
+ * =
@param buffer       Buffer containing the control message with ACC
+ */
+vo=
id
+receive_acc_message(struct context *c, const struct buffer *buffer);
+
=
+
+bool
+send_acc_message(struct context *c,
+                 struct tls_m=
ulti *tls_multi,
+                 struct tls_session *session,
+          =
       const char *protocol, bool fragment,
+                 const char *m=
sg, bool base64);
+
+
+/**
+ * Parses an info message from the server that =
contains app custom control info
+ * information prior to the PUSH_REPLY to=
 be able to use app custom control
+ * protocols before sending
+ *
+ * In =
client mode only allow what we support ourselves=2E In server mode
+ * allo=
w also capabilities that we not support ourselves=2E
+ *
+ * @param capabil=
ities      The string to parse
+ * @param delim             The delimiter t=
o use when parsing the string=2E
+ *                          IV_ACC uses "=
," as delimiter while the
+ *                          custom-control PUSH =
message uses " " as "," is
+ *                          already used to sep=
arate different push directives
+ * @param max_acc_len       Set to the max=
imum ACC message length
+ * @param server            Whether we are server =
or client
+ * @param gc                The gc arena to use for allocating t=
he resulting string
+ * @return                  The resulting protocol str=
ing or NULL on error
+ */
+char *
+parse_acc_parameters(const char *capabil=
ities,
+                     const char *delim,
+                     int *=
max_acc_len,
+                     bool server,
+                     struc=
t gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets c->optio=
ns=2Eacc_negotiated_protocols
+ * to the common protocols of server and cli=
ent and
+ * c->options=2Eacc_max_message_length  to the maximum length of t=
he ACC message
+ * support by both server and client=2E
+ *
+ * If there is=
 no common protocol or the client does not support any app custom
+ * proto=
col c->options=2Eacc_negotiated_protocols will be set to NULL=2E
+ *
+ * @p=
aram mi     the client instance to use the set the app custom protocols=2E
=
+ */
+void
+determine_common_acc_protocols(struct multi_instance *mi);
+#en=
dif
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index b9=
7fb7a=2E=2Ed9e1979 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/f=
orward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"=

 #include "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
=
@@ -257,11 +258,11 @@
     }
     else if (buf_string_match_head_str(buf, "=
INFO_PRE"))
     {
-        server_pushed_info(buf, 8);
+        server_pus=
hed_info(c, buf, 8);
     }
     else if (buf_string_match_head_str(buf, "I=
NFO"))
     {
-        server_pushed_info(buf, 4);
+        server_pushed_i=
nfo(c, buf, 4);
     }
     else if (buf_string_match_head_str(buf, "CR_RES=
PONSE"))
     {
@@ -271,6 +272,10 @@
     {
         receive_auth_pending(c=
, buf);
     }
+    else if (buf_string_match_head_str(buf, "ACC"))
+    {
=
+        receive_acc_message(c, buf);
+    }
     else if (buf_string_match=
_head_str(buf, "EXIT"))
     {
         receive_exit_message(c);
diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index ac86f97=2E=2Eb4a8f1e 1=
00644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2277,6 +227=
7,10 @@
             buf_printf(&out, " aead-epoch");
         }
     }
+  =
  if (c->options=2Eacc_negotiated_protocols)
+    {
+        buf_printf(&ou=
t, " custom-control %d,A:6,%s", c->options=2Eacc_max_message_length, c->opt=
ions=2Eacc_negotiated_protocols);
+    }
 
     if (BLENZ(&out) > strlen(he=
ader))
     {
@@ -2521,6 +2525,11 @@
         flags |=3D (OPT_P_ROUTE | OPT=
_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+    {
+        =
flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -2729,6 +2738,19 =
@@
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
1d2=2E=2E0c75d62 100644
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
d_info_acc(struct context *c, const char **m)
+{
+    int max_acc_len =3D 0=
;
+
+
+    /* example string to parse: ACC:1400 A:6 flower:happy */
+    /*=
 Skip over the ACC: prefix */
+    *m +=3D 4;
+
+    char *protocols =3D pa=
rse_acc_parameters(*m, " ", &max_acc_len, false, &c->options=2Egc);
+    if=
 (protocols)
+    {
+        c->options=2Eacc_negotiated_protocols =3D prot=
ocols;
+        c->options=2Eacc_max_message_length =3D max_acc_len;
+
+#if=
def ENABLE_MANAGEMENT
+        if (management)
+        {
+            msg(=
M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d", protocols, max_=
acc_len);
+        }
+#endif
+    }
+    else
+    {
+        msg(D_PUSH_ER=
RORS, "WARNING: Received ACC info command with invalid parameters");
+    }=

+}
 
 void
-server_pushed_info(const struct buffer *buffer, const int adv)=

+server_pushed_info(struct context *c, const struct buffer *buffer, const =
int adv)
 {
     const char *m =3D "";
     struct buffer buf =3D *buffer;
=
@@ -232,6 +262,12 @@
         m =3D BSTR(&buf);
     }
 
+    if (strncmp(m=
, "ACC:", 4) =3D=3D 0)
+    {
+        parse_server_pushed_info_acc(c, &m);=

+        return;
+    }
+
 #ifdef ENABLE_MANAGEMENT
     struct gc_arena g=
c;
     if (management)
@@ -284,6 +320,7 @@
     msg(D_PUSH, "CR response w=
as sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword for the AU=
TH_PENDING request
  * @param buffer                buffer containing the k=
eywords, the buffer's
@@ -440,7 +477,6 @@
     const char *const peer_info =
=3D tls_multi->peer_info;
     unsigned int proto =3D extract_iv_proto(peer=
_info);
 
-
     /* Calculate the maximum timeout and subtract the time we =
already waited */
     unsigned int max_timeout =3D
         max_uint(tls_m=
ulti->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_window);
@@=
 -731,6 +767,11 @@
                 client_max_mtu, o->ce=2Etun_mtu, o->ce=
=2Etun_mtu);
         }
     }
+
+    if (c->options=2Eacc_negotiated_proto=
cols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "custom-contr=
ol %d A:6 %s", c->options=2Eacc_max_message_length, c->options=2Eacc_negoti=
ated_protocols);
+    }
 }
 
 #if defined(__GNUC__) || defined(__clang__)
d=
iff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E=
3aca8a7 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52=
,6 +52,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /=
**
  * @brief Handles the receiving of a push-update message and applies up=
dates to the specified
  * options=2E
@@ -92,7 +93,7 @@
 
 void receive_exi=
t_message(struct context *c);
 
-void server_pushed_info(const struct buffe=
r *buffer, const int adv);
+void server_pushed_info(struct context *c, cons=
t struct buffer *buffer, const int adv);
 
 void receive_cr_response(struct=
 context *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/push_=
util=2Ec b/src/openvpn/push_util=2Ec
index 0213041=2E=2Eeae6c35 100644
--- =
a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -368,4 +368,=
4 @@
 
     RETURN_UPDATE_STATUS(n_sent);
 }
-#endif /* ifdef ENABLE_MANAGE=
MENT */
+#endif /* ifdef ENABLE_MANAGEMENT */
\ No newline at end of file
d=
iff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index aeec020=2E=2E73=
ca54c 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +=
55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
+#include "acc=
=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_backend=2Eh"
 #include "ssl=
_ncp=2Eh"
@@ -2105,6 +2106,11 @@
                     }
                 }
=
             }
+
+            if (session->opt->acc_protocols)
+           =
 {
+                buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LE=
N, session->opt->acc_protocols);
+            }
         }
     }
 
diff --=
git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 6b86bc0=
=2E=2E0270c23 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl=
_common=2Eh
@@ -452,6 +452,9 @@
     size_t ekm_size;
 
     bool dco_enabl=
ed; /**< Whether keys have to be installed in DCO or not */
+
+    /** The =
app custom control protocols we should announce as supported */
+    const =
char *acc_protocols;
 };
 
 /** @addtogroup control_processor
diff --git a/=
tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam
index 5430ecb=2E=2Ed864a8f 100644
--- a/tests/unit_tests/openvpn/Make=
file=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -103,9 +103,11 @@=

 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRY=
PTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
+    test_acc=2Ec test=
_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_management=
=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
+	$(top_srcdir)/=
src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir=
)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -127=
,6 +129,7 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/=
src/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \=

+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_=
util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_src=
dir)/src/openvpn/ssl_verify_openssl=2Ec \
@@ -375,8 +378,10 @@
 
 misc_test=
driver_SOURCES =3D test_misc=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
=
+	mock_management=2Ec mock_management=2Eh \
 	mock_msg=2Ec test_common=2Eh =
 \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top=
_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=
=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
@@ -389,6 +394,7 @@
 	$(t=
op_srcdir)/src/openvpn/siphash_reference=2Ec \
 	$(top_srcdir)/src/openvpn/=
session_id=2Ec
 
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/s=
rc/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_te=
sts/openvpn \
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/t=
ests/unit_tests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2Ecddd669 1006=
44
--- a/tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_test=
s/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 =

+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
=
@@ -60,4 +61,4 @@
 void
 management_sleep(const int n)
 {
-}
+}
\ No newlin=
e at end of file
diff --git a/tests/unit_tests/openvpn/mock_management=2Eh =
b/tests/unit_tests/openvpn/mock_management=2Eh
new file mode 100644
index 0=
000000=2E=2Ee21aec43
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_mana=
gement=2Eh
@@ -0,0 +1,32 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@op=
envpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
=
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License version 2
+ * =
 as published by the Free Software Foundation=2E
+ *
+ *  This program is d=
istributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more =
details=2E
+ *
+ *  You should have received a copy of the GNU General Publ=
ic License along
+ *  with this program; if not, write to the Free Software=
 Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA=2E
+ */
+
+#ifndef MOCK_MANAGEMENT_H
+#define MOCK_MANAGEMENT_H
+=
void init_mock_management(void);
+
+void uninit_mock_management(void);
+
+#=
endif
diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/te=
sts/unit_tests/openvpn/mock_push_dependencies=2Ec
index 112bcfd=2E=2Ec16d0c=
b 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/te=
sts/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -43,7 +43,8 @@
     ui=
nt64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCK=
FLAGS
                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | O=
PT_P_COMP | OPT_P_PERSIST
                      | OPT_P_MESSAGES | OPT_P_EX=
PLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                     | OPT_P_=
PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+      =
               | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE |=
 OPT_P_DHCPDNS
+                     | OPT_P_ACC;
     return flags;
 }
 
d=
iff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvp=
n/test_acc=2Ec
new file mode 100644
index 0000000=2E=2E42a79c6
--- /dev/nul=
l
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,0 +1,301 @@
+/*
+ *  Op=
enVPN -- An application to securely tunnel IP networks
+ *             over=
 a single TCP/UDP port, with support for SSL/TLS-based
+ *             sess=
ion authentication and key exchange,
+ *             packet encryption, pac=
ket authentication, and
+ *             packet compression=2E
+ *
+ *  Copy=
right (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Ar=
ne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software;=
 you can redistribute it and/or modify
+ *  it under the terms of the GNU G=
eneral Public License version 2
+ *  as published by the Free Software Foun=
dation=2E
+ *
+ *  This program is distributed in the hope that it will be =
useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=

+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  =
GNU General Public License for more details=2E
+ *
+ *  You should have rec=
eived a copy of the GNU General Public License along
+ *  with this program=
; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin S=
treet, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG=
_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <st=
dio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2Eh>
+#include <string=2E=
h>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "acc=2Eh"
+#in=
clude "test_acc=2Eh"
+#include "test_common=2Eh"
+
+#include "mock_msg=2Eh"=

+#include "multi=2Eh"
+
+char control_channel_mesage_sent[2048];
+
+/* Moc=
k functions */
+bool
+send_control_channel_string_dowork(struct tls_session=
 *session,
+                                   const char *str, unsigned in=
t msglevel)
+{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    memcp=
y(control_channel_mesage_sent, str, strlen(str));
+    return true;
+}
+
+v=
oid
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+aut=
h_set_client_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#=
define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"               =
 \
+                    "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d6=
0nTS" \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewC=
TAKABrwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAM=
AAQIACgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAA=
AA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBB=
QEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJA=
AdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=
=3D=3D"
+
+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef E=
NABLE_MANAGEMENT
+    skip();
+#else
+    /* ensure that the messages get t=
o mock_msg */
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345=
678;
+    struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 C=
lientHello */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+ =
   struct buffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=
=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, stru=
ct tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D=
 &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eop=
t->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void=
 *)msg, sizeof(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    assert=
_string_equal(mock_msg_buf, "Received custom app control message (protocol =
'cck1')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cc=
k1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SS=
BhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg=
_buf, (void *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c,=
 &msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app con=
trol message (protocol 'flower')");
+    assert_string_equal(mock_managment=
_buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyE=
AAA=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    const char msg_incorrec=
t_len[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhb=
SAAS2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect=
_len, sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+=
    const char *error =3D "WARNING: Received malformed custom app control c=
hannel "
+                        "(field length 62, payload length 64 mism=
atch) message "
+                        "control message: 496e7367 496d316=
c 496a6f67 496d5a79 "
+                        "62326369 4c434141 65475a6d =
2f534a7[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+=
    assert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managmen=
t_buf);
+    const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=
=3D";
+    buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment=
));
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_m=
sg_buf, "Received custom app control message (protocol 'power', fragment)")=
;
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGV=
sbG8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    /* check two encodi=
ng present */
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,S=
SBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&ms=
g_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    rece=
ive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malforme=
d custom app control channel (number of "
+            "encodings must be e=
xactly one (B64=3D1, ASCII=3D1)) message control "
+            "message: 5=
3534268 62534141 4945746c 636d3170 6443442f 2f534230 "
+            "614755=
67 37372b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
=
+    assert_string_equal(mock_managment_buf, "");
+
+    /* no encoding pre=
sent */
+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIE=
tlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (v=
oid *)flower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_mes=
sage(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom ap=
p control channel (number of "
+            "encodings must be exactly one =
(B64=3D0, ASCII=3D0)) message control "
+            "message: 53534268 625=
34141 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[=
more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert=
_string_equal(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    man=
agement =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_par=
ameters(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* para=
meters to INFO message */
+    const char *info_acc_msg =3D "4096 A:6 flowe=
r:happy";
+
+    int max_len =3D 0;
+    const char *protocols =3D parse_ac=
c_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_eq=
ual(protocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+  =
  /* a client does not accept a length longer than it supports */
+    prot=
ocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+ =
   assert_null(protocols);
+
+    /* message with lower limit than our, sho=
uld work for client and server */
+    info_acc_msg =3D "1111 A:6 flower:ha=
ppy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, =
false, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    asse=
rt_int_equal(max_len, 1111);
+
+    protocols =3D parse_acc_parameters(info=
_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "f=
lower:happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more encodin=
gs than supported=2E Server should be okay, client should fail */
+    info=
_acc_msg =3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc_parame=
ters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);=

+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, tru=
e, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_i=
nt_equal(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg =3D=
 "1400 A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(info_a=
cc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    prot=
ocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+ =
   assert_null(protocols);
+
+
+    const char *iv_acc_capabilities =3D "14=
00,A:6,flower:happy:power";
+    protocols =3D parse_acc_parameters(iv_acc_=
capabilities, ",", &max_len, true, &gc);
+    assert_string_equal(protocols=
, "flower:happy:power");
+
+    /* too small protocol length */
+    info_a=
cc_msg =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(i=
nfo_acc_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
+   =
 /* non-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flower=
:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &max=
_len, true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical prot=
ocol length */
+    info_acc_msg =3D "abff A:6 flower:happy 77";
+    proto=
cols =3D parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+   =
 assert_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_p=
rotocols(void **state)
+{
+    struct multi_instance mi =3D { 0 };
+    str=
uct context *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+   =
 ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);=

+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:=
6,flower:happy:power";
+    c->options=2Eacc_protocols =3D "power:flower:st=
ar";
+
+    determine_common_acc_protocols(&mi);
+
+    assert_int_equal(c-=
>options=2Eacc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equ=
al(c->options=2Eacc_negotiated_protocols, "flower:power");
+
+    gc_free(&=
c->options=2Egc);
+}
+
+void
+test_acc_send_message(void **state)
+{
+    s=
truct multi_instance mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext=
;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_=
multi, struct tls_multi, &c->options=2Egc);
+    bool ret;
+
+    c->c2=2Et=
ls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergenc=
y:power";
+    c->options=2Eacc_protocols =3D "power:flower:emergency";
+  =
  determine_common_acc_protocols(&mi);
+
+
+    struct tls_session *session=
 =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_messag=
e(c, c->c2=2Etls_multi, session, "emergency", true,
+                      =
     "EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    a=
ssert_true(ret);
+    assert_string_equal(control_channel_mesage_sent,
+   =
                     "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THI=
S IS NOT A DRILL:");
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, =
session, "emergency", false,
+                           "THE GOVERNMENT HA=
S ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_tr=
ue(ret);
+    assert_string_equal(control_channel_mesage_sent,
+           =
             "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOUR=
ED ALERT FOR YOUR AREA=2E");
+
+
+    /* test a long message (> 1000) with =
fragment to get the maximum header size */
+    char long_message[1200] =3D=
 { 0 };
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+        long_messag=
e[i] =3D (char)(' ' + (i % 95));
+    }
+
+    /* last char of the message =
is a i and then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+  =
  assert_int_equal(long_message[1024], '\0');
+
+    ret =3D send_acc_messa=
ge(c, c->c2=2Etls_multi, session, "emergency", true,
+                     =
      long_message, false);
+
+    assert_true(ret);
+    size_t cc_len =3D=
 strlen(control_channel_mesage_sent);
+    assert_int_equal(control_channel=
_mesage_sent[cc_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC=
,emergency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(con=
trol_channel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));
+
=
+    gc_free(&c->options=2Egc);
+}
\ No newline at end of file
diff --git a=
/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=
=2Eh
new file mode 100644
index 0000000=2E=2Ea64bab5
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An=
 application to securely tunnel IP networks
+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based
+ *             session authent=
ication and key exchange,
+ *             packet encryption, packet authent=
ication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2=
025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe =
<arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can re=
distribute it and/or modify
+ *  it under the terms of the GNU General Publ=
ic License version 2
+ *  as published by the Free Software Foundation=2E
+=
 *
+ *  This program is distributed in the hope that it will be useful,
+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General=
 Public License for more details=2E
+ *
+ *  You should have received a cop=
y of the GNU General Public License along
+ *  with this program; if not, w=
rite to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fift=
h Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef TEST_ACC_H
+#define T=
EST_ACC_H
+void test_acc_parse_client_messages(void **state);
+
+void test_=
parse_acc_parameters(void **state);
+
+void test_acc_common_protocols(void =
**state);
+
+void test_acc_send_message(void **state);
+#endif
diff --git a=
/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_c=
ommon=2Eh
index 8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_tests/openvpn/=
test_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -43,11 +4=
3,13 @@
 #define LargestIntegralType uintmax_t
 #endif
 /* redefine 2=2Ex A=
PI in terms of 1=2Ex API */
-#define CMockaValueData             LargestInt=
egralType
-#define check_expected_uint         check_expected
-#define expe=
ct_uint_value           expect_value
-#define expect_check_data           e=
xpect_check
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValueDa=
ta                       LargestIntegralType
+#define check_expected_uint  =
                 check_expected
+#define expect_uint_value                 =
    expect_value
+#define expect_check_data                     expect_chec=
k
+#define cast_ptr_to_cmocka_value(x)           (x)
+#define assert_int_in=
_range(value, min, max)  assert_in_range((value), (min), (max))
+#define as=
sert_uint_in_range(value, min, max) assert_in_range((value), (min), (max))
=
 #endif
 
 /**
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/=
unit_tests/openvpn/test_misc=2Ec
index 8d88943=2E=2Eeba4e27 100644
--- a/te=
sts/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_mi=
sc=2Ec
@@ -41,10 +41,34 @@
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
=
 #include "sid_hash=2Eh"
+#include "test_schedule=2Eh"
+#include "multi=2Eh=
"
+
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
-#include "test_sched=
ule=2Eh"
+
+/* extra mocks */
+bool
+apply_push_options(struct context *c, =
struct options *options, struct buffer *buf,
+                   uint64_t p=
ermission_mask, uint64_t *option_types_found,
+                   struct en=
v_set *es, bool is_update)
+{
+    return true;
+}
+
+bool
+send_control_ch=
annel_string(struct context *c, const char *str, msglvl_t msglevel)
+{
+   =
 check_expected_ptr(str);
+    return true;
+}
+
+struct multi_instance *
+=
lookup_by_cid(struct multi_context *m, const unsigned long cid)
+{
+    ret=
urn *(m->instances);
+}
 
 static void
 test_compat_lzo_string(void **state=
)
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/ope=
nvpn/test_ssl=2Ec
index 4baf8cc=2E=2Ef4841cd 100644
--- a/tests/unit_tests/=
openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +=
52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "tes=
t_acc=2Eh"
+
 /* Mock function to be allowed to include win32=2Ec which is =
required for
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,=
20 @@
 {
     return;
 }
+void
+reschedule_multi_process(struct context *c)=

+{
+}
+
+/* Define a dummy dco cipher option to avoid linking against all =
the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_suppor=
ted_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-1=
28-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req=
 -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -1111=
,8 +1127,11 @@
         cmocka_unit_test(ssl_test_extract_last_matching_fie=
ld),
         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
     =
    cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
-        c=
mocka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_test(ssl=
_test_extract_peer_info),
+        cmocka_unit_test(test_acc_parse_client_m=
essages),
+        cmocka_unit_test(test_parse_acc_parameters),
+        cm=
ocka_unit_test(test_acc_common_protocols),
+        cmocka_unit_test(test_a=
cc_send_message)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795=
b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 11
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--bCVN5Ejinos=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #11</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vie=
w Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Implement sending/receiving app custom contro=
l protocol messages<br><br>This allows openvpn GUI/front-ends and server vi=
a management<br>to use the OpenVPN control channel to pass messages between=
 each other<br>while OpenVPN handles the marshalling/unmarshalling of these=
 and<br>negotiate the common app custom control protocols=2E<br><br>This pr=
ovides an easy to use secure channel that does not depend on<br>the network=
 itself to work and can also used before fully authenticating<br>the client=
=2E See the management-notes=2Etxt for more details how to use<br>this feat=
ure=2E An upcoming patch will also add some example python<br>script that s=
howcase this feature=2E<br><br>Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86=
b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<b=
r>M CMakeLists=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M doc/ma=
nagement-notes=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/acc=2E=
c<br>A src/openvpn/acc=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/in=
it=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/ope=
nvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br=
>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/openvpn/push_uti=
l=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/u=
nit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_manageme=
nt=2Ec<br>A tests/unit_tests/openvpn/mock_management=2Eh<br>M tests/unit_te=
sts/openvpn/mock_push_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_a=
cc=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/ope=
nvpn/test_common=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests=
/unit_tests/openvpn/test_ssl=2Ec<br>27 files changed, 1,402 insertions(+), =
28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/58/1858/11</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index bac4dd4=2E=2Ed63d0ef 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -433,6 +433,8 @@</span><br><span>     src/compat/=
compat-gettimeofday=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</=
span><br><span>     src/compat/compat-strtok_r=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>=
     src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><=
br><span>     src/openvpn/base64=2Ec</span><br><span>@@ -569,9 +571,9 @@</s=
pan><br><span>     src/openvpn/ps=2Ec</span><br><span>     src/openvpn/ps=
=2Eh</span><br><span>     src/openvpn/push=2Ec</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    src/openvpn/push_util=2Ec</span><br><span>    =
 src/openvpn/push=2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    src/openvpn/pushlist=2Eh</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    src/openvpn/push_util=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        src/openvpn/pushlist=2Eh</span><br><span>     sr=
c/openvpn/reflect_filter=2Ec</span><br><span>     src/openvpn/reflect_filte=
r=2Eh</span><br><span>     src/openvpn/reliable=2Ec</span><br><span>@@ -821=
,7 +823,10 @@</span><br><span>             tests/unit_tests/openvpn/mock_ma=
nagement=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_ssl=
_dependencies=2Ec</span><br><span>             tests/unit_tests/openvpn/moc=
k_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           tests/unit_tests/openvpn/test_acc=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            src/openvpn/acc=2Ec</span><br><spa=
n>             src/openvpn/argv=2Ec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            src/openvpn/auth_token=2Ec</span><br><span>    =
         src/openvpn/base64=2Ec</span><br><span>             src/openvpn/cr=
ypto_epoch=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span>@@ -835,8 +840,11 @@</span><br><span>             src/openv=
pn/options_util=2Ec</span><br><span>             src/openvpn/otime=2Ec</spa=
n><br><span>             src/openvpn/packet_id=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/reliable=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/ses=
sion_id=2Ec</span><br><span>             src/openvpn/run_command=2Ec</span>=
<br><span>             src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/ssl_ncp=2Ec</span><b=
r><span>             src/openvpn/ssl_openssl=2Ec</span><br><span>          =
   src/openvpn/ssl_util=2Ec</span><br><span>             src/openvpn/ssl_ve=
rify_mbedtls=2Ec</span><br><span>@@ -853,6 +861,8 @@</span><br><span>     t=
arget_sources(test_misc PRIVATE</span><br><span>         tests/unit_tests/o=
penvpn/mock_get_random=2Ec</span><br><span>         tests/unit_tests/openvp=
n/test_schedule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        tests/unit_tests/openvpn/mock_management=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/base64=2Ec</span><br>=
<span>         src/openvpn/options_util=2Ec</span><br><span>         src/op=
envpn/otime=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</span><br=
><span>diff --git a/doc/man-sections/client-options=2Erst b/doc/man-section=
s/client-options=2Erst</span><br><span>index 87c138a=2E=2E89ba7cf 100644</s=
pan><br><span>--- a/doc/man-sections/client-options=2Erst</span><br><span>+=
++ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -12,6 +12,17 =
@@</span><br><span>   When this option is set, OpenVPN will not drop incomi=
ng tun packets with</span><br><span>   same destination as host=2E</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-cust=
om-control protocollist</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Sets the list of supported app custom control protocols=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  These protocols are announce=
d to the server when this option is used</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  as a client=2E If the option is set on a server it w=
ill negotiate the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
common protocols with the client=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  T=
he protocollist is a : separated list of protocol identifiers=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  See management-notes=2Etxt in the OpenVPN distr=
ibution  and the OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  draft for a description of app custom control protocol support=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> --auth-token token</span><br><span>   This is not an option to be used di=
rectly in any configuration files,</span><br><span>   but rather push this =
option from a ``--client-connect`` script or a</span><br><span>diff --git a=
/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>in=
dex 325f8bd=2E=2E565b1b8 100644</span><br><span>--- a/doc/management-notes=
=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ =
-798,6 +798,58 @@</span><br><span> The client should return the response to=
 the crtext challenge</span><br><span> using the cr-response command=2E</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+app c=
ustom control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+If the special string &quot;ACC&quot; is passe=
d as {EXTRA} OpenVPN will determine</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+the common app custom protocols between the client and the =
server and instruct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
the client that the server will send control messages to the client using</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ACC protocol=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+The server should then use acc-msg comma=
nd to send app custom control messages</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+to the client to facilitate the pending authentication=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (OpenVPN =
2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+---=
---------------------------------------</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+On an OpenVPN instance running in server mode this command sends an</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+app custom control message=
 to a client=2E The format of the command is:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  client-acc-msg {CID} {KID}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 {message}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CID,KID -- client ID and Key ID=2E See do=
cumentation for &quot;&gt;CLIENT:&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+notification for more info=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+protocol -- the ACC protocol identifier that this message should=
 be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tagg=
ed with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+flags    -- a colon separate=
d list of the encoding and the flag if</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            the message is a fragment=2E E=2Eg=2E &quot;=
6:F&quot; for a base64 encoded</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            message that is also a fragment and not complete yet=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+message  -- The message encoded in =
the encoding specified in flags</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- acc-msg (OpenVP=
N 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-----------------------------------------</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+When OpenVPN is running in --client mode this command sends an app</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+custom command to the ser=
ver=2E The format of the command is</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
cc-msg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+See the client-acc-msg command for more details about the format of the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+message=2E Since a =
client has only one peer there is no need to specify the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+client id and key id=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> COMMAND -- client-deny  (OpenVPN 2=
=2E1 or higher)</span><br><span> ------------------------------------------=
-----</span><br><span> </span><br><span>@@ -1272,6 +1324,40 @@</span><br><s=
pan>    response=2E Mechanisms that need multiple rounds or more complex an=
swers</span><br><span>    should implement a different response type than C=
R_RESPONSE=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+(6) App custom control message</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    This message is an application specific payload message that is tra=
nsported</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    over th=
e OpenVPN control channel=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    In ser=
ver mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{KID=
},{protocol},{fragment},{msg_base64}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  In client mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;ACC:{protocol=
},{fragment},{msg_base64}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The proto=
col is a short ascii string identifying the app specific custom</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    protocol=2E If fragment is =
set to 1, the message is not complete and the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    next message should be concatenated to this m=
essage to form a complete</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(7) App custom con=
trol protocol message</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   This message i=
nform the server or client about the common ACC</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+   protocols and the maximum message length for=
 an ACC message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+   In server mode:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   &gt;CLIENT:ACC_PROTOCOLS,{CID},protoc=
ols=3D{protocol_list},message_len=3D{max_msg_len}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+   In client mode:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   &gt;AC=
C_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{max_msg_len}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   protocol_list is a list of supported protoc=
ols by the client=2E For example</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   flower:power:sys_info would indicate these three protocols =
to be supported=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
  max_msg_len specifies the maximum message length that the peer supports=
=2E</span><br><span> </span><br><span> Variables:</span><br><span> </span><=
br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam=
</span><br><span>index 7ecddff=2E=2Ec82e5af 100644</span><br><span>--- a/sr=
c/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</sp=
an><br><span>@@ -42,6 +42,7 @@</span><br><span> sbin_PROGRAMS =3D openvpn</=
span><br><span> </span><br><span> openvpn_SOURCES =3D \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><br><span> 	ar=
gv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=2Eh \</span><=
br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -121,7 +122,8 @@</spa=
n><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \=
</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br><span> 	pushlist=2E=
h \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><br><sp=
an> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git a/src/openvpn/a=
cc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2Ec1eb0c4</span><br><span>--- /dev/null</span><br><=
span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,403 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunne=
l IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         over a single TCP/UDP port, with support for SSL/TLS-based</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session auth=
entication and key exchange,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             packet encryption, packet authentication, and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet com=
pression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Op=
enVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eor=
g&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is free software; you can redis=
tribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  it under the terms of the GNU General Public License version 2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the=
 Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is distributed in the hope that it will be useful,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General=
 Public License for more details=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  You should have received a copy of the GNU General Public License along<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, write to the Free Software Foundation, Inc=2E,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;options_util=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+enum acc_message_flag</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLA=
GS_FRAGMENT =3D 4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+log_acc_message(struct context *c, const struct buffer *buf, int=
 payload_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          const char *protocol, int flags)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool fragment =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGMENT;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *payload_msg =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
For simplicity, we always encode payload to be base64 encoded</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * if not already in base64 f=
ormat */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (fla=
gs &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        char *b64out =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ASSERT(openvpn_base64_encode(CBPTR(buf), payload_len, &a=
mp;b64out) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        gc_addspecial(b64out, free, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        payload_msg =3D b64out;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        payload_msg =3D CBSTR(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (managem=
ent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *s=
ession =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct man_def_auth_context *mda =3D session-=
&gt;opt-&gt;mda_context;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* server mode=2E Report client con=
text */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_k=
ey_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                mda-&gt;cid, mda_key_i=
d, protocol, fragment, payload_msg);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* Client mode=2E Do not a report a CLIENT id */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC:%s,%=
d,%s&quot;, protocol, fragment, payload_msg);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received custom app control mess=
age (protocol &#39;%s&#39;%s)&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        protocol, fragment ? &quot;, fragment&quot; : &quo=
t;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Pa=
rses the flags field of an app control message and moves the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  buffer past the flags string=
=2E If there is an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  error parsing the flags field the method returns -1 and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  puts the error reason in err_rea=
son</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(struct buffer *bu=
f, const char **err_reason, struct gc_arena *gc)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *flags =3D buf_extract_field(buf, &#39;,&#39;, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        *err_reason =3D &quot;could not extract flags =
field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A&#39;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC=
_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&#39;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MES=
SAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            *err_reason =
=3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return -1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* The message should be encoded with exactly one encoding=2E Ensure that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only one of =
the flags is present */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASCII);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool base64enc =
=3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &qu=
ot;number of encodings must be exactly one &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                           &quot;(B64=3D%d, A=
SCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               base64enc, asciienc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *err_reason =3D tmp;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn acc_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
receive_acc_message(struct context *c, const struct buffer *buffer)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *err_reason =
=3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example messag=
e: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D *buffer;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&quot;ACC&quot;)) || b=
uf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        err_reason =3D &quot;missing , after ACC&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* extract protocol, payload length, flags substrings */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocol =3D buf_e=
xtract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!protocol)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        err_reason =3D &quot;could not extract protocol field&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int payload_len;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char *payload_len_str =3D buf_extract_field(&=
amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!payload_len_str || !((payload_len =3D atoi(payload_len=
_str))))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &q=
uot;could not extract payload length field&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt flags =3D parse_acc_message_flags(&amp;buf, &amp;err_reason, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We sh=
ould have a final NUL byte in the control message buffer</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * and thus the length of the buff=
er should be payload_len + 1 */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tm=
p, 512, &quot;field length %d, payload length %d mismatch&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                 payload_len, =
buf_len(&amp;buf) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        err_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_=
len, protocol, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING:=
 Received malformed custom app control channel &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       &quot;(%s) message=
 control message: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        err_reason,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        format_hex(BPTR(&amp;buf), BLEN(&amp;buf), 80, &amp;gc));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_messag=
e(struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 struct tls_multi *tls_multi,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                 struct tls_session *session,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const=
 char *protocol, bool fragment,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                 const char *msg, bool base64)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * length of the protocol string + one &#39;,&#39;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * 2 for the encoding (A or =
6), potential F (fragment), and 1 for the &#39;,&#39;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * 4 for the message size itself and=
 one comma</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 1 =
for the comma before the message itself */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const size_t max_header_size =3D strlen(&quot;AC=
C,&quot;) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size_t len =3D max_header_size + strlen(m=
sg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_S=
IZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;m=
essage length (%zu) exceeds maximum possible message length (%d)&quot;, len=
, TLS_CHANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &gt; c-&g=
t;options=2Eacc_max_message_length)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_CLIENT, &quot;header (%zu) + message size (%zu) length (%zu=
) exceeds &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   &quot;maximum allowed length negotiated with peer (%d)&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ma=
x_header_size, strlen(msg), len,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            c-&gt;options=2Eacc_max_message_length);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(len + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ex=
ample message: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s=
%s,%s&quot;, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+               strlen(msg),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+               base64 ? &quot;6&quot; : &quot;A&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+               fragment ? &qu=
ot;F&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+               msg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    send_co=
ntrol_channel_string_dowork(session, BSTR(&amp;buf), D_PUSH);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    reschedule_multi_process(c);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+parse_acc_parameters(const char *capabilities,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     const char *delim,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                     int=
 *max_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                bool server,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                     struct gc_arena *gc)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    char *tmp_message =3D string_alloc(capabilities, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message_=
orig =3D tmp_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *token =3D strtok_r(tmp_message, delim, &amp;lasts);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int p =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int acclen =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *protocols =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* In server mode we allow more capabilities than ou=
r own, in client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * mode we reject if we should use capabilities that we do not support */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int allowed_acc_=
len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    while (token)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(p =3D=3D 0 &amp;&amp; !atoi_constrained(token, &amp;acclen, &quot;ACC mess=
age length&quot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (p =3D=3D 1 &amp;&amp; (!tls_item_in_cipher_list(&qu=
ot;A&quot;, token) || !tls_item_in_cipher_list(&quot;6&quot;, token)))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &qu=
ot;App custom control encoding must include base64 and ascii&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; !server &amp;&amp;=
 strcmp(token, &quot;A:6&quot;) &amp;&amp; strcmp(token, &quot;6:A&quot;))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS,=
 &quot;App custom control encoding must exactly base64 and ascii&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (p =3D=3D 2)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            protocols =3D token;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (p =3D=3D 3)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(D_PUSH_ERRORS, &quot;Too many parameters for INFO ACC messag=
e/IV_ACC=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r=
(NULL, delim, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        p++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    *max_acc_len =3D min_int(accl=
en, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ret =3D string_alloc(protocols, gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(t=
mp_message_orig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
determine_common_acc_protocols(struct multi_instance *mi)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;context;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc=
_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* No app cust=
om protocols have been configured server-side=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (c-&gt;options=2Eacc_negotiated_protocols)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* We already have determined the common protocols=2E =
Doing this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* again would just add an extra string allocation to options-&gt;gc */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *peer_in=
fo =3D c-&gt;c2=2Etls_multi-&gt;peer_info;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char *iv_acc =3D extract_var_peer_info(peer_info=
, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!iv_acc)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_len =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocols =3D pa=
rse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max_acc_len, true, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!protocols)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: IV_A=
CC peer info variable of peer is malformed&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *token =3D strtok_r(protocols, &quot;:&quot;, &amp;lasts);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_protocols =3D a=
lloc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (=
token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tls_item_in_cip=
her_list(token, c-&gt;options=2Eacc_protocols))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /* protocol is in both server and client list=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
buf_len(&amp;common_protocols) &gt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                buf_write_u8(&amp;common_protocols, &#39;:&#39=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf=
(&amp;common_protocols, &quot;%s&quot;, token);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;last=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_protocols) =3D=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &q=
uot;WARNING: No common app custom control protocol=2E&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    c-&gt;options=2Eacc_negotiated_protocols =3D string_alloc(buf_str(=
&amp;common_protocols), &amp;c-&gt;options=2Egc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_max_message_length =
=3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quo=
t;&gt;CLIENT:ACC_PROTOCOLS,%lu,protocols=3D%s,message_len=3D%d&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2E=
c2=2Emda_context=2Ecid, c-&gt;options=2Eacc_negotiated_protocols,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        max_acc_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No ne=
wline at end of file</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src=
/openvpn/acc=2Eh</span><br><span>new file mode 100644</span><br><span>index=
 0000000=2E=2Ea6112cd</span><br><span>--- /dev/null</span><br><span>+++ b/s=
rc/openvpn/acc=2Eh</span><br><span>@@ -0,0 +1,92 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
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
 write to the Free Software Foundation, Inc=2E,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method p=
arses an app custom control message and delivers it to the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * management interface=2E We leave =
reassembly of fragmented messages to the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * management interface=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param c            The context struct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buffer       Buffer containing =
the control message with ACC</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(st=
ruct context *c, const struct buffer *buffer);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct co=
ntext *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       struct tls_multi *tls_multi,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 struct tls_session *session,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                 const char *prot=
ocol, bool fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 const char *msg, bool base64);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an info message=
 from the server that contains app custom control info</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * information prior to the PUSH_REPLY t=
o be able to use app custom control</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * protocols before sending</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * In client mode only allow what we support ourselves=2E In server =
mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allow also c=
apabilities that we not support ourselves=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param capabilities      The string to parse</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param delim             The delimit=
er to use when parsing the string=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                          IV_ACC uses &quot;,&quot; as d=
elimiter while the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*                          custom-control PUSH message uses &quot; &quot; a=
s &quot;,&quot; is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*                          already used to separate different push directiv=
es</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc=
_len       Set to the maximum ACC message length</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param server            Whether we are ser=
ver or client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram gc                The gc arena to use for allocating the resulting stri=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return       =
           The resulting protocol string or NULL on error</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+parse_acc_parameters(const char *capabilities,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     const char *delim,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  int *max_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                     bool server,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                     struct gc_arena *gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Parses the IV_ACC of the peer and sets c-&gt;options=2Eacc_negotiated_=
protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to the =
common protocols of server and client and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * c-&gt;options=2Eacc_max_message_length  to the max=
imum length of the ACC message</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * support by both server and client=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * If there is no common protocol or the client does not supp=
ort any app custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* protocol c-&gt;options=2Eacc_negotiated_protocols will be set to NULL=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param mi     the client instance =
to use the set the app custom protocols=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+determin=
e_common_acc_protocols(struct multi_instance *mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/open=
vpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index b97fb7a=2E=
=2Ed9e1979 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><=
span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span>=
<br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;aut=
h_token=2Eh&quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&q=
uot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</sp=
an><br><span> </span><br><span>@@ -257,11 +258,11 @@</span><br><span>     }=
</span><br><span>     else if (buf_string_match_head_str(buf, &quot;INFO_PR=
E&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        server_pushed_info(buf, 8);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        server_pushed_info(c, buf, 8);</span><br=
><span>     }</span><br><span>     else if (buf_string_match_head_str(buf, =
&quot;INFO&quot;))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        server_pushed_info(buf, 4);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        server_pushed_info(c, buf, 4);<=
/span><br><span>     }</span><br><span>     else if (buf_string_match_head_=
str(buf, &quot;CR_RESPONSE&quot;))</span><br><span>     {</span><br><span>@=
@ -271,6 +272,10 @@</span><br><span>     {</span><br><span>         receive=
_auth_pending(c, buf);</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (buf_string_match_head_str(buf, &quot=
;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        receive_acc_m=
essage(c, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     else if (buf_string_match_head_str(buf, &quot;EXIT&q=
uot;))</span><br><span>     {</span><br><span>         receive_exit_message=
(c);</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index ac86f97=2E=2Eb4a8f1e 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -2277,6 +2277,10 @@</span><br><span>             buf_printf(&amp;=
out, &quot; aead-epoch&quot;);</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;=
options=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        buf_printf(&amp;out, &quot; custom-control %d,A:6,%s&quot;, c-&gt=
;options=2Eacc_max_message_length, c-&gt;options=2Eacc_negotiated_protocols=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span> </span><br><span>     if (BLENZ(&amp;out) &gt; strlen(header))</span>=
<br><span>     {</span><br><span>@@ -2521,6 +2525,11 @@</span><br><span>   =
      flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (c-&gt;options=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       flags |=3D OPT_P_ACC;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     return flags;</span><br><span> }</span><br><span> </span><=
br><span>@@ -2729,6 +2738,19 @@</span><br><span>         frame-&gt;tun_mtu =
=3D min_int(frame-&gt;tun_max_mtu, c-&gt;options=2Ece=2Etun_mtu);</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (found &amp; OPT_P_NCP)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: ACC protocols: %s, msg l=
en: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      c-&gt;options=2Eacc_negotiated_protocols, c-&gt;options=2Eacc_max_mes=
sage_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_CLIENT, &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   c-&gt;options=2Eacc_negotiated_protocols, c-&gt;options=2Eacc_max_messag=
e_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     return true;</span><br><=
span> }</span><br><span> </span><br><span>@@ -3350,6 +3372,7 @@</span><br><=
span>     to=2Everify_hash_depth =3D options-&gt;verify_hash_depth;</span><=
br><span>     to=2Everify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</sp=
an><br><span>     memcpy(to=2Ex509_username_field, options-&gt;x509_usernam=
e_field, sizeof(to=2Ex509_username_field));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    to=2Eacc_protocols =3D options-&gt;acc_protocol=
s;</span><br><span>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=
=2Enet_ctx =3D &amp;c-&gt;net_ctx;</span><br><span> </span><br><span>@@ -43=
04,6 +4327,25 @@</span><br><span> }</span><br><span> #endif /* ifdef TARGET=
_ANDROID */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+management_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                   struct buffer_list *input) /* ownership tran=
sferred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D a=
rg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (buffer_list_defined(inp=
ut) &amp;&amp; c-&gt;c2=2Etls_multi)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *sessio=
n =3D &amp;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct options *opt =3D &amp;c-&gt;options;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_messa=
ge(c, multi, session, opt-&gt;acc_negotiated_protocols, input);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buffer_list_free(input);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</sp=
an><br><span> </span><br><span> void</span><br><span>@@ -4320,6 +4362,7 @@<=
/span><br><span>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;<=
/span><br><span>         cb=2Eremote_cmd =3D management_callback_remote_cmd=
;</span><br><span>         cb=2Esend_cc_message =3D management_callback_sen=
d_cc_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cb=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDRO=
ID</span><br><span>         cb=2Enetwork_change =3D management_callback_net=
work_change;</span><br><span> #endif</span><br><span>diff --git a/src/openv=
pn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 1fa3738=2E=2Ea=
d54999 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>=
+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -44,9 +44,11 @@</span><br><=
span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;push=2Eh=
&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><=
span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #i=
nclude &quot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br=
><span> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quo=
t;</span><br><span>@@ -1081,6 +1083,35 @@</span><br><span>             }</s=
pan><br><span>             break;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;pers=
ist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                bool status =3D (*man-&gt;persist=2Ecallback=2Eclien=
t_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                                  =
                    man-&gt;connection=2Ein_extra_cid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
                              man-&gt;connection=2Ein_extra_kid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
                                        man-&gt;connection=2Ein_extra);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt=
;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                report_command_status(status, &quot;client-acc=
-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                man_co=
mmand_unsupported(&quot;client-acc-msg&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                bool status =3D (*man-&g=
t;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                                  man-&gt;connection=2Ein_extra);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;conne=
ction=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                report_command_status(status, &quot;acc-msg&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                man_command_unsuppo=
rted(&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            break;</span><br><span>         case IEC_PK_SIGN:</span><br><s=
pan>             man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><b=
r><span>             buffer_list_free(man-&gt;connection=2Eext_key_input);<=
/span><br><span>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+man_client_acc_msg(struct management *man, const char *cid_str,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   co=
nst char *kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_conn=
ection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;m=
c-&gt;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extr=
a_kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cm=
d =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp=
;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span> man_client_auth(struct management *man, const ch=
ar *cid_str, const char *kid_str, const bool extra)</span><br><span> {</spa=
n><br><span>     struct man_connection *mc =3D &amp;man-&gt;connection;</sp=
an><br><span>@@ -1759,6 +1813,17 @@</span><br><span>             man_client=
_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (streq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     els=
e if (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><s=
pan>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -3132=
,6 +3197,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> voi=
d</span><br><span> management_connection_established(struct management *man=
, struct man_def_auth_context *mdac,</span><br><span>                      =
             const struct env_set *es)</span><br><span>@@ -4372,6 +4438,62 =
@@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+management_send_acc_message(struct context *c, =
struct tls_multi *multi, struct tls_session *session,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            const char *n=
egotiated_protocols, struct buffer_list *input)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* also ensures that are enough inputs in the list to safely =
call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * buffer_l=
ist_peek without extra NULL checks */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough input lines=
 for sending acc message, &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                      &quot;missing protocol, flag and/or mess=
ages lines&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *proto_buf=
 =3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *protocol =3D string_alloc(CBSTR(proto_buf), &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list=
_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer *encodin=
g_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *encoding =3D buf_str(encoding_buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *flag =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool b64encoding =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
fragment =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while ((flag =
=3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!strcmp(flag, &quot;6&quot;))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            b64encoding =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else if (!strcmp(flag, &quot;F&quot;))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            fragment =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buffer_list_aggregate_separator(input, 10000, &quot;&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct buffer *acc_msg_buf =3D buffer_list_peek(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!negotiated_protocols || !tls_item_in_cipher_list(pr=
otocol, negotiated_protocols))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_CLIENT, &quot;protocol not in the list of negotiated protocols: =
%s&quot;, np(negotiated_protocols));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D=
 send_acc_message(c, multi, session, protocol,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                fragment, buf_cs=
tr(acc_msg_buf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                             b64encoding);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+error:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEMENT */</span><br><s=
pan> </span><br><span> #include &quot;win32=2Eh&quot;</span><br><span>diff =
--git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>ind=
ex 31577e4=2E=2E4eebf75 100644</span><br><span>--- a/src/openvpn/manage=2Eh=
</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -184,12 +1=
84,19 @@</span><br><span>     int (*n_clients)(void *arg);</span><br><span>=
     bool (*send_cc_message)(void *arg, const char *message, const char *pa=
rameter);</span><br><span>     bool (*kill_by_cid)(void *arg, const unsigne=
d long cid, const char *kill_msg);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     bool (*client_auth)(void *arg, const u=
nsigned long cid, const unsigned int mda_key_id,</span><br><span>          =
               const bool auth, const char *reason, const char *client_reas=
on,</span><br><span>                         struct buffer_list *cc_config)=
; /* ownership transferred */</span><br><span>     bool (*client_pending_au=
th)(void *arg, const unsigned long cid, const unsigned int kid,</span><br><=
span>                                 const char *extra, unsigned int timeo=
ut);</span><br><span>     char *(*get_peer_info)(void *arg, const unsigned =
long cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
(*client_acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                           const unsigned long cid,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           const u=
nsigned int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           struct buffer_list *msg);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)(void *arg,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    struct =
buffer_list *msg);</span><br><span>     bool (*proxy_cmd)(void *arg, const =
char **p);</span><br><span>     bool (*remote_cmd)(void *arg, const char **=
p);</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@ -292,13 +299,=
15 @@</span><br><span>     struct command_line *in;</span><br><span>     st=
ruct buffer_list *out;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define IEC_UNDEF          0</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_AUTH    1</span><b=
r><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIGN    3</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CERTIFICATE 4</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PK_SIGN     5</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PASSWORD    6<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_RSA_SIGN=
       3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC=
_CERTIFICATE    4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine IEC_PK_SIGN        5</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define IEC_PASSWORD       6</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</span><br><span>     =
int in_extra_cmd;</span><br><span>     struct buffer_list *in_extra;</span>=
<br><span>     unsigned long in_extra_cid;</span><br><span>@@ -503,6 +512,1=
4 @@</span><br><span> </span><br><span> void man_persist_client_stats(struc=
t management *man, struct context *c);</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC message from the in=
put buffer_list and send to the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * session identified by session and multi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct tls_session;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct tls_multi;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+management_send_acc_message(struct context *c, struct tls_multi *multi, s=
truct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            const char *negotiated_protocols, struc=
t buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT *=
/</span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/o=
penvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index dda9232=2E=
=2E26bb205 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br>=
<span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dc=
o=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quo=
t;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</s=
pan><br><span> </span><br><span>@@ -1735,8 +1736,9 @@</span><br><span>  * -=
 peer id</span><br><span>  */</span><br><span> static bool</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-multi_client_set_protocol_options(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi=
_client_set_protocol_options(struct multi_instance *mi)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *=
c =3D &amp;mi-&gt;context;</span><br><span>     struct tls_multi *tls_multi=
 =3D c-&gt;c2=2Etls_multi;</span><br><span>     const char *const peer_info=
 =3D tls_multi-&gt;peer_info;</span><br><span>     struct options *o =3D &a=
mp;c-&gt;options;</span><br><span>@@ -1795,6 +1797,13 @@</span><br><span>  =
       o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (o-&gt;acc_protocols)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* If ACC is enabled server side call to find common acc prot=
ocols,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * wi=
ll be pushed during push message */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        determine_common_acc_protocols(mi);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     /* Select cipher if client =
supports Negotiable Crypto Parameters */</span><br><span> </span><br><span>=
     /* if we have already created our key, we cannot *change* our own</spa=
n><br><span>@@ -2380,7 +2389,7 @@</span><br><span>      * peer must be adde=
d before iroutes=2E For other platforms it doesn&#39;t matter=2E */</span><=
br><span> </span><br><span>     /* authentication complete, calculate dynam=
ic client specific options */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!multi_client_set_protocol_options(&amp;mi-&gt;context))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_client_=
set_protocol_options(mi))</span><br><span>     {</span><br><span>         m=
i-&gt;context=2Ec2=2Etls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><s=
pan>     }</span><br><span>@@ -4084,6 +4093,26 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+calculate_app_control_extra(struct multi_instance *mi, struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =
=3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    determine_common_acc_protocols(mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!c-&gt;options=2Eacc_negotiated_protocols)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC: No negotiated proto=
cols&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
1024, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &qu=
ot;ACC:%d A:6 %s&quot;, c-&gt;options=2Eacc_max_message_length,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+               c-&gt;options=2E=
acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return buf_str(&amp;buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> st=
atic bool</span><br><span> management_client_pending_auth(void *arg, const =
unsigned long cid, const unsigned int mda_key_id,</span><br><span>         =
                       const char *extra, unsigned int timeout)</span><br><=
span>@@ -4094,10 +4123,22 @@</span><br><span>     if (mi)</span><br><span> =
    {</span><br><span>         struct tls_multi *multi =3D mi-&gt;context=
=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!strcmp(extra, &quot;ACC&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            extra =3D calculate_app_control_extra(mi, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(!extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span>         struct tls_session *session =3D lookup_=
session_by_mda_key_id(multi, mda_key_id);</span><br><span> </span><br><span=
>         if (!session)</span><br><span>         {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><spa=
n>             return false;</span><br><span>         }</span><br><span> </=
span><br><span>@@ -4105,6 +4146,7 @@</span><br><span>         bool ret =3D =
send_auth_pending_messages(multi, session, extra, timeout);</span><br><span=
>         reschedule_multi_process(&amp;mi-&gt;context);</span><br><span>  =
       multi_schedule_context_wakeup(m, mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>        =
 return ret;</span><br><span>     }</span><br><span>     return false;</spa=
n><br><span>@@ -4148,6 +4190,39 @@</span><br><span>     return ret;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_client=
_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                          const unsigned long cid,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          const unsigned int=
 mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                   struct buffer_list *input) /* ownership transferred */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D (struct=
 multi_context *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct multi_instance *mi =3D lookup_by_cid(m, cid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_list_defined(input))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D=
 mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct tls_session *session =3D lookup_session_by_mda=
_key_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!session)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(M_CLIENT, &quot;client session not found&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            buffer_list_free(i=
nput);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct options *opt =3D &amp=
;mi-&gt;context=2Eoptions;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =
=3D management_send_acc_message(&amp;mi-&gt;context, multi, session, opt-&g=
t;acc_negotiated_protocols, input);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buffer_list_free(input);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c char *</span><br><span> management_get_peer_info(void *arg, const unsigne=
d long cid)</span><br><span> {</span><br><span>@@ -4184,6 +4259,7 @@</span>=
<br><span>         cb=2En_clients =3D management_callback_n_clients;</span>=
<br><span>         cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br><=
span>         cb=2Eclient_auth =3D management_client_auth;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D mana=
gement_client_acc_msg;</span><br><span>         cb=2Eclient_pending_auth =
=3D management_client_pending_auth;</span><br><span>         cb=2Eget_peer_=
info =3D management_get_peer_info;</span><br><span>         cb=2Epush_updat=
e_broadcast =3D management_callback_send_push_update_broadcast;</span><br><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index d839b59=2E=2E2589942 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #include &quot;syshea=
d=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;buff=
er=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><spa=
n> #include &quot;common=2Eh&quot;</span><br><span>@@ -7133,6 +7134,28 @@</=
span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> =
        options-&gt;force_key_material_export =3D true;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (str=
eq(p[0], &quot;app-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GE=
NERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;acc_protocols =3D p[1];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (streq(p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&am=
p; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &q=
uot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(msglevel, &quot;App custom control encoding must be base64 and ascii&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;=
options-&gt;acc_max_message_length,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                              &quot;app custom message mess=
age length&quot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;acc_negotiated_protocols =3D =
p[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span>     else if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>         msg(M_WARN, &quo=
t;NOTICE: --prng option ignored (SSL library PRNG is used)&quot;);</span><b=
r><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</spa=
n><br><span>index 4cd9ef5=2E=2Ef603eb0 100644</span><br><span>--- a/src/ope=
nvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><s=
pan>@@ -712,6 +712,16 @@</span><br><span>     /* force using TLS key materi=
al export for data channel key generation */</span><br><span>     bool forc=
e_key_material_export;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /** The app custom control protocols we should ann=
ounce as supported */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *acc_protocols;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
* the protocols that are negotiated with the peer=2E As a client we</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * trust the server pus=
hed list here */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *acc_negotiated_protocols;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /** the maximum length of an ACC control channel message */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int acc_max_message_length;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   bool vlan_tagging;</span><br><span>     enum vlan_acceptable_frames vlan=
_accept;</span><br><span>     uint16_t vlan_pvid;</span><br><span>@@ -763,8=
 +773,10 @@</span><br><span> #define OPT_P_INLINE          (1u &lt;&lt; 29)=
</span><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br>=
<span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ACC             (1ull &lt;&=
lt; 32)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_=
ID | 0x0ull))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Opt=
ions allowed in the normal configuration file (vs pushed options or in ccd =
files) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OP=
T_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC=
))</span><br><span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;=
pull)</span><br><span> </span><br><span>diff --git a/src/openvpn/push=2Ec b=
/src/openvpn/push=2Ec</span><br><span>index 0e281d2=2E=2E0c75d62 100644</sp=
an><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/p=
ush=2Ec</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #include &quot;s=
yshead=2Eh&quot;</span><br><span> </span><br><span> #include &quot;push=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</sp=
an><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &q=
uot;crypto=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><b=
r><span>@@ -220,9 +222,37 @@</span><br><span> #endif</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_server_=
pushed_info_acc(struct context *c, const char **m)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int max_acc_len =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* example str=
ing to parse: ACC:1400 A:6 flower:happy */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Skip over the ACC: prefix */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    *m +=3D 4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *protocols =3D parse_acc_parameters(*m, &quot; &quo=
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
pushed_info_acc(c, &amp;m);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</=
span><br><span>     if (management)</span><br><span>@@ -284,6 +320,7 @@</sp=
an><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s=
&#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  =
* Parse the keyword for the AUTH_PENDING request</span><br><span>  * @param=
 buffer                buffer containing the keywords, the buffer&#39;s</sp=
an><br><span>@@ -440,7 +477,6 @@</span><br><span>     const char *const pee=
r_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int proto=
 =3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=
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
span><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_ut=
il=2Ec</span><br><span>index 0213041=2E=2Eeae6c35 100644</span><br><span>--=
- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=
=2Ec</span><br><span>@@ -368,4 +368,4 @@</span><br><span> </span><br><span>=
     RETURN_UPDATE_STATUS(n_sent);</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_MANAGEMENT */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MAN=
AGEMENT */</span><br><span>\ No newline at end of file</span><br><span>diff=
 --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index ae=
ec020=2E=2E73ca54c 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><=
br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span>=
<br><span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><b=
r><span> #include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &q=
uot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&qu=
ot;</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -2=
105,6 +2106,11 @@</span><br><span>                     }</span><br><span>  =
               }</span><br><span>             }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (session-&gt;opt-&gt;acc_protocols)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &quo=
t;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_prot=
ocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span>         }</span><br><span>     }</span><br><span> </span=
><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=
=2Eh</span><br><span>index 6b86bc0=2E=2E0270c23 100644</span><br><span>--- =
a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=
=2Eh</span><br><span>@@ -452,6 +452,9 @@</span><br><span>     size_t ekm_si=
ze;</span><br><span> </span><br><span>     bool dco_enabled; /**&lt; Whethe=
r keys have to be installed in DCO or not */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /** The app custom control protocols we should announce as suppor=
ted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *acc_protocols;</span><br><span> };</span><br><span> </span><br><span> /*=
* @addtogroup control_processor</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br=
><span>index 5430ecb=2E=2Ed864a8f 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam</span><br><span>@@ -103,9 +103,11 @@</span><br><span> 	@TEST_C=
FLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTION=
AL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_acc=2Ec tes=
t_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</=
span><br><span> 	mock_management=2Ec \</span><br><span> 	mock_ssl_dependenc=
ies=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ba=
se64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><=
br><span>@@ -127,6 +129,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/ru=
n_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl=
_ncp=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><span>@=
@ -375,8 +378,10 @@</span><br><span> </span><br><span> misc_testdriver_SOUR=
CES =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedule=
=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_managem=
ent=2Ec mock_management=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2E=
h  \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/ssl_util=2Ec \</span><br><span>@@ -389,6 +394,7 @@</span><br><span> 	$(=
top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/session_id=2Ec</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> push_update_msg_testdriver_=
CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/=
src/compat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</=
span><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/=
tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=
=2E=2Ecddd669 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_ma=
nagement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> =
#include &quot;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef E=
NABLE_MANAGEMENT</span><br><span>@@ -60,4 +61,4 @@</span><br><span> void</s=
pan><br><span> management_sleep(const int n)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span=
><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Eh b/test=
s/unit_tests/openvpn/mock_management=2Eh</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2Ee21aec43</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Eh</span>=
<br><span>@@ -0,0 +1,32 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVP=
N -- An application to securely tunnel IP networks</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, w=
ith support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             session authentication and key exchange,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypt=
ion, packet authentication, and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet compression=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 20=
25 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pr=
ogram is free software; you can redistribute it and/or modify</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU=
 General Public License version 2</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope th=
at it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of =
the GNU General Public License along</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  with this program; if not, write to the Free Software =
Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define MOCK_MANAGEMENT_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void init_mock_management(void);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void uninit_mock_management(void);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn=
/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependenci=
es=2Ec</span><br><span>index 112bcfd=2E=2Ec16d0cb 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -=
43,7 +43,8 @@</span><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUT=
E_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span>                =
      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERS=
IST</span><br><span>                      | OPT_P_MESSAGES | OPT_P_EXPLICIT=
_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_P=
USH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P=
_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                     | OPT_P_ACC;</span><br><span>     =
return flags;</span><br><span> }</span><br><span> </span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_=
acc=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E42a79c6</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,301 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel =
IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       over a single TCP/UDP port, with support for SSL/TLS-based</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authen=
tication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             packet encryption, packet authentication, and</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compr=
ession=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Open=
VPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  This program is free software; you can redistr=
ibute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  it under the terms of the GNU General Public License version 2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the F=
ree Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is distributed in the hope that it will be useful,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without=
 even the implied warranty of</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General P=
ublic License for more details=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 You should have received a copy of the GNU General Public License along</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program;=
 if not, write to the Free Software Foundation, Inc=2E,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bo=
ston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;c=
mocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
est_acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+char control_channel_mesage_sent[2048];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Mock functions */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_contro=
l_channel_string_dowork(struct tls_session *session,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   const =
char *str, unsigned int msglevel)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_in_range(strlen(str), 0, 2048);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    memcpy(control_channel_mesage_sent, str, strlen(str));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_re=
ply_auth_token(struct tls_multi *multi)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+auth_set_client_reason(struct tls_multi *multi, co=
nst char *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9=
JnjI3tBM&quot;                \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66=
z/notFT0cF1d60nTS&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCe=
wCTAKABrwCP&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAW=
ABQAH&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&=
quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_parse_clien=
t_messages(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABL=
E_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ski=
p();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that the messag=
es get to mock_msg */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    x_debug_level =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    management =3D (void *)0x12345678;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* contains a TLS 1=2E3 ClientHello */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg[] =3D &qu=
ot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer msg_buf;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct context c =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_mu=
lti, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&=
gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;ses=
sion[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=2Emda_context;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_=
buf, (void *)msg, sizeof(msg));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received cu=
stom app control message (protocol &#39;cck1&#39;)&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managme=
nt_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char flower_msg[] =3D &quot;ACC,flower,48,6=
,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (vo=
id *)flower_msg, sizeof(flower_msg));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_m=
sg_buf, &quot;Received custom app control message (protocol &#39;flower&#39=
;)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbS=
AAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char msg_incorrect_len[] =3D &quot;ACC=
,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9I=
g=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_set_read(&amp;msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_l=
en));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_ac=
c_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *error =3D &quot;WARNING: Received malformed cu=
stom app control channel &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        &quot;(field length 62, payload length =
64 mismatch) message &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        &quot;control message: 496e7367 496d316c 49=
6a6f67 496d5a79 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        &quot;62326369 4c434141 65475a6d 2f534a7[more=2E=
=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char msg_fragment[] =3D &quot;A=
CC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_fragment, siz=
eof(msg_fragment));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Rece=
ived custom app control message (protocol &#39;power&#39;, fragment)&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check two en=
coding present */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char flower_msg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlc=
m1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_ms=
g_two_encs, sizeof(flower_msg_two_encs));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Received malform=
ed custom app control channel (number of &quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &quot;encodings must be exactly one=
 (B64=3D1, ASCII=3D1)) message control &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &quot;message: 53534268 62534141 4945=
746c 636d3170 6443442f 2f534230 &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &quot;61475567 37372b3[more=2E=2E=2E]&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* no encoding present */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg_no_encs[] =
=3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=
=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_s=
et_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_=
message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    erro=
r =3D &quot;WARNING: Received malformed custom app control channel (number =
of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &quot;encodings must be exactly one (B64=3D0, ASCII=3D0)) message control=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;message: 53534268 62534141 4945746c 636d3170 6443442f 2f534230 &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;6=
1475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_ma=
nagment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug=
_level =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ma=
nagement =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_parse_acc_parameters(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* parameters to INFO message */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *info_acc_msg=
 =3D &quot;4096 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int max_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *protocols =3D parse_acc_parameters(info_acc_msg, &quot;=
 &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(max_len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a client =
does not accept a length longer than it supports */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(in=
fo_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* message with lower limit than our, should=
 work for client and server */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_=
parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
protocols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot;=
 &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* more enco=
dings than supported=2E Server should be okay, client should fail */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot=
;1200 A:6:B flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &qu=
ot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &a=
mp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_=
len, 1200);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D =
&quot;1400 A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quo=
t; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot=
;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
iv_acc_capabilities =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_pa=
rameters(iv_acc_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(protocols, &quot;flower:happy:power&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* too small protocol length */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =
=3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical p=
rotocol length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  info_acc_msg =3D &quot;abff A:6 flower:happy 77&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters=
(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* non-numerical protocol length */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot=
;abff A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot;,&q=
uot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_acc_common_protocols(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c=
 =3D &amp;mi=2Econtext;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    c-&gt;options=2Egc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt=
;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_mult=
i-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:p=
ower&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&g=
t;options=2Eacc_protocols =3D &quot;power:flower:star&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    determine_common_acc_protocols(&amp;mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(c-&gt;options=2Eacc_max_me=
ssage_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(c-&gt;options=2Eacc_negotiated_protocol=
s, &quot;flower:power&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_acc_send_message(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c=
 =3D &amp;mi=2Econtext;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    c-&gt;options=2Egc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt=
;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
bool ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;=
peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:pow=
er&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;=
options=2Eacc_protocols =3D &quot;power:flower:emergency&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protoc=
ols(&amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct tls_session *session =3D &amp;c-&=
gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;eme=
rgency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           &quot;EMERGENCY BROADCAST MESSAGE - THIS IS NOT =
A DRILL:&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(control_channel_mesage_sent,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        &quot;ACC,emergency,50,AF,EMERG=
ENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, sessio=
n, &quot;emergency&quot;, false,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           &quot;THE GOVERNMENT HAS ISSUED A R=
AINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(control_channel=
_mesage_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAIN=
BOW COLOURED ALERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* test a =
long message (&gt; 1000) with fragment to get the maximum header size */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char long_message[=
1200] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; 1024; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long_mes=
sage[i] =3D (char)(&#39; &#39; + (i % 95));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* la=
st char of the message is a i and then a \0 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1023], &#39;i&=
#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(long_message[1024], &#39;\0&#39;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;em=
ergency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           long_message, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t cc_len =3D strlen(control_channel_mesage_sent);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co=
ntrol_channel_mesage_sent[cc_len - 1], &#39;i&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *expected_start_cc =3D &qu=
ot;ACC,emergency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(=
control_channel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ =
No newline at end of file</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2Ea64bab5</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=
=2Eh</span><br><span>@@ -0,0 +1,35 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/=
UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             session authentication and key exchange=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket encryption, packet authentication, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is free software; you can redistribute it and/or modify</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms=
 of the GNU General Public License version 2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the F=
ree Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define TEST_ACC_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void test_acc_parse_client_messages(void **state);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_parse_acc_parameters(void **sta=
te);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_protocols(voi=
d **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_send_message(=
void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span>diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/t=
ests/unit_tests/openvpn/test_common=2Eh</span><br><span>index 8db4ea6=2E=2E=
c865142 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_common=
=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_common=2Eh</span><=
br><span>@@ -43,11 +43,13 @@</span><br><span> #define LargestIntegralType u=
intmax_t</span><br><span> #endif</span><br><span> /* redefine 2=2Ex API in =
terms of 1=2Ex API */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define CMockaValueData             LargestIntegralType</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define check_expected_uint         check=
_expected</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define expe=
ct_uint_value           expect_value</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define expect_check_data           expect_check</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define cast_ptr_to_cmocka_value(=
x) (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CMock=
aValueData                       LargestIntegralType</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define check_expected_uint              =
     check_expected</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define expect_uint_value                     expect_value</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define expect_check_data           =
          expect_check</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define cast_ptr_to_cmocka_value(x)           (x)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define assert_int_in_range(value, min, m=
ax)  assert_in_range((value), (min), (max))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define assert_uint_in_range(value, min, max) asser=
t_in_range((value), (min), (max))</span><br><span> #endif</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>ind=
ex 8d88943=2E=2Eeba4e27 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>@@ -41,10 +41,34 @@</span><br><span> #include &quot;mo=
ck_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br=
><span> #include &quot;sid_hash=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifde=
f _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &q=
uot;test_schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* extra mo=
cks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct co=
ntext *c, struct options *options, struct buffer *buf,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   uint64_t permission_m=
ask, uint64_t *option_types_found,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                   struct env_set *es, bool is_update)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_=
string(struct context *c, const char *str, msglvl_t msglevel)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    check_expected_ptr(str);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct=
 multi_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lo=
okup_by_cid(struct multi_context *m, const unsigned long cid)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return *(m-&gt;instances);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> sta=
tic void</span><br><span> test_compat_lzo_string(void **state)</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/o=
penvpn/test_ssl=2Ec</span><br><span>index 4baf8cc=2E=2Ef4841cd 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</=
span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #inclu=
de &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock function t=
o be allowed to include win32=2Ec which is required for</span><br><span>  *=
 getting the temp directory */</span><br><span> #ifdef _WIN32</span><br><sp=
an>@@ -86,6 +88,20 @@</span><br><span> {</span><br><span>     return;</span=
><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_proc=
ess(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Define a dummy dco cipher option to avoid linking=
 against all the DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * units */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+con=
st char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_su=
pported_ciphers(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot=
;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><spa=
n> /* generated using</span><br><span>  * openssl req -x509 -newkey ec -pke=
yopt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>@@ -1111,8 +11=
27,11 @@</span><br><span>         cmocka_unit_test(ssl_test_extract_last_ma=
tching_field),</span><br><span>         cmocka_unit_test(ssl_test_reject_nu=
ll_in_cert_subject),</span><br><span>         cmocka_unit_test(ssl_test_esc=
ape_rfc_2253_chars_in_subject),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        cmocka_unit_test(ssl_test_extract_peer_info)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract_peer_info),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(test_acc_parse_client_messages),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_parse_acc_parameters),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_tes=
t(test_acc_common_protocols),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_acc_send_message)</span><br><span> =
    };</span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL=
)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6d=
e86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>

</body></html>
--bCVN5Ejinos=--


--===============3755347948804108392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3755347948804108392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3755347948804108392==--

