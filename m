Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F9DC5DF93
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4ncawQoIoh4/I7BUs7OHQ/n/L/k28PxlNRpuHQ+iZ9Q=; b=XJo9gEVOhyG2Km
	+vxjA7W2dOQmXiMrGB21sW+KHChVfcRfpjVtWxvHc0lnFJ/JVAYgso6vT/TovA4EiF8RlwaTqkvH5
	dVs/NY0GTuTFM/osa9DfDKAIfmvAMNixhNaK8K5IX8ezCzyG5grT44IfjqOSjlhqaLdrcyuvvwTan
	hn0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRV6-0004Db-RT;
	Fri, 21 Aug 2026 15:49:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRV5-0004DO-MM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PBmftu9ZckoMSGGjMfq6ityFIyBpYUW3hFiRM822wSE=; b=KxpoabG7m6dKiQKu8iXEj1s2cH
 VB/wiztG6dl4UYKNtq5AtMJVG8PkTbyynJwsO6VVTfRQgnietWBmzYyEwOpqq3XeHZZPXXCddnW4a
 5dFKE6dScep/CXPbV3XUi1+c++vd8octOlu0pM4YbsPMzfyoK0HtDlwhUvv76d8LWxpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PBmftu9ZckoMSGGjMfq6ityFIyBpYUW3hFiRM822wSE=; b=K
 o4qfRbaBeBPRMA8DTMykTQAiwQz3PgyltcdZGaHuo7JAAcni25oZgayjMf6IhPHhXn1AGH5Okkmfc
 085UegZ3eQsfDhIe+Q7WSGLVzXxu195+8ZhL/6pQEnNLdRB/tNu7DCaS8naqR27HkRTYv0aXGTd8f
 h+VdoArAPuJw6o6c=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUv-0005cz-Sz for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:45 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c2055f5a993so137369266b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327371; x=1787932171; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PBmftu9ZckoMSGGjMfq6ityFIyBpYUW3hFiRM822wSE=;
 b=cgYCm7Jtt+KItD4BhWB9yTHqqM5IVCrBqNhR0ZpR9zctYSQuWIUYinNHdy0quIEwLM
 6umU7AK1MMHpt/8PGTjogV1kZ5w4NT4hs/bnCkCARN1HfFNq+uuMqwOJA7E8ETdQc+F0
 BC6azbCN3jLKHB3krKBI1iRMu8vySX2yVuSgTELBnh5J6ib7Vd58OiFABwChGnXvALZQ
 6OjNWhMe7ahIn79I7Wl4b3zpuvGQk+gfxZbLs7ole/o9dSo0dpAJd++6kFIXYcEu5sHM
 kI5FwL4JytYnXfoq9TXwAUh4spzK4gf9czAB0jnPUtXIHV0GDYZExrdQIrnSF7H9yEn5
 Lggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327371; x=1787932171;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PBmftu9ZckoMSGGjMfq6ityFIyBpYUW3hFiRM822wSE=;
 b=DXZ0mebnk+T7pYuGPyY+IJP0HPJCPjzAjL4QrAY86aDWfEDieRZD+9Kzc6NbykKsvf
 YMrw58vNpphROV4/xIwMo1C8MFO8RT7Mvg5XXwfBzBVDyfccaRdqozRlJBZzxv7yDEgZ
 CAbN0CBGmFkgzW3vIdAWRkSwwIttNr4VB0rFxtkDgwv21g0rGcACy2DbmudguDLMmurb
 F9XMzRzOlegd2fatbxzCU/bR9OeH27Ypkhq6PBHd0oT+nTpWfhN1ULYXmrxXq7Ei2Naf
 E20L6Be4r0hTaWm7EJVz9dCgikJyRVs9kJpYuB9o+gLQQQQRHTkZdoo1oH6untY83B6x
 8iHg==
X-Gm-Message-State: AFuF++nO//mH+C+FlUaXO6Ylf5I1/nud5FzurxbdD5n4he5PmuiaDZBh
 SiCEtxhE5MnqSinab0uOKnHq/zB/HT2WWaa459d8YVVOhA6LVFTvHEdbc6UtuZWhrJ4SITxtXZ6
 aMEnMR9VzadLAOMe9pO5vCZFnY9vJSIwHagz+cn4ho3Dy1Tcc+P5n4To+g8bFqwhnRyAtzc6t0M
 Gsr3kBNw==
X-Gm-Gg: AR+sD13AalgkKFfb5zCd7/+ZdixPyjO0OGTNJsXHGGf1vCRElQ5yMV+dsLiXfnQC8q0
 RPzeLjAbkmPI6F0DIiwdgQLg13TlDTqoEkKnHXGiz6eiHskB5YbLJconV5cqEJlNM5qTgZ7jLho
 KMpkqaxBO8RTZFbixvtot4V7UqHawmuiNADuHmlO/95Qf3xm5Jqs47XJcR8k7yp9E3nHh3vWU8P
 6d77LD0U9hv7RBlUtxTLXdVxoriqYs4OL8G0ACAIFfF2JHmwAaW9P5fBEiRNh08mO6/Qg5MJLh5
 yhiiLAkmbulFIMwWqa8IZQBNWEyeAiXfSWtBRHZXvuiJTqP88egvA5YcbKzu8zJPnxkNBGTxi3j
 D9NX9aZ/ItA1jgJfACLs/zu+fRbRGEngVsWU6XEvNeC6WnQiA3/az/TQV0e1bAHnbyIn6TxJlqA
 zWqW9sax8+uSsJ95eFIHeJVgnb69/+/yv9W2017q1Dx34ZdGmkKFvjk5aVi0QXhYExg7usWvxye
 BzMujftPfauttzOlR/OpQv4RCaIz3rXjLtMzUwef7zuUPPVWZtepNUo3lQ6UvmMqLi9Qly7D57a
 KWsBvhLu1p6VfLTnUiHjDK8fhr9vYdPC1oW0+KbP0Qu/GkKujlI=
X-Received: by 2002:a17:907:3e02:b0:c21:6f8c:2335 with SMTP id
 a640c23a62f3a-c246a6b1745mr733476666b.16.1787327369683; 
 Fri, 21 Aug 2026 08:49:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591df622sm535936466b.46.2026.08.21.08.49.29
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 81624a3b415df9d817a7e41a5f00101e29f3a4ac
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a22aa33883b0321d7f98ae6b53239e0725193f5d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUv-0005cz-Sz
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
Content-Type: multipart/mixed; boundary="===============0274239588052581552=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0274239588052581552==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dRSvloxgMJU="; charset=UTF-8

--dRSvloxgMJU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail )


Change subject: Implement sending/r=
eceiving app custom control protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Implement sending/receiving app custom control pr=
otocol

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Signed-off-by:=
 Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-section=
s/client-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/Makefile=
=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/forward=2Ec=

M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M=
 src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
=
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_util=2Ec
A=
 src/openvpn/push_util=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=
=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mo=
ck_management=2Ec
A tests/unit_tests/openvpn/mock_management=2Eh
M tests/un=
it_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/openvpn/test=
_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_tests/openvpn=
/test_misc=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
27 files changed, 1,=
317 insertions(+), 22 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/58/1858/1

diff --git a/CMakeLists=2Etxt b/CM=
akeLists=2Etxt
index 6eb5954=2E=2E8f52e44 100644
--- a/CMakeLists=2Etxt
+++=
 b/CMakeLists=2Etxt
@@ -424,6 +424,8 @@
     src/compat/compat-gettimeofday=
=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
=
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/argv=2Ec=

     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -560,8 +562,9 @@
=
     src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/openvpn/push=2Ec
-=
    src/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
+    src/openvpn/pu=
sh_util=2Ec
+    src/openvpn/push_util=2Eh
     src/openvpn/pushlist=2Eh
  =
   src/openvpn/reflect_filter=2Ec
     src/openvpn/reflect_filter=2Eh
@@ -8=
12,7 +815,10 @@
             tests/unit_tests/openvpn/mock_management=2Ec
 =
            tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
            =
 tests/unit_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_tes=
ts/openvpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src/o=
penvpn/argv=2Ec
+            src/openvpn/auth_token=2Ec
             src/op=
envpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             src=
/openvpn/crypto_mbedtls=2Ec
@@ -826,8 +832,11 @@
             src/openvpn/o=
ptions_util=2Ec
             src/openvpn/otime=2Ec
             src/openvpn=
/packet_id=2Ec
+            src/openvpn/reliable=2Ec
+            src/openv=
pn/session_id=2Ec
             src/openvpn/run_command=2Ec
             src=
/openvpn/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
             =
src/openvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
         =
    src/openvpn/ssl_verify_mbedtls=2Ec
@@ -844,6 +853,8 @@
     target_sour=
ces(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random=2Ec=

         tests/unit_tests/openvpn/test_schedule=2Ec
+        tests/unit_te=
sts/openvpn/mock_management=2Ec
+        src/openvpn/base64=2Ec
         sr=
c/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/open=
vpn/ssl_util=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/doc/m=
an-sections/client-options=2Erst
index 87c138a=2E=2E89ba7cf 100644
--- a/do=
c/man-sections/client-options=2Erst
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
7fd12b4=2E=2E4fcccf1 100644
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
+	push_util=2Ec push_util=2Eh \
 	pushlist=
=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2E=
h \
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 10=
0644
index 0000000=2E=2E2b7e65f
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ =
-0,0 +1,390 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP net=
works
+ *             over a single TCP/UDP port, with support for SSL/TLS-=
based
+ *             session authentication and key exchange,
+ *         =
    packet encryption, packet authentication, and
+ *             packet co=
mpression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
=
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
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
+ *  with this program; if not, write to the Free Software Foundation, =
Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
=
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "sy=
shead=2Eh"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#include "push_=
util=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"=

+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=
=2Eh"
+
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    =
ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
=
+
+
+static void
+log_acc_message(struct context *c, const struct buffer *b=
uf, int payload_len,
+                const char *protocol, int flags)
+{
+=
    bool fragment =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MA=
NAGEMENT
+    struct gc_arena gc =3D gc_new();
+    const char *payload_msg=
 =3D NULL;
+
+    /* For simplicity, we always encode payload to be base64 =
encoded
+     * if not already in base64 format */
+    if (flags & ACC_MES=
SAGE_FLAGS_ASCII)
+    {
+        char *b64out =3D NULL;
+        ASSERT(op=
envpn_base64_encode(BPTR(buf), payload_len, &b64out) >=3D 0);
+        gc_a=
ddspecial(b64out, free, &gc);
+        payload_msg =3D b64out;
+    }
+    =
else
+    {
+        payload_msg =3D BSTR(buf);
+    }
+
+    if (managemen=
t)
+    {
+        struct tls_session *session =3D &c->c2=2Etls_multi->sess=
ion[TM_ACTIVE];
+
+        struct man_def_auth_context *mda =3D session->op=
t->mda_context;
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+       =
 {
+            /* server mode=2E Report client context */
+            uns=
igned int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_id;
+ =
           msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+                md=
a->cid, mda_key_id, protocol, fragment, payload_msg);
+        }
+        e=
lse
+        {
+            /* Client mode=2E Do not a report a CLIENT id *=
/
+            msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payload_m=
sg);
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMEN=
T */
+    msg(D_PUSH, "Received custom app control message (protocol '%s'%s=
)",
+        protocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *  Pars=
es the flags field of an app control message and moves the
+ *  buffer past=
 the flags string=2E If there is an
+ *  error parsing the flags field the =
method returns -1 and
+ *  puts the error reason in err_reason
+ */
+static=
 int
+parse_acc_message_flags(struct buffer *buf, const char **err_reason, =
struct gc_arena *gc)
+{
+    const char *flags =3D extract_field(buf, ',', =
gc);
+
+    if (!flags)
+    {
+        *err_reason =3D "could not extract =
flags field";
+        return -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+ =
   for (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+      =
  if (*flag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MESSAGE_=
FLAGS_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+        {
+   =
         acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else =
if (*flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSAGE_FL=
AGS_FRAGMENT;
+        }
+        else
+        {
+            *err_reason =
=3D "Unknown flag in flags";
+            return -1;
+        }
+    }
+   =
 /* The message should be encoded with exactly one encoding=2E Ensure that
=
+     * only one of the flags is present */
+    bool asciienc =3D (bool)(a=
cc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_fla=
gs & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+  =
  {
+        char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 51=
2, "number of encodings must be exactly one "
+                           "=
(B64=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc);
+        *=
err_reason =3D tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
=
+
+
+void
+receive_acc_message(struct context *c, const struct buffer *buff=
er)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *err_reason =
=3D "";
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+   =
 struct buffer buf =3D *buffer;
+
+    if (!buf_advance(&buf, strlen("ACC")=
) || buf_read_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "missing , =
after ACC";
+        goto err;
+    }
+
+    /* extract protocol, payload l=
ength, flags substrings */
+    char *protocol =3D extract_field(&buf, ',',=
 &gc);
+    if (!protocol)
+    {
+        err_reason =3D "could not extrac=
t protocol field";
+        goto err;
+    }
+
+    int payload_len =3D 0;
=
+    if (!buffer_read_int(&buf, &payload_len))
+    {
+        err_reason =
=3D "could not extract payload length field";
+        goto err;
+    }
+
+=
    /* comma after the length */
+    if (buf_read_u8(&buf) !=3D ',')
+    =
{
+        err_reason =3D "missing , after payload len";
+        goto err;=

+    }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_reason, &gc=
);
+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We shou=
ld have a final NUL byte in the control message buffer
+     * and thus the=
 length of the buffer should be payload_len + 1 */
+    if (buf_len(&buf) !=
=3D payload_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
=
+        snprintf(tmp, 512, "field length %d, payload length %d mismatch",
=
+                 payload_len, buf_len(&buf) - 1);
+        err_reason =3D =
tmp;
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf, payload_le=
n, protocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUS=
H_ERRORS, "WARNING: Received malformed custom app control channel "
+      =
                 "(%s) message control message: %s",
+        err_reason,
+=
        format_hex(BPTR(&buf), BLEN(&buf), 80, &gc));
+    gc_free(&gc);
+}=

+
+
+bool
+send_acc_message(struct context *c,
+                 struct tl=
s_multi *tls_multi,
+                 struct tls_session *session,
+       =
          const char *protocol, bool fragment,
+                 const char=
 *msg, bool base64)
+{
+    /* TODO check client capabilities */
+    /* 3 =
for the encoding, potential F, and , 1 for the final flag, 5 for the messag=
e size itself */
+    const size_t max_header_size =3D strlen("ACC,") + 3 +=
 strlen(protocol) + 1 + 5;
+
+    size_t len =3D max_header_size + strlen(m=
sg);
+
+    if (len > PUSH_BUNDLE_SIZE)
+    {
+        msg(M_CLIENT, "mess=
age length (%zu) exceeds maximum possible message length (%d)", len, PUSH_B=
UNDLE_SIZE);
+        return false;
+    }
+
+    struct gc_arena gc =3D gc=
_new();
+    struct buffer buf =3D alloc_buf_gc(len, &gc);
+
+    /* Exampl=
e message: ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%=
s,%zu,%s%s,%s", protocol,
+               strlen(msg),
+               base=
64 ? "6" : "A",
+               fragment ? "F" : "",
+               msg);
=
+
+    send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
+  =
  reschedule_multi_process(c);
+    return true;
+}
+
+char *
+parse_acc_pa=
rameters(const char *capabilities,
+                     const char *delim,=

+                     int *max_acc_len,
+                     bool server,=

+                     struct gc_arena *gc)
+{
+    char *tmp_message =3D s=
tring_alloc(capabilities, NULL);
+    char *tmp_message_orig =3D tmp_messag=
e;
+    char *lasts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_mes=
sage, delim, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const=
 char *protocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mod=
e we allow more capabilities than our own, in client
+     * mode we reject=
 if we should use capabilities that we do not support */
+    int allowed_a=
cc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
=
+        if (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message l=
ength", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+     =
       goto done;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cip=
her_list("A", token) || !tls_item_in_cipher_list("6", token)))
+        {
+=
            msg(D_PUSH_ERRORS, "App custom control encoding must include ba=
se64 and ascii");
+            goto done;
+        }
+
+        if (p =3D=
=3D 1 && !server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        =
{
+            msg(D_PUSH_ERRORS, "App custom control encoding must exactly=
 base64 and ascii");
+            goto done;
+        }
+
+        if (p =
=3D=3D 2)
+        {
+            protocols =3D token;
+        }
+
+      =
  if (p =3D=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many para=
meters for INFO ACC message/IV_SSO=2E");
+            goto done;
+        }=

+
+        token =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+=

+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D strin=
g_alloc(protocols, gc);
+
+done:
+    free(tmp_message_orig);
+    return r=
et;
+}
+
+
+void
+determine_common_acc_protocols(struct context *c)
+{
+   =
 if (!c->options=2Eacc_protocols)
+    {
+        /* No app custom protocol=
s have been configured server-side=2E */
+        return;
+    }
+    if (c=
->options=2Eacc_negotiated_protocols)
+    {
+        /* We already have de=
termined the common protocols=2E Doing this
+         * again would just ad=
d an extra string allocation to options->gc */
+        return;
+    }
+
+ =
   struct gc_arena gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048=
,6:A,flower:power */
+    const char *peer_info =3D c->c2=2Etls_multi->peer=
_info;
+    char *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", =
&gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);
+        return;
+   =
 }
+
+    int max_acc_len =3D 0;
+    char *protocols =3D parse_acc_paramet=
ers(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+ =
       gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info=
 variable of peer is malformed");
+        return;
+    }
+
+    char *last=
s =3D NULL;
+    const char *token =3D strtok_r(protocols, ":", &lasts);
+
=
+    struct buffer common_protocols =3D alloc_buf_gc(1024, &gc);
+
+    whi=
le (token)
+    {
+        if (tls_item_in_cipher_list(token, c->options=2E=
acc_protocols))
+        {
+            /* protocol is in both server and c=
lient list */
+            if (buf_len(&common_protocols) > 0)
+           =
 {
+                buf_write_u8(&common_protocols, ':');
+            }
+ =
           buf_printf(&common_protocols, "%s", token);
+        }
+        =
token =3D strtok_r(NULL, ":", &lasts);
+    }
+
+    if (buf_len(&common_pr=
otocols) =3D=3D 0)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_DEBUG,=
 "WARNING: No common app custom control protocol=2E");
+        return;
+  =
  }
+
+    c->options=2Eacc_negotiated_protocols =3D string_alloc(buf_str(&=
common_protocols), &c->options=2Egc);
+    c->options=2Eapp_custom_protocol=
_len =3D max_acc_len;
+    gc_free(&gc);
+}
\ No newline at end of file
dif=
f --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
in=
dex 0000000=2E=2Ec86eb5d
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1=
,92 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ =
*             over a single TCP/UDP port, with support for SSL/TLS-based
+ =
*             session authentication and key exchange,
+ *             pack=
et encryption, packet authentication, and
+ *             packet compressio=
n=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Cop=
yright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program=
 is free software; you can redistribute it and/or modify
+ *  it under the =
terms of the GNU General Public License version 2
+ *  as published by the =
Free Software Foundation=2E
+ *
+ *  This program is distributed in the hop=
e that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of
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
#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_M=
SG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an ap=
p custom control message and delivers it to the
+ * management interface=2E=
 We leave reassembly of fragmented messages to the
+ * management interface=
=2E
+ *
+ * @param c            The context struct
+ * @param buffer       =
Buffer containing the control message with ACC
+ */
+void
+receive_acc_mess=
age(struct context *c, const struct buffer *buffer);
+
+
+bool
+send_acc_me=
ssage(struct context *c,
+                 struct tls_multi *tls_multi,
+  =
               struct tls_session *session,
+                 const char *p=
rotocol, bool fragment,
+                 const char *msg, bool base64);
+
=
+
+/**
+ * Parses an info message from the server that contains app custom =
control info
+ * information prior to the PUSH_REPLY to be able to use app =
custom control
+ * protocols before sending
+ *
+ * In client mode only all=
ow what we support ourselves=2E In server mode
+ * allow also capabilities =
that we not support ourselves=2E
+ *
+ * @param capabilities      The strin=
g to parse
+ * @param delim             The delimiter to use when parsing t=
he string=2E
+ *                          IV_ACC uses "," as delimiter whil=
e the
+ *                          custom-control PUSH message uses " " as =
"," is
+ *                          already used to separate different push=
 directives
+ * @param max_acc_len       Set to the maximum ACC message len=
gth
+ * @param server            Whether we are server or client
+ * @param=
 gc                The gc arena to use for allocating the resulting string
=
+ * @return                  The resulting protocol string or NULL on error=

+ */
+char *
+parse_acc_parameters(const char *capabilities,
+            =
         const char *delim,
+                     int *max_acc_len,
+      =
               bool server,
+                     struct gc_arena *gc);
+
+=
/**
+ * Parses the IV_ACC of the peer and sets c->options=2Eacc_negotiated_=
protocols
+ * to the common protocols of server and client and
+ * c->optio=
ns=2Eapp_custom_protocol_len  to the maximum length of the ACC message
+ * =
support by both server and client=2E
+ *
+ * If there is no common protocol=
 or the client does not support any app custom
+ * protocol c->options=2Eac=
c_negotiated_protocols will be set to NULL=2E
+ *
+ * @param c     the clie=
nt context to use the set the app custom protocols=2E
+ */
+void
+determine=
_common_acc_protocols(struct context *c);
+#endif
diff --git a/src/openvpn/=
forward=2Ec b/src/openvpn/forward=2Ec
index 46e1a53=2E=2E48a9b7c 100644
---=
 a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
=
 #include "dco=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+=
#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -251,11 +252,11 @@
     }
=
     else if (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        s=
erver_pushed_info(buf, 8);
+        server_pushed_info(c, buf, 8);
     }
 =
    else if (buf_string_match_head_str(buf, "INFO"))
     {
-        server=
_pushed_info(buf, 4);
+        server_pushed_info(c, buf, 4);
     }
     e=
lse if (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -265,6 +26=
6,10 @@
     {
         receive_auth_pending(c, buf);
     }
+    else if (=
buf_string_match_head_str(buf, "ACC"))
+    {
+        receive_acc_message(=
c, buf);
+    }
     else if (buf_string_match_head_str(buf, "EXIT"))
     =
{
         receive_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec
index 101fa64=2E=2Efc7e9b4 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2283,6 +2283,10 @@
             buf_pri=
ntf(&out, " aead-epoch");
         }
     }
+    if (c->options=2Eacc_negot=
iated_protocols)
+    {
+        buf_printf(&out, "custom-control %d,A:6,%s=
", c->options=2Eapp_custom_protocol_len, c->options=2Eacc_negotiated_protoc=
ols);
+    }
 
     if (BLENZ(&out) > strlen(header))
     {
@@ -2527,6 +25=
31,11 @@
         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    i=
f (c->options=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }=

+
     return flags;
 }
 
@@ -3342,6 +3351,7 @@
     to=2Everify_hash_dept=
h =3D options->verify_hash_depth;
     to=2Everify_hash_no_ca =3D options->=
verify_hash_no_ca;
     memcpy(to=2Ex509_username_field, options->x509_user=
name_field, sizeof(to=2Ex509_username_field));
+    to=2Eacc_protocols =3D =
options->acc_protocols;
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D =
&c->net_ctx;
 
@@ -4300,6 +4310,27 @@
 }
 #endif /* ifdef TARGET_ANDROID */=

 
+static bool
+management_acc_msg(void *arg,
+                   struct b=
uffer_list *input) /* ownership transferred */
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct context *c =3D arg;
+
+    bool ret =3D true;
+  =
  if (buffer_list_defined(input))
+    {
+        struct tls_multi *multi =
=3D c->c2=2Etls_multi;
+        struct tls_session *session =3D &multi->ses=
sion[TM_ACTIVE];
+        struct options *opt =3D &c->options;
+
+        r=
et =3D management_send_acc_message(c, multi, session, opt->acc_negotiated_p=
rotocols, input);
+    }
+
+    buffer_list_free(input);
+    gc_free(&gc);=

+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4316=
,6 +4347,7 @@
         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;
  =
       cb=2Eremote_cmd =3D management_callback_remote_cmd;
         cb=2Ese=
nd_cc_message =3D management_callback_send_cc_message;
+        cb=2Eacc_ms=
g =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_chan=
ge =3D management_callback_network_change;
 #endif
diff --git a/src/openvpn=
/manage=2Ec b/src/openvpn/manage=2Ec
index bfc2aa2=2E=2Ea9f2463 100644
--- =
a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,8 +44,10 @@
 #=
include "dco=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#include "acc=
=2Eh"
 
 #include "memdbg=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKC=
S11
 #include "pkcs11=2Eh"
@@ -1080,6 +1082,35 @@
             }
          =
   break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (man->persist=
=2Ecallback=2Eclient_acc_msg)
+            {
+                bool status =
=3D (*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecallback=2Ea=
rg,
+                                                                      =
man->connection=2Ein_extra_cid,
+                                          =
                            man->connection=2Ein_extra_kid,
+              =
                                                        man->connection=2Ei=
n_extra);
+                man->connection=2Ein_extra =3D NULL;
+          =
      report_command_status(status, "client-acc-msg");
+            }
+    =
        else
+            {
+                man_command_unsupported("clien=
t-acc-msg");
+            }
+            break;
+
+        case IEC_ACC_MSG=
:
+            if (man->persist=2Ecallback=2Eacc_msg)
+            {
+     =
           bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(man->persis=
t=2Ecallback=2Earg,
+                                                      =
         man->connection=2Ein_extra);
+                man->connection=2Ein=
_extra =3D NULL;
+                report_command_status(status, "acc-msg");=

+            }
+            else
+            {
+                man_comma=
nd_unsupported("acc-msg");
+            }
+            break;
         case=
 IEC_PK_SIGN:
             man->connection=2Eext_key_state =3D EKS_READY;
 =
            buffer_list_free(man->connection=2Eext_key_input);
@@ -1204,6 +=
1235,29 @@
 }
 
 static void
+man_client_acc_msg(struct management *man, co=
nst char *cid_str,
+                   const char *kid_str)
+{
+    struct =
man_connection *mc =3D &man->connection;
+    mc->in_extra_cid =3D 0;
+    =
mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+   =
     && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+        mc->=
in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
=
+    }
+}
+
+static void
+man_acc_msg(struct management *man)
+{
+    struc=
t man_connection *mc =3D &man->connection;
+    mc->in_extra_cmd =3D IEC_AC=
C_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_client_auth=
(struct management *man, const char *cid_str, const char *kid_str, const bo=
ol extra)
 {
     struct man_connection *mc =3D &man->connection;
@@ -1760,=
6 +1814,17 @@
             man_client_pending_auth(man, p[1], p[2], p[3], p=
[4]);
         }
     }
+    else if (streq(p[0], "client-acc-msg"))
+    {=

+        if (man_need(man, p, 2, 0))
+        {
+            man_client_ac=
c_msg(man, p[1], p[2]);
+        }
+    }
+    else if (streq(p[0], "acc-ms=
g"))
+    {
+        man_acc_msg(man);
+    }
     else if (streq(p[0], "rs=
a-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -3121,6 +3186,7 @@
=
     }
 }
 
+
 void
 management_connection_established(struct management *m=
anagement, struct man_def_auth_context *mdac,
                             =
      const struct env_set *es)
@@ -4352,6 +4418,65 @@
     }
 }
 
+bool
+m=
anagement_send_acc_message(struct context *c, struct tls_multi *multi, stru=
ct tls_session *session,
+                            const char *negotiate=
d_protocols, struct buffer_list *input)
+{
+    /* ensure that are enough i=
nputs in the list */
+    if (!input || input->size < 3)
+    {
+        ms=
g(M_CLIENT, "not enough input lines for acc message");
+        return fals=
e;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    const struct buffe=
r *proto_buf =3D buffer_list_peek(input);
+    const char *protocol =3D str=
ing_alloc(BSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+    const =
struct buffer *encoding_buf =3D buffer_list_peek(input);
+    char *encodin=
g =3D buf_str(encoding_buf);
+    char *flag =3D NULL;
+    bool b64encodin=
g =3D false;
+    bool fragment =3D false;
+
+    while ((flag =3D strsep(&=
encoding, ":")))
+    {
+        if (!strcmp(flag, "6"))
+        {
+      =
      b64encoding =3D true;
+        }
+        else if (!strcmp(flag, "F")=
)
+        {
+            fragment =3D true;
+        }
+    }
+    buffer_=
list_pop(input);
+
+    buffer_list_aggregate_separator(input, 10000, "");
=
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);
+
+    i=
f (!proto_buf || !acc_msg_buf)
+    {
+        msg(M_CLIENT, "missing proto=
col or message");
+        goto error;
+    }
+    if (!negotiated_protocol=
s || !tls_item_in_cipher_list(protocol, negotiated_protocols))
+    {
+    =
    msg(M_CLIENT, "protocol not in the list of negotiated protocols: %s", n=
p(negotiated_protocols));
+        goto error;
+    }
+
+    bool ret =3D s=
end_acc_message(c, multi, session, protocol,
+                             =
   fragment, buf_str(acc_msg_buf),
+                                b64enco=
ding);
+    gc_free(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    =
return false;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2E=
h"
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 71e88=
d0=2E=2E39bdf99 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manag=
e=2Eh
@@ -184,12 +184,19 @@
     int (*n_clients)(void *arg);
     bool (*s=
end_cc_message)(void *arg, const char *message, const char *parameter);
   =
  bool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_=
msg);
+
     bool (*client_auth)(void *arg, const unsigned long cid, const =
unsigned int mda_key_id,
                         const bool auth, const ch=
ar *reason, const char *client_reason,
                         struct buff=
er_list *cc_config); /* ownership transferred */
     bool (*client_pending=
_auth)(void *arg, const unsigned long cid, const unsigned int kid,
        =
                         const char *extra, unsigned int timeout);
     cha=
r *(*get_peer_info)(void *arg, const unsigned long cid);
+    bool (*client=
_acc_msg)(void *arg,
+                           const unsigned long cid,
+=
                           const unsigned int mda_key_id,
+                =
           struct buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+     =
               struct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, =
const char **p);
     bool (*remote_cmd)(void *arg, const char **p);
 #ifde=
f TARGET_ANDROID
@@ -292,13 +299,15 @@
     struct command_line *in;
     s=
truct buffer_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AU=
TH 1
+#define IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #defin=
e IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#defin=
e IEC_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+=
#define IEC_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_=
SIGN        5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+=
#define IEC_ACC_MSG        8
     int in_extra_cmd;
     struct buffer_list=
 *in_extra;
     unsigned long in_extra_cid;
@@ -511,4 +520,13 @@
  */
 voi=
d management_sleep(const int n);
 
+/** Parses the ACC message from the inp=
ut buffer_list and send to the
+ * session identified by session and multi
=
+ */
+struct tls_session;
+struct tls_multi;
+bool
+management_send_acc_mes=
sage(struct context *c, struct tls_multi *multi, struct tls_session *sessio=
n,
+                            const char *negotiated_protocols, struct bu=
ffer_list *input);
+
 #endif /* ifndef MANAGE_H */
diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec
index dda5c6b=2E=2Eae2b80d 100644
--- a/=
src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -52,6 +52,7 @@
 #inclu=
de "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#incl=
ude "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1773,6 +1774,13 @=
@
         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }
 
=
+    if (o->acc_protocols)
+    {
+        /* If ACC is enabled server side=
 call to find common acc protocols,
+         * will be pushed during push =
message */
+        determine_common_acc_protocols(c);
+    }
+
     /* Sel=
ect cipher if client supports Negotiable Crypto Parameters */
 
     /* if =
we have already created our key, we cannot *change* our own
@@ -4032,6 +404=
0,24 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(struc=
t context *c, struct gc_arena *gc)
+{
+    determine_common_acc_protocols(c=
);
+
+    if (!c->options=2Eacc_negotiated_protocols)
+    {
+        msg(M=
_CLIENT, "ACC: No negotiated protocols");
+        return NULL;
+    }
+
+ =
   struct buffer buf =3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "A=
CC:%d A:6 %s", c->options=2Eapp_custom_protocol_len, c->options=2Eacc_negot=
iated_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 managemen=
t_client_pending_auth(void *arg, const unsigned long cid, const unsigned in=
t mda_key_id,
                                const char *extra, unsigned i=
nt timeout)
@@ -4042,17 +4068,29 @@
     if (mi)
     {
         struct tls=
_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena =
gc =3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+          =
  extra =3D calculate_app_control_extra(&mi->context, &gc);
+            if=
 (!extra)
+            {
+                gc_free(&gc);
+                re=
turn false;
+            }
+        }
         struct tls_session *session =
=3D lookup_session_by_mda_key_id(multi, mda_key_id);
 
         if (!sessio=
n)
         {
             return false;
         }
-        
+
         /*=
 sends INFO_PRE and AUTH_PENDING messages to client */
         bool ret =
=3D send_auth_pending_messages(multi, session, extra, timeout);
         re=
schedule_multi_process(&mi->context);
         multi_schedule_context_wakeu=
p(m, mi);
+        gc_free(&gc);
         return ret;
     }
     return fa=
lse;
@@ -4096,6 +4134,39 @@
     return ret;
 }
 
+
+static bool
+managemen=
t_client_acc_msg(void *arg,
+                          const unsigned long =
cid,
+                          const unsigned int mda_key_id,
+           =
               struct buffer_list *input) /* ownership transferred */
+{
+ =
   struct multi_context *m =3D (struct multi_context *)arg;
+    struct mul=
ti_instance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+    =
if (mi && buffer_list_defined(input))
+    {
+        struct tls_multi *mul=
ti =3D mi->context=2Ec2=2Etls_multi;
+        struct tls_session *session =
=3D lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (!session)=

+        {
+            msg(M_CLIENT, "client session not found");
+      =
      buffer_list_free(input);
+            return false;
+        }
+
+   =
     struct options *opt =3D &mi->context=2Eoptions;
+
+        ret =3D man=
agement_send_acc_message(&mi->context, multi, session, opt->acc_negotiated_=
protocols, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
=
+    buffer_list_free(input);
+    return ret;
+}
+
+
 static char *
 manag=
ement_get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4132,6 +4203=
,7 @@
         cb=2En_clients =3D management_callback_n_clients;
         c=
b=2Ekill_by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth =3D m=
anagement_client_auth;
+        cb=2Eclient_acc_msg =3D management_client_a=
cc_msg;
         cb=2Eclient_pending_auth =3D management_client_pending_aut=
h;
         cb=2Eget_peer_info =3D management_get_peer_info;
         cb=2E=
push_update_broadcast =3D management_callback_send_push_update_broadcast;
d=
iff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 4391434=
=2E=2E65610a71 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/optio=
ns=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #=
include "buffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -7132,=
6 +7133,28 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->=
force_key_material_export =3D true;
     }
+    else if (streq(p[0], "app-c=
ustom-control") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_G=
ENERAL);
+        options->acc_protocols =3D p[1];
+    }
+    else if (str=
eq(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+      =
  VERIFY_PERMISSION(OPT_P_ACC);
+
+        if (!streq(p[2], "A:6") && !stre=
q(p[2], "6:A"))
+        {
+            msg(msglevel, "App custom control e=
ncoding must be base64 and ascii");
+            goto err;
+        }
+
+  =
      if (!atoi_constrained(p[1], &options->app_custom_protocol_len,
+     =
                         "app custom message message length", ACC_MIN_MSG_L=
EN, ACC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
+        =
}
+        options->acc_negotiated_protocols =3D p[3];
+    }
     else if =
(streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE:=
 --prng option ignored (SSL library PRNG is used)");
diff --git a/src/openv=
pn/options=2Eh b/src/openvpn/options=2Eh
index de69c8e=2E=2E3d3b526 100644
=
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -711,6 +711,=
16 @@
     /* force using TLS key material export for data channel key gene=
ration */
     bool force_key_material_export;
 
+    /** The app custom co=
ntrol protocols we should announce as supported */
+    const char *acc_pro=
tocols;
+
+    /** the protocols that are negotiated with the peer=2E As a =
client we
+     * trust the server pushed list here */
+    const char *acc=
_negotiated_protocols;
+
+    /** the maximum length of an ACC control chan=
nel message */
+    int app_custom_protocol_len;
+
     bool vlan_tagging;
=
     enum vlan_acceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -=
762,6 +772,7 @@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PU=
SH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define=
 OPT_P_ACC             (1ull << 32)
 
 /* Options allowed in the normal con=
figuration file */
 #define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MO=
DE | OPT_P_ACC | OPT_P_PEER_ID))
diff --git a/src/openvpn/push=2Ec b/src/op=
envpn/push=2Ec
index 5b15f71=2E=2E7697ec2 100644
--- a/src/openvpn/push=2Ec=

+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,9 @@
 #include "syshead=2Eh"
 
 #i=
nclude "push=2Eh"
+
+#include "acc=2Eh"
+#include "push_util=2Eh"
 #include=
 "options=2Eh"
 #include "crypto=2Eh"
 #include "ssl=2Eh"
@@ -220,9 +223,8 =
@@
 #endif
 }
 
-
 void
-server_pushed_info(const struct buffer *buffer, co=
nst int adv)
+server_pushed_info(struct context *c, const struct buffer *bu=
ffer, const int adv)
 {
     const char *m =3D "";
     struct buffer buf =
=3D *buffer;
@@ -232,6 +234,27 @@
         m =3D BSTR(&buf);
     }
 
+    =
if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        int max_acc_len =3D 0;
=
+
+
+        /* example string to parse: ACC:1400 A:6 flower:happy */
+    =
    /* Skip over the ACC: prefix */
+        m +=3D 4;
+
+        char *pro=
tocols =3D parse_acc_parameters(m, " ", &max_acc_len, false, &c->options=2E=
gc);
+        if (protocols)
+        {
+            c->options=2Eacc_negot=
iated_protocols =3D protocols;
+            c->options=2Eapp_custom_protoco=
l_len =3D max_acc_len;
+        }
+        else
+        {
+            msg=
(D_PUSH_ERRORS, "WARNING: Received ACC info command with invalid parameters=
");
+        }
+    }
+
 #ifdef ENABLE_MANAGEMENT
     struct gc_arena gc;
=
     if (management)
@@ -284,6 +307,7 @@
     msg(D_PUSH, "CR response was =
sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_=
PENDING request
  * @param buffer                buffer containing the keyw=
ords, the buffer's
@@ -440,7 +464,6 @@
     const char *const peer_info =3D=
 tls_multi->peer_info;
     unsigned int proto =3D extract_iv_proto(peer_in=
fo);
 
-
     /* Calculate the maximum timeout and subtract the time we alr=
eady waited */
     unsigned int max_timeout =3D
         max_uint(tls_mult=
i->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_window);
@@ -7=
31,6 +754,11 @@
                 client_max_mtu, o->ce=2Etun_mtu, o->ce=2Et=
un_mtu);
         }
     }
+
+    if (c->options=2Eacc_negotiated_protocols=
)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "custom-control %=
d A:6 %s", c->options=2Eapp_custom_protocol_len, c->options=2Eacc_negotiate=
d_protocols);
+    }
 }
 
 #if defined(__GNUC__) || defined(__clang__)
diff=
 --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E3ac=
a8a7 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 =
+52,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /**
=
  * @brief Handles the receiving of a push-update message and applies updat=
es to the specified
  * options=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_m=
essage(struct context *c);
 
-void server_pushed_info(const struct buffer *=
buffer, const int adv);
+void server_pushed_info(struct context *c, const s=
truct buffer *buffer, const int adv);
 
 void receive_cr_response(struct co=
ntext *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/push_uti=
l=2Ec b/src/openvpn/push_util=2Ec
index fcc5411=2E=2E6462a97 100644
--- a/s=
rc/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -370,4 +370,4 @=
@
 
     RETURN_UPDATE_STATUS(n_sent);
 }
-#endif /* ifdef ENABLE_MANAGEMEN=
T */
+#endif /* ifdef ENABLE_MANAGEMENT */
\ No newline at end of file
diff=
 --git a/src/openvpn/push_util=2Eh b/src/openvpn/push_util=2Eh
new file mod=
e 100644
index 0000000=2E=2Ec9cc680
--- /dev/null
+++ b/src/openvpn/push_ut=
il=2Eh
@@ -0,0 +1,34 @@
+/*
+ *  OpenVPN -- An application to securely tunn=
el IP networks
+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based
+ *             session authentication and key exchange,
+ *=
             packet encryption, packet authentication, and
+ *             =
packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvp=
n=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
=
+ *  This program is free software; you can redistribute it and/or modify
+=
 *  it under the terms of the GNU General Public License version 2
+ *  as =
published by the Free Software Foundation=2E
+ *
+ *  This program is distr=
ibuted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more deta=
ils=2E
+ *
+ *  You should have received a copy of the GNU General Public L=
icense along
+ *  with this program; if not, write to the Free Software Fou=
ndation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-130=
1 USA=2E
+ */
+
+#include "buffer=2Eh"
+
+/**
+ * Extract a field from buf =
that end with the \c sep character=2E The
+ * returned string is allocated =
in the gc_arena=2E If the seperator character
+ * is not found, the functio=
n returns the nullptr=2E
+ */
+char *
+extract_field(struct buffer *buf, ch=
ar sep, struct gc_arena *gc);
diff --git a/src/openvpn/ssl=2Ec b/src/openvp=
n/ssl=2Ec
index d5bd602=2E=2E12e19aa 100644
--- a/src/openvpn/ssl=2Ec
+++ b=
/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #inc=
lude "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ss=
l_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -2054,6 +2055,11 @@
             =
        }
                 }
             }
+
+            if (session->opt=
->acc_protocols)
+            {
+                buf_printf(&out, "IV_ACC=
=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+          =
  }
         }
     }
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openv=
pn/ssl_common=2Eh
index db61198=2E=2E3b326a7 100644
--- a/src/openvpn/ssl_c=
ommon=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -452,6 +452,9 @@
     size_t =
ekm_size;
 
     bool dco_enabled; /**< Whether keys have to be installed i=
n DCO or not */
+
+    /** The app custom control protocols we should annou=
nce as supported */
+    const char *acc_protocols;
 };
 
 /** @addtogroup =
control_processor
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tes=
ts/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=2Ecfa5efc 100644
--- a=
/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Make=
file=2Eam
@@ -103,9 +103,11 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D =
@TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ss=
l=2Ec \
+    test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_c=
ommon=2Eh \
-	mock_management=2Ec \
+	mock_management=2Ec mock_management=
=2Eh \
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
@@ -388,6 +393,7 @@
 	$(t=
op_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_re=
ference=2Ec
 
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/=
openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests=
/openvpn \
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/test=
s/unit_tests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2Ee3bf828 100644
=
--- a/tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/o=
penvpn/mock_management=2Ec
@@ -29,8 +29,11 @@
 
 #include "syshead=2Eh"
 
+=
#include <stdlib=2Eh>
 #include "manage=2Eh"
 
+#include "mock_management=
=2Eh"
+
 #ifdef ENABLE_MANAGEMENT
 
 struct management *management; /* GLOB=
AL */
@@ -61,3 +64,15 @@
 management_sleep(const int n)
 {
 }
+
+void
+init=
_mock_management(void)
+{
+    ALLOC_OBJ_CLEAR(management, struct managemen=
t);
+}
+
+void
+uninit_mock_management(void)
+{
+    free(management);
+}
\=
 No newline at end of file
diff --git a/tests/unit_tests/openvpn/mock_manag=
ement=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh
new file mode 1006=
44
index 0000000=2E=2Ee21aec43
--- /dev/null
+++ b/tests/unit_tests/openvpn=
/mock_management=2Eh
@@ -0,0 +1,32 @@
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
+#ifndef MOCK_MANAGEMENT_H
+#define MOCK_MA=
NAGEMENT_H
+void init_mock_management(void);
+
+void uninit_mock_management=
(void);
+
+#endif
diff --git a/tests/unit_tests/openvpn/mock_push_dependenc=
ies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
index 112bcfd=
=2E=2Ec16d0cb 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -43,7 +43=
,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF=
 | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SHAPER | OP=
T_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT_P_MESSAG=
ES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                =
     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHC=
PDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | =
OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
     return =
flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit=
_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=2E2b3e2dc=

--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,0 +1,236 @=
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
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyrigh=
t (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
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
 this program; if not, write to the Free Software Foundation, Inc=2E,
+ *  =
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifde=
f HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
=
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2Eh>
+#inclu=
de <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "=
acc=2Eh"
+#include "test_acc=2Eh"
+
+#include "mock_msg=2Eh"
+
+/* Mock fun=
ctions */
+bool
+send_control_channel_string_dowork(struct tls_session *ses=
sion,
+                                   const char *str, int msglevel)
+{=

+    assert_false(true);
+    return false;
+}
+
+void
+send_push_reply_au=
th_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_client_reason(str=
uct tls_multi *multi, const char *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgM=
BARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+                   =
 "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+              =
      "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+         =
           "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+    =
                "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
=
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgAr=
A" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4=
gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_ac=
c_parse_client_messages(void **state)
+{
+    /* ensure that the messages g=
et to mock_msg */
+    x_debug_level =3D 3;
+    management =3D (void *)0x1=
2345678;
+    struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=
=2E3 ClientHello */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD=
;
+
+    struct buffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eo=
ptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi=
, struct tls_multi, &gc);
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struc=
t tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D =
&c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt=
->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void =
*)msg, sizeof(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    assert_=
string_equal(mock_msg_buf, "Received custom app control message (protocol '=
cck1')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck=
1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSB=
hbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_=
buf, (void *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, =
&msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app cont=
rol message (protocol 'flower')");
+    assert_string_equal(mock_managment_=
buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEA=
AA=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    const char msg_incorrect=
_len[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbS=
AAS2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_=
len, sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+ =
   const char *error =3D "WARNING: Received malformed custom app control ch=
annel "
+                        "(field length 62, payload length 64 misma=
tch) message "
+                        "control message: 496e7367 496d316c=
 496a6f67 496d5a79 "
+                        "62326369 4c434141 65475a6d 2=
f534a7[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+ =
   assert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment=
_buf);
+    const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D=
";
+    buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));=

+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_=
buf, "Received custom app control message (protocol 'power', fragment)");
+=
    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG=
8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding =
present */
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,SSBh=
bSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_b=
uf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive=
_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed c=
ustom app control channel (number of "
+            "encodings must be exac=
tly one (B64=3D1, ASCII=3D1)) message control "
+            "message: 5353=
4268 62534141 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 =
37372b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+  =
  assert_string_equal(mock_managment_buf, "");
+
+    /* no encoding presen=
t */
+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlc=
m1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void=
 *)flower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_messag=
e(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom app c=
ontrol channel (number of "
+            "encodings must be exactly one (B6=
4=3D0, ASCII=3D0)) message control "
+            "message: 53534268 625341=
41 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[mor=
e=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_st=
ring_equal(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    manage=
ment =3D NULL;
+    gc_free(&gc);
+}
+
+void
+test_parse_acc_parameters(voi=
d **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* parameters to I=
NFO message */
+    const char *info_acc_msg =3D "4096 A:6 flower:happy";
+=

+    int max_len =3D 0;
+    const char *protocols =3D parse_acc_parameter=
s(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protoco=
ls, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a clie=
nt does not accept a length longer than it supports */
+    protocols =3D p=
arse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_n=
ull(protocols);
+
+    /* message with lower limit than our, should work fo=
r client and server */
+    info_acc_msg =3D "1111 A:6 flower:happy";
+    =
protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc)=
;
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equa=
l(max_len, 1111);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, "=
 ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy=
");
+    assert_int_equal(max_len, 1111);
+
+    /* more encodings than sup=
ported=2E Server should be okay, client should fail */
+    info_acc_msg =
=3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc_parameters(info=
_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+    p=
rotocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
=
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equal(=
max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg =3D "1400 A:=
6 flower:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, "=
 ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    protocols =3D=
 parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert=
_null(protocols);
+
+
+    const char *iv_acc_capabilities =3D "1400,A:6,fl=
ower:happy:power";
+    protocols =3D parse_acc_parameters(iv_acc_capabilit=
ies, ",", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower=
:happy:power");
+
+    /* too small protocol length */
+    info_acc_msg =
=3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_acc=
_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* non=
-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flower:happy =
77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &max_len, t=
rue, &gc);
+    assert_null(protocols);
+
+    /* non-numerical protocol le=
ngth */
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
+    struct context c =3D { 0 };
+    c=2Eoptions=2Egc=
 =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_mul=
ti, &c=2Eoptions=2Egc);
+
+    c=2Ec2=2Etls_multi->peer_info =3D "IV_PROTO=
=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c=2Eoptions=2Eacc_prot=
ocols =3D "power:flower:star";
+
+    determine_common_acc_protocols(&c);
+=

+    assert_int_equal(c=2Eoptions=2Eapp_custom_protocol_len, ACC_MAX_MSG_L=
EN);
+    assert_string_equal(c=2Eoptions=2Eacc_negotiated_protocols, "flow=
er:power");
+
+    gc_free(&c=2Eoptions=2Egc);
+}
\ No newline at end of fi=
le
diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/op=
envpn/test_acc=2Eh
new file mode 100644
index 0000000=2E=2E11ecf32
--- /dev=
/null
+++ b/tests/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,33 @@
+/*
+ * =
 OpenVPN -- An application to securely tunnel IP networks
+ *             o=
ver a single TCP/UDP port, with support for SSL/TLS-based
+ *             s=
ession authentication and key exchange,
+ *             packet encryption, =
packet authentication, and
+ *             packet compression=2E
+ *
+ *  C=
opyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025=
 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free softwa=
re; you can redistribute it and/or modify
+ *  it under the terms of the GN=
U General Public License version 2
+ *  as published by the Free Software F=
oundation=2E
+ *
+ *  This program is distributed in the hope that it will =
be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ =
*  GNU General Public License for more details=2E
+ *
+ *  You should have =
received a copy of the GNU General Public License along
+ *  with this prog=
ram; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Frankli=
n Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
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
+#endif
diff --git a/tests/unit_tests/openvpn/test_=
misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 5f03860=2E=2E18e435=
6 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_test=
s/openvpn/test_misc=2Ec
@@ -40,11 +40,35 @@
 #include "list=2Eh"
 #include =
"mock_msg=2Eh"
 #include "crypto=2Eh"
+#include "test_schedule=2Eh"
+#inclu=
de "mock_management=2Eh"
+#include "multi=2Eh"
+
 #ifdef _WIN32
 #include "=
win32-util=2Eh"
 #endif
-#include "test_schedule=2Eh"
 
+/* extra mocks */
=
+bool
+apply_push_options(struct context *c, struct options *options, struc=
t buffer *buf,
+                   uint64_t permission_mask, uint64_t *opti=
on_types_found,
+                   struct env_set *es, bool is_update)
+{
=
+    return true;
+}
+
+bool
+send_control_channel_string(struct context *c=
, const char *str, msglvl_t msglevel)
+{
+    check_expected_ptr(str);
+   =
 return true;
+}
+
+struct multi_instance *
+lookup_by_cid(struct multi_con=
text *m, const unsigned long cid)
+{
+    return *(m->instances);
+}
 
 sta=
tic void
 test_compat_lzo_string(void **state)
@@ -492,5 +516,8 @@
 main(vo=
id)
 {
     openvpn_unit_test_setup();
-    return cmocka_run_group_tests(m=
isc_tests, NULL, NULL);
+    init_mock_management();
+    int ret =3D cmock=
a_run_group_tests(misc_tests, NULL, NULL);
+    uninit_mock_management();
+=
    return ret;
 }
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tes=
ts/unit_tests/openvpn/test_ssl=2Ec
index d6b63d0=2E=2Eb3889cd 100644
--- a/=
tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_s=
sl=2Ec
@@ -52,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"=

 
+#include "test_acc=2Eh"
+
 /* Mock function to be allowed to include wi=
n32=2Ec which is required for
  * getting the temp directory */
 #ifdef _WI=
N32
@@ -87,6 +89,16 @@
     return;
 }
 
+/* Define a dummy dco cipher opti=
on to avoid linking against all the DCO
+ * units */
+#if defined(ENABLE_DC=
O)
+const char *
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-G=
CM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
+
 /*=
 generated using
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curv=
e:secp384r1 -keyout - \
  * -noenc -sha256 -days 3650 -subj '/CN=3Dovpn-tes=
t-secp384r1'  -nodes \
@@ -960,8 +972,10 @@
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
+        cmocka_unit_test(test_acc_common_protocols)
     };
=
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-=
Number: 1858
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--dRSvloxgMJU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Implement sending/receiving app custom control protocol<br><br>Cha=
nge-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Sc=
hwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-=
sections/client-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/open=
vpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M sr=
c/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec=
<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/op=
tions=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/o=
penvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>A src/openvpn/push_util=
=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/un=
it_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_managemen=
t=2Ec<br>A tests/unit_tests/openvpn/mock_management=2Eh<br>M tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_ac=
c=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/open=
vpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>27 files ch=
anged, 1,317 insertions(+), 22 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index =
6eb5954=2E=2E8f52e44 100644</span><br><span>--- a/CMakeLists=2Etxt</span><b=
r><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -424,6 +424,8 @@</span><b=
r><span>     src/compat/compat-gettimeofday=2Ec</span><br><span>     src/co=
mpat/compat-strsep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/acc=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><span>     src=
/openvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><sp=
an>@@ -560,8 +562,9 @@</span><br><span>     src/openvpn/ps=2Ec</span><br><s=
pan>     src/openvpn/ps=2Eh</span><br><span>     src/openvpn/push=2Ec</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/push_util=
=2Ec</span><br><span>     src/openvpn/push=2Eh</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/push_util=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/push_util=2Eh</span><b=
r><span>     src/openvpn/pushlist=2Eh</span><br><span>     src/openvpn/refl=
ect_filter=2Ec</span><br><span>     src/openvpn/reflect_filter=2Eh</span><b=
r><span>@@ -812,7 +815,10 @@</span><br><span>             tests/unit_tests/=
openvpn/mock_management=2Ec</span><br><span>             tests/unit_tests/o=
penvpn/mock_ssl_dependencies=2Ec</span><br><span>             tests/unit_te=
sts/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            tests/unit_tests/openvpn/test_acc=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/acc=2Ec=
</span><br><span>             src/openvpn/argv=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/auth_token=2Ec</span=
><br><span>             src/openvpn/base64=2Ec</span><br><span>            =
 src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/cryp=
to_mbedtls=2Ec</span><br><span>@@ -826,8 +832,11 @@</span><br><span>       =
      src/openvpn/options_util=2Ec</span><br><span>             src/openvpn=
/otime=2Ec</span><br><span>             src/openvpn/packet_id=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/relia=
ble=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
src/openvpn/session_id=2Ec</span><br><span>             src/openvpn/run_com=
mand=2Ec</span><br><span>             src/openvpn/ssl_mbedtls=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/ssl_n=
cp=2Ec</span><br><span>             src/openvpn/ssl_openssl=2Ec</span><br><=
span>             src/openvpn/ssl_util=2Ec</span><br><span>             src=
/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -844,6 +853,8 @@</span><=
br><span>     target_sources(test_misc PRIVATE</span><br><span>         tes=
ts/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>         tests/un=
it_tests/openvpn/test_schedule=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        tests/unit_tests/openvpn/mock_management=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/base64=
=2Ec</span><br><span>         src/openvpn/options_util=2Ec</span><br><span>=
         src/openvpn/otime=2Ec</span><br><span>         src/openvpn/ssl_uti=
l=2Ec</span><br><span>diff --git a/doc/man-sections/client-options=2Erst b/=
doc/man-sections/client-options=2Erst</span><br><span>index 87c138a=2E=2E89=
ba7cf 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@=
@ -12,6 +12,17 @@</span><br><span>   When this option is set, OpenVPN will =
not drop incoming tun packets with</span><br><span>   same destination as h=
ost=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+--app-custom-control protocollist</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  Sets the list of supported app custom control protocol=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  These protoco=
ls are announced to the server when this option is used</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  as a client=2E If the option is set o=
n a server it will negotiate the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  common protocols with the client=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  The protocollist is a : separated list of protocol identifier=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  See management-notes=2Etxt in th=
e OpenVPN distribution  and the OpenVPN RFC</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  draft for a description of app custom control pro=
tocol support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> --auth-token token</span><br><span>   This is not an option =
to be used directly in any configuration files,</span><br><span>   but rath=
er push this option from a ``--client-connect`` script or a</span><br><span=
>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span=
><br><span>index d6b3fbb=2E=2Eb2dcc0a 100644</span><br><span>--- a/doc/mana=
gement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><=
br><span>@@ -798,6 +798,56 @@</span><br><span> The client should return the=
 response to the crtext challenge</span><br><span> using the cr-response co=
mmand=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+app custom control</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+If the special string &quot;ACC&qu=
ot; is passed as {EXTRA} OpenVPN will determine</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+the common app custom protocols between the cli=
ent and the sever and insruct</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+the client that the server will send control messages to the clie=
nt using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ACC pro=
tocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+The server should then use acc=
-msg command to send app custom control messages</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+to the client to faciliate the pending authent=
ication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (O=
penVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+------------------------------------------</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+This commands sends an app custom control message to a client,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+the format of the comman=
d is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID=
 -- client ID and Key ID=2E  See documentation for &quot;&gt;CLIENT:&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+notification for mor=
e info=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+protocol -- the ACC protocol =
identified that this message should be</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            tagged with=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+flags    -- a colon seperated list of the encoding and the flag if</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            the messa=
ge is a fragment=2E E=2Eg=2E &quot;6:F&quot; for a base64 encoded</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            message that is a=
lso a fragment and not complete yet=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
message  -- The message encoded in the encoding specified in flags</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+-----------------------------------------=
-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+This commands sends an app custom com=
mand to the peer, the format of the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+command is</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+See t=
he client-acc-msg command for more details about the format of the message=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- client=
-deny  (OpenVPN 2=2E1 or higher)</span><br><span> -------------------------=
----------------------</span><br><span> </span><br><span>@@ -1247,6 +1297,2=
3 @@</span><br><span>    response=2E Mechanisms that need multiple rounds o=
r more complex answers</span><br><span>    should implement a different res=
ponse type than CR_RESPONSE=2E</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+(6) App custom control message</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    This message is an application specific payload me=
ssage that is transported</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    over the OpenVPN control channel=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    In server mode:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIE=
NT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    In client mode:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&gt;ACC:{protocol},{fragment},{msg_base64}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    The protocol is a short ascii string identifying the app specific c=
ustom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocol a=
nd identifies the protocol=2E If fragment is set to 1, the message</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    is not complete and the =
next message should be concatenated to this message</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    to form a complete message=2E</span><=
br><span> </span><br><span> Variables:</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br>=
<span>index 7fd12b4=2E=2E4fcccf1 100644</span><br><span>--- a/src/openvpn/M=
akefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><spa=
n>@@ -42,6 +42,7 @@</span><br><span> sbin_PROGRAMS =3D openvpn</span><br><s=
pan> </span><br><span> openvpn_SOURCES =3D \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><br><span> 	argv=2Ec argv=
=2Eh \</span><br><span> 	auth_token=2Ec auth_token=2Eh \</span><br><span> 	=
base64=2Ec base64=2Eh \</span><br><span>@@ -121,7 +122,8 @@</span><br><span=
> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \</span><br>=
<span> 	ps=2Ec ps=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	push=2Ec push_util=2Ec push=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	push=2Ec push=2Eh \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	push_util=2Ec push_util=2Eh \</span><br><span> 	pushlist=
=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><br>=
<span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git a/src/openvp=
n/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2E2b7e65f</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,390 @@</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025=
 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
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
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;co=
nfig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;push_u=
til=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
sl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+enum acc_message_flag<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_B=
ASE64 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC=
_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+log_acc_message(struct context *c, const struct buff=
er *buf, int payload_len,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const char *protocol, int flags)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool fragment =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGME=
NT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MA=
NAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *payload_msg =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* For simplicity, we always encode payload to be base64 encoded</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if not already=
 in base64 format */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        char *b64out =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ASSERT(openvpn_base64_encode(BPTR(buf), payl=
oad_len, &amp;b64out) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gc_addspecial(b64out, free, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D b64out;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        payload_msg =3D BSTR(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_=
session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct man_def_auth_context *mda =
=3D session-&gt;opt-&gt;mda_context;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* server mode=2E Repor=
t client context */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_mult=
i)-&gt;mda_key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                mda-&gt;ci=
d, mda_key_id, protocol, fragment, payload_msg);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* Client mode=2E Do not a report a CLIENT id */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;=
&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payload_msg);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received custom app=
 control message (protocol &#39;%s&#39;%s)&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        protocol, fragment ? &quot;, fragment=
&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Parses the flags field of an app control message and moves the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  buffer past the f=
lags string=2E If there is an</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  error parsing the flags field the method returns -1 and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  puts the error reason=
 in err_reason</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(struct=
 buffer *buf, const char **err_reason, struct gc_arena *gc)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *flags =3D extract_field(buf, &#39;,&#=
39;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        *err_reason =3D &quot;could not extract=
 flags field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=
=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&#39=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D =
ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *err_re=
ason =3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return -1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* The message should be encoded with exactly one encoding=2E Ensure=
 that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only on=
e of the flags is present */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASC=
II);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool base64=
enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &=
quot;number of encodings must be exactly one &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;(B64=3D%=
d, ASCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                 base64enc, asciienc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        *err_reason =3D tmp;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return acc_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+receive_acc_message(struct context *c, const struct buffer *buffer)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *err_reas=
on =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example mes=
sage: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D *buffer;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&quot;ACC&quot;)) |=
| buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        err_reason =3D &quot;missing , after ACC&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* extract protocol, payload length, flags substrings */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocol =3D ex=
tract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!protocol)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        err_reason =3D &quot;could not extract protocol field&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int payload_len =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!buffer_read_int(&amp;buf, &amp;payl=
oad_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &=
quot;could not extract payload length field&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* comma after the length */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        err_reason =3D &quot;missing , after payload=
 len&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message_flags=
(&amp;buf, &amp;err_reason, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (flags &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* We should have a final NUL byte in the co=
ntrol message buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * and thus the length of the buffer should be payload_len + 1 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf=
) !=3D payload_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ch=
ar *tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        snprintf(tmp, 512, &quot;field length %d, paylo=
ad length %d mismatch&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                 payload_len, buf_len(&amp;buf) - 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 log_acc_message(c, &amp;buf, payload_len, protocol, flags);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app contro=
l channel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    &quot;(%s) message control message: %s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        format_hex(BPTR(&amp;=
buf), BLEN(&amp;buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi *t=
ls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       struct tls_session *session,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 const char *protocol, bool fragment,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const ch=
ar *msg, bool base64)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TODO chec=
k client capabilities */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* 3 for the encoding, potential F, and , 1 for the final flag, 5 =
for the message size itself */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;) + =
3 + strlen(protocol) + 1 + 5;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t len =3D max_header_size + strlen(msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (len &gt; PUSH_BUNDLE_SIZE)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_CLIENT, &quot;message length (%zu) exceeds maximum possibl=
e message length (%d)&quot;, len, PUSH_BUNDLE_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(len, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Example message: ACC,muppets,15,A=
,I am Miss Piggy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+               strlen(msg),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+               base6=
4 ? &quot;6&quot; : &quot;A&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+               fragment ? &quot;F&quot; : &quot;&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+               msg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    send_control_channel_string_dowork(se=
ssion, BSTR(&amp;buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    reschedule_multi_process(c);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const c=
har *capabilities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    const char *delim,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     int *max_acc_len,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     bool server,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_messa=
ge =3D string_alloc(capabilities, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *tmp_message_orig =3D tmp_message;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_me=
ssage, delim, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int accle=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *protocols =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In =
server mode we allow more capabilities than our own, in client</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * mode we reject if we shou=
ld use capabilities that we do not support */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int allowed_acc_len =3D server ? INT_MAX : AC=
C_MAX_MSG_LEN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_=
constrained(token, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG=
_LEN, allowed_acc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            goto done;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=
=3D 1 &amp;&amp; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_it=
em_in_cipher_list(&quot;6&quot;, token)))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custom control encodin=
g must include base64 and ascii&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            goto done;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p =3D=3D 1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot=
;) &amp;&amp; strcmp(token, &quot;6:A&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custom control enc=
oding must exactly base64 and ascii&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto done;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (p =3D=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    protocols =3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS,=
 &quot;Too many parameters for INFO ACC message/IV_SSO=2E&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(=
protocols, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocol=
s(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;op=
tions=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
No app custom protocols have been configured server-side=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protocols)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* We already have determi=
ned the common protocols=2E Doing this</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * again would just add an extra string allocati=
on to options-&gt;gc */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D204=
8,6:A,flower:power */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *peer_info =3D c-&gt;c2=2Etls_multi-&gt;peer_info;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char *iv_acc =3D extrac=
t_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   char *protocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max=
_acc_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!prot=
ocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ER=
RORS, &quot;WARNING: IV_ACC peer info variable of peer is malformed&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(protocols, &quo=
t;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er common_protocols =3D alloc_buf_gc(1024, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    while (token)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (tls_item_in_cipher_list(token, c-&gt;options=2Eacc_protocols))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* protocol is in b=
oth server and client list */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (buf_len(&amp;common_protocols) &gt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                buf_write_u8(&amp;co=
mmon_protocols, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            buf_printf(&amp;common_protocols, &quot;%s&quot;, token);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL=
, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;co=
mmon_protocols) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_PUSH_DEBUG, &quot;WARNING: No common app custom control protoco=
l=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_negotiated_protocols=
 =3D string_alloc(buf_str(&amp;common_protocols), &amp;c-&gt;options=2Egc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=
=2Eapp_custom_protocol_len =3D max_acc_len;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</sp=
an><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><=
br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ec86eb5d</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span=
><br><span>@@ -0,0 +1,92 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
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
0, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_=
LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_M=
AX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * This method parses an app custom con=
trol message and delivers it to the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * management interface=2E We leave reassembly of fragmente=
d messages to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 management interface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c =
           The context struct</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buffer       Buffer containing the control message with=
 ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, const s=
truct buffer *buffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi =
*tls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         struct tls_session *session,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                 const char *protocol, bool fragment,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const =
char *msg, bool base64);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Parses an info message from the server that co=
ntains app custom control info</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * information prior to the PUSH_REPLY to be able to use app cus=
tom control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * proto=
cols before sending</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In client mode=
 only allow what we support ourselves=2E In server mode</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * allow also capabilities that we not =
support ourselves=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param capabi=
lities      The string to parse</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param delim             The delimiter to use when parsing t=
he string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     IV_ACC uses &quot;,&quot; as delimiter while the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                       =
   custom-control PUSH message uses &quot; &quot; as &quot;,&quot; is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                       =
   already used to separate different push directives</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len       Set to the ma=
ximum ACC message length</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param server            Whether we are server or client</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc                Th=
e gc arena to use for allocating the resulting string</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return                  The resulting=
 protocol string or NULL on error</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
ar *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_param=
eters(const char *capabilities,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     const char *delim,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     int *max_acc_len,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     b=
ool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             struct gc_arena *gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses the IV_ACC=
 of the peer and sets c-&gt;options=2Eacc_negotiated_protocols</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * to the common protocols of se=
rver and client and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * c-&gt;options=2Eapp_custom_protocol_len  to the maximum length of the AC=
C message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * support=
 by both server and client=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If t=
here is no common protocol or the client does not support any app custom</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocol c-&gt;opti=
ons=2Eacc_negotiated_protocols will be set to NULL=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param c     the client context to use the set the app =
custom protocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(=
struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/f=
orward=2Ec</span><br><span>index 46e1a53=2E=2E48a9b7c 100644</span><br><spa=
n>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=
=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=
=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><=
span> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><spa=
n>@@ -251,11 +252,11 @@</span><br><span>     }</span><br><span>     else if=
 (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pus=
hed_info(buf, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      server_pushed_info(c, buf, 8);</span><br><span>     }</span><br><span=
>     else if (buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
erver_pushed_info(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        server_pushed_info(c, buf, 4);</span><br><span>     }</span>=
<br><span>     else if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&qu=
ot;))</span><br><span>     {</span><br><span>@@ -265,6 +266,10 @@</span><br=
><span>     {</span><br><span>         receive_auth_pending(c, buf);</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (buf_string_match_head_str(buf, &quot;ACC&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        receive_acc_message(c, buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else i=
f (buf_string_match_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {=
</span><br><span>         receive_exit_message(c);</span><br><span>diff --g=
it a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 101f=
a64=2E=2Efc7e9b4 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><b=
r><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2283,6 +2283,10 @@</=
span><br><span>             buf_printf(&amp;out, &quot; aead-epoch&quot;);<=
/span><br><span>         }</span><br><span>     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protoc=
ols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, =
&quot;custom-control %d,A:6,%s&quot;, c-&gt;options=2Eapp_custom_protocol_l=
en, c-&gt;options=2Eacc_negotiated_protocols);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     if =
(BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</span><br><spa=
n>@@ -2527,6 +2531,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE |=
 OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return flags;<=
/span><br><span> }</span><br><span> </span><br><span>@@ -3342,6 +3351,7 @@<=
/span><br><span>     to=2Everify_hash_depth =3D options-&gt;verify_hash_dep=
th;</span><br><span>     to=2Everify_hash_no_ca =3D options-&gt;verify_hash=
_no_ca;</span><br><span>     memcpy(to=2Ex509_username_field, options-&gt;x=
509_username_field, sizeof(to=2Ex509_username_field));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    to=2Eacc_protocols =3D options-&gt;a=
cc_protocols;</span><br><span>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><sp=
an>     to=2Enet_ctx =3D &amp;c-&gt;net_ctx;</span><br><span> </span><br><s=
pan>@@ -4300,6 +4310,27 @@</span><br><span> }</span><br><span> #endif /* if=
def TARGET_ANDROID */</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+management_acc_msg(void *arg,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   struct buffer_list *input) /* owne=
rship transferred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct context *c =3D arg;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (buffer_list_defined(input))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *session =3D =
&amp;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct options *opt =3D &amp;c-&gt;options;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_message(c, =
multi, session, opt-&gt;acc_negotiated_protocols, input);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buffer_list_free(input);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><=
br><span> </span><br><span> void</span><br><span>@@ -4316,6 +4347,7 @@</spa=
n><br><span>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</spa=
n><br><span>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</s=
pan><br><span>         cb=2Esend_cc_message =3D management_callback_send_cc=
_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=
=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</=
span><br><span>         cb=2Enetwork_change =3D management_callback_network=
_change;</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index bfc2aa2=2E=2Ea9f24=
63 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ =
b/src/openvpn/manage=2Ec</span><br><span>@@ -44,8 +44,10 @@</span><br><span=
> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;push=2Eh&quo=
t;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span=
> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><b=
r><span> </span><br><span> #ifdef ENABLE_PKCS11</span><br><span> #include &=
quot;pkcs11=2Eh&quot;</span><br><span>@@ -1080,6 +1082,35 @@</span><br><spa=
n>             }</span><br><span>             break;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_=
ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (man-&gt;persist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                bool status =3D (*man-&gt;persist=
=2Ecallback=2Eclient_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                                       man-&gt;connection=2Ein_extra_cid,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                                 man-&gt;connection=2Ein_ex=
tra_kid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                                                           man-&gt;connecti=
on=2Ein_extra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            man-&gt;connection=2Ein_extra =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                report_command_status(sta=
tus, &quot;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               man_command_unsupported(&quot;client-acc-msg&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case IEC_ACC_MSG:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Eac=
c_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                boo=
l status =3D (*man-&gt;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecall=
back=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                                       man-&gt;connection=
=2Ein_extra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          man-&gt;connection=2Ein_extra =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                report_command_status(status,=
 &quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    man_command_unsupported(&quot;acc-msg&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            break;</span><br><span>         case IE=
C_PK_SIGN:</span><br><span>             man-&gt;connection=2Eext_key_state =
=3D EKS_READY;</span><br><span>             buffer_list_free(man-&gt;connec=
tion=2Eext_key_input);</span><br><span>@@ -1204,6 +1235,29 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+man_client_acc_msg(struct management *man=
, const char *cid_str,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   const char *kid_str)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_=
kid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p=
arse_cid(cid_str, &amp;mc-&gt;in_extra_cid)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        &amp;&amp; parse_uint(kid_str, &quot;KID&qu=
ot;, &amp;mc-&gt;in_extra_kid))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      mc-&gt;in_extra_cmd =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        in_extra_reset(mc, IER_NEW);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg=
(struct management *man)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ma=
n_connection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_N=
EW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span> man_client_auth(struct =
management *man, const char *cid_str, const char *kid_str, const bool extra=
)</span><br><span> {</span><br><span>     struct man_connection *mc =3D &am=
p;man-&gt;connection;</span><br><span>@@ -1760,6 +1814,17 @@</span><br><spa=
n>             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);</span>=
<br><span>         }</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;client-acc-msg&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(man, p, 2,=
 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            man_client_ac=
c_msg(man, p[1], p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p=
[0], &quot;acc-msg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 man_acc_msg(man);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     else if (streq(p[0], &quot;rsa-sig&quot;))</span>=
<br><span>     {</span><br><span>         man_pk_sig(man, &quot;rsa-sig&quo=
t;);</span><br><span>@@ -3121,6 +3186,7 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> void</span><br><span> management_connection_estab=
lished(struct management *management, struct man_def_auth_context *mdac,</s=
pan><br><span>                                   const struct env_set *es)<=
/span><br><span>@@ -4352,6 +4418,65 @@</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
send_acc_message(struct context *c, struct tls_multi *multi, struct tls_ses=
sion *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       const char *negotiated_protocols, struct buffer_list=
 *input)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that are enough=
 inputs in the list */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!input || input-&gt;size &lt; 3)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_CLIENT, &quot;not enough input lines for acc messag=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *proto_buf =3D bu=
ffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *protocol =3D string_alloc(BSTR(proto_buf), &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(inp=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *encoding_=
buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    char *encoding =3D buf_str(encoding_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char *flag =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool b64encoding =3D false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fragment =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while ((flag =3D strsep(=
&amp;encoding, &quot;:&quot;)))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!strcmp(flag, &quot;6&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            b64encoding =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        else if (!strcmp(flag, &quot;F&quot;))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            fragment =3D true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buffer_list_aggregate_separator(input, 10000, &quot;&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buff=
er *acc_msg_buf =3D buffer_list_peek(input);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!proto_buf || !acc_msg_buf)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_CLIENT, &quot;missing protocol or message&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!negotiated_protocols || !tls=
_item_in_cipher_list(protocol, negotiated_protocols))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the list of=
 negotiated protocols: %s&quot;, np(negotiated_protocols));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool ret =3D send_acc_message(c, multi, session, protocol,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
       fragment, buf_str(acc_msg_buf),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                b64encoding);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_=
MANAGEMENT */</span><br><span> </span><br><span> #include &quot;win32=2Eh&q=
uot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/mana=
ge=2Eh</span><br><span>index 71e88d0=2E=2E39bdf99 100644</span><br><span>--=
- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</sp=
an><br><span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_clients)(vo=
id *arg);</span><br><span>     bool (*send_cc_message)(void *arg, const cha=
r *message, const char *parameter);</span><br><span>     bool (*kill_by_cid=
)(void *arg, const unsigned long cid, const char *kill_msg);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool (*clien=
t_auth)(void *arg, const unsigned long cid, const unsigned int mda_key_id,<=
/span><br><span>                         const bool auth, const char *reaso=
n, const char *client_reason,</span><br><span>                         stru=
ct buffer_list *cc_config); /* ownership transferred */</span><br><span>   =
  bool (*client_pending_auth)(void *arg, const unsigned long cid, const uns=
igned int kid,</span><br><span>                                 const char =
*extra, unsigned int timeout);</span><br><span>     char *(*get_peer_info)(=
void *arg, const unsigned long cid);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                           const unsigne=
d long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                   const unsigned int mda_key_id,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                           struct buffer_list=
 *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*a=
cc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   struct buffer_list *msg);</span><br><span>     bool (*pr=
oxy_cmd)(void *arg, const char **p);</span><br><span>     bool (*remote_cmd=
)(void *arg, const char **p);</span><br><span> #ifdef TARGET_ANDROID</span>=
<br><span>@@ -292,13 +299,15 @@</span><br><span>     struct command_line *i=
n;</span><br><span>     struct buffer_list *out;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF   =
       0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC=
_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FE=
ATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_=
RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define IEC_PASSWORD    6</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define IEC_RSA_SIGN       3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG    =
    8</span><br><span>     int in_extra_cmd;</span><br><span>     struct bu=
ffer_list *in_extra;</span><br><span>     unsigned long in_extra_cid;</span=
><br><span>@@ -511,4 +520,13 @@</span><br><span>  */</span><br><span> void =
management_sleep(const int n);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/** Parses the ACC message from the input buff=
er_list and send to the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * session identified by session and multi</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct tls_session;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct tls_multi;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manage=
ment_send_acc_message(struct context *c, struct tls_multi *multi, struct tl=
s_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            const char *negotiated_protocols, struct buffer=
_list *input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> #endif /* ifndef MANAGE_H */</span><br><span>diff --git a/src/=
openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index dda5c6b=2E=
=2Eae2b80d 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br>=
<span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dc=
o=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quo=
t;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</s=
pan><br><span> </span><br><span>@@ -1773,6 +1774,13 @@</span><br><span>    =
     o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (o-&gt;acc_protocols)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* If ACC is enabled server side call to find common acc protoc=
ols,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * will=
 be pushed during push message */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        determine_common_acc_protocols(c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     /* Select cipher if client sup=
ports Negotiable Crypto Parameters */</span><br><span> </span><br><span>   =
  /* if we have already created our key, we cannot *change* our own</span><=
br><span>@@ -4032,6 +4040,24 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cal=
culate_app_control_extra(struct context *c, struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(c);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc_negotiated_protocol=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC=
: No negotiated protocols&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf=
_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, c-&gt;options=2Eapp_custom_pro=
tocol_len, c-&gt;options=2Eacc_negotiated_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&amp;buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> static bool</span><br><span> management_client_pen=
ding_auth(void *arg, const unsigned long cid, const unsigned int mda_key_id=
,</span><br><span>                                const char *extra, unsign=
ed int timeout)</span><br><span>@@ -4042,17 +4068,29 @@</span><br><span>   =
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
><span>         {</span><br><span>             return false;</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
      /* sends INFO_PRE and AUTH_PENDING messages to client */</span><br><s=
pan>         bool ret =3D send_auth_pending_messages(multi, session, extra,=
 timeout);</span><br><span>         reschedule_multi_process(&amp;mi-&gt;co=
ntext);</span><br><span>         multi_schedule_context_wakeup(m, mi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc)=
;</span><br><span>         return ret;</span><br><span>     }</span><br><sp=
an>     return false;</span><br><span>@@ -4096,6 +4134,39 @@</span><br><spa=
n>     return ret;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+management_client_acc_msg(void *arg,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                          const unsigned long cid=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
        const unsigned int mda_key_id,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          struct buffer_list *input) /* =
ownership transferred */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mu=
lti_context *m =3D (struct multi_context *)arg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D lookup_by_cid=
(m, cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buf=
fer_list_defined(input))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *session=
 =3D lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!session)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;client session no=
t found&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct options *opt =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ret =3D management_send_acc_message(&amp;mi-&gt;cont=
ext, multi, session, opt-&gt;acc_negotiated_protocols, input);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_context_w=
akeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> static char *</span><br><span> management_get_peer_in=
fo(void *arg, const unsigned long cid)</span><br><span> {</span><br><span>@=
@ -4132,6 +4203,7 @@</span><br><span>         cb=2En_clients =3D management=
_callback_n_clients;</span><br><span>         cb=2Ekill_by_cid =3D manageme=
nt_kill_by_cid;</span><br><span>         cb=2Eclient_auth =3D management_cl=
ient_auth;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
b=2Eclient_acc_msg =3D management_client_acc_msg;</span><br><span>         =
cb=2Eclient_pending_auth =3D management_client_pending_auth;</span><br><spa=
n>         cb=2Eget_peer_info =3D management_get_peer_info;</span><br><span=
>         cb=2Epush_update_broadcast =3D management_callback_send_push_upda=
te_broadcast;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec</span><br><span>index 4391434=2E=2E65610a71 100644</span>=
<br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/o=
ptions=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><s=
pan> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br>=
<span> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;erro=
r=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><spa=
n>@@ -7132,6 +7133,28 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
ENERAL);</span><br><span>         options-&gt;force_key_material_export =3D=
 true;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (streq(p[0], &quot;app-custom-control&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        options-&gt;acc_protocols =3D p[1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;custom-control&quot;=
) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2], &quot;A:6&quot;)=
 &amp;&amp; !streq(p[2], &quot;6:A&quot;))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(msglevel, &quot;App custom control encoding mu=
st be base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ato=
i_constrained(p[1], &amp;options-&gt;app_custom_protocol_len,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                              &qu=
ot;app custom message message length&quot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LE=
N, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;acc_=
negotiated_protocols =3D p[3];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;prng&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>=
         msg(M_WARN, &quot;NOTICE: --prng option ignored (SSL library PRNG =
is used)&quot;);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src=
/openvpn/options=2Eh</span><br><span>index de69c8e=2E=2E3d3b526 100644</spa=
n><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn=
/options=2Eh</span><br><span>@@ -711,6 +711,16 @@</span><br><span>     /* f=
orce using TLS key material export for data channel key generation */</span=
><br><span>     bool force_key_material_export;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom contro=
l protocols we should announce as supported */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /** the protocols that are negotiated with the peer=
=2E As a client we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * trust the server pushed list here */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *acc_negotiated_protocols;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC control chan=
nel message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt app_custom_protocol_len;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     bool vlan_tagging;</span><br><span>     enum =
vlan_acceptable_frames vlan_accept;</span><br><span>     uint16_t vlan_pvid=
;</span><br><span>@@ -762,6 +772,7 @@</span><br><span> #define OPT_P_INLINE=
          (1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUSH_MTU        (=
1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt;=
 31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_A=
CC             (1ull &lt;&lt; 32)</span><br><span> </span><br><span> /* Opt=
ions allowed in the normal configuration file */</span><br><span> #define O=
PT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_ACC | OPT_P_PEER_I=
D))</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2E=
c</span><br><span>index 5b15f71=2E=2E7697ec2 100644</span><br><span>--- a/s=
rc/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><s=
pan>@@ -27,6 +27,9 @@</span><br><span> #include &quot;syshead=2Eh&quot;</sp=
an><br><span> </span><br><span> #include &quot;push=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;push_util=2Eh&quot;</span>=
<br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &quot=
;crypto=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><=
span>@@ -220,9 +223,8 @@</span><br><span> #endif</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pus=
hed_info(const struct buffer *buffer, const int adv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+server_pushed_info(struct context *c, con=
st struct buffer *buffer, const int adv)</span><br><span> {</span><br><span=
>     const char *m =3D &quot;&quot;;</span><br><span>     struct buffer bu=
f =3D *buffer;</span><br><span>@@ -232,6 +234,27 @@</span><br><span>       =
  m =3D BSTR(&amp;buf);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&=
quot;, 4) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ma=
x_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* example string to parse: ACC:1=
400 A:6 flower:happy */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* Skip over the ACC: prefix */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        m +=3D 4;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        char *protocols =3D parse_acc_parameters(m, &quot; &quot;, &amp;=
max_acc_len, false, &amp;c-&gt;options=2Egc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (protocols)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            c-&gt;options=2Eacc_negotiated_protocols =3D=
 protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    c-&gt;options=2Eapp_custom_protocol_len =3D max_acc_len;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;WARNING: Received ACC in=
fo command with invalid parameters&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_ar=
ena gc;</span><br><span>     if (management)</span><br><span>@@ -284,6 +307=
,7 @@</span><br><span>     msg(D_PUSH, &quot;CR response was sent by client=
 (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br=
><span>  * Parse the keyword for the AUTH_PENDING request</span><br><span> =
 * @param buffer                buffer containing the keywords, the buffer&=
#39;s</span><br><span>@@ -440,7 +464,6 @@</span><br><span>     const char *=
const peer_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned =
int proto =3D extract_iv_proto(peer_info);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate t=
he maximum timeout and subtract the time we already waited */</span><br><sp=
an>     unsigned int max_timeout =3D</span><br><span>         max_uint(tls_=
multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_wind=
ow);</span><br><span>@@ -731,6 +754,11 @@</span><br><span>                 =
client_max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(c-&gt;options=2Eacc_negotiated_protocols)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;custom-contr=
ol %d A:6 %s&quot;, c-&gt;options=2Eapp_custom_protocol_len, c-&gt;options=
=2Eacc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> #if d=
efined(__GNUC__) || defined(__clang__)</span><br><span>diff --git a/src/ope=
nvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span>index dff945f=2E=2E3ac=
a8a7 100644</span><br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ =
b/src/openvpn/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</span><br><span> <=
/span><br><span> int process_incoming_push_request(struct context *c);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /**</span><br><span>  * @brief Handles the receiving of a push-=
update message and applies updates to the specified</span><br><span>  * opt=
ions=2E</span><br><span>@@ -92,7 +93,7 @@</span><br><span> </span><br><span=
> void receive_exit_message(struct context *c);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void server_pushed_info(const s=
truct buffer *buffer, const int adv);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void server_pushed_info(struct context *c, const struct b=
uffer *buffer, const int adv);</span><br><span> </span><br><span> void rece=
ive_cr_response(struct context *c, const struct buffer *buffer);</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvp=
n/push_util=2Ec</span><br><span>index fcc5411=2E=2E6462a97 100644</span><br=
><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/pu=
sh_util=2Ec</span><br><span>@@ -370,4 +370,4 @@</span><br><span> </span><br=
><span>     RETURN_UPDATE_STATUS(n_sent);</span><br><span> }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_MANAGEMENT */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENA=
BLE_MANAGEMENT */</span><br><span>\ No newline at end of file</span><br><sp=
an>diff --git a/src/openvpn/push_util=2Eh b/src/openvpn/push_util=2Eh</span=
><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ec9cc680<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/push_util=
=2Eh</span><br><span>@@ -0,0 +1,34 @@</span><br><span style=3D"color: hsl(1=
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
 hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Extract a field from buf that end with the \c sep character=2E The</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * returned string is al=
located in the gc_arena=2E If the seperator character</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * is not found, the function returns the=
 nullptr=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+extract_field(struct buffer *buf, cha=
r sep, struct gc_arena *gc);</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index d5bd602=2E=2E12e19aa 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </span><br><s=
pan> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;=
ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;acc=2Eh&quot;</span><br><span> #include &quot;ssl_verify=2Eh&quot;=
</span><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br><span> #in=
clude &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -2054,6 +2055,11 @@</span>=
<br><span>                     }</span><br><span>                 }</span><=
br><span>             }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(session-&gt;opt-&gt;acc_protocols)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                buf_printf(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&q=
uot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>      =
   }</span><br><span>     }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>ind=
ex db61198=2E=2E3b326a7 100644</span><br><span>--- a/src/openvpn/ssl_common=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -4=
52,6 +452,9 @@</span><br><span>     size_t ekm_size;</span><br><span> </spa=
n><br><span>     bool dco_enabled; /**&lt; Whether keys have to be installe=
d in DCO or not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app cust=
om control protocols we should announce as supported */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><b=
r><span> };</span><br><span> </span><br><span> /** @addtogroup control_proc=
essor</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2E=
cfa5efc 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -103,9 +103,11 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> ss=
l_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br>=
<span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    test_acc=2Ec test_acc=2Eh \</span><br><spa=
n> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	mock_management=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	mock_management=2Ec mock_management=2Eh \</sp=
an><br><span> 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/buffer=2Ec \</span><br><span>@@ -127,6 +129,7 @@</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/ssl_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/ssl_mbedtls=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl=
_verify_mbedtls=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verif=
y_openssl=2Ec \</span><br><span>@@ -375,8 +378,10 @@</span><br><span> </spa=
n><br><span> misc_testdriver_SOURCES =3D test_misc=2Ec \</span><br><span> 	=
test_schedule=2Ec test_schedule=2Eh \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	mock_management=2Ec mock_management=2Eh \</span><br><spa=
n> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span>@@ -388,6=
 +393,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span>=
<br><span> 	-I$(top_srcdir)/src/compat \</span><br><span> 	-I$(top_srcdir)/=
tests/unit_tests/openvpn \</span><br><span>diff --git a/tests/unit_tests/op=
envpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</s=
pan><br><span>index 77f6ce2=2E=2Ee3bf828 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/mock_management=2Ec</span><br><span>@@ -29,8 +29,11 @@</span><b=
r><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdl=
ib=2Eh&gt;</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mo=
ck_management=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br>=
<span> struct management *management; /* GLOBAL */</span><br><span>@@ -61,3=
 +64,15 @@</span><br><span> management_sleep(const int n)</span><br><span> =
{</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+init_mock_management(void)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(management, struct manag=
ement);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+uninit_mock_management(void)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    free(management);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span>\ No newline at end of file</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/unit_tests/openvpn=
/mock_management=2Eh</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000=2E=2Ee21aec43</span><br><span>--- /dev/null</span><br><span>++=
+ b/tests/unit_tests/openvpn/mock_management=2Eh</span><br><span>@@ -0,0 +1=
,32 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single TCP/UDP port, with support for SSL/=
TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     session authentication and key exchange,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet encryption, packet authenti=
cation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet compression=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copy=
right (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lice=
nse version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as=
 published by the Free Software Foundation=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is distributed in the hope that it will be useful=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void init_mock_management(void);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id uninit_mock_management(void);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_push_dependenci=
es=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><spa=
n>index 112bcfd=2E=2Ec16d0cb 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/mock_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,8 @@</span><=
br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCK=
BUF | OPT_P_SOCKFLAGS</span><br><span>                      | OPT_P_SETENV =
| OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span> =
                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO =
| OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                 | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE=
 | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROU=
TE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    | OPT_P_ACC;</span><br><span>     return flags;</span><=
br><span> }</span><br><span> </span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><sp=
an>new file mode 100644</span><br><span>index 0000000=2E=2E2b3e2dc</span><b=
r><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_a=
cc=2Ec</span><br><span>@@ -0,0 +1,236 @@</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             session authentication and key excha=
nge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet encryption, packet authentication, and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@open=
vpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Co=
pyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
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
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the =
Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 US=
A=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Mock functions */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+send_control_channel_string_dowork(struct tls_session *sessi=
on,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                   const char *str, int msglevel)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(true);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_token(struct tls_=
multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
auth_set_client_reason(struct tls_multi *multi, const char *reason)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;           =
     \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot=
;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;QAXAB=
4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;ICAgaCBsIHA=
gJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;AUEAwQDAwAtAAIB=
AQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;93rQwityP9eKSijXgcQ=
=3D=3D&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_acc_parse_client_messages(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that the messages ge=
t to mock_msg */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 x_debug_level =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    management =3D (void *)0x12345678;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* contains a TLS 1=2E3 ClientHello */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char msg[] =3D &quot;AC=
C,cck1,384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer msg_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct context c =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC=
_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt =
=3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;md=
a_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg, sizeof(msg=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_=
message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(mock_msg_buf, &quot;Received custom app control message (pr=
otocol &#39;cck1&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC=
,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char flower_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGU=
g77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg, sizeof(flow=
er_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receiv=
e_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custo=
m app control message (protocol &#39;flower&#39;)&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managmen=
t_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94o=
CPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mo=
ck_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char msg_incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogIm=
Zyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (v=
oid *)msg_incorrect_len, sizeof(msg_incorrect_len));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *error =3D &quot;WARNING: Received malformed custom app control channel &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;(field length 62, payload length 64 mismatch) message &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     &quot;control message: 496e7367 496d316c 496a6f67 496d5a79 &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
&quot;62326369 4c434141 65475a6d 2f534a7[more=2E=2E=2E]&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(m=
ock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    C=
LEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=
=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_s=
et_read(&amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp=
;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(mock_msg_buf, &quot;Received custom app control mess=
age (protocol &#39;power&#39;, fragment)&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &q=
uot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* check two encoding present */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg_two_=
encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZ=
yEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof(flower_ms=
g_two_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
ceive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    error =3D &quot;WARNING: Received malformed custom app control channe=
l (number of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;encodings must be exactly one (B64=3D1, ASCII=3D1)) messa=
ge control &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;message: 53534268 62534141 4945746c 636d3170 6443442f 2f534=
230 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* no encoding present */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char flower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhb=
SAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)f=
lower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Received m=
alformed custom app control channel (number of &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;encodings must be exact=
ly one (B64=3D0, ASCII=3D0)) message control &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;message: 53534268 62534=
141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;61475567 37372b3[more=2E=2E=2E=
]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    management =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
parse_acc_parameters(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* parameters to INFO message */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &quot;4096 =
A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_len=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;ma=
x_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, =
1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* a client does not accept =
a length longer than it supports */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot;=
 &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* message with lower limit than our, should work for client a=
nd server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inf=
o_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_ac=
c_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;=
flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(max_len, 1111);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1=
111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than suppor=
ted=2E Server should be okay, client should fail */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B flo=
wer:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_l=
en, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6=
 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &am=
p;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_le=
n, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capabil=
ities =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv_ac=
c_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols,=
 &quot;flower:happy:power&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* too small protocol length */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_pa=
rameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol length *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =
=3D &quot;abff A:6 flower:happy 77&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, =
&quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* non-numerical protocol length */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flow=
er:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max=
_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_acc_common_protocols(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct context c =3D { 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct=
 tls_multi, &amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 c=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,=
A:6,flower:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    c=2Eoptions=2Eacc_protocols =3D &quot;power:flower:star&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(&a=
mp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(c=2Eoptions=
=2Eapp_custom_protocol_len, ACC_MAX_MSG_LEN);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(c=2Eoptions=2Eacc_negotia=
ted_protocols, &quot;flower:power&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests=
/openvpn/test_acc=2Eh</span><br><span>new file mode 100644</span><br><span>=
index 0000000=2E=2E11ecf32</span><br><span>--- /dev/null</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,33 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secu=
rely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             se=
ssion authentication and key exchange,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you=
 can redistribute it and/or modify</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  it under the terms of the GNU General Public License ver=
sion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publis=
hed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is distributed in the hope that it will be useful,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  G=
NU General Public License for more details=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, write to the Free Software Foundation, Inc=2E,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fif=
th Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_pars=
e_client_messages(void **state);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
est_parse_acc_parameters(void **state);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void test_acc_common_protocols(void **state);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>index 5f03860=2E=2E18e4356 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>@@ -40,11 +40,35 @@</span><br><span> #includ=
e &quot;list=2Eh&quot;</span><br><span> #include &quot;mock_msg=2Eh&quot;</=
span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_manageme=
nt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #ifdef _WIN32</span><br><span> #include &quot;win32-u=
til=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#include &quot;test_schedule=2Eh&quot;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* extra mocks */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct context *c, s=
truct options *options, struct buffer *buf,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                   uint64_t permission_mask, uint64=
_t *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   struct env_set *es, bool is_update)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(struct=
 context *c, const char *str, msglvl_t msglevel)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    check_expected_ptr(str);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instanc=
e *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lookup_by_cid(st=
ruct multi_context *m, const unsigned long cid)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return *(m-&gt;instances);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span> </span><br><span> static void</span=
><br><span> test_compat_lzo_string(void **state)</span><br><span>@@ -492,5 =
+516,8 @@</span><br><span> main(void)</span><br><span> {</span><br><span>  =
   openvpn_unit_test_setup();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return cmocka_run_group_tests(misc_tests, NULL, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    init_mock_management();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D cmoc=
ka_run_group_tests(misc_tests, NULL, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uninit_mock_management();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_t=
ests/openvpn/test_ssl=2Ec</span><br><span>index d6b63d0=2E=2Eb3889cd 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,=
8 @@</span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> =
#include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock func=
tion to be allowed to include win32=2Ec which is required for</span><br><sp=
an>  * getting the temp directory */</span><br><span> #ifdef _WIN32</span><=
br><span>@@ -87,6 +89,16 @@</span><br><span>     return;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Define a dummy dco cipher option to avoid linking against all the DCO</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * units */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128-CBC=
:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /* generated using</span><br><span>  * openssl req -x509 -=
newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>=
  * -noenc -sha256 -days 3650 -subj &#39;/CN=3Dovpn-test-secp384r1&#39;  -n=
odes \</span><br><span>@@ -960,8 +972,10 @@</span><br><span>         cmocka=
_unit_test(test_data_channel_known_vectors_epoch),</span><br><span>        =
 cmocka_unit_test(test_data_channel_known_vectors_shortpktid),</span><br><s=
pan>         cmocka_unit_test(crypto_test_print_cert_details),</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_=
extract_peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(ssl_test_extract_peer_info),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_acc_parse_client_messages),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_parse_acc_parameters),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_acc_common_protocols)</span><br><span=
>     };</span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENS=
SL)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896=
b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--dRSvloxgMJU=--


--===============0274239588052581552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0274239588052581552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0274239588052581552==--

