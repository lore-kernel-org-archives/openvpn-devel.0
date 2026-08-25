Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3CFC61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=minDrBeVuAKzlE7Sz089nqplv1c9+ASwfPq85OllSAg=; b=HhI9dPacMg72BkwEd+llQ2f8bM
	2hSJ55c26NoJxw1bfPsO3BhjIXlh5owq+233KDfIkLYkzL8S7TAYMQUrVWZ0qeqJ6eg/3DaAKdUUu
	DPQ/5wtYhzQI8Vnj98HEj2X5KvE0NtTyQ+Q8O7lDnVi48iq3ZM6D5MEU87uINUnzDEaw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyuRq-0006n7-Qd;
	Tue, 25 Aug 2026 16:56:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyuRp-0006n1-HN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:56:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mVv3kWvKDQOAqD8jhfGxEuTwti9C6bV3uH1Pj6wHtik=; b=ZMV2JiyW+PqH4VqiP7odaq3DZu
 5xEmkFq30St34+UbIbleLIlSxnf/ivSCu/DWXw1iAu9yH8AFSTSoKLxhFpGIjdH51mCb6QcHF6wie
 dMP9412gVv8T6CO2y0dRnTFpJGN4CGY5067laYRKVuIfEO/z3o/E5mOGgnnkOo+vXDDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mVv3kWvKDQOAqD8jhfGxEuTwti9C6bV3uH1Pj6wHtik=; b=m
 5U0AZf5Iv0uHbu+TIPbiqzwzQy7CUjYQP2FeeuK3/HAi+O61bhS7zvgGv1MS5vYw9qSHOQITG83Fe
 aE1U2x8T/9fm16V7csHbOd7A8E6wk4R9MI+yp41XoGm6qO6GnUHoUs5rKQLBroCLNTIA+UNQxa4JC
 7HZYlGt2UqaddO8c=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyuRe-0003ef-Qn for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:56:26 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso837818466b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787676972; x=1788281772; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mVv3kWvKDQOAqD8jhfGxEuTwti9C6bV3uH1Pj6wHtik=;
 b=SPtJIpoxEBbnBaAgcCBCUL0zgC1ZyBaIJL7RwxgPT0F2TOYWEQFUpiN8449rX2vicS
 +b1aTGLxVc6jIVURVtCyuirxuOvDsfGU+VPRszEtQSF4sUIFj8XGmgw1VYSAp5EW/bgH
 UfYH9B/SjxEdifK9/tijs6tCiKkuY0yoh1YOF8Xdi4Ky/69SUvwPBuplV5hg2jD8jD1K
 pT7MsrSSsD3E+MqgESUV3AqQWuBg+yTFtayu84HO9B2GL6GPATmKupMtIHnddeaKs+m1
 S+gQJx8lxVN58jzuTpIQH0kD1vLV7JqzD4YPOCnv0Up6la3QPi02dT1anLvikNuHiC1U
 dnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787676972; x=1788281772;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mVv3kWvKDQOAqD8jhfGxEuTwti9C6bV3uH1Pj6wHtik=;
 b=o1hLU+8+oebC0suc7NXuacxIT+Zrxxt9J865CFXfph4ibZWl636W20Uvj4Dn9AHGXz
 cWYpyDZk/lEc5X+Zg516EhWrYPYCcL2hUebhF77gj6yo5waYRok7YAfKOHcnXiPOWzXP
 yaQxvmr8MOPASRz+4F0PFdsFNggqVe70mzBaIcdBvfIqJN/wdgh3bHeWia0scJg1pb4w
 J3P0VzE0SWFgW5RWcXHvPRVEiWBbLGu0lR/UiwuN2es04qPbCXfI4Oq47YTegvAwPwsA
 tZvMFIF4LU9upPH07GtQvOSVKSZesb2joKmzPU46ufweswDYWkBpdPfFZRSuRnlasBvq
 BM+g==
X-Gm-Message-State: AFuF++knz43VCETvoaj+TSx5G/pNS1Fj2c5otY8qpBcFHrl96FwdBM9U
 X48K0bGVbyFDkaQ+YcubyVVg3eZ3Za4Io4kTZ2s/+50D6KgSlamTdn/8hlpuUz0jCqwBZC7pAbX
 uRrK+Y+IrPw1W/1ATdJZCDmGqLbBczw8wBMB+GYVyv9OC1Yr0bXBqMANcTIWbN82MyMwnYJ85wI
 Vl6Fg5kQ==
X-Gm-Gg: AR+sD127DEmxT2zrd2Q42oAcxHdRZUgYKXvnwvuYv6hR6rqayMgd0TQxT09wuo9oRJ2
 qLVBO6oHb0Sj+S+Vajicvi83kqjjIdkqV/NtLX24n+WeU2kxsX4I+Kwk7PcWc9JxE3uO+BIYO3B
 AhW0X+EdvWefycWhfPCf3/a95m0aryBdThTJTUt/Z1flAtTiBXj1NN40bg8PRHiClLXr2nEM33Z
 ipeQ8d9ZtHCXoAnFVhkKhbnSxlmPefTDhASdpOXDWK53AMGuKgG89UxKs7hwoMLjLNegcIovL48
 Vi5di3rUBRKv1m5Exu532lnaA57ioS1GfzqY+7DOnf2sFTHvJkN9BOVB1VEA77slrkie5XiKjxq
 SlKm6VxJFPqSZK+n9AppaDNnOMhKuKV0Tz4DXEa3GQfrhS40pcRwHPtX9JIjXEvnBX9Fioj5BUs
 j6y5o5eHdNf7Z3VMTFFG5NjAKDWITXnOh+yUpHNZGXKCifCXhXLfwnPknzog+sph4JBBnHxAbX9
 ORoOJMI3AeFQBSOPrEkZzQk/HMk8FBtdMmJ+d5afQtTf7Cj5c/PvdVomVrF/wXSEtM/P+EMqMZe
 8LNQa1LZ3Cr/RqkkfU3qPg5LIvmtlp38jzODI9fAVpvHz9e6Z5dr/oVCIOKe3g==
X-Received: by 2002:a17:907:d0c:b0:c20:d90b:2cb1 with SMTP id
 a640c23a62f3a-c249188eadbmr3202046166b.0.1787676971135; 
 Tue, 25 Aug 2026 09:56:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef4d2sm26352566b.59.2026.08.25.09.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 09:56:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 16:55:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 5c4744b6f6002bfb2663c16fa2d8d1371446cdaa
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1974489dc63d2fb1c81dfc08a31c83fc0fa63f63-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyuRe-0003ef-Qn
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8545900966330100163=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8545900966330100163==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="quFs1NjYh+0="; charset=UTF-8

--quFs1NjYh+0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#4)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1858?usp=3Demail )


Change subject: Implement sending/rece=
iving app custom control protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Implement sending/receiving app custom control proto=
col

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-sections/c=
lient-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/Makefile=2Ea=
m
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/forward=2Ec
M s=
rc/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src=
/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M sr=
c/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_util=2Ec
M src=
/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_tests/openvpn/Ma=
kefile=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
A tests/unit_tes=
ts/openvpn/mock_management=2Eh
M tests/unit_tests/openvpn/mock_push_depende=
ncies=2Ec
A tests/unit_tests/openvpn/test_acc=2Ec
A tests/unit_tests/openvp=
n/test_acc=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/=
openvpn/test_ssl=2Ec
26 files changed, 1,342 insertions(+), 23 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/18=
58/4

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ea=
9331c2 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -424,6 +424,=
8 @@
     src/compat/compat-gettimeofday=2Ec
     src/compat/compat-strsep=
=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/=
openvpn/acc=2Eh
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     sr=
c/openvpn/base64=2Ec
@@ -560,9 +562,9 @@
     src/openvpn/ps=2Ec
     src/o=
penvpn/ps=2Eh
     src/openvpn/push=2Ec
-    src/openvpn/push_util=2Ec
    =
 src/openvpn/push=2Eh
-    src/openvpn/pushlist=2Eh
+    src/openvpn/push_u=
til=2Ec
+        src/openvpn/pushlist=2Eh
     src/openvpn/reflect_filter=
=2Ec
     src/openvpn/reflect_filter=2Eh
     src/openvpn/reliable=2Ec
@@ -=
812,7 +814,10 @@
             tests/unit_tests/openvpn/mock_management=2Ec
=
             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
           =
  tests/unit_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_te=
sts/openvpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src/=
openvpn/argv=2Ec
+            src/openvpn/auth_token=2Ec
             src/o=
penvpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             sr=
c/openvpn/crypto_mbedtls=2Ec
@@ -826,8 +831,11 @@
             src/openvpn/=
options_util=2Ec
             src/openvpn/otime=2Ec
             src/openvp=
n/packet_id=2Ec
+            src/openvpn/reliable=2Ec
+            src/open=
vpn/session_id=2Ec
             src/openvpn/run_command=2Ec
             sr=
c/openvpn/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
            =
 src/openvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
        =
     src/openvpn/ssl_verify_mbedtls=2Ec
@@ -844,6 +852,8 @@
     target_sou=
rces(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random=2E=
c
         tests/unit_tests/openvpn/test_schedule=2Ec
+        tests/unit_t=
ests/openvpn/mock_management=2Ec
+        src/openvpn/base64=2Ec
         s=
rc/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/ope=
nvpn/ssl_util=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/doc/=
man-sections/client-options=2Erst
index 87c138a=2E=2E89ba7cf 100644
--- a/d=
oc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=
=2Erst
@@ -12,6 +12,17 @@
   When this option is set, OpenVPN will not drop=
 incoming tun packets with
   same destination as host=2E
 
+--app-custom-c=
ontrol protocollist
+  Sets the list of supported app custom control protoc=
ols=2E
+  These protocols are announced to the server when this option is u=
sed
+  as a client=2E If the option is set on a server it will negotiate th=
e
+  common protocols with the client=2E
+
+  The protocollist is a : separ=
ated list of protocol identifiers=2E
+
+  See management-notes=2Etxt in the=
 OpenVPN distribution  and the OpenVPN RFC
+  draft for a description of ap=
p custom control protocol support=2E
+
 --auth-token token
   This is not a=
n option to be used directly in any configuration files,
   but rather push=
 this option from a ``--client-connect`` script or a
diff --git a/doc/manag=
ement-notes=2Etxt b/doc/management-notes=2Etxt
index d6b3fbb=2E=2Eb2dcc0a 1=
00644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ =
-798,6 +798,56 @@
 The client should return the response to the crtext chal=
lenge
 using the cr-response command=2E
 
+app custom control
+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is =
passed as {EXTRA} OpenVPN will determine
+the common app custom protocols b=
etween the client and the sever and insruct
+the client that the server wil=
l send control messages to the client using
+the ACC protocol=2E
+
+The ser=
ver should then use acc-msg command to send app custom control messages
+to=
 the client to faciliate the pending authentication=2E
+
+COMMAND -- client=
-acc-msg (OpenVPN 2=2E8 or higher)
+---------------------------------------=
---
+
+This commands sends an app custom control message to a client,
+the =
format of the command is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  =
{flags}
+  {message}
+  END
+
+CID,KID -- client ID and Key ID=2E  See docu=
mentation for ">CLIENT:"
+notification for more info=2E
+
+protocol -- the =
ACC protocol identified that this message should be
+            tagged wit=
h=2E
+
+flags    -- a colon seperated list of the encoding and the flag if
=
+            the message is a fragment=2E E=2Eg=2E "6:F" for a base64 encod=
ed
+            message that is also a fragment and not complete yet=2E
+
+=
message  -- The message encoded in the encoding specified in flags
+
+
+COM=
MAND -- acc-msg (OpenVPN 2=2E8 or higher)
+--------------------------------=
----------
+
+This commands sends an app custom command to the peer, the fo=
rmat of the
+command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {message}
=
+  END
+
+See the client-acc-msg command for more details about the format =
of the message=2E
+
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)
 -=
----------------------------------------------
 
@@ -1247,6 +1297,23 @@
   =
 response=2E Mechanisms that need multiple rounds or more complex answers
 =
   should implement a different response type than CR_RESPONSE=2E
 
+(6) Ap=
p custom control message
+
+    This message is an application specific pay=
load message that is transported
+    over the OpenVPN control channel=2E
+=

+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{protocol},{fragment},=
{msg_base64}
+
+    In client mode:
+
+    >ACC:{protocol},{fragment},{msg_=
base64}
+
+    The protocol is a short ascii string identifying the app spe=
cific custom
+    protocol and identifies the protocol=2E If fragment is se=
t to 1, the message
+    is not complete and the next message should be con=
catenated to this message
+    to form a complete message=2E
 
 Variables:
=
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index =
7fd12b4=2E=2Ede7a5e7 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openv=
pn/Makefile=2Eam
@@ -42,6 +42,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SO=
URCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth=
_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -121,7 +122,8 @@
 	proto=2Ec prot=
o=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec =
push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 	refle=
ct_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --git=
 a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 100644
index 000=
0000=2E=2Ea5d6641
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,402 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright=
 (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is fr=
ee software; you can redistribute it and/or modify
+ *  it under the terms =
of the GNU General Public License version 2
+ *  as published by the Free S=
oftware Foundation=2E
+ *
+ *  This program is distributed in the hope that=
 it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  S=
ee the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sho=
uld have received a copy of the GNU General Public License along
+ *  with =
this program; if not, write to the Free Software Foundation, Inc=2E,
+ *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef=
 HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+=
#include <string=2Eh>
+#include "buffer=2Eh"
+#include "error=2Eh"
+#includ=
e "acc=2Eh"
+#include "forward=2Eh"
+#include "options_util=2Eh"
+#include =
"ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+
+enum acc_message_flag
+{
+    ACC=
_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_M=
ESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+log_acc_message(struct c=
ontext *c, const struct buffer *buf, int payload_len,
+                cons=
t char *protocol, int flags)
+{
+    bool fragment =3D flags & ACC_MESSAGE_=
FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =3D gc_ne=
w();
+    const char *payload_msg =3D NULL;
+
+    /* For simplicity, we al=
ways encode payload to be base64 encoded
+     * if not already in base64 f=
ormat */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        char *b6=
4out =3D NULL;
+        ASSERT(openvpn_base64_encode(BPTR(buf), payload_len=
, &b64out) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
+        pay=
load_msg =3D b64out;
+    }
+    else
+    {
+        payload_msg =3D BSTR(=
buf);
+    }
+
+    if (management)
+    {
+        struct tls_session *ses=
sion =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        struct man_def_=
auth_context *mda =3D session->opt->mda_context;
+        if (c->options=2E=
mode =3D=3D MODE_SERVER)
+        {
+            /* server mode=2E Report c=
lient context */
+            unsigned int mda_key_id =3D get_primary_key(c=
->c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,=
%u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol, fragment, pa=
yload_msg);
+        }
+        else
+        {
+            /* Client mode=
=2E Do not a report a CLIENT id */
+            msg(M_CLIENT, ">ACC:%s,%d,%=
s", protocol, fragment, payload_msg);
+        }
+    }
+    gc_free(&gc);
=
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Received custom app=
 control message (protocol '%s'%s)",
+        protocol, fragment ? ", fragm=
ent" : "");
+}
+
+
+/**
+ *  Parses the flags field of an app control messa=
ge and moves the
+ *  buffer past the flags string=2E If there is an
+ *  e=
rror parsing the flags field the method returns -1 and
+ *  puts the error =
reason in err_reason
+ */
+static int
+parse_acc_message_flags(struct buffe=
r *buf, const char **err_reason, struct gc_arena *gc)
+{
+    const char *f=
lags =3D extract_field(buf, ',', gc);
+
+    if (!flags)
+    {
+        *e=
rr_reason =3D "could not extract flags field";
+        return -1;
+    }
+=

+
+    int acc_flags =3D 0;
+
+    for (const char *flag =3D flags; *flag =
!=3D '\0'; flag++)
+    {
+        if (*flag =3D=3D 'A')
+        {
+      =
      acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;
+        }
+        else if (=
*flag =3D=3D '6')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_=
BASE64;
+        }
+        else if (*flag =3D=3D 'F')
+        {
+        =
    acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
+        else
+  =
      {
+            *err_reason =3D "Unknown flag in flags";
+            =
return -1;
+        }
+    }
+    /* The message should be encoded with exa=
ctly one encoding=2E Ensure that
+     * only one of the flags is present *=
/
+    bool asciienc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    =
bool base64enc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if =
(base64enc + asciienc !=3D 1)
+    {
+        char *tmp =3D gc_malloc(512, =
1, gc);
+        snprintf(tmp, 512, "number of encodings must be exactly on=
e "
+                           "(B64=3D%d, ASCII=3D%d)",
+                =
 base64enc, asciienc);
+        *err_reason =3D tmp;
+        return -1;
+ =
   }
+
+    return acc_flags;
+}
+
+
+void
+receive_acc_message(struct cont=
ext *c, const struct buffer *buffer)
+{
+    struct gc_arena gc =3D gc_new(=
);
+    const char *err_reason =3D "";
+
+    /* Example message: ACC,muppe=
ts,15,A,I am Miss Piggy */
+    struct buffer buf =3D *buffer;
+
+    if (!=
buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+   =
     err_reason =3D "missing , after ACC";
+        goto err;
+    }
+
+   =
 /* extract protocol, payload length, flags substrings */
+    char *protoc=
ol =3D extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
+        e=
rr_reason =3D "could not extract protocol field";
+        goto err;
+    }=

+
+    int payload_len =3D 0;
+    if (!buffer_read_int(&buf, &payload_len=
))
+    {
+        err_reason =3D "could not extract payload length field";=

+        goto err;
+    }
+
+    /* comma after the length */
+    if (buf=
_read_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "missing , after pa=
yload len";
+        goto err;
+    }
+
+    int flags =3D parse_acc_messag=
e_flags(&buf, &err_reason, &gc);
+
+    if (flags < 0)
+    {
+        goto=
 err;
+    }
+
+    /* We should have a final NUL byte in the control messa=
ge buffer
+     * and thus the length of the buffer should be payload_len +=
 1 */
+    if (buf_len(&buf) !=3D payload_len + 1)
+    {
+        char *tm=
p =3D gc_malloc(512, 1, &gc);
+        snprintf(tmp, 512, "field length %d,=
 payload length %d mismatch",
+                 payload_len, buf_len(&buf) =
- 1);
+        err_reason =3D tmp;
+        goto err;
+    }
+
+
+    log_a=
cc_message(c, &buf, payload_len, protocol, flags);
+    gc_free(&gc);
+    =
return;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: Received malformed custom=
 app control channel "
+                       "(%s) message control messag=
e: %s",
+        err_reason,
+        format_hex(BPTR(&buf), BLEN(&buf), 80=
, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_acc_message(struct context *=
c,
+                 struct tls_multi *tls_multi,
+                 struct =
tls_session *session,
+                 const char *protocol, bool fragment=
,
+                 const char *msg, bool base64)
+{
+    /*
+     * length=
 of the protocol string + one ','
+     * 2 for the encoding (A or 6), pote=
ntial F (fragment), and 1 for the ',',
+     * 4 for the message size itsel=
f and one comma
+     * 1 for the comma before the message itself */
+    c=
onst size_t max_header_size =3D strlen("ACC,") + strlen(protocol) + 1 + 4 +=
 1 + 2 + 1;
+    size_t len =3D max_header_size + strlen(msg);
+
+    if (l=
en > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CLIENT, "message length (%=
zu) exceeds maximum possible message length (%d)", len, TLS_CHANNEL_BUF_SIZ=
E);
+        return false;
+    }
+
+    if ((int)len > c->options=2Eacc_ma=
x_message_length)
+    {
+        msg(M_CLIENT, "header (%zu) + message siz=
e (%zu) length (%zu) exceeds "
+                      "maximum allowed leng=
th negotiated with peer (%d)",
+            max_header_size, strlen(msg), l=
en,
+            c->options=2Eacc_max_message_length);
+        return fals=
e;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* add 1 for the fin=
al \0 */
+    struct buffer buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* E=
xample message: ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "=
ACC,%s,%zu,%s%s,%s", protocol,
+               strlen(msg),
+              =
 base64 ? "6" : "A",
+               fragment ? "F" : "",
+               m=
sg);
+
+    send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH)=
;
+    reschedule_multi_process(c);
+    gc_free(&gc);
+    return true;
+}=

+
+char *
+parse_acc_parameters(const char *capabilities,
+               =
      const char *delim,
+                     int *max_acc_len,
+         =
            bool server,
+                     struct gc_arena *gc)
+{
+   =
 char *tmp_message =3D string_alloc(capabilities, NULL);
+    char *tmp_mes=
sage_orig =3D tmp_message;
+    char *lasts =3D NULL;
+
+    const char *to=
ken =3D strtok_r(tmp_message, delim, &lasts);
+
+    int p =3D 0;
+    int =
acclen =3D 0;
+    const char *protocols =3D NULL;
+    char *ret =3D NULL;=

+
+    /* In server mode we allow more capabilities than our own, in clien=
t
+     * mode we reject if we should use capabilities that we do not suppo=
rt */
+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+ =
   while (token)
+    {
+        if (p =3D=3D 0 && !atoi_constrained(token,=
 &acclen, "ACC message length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ER=
RORS))
+        {
+            goto done;
+        }
+
+        if (p =3D=
=3D 1 && (!tls_item_in_cipher_list("A", token) || !tls_item_in_cipher_list(=
"6", token)))
+        {
+            msg(D_PUSH_ERRORS, "App custom contro=
l encoding must include base64 and ascii");
+            goto done;
+      =
  }
+
+        if (p =3D=3D 1 && !server && strcmp(token, "A:6") && strcmp(=
token, "6:A"))
+        {
+            msg(D_PUSH_ERRORS, "App custom contr=
ol encoding must exactly base64 and ascii");
+            goto done;
+     =
   }
+
+        if (p =3D=3D 2)
+        {
+            protocols =3D token=
;
+        }
+
+        if (p =3D=3D 3)
+        {
+            msg(D_PUSH_=
ERRORS, "Too many parameters for INFO ACC message/IV_ACC=2E");
+           =
 goto done;
+        }
+
+        token =3D strtok_r(NULL, delim, &lasts);
=
+        p++;
+    }
+
+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LE=
N);
+    ret =3D string_alloc(protocols, gc);
+
+done:
+    free(tmp_messag=
e_orig);
+    return ret;
+}
+
+
+void
+determine_common_acc_protocols(stru=
ct context *c)
+{
+    if (!c->options=2Eacc_protocols)
+    {
+        /* =
No app custom protocols have been configured server-side=2E */
+        ret=
urn;
+    }
+    if (c->options=2Eacc_negotiated_protocols)
+    {
+       =
 /* We already have determined the common protocols=2E Doing this
+        =
 * again would just add an extra string allocation to options->gc */
+     =
   return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    /* example=
 IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    const char *peer_info =3D c=
->c2=2Etls_multi->peer_info;
+    char *iv_acc =3D extract_var_peer_info(pe=
er_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);=

+        return;
+    }
+
+    int max_acc_len =3D 0;
+    char *protocols=
 =3D parse_acc_parameters(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if =
(!protocols)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WAR=
NING: IV_ACC peer info variable of peer is malformed");
+        return;
+ =
   }
+
+    char *lasts =3D NULL;
+    const char *token =3D strtok_r(proto=
cols, ":", &lasts);
+
+    struct buffer common_protocols =3D alloc_buf_gc(=
1024, &gc);
+
+    while (token)
+    {
+        if (tls_item_in_cipher_lis=
t(token, c->options=2Eacc_protocols))
+        {
+            /* protocol i=
s in both server and client list */
+            if (buf_len(&common_protoc=
ols) > 0)
+            {
+                buf_write_u8(&common_protocols, '=
:');
+            }
+            buf_printf(&common_protocols, "%s", token)=
;
+        }
+        token =3D strtok_r(NULL, ":", &lasts);
+    }
+
+    =
if (buf_len(&common_protocols) =3D=3D 0)
+    {
+        gc_free(&gc);
+   =
     msg(D_PUSH_DEBUG, "WARNING: No common app custom control protocol=2E")=
;
+        return;
+    }
+
+    c->options=2Eacc_negotiated_protocols =3D =
string_alloc(buf_str(&common_protocols), &c->options=2Egc);
+    c->options=
=2Eacc_max_message_length =3D max_acc_len;
+    gc_free(&gc);
+}
\ No newli=
ne at end of file
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
ne=
w file mode 100644
index 0000000=2E=2E5d9b203
--- /dev/null
+++ b/src/openv=
pn/acc=2Eh
@@ -0,0 +1,92 @@
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
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"=

+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * Thi=
s method parses an app custom control message and delivers it to the
+ * ma=
nagement interface=2E We leave reassembly of fragmented messages to the
+ *=
 management interface=2E
+ *
+ * @param c            The context struct
+ *=
 @param buffer       Buffer containing the control message with ACC
+ */
+v=
oid
+receive_acc_message(struct context *c, const struct buffer *buffer);
+=

+
+bool
+send_acc_message(struct context *c,
+                 struct tls_=
multi *tls_multi,
+                 struct tls_session *session,
+         =
        const char *protocol, bool fragment,
+                 const char *=
msg, bool base64);
+
+
+/**
+ * Parses an info message from the server that=
 contains app custom control info
+ * information prior to the PUSH_REPLY t=
o be able to use app custom control
+ * protocols before sending
+ *
+ * In=
 client mode only allow what we support ourselves=2E In server mode
+ * all=
ow also capabilities that we not support ourselves=2E
+ *
+ * @param capabi=
lities      The string to parse
+ * @param delim             The delimiter =
to use when parsing the string=2E
+ *                          IV_ACC uses =
"," as delimiter while the
+ *                          custom-control PUSH=
 message uses " " as "," is
+ *                          already used to se=
parate different push directives
+ * @param max_acc_len       Set to the ma=
ximum ACC message length
+ * @param server            Whether we are server=
 or client
+ * @param gc                The gc arena to use for allocating =
the resulting string
+ * @return                  The resulting protocol st=
ring or NULL on error
+ */
+char *
+parse_acc_parameters(const char *capabi=
lities,
+                     const char *delim,
+                     int =
*max_acc_len,
+                     bool server,
+                     stru=
ct gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets c->opti=
ons=2Eacc_negotiated_protocols
+ * to the common protocols of server and cl=
ient and
+ * c->options=2Eacc_max_message_length  to the maximum length of =
the ACC message
+ * support by both server and client=2E
+ *
+ * If there i=
s no common protocol or the client does not support any app custom
+ * prot=
ocol c->options=2Eacc_negotiated_protocols will be set to NULL=2E
+ *
+ * @=
param c     the client context to use the set the app custom protocols=2E
+=
 */
+void
+determine_common_acc_protocols(struct context *c);
+#endif
diff =
--git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 2ade321=2E=
=2E736e975 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=
=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"
 #inc=
lude "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -25=
1,11 +252,11 @@
     }
     else if (buf_string_match_head_str(buf, "INFO_P=
RE"))
     {
-        server_pushed_info(buf, 8);
+        server_pushed_in=
fo(c, buf, 8);
     }
     else if (buf_string_match_head_str(buf, "INFO"))=

     {
-        server_pushed_info(buf, 4);
+        server_pushed_info(c,=
 buf, 4);
     }
     else if (buf_string_match_head_str(buf, "CR_RESPONSE"=
))
     {
@@ -265,6 +266,10 @@
     {
         receive_auth_pending(c, buf)=
;
     }
+    else if (buf_string_match_head_str(buf, "ACC"))
+    {
+     =
   receive_acc_message(c, buf);
+    }
     else if (buf_string_match_head_=
str(buf, "EXIT"))
     {
         receive_exit_message(c);
diff --git a/src=
/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 6b53686=2E=2Ee8e3a6d 100644
=
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2283,6 +2283,10 @=
@
             buf_printf(&out, " aead-epoch");
         }
     }
+    if (=
c->options=2Eacc_negotiated_protocols)
+    {
+        buf_printf(&out, " c=
ustom-control %d,A:6,%s", c->options=2Eacc_max_message_length, c->options=
=2Eacc_negotiated_protocols);
+    }
 
     if (BLENZ(&out) > strlen(header=
))
     {
@@ -2527,6 +2531,11 @@
         flags |=3D (OPT_P_ROUTE | OPT_P_D=
HCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+    {
+        flag=
s |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -3342,6 +3351,7 @@
  =
   to=2Everify_hash_depth =3D options->verify_hash_depth;
     to=2Everify_=
hash_no_ca =3D options->verify_hash_no_ca;
     memcpy(to=2Ex509_username_f=
ield, options->x509_username_field, sizeof(to=2Ex509_username_field));
+   =
 to=2Eacc_protocols =3D options->acc_protocols;
     to=2Ees =3D c->c2=2Ees=
;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4300,6 +4310,27 @@
 }
 #endif /*=
 ifdef TARGET_ANDROID */
 
+static bool
+management_acc_msg(void *arg,
+   =
                struct buffer_list *input) /* ownership transferred */
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct context *c =3D arg;
+
+   =
 bool ret =3D true;
+    if (buffer_list_defined(input) && c->c2=2Etls_mult=
i)
+    {
+        struct tls_multi *multi =3D c->c2=2Etls_multi;
+        =
struct tls_session *session =3D &multi->session[TM_ACTIVE];
+        struct=
 options *opt =3D &c->options;
+
+        ret =3D management_send_acc_messa=
ge(c, multi, session, opt->acc_negotiated_protocols, input);
+    }
+
+    =
buffer_list_free(input);
+    gc_free(&gc);
+    return ret;
+}
 #endif /* =
ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4316,6 +4347,7 @@
         cb=2Eprox=
y_cmd =3D management_callback_proxy_cmd;
         cb=2Eremote_cmd =3D manag=
ement_callback_remote_cmd;
         cb=2Esend_cc_message =3D management_cal=
lback_send_cc_message;
+        cb=2Eacc_msg =3D management_acc_msg;
 #ifde=
f TARGET_ANDROID
         cb=2Enetwork_change =3D management_callback_netwo=
rk_change;
 #endif
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec
index 29fdffc=2E=2Eabf6f8b 100644
--- a/src/openvpn/manage=2Ec
+++ b/s=
rc/openvpn/manage=2Ec
@@ -44,8 +44,10 @@
 #include "dco=2Eh"
 #include "pus=
h=2Eh"
 #include "multi=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
+=
#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1=
080,6 +1082,35 @@
             }
             break;
 
+        case IEC_CL=
IENT_ACC_MSG:
+            if (man->persist=2Ecallback=2Eclient_acc_msg)
+ =
           {
+                bool status =3D (*man->persist=2Ecallback=2Ec=
lient_acc_msg)(man->persist=2Ecallback=2Earg,
+                            =
                                          man->connection=2Ein_extra_cid,
+=
                                                                      man->=
connection=2Ein_extra_kid,
+                                               =
                       man->connection=2Ein_extra);
+                man->c=
onnection=2Ein_extra =3D NULL;
+                report_command_status(statu=
s, "client-acc-msg");
+            }
+            else
+            {
+    =
            man_command_unsupported("client-acc-msg");
+            }
+    =
        break;
+
+        case IEC_ACC_MSG:
+            if (man->persist=
=2Ecallback=2Eacc_msg)
+            {
+                bool status =3D (*ma=
n->persist=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+          =
                                                     man->connection=2Ein_e=
xtra);
+                man->connection=2Ein_extra =3D NULL;
+             =
   report_command_status(status, "acc-msg");
+            }
+            el=
se
+            {
+                man_command_unsupported("acc-msg");
+   =
         }
+            break;
         case IEC_PK_SIGN:
             man-=
>connection=2Eext_key_state =3D EKS_READY;
             buffer_list_free(ma=
n->connection=2Eext_key_input);
@@ -1204,6 +1235,29 @@
 }
 
 static void
+m=
an_client_acc_msg(struct management *man, const char *cid_str,
+           =
        const char *kid_str)
+{
+    struct man_connection *mc =3D &man->co=
nnection;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
+    if=
 (parse_cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_str, "KI=
D", &mc->in_extra_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLIENT_ACC=
_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void
+man_a=
cc_msg(struct management *man)
+{
+    struct man_connection *mc =3D &man->=
connection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_reset(mc, =
IER_NEW);
+}
+
+static void
 man_client_auth(struct management *man, const =
char *cid_str, const char *kid_str, const bool extra)
 {
     struct man_co=
nnection *mc =3D &man->connection;
@@ -1760,6 +1814,17 @@
             man_=
client_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
+    el=
se if (streq(p[0], "client-acc-msg"))
+    {
+        if (man_need(man, p, =
2, 0))
+        {
+            man_client_acc_msg(man, p[1], p[2]);
+      =
  }
+    }
+    else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_ms=
g(man);
+    }
     else if (streq(p[0], "rsa-sig"))
     {
         man_pk=
_sig(man, "rsa-sig");
@@ -3131,6 +3196,7 @@
     }
 }
 
+
 void
 management=
_connection_established(struct management *management, struct man_def_auth_=
context *mdac,
                                   const struct env_set *es)=

@@ -4362,6 +4428,62 @@
     }
 }
 
+bool
+management_send_acc_message(stru=
ct context *c, struct tls_multi *multi, struct tls_session *session,
+     =
                       const char *negotiated_protocols, struct buffer_list=
 *input)
+{
+    /* also ensures that are enough inputs in the list to safe=
ly call
+     * buffer_list_peek without extra NULL checks */
+    if (!inp=
ut || input->size < 3)
+    {
+        msg(M_CLIENT, "not enough input line=
s for sending acc message, "
+                      "missing protocol, flag=
 and/or messages lines");
+        return false;
+    }
+
+    struct gc_ar=
ena gc =3D gc_new();
+
+    const struct buffer *proto_buf =3D buffer_list_=
peek(input);
+    const char *protocol =3D string_alloc(BSTR(proto_buf), &g=
c);
+    buffer_list_pop(input);
+
+    const struct buffer *encoding_buf =
=3D buffer_list_peek(input);
+    char *encoding =3D buf_str(encoding_buf);=

+    char *flag =3D NULL;
+    bool b64encoding =3D false;
+    bool fragm=
ent =3D false;
+
+    while ((flag =3D strsep(&encoding, ":")))
+    {
+   =
     if (!strcmp(flag, "6"))
+        {
+            b64encoding =3D true;
=
+        }
+        else if (!strcmp(flag, "F"))
+        {
+            fr=
agment =3D true;
+        }
+    }
+    buffer_list_pop(input);
+
+    buff=
er_list_aggregate_separator(input, 10000, "");
+    const struct buffer *ac=
c_msg_buf =3D buffer_list_peek(input);
+
+    if (!negotiated_protocols || =
!tls_item_in_cipher_list(protocol, negotiated_protocols))
+    {
+        m=
sg(M_CLIENT, "protocol not in the list of negotiated protocols: %s", np(neg=
otiated_protocols));
+        goto error;
+    }
+
+    bool ret =3D send_a=
cc_message(c, multi, session, protocol,
+                                fr=
agment, buf_str(acc_msg_buf),
+                                b64encoding)=
;
+    gc_free(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    retur=
n false;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
di=
ff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index f752fec=2E=
=2Ede9303b 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh=

@@ -184,12 +184,19 @@
     int (*n_clients)(void *arg);
     bool (*send_c=
c_message)(void *arg, const char *message, const char *parameter);
     boo=
l (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);=

+
     bool (*client_auth)(void *arg, const unsigned long cid, const unsig=
ned int mda_key_id,
                         const bool auth, const char *r=
eason, const char *client_reason,
                         struct buffer_li=
st *cc_config); /* ownership transferred */
     bool (*client_pending_auth=
)(void *arg, const unsigned long cid, const unsigned int kid,
             =
                    const char *extra, unsigned int timeout);
     char *(*=
get_peer_info)(void *arg, const unsigned long cid);
+    bool (*client_acc_=
msg)(void *arg,
+                           const unsigned long cid,
+     =
                      const unsigned int mda_key_id,
+                     =
      struct buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+          =
          struct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, const=
 char **p);
     bool (*remote_cmd)(void *arg, const char **p);
 #ifdef TAR=
GET_ANDROID
@@ -292,13 +299,15 @@
     struct command_line *in;
     struct=
 buffer_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
=
+#define IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC=
_CLIENT_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC=
_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#defi=
ne IEC_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN =
       5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#defi=
ne IEC_ACC_MSG        8
     int in_extra_cmd;
     struct buffer_list *in_=
extra;
     unsigned long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_pe=
rsist_client_stats(struct management *man, struct context *c);
 
+/** Parse=
s the ACC message from the input buffer_list and send to the
+ * session id=
entified by session and multi
+ */
+struct tls_session;
+struct tls_multi;
=
+bool
+management_send_acc_message(struct context *c, struct tls_multi *mul=
ti, struct tls_session *session,
+                            const char *n=
egotiated_protocols, struct buffer_list *input);
 #endif /* ifdef ENABLE_MA=
NAGEMENT */
 
 /**
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index 8342d16=2E=2Eb444433 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -52,6 +52,7 @@
 #include "ssl_util=2Eh"
 #include "d=
co=2Eh"
 #include "reflect_filter=2Eh"
+#include "acc=2Eh"
 
 /*#define MUL=
TI_DEBUG_EVENT_LOOP*/
 
@@ -1773,6 +1774,13 @@
         o->imported_protoco=
l_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }
 
+    if (o->acc_protocols)
+  =
  {
+        /* If ACC is enabled server side call to find common acc proto=
cols,
+         * will be pushed during push message */
+        determine_=
common_acc_protocols(c);
+    }
+
     /* Select cipher if client supports =
Negotiable Crypto Parameters */
 
     /* if we have already created our ke=
y, we cannot *change* our own
@@ -4032,6 +4040,24 @@
     }
 }
 
+static co=
nst char *
+calculate_app_control_extra(struct context *c, struct gc_arena =
*gc)
+{
+    determine_common_acc_protocols(c);
+
+    if (!c->options=2Eac=
c_negotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negotiated p=
rotocols");
+        return NULL;
+    }
+
+    struct buffer buf =3D alloc=
_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", c->options=2Eac=
c_max_message_length, c->options=2Eacc_negotiated_protocols);
+    return b=
uf_str(&buf);
+}
+
+
 static bool
 management_client_pending_auth(void *arg=
, const unsigned long cid, const unsigned int mda_key_id,
                 =
               const char *extra, unsigned int timeout)
@@ -4042,17 +4068,3=
0 @@
     if (mi)
     {
         struct tls_multi *multi =3D mi->context=
=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new();
+        if =
(!strcmp(extra, "ACC"))
+        {
+            extra =3D calculate_app_con=
trol_extra(&mi->context, &gc);
+            if (!extra)
+            {
+   =
             gc_free(&gc);
+                return false;
+            }
+ =
       }
         struct tls_session *session =3D lookup_session_by_mda_key=
_id(multi, mda_key_id);
 
         if (!session)
         {
+            gc=
_free(&gc);
             return false;
         }
-        
+
         /* s=
ends INFO_PRE and AUTH_PENDING messages to client */
         bool ret =3D =
send_auth_pending_messages(multi, session, extra, timeout);
         resche=
dule_multi_process(&mi->context);
         multi_schedule_context_wakeup(m,=
 mi);
+        gc_free(&gc);
         return ret;
     }
     return false;=

@@ -4096,6 +4135,39 @@
     return ret;
 }
 
+
+static bool
+management_cl=
ient_acc_msg(void *arg,
+                          const unsigned long cid,=

+                          const unsigned int mda_key_id,
+               =
           struct buffer_list *input) /* ownership transferred */
+{
+    s=
truct multi_context *m =3D (struct multi_context *)arg;
+    struct multi_i=
nstance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+    if (=
mi && buffer_list_defined(input))
+    {
+        struct tls_multi *multi =
=3D mi->context=2Ec2=2Etls_multi;
+        struct tls_session *session =3D =
lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (!session)
+  =
      {
+            msg(M_CLIENT, "client session not found");
+          =
  buffer_list_free(input);
+            return false;
+        }
+
+       =
 struct options *opt =3D &mi->context=2Eoptions;
+
+        ret =3D managem=
ent_send_acc_message(&mi->context, multi, session, opt->acc_negotiated_prot=
ocols, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+   =
 buffer_list_free(input);
+    return ret;
+}
+
+
 static char *
 managemen=
t_get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4132,6 +4204,7 @=
@
         cb=2En_clients =3D management_callback_n_clients;
         cb=2E=
kill_by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth =3D manag=
ement_client_auth;
+        cb=2Eclient_acc_msg =3D management_client_acc_m=
sg;
         cb=2Eclient_pending_auth =3D management_client_pending_auth;
 =
        cb=2Eget_peer_info =3D management_get_peer_info;
         cb=2Epush=
_update_broadcast =3D management_callback_send_push_update_broadcast;
diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 178b5f6=2E=
=2E27540e7 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #in=
clude "buffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -7100,6 =
+7101,28 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->fo=
rce_key_material_export =3D true;
     }
+    else if (streq(p[0], "app-cus=
tom-control") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GEN=
ERAL);
+        options->acc_protocols =3D p[1];
+    }
+    else if (streq=
(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+        =
VERIFY_PERMISSION(OPT_P_ACC);
+
+        if (!streq(p[2], "A:6") && !streq(=
p[2], "6:A"))
+        {
+            msg(msglevel, "App custom control enc=
oding must be base64 and ascii");
+            goto err;
+        }
+
+    =
    if (!atoi_constrained(p[1], &options->acc_max_message_length,
+        =
                      "app custom message message length", ACC_MIN_MSG_LEN,=
 ACC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
+        }
+=
        options->acc_negotiated_protocols =3D p[3];
+    }
     else if (st=
req(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: --=
prng option ignored (SSL library PRNG is used)");
diff --git a/src/openvpn/=
options=2Eh b/src/openvpn/options=2Eh
index 131513e=2E=2Eef4f1fe 100644
---=
 a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -711,6 +711,16 =
@@
     /* force using TLS key material export for data channel key generat=
ion */
     bool force_key_material_export;
 
+    /** The app custom contr=
ol protocols we should announce as supported */
+    const char *acc_protoc=
ols;
+
+    /** the protocols that are negotiated with the peer=2E As a cli=
ent we
+     * trust the server pushed list here */
+    const char *acc_ne=
gotiated_protocols;
+
+    /** the maximum length of an ACC control channel=
 message */
+    int acc_max_message_length;
+
     bool vlan_tagging;
    =
 enum vlan_acceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -762,=
8 +772,10 @@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_=
MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OP=
T_P_ACC             (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE=
 | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the no=
rmal configuration file (vs pushed options or in ccd files) */
+#define OPT=
_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC)=
)
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/pus=
h=2Ec b/src/openvpn/push=2Ec
index fa7bf1e=2E=2E12068b5 100644
--- a/src/op=
envpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "sysh=
ead=2Eh"
 
 #include "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2E=
h"
 #include "crypto=2Eh"
 #include "ssl=2Eh"
@@ -220,9 +222,8 @@
 #endif
 =
}
 
-
 void
-server_pushed_info(const struct buffer *buffer, const int adv)=

+server_pushed_info(struct context *c, const struct buffer *buffer, const =
int adv)
 {
     const char *m =3D "";
     struct buffer buf =3D *buffer;
=
@@ -232,6 +233,27 @@
         m =3D BSTR(&buf);
     }
 
+    if (strncmp(m=
, "ACC:", 4) =3D=3D 0)
+    {
+        int max_acc_len =3D 0;
+
+
+        =
/* example string to parse: ACC:1400 A:6 flower:happy */
+        /* Skip o=
ver the ACC: prefix */
+        m +=3D 4;
+
+        char *protocols =3D pa=
rse_acc_parameters(m, " ", &max_acc_len, false, &c->options=2Egc);
+       =
 if (protocols)
+        {
+            c->options=2Eacc_negotiated_protoco=
ls =3D protocols;
+            c->options=2Eacc_max_message_length =3D max_=
acc_len;
+        }
+        else
+        {
+            msg(D_PUSH_ERRORS=
, "WARNING: Received ACC info command with invalid parameters");
+        }=

+    }
+
 #ifdef ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (manag=
ement)
@@ -284,6 +306,7 @@
     msg(D_PUSH, "CR response was sent by client=
 ('%s')", m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING reques=
t
  * @param buffer                buffer containing the keywords, the buff=
er's
@@ -440,7 +463,6 @@
     const char *const peer_info =3D tls_multi->pe=
er_info;
     unsigned int proto =3D extract_iv_proto(peer_info);
 
-
     =
/* Calculate the maximum timeout and subtract the time we already waited */=

     unsigned int max_timeout =3D
         max_uint(tls_multi->opt=2Ereneg=
otiate_seconds / 2, tls_multi->opt=2Ehandshake_window);
@@ -731,6 +753,11 @=
@
                 client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
     =
    }
     }
+
+    if (c->options=2Eacc_negotiated_protocols)
+    {
+    =
    push_option_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s", c->=
options=2Eacc_max_message_length, c->options=2Eacc_negotiated_protocols);
+=
    }
 }
 
 #if defined(__GNUC__) || defined(__clang__)
diff --git a/src/op=
envpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E3aca8a7 100644
---=
 a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int=
 process_incoming_push_request(struct context *c);
 
+
 /**
  * @brief Hand=
les the receiving of a push-update message and applies updates to the speci=
fied
  * options=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_message(struct c=
ontext *c);
 
-void server_pushed_info(const struct buffer *buffer, const i=
nt adv);
+void server_pushed_info(struct context *c, const struct buffer *b=
uffer, const int adv);
 
 void receive_cr_response(struct context *c, const=
 struct buffer *buffer);
 
diff --git a/src/openvpn/push_util=2Ec b/src/ope=
nvpn/push_util=2Ec
index fcc5411=2E=2E6462a97 100644
--- a/src/openvpn/push=
_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -370,4 +370,4 @@
 
     RETURN=
_UPDATE_STATUS(n_sent);
 }
-#endif /* ifdef ENABLE_MANAGEMENT */
+#endif /*=
 ifdef ENABLE_MANAGEMENT */
\ No newline at end of file
diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 5f5d1f9=2E=2Ea5663e3 100644
--- a=
/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #includ=
e "crypto_epoch=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl=
_verify=2Eh"
 #include "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -2054,6=
 +2055,11 @@
                     }
                 }
             }
+
+  =
          if (session->opt->acc_protocols)
+            {
+                =
buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc=
_protocols);
+            }
         }
     }
 
diff --git a/src/openvpn/ss=
l_common=2Eh b/src/openvpn/ssl_common=2Eh
index db61198=2E=2E3b326a7 100644=

--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -452,=
6 +452,9 @@
     size_t ekm_size;
 
     bool dco_enabled; /**< Whether key=
s have to be installed in DCO or not */
+
+    /** The app custom control p=
rotocols we should announce as supported */
+    const char *acc_protocols;=

 };
 
 /** @addtogroup control_processor
diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=
=2E=2E753e59d 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tes=
ts/unit_tests/openvpn/Makefile=2Eam
@@ -103,9 +103,11 @@
 	@TEST_CFLAGS@
 s=
sl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_test=
driver_SOURCES =3D test_ssl=2Ec \
+    test_acc=2Ec test_acc=2Eh \
 	mock_m=
sg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_de=
pendencies=2Ec mock_win32_execve=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec =
\
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=
=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -127,6 +129,7 @@
 	$(top=
_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_open=
ssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src=
/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_s=
rcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl=
_verify_openssl=2Ec \
@@ -375,8 +378,10 @@
 
 misc_testdriver_SOURCES =3D t=
est_misc=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
+	mock_management=2E=
c mock_management=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=
=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn=
/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcdir=
)/src/openvpn/ssl_util=2Ec \
@@ -388,6 +393,7 @@
 	$(top_srcdir)/src/openvp=
n/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
+
 push=
_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_s=
rcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
diff --git=
 a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/=
mock_management=2Ec
index 77f6ce2=2E=2Ecddd669 100644
--- a/tests/unit_test=
s/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_managemen=
t=2Ec
@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
=
 #include "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
@@ -60,4 +61,4 @@
 void
=
 management_sleep(const int n)
 {
-}
+}
\ No newline at end of file
diff --=
git a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/unit_tests/openv=
pn/mock_management=2Eh
new file mode 100644
index 0000000=2E=2Ee21aec43
---=
 /dev/null
+++ b/tests/unit_tests/openvpn/mock_management=2Eh
@@ -0,0 +1,32=
 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *  =
           over a single TCP/UDP port, with support for SSL/TLS-based
+ *  =
           session authentication and key exchange,
+ *             packet =
encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copy=
right (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program =
is free software; you can redistribute it and/or modify
+ *  it under the t=
erms of the GNU General Public License version 2
+ *  as published by the F=
ree Software Foundation=2E
+ *
+ *  This program is distributed in the hope=
 that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, write to the Free Software Foundation, Inc=2E,
=
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+=
#ifndef MOCK_MANAGEMENT_H
+#define MOCK_MANAGEMENT_H
+void init_mock_manage=
ment(void);
+
+void uninit_mock_management(void);
+
+#endif
diff --git a/te=
sts/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvp=
n/mock_push_dependencies=2Ec
index 112bcfd=2E=2Ec16d0cb 100644
--- a/tests/=
unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvp=
n/mock_push_dependencies=2Ec
@@ -43,7 +43,8 @@
     uint64_t flags =3D OPT_=
P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
               =
       | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PER=
SIST
                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P=
_ECHO | OPT_P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP |=
 OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+                     | OPT_=
P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+     =
                | OPT_P_ACC;
     return flags;
 }
 
diff --git a/tests/uni=
t_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
new fi=
le mode 100644
index 0000000=2E=2Ed73547e
--- /dev/null
+++ b/tests/unit_te=
sts/openvpn/test_acc=2Ec
@@ -0,0 +1,297 @@
+/*
+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks
+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVP=
N Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2=
549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistribute=
 it and/or modify
+ *  it under the terms of the GNU General Public License=
 version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Th=
is program is distributed in the hope that it will be useful,
+ *  but WITH=
OUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY=
 or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Li=
cense for more details=2E
+ *
+ *  You should have received a copy of the G=
NU General Public License along
+ *  with this program; if not, write to th=
e Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <=
stdlib=2Eh>
+#include <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=
=2Eh>
+#include <cmocka=2Eh>
+
+#include "acc=2Eh"
+#include "test_acc=2Eh"=

+
+#include "mock_msg=2Eh"
+
+char control_channel_mesage_sent[2048];
+
+/=
* Mock functions */
+bool
+send_control_channel_string_dowork(struct tls_se=
ssion *session,
+                                   const char *str, int ms=
glevel)
+{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    memcpy(co=
ntrol_channel_mesage_sent, str, strlen(str));
+    return true;
+}
+
+void
=
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_se=
t_client_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#defi=
ne MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+=
                    "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS=
" \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKA=
BrwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQI=
ACgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0A=
MAAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGA=
QMDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdAC=
Ck4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=
=3D"
+
+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENAB=
LE_MANAGEMENT
+    skip();
+#else
+    /* ensure that the messages get to m=
ock_msg */
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678=
;
+    struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 Clie=
ntHello */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    =
struct buffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=2E=
mode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct =
tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=
=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->=
mda_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void *)=
msg, sizeof(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    assert_st=
ring_equal(mock_msg_buf, "Received custom app control message (protocol 'cc=
k1')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,=
0," MSG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhb=
SAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_bu=
f, (void *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &m=
sg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app contro=
l message (protocol 'flower')");
+    assert_string_equal(mock_managment_bu=
f, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=
=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    const char msg_incorrect_l=
en[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAA=
S2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_le=
n, sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+   =
 const char *error =3D "WARNING: Received malformed custom app control chan=
nel "
+                        "(field length 62, payload length 64 mismatc=
h) message "
+                        "control message: 496e7367 496d316c 4=
96a6f67 496d5a79 "
+                        "62326369 4c434141 65475a6d 2f5=
34a7[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+   =
 assert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment_b=
uf);
+    const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";=

+    buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));
+=
    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_bu=
f, "Received custom app control message (protocol 'power', fragment)");
+  =
  assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8g=
dw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding pr=
esent */
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbS=
AAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf=
, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive_a=
cc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed cus=
tom app control channel (number of "
+            "encodings must be exactl=
y one (B64=3D1, ASCII=3D1)) message control "
+            "message: 535342=
68 62534141 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 37=
372b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    =
assert_string_equal(mock_managment_buf, "");
+
+    /* no encoding present =
*/
+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlcm1=
pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *=
)flower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_message(=
&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom app con=
trol channel (number of "
+            "encodings must be exactly one (B64=
=3D0, ASCII=3D0)) message control "
+            "message: 53534268 6253414=
1 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[more=
=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_str=
ing_equal(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    managem=
ent =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_paramet=
ers(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* paramete=
rs to INFO message */
+    const char *info_acc_msg =3D "4096 A:6 flower:ha=
ppy";
+
+    int max_len =3D 0;
+    const char *protocols =3D parse_acc_pa=
rameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(=
protocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /*=
 a client does not accept a length longer than it supports */
+    protocol=
s =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    a=
ssert_null(protocols);
+
+    /* message with lower limit than our, should =
work for client and server */
+    info_acc_msg =3D "1111 A:6 flower:happy"=
;
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, fals=
e, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_i=
nt_equal(max_len, 1111);
+
+    protocols =3D parse_acc_parameters(info_acc=
_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flowe=
r:happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more encodings t=
han supported=2E Server should be okay, client should fail */
+    info_acc=
_msg =3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc_parameters=
(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+=
    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &=
gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_e=
qual(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg =3D "14=
00 A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_m=
sg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    protocol=
s =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    a=
ssert_null(protocols);
+
+
+    const char *iv_acc_capabilities =3D "1400,A=
:6,flower:happy:power";
+    protocols =3D parse_acc_parameters(iv_acc_capa=
bilities, ",", &max_len, true, &gc);
+    assert_string_equal(protocols, "f=
lower:happy:power");
+
+    /* too small protocol length */
+    info_acc_m=
sg =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_=
acc_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* =
non-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flower:hap=
py 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &max_len=
, true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical protocol=
 length */
+    info_acc_msg =3D "abff A:6 flower:happy 77";
+    protocols=
 =3D parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+    ass=
ert_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_proto=
cols(void **state)
+{
+    struct context c =3D { 0 };
+    c=2Eoptions=2Eg=
c =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_mu=
lti, &c=2Eoptions=2Egc);
+
+    c=2Ec2=2Etls_multi->peer_info =3D "IV_PROTO=
=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c=2Eoptions=2Eacc_prot=
ocols =3D "power:flower:star";
+
+    determine_common_acc_protocols(&c);
+=

+    assert_int_equal(c=2Eoptions=2Eacc_max_message_length, ACC_MAX_MSG_LE=
N);
+    assert_string_equal(c=2Eoptions=2Eacc_negotiated_protocols, "flowe=
r:power");
+
+    gc_free(&c=2Eoptions=2Egc);
+}
+
+void
+test_acc_send_mes=
sage(void **state)
+{
+    struct context c =3D { 0 };
+    c=2Eoptions=2Eg=
c =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_mu=
lti, &c=2Eoptions=2Egc);
+    bool ret;
+
+    c=2Ec2=2Etls_multi->peer_inf=
o =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power";
+    c=
=2Eoptions=2Eacc_protocols =3D "power:flower:emergency";
+    determine_com=
mon_acc_protocols(&c);
+
+
+    struct tls_session *session =3D &c=2Ec2=2Et=
ls_multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_message(&c, c=2Ec2=2E=
tls_multi, session, "emergency", true,
+                           "EMERGEN=
CY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    assert_true(re=
t);
+    assert_string_equal(control_channel_mesage_sent,
+                =
        "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DR=
ILL:");
+
+    ret =3D send_acc_message(&c, c=2Ec2=2Etls_multi, session, "e=
mergency", false,
+                           "THE GOVERNMENT HAS ISSUED A =
RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_true(ret);
+ =
   assert_string_equal(control_channel_mesage_sent,
+                      =
  "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FO=
R YOUR AREA=2E");
+
+
+    /* test a long message (> 1000) with fragment to=
 get the maximum header size */
+    char long_message[1200] =3D { 0 };
+
+=
    for (int i =3D 0; i < 1024; i++)
+    {
+        long_message[i] =3D ' =
' + (i % 95);
+    }
+
+    /* last char of the message is a i and then a \=
0 */
+    assert_int_equal(long_message[1023], 'i');
+    assert_int_equal(=
long_message[1024], '\0');
+
+    ret =3D send_acc_message(&c, c=2Ec2=2Etls=
_multi, session, "emergency", true,
+                           long_messag=
e, false);
+
+    assert_true(ret);
+    size_t cc_len =3D strlen(control_c=
hannel_mesage_sent);
+    assert_int_equal(control_channel_mesage_sent[cc_l=
en - 1], 'i');
+    const char *expected_start_cc =3D "ACC,emergency,1024,A=
F, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_channel_mesa=
ge_sent, expected_start_cc, sizeof(expected_start_cc));
+
+    gc_free(&c=
=2Eoptions=2Egc);
+}
\ No newline at end of file
diff --git a/tests/unit_te=
sts/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
new file m=
ode 100644
index 0000000=2E=2Ea64bab5
--- /dev/null
+++ b/tests/unit_tests/=
openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
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
+ *  Copyright (C) 2025 OpenVPN Inc=
 <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=
=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistribute it=
 and/or modify
+ *  it under the terms of the GNU General Public License ve=
rsion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This =
program is distributed in the hope that it will be useful,
+ *  but WITHOUT=
 ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or=
 FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Licen=
se for more details=2E
+ *
+ *  You should have received a copy of the GNU =
General Public License along
+ *  with this program; if not, write to the F=
ree Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E
+ */
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+vo=
id test_acc_parse_client_messages(void **state);
+
+void test_parse_acc_par=
ameters(void **state);
+
+void test_acc_common_protocols(void **state);
+
+=
void test_acc_send_message(void **state);
+#endif
diff --git a/tests/unit_t=
ests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index a=
41c27b=2E=2E82292f1 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++=
 b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -40,11 +40,34 @@
 #include "li=
st=2Eh"
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
+#include "test_sch=
edule=2Eh"
+#include "multi=2Eh"
+
 #ifdef _WIN32
 #include "win32-util=2Eh=
"
 #endif
-#include "test_schedule=2Eh"
 
+/* extra mocks */
+bool
+apply_p=
ush_options(struct context *c, struct options *options, struct buffer *buf,=

+                   uint64_t permission_mask, uint64_t *option_types_found=
,
+                   struct env_set *es, bool is_update)
+{
+    return tr=
ue;
+}
+
+bool
+send_control_channel_string(struct context *c, const char *=
str, msglvl_t msglevel)
+{
+    check_expected_ptr(str);
+    return true;
=
+}
+
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const=
 unsigned long cid)
+{
+    return *(m->instances);
+}
 
 static void
 test=
_compat_lzo_string(void **state)
diff --git a/tests/unit_tests/openvpn/test=
_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 887c492=2E=2Eaa639ff=
 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/=
openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include=
 "openvpn=2Eh"
 
+#include "test_acc=2Eh"
+
 /* Mock function to be allowed=
 to include win32=2Ec which is required for
  * getting the temp directory =
*/
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
     return;
 }
+void
+reschedule_m=
ulti_process(struct context *c)
+{
+}
+
+/* Define a dummy dco cipher optio=
n to avoid linking against all the DCO
+ * units */
+#if defined(ENABLE_DCO=
)
+const char *
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-GC=
M:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* =
generated using
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve=
:secp384r1 -keyout - \
@@ -960,8 +976,11 @@
         cmocka_unit_test(test_=
data_channel_known_vectors_epoch),
         cmocka_unit_test(test_data_chan=
nel_known_vectors_shortpktid),
         cmocka_unit_test(crypto_test_print_=
cert_details),
-        cmocka_unit_test(ssl_test_extract_peer_info)
-
+   =
     cmocka_unit_test(ssl_test_extract_peer_info),
+        cmocka_unit_tes=
t(test_acc_parse_client_messages),
+        cmocka_unit_test(test_parse_acc=
_parameters),
+        cmocka_unit_test(test_acc_common_protocols),
+      =
  cmocka_unit_test(test_acc_send_message)
     };
 
 #if defined(ENABLE_CRY=
PTO_OPENSSL)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6=
a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-Pat=
chSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--quFs1NjYh+0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Implement sending/receiving app custom control protocol<br><br>Ch=
ange-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne S=
chwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man=
-sections/client-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/ope=
nvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M s=
rc/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2E=
c<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/o=
ptions=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/=
openvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>M src/openvpn/ssl=2Ec<br=
>M src/openvpn/ssl_common=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<b=
r>M tests/unit_tests/openvpn/mock_management=2Ec<br>A tests/unit_tests/open=
vpn/mock_management=2Eh<br>M tests/unit_tests/openvpn/mock_push_dependencie=
s=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests/open=
vpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/uni=
t_tests/openvpn/test_ssl=2Ec<br>26 files changed, 1,342 insertions(+), 23 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/58/1858/4</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etx=
t b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Ea9331c2 100644</spa=
n><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</=
span><br><span>@@ -424,6 +424,8 @@</span><br><span>     src/compat/compat-g=
ettimeofday=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span><br=
><span>     src/compat/compat-strtok_r=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     src=
/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><span=
>     src/openvpn/base64=2Ec</span><br><span>@@ -560,9 +562,9 @@</span><br>=
<span>     src/openvpn/ps=2Ec</span><br><span>     src/openvpn/ps=2Eh</span=
><br><span>     src/openvpn/push=2Ec</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    src/openvpn/push_util=2Ec</span><br><span>     src/openv=
pn/push=2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/op=
envpn/pushlist=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   src/openvpn/push_util=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/pushlist=2Eh</span><br><span>     src/openvpn/=
reflect_filter=2Ec</span><br><span>     src/openvpn/reflect_filter=2Eh</spa=
n><br><span>     src/openvpn/reliable=2Ec</span><br><span>@@ -812,7 +814,10=
 @@</span><br><span>             tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_ssl_depende=
ncies=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_win32_=
execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   tests/unit_tests/openvpn/test_acc=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            src/openvpn/acc=2Ec</span><br><span>      =
       src/openvpn/argv=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            src/openvpn/auth_token=2Ec</span><br><span>            =
 src/openvpn/base64=2Ec</span><br><span>             src/openvpn/crypto_epo=
ch=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec</span><b=
r><span>@@ -826,8 +831,11 @@</span><br><span>             src/openvpn/optio=
ns_util=2Ec</span><br><span>             src/openvpn/otime=2Ec</span><br><s=
pan>             src/openvpn/packet_id=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            src/openvpn/reliable=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/session_id=
=2Ec</span><br><span>             src/openvpn/run_command=2Ec</span><br><sp=
an>             src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            src/openvpn/ssl_ncp=2Ec</span><br><span=
>             src/openvpn/ssl_openssl=2Ec</span><br><span>             src/=
openvpn/ssl_util=2Ec</span><br><span>             src/openvpn/ssl_verify_mb=
edtls=2Ec</span><br><span>@@ -844,6 +852,8 @@</span><br><span>     target_s=
ources(test_misc PRIVATE</span><br><span>         tests/unit_tests/openvpn/=
mock_get_random=2Ec</span><br><span>         tests/unit_tests/openvpn/test_=
schedule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 tests/unit_tests/openvpn/mock_management=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        src/openvpn/base64=2Ec</span><br><span>  =
       src/openvpn/options_util=2Ec</span><br><span>         src/openvpn/ot=
ime=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</span><br><span>d=
iff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client=
-options=2Erst</span><br><span>index 87c138a=2E=2E89ba7cf 100644</span><br>=
<span>--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc=
/man-sections/client-options=2Erst</span><br><span>@@ -12,6 +12,17 @@</span=
><br><span>   When this option is set, OpenVPN will not drop incoming tun p=
ackets with</span><br><span>   same destination as host=2E</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-custom-contr=
ol protocollist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Se=
ts the list of supported app custom control protocols=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  These protocols are announced to the=
 server when this option is used</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  as a client=2E If the option is set on a server it will nego=
tiate the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  common p=
rotocols with the client=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The proto=
collist is a : separated list of protocol identifiers=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  See management-notes=2Etxt in the OpenVPN distribution =
 and the OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  draft for a description of app custom control protocol support=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --auth-t=
oken token</span><br><span>   This is not an option to be used directly in =
any configuration files,</span><br><span>   but rather push this option fro=
m a ``--client-connect`` script or a</span><br><span>diff --git a/doc/manag=
ement-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index d6b3fb=
b=2E=2Eb2dcc0a 100644</span><br><span>--- a/doc/management-notes=2Etxt</spa=
n><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -798,6 +798=
,56 @@</span><br><span> The client should return the response to the crtext=
 challenge</span><br><span> using the cr-response command=2E</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+app custom contr=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+If the special string &quot;ACC&quot; is passed as {EXT=
RA} OpenVPN will determine</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+the common app custom protocols between the client and the sever and=
 insruct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the client =
that the server will send control messages to the client using</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+the ACC protocol=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+The server should then use acc-msg command to send =
app custom control messages</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+to the client to faciliate the pending authentication=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or highe=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----------------=
-------------------------</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This commands=
 sends an app custom control message to a client,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+the format of the command is:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID -- client ID and Key=
 ID=2E  See documentation for &quot;&gt;CLIENT:&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+notification for more info=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+protocol -- the ACC protocol identified that this =
message should be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          tagged with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+flags    -- a =
colon seperated list of the encoding and the flag if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            the message is a fragment=2E =
E=2Eg=2E &quot;6:F&quot; for a base64 encoded</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            message that is also a fragment and n=
ot complete yet=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+message  -- The mess=
age encoded in the encoding specified in flags</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- =
acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+------------------------------------------</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+This commands sends an app custom command to the peer, th=
e format of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+comm=
and is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+See the client-acc-msg c=
ommand for more details about the format of the message=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> COMMAND -- client-deny  (OpenVPN 2=2E=
1 or higher)</span><br><span> ---------------------------------------------=
--</span><br><span> </span><br><span>@@ -1247,6 +1297,23 @@</span><br><span=
>    response=2E Mechanisms that need multiple rounds or more complex answe=
rs</span><br><span>    should implement a different response type than CR_R=
ESPONSE=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+(6) App custom control message</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    This message is an application specific payload message that is transp=
orted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    over the O=
penVPN control channel=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    In server=
 mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{KID},{=
protocol},{fragment},{msg_base64}</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    I=
n client mode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;ACC:{protocol},{=
fragment},{msg_base64}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The protocol=
 is a short ascii string identifying the app specific custom</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    protocol and identifies the pr=
otocol=2E If fragment is set to 1, the message</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    is not complete and the next message should =
be concatenated to this message</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    to form a complete message=2E</span><br><span> </span><br><=
span> Variables:</span><br><span> </span><br><span>diff --git a/src/openvpn=
/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd12b4=2E=
=2Ede7a5e7 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br=
><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -42,6 +42,7 @@</s=
pan><br><span> sbin_PROGRAMS =3D openvpn</span><br><span> </span><br><span>=
 openvpn_SOURCES =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	acc=2Ec acc=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span=
> 	auth_token=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh =
\</span><br><span>@@ -121,7 +122,8 @@</span><br><span> 	proto=2Ec proto=2Eh=
 \</span><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=
=2Ec push=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	pus=
h=2Ec push=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	pu=
sh_util=2Ec \</span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_fi=
lter=2Ec reflect_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \=
</span><br><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ea5d664=
1</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</=
span><br><span>@@ -0,0 +1,402 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
OpenVPN -- An application to securely tunnel IP networks</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP p=
ort, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             session authentication and key exchange,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet e=
ncryption, packet authentication, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             packet compression=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Ene=
t&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  T=
his program is free software; you can redistribute it and/or modify</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of t=
he GNU General Public License version 2</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the h=
ope that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
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
 &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;forward=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;ssl_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
num acc_message_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_F=
LAGS_ASCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120, =
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
_encode(BPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b64out, free, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        payl=
oad_msg =3D b64out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D BSTR(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (management)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;s=
ession[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct man_d=
ef_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;options=2Emode =3D=
=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* server mode=2E Report client context */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            unsigned int mda_key_id =3D get_primary_k=
ey(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,=
%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            mda-&gt;cid, mda_key_id, protocol, fragment, payload_msg);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* Client mode=2E Do not a report a CLI=
ENT id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payload_m=
sg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quo=
t;Received custom app control message (protocol &#39;%s&#39;%s)&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        protocol, fragme=
nt ? &quot;, fragment&quot; : &quot;&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  Parses the flags field of an app control me=
ssage and moves the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  buffer past the flags string=2E If there is an</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  error parsing the flags field the method=
 returns -1 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
puts the error reason in err_reason</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc=
_message_flags(struct buffer *buf, const char **err_reason, struct gc_arena=
 *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *flags =3D extrac=
t_field(buf, &#39;,&#39;, gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D &q=
uot;could not extract flags field&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int acc_flags =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (const char *flag =3D flags; *flag !=
=3D &#39;\0&#39;; flag++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (*flag =3D=3D &#39;A&#39;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;6&#39;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE=
_FLAGS_BASE64;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if=
 (*flag =3D=3D &#39;F&#39;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            *err_reason =3D &quot;Unknown flag in flags&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return -1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* The message should be encoded with exac=
tly one encoding=2E Ensure that</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * only one of the flags is present */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool asciienc =3D (bool)(acc_flags &=
amp; ACC_MESSAGE_FLAGS_ASCII);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool base64enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_=
BASE64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (base64enc + asciienc !=
=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_ma=
lloc(512, 1, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      snprintf(tmp, 512, &quot;number of encodings must be exactly one &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
          &quot;(B64=3D%d, ASCII=3D%d)&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 base64enc, asciienc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D tmp;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return acc_flags;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, const stru=
ct buffer *buffer)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *err_reason =3D &quot;&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *buff=
er;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_advance(&amp;buf, strl=
en(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;missing , after =
ACC&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        g=
oto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* extract protocol, payload length, fla=
gs substrings */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *protocol =3D extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!protocol)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could not ex=
tract protocol field&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int payload_len =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buffer_read=
_int(&amp;buf, &amp;payload_len))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        err_reason =3D &quot;could not extract payload length field&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* comma after the length */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (buf_read_u8(&amp;buf) !=3D &#39;,=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quo=
t;missing , after payload len&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D =
parse_acc_message_flags(&amp;buf, &amp;err_reason, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We should have a f=
inal NUL byte in the control message buffer</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * and thus the length of the buffer should be =
payload_len + 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &quot=
;field length %d, payload length %d mismatch&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 payload_len, buf_len(&am=
p;buf) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 err_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_len, protoco=
l, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Received ma=
lformed custom app control channel &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       &quot;(%s) message control mes=
sage: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    err_reason,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    format_hex(BPTR(&amp;buf), BLEN(&amp;buf), 80, &amp;gc));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct con=
text *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
      struct tls_multi *tls_multi,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                 struct tls_session *session,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const char *proto=
col, bool fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 const char *msg, bool base64)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * length of the protocol string + one &#39;,&#39;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * 2 for the encoding (A or 6), potentia=
l F (fragment), and 1 for the &#39;,&#39;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * 4 for the message size itself and one comma</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 1 for the comm=
a before the message itself */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;) + =
strlen(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    size_t len =3D max_header_size + strlen(msg);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;message lengt=
h (%zu) exceeds maximum possible message length (%d)&quot;, len, TLS_CHANNE=
L_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &gt; c-&gt;options=2E=
acc_max_message_length)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_CLIENT, &quot;header (%zu) + message size (%zu) length (%zu) exceeds &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
       &quot;maximum allowed length negotiated with peer (%d)&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            max_header_siz=
e, strlen(msg), len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            c-&gt;options=2Eacc_max_message_length);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* add 1 for the final \0 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(le=
n + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example message=
: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, =
protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
     strlen(msg),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
             base64 ? &quot;6&quot; : &quot;A&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+               fragment ? &quot;F&quot; :=
 &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
          msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    send_control_channe=
l_string_dowork(session, BSTR(&amp;buf), D_PUSH);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    reschedule_multi_process(c);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_ac=
c_parameters(const char *capabilities,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     const char *delim,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     int *max_acc_le=
n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    bool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char *tmp_message =3D string_alloc(capabilities, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message_orig =3D tmp=
_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =
=3D strtok_r(tmp_message, delim, &amp;lasts);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int p =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int acclen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *protocols =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    char *ret =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* In server mode we allow more capabilities than our own, in cl=
ient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * mode we =
reject if we should use capabilities that we do not support */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int allowed_acc_len =3D serv=
er ? INT_MAX : ACC_MAX_MSG_LEN;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whi=
le (token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 0 =
&amp;&amp; !atoi_constrained(token, &amp;acclen, &quot;ACC message length&q=
uot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            goto done;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (p =3D=3D 1 &amp;&amp; (!tls_item_in_cipher_list(&quot;A&quot;, =
token) || !tls_item_in_cipher_list(&quot;6&quot;, token)))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custo=
m control encoding must include base64 and ascii&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (p =3D=3D 1 &amp;&amp; !server &amp;&amp; strcmp(toke=
n, &quot;A:6&quot;) &amp;&amp; strcmp(token, &quot;6:A&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App =
custom control encoding must exactly base64 and ascii&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (p =3D=3D 2)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            protocols =3D token;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p =3D=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(D_PUSH_ERRORS, &quot;Too many parameters for INFO ACC message/IV_ACC=2E=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, deli=
m, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    p++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    *max_acc_len =3D min_int(acclen, ACC_MAX=
_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D string_alloc(protocols, gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(tmp_message=
_orig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return r=
et;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+determine_co=
mmon_acc_protocols(struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!c-&gt;options=2Eacc_protocols)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* No app custom protocols have been configured server-side=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_neg=
otiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We a=
lready have determined the common protocols=2E Doing this</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * again would just add an ex=
tra string allocation to options-&gt;gc */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* example I=
V_ACC: IV_ACC=3D2048,6:A,flower:power */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *peer_info =3D c-&gt;c2=2Etls_multi-&gt=
;peer_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 *iv_acc =3D extract_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int max_acc_len =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    char *protocols =3D parse_acc_parameters(iv_acc, &quo=
t;,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info variable of peer i=
s malformed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strto=
k_r(protocols, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer common_protocols =3D alloc_buf_gc(1024, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (tls_item_in_cipher_list(token, c-&gt;option=
s=2Eacc_protocols))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* protocol is in both server and client list */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (buf_len(&amp;common_protocol=
s) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 buf_write_u8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            buf_printf(&amp;common_protocols, &quo=
t;%s&quot;, token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to=
ken =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (buf_len(&amp;common_protocols) =3D=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING: No common app c=
ustom control protocol=2E&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc=
_negotiated_protocols =3D string_alloc(buf_str(&amp;common_protocols), &amp=
;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    c-&gt;options=2Eacc_max_message_length =3D max_acc_len;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline =
at end of file</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openv=
pn/acc=2Eh</span><br><span>new file mode 100644</span><br><span>index 00000=
00=2E=2E5d9b203</span><br><span>--- /dev/null</span><br><span>+++ b/src/ope=
nvpn/acc=2Eh</span><br><span>@@ -0,0 +1,92 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sin=
gle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales=
@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is free software; you can redistribute it and/or m=
odify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under t=
he terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write t=
o the Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method parses an =
app custom control message and delivers it to the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * management interface=2E We leave reassembl=
y of fragmented messages to the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * management interface=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param c            The context struct</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param buffer       Buffer containing the contro=
l message with ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct conte=
xt *c, const struct buffer *buffer);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 str=
uct tls_multi *tls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 struct tls_session *session,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const char *protocol, bo=
ol fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
          const char *msg, bool base64);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Parses an info message from th=
e server that contains app custom control info</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * information prior to the PUSH_REPLY to be abl=
e to use app custom control</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * protocols before sending</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* In client mode only allow what we support ourselves=2E In server mode</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allow also capabilit=
ies that we not support ourselves=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param capabilities      The string to parse</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param delim             The delimiter to us=
e when parsing the string=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          IV_ACC uses &quot;,&quot; as delimiter=
 while the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
                   custom-control PUSH message uses &quot; &quot; as &quot;=
,&quot; is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
                   already used to separate different push directives</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len    =
   Set to the maximum ACC message length</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param server            Whether we are server or c=
lient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc  =
              The gc arena to use for allocating the resulting string</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return               =
   The resulting protocol string or NULL on error</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+parse_acc_parameters(const char *capabilities,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     const char *delim,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     int *m=
ax_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             bool server,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     struct gc_arena *gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Par=
ses the IV_ACC of the peer and sets c-&gt;options=2Eacc_negotiated_protocol=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to the common p=
rotocols of server and client and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * c-&gt;options=2Eacc_max_message_length  to the maximum len=
gth of the ACC message</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * support by both server and client=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * If there is no common protocol or the client does not support any =
app custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protoc=
ol c-&gt;options=2Eacc_negotiated_protocols will be set to NULL=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param c     the client context to use the=
 set the app custom protocols=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+determine_common_a=
cc_protocols(struct context *c);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/forward=2Ec b/=
src/openvpn/forward=2Ec</span><br><span>index 2ade321=2E=2E736e975 100644</=
span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/open=
vpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include=
 &quot;dco=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</=
span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><s=
pan> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </s=
pan><br><span>@@ -251,11 +252,11 @@</span><br><span>     }</span><br><span>=
     else if (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  server_pushed_info(buf, 8);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        server_pushed_info(c, buf, 8);</span><br><span>     }</sp=
an><br><span>     else if (buf_string_match_head_str(buf, &quot;INFO&quot;)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        server_pushed_info(buf, 4);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        server_pushed_info(c, buf, 4);</span><br><span> =
    }</span><br><span>     else if (buf_string_match_head_str(buf, &quot;CR=
_RESPONSE&quot;))</span><br><span>     {</span><br><span>@@ -265,6 +266,10 =
@@</span><br><span>     {</span><br><span>         receive_auth_pending(c, =
buf);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (buf_string_match_head_str(buf, &quot;ACC&quot;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        receive_acc_message(c, buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
>     else if (buf_string_match_head_str(buf, &quot;EXIT&quot;))</span><br>=
<span>     {</span><br><span>         receive_exit_message(c);</span><br><s=
pan>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><spa=
n>index 6b53686=2E=2Ee8e3a6d 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2283,6 =
+2283,10 @@</span><br><span>             buf_printf(&amp;out, &quot; aead-e=
poch&quot;);</span><br><span>         }</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_nego=
tiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_prin=
tf(&amp;out, &quot; custom-control %d,A:6,%s&quot;, c-&gt;options=2Eacc_max=
_message_length, c-&gt;options=2Eacc_negotiated_protocols);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><=
span>     if (BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</=
span><br><span>@@ -2527,6 +2531,11 @@</span><br><span>         flags |=3D (=
OPT_P_ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2E=
acc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D =
OPT_P_ACC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     r=
eturn flags;</span><br><span> }</span><br><span> </span><br><span>@@ -3342,=
6 +3351,7 @@</span><br><span>     to=2Everify_hash_depth =3D options-&gt;ve=
rify_hash_depth;</span><br><span>     to=2Everify_hash_no_ca =3D options-&g=
t;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex509_username_field, =
options-&gt;x509_username_field, sizeof(to=2Ex509_username_field));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eacc_protocols =3D =
options-&gt;acc_protocols;</span><br><span>     to=2Ees =3D c-&gt;c2=2Ees;<=
/span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_ctx;</span><br><span> =
</span><br><span>@@ -4300,6 +4310,27 @@</span><br><span> }</span><br><span>=
 #endif /* ifdef TARGET_ANDROID */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   struct buffer_list *=
input) /* ownership transferred */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool ret =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_multi=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi =
=3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct tls_session *session =3D &amp;multi-&gt;session[TM_ACT=
IVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 options *opt =3D &amp;c-&gt;options;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ret =3D management_send_acc_message(c, multi, session, opt-&gt;acc_n=
egotiated_protocols, input);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(inp=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> v=
oid</span><br><span>@@ -4316,6 +4347,7 @@</span><br><span>         cb=2Epro=
xy_cmd =3D management_callback_proxy_cmd;</span><br><span>         cb=2Erem=
ote_cmd =3D management_callback_remote_cmd;</span><br><span>         cb=2Es=
end_cc_message =3D management_callback_send_cc_message;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D management_acc=
_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>         cb=2E=
network_change =3D management_callback_network_change;</span><br><span> #en=
dif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec</span><br><span>index 29fdffc=2E=2Eabf6f8b 100644</span><br><span>---=
 a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</spa=
n><br><span>@@ -44,8 +44,10 @@</span><br><span> #include &quot;dco=2Eh&quot=
;</span><br><span> #include &quot;push=2Eh&quot;</span><br><span> #include =
&quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #include =
&quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #ifd=
ef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br=
><span>@@ -1080,6 +1082,35 @@</span><br><span>             }</span><br><spa=
n>             break;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallbac=
k=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(ma=
n-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                                               =
       man-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                                     =
                 man-&gt;connection=2Ein_extra_kid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
                             man-&gt;connection=2Ein_extra);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection=
=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                report_command_status(status, &quot;client-acc-msg&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                man_command_unsup=
ported(&quot;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                bool status =3D (*man-&gt;persist=
=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
                         man-&gt;connection=2Ein_extra);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ei=
n_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              report_command_status(status, &quot;acc-msg&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                man_command_unsupported(&quo=
t;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span>         case IEC_PK_SIGN:</span><br><span>     =
        man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><br><span> =
            buffer_list_free(man-&gt;connection=2Eext_key_input);</span><br=
><span>@@ -1204,6 +1235,29 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+man_client_acc_msg(struct management *man, const char *cid_str,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   const char =
*kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *m=
c =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in=
_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
&amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IE=
C_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt=
;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-=
&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span> man_client_auth(struct management *man, const char *cid_=
str, const char *kid_str, const bool extra)</span><br><span> {</span><br><s=
pan>     struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><=
span>@@ -1760,6 +1814,17 @@</span><br><span>             man_client_pending=
_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (streq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (man_need(man, p, 2, 0))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if=
 (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><span>=
         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -3131,6 +=
3196,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</s=
pan><br><span> management_connection_established(struct management *managem=
ent, struct man_def_auth_context *mdac,</span><br><span>                   =
                const struct env_set *es)</span><br><span>@@ -4362,6 +4428,=
62 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+management_send_acc_message(struct context *=
c, struct tls_multi *multi, struct tls_session *session,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            const char=
 *negotiated_protocols, struct buffer_list *input)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* also ensures that are enough inputs in the list to safe=
ly call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * buffe=
r_list_peek without extra NULL checks */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough input li=
nes for sending acc message, &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                      &quot;missing protocol, flag and/or m=
essages lines&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *proto_=
buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *protocol =3D string_alloc(BSTR(proto_buf), &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_li=
st_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer =
*encoding_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(encoding_buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *flag =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool b64encoding =
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
or: hsl(120, 100%, 40%);">+                                fragment, buf_st=
r(acc_msg_buf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                            b64encoding);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+error:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEMENT */</span><br><sp=
an> </span><br><span> #include &quot;win32=2Eh&quot;</span><br><span>diff -=
-git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>inde=
x f752fec=2E=2Ede9303b 100644</span><br><span>--- a/src/openvpn/manage=2Eh<=
/span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -184,12 +18=
4,19 @@</span><br><span>     int (*n_clients)(void *arg);</span><br><span> =
    bool (*send_cc_message)(void *arg, const char *message, const char *par=
ameter);</span><br><span>     bool (*kill_by_cid)(void *arg, const unsigned=
 long cid, const char *kill_msg);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     bool (*client_auth)(void *arg, const un=
signed long cid, const unsigned int mda_key_id,</span><br><span>           =
              const bool auth, const char *reason, const char *client_reaso=
n,</span><br><span>                         struct buffer_list *cc_config);=
 /* ownership transferred */</span><br><span>     bool (*client_pending_aut=
h)(void *arg, const unsigned long cid, const unsigned int kid,</span><br><s=
pan>                                 const char *extra, unsigned int timeou=
t);</span><br><span>     char *(*get_peer_info)(void *arg, const unsigned l=
ong cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (=
*client_acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           const unsigned long cid,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                           const un=
signed int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           struct buffer_list *msg);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)(void *arg,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    struct b=
uffer_list *msg);</span><br><span>     bool (*proxy_cmd)(void *arg, const c=
har **p);</span><br><span>     bool (*remote_cmd)(void *arg, const char **p=
);</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@ -292,13 +299,1=
5 @@</span><br><span>     struct command_line *in;</span><br><span>     str=
uct buffer_list *out;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define IEC_UNDEF          0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_AUTH    1</span><br=
><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIGN    3</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CERTIFICATE 4</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PK_SIGN     5</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PASSWORD    6</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_RSA_SIGN =
      3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_=
CERTIFICATE    4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine IEC_PK_SIGN        5</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define IEC_PASSWORD       6</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</span><br><span>     i=
nt in_extra_cmd;</span><br><span>     struct buffer_list *in_extra;</span><=
br><span>     unsigned long in_extra_cid;</span><br><span>@@ -503,6 +512,14=
 @@</span><br><span> </span><br><span> void man_persist_client_stats(struct=
 management *man, struct context *c);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC message from the inp=
ut buffer_list and send to the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * session identified by session and multi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct tls_session;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct tls_multi;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+management_send_acc_message(struct context *c, struct tls_multi *multi, st=
ruct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            const char *negotiated_protocols, struct=
 buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */=
</span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/op=
envpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 8342d16=2E=2E=
b444433 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>=
+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br><sp=
an> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dco=
=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot=
;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</sp=
an><br><span> </span><br><span>@@ -1773,6 +1774,13 @@</span><br><span>     =
    o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (o-&gt;acc_protocols)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* If ACC is enabled server side call to find common acc protoco=
ls,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * will =
be pushed during push message */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        determine_common_acc_protocols(c);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     /* Select cipher if client supp=
orts Negotiable Crypto Parameters */</span><br><span> </span><br><span>    =
 /* if we have already created our key, we cannot *change* our own</span><b=
r><span>@@ -4032,6 +4040,24 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+calc=
ulate_app_control_extra(struct context *c, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc_negotiated_protocols=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC:=
 No negotiated protocols&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_=
printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, c-&gt;options=2Eacc_max_message=
_length, c-&gt;options=2Eacc_negotiated_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&amp;buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> static bool</span><br><span> management_client_pen=
ding_auth(void *arg, const unsigned long cid, const unsigned int mda_key_id=
,</span><br><span>                                const char *extra, unsign=
ed int timeout)</span><br><span>@@ -4042,17 +4068,30 @@</span><br><span>   =
  if (mi)</span><br><span>     {</span><br><span>         struct tls_multi =
*multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &quot;ACC&quot;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            extra =3D calculate_ap=
p_control_extra(&amp;mi-&gt;context, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!extra)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>      =
   struct tls_session *session =3D lookup_session_by_mda_key_id(multi, mda_=
key_id);</span><br><span> </span><br><span>         if (!session)</span><br=
><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          gc_free(&amp;gc);</span><br><span>             return false;</spa=
n><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>         /* sends INFO_PRE and AUTH_PENDING messages to client */</s=
pan><br><span>         bool ret =3D send_auth_pending_messages(multi, sessi=
on, extra, timeout);</span><br><span>         reschedule_multi_process(&amp=
;mi-&gt;context);</span><br><span>         multi_schedule_context_wakeup(m,=
 mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fre=
e(&amp;gc);</span><br><span>         return ret;</span><br><span>     }</sp=
an><br><span>     return false;</span><br><span>@@ -4096,6 +4135,39 @@</spa=
n><br><span>     return ret;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_client_acc_msg(void *arg,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                          const unsigne=
d long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                  const unsigned int mda_key_id,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                          struct buffer_list *=
input) /* ownership transferred */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct multi_context *m =3D (struct multi_context *)arg;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D loo=
kup_by_cid(m, cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp=
;&amp; buffer_list_defined(input))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_sessio=
n *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!session)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;client =
session not found&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buffer_list_free(input);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct options *opt =3D &amp;mi-&gt;context=2Eoptions;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ret =3D management_send_acc_message(&amp;mi=
-&gt;context, multi, session, opt-&gt;acc_negotiated_protocols, input);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_=
context_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(input);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> static char *</span><br><span> management_=
get_peer_info(void *arg, const unsigned long cid)</span><br><span> {</span>=
<br><span>@@ -4132,6 +4204,7 @@</span><br><span>         cb=2En_clients =3D=
 management_callback_n_clients;</span><br><span>         cb=2Ekill_by_cid =
=3D management_kill_by_cid;</span><br><span>         cb=2Eclient_auth =3D m=
anagement_client_auth;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cb=2Eclient_acc_msg =3D management_client_acc_msg;</span><br><sp=
an>         cb=2Eclient_pending_auth =3D management_client_pending_auth;</s=
pan><br><span>         cb=2Eget_peer_info =3D management_get_peer_info;</sp=
an><br><span>         cb=2Epush_update_broadcast =3D management_callback_se=
nd_push_update_broadcast;</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 178b5f6=2E=2E27540e7 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> <=
/span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot=
;</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span> #includ=
e &quot;error=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</s=
pan><br><span>@@ -7100,6 +7101,28 @@</span><br><span>         VERIFY_PERMIS=
SION(OPT_P_GENERAL);</span><br><span>         options-&gt;force_key_materia=
l_export =3D true;</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (streq(p[0], &quot;app-custom-control&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;acc_protocols =3D p[1];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;custom-c=
ontrol&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p=
[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT=
_P_ACC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2], &quot=
;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control =
encoding must be base64 and ascii&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!atoi_constrained(p[1], &amp;options-&gt;acc_max_message_length,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
       &quot;app custom message message length&quot;, ACC_MIN_MSG_LEN, ACC_=
MAX_MSG_LEN, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        option=
s-&gt;acc_negotiated_protocols =3D p[3];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;=
prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span>=
<br><span>         msg(M_WARN, &quot;NOTICE: --prng option ignored (SSL lib=
rary PRNG is used)&quot;);</span><br><span>diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh</span><br><span>index 131513e=2E=2Eef4f1fe 1=
00644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/s=
rc/openvpn/options=2Eh</span><br><span>@@ -711,6 +711,16 @@</span><br><span=
>     /* force using TLS key material export for data channel key generatio=
n */</span><br><span>     bool force_key_material_export;</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app cus=
tom control protocols we should announce as supported */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /** the protocols that are negotiated with=
 the peer=2E As a client we</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * trust the server pushed list here */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *acc_negotiated_protocols;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC c=
ontrol channel message */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int acc_max_message_length;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     bool vlan_tagging;</span><br><span>=
     enum vlan_acceptable_frames vlan_accept;</span><br><span>     uint16_t=
 vlan_pvid;</span><br><span>@@ -762,8 +772,10 @@</span><br><span> #define O=
PT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUSH_M=
TU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE     (=
1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine OPT_P_ACC             (1ull &lt;&lt; 32)</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INS=
TANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Options allowed in the normal configurati=
on file (vs pushed options or in ccd files) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_=
PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </span><br><span> =
#define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>=
index fa7bf1e=2E=2E12068b5 100644</span><br><span>--- a/src/openvpn/push=2E=
c</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +27,8=
 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </sp=
an><br><span> #include &quot;push=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;options=
=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span=
> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -220,9 +222,8 @@</span><b=
r><span> #endif</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(const struct buffer *bu=
ffer, const int adv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+server_pushed_info(struct context *c, const struct buffer *buffer, const i=
nt adv)</span><br><span> {</span><br><span>     const char *m =3D &quot;&qu=
ot;;</span><br><span>     struct buffer buf =3D *buffer;</span><br><span>@@=
 -232,6 +233,27 @@</span><br><span>         m =3D BSTR(&amp;buf);</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        int max_acc_len =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* example string to parse: ACC:1400 A:6 flower:happy */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* Skip over the ACC:=
 prefix */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
 +=3D 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        char *protocols =3D pa=
rse_acc_parameters(m, &quot; &quot;, &amp;max_acc_len, false, &amp;c-&gt;op=
tions=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-=
&gt;options=2Eacc_negotiated_protocols =3D protocols;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Eacc_max_messa=
ge_length =3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PU=
SH_ERRORS, &quot;WARNING: Received ACC info command with invalid parameters=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MAN=
AGEMENT</span><br><span>     struct gc_arena gc;</span><br><span>     if (m=
anagement)</span><br><span>@@ -284,6 +306,7 @@</span><br><span>     msg(D_P=
USH, &quot;CR response was sent by client (&#39;%s&#39;)&quot;, m);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /**</span><br><span>  * Parse the keyword for t=
he AUTH_PENDING request</span><br><span>  * @param buffer                bu=
ffer containing the keywords, the buffer&#39;s</span><br><span>@@ -440,7 +4=
63,6 @@</span><br><span>     const char *const peer_info =3D tls_multi-&gt;=
peer_info;</span><br><span>     unsigned int proto =3D extract_iv_proto(pee=
r_info);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span>     /* Calculate the maximum timeout and subtract th=
e time we already waited */</span><br><span>     unsigned int max_timeout =
=3D</span><br><span>         max_uint(tls_multi-&gt;opt=2Erenegotiate_secon=
ds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span><br><span>@@ -731,6 +7=
53,11 @@</span><br><span>                 client_max_mtu, o-&gt;ce=2Etun_mt=
u, o-&gt;ce=2Etun_mtu);</span><br><span>         }</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_p=
rotocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_option_fmt(=
gc, push_list, M_USAGE, &quot;custom-control %d A:6 %s&quot;, c-&gt;options=
=2Eacc_max_message_length, c-&gt;options=2Eacc_negotiated_protocols);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }<=
/span><br><span> </span><br><span> #if defined(__GNUC__) || defined(__clang=
__)</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2E=
h</span><br><span>index dff945f=2E=2E3aca8a7 100644</span><br><span>--- a/s=
rc/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><s=
pan>@@ -52,6 +52,7 @@</span><br><span> </span><br><span> int process_incomi=
ng_push_request(struct context *c);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 @brief Handles the receiving of a push-update message and applies updates =
to the specified</span><br><span>  * options=2E</span><br><span>@@ -92,7 +9=
3,7 @@</span><br><span> </span><br><span> void receive_exit_message(struct =
context *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void server_pushed_info(const struct buffer *buffer, const int adv=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void server_pushe=
d_info(struct context *c, const struct buffer *buffer, const int adv);</spa=
n><br><span> </span><br><span> void receive_cr_response(struct context *c, =
const struct buffer *buffer);</span><br><span> </span><br><span>diff --git =
a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>ind=
ex fcc5411=2E=2E6462a97 100644</span><br><span>--- a/src/openvpn/push_util=
=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -37=
0,4 +370,4 @@</span><br><span> </span><br><span>     RETURN_UPDATE_STATUS(n=
_sent);</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span>=
\ No newline at end of file</span><br><span>diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1f9=2E=2Ea5663e3 100644</=
span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </span><br><span=
> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;ssl=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;acc=2Eh&quot;</span><br><span> #include &quot;ssl_verify=2Eh&quot;</s=
pan><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br><span> #inclu=
de &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -2054,6 +2055,11 @@</span><br=
><span>                     }</span><br><span>                 }</span><br>=
<span>             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (se=
ssion-&gt;opt-&gt;acc_protocols)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                buf_printf(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&quot=
;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>         =
}</span><br><span>     }</span><br><span> </span><br><span>diff --git a/src=
/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index =
db61198=2E=2E3b326a7 100644</span><br><span>--- a/src/openvpn/ssl_common=2E=
h</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -452,=
6 +452,9 @@</span><br><span>     size_t ekm_size;</span><br><span> </span><=
br><span>     bool dco_enabled; /**&lt; Whether keys have to be installed i=
n DCO or not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom =
control protocols we should announce as supported */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br>=
<span> };</span><br><span> </span><br><span> /** @addtogroup control_proces=
sor</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/t=
ests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2E75=
3e59d 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</=
span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>@@ -103,9 +103,11 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_=
testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><s=
pan> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    test_acc=2Ec test_acc=2Eh \</span><br><span>=
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_manage=
ment=2Ec \</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32_execve=2E=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/openvpn/acc=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -127,6 +129,7 @@=
</span><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/ssl_mbedtls=2Ec \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/ssl_verify_mbedtls=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/ssl_verify_openssl=2Ec \</span><br><span>@@ -375,8 +378,10 @@</span><b=
r><span> </span><br><span> misc_testdriver_SOURCES =3D test_misc=2Ec \</spa=
n><br><span> 	test_schedule=2Ec test_schedule=2Eh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_management=2Ec mock_management=2Eh =
\</span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_=
get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br=
><span>@@ -388,6 +393,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/siph=
ash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/=
openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span> 	=
-I$(top_srcdir)/tests/unit_tests/openvpn \</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_m=
anagement=2Ec</span><br><span>index 77f6ce2=2E=2Ecddd669 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>@@ -29,6 +2=
9,7 @@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;stdlib=2Eh&gt;</span><br><span> #include &quot;manage=2Eh&quot;<=
/span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span=
>@@ -60,4 +61,4 @@</span><br><span> void</span><br><span> management_sleep(=
const int n)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span>\ No newline at end of file</span><br><span>diff --git a/tests/un=
it_tests/openvpn/mock_management=2Eh b/tests/unit_tests/openvpn/mock_manage=
ment=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Ee21aec43</span><br><span>--- /dev/null</span><br><span>+++ b/tests/un=
it_tests/openvpn/mock_management=2Eh</span><br><span>@@ -0,0 +1,32 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc254=
9=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
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
s program; if not, write to the Free Software Foundation, Inc=2E,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef MOCK_MANAG=
EMENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MOCK=
_MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void i=
nit_mock_management(void);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void uninit_=
mock_management(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span>diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/t=
ests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>index 11=
2bcfd=2E=2Ec16d0cb 100644</span><br><span>--- a/tests/unit_tests/openvpn/mo=
ck_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,8 @@</span><br><span> =
    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_=
P_SOCKFLAGS</span><br><span>                      | OPT_P_SETENV | OPT_P_SH=
APER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span>           =
           | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PU=
LL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
       | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_D=
HCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P=
_DHCPDNS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          | OPT_P_ACC;</span><br><span>     return flags;</span><br><span> =
}</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2Ed73547e</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</sp=
an><br><span>@@ -0,0 +1,297 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
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
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+char control_channel_mesage_sent[2048];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Mock functions */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+send_control_channel_string_dowork(struct tls_session *session,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
          const char *str, int msglevel)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_in_range(strlen(str), 0, 2048);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    memcpy(control_channel_mesage_sent, str, strlen(str));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_=
push_reply_auth_token(struct tls_multi *multi)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+auth_set_client_reason(struct tls_multi *=
multi, const char *reason)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkE=
DDxLBpZw9JnjI3tBM&quot;                \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    &quot;r4engpg/cDgS48DMaxyCdbzofNjQ=
JU9Y0DD66z/notFT0cF1d60nTS&quot; \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMy=
qwCvALwCewCTAKABrwCP&quot; \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAM=
AAQIACgAWABQAH&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAM=
FAwYDCAc&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgA=
rA&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quo=
t; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     &quot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_pa=
rse_client_messages(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    skip();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that t=
he messages get to mock_msg */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    x_debug_level =3D 3;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    management =3D (void *)0x12345678;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* contains a TLS 1=2E3 ClientHello *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg=
[] =3D &quot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer msg_buf;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct context c =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, str=
uct tls_multi, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Et=
ls_multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_mul=
ti-&gt;session[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=2Emda_conte=
xt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read=
(&amp;msg_buf, (void *)msg, sizeof(msg));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;R=
eceived custom app control message (protocol &#39;cck1&#39;)&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mo=
ck_managment_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg[] =3D &quot;ACC=
,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;=
msg_buf, (void *)flower_msg, sizeof(flower_msg));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(mock_msg_buf, &quot;Received custom app control message (protocol &#3=
9;flower&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,flo=
wer,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char msg_incorrect_len[] =
=3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAA=
S2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_incorrect_len, sizeof(ms=
g_incorrect_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *error =3D &quot;WARNING: Received=
 malformed custom app control channel &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        &quot;(field length 62, pa=
yload length 64 mismatch) message &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        &quot;control message: 496e736=
7 496d316c 496a6f67 496d5a79 &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        &quot;62326369 4c434141 65475a6d 2f=
534a7[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_fragment[]=
 =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_f=
ragment, sizeof(msg_fragment));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf=
, &quot;Received custom app control message (protocol &#39;power&#39;, frag=
ment)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVs=
bG8gdw=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_man=
agment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
check two encoding present */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char flower_msg_two_encs[] =3D &quot;ACC,flower,48,6A,S=
SBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void=
 *)flower_msg_two_encs, sizeof(flower_msg_two_encs));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Rece=
ived malformed custom app control channel (number of &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;encodings must be=
 exactly one (B64=3D1, ASCII=3D1)) message control &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;message: 53534268 6=
2534141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &quot;61475567 37372b3[more=2E=
=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(mock_msg_buf, error);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* no encoding present */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_ms=
g_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZn=
JvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf_set_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof(flower_=
msg_no_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eceive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    error =3D &quot;WARNING: Received malformed custom app control chann=
el (number of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;encodings must be exactly one (B64=3D0, ASCII=3D0)) mess=
age control &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;message: 53534268 62534141 4945746c 636d3170 6443442f 2f53=
4230 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    x_debug_level =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    management =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_parse_acc_parameters(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* parameters to INFO message =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *i=
nfo_acc_msg =3D &quot;4096 A:6 flower:happy&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int max_len =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *protocols =3D parse_acc_parameters(info_acc_=
msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flow=
er:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(max_len, 1280);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* a client does not accept a length longer than it supports */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* message with lower limit than ou=
r, should work for client and server */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D p=
arse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_ms=
g, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower=
:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
more encodings than supported=2E Server should be okay, client should fail =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =
=3D &quot;1200 A:6:B flower:happy&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &=
quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; =
&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(max_len, 1200);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extra para=
meter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_ac=
c_msg =3D &quot;1400 A:6 flower:happy 77&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc=
_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &q=
uot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *iv_acc_capabilities =3D &quot;1400,A:6,flower:happy:power&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D =
parse_acc_parameters(iv_acc_capabilities, &quot;,&quot;, &amp;max_len, true=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(protocols, &quot;flower:happy:power&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* too small protocol length */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flow=
er:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
protocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_le=
n, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-n=
umerical protocol length */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    info_acc_msg =3D &quot;abff A:6 flower:happy 77&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_=
parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol length=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg=
 =3D &quot;abff A:6 flower:happy 77&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg,=
 &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_acc_common_protocols(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=
=2Ec2=2Etls_multi, struct tls_multi, &amp;c=2Eoptions=2Egc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PRO=
TO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Eacc_protocols =3D &quo=
t;power:flower:star&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    determin=
e_common_acc_protocols(&amp;c);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(c=2Eoptions=2Eacc_max_message_length, ACC_MAX_MSG_LEN);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(c=
=2Eoptions=2Eacc_negotiated_protocols, &quot;flower:power&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;c=2Eoptions=2Egc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_=
send_message(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
context c =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    c=2Eoptions=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;c=2Eoptions=
=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;peer_info =
=3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Eac=
c_protocols =3D &quot;power:flower:emergency&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(&amp;c=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct tls_session *session =3D &amp;c=2Ec2=2Etls_m=
ulti-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D send_acc_message(&amp;c, c=2Ec2=2Etls_multi, session, &quot;emergency&q=
uot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                   &quot;EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:=
&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(control_channel_mesage_sent,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        &quot;ACC,emergency,50,AF,EMERGENCY BRO=
ADCAST MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ret =3D send_acc_message(&amp;c, c=2Ec2=2Etls_multi, session, &q=
uot;emergency&quot;, false,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           &quot;THE GOVERNMENT HAS ISSUED A RAINBO=
W COLOURED ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(control_channel_mesa=
ge_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW C=
OLOURED ALERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* test a long =
message (&gt; 1000) with fragment to get the maximum header size */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char long_message[1200]=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt=
; 1024; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long_message[=
i] =3D &#39; &#39; + (i % 95);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* last char of th=
e message is a i and then a \0 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(long_message[1023], &#39;i&#39;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_=
message[1024], &#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D send_acc_message(&amp;c, c=2Ec2=2Etls_multi, session, &quot;emergency&q=
uot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                   long_message, false);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    size_t cc_len =3D strlen(control_channel_mesage_sent);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(control_cha=
nnel_mesage_sent[cc_len - 1], &#39;i&#39;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *expected_start_cc =3D &quot;ACC,eme=
rgency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(control_ch=
annel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;c=2Eoptions=2Egc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline a=
t end of file</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ac=
c=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>new file mode=
 100644</span><br><span>index 0000000=2E=2Ea64bab5</span><br><span>--- /dev=
/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Eh</span><br=
><span>@@ -0,0 +1,35 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -=
- An application to securely tunnel IP networks</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with=
 support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             session authentication and key exchange,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption=
, packet authentication, and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             packet compression=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progr=
am is free software; you can redistribute it and/or modify</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Ge=
neral Public License version 2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that =
it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  GNU General Public License for more details=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, write to the Free Software Fo=
undation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void test_acc_parse_client_messages(void **state);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void test_parse_acc_parameters(void **state);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void test_acc_common_protocols(void **state);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_acc_send_message(void **state);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/=
openvpn/test_misc=2Ec</span><br><span>index a41c27b=2E=2E82292f1 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -40,11 +40,3=
4 @@</span><br><span> #include &quot;list=2Eh&quot;</span><br><span> #inclu=
de &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tes=
t_schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span> #include &quot=
;win32-util=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#include &quot;test_schedule=2Eh&quot;</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* extra mocks=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct conte=
xt *c, struct options *options, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   uint64_t permission_ma=
sk, uint64_t *option_types_found,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   struct env_set *es, bool is_update)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_str=
ing(struct context *c, const char *str, msglvl_t msglevel)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_expected_ptr(str);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct mul=
ti_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lookup=
_by_cid(struct multi_context *m, const unsigned long cid)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return *(m-&gt;instances);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> static =
void</span><br><span> test_compat_lzo_string(void **state)</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openv=
pn/test_ssl=2Ec</span><br><span>index 887c492=2E=2Eaa639ff 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</span=
><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &=
quot;openvpn=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock function to be=
 allowed to include win32=2Ec which is required for</span><br><span>  * get=
ting the temp directory */</span><br><span> #ifdef _WIN32</span><br><span>@=
@ -86,6 +88,20 @@</span><br><span> {</span><br><span>     return;</span><br=
><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_process(=
struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Define a dummy dco cipher option to avoid linking aga=
inst all the DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
units */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const c=
har *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_suppor=
ted_ciphers(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES=
-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 /* generated using</span><br><span>  * openssl req -x509 -newkey ec -pkeyo=
pt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>@@ -960,8 +976,1=
1 @@</span><br><span>         cmocka_unit_test(test_data_channel_known_vect=
ors_epoch),</span><br><span>         cmocka_unit_test(test_data_channel_kno=
wn_vectors_shortpktid),</span><br><span>         cmocka_unit_test(crypto_te=
st_print_cert_details),</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        cmocka_unit_test(ssl_test_extract_peer_info)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(ssl_test_extract_peer_info),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_acc_parse_client_messages),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_parse_acc_parameters),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_a=
cc_common_protocols),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_acc_send_message)</span><br><span>     };</=
span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d79=
5b2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--quFs1NjYh+0=--


--===============8545900966330100163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8545900966330100163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8545900966330100163==--

