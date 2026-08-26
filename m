Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96C5C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=caHAor+FxF3ljuhADeaHszZUvLzy8cOSf9w2Kx6I91k=; b=eR7INa7qZut+ctLmK2YJP35apj
	jLgS0AcSO9AXwCJ+NBAF3ZiBUI4MD3ct6PfTUZutOseOWCExAVbl4BVsPTevdSe+kasMJ0uArNYrg
	PgzRpne752H+rsZrr8Jh+7UV3nuC/c6uRnFWxr2SrnjHd9BAxwYX2Y1QL6we81Kh3q08=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzCB9-0002Ab-Ks;
	Wed, 26 Aug 2026 11:52:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzCB7-0002AN-GI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A+btQuK+QeQAxd3roAqv7iOEf3a9wylQ6j+RQqTnOAI=; b=Ofs3XwD7ssJn9zLhd/W8jbuur4
 8GPPXk02p8Hlvo+4bGcYXECs1pW9p9J6FY7uMAjfLU2srQr1eCIzAxrS1na1zkDgEFupu1euGO3gm
 0HMoH5bqp4G0edSO0MMAMinWP2RrXtTg/TxW5/zSNpOiCGodHBS8NT4xWRyxlELXVYP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A+btQuK+QeQAxd3roAqv7iOEf3a9wylQ6j+RQqTnOAI=; b=L
 8VkPk4Qyj6NWxUKkZx9RtvNKJS40fOVyNWKYqS500W4VJJQsLMTY+eSA11Z4RrtKRzMzmiCeW0OYp
 HR4uDS+X6AQ4N9HW7pStZwpJeGSJZQMDBz6PeXUVBNsEr5c4GB2xFe9ryaXPVBTAspsL2S72D4pWC
 pj867GloJQL7rs7U=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzCAv-0000yR-Ux for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:20 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so911328a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 04:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787745127; x=1788349927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A+btQuK+QeQAxd3roAqv7iOEf3a9wylQ6j+RQqTnOAI=;
 b=TG45F7PN2AM32fVMWDMqlk6ssVsSbksxG6TKFRNg04UyNYoIj+d4JzdbU/zuZ8kNB8
 U6Q+mVVFzxND20v2ltHRhGH3wJdJfdp16t8Z3BQQYoCeJTFrpv3+2bSGFQ2580e1Jz17
 D+oh7EWrmjsQooY+/8S0aAANkEJgIG+hUEzCfr3w0PkY01FlplTI7XHNRlTjiGrmSuSD
 pVOfvMsVSxmAoINXqmUW5KamqYFG+QrRzHvYkQVS3cF8LmftpiRijsS0c5C5IQcCc84H
 k7Tp6gj477dmkLE5L8Mt93iC6kmAp/bvhwLLuSa+e7f/46J5CiJTh9eQOBwkcRrhFb9+
 ZiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787745127; x=1788349927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A+btQuK+QeQAxd3roAqv7iOEf3a9wylQ6j+RQqTnOAI=;
 b=T97GP3Dxoheu9OL3/j/nypEwYF7GVMK4gJ5v0+FYtrWTwyQHr1F2zTsVQIcWP4D8bb
 0UaIDB/gVEz3Xa60GJWWtMrBdryQp9Xc3qpmq0upPrb8g72+yH/iBlRbpQoPYEaw1Twv
 S3HFbVndKdt5KAPNCX8qigH9YPywUkj9Q6uqZwjOpFVpqWr2O/tt06XCs8l+KUprdske
 EETF40pJzp9hFSuieu9p5OYbgIGvbdqeEJ+mgTWbxxRqFxE8c4xVrMYQkQFVJ5hoj8+w
 en2QNiaFl5BeUof3kax33pIK38JzZgbf1Bo03GOGf9Xw1JjivRd17tWLQ2cJReBhhyz7
 +Riw==
X-Gm-Message-State: AFuF++k9R3pW0+qRI+1VXOOECJbST/XZbL+cGm4+c9yjdhGXbopx9wFD
 GUlxcntZTKb8+2Hcgk9WYzu9QVErAZ+60SkKSX4RPlVotSreyJHIUrdnM/xTvnT+wslG+OpQOA+
 fNUH2ATYFbXNJmmraFlAWTRBS6QdEgWmU9Jau/hE+vkz7mYm1C42EuzNf7fBfecy6CR5JpsxcG/
 s/ST/wiw==
X-Gm-Gg: AR+sD13N3JOq+jKYRhIoV3xMusZ7WXrJFzk2Zezsq7I4mb9iA/y4awzZJQWSYjfZq2O
 psMv2n7PJ9e2jgq1TS/Hp3JO+Bq2/UVW7AaShpakdjdaH3FYckNzua0AkvWq+C5Cix3tLPlC8NM
 ah4iqjwnGJFrJWFOoGuD9xTt9paZHObqSS+diXeIEqeCVHtwJtdkTrGCY9wf7xNyLvD1wuOpel5
 dRd7nMsXo/prC/7DHQ1QRwR4hTq+vfLzIrlNU1k3ptA4fcP86ZFX5ghETwXslZYJ0jWquiFJIaX
 NHdZRKX5ctU260e6OairIFTVLbH1CctolFC7kfPNiKBb7lEYADIKIDItPFiUJ44TWmFgkzYD4JR
 P+OgkGSQ9DdJMWkSyyIYL7ZhBhwVCU4J6J/cwwhz3I+ygAOyY6cmt8cMkPjR7yzkYTl5I7nYD06
 C/nYvte8LlFqNASQWrzvAoivjhGcYX7yvP6cB2sdG/Uf0CbV/u9saWI+JvYxXpzsp6aXOwcCoOV
 yUaiTNxCmo4MCMI7A9J9dkzLfq5oMFQjJmSchdYUIzPrq3jDEriEGW/O8+xwSvcEigepmf8ZxTh
 wb99078+X3oNt1Wv4H3musSDpU0stoCp4LW5T5+YwPhfHcxqFGo=
X-Received: by 2002:a05:6402:190c:b0:6a1:29ca:681e with SMTP id
 4fb4d7f45d1cf-6a5df5e18c6mr7532946a12.7.1787745126370; 
 Wed, 26 Aug 2026 04:52:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83ba0sm3981439a12.14.2026.08.26.04.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:52:05 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 11:51:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: ae69bda99914f727fb69583d84c44d0aa04929af
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cc6792e9cf3ed14e025c41fb2678bd321e073cad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzCAv-0000yR-Ux
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
Content-Type: multipart/mixed; boundary="===============4518699328949357508=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4518699328949357508==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dHvo4a+KAiU="; charset=UTF-8

--dHvo4a+KAiU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#7)=2E ( http://gerrit=2Eopenvpn=2E=
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
M tests/unit_tests/openvpn/test_common=2Eh
M tests/unit_test=
s/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
27 files ch=
anged, 1,343 insertions(+), 27 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/58/1858/7

diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ea9331c2 100644
--- a/CMakeLists=
=2Etxt
+++ b/CMakeLists=2Etxt
@@ -424,6 +424,8 @@
     src/compat/compat-ge=
ttimeofday=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-str=
tok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvp=
n/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -560,9 =
+562,9 @@
     src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/openvpn/=
push=2Ec
-    src/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
-    src/=
openvpn/pushlist=2Eh
+    src/openvpn/push_util=2Ec
+        src/openvpn/pu=
shlist=2Eh
     src/openvpn/reflect_filter=2Ec
     src/openvpn/reflect_fil=
ter=2Eh
     src/openvpn/reliable=2Ec
@@ -812,7 +814,10 @@
             tes=
ts/unit_tests/openvpn/mock_management=2Ec
             tests/unit_tests/ope=
nvpn/mock_ssl_dependencies=2Ec
             tests/unit_tests/openvpn/mock_w=
in32_execve=2Ec
+            tests/unit_tests/openvpn/test_acc=2Ec
+       =
     src/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
+            src=
/openvpn/auth_token=2Ec
             src/openvpn/base64=2Ec
             sr=
c/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=2Ec
@@ -=
826,8 +831,11 @@
             src/openvpn/options_util=2Ec
             src=
/openvpn/otime=2Ec
             src/openvpn/packet_id=2Ec
+            src/=
openvpn/reliable=2Ec
+            src/openvpn/session_id=2Ec
             s=
rc/openvpn/run_command=2Ec
             src/openvpn/ssl_mbedtls=2Ec
+      =
      src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_openssl=2Ec
    =
         src/openvpn/ssl_util=2Ec
             src/openvpn/ssl_verify_mbedt=
ls=2Ec
@@ -844,6 +852,8 @@
     target_sources(test_misc PRIVATE
         t=
ests/unit_tests/openvpn/mock_get_random=2Ec
         tests/unit_tests/openv=
pn/test_schedule=2Ec
+        tests/unit_tests/openvpn/mock_management=2Ec
=
+        src/openvpn/base64=2Ec
         src/openvpn/options_util=2Ec
     =
    src/openvpn/otime=2Ec
         src/openvpn/ssl_util=2Ec
diff --git a/do=
c/man-sections/client-options=2Erst b/doc/man-sections/client-options=2Erst=

index 87c138a=2E=2E89ba7cf 100644
--- a/doc/man-sections/client-options=2E=
rst
+++ b/doc/man-sections/client-options=2Erst
@@ -12,6 +12,17 @@
   When =
this option is set, OpenVPN will not drop incoming tun packets with
   same=
 destination as host=2E
 
+--app-custom-control protocollist
+  Sets the li=
st of supported app custom control protocols=2E
+  These protocols are anno=
unced to the server when this option is used
+  as a client=2E If the optio=
n is set on a server it will negotiate the
+  common protocols with the cli=
ent=2E
+
+  The protocollist is a : separated list of protocol identifiers=
=2E
+
+  See management-notes=2Etxt in the OpenVPN distribution  and the Op=
enVPN RFC
+  draft for a description of app custom control protocol support=
=2E
+
 --auth-token token
   This is not an option to be used directly in a=
ny configuration files,
   but rather push this option from a ``--client-co=
nnect`` script or a
diff --git a/doc/management-notes=2Etxt b/doc/managemen=
t-notes=2Etxt
index d6b3fbb=2E=2Eb2dcc0a 100644
--- a/doc/management-notes=
=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -798,6 +798,56 @@
 The client sh=
ould return the response to the crtext challenge
 using the cr-response com=
mand=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+If the special string "ACC" is passed as {EXTRA} OpenVPN will=
 determine
+the common app custom protocols between the client and the seve=
r and insruct
+the client that the server will send control messages to the=
 client using
+the ACC protocol=2E
+
+The server should then use acc-msg co=
mmand to send app custom control messages
+to the client to faciliate the p=
ending authentication=2E
+
+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or hig=
her)
+------------------------------------------
+
+This commands sends an =
app custom control message to a client,
+the format of the command is:
+
+ =
 client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
=
+CID,KID -- client ID and Key ID=2E  See documentation for ">CLIENT:"
+noti=
fication for more info=2E
+
+protocol -- the ACC protocol identified that t=
his message should be
+            tagged with=2E
+
+flags    -- a colon se=
perated list of the encoding and the flag if
+            the message is a =
fragment=2E E=2Eg=2E "6:F" for a base64 encoded
+            message that i=
s also a fragment and not complete yet=2E
+
+message  -- The message encode=
d in the encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8=
 or higher)
+------------------------------------------
+
+This commands se=
nds an app custom command to the peer, the format of the
+command is
+
+  a=
cc-msg
+  {protocol}
+  {flags}
+  {message}
+  END
+
+See the client-acc-m=
sg command for more details about the format of the message=2E
+
+
 COMMAND=
 -- client-deny  (OpenVPN 2=2E1 or higher)
 -------------------------------=
----------------
 
@@ -1247,6 +1297,23 @@
    response=2E Mechanisms that n=
eed multiple rounds or more complex answers
    should implement a differen=
t response type than CR_RESPONSE=2E
 
+(6) App custom control message
+
+  =
  This message is an application specific payload message that is transport=
ed
+    over the OpenVPN control channel=2E
+
+    In server mode:
+
+    >=
CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}
+
+    In client =
mode:
+
+    >ACC:{protocol},{fragment},{msg_base64}
+
+    The protocol is=
 a short ascii string identifying the app specific custom
+    protocol and=
 identifies the protocol=2E If fragment is set to 1, the message
+    is no=
t complete and the next message should be concatenated to this message
+   =
 to form a complete message=2E
 
 Variables:
 
diff --git a/src/openvpn/Mak=
efile=2Eam b/src/openvpn/Makefile=2Eam
index 7fd12b4=2E=2Ede7a5e7 100644
--=
- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -42,6 +42,=
7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh =
\
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base=
64=2Eh \
@@ -121,7 +122,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh =
\
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh=
 \
+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=
=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src=
/openvpn/acc=2Ec
new file mode 100644
index 0000000=2E=2E9a060d8
--- /dev/n=
ull
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,396 @@
+/*
+ *  OpenVPN -- An appl=
ication to securely tunnel IP networks
+ *             over a single TCP/UD=
P port, with support for SSL/TLS-based
+ *             session authenticati=
on and key exchange,
+ *             packet encryption, packet authenticati=
on, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 O=
penVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne=
@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistr=
ibute it and/or modify
+ *  it under the terms of the GNU General Public Li=
cense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ =
*  This program is distributed in the hope that it will be useful,
+ *  but=
 WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publ=
ic License for more details=2E
+ *
+ *  You should have received a copy of =
the GNU General Public License along
+ *  with this program; if not, write =
to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Flo=
or, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "co=
nfig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <string=2Eh>
+#incl=
ude "buffer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include "forwa=
rd=2Eh"
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ss=
l_ncp=2Eh"
+
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
=
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,=

+};
+
+
+static void
+log_acc_message(struct context *c, const struct buff=
er *buf, int payload_len,
+                const char *protocol, int flags)=

+{
+    bool fragment =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENAB=
LE_MANAGEMENT
+    struct gc_arena gc =3D gc_new();
+    const char *payloa=
d_msg =3D NULL;
+
+    /* For simplicity, we always encode payload to be ba=
se64 encoded
+     * if not already in base64 format */
+    if (flags & AC=
C_MESSAGE_FLAGS_ASCII)
+    {
+        char *b64out =3D NULL;
+        ASSE=
RT(openvpn_base64_encode(BPTR(buf), payload_len, &b64out) >=3D 0);
+       =
 gc_addspecial(b64out, free, &gc);
+        payload_msg =3D b64out;
+    }
=
+    else
+    {
+        payload_msg =3D BSTR(buf);
+    }
+
+    if (mana=
gement)
+    {
+        struct tls_session *session =3D &c->c2=2Etls_multi-=
>session[TM_ACTIVE];
+
+        struct man_def_auth_context *mda =3D sessio=
n->opt->mda_context;
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+  =
      {
+            /* server mode=2E Report client context */
+          =
  unsigned int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_i=
d;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+             =
   mda->cid, mda_key_id, protocol, fragment, payload_msg);
+        }
+    =
    else
+        {
+            /* Client mode=2E Do not a report a CLIENT=
 id */
+            msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payl=
oad_msg);
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANA=
GEMENT */
+    msg(D_PUSH, "Received custom app control message (protocol '=
%s'%s)",
+        protocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ * =
 Parses the flags field of an app control message and moves the
+ *  buffer=
 past the flags string=2E If there is an
+ *  error parsing the flags field=
 the method returns -1 and
+ *  puts the error reason in err_reason
+ */
+s=
tatic int
+parse_acc_message_flags(struct buffer *buf, const char **err_rea=
son, struct gc_arena *gc)
+{
+    const char *flags =3D extract_field(buf, =
',', gc);
+
+    if (!flags)
+    {
+        *err_reason =3D "could not ext=
ract flags field";
+        return -1;
+    }
+
+
+    int acc_flags =3D 0;=

+
+    for (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+ =
       if (*flag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MES=
SAGE_FLAGS_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+        {=

+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        =
else if (*flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSA=
GE_FLAGS_FRAGMENT;
+        }
+        else
+        {
+            *err_re=
ason =3D "Unknown flag in flags";
+            return -1;
+        }
+    }=

+    /* The message should be encoded with exactly one encoding=2E Ensure =
that
+     * only one of the flags is present */
+    bool asciienc =3D (bo=
ol)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(ac=
c_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1=
)
+    {
+        char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tm=
p, 512, "number of encodings must be exactly one "
+                       =
    "(B64=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc);
+    =
    *err_reason =3D tmp;
+        return -1;
+    }
+
+    return acc_flags=
;
+}
+
+
+void
+receive_acc_message(struct context *c, const struct buffer =
*buffer)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *err_reas=
on =3D "";
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+=
    struct buffer buf =3D *buffer;
+
+    if (!buf_advance(&buf, strlen("AC=
C")) || buf_read_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "missing=
 , after ACC";
+        goto err;
+    }
+
+    /* extract protocol, payloa=
d length, flags substrings */
+    char *protocol =3D extract_field(&buf, '=
,', &gc);
+    if (!protocol)
+    {
+        err_reason =3D "could not ext=
ract protocol field";
+        goto err;
+    }
+
+    int payload_len;
+  =
  char *payload_len_str =3D extract_field(&buf, ',', &gc);
+    if (!payloa=
d_len_str || !((payload_len =3D atoi(payload_len_str))))
+    {
+        er=
r_reason =3D "could not extract payload length field";
+        goto err;
+=
    }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_reason, &gc);=

+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We should=
 have a final NUL byte in the control message buffer
+     * and thus the l=
ength of the buffer should be payload_len + 1 */
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
+    /*
+     * length of the protocol string + one =
','
+     * 2 for the encoding (A or 6), potential F (fragment), and 1 for =
the ',',
+     * 4 for the message size itself and one comma
+     * 1 for =
the comma before the message itself */
+    const size_t max_header_size =
=3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =
=3D max_header_size + strlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+=
    {
+        msg(M_CLIENT, "message length (%zu) exceeds maximum possible=
 message length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+=
    }
+
+    if ((int)len > c->options=2Eacc_max_message_length)
+    {
+  =
      msg(M_CLIENT, "header (%zu) + message size (%zu) length (%zu) exceeds=
 "
+                      "maximum allowed length negotiated with peer (%d)=
",
+            max_header_size, strlen(msg), len,
+            c->options=
=2Eacc_max_message_length);
+        return false;
+    }
+
+    struct gc_=
arena gc =3D gc_new();
+    /* add 1 for the final \0 */
+    struct buffer=
 buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppets=
,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protoc=
ol,
+               strlen(msg),
+               base64 ? "6" : "A",
+     =
          fragment ? "F" : "",
+               msg);
+
+    send_control_ch=
annel_string_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_pro=
cess(c);
+    gc_free(&gc);
+    return true;
+}
+
+char *
+parse_acc_param=
eters(const char *capabilities,
+                     const char *delim,
+ =
                    int *max_acc_len,
+                     bool server,
+ =
                    struct gc_arena *gc)
+{
+    char *tmp_message =3D stri=
ng_alloc(capabilities, NULL);
+    char *tmp_message_orig =3D tmp_message;
=
+    char *lasts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_messag=
e, delim, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const ch=
ar *protocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode w=
e allow more capabilities than our own, in client
+     * mode we reject if=
 we should use capabilities that we do not support */
+    int allowed_acc_=
len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+  =
      if (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message leng=
th", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+        =
    goto done;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher=
_list("A", token) || !tls_item_in_cipher_list("6", token)))
+        {
+   =
         msg(D_PUSH_ERRORS, "App custom control encoding must include base6=
4 and ascii");
+            goto done;
+        }
+
+        if (p =3D=3D 1=
 && !server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+  =
          msg(D_PUSH_ERRORS, "App custom control encoding must exactly base=
64 and ascii");
+            goto done;
+        }
+
+        if (p =3D=3D =
2)
+        {
+            protocols =3D token;
+        }
+
+        if (p=
 =3D=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters =
for INFO ACC message/IV_ACC=2E");
+            goto done;
+        }
+
+   =
     token =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *=
max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc=
(protocols, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
=
+
+
+void
+determine_common_acc_protocols(struct context *c)
+{
+    if (!c=
->options=2Eacc_protocols)
+    {
+        /* No app custom protocols have =
been configured server-side=2E */
+        return;
+    }
+    if (c->optio=
ns=2Eacc_negotiated_protocols)
+    {
+        /* We already have determine=
d the common protocols=2E Doing this
+         * again would just add an ex=
tra string allocation to options->gc */
+        return;
+    }
+
+    stru=
ct gc_arena gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,fl=
ower:power */
+    const char *peer_info =3D c->c2=2Etls_multi->peer_info;
=
+    char *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+=
    if (!iv_acc)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+ =
   int max_acc_len =3D 0;
+    char *protocols =3D parse_acc_parameters(iv_=
acc, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+        =
gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variab=
le of peer is malformed");
+        return;
+    }
+
+    char *lasts =3D N=
ULL;
+    const char *token =3D strtok_r(protocols, ":", &lasts);
+
+    st=
ruct buffer common_protocols =3D alloc_buf_gc(1024, &gc);
+
+    while (tok=
en)
+    {
+        if (tls_item_in_cipher_list(token, c->options=2Eacc_pro=
tocols))
+        {
+            /* protocol is in both server and client l=
ist */
+            if (buf_len(&common_protocols) > 0)
+            {
+   =
             buf_write_u8(&common_protocols, ':');
+            }
+        =
    buf_printf(&common_protocols, "%s", token);
+        }
+        token =
=3D strtok_r(NULL, ":", &lasts);
+    }
+
+    if (buf_len(&common_protocol=
s) =3D=3D 0)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_DEBUG, "WARN=
ING: No common app custom control protocol=2E");
+        return;
+    }
+
=
+    c->options=2Eacc_negotiated_protocols =3D string_alloc(buf_str(&common=
_protocols), &c->options=2Egc);
+    c->options=2Eacc_max_message_length =
=3D max_acc_len;
+    gc_free(&gc);
+}
\ No newline at end of file
diff --g=
it a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 0=
000000=2E=2E5d9b203
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,92 @=
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
+#ifnd=
ef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LE=
N 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app cus=
tom control message and delivers it to the
+ * management interface=2E We l=
eave reassembly of fragmented messages to the
+ * management interface=2E
+=
 *
+ * @param c            The context struct
+ * @param buffer       Buffe=
r containing the control message with ACC
+ */
+void
+receive_acc_message(s=
truct context *c, const struct buffer *buffer);
+
+
+bool
+send_acc_message=
(struct context *c,
+                 struct tls_multi *tls_multi,
+       =
          struct tls_session *session,
+                 const char *protoc=
ol, bool fragment,
+                 const char *msg, bool base64);
+
+
+/*=
*
+ * Parses an info message from the server that contains app custom contr=
ol info
+ * information prior to the PUSH_REPLY to be able to use app custo=
m control
+ * protocols before sending
+ *
+ * In client mode only allow wh=
at we support ourselves=2E In server mode
+ * allow also capabilities that =
we not support ourselves=2E
+ *
+ * @param capabilities      The string to =
parse
+ * @param delim             The delimiter to use when parsing the st=
ring=2E
+ *                          IV_ACC uses "," as delimiter while the=

+ *                          custom-control PUSH message uses " " as "," i=
s
+ *                          already used to separate different push dire=
ctives
+ * @param max_acc_len       Set to the maximum ACC message length
+=
 * @param server            Whether we are server or client
+ * @param gc  =
              The gc arena to use for allocating the resulting string
+ * @=
return                  The resulting protocol string or NULL on error
+ */=

+char *
+parse_acc_parameters(const char *capabilities,
+                 =
    const char *delim,
+                     int *max_acc_len,
+           =
          bool server,
+                     struct gc_arena *gc);
+
+/**
+=
 * Parses the IV_ACC of the peer and sets c->options=2Eacc_negotiated_proto=
cols
+ * to the common protocols of server and client and
+ * c->options=2E=
acc_max_message_length  to the maximum length of the ACC message
+ * suppor=
t by both server and client=2E
+ *
+ * If there is no common protocol or th=
e client does not support any app custom
+ * protocol c->options=2Eacc_nego=
tiated_protocols will be set to NULL=2E
+ *
+ * @param c     the client con=
text to use the set the app custom protocols=2E
+ */
+void
+determine_commo=
n_acc_protocols(struct context *c);
+#endif
diff --git a/src/openvpn/forwar=
d=2Ec b/src/openvpn/forward=2Ec
index 2ade321=2E=2E736e975 100644
--- a/src=
/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #incl=
ude "dco=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#inclu=
de "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -251,11 +252,11 @@
     }
     e=
lse if (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        server_=
pushed_info(buf, 8);
+        server_pushed_info(c, buf, 8);
     }
     el=
se if (buf_string_match_head_str(buf, "INFO"))
     {
-        server_pushe=
d_info(buf, 4);
+        server_pushed_info(c, buf, 4);
     }
     else if=
 (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -265,6 +266,10 @=
@
     {
         receive_auth_pending(c, buf);
     }
+    else if (buf_st=
ring_match_head_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf=
);
+    }
     else if (buf_string_match_head_str(buf, "EXIT"))
     {
    =
     receive_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src/openv=
pn/init=2Ec
index 6b53686=2E=2Ee8e3a6d 100644
--- a/src/openvpn/init=2Ec
++=
+ b/src/openvpn/init=2Ec
@@ -2283,6 +2283,10 @@
             buf_printf(&ou=
t, " aead-epoch");
         }
     }
+    if (c->options=2Eacc_negotiated_p=
rotocols)
+    {
+        buf_printf(&out, " custom-control %d,A:6,%s", c->=
options=2Eacc_max_message_length, c->options=2Eacc_negotiated_protocols);
+=
    }
 
     if (BLENZ(&out) > strlen(header))
     {
@@ -2527,6 +2531,11 @=
@
         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->o=
ptions=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
    =
 return flags;
 }
 
@@ -3342,6 +3351,7 @@
     to=2Everify_hash_depth =3D o=
ptions->verify_hash_depth;
     to=2Everify_hash_no_ca =3D options->verify_=
hash_no_ca;
     memcpy(to=2Ex509_username_field, options->x509_username_fi=
eld, sizeof(to=2Ex509_username_field));
+    to=2Eacc_protocols =3D options=
->acc_protocols;
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net=
_ctx;
 
@@ -4300,6 +4310,27 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+sta=
tic bool
+management_acc_msg(void *arg,
+                   struct buffer_l=
ist *input) /* ownership transferred */
+{
+    struct gc_arena gc =3D gc_n=
ew();
+    struct context *c =3D arg;
+
+    bool ret =3D true;
+    if (bu=
ffer_list_defined(input) && c->c2=2Etls_multi)
+    {
+        struct tls_m=
ulti *multi =3D c->c2=2Etls_multi;
+        struct tls_session *session =3D=
 &multi->session[TM_ACTIVE];
+        struct options *opt =3D &c->options;
=
+
+        ret =3D management_send_acc_message(c, multi, session, opt->acc_=
negotiated_protocols, input);
+    }
+
+    buffer_list_free(input);
+    g=
c_free(&gc);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 v=
oid
@@ -4316,6 +4347,7 @@
         cb=2Eproxy_cmd =3D management_callback_p=
roxy_cmd;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
    =
     cb=2Esend_cc_message =3D management_callback_send_cc_message;
+       =
 cb=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2E=
network_change =3D management_callback_network_change;
 #endif
diff --git a=
/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 29fdffc=2E=2Eabf6f8b=
 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,8 =
+44,10 @@
 #include "dco=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#=
include "acc=2Eh"
 
 #include "memdbg=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifde=
f ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1080,6 +1082,35 @@
             =
}
             break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (=
man->persist=2Ecallback=2Eclient_acc_msg)
+            {
+                b=
ool status =3D (*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ec=
allback=2Earg,
+                                                           =
           man->connection=2Ein_extra_cid,
+                               =
                                       man->connection=2Ein_extra_kid,
+   =
                                                                   man->con=
nection=2Ein_extra);
+                man->connection=2Ein_extra =3D NULL;
=
+                report_command_status(status, "client-acc-msg");
+        =
    }
+            else
+            {
+                man_command_unsuppo=
rted("client-acc-msg");
+            }
+            break;
+
+        case =
IEC_ACC_MSG:
+            if (man->persist=2Ecallback=2Eacc_msg)
+         =
   {
+                bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(=
man->persist=2Ecallback=2Earg,
+                                           =
                    man->connection=2Ein_extra);
+                man->conn=
ection=2Ein_extra =3D NULL;
+                report_command_status(status, =
"acc-msg");
+            }
+            else
+            {
+              =
  man_command_unsupported("acc-msg");
+            }
+            break;
  =
       case IEC_PK_SIGN:
             man->connection=2Eext_key_state =3D E=
KS_READY;
             buffer_list_free(man->connection=2Eext_key_input);
@=
@ -1204,6 +1235,29 @@
 }
 
 static void
+man_client_acc_msg(struct manageme=
nt *man, const char *cid_str,
+                   const char *kid_str)
+{
+=
    struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cid =
=3D 0;
+    mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_ext=
ra_cid)
+        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+=
        mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc=
, IER_NEW);
+    }
+}
+
+static void
+man_acc_msg(struct management *man)
+=
{
+    struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cm=
d =3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man=
_client_auth(struct management *man, const char *cid_str, const char *kid_s=
tr, const bool extra)
 {
     struct man_connection *mc =3D &man->connectio=
n;
@@ -1760,6 +1814,17 @@
             man_client_pending_auth(man, p[1], p=
[2], p[3], p[4]);
         }
     }
+    else if (streq(p[0], "client-acc-m=
sg"))
+    {
+        if (man_need(man, p, 2, 0))
+        {
+            m=
an_client_acc_msg(man, p[1], p[2]);
+        }
+    }
+    else if (streq(p=
[0], "acc-msg"))
+    {
+        man_acc_msg(man);
+    }
     else if (str=
eq(p[0], "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -3131,6=
 +3196,7 @@
     }
 }
 
+
 void
 management_connection_established(struct m=
anagement *management, struct man_def_auth_context *mdac,
                 =
                  const struct env_set *es)
@@ -4362,6 +4428,62 @@
     }
 =
}
 
+bool
+management_send_acc_message(struct context *c, struct tls_multi =
*multi, struct tls_session *session,
+                            const cha=
r *negotiated_protocols, struct buffer_list *input)
+{
+    /* also ensures=
 that are enough inputs in the list to safely call
+     * buffer_list_peek=
 without extra NULL checks */
+    if (!input || input->size < 3)
+    {
+ =
       msg(M_CLIENT, "not enough input lines for sending acc message, "
+  =
                    "missing protocol, flag and/or messages lines");
+     =
   return false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    cons=
t struct buffer *proto_buf =3D buffer_list_peek(input);
+    const char *pr=
otocol =3D string_alloc(BSTR(proto_buf), &gc);
+    buffer_list_pop(input);=

+
+    const struct buffer *encoding_buf =3D buffer_list_peek(input);
+   =
 char *encoding =3D buf_str(encoding_buf);
+    char *flag =3D NULL;
+    b=
ool b64encoding =3D false;
+    bool fragment =3D false;
+
+    while ((fla=
g =3D strsep(&encoding, ":")))
+    {
+        if (!strcmp(flag, "6"))
+   =
     {
+            b64encoding =3D true;
+        }
+        else if (!str=
cmp(flag, "F"))
+        {
+            fragment =3D true;
+        }
+    =
}
+    buffer_list_pop(input);
+
+    buffer_list_aggregate_separator(input=
, 10000, "");
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(in=
put);
+
+    if (!negotiated_protocols || !tls_item_in_cipher_list(protocol=
, negotiated_protocols))
+    {
+        msg(M_CLIENT, "protocol not in the=
 list of negotiated protocols: %s", np(negotiated_protocols));
+        got=
o error;
+    }
+
+    bool ret =3D send_acc_message(c, multi, session, pro=
tocol,
+                                fragment, buf_str(acc_msg_buf),
+  =
                              b64encoding);
+    gc_free(&gc);
+    return =
ret;
+error:
+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef ENABL=
E_MANAGEMENT */
 
 #include "win32=2Eh"
diff --git a/src/openvpn/manage=2Eh=
 b/src/openvpn/manage=2Eh
index f752fec=2E=2Ede9303b 100644
--- a/src/openv=
pn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (=
*n_clients)(void *arg);
     bool (*send_cc_message)(void *arg, const char =
*message, const char *parameter);
     bool (*kill_by_cid)(void *arg, const=
 unsigned long cid, const char *kill_msg);
+
     bool (*client_auth)(void =
*arg, const unsigned long cid, const unsigned int mda_key_id,
             =
            const bool auth, const char *reason, const char *client_reason,=

                         struct buffer_list *cc_config); /* ownership tran=
sferred */
     bool (*client_pending_auth)(void *arg, const unsigned long =
cid, const unsigned int kid,
                                 const char *e=
xtra, unsigned int timeout);
     char *(*get_peer_info)(void *arg, const u=
nsigned long cid);
+    bool (*client_acc_msg)(void *arg,
+                =
           const unsigned long cid,
+                           const unsig=
ned int mda_key_id,
+                           struct buffer_list *msg);
+=
    bool (*acc_msg)(void *arg,
+                    struct buffer_list *msg=
);
     bool (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cm=
d)(void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@=

     struct command_line *in;
     struct buffer_list *out;
 
-#define IEC=
_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#d=
efine IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* =
*/
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SI=
GN     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#define =
IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWORD   =
    6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int =
in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_extr=
a_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(struct managem=
ent *man, struct context *c);
 
+/** Parses the ACC message from the input =
buffer_list and send to the
+ * session identified by session and multi
+ *=
/
+struct tls_session;
+struct tls_multi;
+bool
+management_send_acc_messag=
e(struct context *c, struct tls_multi *multi, struct tls_session *session,
=
+                            const char *negotiated_protocols, struct buffe=
r_list *input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index b28cf80=2E=2Eb444433 100=
644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -52,6 +52,7 =
@@
 #include "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=
=2Eh"
+#include "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1773,=
6 +1774,13 @@
         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIF=
Y;
     }
 
+    if (o->acc_protocols)
+    {
+        /* If ACC is enabled=
 server side call to find common acc protocols,
+         * will be pushed =
during push message */
+        determine_common_acc_protocols(c);
+    }
+=

     /* Select cipher if client supports Negotiable Crypto Parameters */
 =

     /* if we have already created our key, we cannot *change* our own
@@ =
-4032,6 +4040,24 @@
     }
 }
 
+static const char *
+calculate_app_control=
_extra(struct context *c, struct gc_arena *gc)
+{
+    determine_common_acc=
_protocols(c);
+
+    if (!c->options=2Eacc_negotiated_protocols)
+    {
+ =
       msg(M_CLIENT, "ACC: No negotiated protocols");
+        return NULL;=

+    }
+
+    struct buffer buf =3D alloc_buf_gc(1024, gc);
+
+    buf_pri=
ntf(&buf, "ACC:%d A:6 %s", c->options=2Eacc_max_message_length, c->options=
=2Eacc_negotiated_protocols);
+    return buf_str(&buf);
+}
+
+
 static boo=
l
 management_client_pending_auth(void *arg, const unsigned long cid, const=
 unsigned int mda_key_id,
                                const char *extra=
, unsigned int timeout)
@@ -4042,10 +4068,22 @@
     if (mi)
     {
       =
  struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        stru=
ct gc_arena gc =3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {=

+            extra =3D calculate_app_control_extra(&mi->context, &gc);
+  =
          if (!extra)
+            {
+                gc_free(&gc);
+      =
          return false;
+            }
+        }
         struct tls_sessi=
on *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
 
        =
 if (!session)
         {
+            gc_free(&gc);
             return fa=
lse;
         }
 
@@ -4053,6 +4091,7 @@
         bool ret =3D send_auth_pen=
ding_messages(multi, session, extra, timeout);
         reschedule_multi_pr=
ocess(&mi->context);
         multi_schedule_context_wakeup(m, mi);
+      =
  gc_free(&gc);
         return ret;
     }
     return false;
@@ -4096,6 +=
4135,39 @@
     return ret;
 }
 
+
+static bool
+management_client_acc_msg(=
void *arg,
+                          const unsigned long cid,
+           =
               const unsigned int mda_key_id,
+                          st=
ruct buffer_list *input) /* ownership transferred */
+{
+    struct multi_c=
ontext *m =3D (struct multi_context *)arg;
+    struct multi_instance *mi =
=3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+    if (mi && buffer=
_list_defined(input))
+    {
+        struct tls_multi *multi =3D mi->conte=
xt=2Ec2=2Etls_multi;
+        struct tls_session *session =3D lookup_sessio=
n_by_mda_key_id(multi, mda_key_id);
+        if (!session)
+        {
+    =
        msg(M_CLIENT, "client session not found");
+            buffer_list=
_free(input);
+            return false;
+        }
+
+        struct optio=
ns *opt =3D &mi->context=2Eoptions;
+
+        ret =3D management_send_acc_=
message(&mi->context, multi, session, opt->acc_negotiated_protocols, input)=
;
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_list_=
free(input);
+    return ret;
+}
+
+
 static char *
 management_get_peer_in=
fo(void *arg, const unsigned long cid)
 {
@@ -4132,6 +4204,7 @@
         cb=
=2En_clients =3D management_callback_n_clients;
         cb=2Ekill_by_cid =
=3D management_kill_by_cid;
         cb=2Eclient_auth =3D management_client=
_auth;
+        cb=2Eclient_acc_msg =3D management_client_acc_msg;
        =
 cb=2Eclient_pending_auth =3D management_client_pending_auth;
         cb=
=2Eget_peer_info =3D management_get_peer_info;
         cb=2Epush_update_br=
oadcast =3D management_callback_send_push_update_broadcast;
diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 178b5f6=2E=2E27540e7 =
100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6=
 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=
=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -7100,6 +7101,28 @@
 =
        VERIFY_PERMISSION(OPT_P_GENERAL);
         options->force_key_mater=
ial_export =3D true;
     }
+    else if (streq(p[0], "app-custom-control")=
 && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+     =
   options->acc_protocols =3D p[1];
+    }
+    else if (streq(p[0], "custo=
m-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMIS=
SION(OPT_P_ACC);
+
+        if (!streq(p[2], "A:6") && !streq(p[2], "6:A"))=

+        {
+            msg(msglevel, "App custom control encoding must be=
 base64 and ascii");
+            goto err;
+        }
+
+        if (!atoi=
_constrained(p[1], &options->acc_max_message_length,
+                     =
         "app custom message message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_=
LEN, msglevel))
+        {
+            goto err;
+        }
+        optio=
ns->acc_negotiated_protocols =3D p[3];
+    }
     else if (streq(p[0], "pr=
ng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option i=
gnored (SSL library PRNG is used)");
diff --git a/src/openvpn/options=2Eh b=
/src/openvpn/options=2Eh
index 131513e=2E=2Eef4f1fe 100644
--- a/src/openvp=
n/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -711,6 +711,16 @@
     /* fo=
rce using TLS key material export for data channel key generation */
     b=
ool force_key_material_export;
 
+    /** The app custom control protocols =
we should announce as supported */
+    const char *acc_protocols;
+
+    /=
** the protocols that are negotiated with the peer=2E As a client we
+     =
* trust the server pushed list here */
+    const char *acc_negotiated_prot=
ocols;
+
+    /** the maximum length of an ACC control channel message */
+=
    int acc_max_message_length;
+
     bool vlan_tagging;
     enum vlan_ac=
ceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -762,8 +772,10 @@
=
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU        (1=
u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC      =
       (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL=
_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal configur=
ation file (vs pushed options or in ccd files) */
+#define OPT_P_DEFAULT (~=
(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define =
PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/o=
penvpn/push=2Ec
index fa7bf1e=2E=2E12068b5 100644
--- a/src/openvpn/push=2E=
c
+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #=
include "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #include =
"crypto=2Eh"
 #include "ssl=2Eh"
@@ -220,9 +222,8 @@
 #endif
 }
 
-
 void
-=
server_pushed_info(const struct buffer *buffer, const int adv)
+server_push=
ed_info(struct context *c, const struct buffer *buffer, const int adv)
 {
 =
    const char *m =3D "";
     struct buffer buf =3D *buffer;
@@ -232,6 +23=
3,27 @@
         m =3D BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =
=3D=3D 0)
+    {
+        int max_acc_len =3D 0;
+
+
+        /* example st=
ring to parse: ACC:1400 A:6 flower:happy */
+        /* Skip over the ACC: =
prefix */
+        m +=3D 4;
+
+        char *protocols =3D parse_acc_param=
eters(m, " ", &max_acc_len, false, &c->options=2Egc);
+        if (protocol=
s)
+        {
+            c->options=2Eacc_negotiated_protocols =3D protoc=
ols;
+            c->options=2Eacc_max_message_length =3D max_acc_len;
+   =
     }
+        else
+        {
+            msg(D_PUSH_ERRORS, "WARNING: R=
eceived ACC info command with invalid parameters");
+        }
+    }
+
 #i=
fdef ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ -28=
4,6 +306,7 @@
     msg(D_PUSH, "CR response was sent by client ('%s')", m);=

 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING request
  * @param =
buffer                buffer containing the keywords, the buffer's
@@ -440,=
7 +463,6 @@
     const char *const peer_info =3D tls_multi->peer_info;
    =
 unsigned int proto =3D extract_iv_proto(peer_info);
 
-
     /* Calculate =
the maximum timeout and subtract the time we already waited */
     unsigne=
d int max_timeout =3D
         max_uint(tls_multi->opt=2Erenegotiate_second=
s / 2, tls_multi->opt=2Ehandshake_window);
@@ -731,6 +753,11 @@
           =
      client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
     }
=
+
+    if (c->options=2Eacc_negotiated_protocols)
+    {
+        push_opti=
on_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s", c->options=2Eacc=
_max_message_length, c->options=2Eacc_negotiated_protocols);
+    }
 }
 
 #=
if defined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn/push=2E=
h b/src/openvpn/push=2Eh
index dff945f=2E=2E3aca8a7 100644
--- a/src/openvp=
n/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_inco=
ming_push_request(struct context *c);
 
+
 /**
  * @brief Handles the recei=
ving of a push-update message and applies updates to the specified
  * opti=
ons=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_message(struct context *c);
 =

-void server_pushed_info(const struct buffer *buffer, const int adv);
+voi=
d server_pushed_info(struct context *c, const struct buffer *buffer, const =
int adv);
 
 void receive_cr_response(struct context *c, const struct buffe=
r *buffer);
 
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_uti=
l=2Ec
index fcc5411=2E=2E6462a97 100644
--- a/src/openvpn/push_util=2Ec
+++=
 b/src/openvpn/push_util=2Ec
@@ -370,4 +370,4 @@
 
     RETURN_UPDATE_STATU=
S(n_sent);
 }
-#endif /* ifdef ENABLE_MANAGEMENT */
+#endif /* ifdef ENABLE=
_MANAGEMENT */
\ No newline at end of file
diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec
index 5f5d1f9=2E=2Ea5663e3 100644
--- a/src/openvpn/=
ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epo=
ch=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
=
 #include "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -2054,6 +2055,11 @@
=
                     }
                 }
             }
+
+            if =
(session->opt->acc_protocols)
+            {
+                buf_printf(&o=
ut, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
=
+            }
         }
     }
 
diff --git a/src/openvpn/ssl_common=2Eh =
b/src/openvpn/ssl_common=2Eh
index db61198=2E=2E3b326a7 100644
--- a/src/op=
envpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -452,6 +452,9 @@
 =
    size_t ekm_size;
 
     bool dco_enabled; /**< Whether keys have to be =
installed in DCO or not */
+
+    /** The app custom control protocols we s=
hould announce as supported */
+    const char *acc_protocols;
 };
 
 /** @=
addtogroup control_processor
diff --git a/tests/unit_tests/openvpn/Makefile=
=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=2E753e59d 1=
00644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/o=
penvpn/Makefile=2Eam
@@ -103,9 +103,11 @@
 	@TEST_CFLAGS@
 ssl_testdriver_L=
DFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =
=3D test_ssl=2Ec \
+    test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=
=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec =
mock_win32_execve=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdi=
r)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_=
srcdir)/src/openvpn/buffer=2Ec \
@@ -127,6 +129,7 @@
 	$(top_srcdir)/src/op=
envpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \
 	$(t=
op_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_nc=
p=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/open=
vpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=
=2Ec \
@@ -375,8 +378,10 @@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \
=
 	test_schedule=2Ec test_schedule=2Eh \
+	mock_management=2Ec mock_manageme=
nt=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
+	$(top_=
srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 =
	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn/s=
sl_util=2Ec \
@@ -388,6 +393,7 @@
 	$(top_srcdir)/src/openvpn/siphash=2Ec \=

 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
+
 push_update_msg_tes=
tdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/comp=
at \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_t=
ests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=
=2Ec
index 77f6ce2=2E=2Ecddd669 100644
--- a/tests/unit_tests/openvpn/mock_=
management=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 =
+29,7 @@
 
 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "mana=
ge=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
@@ -60,4 +61,4 @@
 void
 management_sle=
ep(const int n)
 {
-}
+}
\ No newline at end of file
diff --git a/tests/uni=
t_tests/openvpn/mock_management=2Eh b/tests/unit_tests/openvpn/mock_managem=
ent=2Eh
new file mode 100644
index 0000000=2E=2Ee21aec43
--- /dev/null
+++ =
b/tests/unit_tests/openvpn/mock_management=2Eh
@@ -0,0 +1,32 @@
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
+#ifndef MOCK_MANAG=
EMENT_H
+#define MOCK_MANAGEMENT_H
+void init_mock_management(void);
+
+voi=
d uninit_mock_management(void);
+
+#endif
diff --git a/tests/unit_tests/ope=
nvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_depend=
encies=2Ec
index 112bcfd=2E=2Ec16d0cb 100644
--- a/tests/unit_tests/openvpn=
/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_depend=
encies=2Ec
@@ -43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE=
_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SET=
ENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
             =
         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL=
_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | =
OPT_P_ROUTE | OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_=
NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | =
OPT_P_ACC;
     return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/te=
st_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
ind=
ex 0000000=2E=2E16b2b3b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_a=
cc=2Ec
@@ -0,0 +1,298 @@
+/*
+ *  OpenVPN -- An application to securely tun=
nel IP networks
+ *             over a single TCP/UDP port, with support fo=
r SSL/TLS-based
+ *             session authentication and key exchange,
+ =
*             packet encryption, packet authentication, and
+ *            =
 packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openv=
pn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *=

+ *  This program is free software; you can redistribute it and/or modify
=
+ *  it under the terms of the GNU General Public License version 2
+ *  as=
 published by the Free Software Foundation=2E
+ *
+ *  This program is dist=
ributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; =
without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more det=
ails=2E
+ *
+ *  You should have received a copy of the GNU General Public =
License along
+ *  with this program; if not, write to the Free Software Fo=
undation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#i=
nclude "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#inclu=
de <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cm=
ocka=2Eh>
+
+#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include "test_co=
mmon=2Eh"
+
+#include "mock_msg=2Eh"
+
+char control_channel_mesage_sent[20=
48];
+
+/* Mock functions */
+bool
+send_control_channel_string_dowork(stru=
ct tls_session *session,
+                                   const char *st=
r, int msglevel)
+{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    =
memcpy(control_channel_mesage_sent, str, strlen(str));
+    return true;
+}=

+
+void
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void=

+auth_set_client_reason(struct tls_multi *multi, const char *reason)
+{
+}=

+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"          =
      \
+                    "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0=
cF1d60nTS" \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvAL=
wCewCTAKABrwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAA=
sABAMAAQIACgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAA=
AFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUI=
BgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzA=
CYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSij=
XgcQ=3D=3D"
+
+void
+test_acc_parse_client_messages(void **state)
+{
+#ifnd=
ef ENABLE_MANAGEMENT
+    skip();
+#else
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
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eo=
pt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE=
]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf,=
 (void *)msg, sizeof(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    =
assert_string_equal(mock_msg_buf, "Received custom app control message (pro=
tocol 'cck1')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,=
0,0,cck1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,4=
8,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_rea=
d(&msg_buf, (void *)flower_msg, sizeof(flower_msg));
+    receive_acc_messa=
ge(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom a=
pp control message (protocol 'flower')");
+    assert_string_equal(mock_man=
agment_buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZ=
nJvZyEAAA=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    const char msg_in=
correct_len[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiA=
iSSBhbSAAS2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_inc=
orrect_len, sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_b=
uf);
+    const char *error =3D "WARNING: Received malformed custom app con=
trol channel "
+                        "(field length 62, payload length 6=
4 mismatch) message "
+                        "control message: 496e7367 4=
96d316c 496a6f67 496d5a79 "
+                        "62326369 4c434141 654=
75a6d 2f534a7[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, err=
or);
+    assert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_ma=
nagment_buf);
+    const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gd=
w=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_frag=
ment));
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mo=
ck_msg_buf, "Received custom app control message (protocol 'power', fragmen=
t)");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1=
,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    /* check two en=
coding present */
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,=
6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read=
(&msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    =
receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malf=
ormed custom app control channel (number of "
+            "encodings must =
be exactly one (B64=3D1, ASCII=3D1)) message control "
+            "messag=
e: 53534268 62534141 4945746c 636d3170 6443442f 2f534230 "
+            "61=
475567 37372b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, erro=
r);
+    assert_string_equal(mock_managment_buf, "");
+
+    /* no encoding=
 present */
+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbS=
AAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf=
, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc=
_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custo=
m app control channel (number of "
+            "encodings must be exactly =
one (B64=3D0, ASCII=3D0)) message control "
+            "message: 53534268=
 62534141 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 3737=
2b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    as=
sert_string_equal(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+   =
 management =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc=
_parameters(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* =
parameters to INFO message */
+    const char *info_acc_msg =3D "4096 A:6 f=
lower:happy";
+
+    int max_len =3D 0;
+    const char *protocols =3D pars=
e_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_strin=
g_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+=

+    /* a client does not accept a length longer than it supports */
+    =
protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc)=
;
+    assert_null(protocols);
+
+    /* message with lower limit than our,=
 should work for client and server */
+    info_acc_msg =3D "1111 A:6 flowe=
r:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_l=
en, false, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    =
assert_int_equal(max_len, 1111);
+
+    protocols =3D parse_acc_parameters(=
info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols=
, "flower:happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more enc=
odings than supported=2E Server should be okay, client should fail */
+    =
info_acc_msg =3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc_pa=
rameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protoco=
ls);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len,=
 true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    asse=
rt_int_equal(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg=
 =3D "1400 A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(in=
fo_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    =
protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc)=
;
+    assert_null(protocols);
+
+
+    const char *iv_acc_capabilities =3D=
 "1400,A:6,flower:happy:power";
+    protocols =3D parse_acc_parameters(iv_=
acc_capabilities, ",", &max_len, true, &gc);
+    assert_string_equal(proto=
cols, "flower:happy:power");
+
+    /* too small protocol length */
+    in=
fo_acc_msg =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_paramete=
rs(info_acc_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
=
+    /* non-numerical protocol length */
+    info_acc_msg =3D "abff A:6 fl=
ower:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", =
&max_len, true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical =
protocol length */
+    info_acc_msg =3D "abff A:6 flower:happy 77";
+    p=
rotocols =3D parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
=
+    assert_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_comm=
on_protocols(void **state)
+{
+    struct context c =3D { 0 };
+    c=2Eopt=
ions=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struc=
t tls_multi, &c=2Eoptions=2Egc);
+
+    c=2Ec2=2Etls_multi->peer_info =3D "=
IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c=2Eoptions=2E=
acc_protocols =3D "power:flower:star";
+
+    determine_common_acc_protocol=
s(&c);
+
+    assert_int_equal(c=2Eoptions=2Eacc_max_message_length, ACC_MA=
X_MSG_LEN);
+    assert_string_equal(c=2Eoptions=2Eacc_negotiated_protocols=
, "flower:power");
+
+    gc_free(&c=2Eoptions=2Egc);
+}
+
+void
+test_acc_=
send_message(void **state)
+{
+    struct context c =3D { 0 };
+    c=2Eopt=
ions=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struc=
t tls_multi, &c=2Eoptions=2Egc);
+    bool ret;
+
+    c=2Ec2=2Etls_multi->=
peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power";
=
+    c=2Eoptions=2Eacc_protocols =3D "power:flower:emergency";
+    determi=
ne_common_acc_protocols(&c);
+
+
+    struct tls_session *session =3D &c=2E=
c2=2Etls_multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_message(&c, c=
=2Ec2=2Etls_multi, session, "emergency", true,
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
+    ret =3D send_acc_message(&c, c=2Ec2=2Etls_multi, ses=
sion, "emergency", false,
+                           "THE GOVERNMENT HAS I=
SSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_true(=
ret);
+    assert_string_equal(control_channel_mesage_sent,
+              =
          "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED =
ALERT FOR YOUR AREA=2E");
+
+
+    /* test a long message (> 1000) with fra=
gment to get the maximum header size */
+    char long_message[1200] =3D { =
0 };
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+        long_message[i=
] =3D (char)(' ' + (i % 95));
+    }
+
+    /* last char of the message is =
a i and then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    a=
ssert_int_equal(long_message[1024], '\0');
+
+    ret =3D send_acc_message(=
&c, c=2Ec2=2Etls_multi, session, "emergency", true,
+                      =
     long_message, false);
+
+    assert_true(ret);
+    size_t cc_len =3D =
strlen(control_channel_mesage_sent);
+    assert_int_equal(control_channel_=
mesage_sent[cc_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC,=
emergency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(cont=
rol_channel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));
+
+=
    gc_free(&c=2Eoptions=2Egc);
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
index a41c27b=2E=2E82292f1 100644
--- a/te=
sts/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_mi=
sc=2Ec
@@ -40,11 +40,34 @@
 #include "list=2Eh"
 #include "mock_msg=2Eh"
 #=
include "crypto=2Eh"
+#include "test_schedule=2Eh"
+#include "multi=2Eh"
+
=
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
-#include "test_schedule=
=2Eh"
 
+/* extra mocks */
+bool
+apply_push_options(struct context *c, str=
uct options *options, struct buffer *buf,
+                   uint64_t perm=
ission_mask, uint64_t *option_types_found,
+                   struct env_s=
et *es, bool is_update)
+{
+    return true;
+}
+
+bool
+send_control_chann=
el_string(struct context *c, const char *str, msglvl_t msglevel)
+{
+    ch=
eck_expected_ptr(str);
+    return true;
+}
+
+struct multi_instance *
+loo=
kup_by_cid(struct multi_context *m, const unsigned long cid)
+{
+    return=
 *(m->instances);
+}
 
 static void
 test_compat_lzo_string(void **state)
d=
iff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvp=
n/test_ssl=2Ec
index 887c492=2E=2Eaa639ff 100644
--- a/tests/unit_tests/ope=
nvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,=
8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_a=
cc=2Eh"
+
 /* Mock function to be allowed to include win32=2Ec which is req=
uired for
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 =
@@
 {
     return;
 }
+void
+reschedule_multi_process(struct context *c)
+{=

+}
+
+/* Define a dummy dco cipher option to avoid linking against all the=
 DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported=
_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-=
GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req -x=
509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -960,8 +=
976,11 @@
         cmocka_unit_test(test_data_channel_known_vectors_epoch),=

         cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
   =
      cmocka_unit_test(crypto_test_print_cert_details),
-        cmocka_uni=
t_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_test(ssl_test_ext=
ract_peer_info),
+        cmocka_unit_test(test_acc_parse_client_messages),=

+        cmocka_unit_test(test_parse_acc_parameters),
+        cmocka_unit=
_test(test_acc_common_protocols),
+        cmocka_unit_test(test_acc_send_m=
essage)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4=
c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--dHvo4a+KAiU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #7</strong> to this change=2E</p><p><a href=3D"http://g=
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
vpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/u=
nit_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<=
br>27 files changed, 1,343 insertions(+), 27 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
58/1858/7</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><b=
r><span>index 6eb5954=2E=2Ea9331c2 100644</span><br><span>--- a/CMakeLists=
=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -424,6 +42=
4,8 @@</span><br><span>     src/compat/compat-gettimeofday=2Ec</span><br><s=
pan>     src/compat/compat-strsep=2Ec</span><br><span>     src/compat/compa=
t-strtok_r=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
rc/openvpn/acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   src/openvpn/acc=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br>=
<span>     src/openvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec=
</span><br><span>@@ -560,9 +562,9 @@</span><br><span>     src/openvpn/ps=2E=
c</span><br><span>     src/openvpn/ps=2Eh</span><br><span>     src/openvpn/=
push=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openv=
pn/push_util=2Ec</span><br><span>     src/openvpn/push=2Eh</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/pushlist=2Eh</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/push_util=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn=
/pushlist=2Eh</span><br><span>     src/openvpn/reflect_filter=2Ec</span><br=
><span>     src/openvpn/reflect_filter=2Eh</span><br><span>     src/openvpn=
/reliable=2Ec</span><br><span>@@ -812,7 +814,10 @@</span><br><span>        =
     tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>         =
    tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>    =
         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/te=
st_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   src/openvpn/acc=2Ec</span><br><span>             src/openvpn/argv=2Ec</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvp=
n/auth_token=2Ec</span><br><span>             src/openvpn/base64=2Ec</span>=
<br><span>             src/openvpn/crypto_epoch=2Ec</span><br><span>       =
      src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -826,8 +831,11 @@</=
span><br><span>             src/openvpn/options_util=2Ec</span><br><span>  =
           src/openvpn/otime=2Ec</span><br><span>             src/openvpn/p=
acket_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     src/openvpn/reliable=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            src/openvpn/session_id=2Ec</span><br><span>          =
   src/openvpn/run_command=2Ec</span><br><span>             src/openvpn/ssl=
_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     src/openvpn/ssl_ncp=2Ec</span><br><span>             src/openvpn/ssl_o=
penssl=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec</span><br>=
<span>             src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -8=
44,6 +852,8 @@</span><br><span>     target_sources(test_misc PRIVATE</span>=
<br><span>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><=
span>         tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_=
management=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/base64=2Ec</span><br><span>         src/openvpn/options_util=
=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><br><span>       =
  src/openvpn/ssl_util=2Ec</span><br><span>diff --git a/doc/man-sections/cl=
ient-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>=
index 87c138a=2E=2E89ba7cf 100644</span><br><span>--- a/doc/man-sections/cl=
ient-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2E=
rst</span><br><span>@@ -12,6 +12,17 @@</span><br><span>   When this option =
is set, OpenVPN will not drop incoming tun packets with</span><br><span>   =
same destination as host=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+--app-custom-control protocollist</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Sets the list of supported app cu=
stom control protocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  These protocols are announced to the server when this option is use=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as a client=2E I=
f the option is set on a server it will negotiate the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  common protocols with the client=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  The protocollist is a : separated list =
of protocol identifiers=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See manage=
ment-notes=2Etxt in the OpenVPN distribution  and the OpenVPN RFC</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  draft for a description of =
app custom control protocol support=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> --auth-token token</span><br><span>   =
This is not an option to be used directly in any configuration files,</span=
><br><span>   but rather push this option from a ``--client-connect`` scrip=
t or a</span><br><span>diff --git a/doc/management-notes=2Etxt b/doc/manage=
ment-notes=2Etxt</span><br><span>index d6b3fbb=2E=2Eb2dcc0a 100644</span><b=
r><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/manageme=
nt-notes=2Etxt</span><br><span>@@ -798,6 +798,56 @@</span><br><span> The cl=
ient should return the response to the crtext challenge</span><br><span> us=
ing the cr-response command=2E</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+app custom control</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+If the spe=
cial string &quot;ACC&quot; is passed as {EXTRA} OpenVPN will determine</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+the common app custom p=
rotocols between the client and the sever and insruct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the client that the server will send cont=
rol messages to the client using</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+the ACC protocol=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The se=
rver should then use acc-msg command to send app custom control messages</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+to the client to facil=
iate the pending authentication=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMM=
AND -- client-acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+------------------------------------------</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+This commands sends an app custom control=
 message to a client,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+the format of the command is:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  clien=
t-acc-msg {CID} {KID}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {fl=
ags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+CID,KID -- client ID and Key ID=2E  See documentation fo=
r &quot;&gt;CLIENT:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+notification for more info=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pro=
tocol -- the ACC protocol identified that this message should be</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            tagged with=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+flags    -- a colon seperated list of the=
 encoding and the flag if</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            the message is a fragment=2E E=2Eg=2E &quot;6:F&quot; for=
 a base64 encoded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          message that is also a fragment and not complete yet=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+message  -- The message encoded in the encoding =
specified in flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or hi=
gher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--------------=
----------------------------</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This comma=
nds sends an app custom command to the peer, the format of the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+command is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  acc-msg</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
{flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+See the client-acc-msg command for more details about=
 the format of the message=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><span>=
 -----------------------------------------------</span><br><span> </span><b=
r><span>@@ -1247,6 +1297,23 @@</span><br><span>    response=2E Mechanisms t=
hat need multiple rounds or more complex answers</span><br><span>    should=
 implement a different response type than CR_RESPONSE=2E</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+(6) App custom contr=
ol message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    This message is an appli=
cation specific payload message that is transported</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    over the OpenVPN control channel=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    In server mode:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_b=
ase64}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    In client mode:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &gt;ACC:{protocol},{fragment},{msg_base64}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    The protocol is a short ascii string =
identifying the app specific custom</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    protocol and identifies the protocol=2E If fragment is =
set to 1, the message</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    is not complete and the next message should be concatenated to this m=
essage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to form a=
 complete message=2E</span><br><span> </span><br><span> Variables:</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/open=
vpn/Makefile=2Eam</span><br><span>index 7fd12b4=2E=2Ede7a5e7 100644</span><=
br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/=
Makefile=2Eam</span><br><span>@@ -42,6 +42,7 @@</span><br><span> sbin_PROGR=
AMS =3D openvpn</span><br><span> </span><br><span> openvpn_SOURCES =3D \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</sp=
an><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_to=
ken=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -121=
,7 +122,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	prox=
y=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br>=
<span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=
=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff -=
-git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file m=
ode 100644</span><br><span>index 0000000=2E=2E9a060d8</span><br><span>--- /=
dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 =
+1,396 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             over a single TCP/UDP port, with support for S=
SL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        session authentication and key exchange,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet encryption, packet authe=
ntication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet compression=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  C=
opyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &=
lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free sof=
tware; you can redistribute it and/or modify</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public L=
icense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 as published by the Free Software Foundation=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  This program is distributed in the hope that it will be use=
ful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT=
 ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin=
 Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffe=
r=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=
_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+enum acc_message_flag</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_BAS=
E64 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_M=
ESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+log_acc_message(struct context *c, const struct buffer=
 *buf, int payload_len,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                const char *protocol, int flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool fragment =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGMEN=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MAN=
AGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *payload_msg =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* For simplicity, we always encode payload to be base64 encoded</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if not already =
in base64 format */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        char *b64out =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ASSERT(openvpn_base64_encode(BPTR(buf), paylo=
ad_len, &amp;b64out) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gc_addspecial(b64out, free, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D b64out;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        payload_msg =3D BSTR(buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_s=
ession *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct man_def_auth_context *mda =3D=
 session-&gt;opt-&gt;mda_context;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* server mode=2E Report c=
lient context */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-=
&gt;mda_key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                mda-&gt;cid, =
mda_key_id, protocol, fragment, payload_msg);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* Client mode=2E Do not a report a CLIENT id */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt=
;ACC:%s,%d,%s&quot;, protocol, fragment, payload_msg);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received custom app con=
trol message (protocol &#39;%s&#39;%s)&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        protocol, fragment ? &quot;, fragment&quo=
t; : &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Parses the flags field of an app control message and moves the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  buffer past the flags=
 string=2E If there is an</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  error parsing the flags field the method returns -1 and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  puts the error reason in =
err_reason</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(struct buf=
fer *buf, const char **err_reason, struct gc_arena *gc)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *flags =3D extract_field(buf, &#39;,&#39;,=
 gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        *err_reason =3D &quot;could not extract fla=
gs field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A&#39=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D =
ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&#39;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_=
MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            *err_reason=
 =3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return -1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* The message should be encoded with exactly one encoding=2E Ensure tha=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only one of=
 the flags is present */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASCII);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool base64enc =
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
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocol =3D extra=
ct_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!protocol)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        err_reason =3D &quot;could not extract protocol field&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int payload_len;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    char *payload_len_str =3D extract_field(&amp;buf,=
 &#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!payload_len_str || !((payload_len =3D atoi(payload_len_str))))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;coul=
d not extract payload length field&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags=
 =3D parse_acc_message_flags(&amp;buf, &amp;err_reason, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We should hav=
e a final NUL byte in the control message buffer</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * and thus the length of the buffer shoul=
d be payload_len + 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512=
, &quot;field length %d, payload length %d mismatch&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 payload_len, buf_le=
n(&amp;buf) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      err_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_len, pr=
otocol, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Receiv=
ed malformed custom app control channel &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                       &quot;(%s) message contro=
l message: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        err_reason,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        format_hex(BPTR(&amp;buf), BLEN(&amp;buf), 80, &amp;gc));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struc=
t context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           struct tls_multi *tls_multi,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 struct tls_session *session,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 const char *=
protocol, bool fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                 const char *msg, bool base64)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * length of the protocol string + one &#39;,&#39;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * 2 for the encoding (A or 6), p=
otential F (fragment), and 1 for the &#39;,&#39;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * 4 for the message size itself and one =
comma</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 1 for t=
he comma before the message itself */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const size_t max_header_size =3D strlen(&quot;ACC,&qu=
ot;) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size_t len =3D max_header_size + strlen(msg);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;messag=
e length (%zu) exceeds maximum possible message length (%d)&quot;, len, TLS=
_CHANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &gt; c-&gt;opt=
ions=2Eacc_max_message_length)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_CLIENT, &quot;header (%zu) + message size (%zu) length (%zu) exc=
eeds &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
              &quot;maximum allowed length negotiated with peer (%d)&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            max_hea=
der_size, strlen(msg), len,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            c-&gt;options=2Eacc_max_message_length);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
_gc(len + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example m=
essage: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&q=
uot;, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
           strlen(msg),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+               base64 ? &quot;6&quot; : &quot;A&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+               fragment ? &quot;F&qu=
ot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
               msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    send_control_c=
hannel_string_dowork(session, BSTR(&amp;buf), D_PUSH);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    reschedule_multi_process(c);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+par=
se_acc_parameters(const char *capabilities,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     const char *delim,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                     int *max_a=
cc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         bool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *tmp_message =3D string_alloc(capabilities, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message_orig =
=3D tmp_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
token =3D strtok_r(tmp_message, delim, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int p =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int acclen =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *protocols =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* In server mode we allow more capabilities than our ow=
n, in client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
mode we reject if we should use capabilities that we do not support */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int allowed_acc_len =
=3D server ? INT_MAX : ACC_MAX_MSG_LEN;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    while (token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =
=3D=3D 0 &amp;&amp; !atoi_constrained(token, &amp;acclen, &quot;ACC message=
 length&quot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (p =3D=3D 1 &amp;&amp; (!tls_item_in_cipher_list(&quot;=
A&quot;, token) || !tls_item_in_cipher_list(&quot;6&quot;, token)))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;=
App custom control encoding must include base64 and ascii&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; !server &amp;&amp; st=
rcmp(token, &quot;A:6&quot;) &amp;&amp; strcmp(token, &quot;6:A&quot;))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &q=
uot;App custom control encoding must exactly base64 and ascii&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (p =3D=3D 2)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            protocols =3D token;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (p =3D=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(D_PUSH_ERRORS, &quot;Too many parameters for INFO ACC message/I=
V_ACC=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NU=
LL, delim, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        p++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    *max_acc_len =3D min_int(acclen,=
 ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret =3D string_alloc(protocols, gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(tmp_=
message_orig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+deter=
mine_common_acc_protocols(struct context *c)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!c-&gt;options=2Eacc_protocols)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* No app custom protocols have been configured server=
-side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eac=
c_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 We already have determined the common protocols=2E Doing this</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * again would just add =
an extra string allocation to options-&gt;gc */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* exam=
ple IV_ACC: IV_ACC=3D2048,6:A,flower:power */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *peer_info =3D c-&gt;c2=2Etls_mult=
i-&gt;peer_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *iv_acc =3D extract_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!iv=
_acc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char *protocols =3D parse_acc_parameters(iv_acc,=
 &quot;,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info variable of p=
eer is malformed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D =
strtok_r(protocols, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer common_protocols =3D alloc_buf_gc(1024, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (tls_item_in_cipher_list(token, c-&gt;opti=
ons=2Eacc_protocols))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* protocol is in both server and client list */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(&amp;common_proto=
cols) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    buf_write_u8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            buf_printf(&amp;common_protocols, &=
quot;%s&quot;, token);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (buf_len(&amp;common_protocols) =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING: No common ap=
p custom control protocol=2E&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2E=
acc_negotiated_protocols =3D string_alloc(buf_str(&amp;common_protocols), &=
amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    c-&gt;options=2Eacc_max_message_length =3D max_acc_len;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newli=
ne at end of file</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/op=
envpn/acc=2Eh</span><br><span>new file mode 100644</span><br><span>index 00=
00000=2E=2E5d9b203</span><br><span>--- /dev/null</span><br><span>+++ b/src/=
openvpn/acc=2Eh</span><br><span>@@ -0,0 +1,92 @@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  This program is free software; you can redistribute it and=
/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it un=
der the terms of the GNU General Public License version 2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software=
 Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is di=
stributed in the hope that it will be useful,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licens=
e for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, wri=
te to the Free Software Foundation, Inc=2E,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method parses=
 an app custom control message and delivers it to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * management interface=2E We leave reass=
embly of fragmented messages to the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * management interface=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param c            The context struct</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param buffer       Buffer containing the co=
ntrol message with ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct c=
ontext *c, const struct buffer *buffer);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context =
*c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 struct tls_multi *tls_multi,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 struct tls_session *session,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 const char *protocol, =
bool fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            const char *msg, bool base64);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an info message from =
the server that contains app custom control info</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * information prior to the PUSH_REPLY to be a=
ble to use app custom control</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * protocols before sending</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * In client mode only allow what we support ourselves=2E In server mode</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allow also capabil=
ities that we not support ourselves=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param capabilities      The string to parse</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param delim             The delimiter to =
use when parsing the string=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *                          IV_ACC uses &quot;,&quot; as delimit=
er while the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     custom-control PUSH message uses &quot; &quot; as &quo=
t;,&quot; is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     already used to separate different push directives</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len  =
     Set to the maximum ACC message length</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param server            Whether we are server or=
 client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc=
                The gc arena to use for allocating the resulting string</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return             =
     The resulting protocol string or NULL on error</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+parse_acc_parameters(const char *capabilities,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     const char *delim,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
int *max_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   bool server,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     struct gc_arena *gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Parses the IV_ACC of the peer and sets c-&gt;options=2Eacc_negotiated_pr=
otocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to the co=
mmon protocols of server and client and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * c-&gt;options=2Eacc_max_message_length  to the maxim=
um length of the ACC message</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * support by both server and client=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * If there is no common protocol or the client does not suppor=
t any app custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
protocol c-&gt;options=2Eacc_negotiated_protocols will be set to NULL=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param c     the client context to u=
se the set the app custom protocols=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+determine_co=
mmon_acc_protocols(struct context *c);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 2ade321=2E=2E736e975 1=
00644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/s=
rc/openvpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #=
include &quot;dco=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&=
quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><=
br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span=
> </span><br><span>@@ -251,11 +252,11 @@</span><br><span>     }</span><br><=
span>     else if (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       server_pushed_info(buf, 8);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        server_pushed_info(c, buf, 8);</span><br><span>     =
}</span><br><span>     else if (buf_string_match_head_str(buf, &quot;INFO&q=
uot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        server_pushed_info(buf, 4);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        server_pushed_info(c, buf, 4);</span><br><s=
pan>     }</span><br><span>     else if (buf_string_match_head_str(buf, &qu=
ot;CR_RESPONSE&quot;))</span><br><span>     {</span><br><span>@@ -265,6 +26=
6,10 @@</span><br><span>     {</span><br><span>         receive_auth_pendin=
g(c, buf);</span><br><span>     }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (buf_string_match_head_str(buf, &quot;ACC&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        receive_acc_message(c, bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span>     else if (buf_string_match_head_str(buf, &quot;EXIT&quot;))</span=
><br><span>     {</span><br><span>         receive_exit_message(c);</span><=
br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br=
><span>index 6b53686=2E=2Ee8e3a6d 100644</span><br><span>--- a/src/openvpn/=
init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -228=
3,6 +2283,10 @@</span><br><span>             buf_printf(&amp;out, &quot; ae=
ad-epoch&quot;);</span><br><span>         }</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_=
negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_=
printf(&amp;out, &quot; custom-control %d,A:6,%s&quot;, c-&gt;options=2Eacc=
_max_message_length, c-&gt;options=2Eacc_negotiated_protocols);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><=
br><span>     if (BLENZ(&amp;out) &gt; strlen(header))</span><br><span>    =
 {</span><br><span>@@ -2527,6 +2531,11 @@</span><br><span>         flags |=
=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;optio=
ns=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags =
|=3D OPT_P_ACC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    return flags;</span><br><span> }</span><br><span> </span><br><span>@@ -=
3342,6 +3351,7 @@</span><br><span>     to=2Everify_hash_depth =3D options-&=
gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_no_ca =3D optio=
ns-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex509_username_fi=
eld, options-&gt;x509_username_field, sizeof(to=2Ex509_username_field));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eacc_protocols=
 =3D options-&gt;acc_protocols;</span><br><span>     to=2Ees =3D c-&gt;c2=
=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_ctx;</span><br>=
<span> </span><br><span>@@ -4300,6 +4310,27 @@</span><br><span> }</span><br=
><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                   struct buffe=
r_list *input) /* ownership transferred */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool ret =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2E=
tls_multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_mult=
i *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;sessi=
on[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   struct options *opt =3D &amp;c-&gt;options;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ret =3D management_send_acc_message(c, multi, session, opt-=
&gt;acc_negotiated_protocols, input);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list=
_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br=
><span> void</span><br><span>@@ -4316,6 +4347,7 @@</span><br><span>        =
 cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><span>        =
 cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><span>      =
   cb=2Esend_cc_message =3D management_callback_send_cc_message;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D manag=
ement_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>     =
    cb=2Enetwork_change =3D management_callback_network_change;</span><br><=
span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec</span><br><span>index 29fdffc=2E=2Eabf6f8b 100644</span><br>=
<span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -44,8 +44,10 @@</span><br><span> #include &quot;dco=
=2Eh&quot;</span><br><span> #include &quot;push=2Eh&quot;</span><br><span> =
#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> =
#include &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><s=
pan> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;<=
/span><br><span>@@ -1080,6 +1082,35 @@</span><br><span>             }</span=
><br><span>             break;</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;persist=
=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_a=
cc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                                     =
                 man-&gt;connection=2Ein_extra_cid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
                             man-&gt;connection=2Ein_extra_kid,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                                       man-&gt;connection=2Ein_extra);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;=
connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                report_command_status(status, &quot;client-acc-=
msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                man_com=
mand_unsupported(&quot;client-acc-msg&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                bool status =3D (*man-&gt=
;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
                                 man-&gt;connection=2Ein_extra);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connec=
tion=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                report_command_status(status, &quot;acc-msg&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                man_command_unsuppor=
ted(&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            break;</span><br><span>         case IEC_PK_SIGN:</span><br><sp=
an>             man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><br=
><span>             buffer_list_free(man-&gt;connection=2Eext_key_input);</=
span><br><span>@@ -1204,6 +1235,29 @@</span><br><span> }</span><br><span> <=
/span><br><span> static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+man_client_acc_msg(struct management *man, const char *cid_str,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                   con=
st char *kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_conne=
ction *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc=
-&gt;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra=
_kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd=
 =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;=
man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span> man_client_auth(struct management *man, const cha=
r *cid_str, const char *kid_str, const bool extra)</span><br><span> {</span=
><br><span>     struct man_connection *mc =3D &amp;man-&gt;connection;</spa=
n><br><span>@@ -1760,6 +1814,17 @@</span><br><span>             man_client_=
pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (streq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (man_need(man, p, 2, 0))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>   =
  else if (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><=
br><span>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ =
-3131,6 +3196,7 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> void</span><br><span> management_connection_established(struct management=
 *management, struct man_def_auth_context *mdac,</span><br><span>          =
                         const struct env_set *es)</span><br><span>@@ -4362=
,6 +4428,62 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message(struct =
context *c, struct tls_multi *multi, struct tls_session *session,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                            c=
onst char *negotiated_protocols, struct buffer_list *input)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* also ensures that are enough inputs in the lis=
t to safely call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * buffer_list_peek without extra NULL checks */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough=
 input lines for sending acc message, &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                      &quot;missing protocol, flag=
 and/or messages lines&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffe=
r *proto_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *protocol =3D string_alloc(BSTR(proto_=
buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(encoding_b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *flag =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool b=
64encoding =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool fragment =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            b64encoding =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else if (!strcmp(flag, &quot;=
F&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fragment=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(input, 1=
0000, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!negotiated_protocols || !tls_item_in_c=
ipher_list(protocol, negotiated_protocols))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_CLIENT, &quot;protocol not in the list of negotiate=
d protocols: %s&quot;, np(negotiated_protocols));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        goto error;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 bool ret =3D send_acc_message(c, multi, session, protocol,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                fra=
gment, buf_str(acc_msg_buf),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                b64encoding);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEMENT */=
</span><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</span><b=
r><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span>=
<br><span>index f752fec=2E=2Ede9303b 100644</span><br><span>--- a/src/openv=
pn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>=
@@ -184,12 +184,19 @@</span><br><span>     int (*n_clients)(void *arg);</sp=
an><br><span>     bool (*send_cc_message)(void *arg, const char *message, c=
onst char *parameter);</span><br><span>     bool (*kill_by_cid)(void *arg, =
const unsigned long cid, const char *kill_msg);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     bool (*client_auth)(void =
*arg, const unsigned long cid, const unsigned int mda_key_id,</span><br><sp=
an>                         const bool auth, const char *reason, const char=
 *client_reason,</span><br><span>                         struct buffer_lis=
t *cc_config); /* ownership transferred */</span><br><span>     bool (*clie=
nt_pending_auth)(void *arg, const unsigned long cid, const unsigned int kid=
,</span><br><span>                                 const char *extra, unsig=
ned int timeout);</span><br><span>     char *(*get_peer_info)(void *arg, co=
nst unsigned long cid);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool (*client_acc_msg)(void *arg,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                           const unsigned long cid,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
      const unsigned int mda_key_id,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                           struct buffer_list *msg);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)(void =
*arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      struct buffer_list *msg);</span><br><span>     bool (*proxy_cmd)(void=
 *arg, const char **p);</span><br><span>     bool (*remote_cmd)(void *arg, =
const char **p);</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@ =
-292,13 +299,15 @@</span><br><span>     struct command_line *in;</span><br>=
<span>     struct buffer_list *out;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF          0</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_AUTH =
   1</span><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIGN    3=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CERTIFICA=
TE 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PK_SI=
GN     5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_P=
ASSWORD    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 IEC_RSA_SIGN       3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define IEC_CERTIFICATE    4</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define IEC_PK_SIGN        5</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define IEC_PASSWORD       6</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</span><b=
r><span>     int in_extra_cmd;</span><br><span>     struct buffer_list *in_=
extra;</span><br><span>     unsigned long in_extra_cid;</span><br><span>@@ =
-503,6 +512,14 @@</span><br><span> </span><br><span> void man_persist_clien=
t_stats(struct management *man, struct context *c);</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC messag=
e from the input buffer_list and send to the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * session identified by session and multi</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct tls_session;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_send_acc_message(struct context *c, struct tl=
s_multi *multi, struct tls_session *session,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            const char *negotiated=
_protocols, struct buffer_list *input);</span><br><span> #endif /* ifdef EN=
ABLE_MANAGEMENT */</span><br><span> </span><br><span> /**</span><br><span>d=
iff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>i=
ndex b28cf80=2E=2Eb444433 100644</span><br><span>--- a/src/openvpn/multi=2E=
c</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -52,6 +52,=
7 @@</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #i=
nclude &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filter=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;acc=2Eh&quot;</span><br><span> </span><br><span> /*#define MULTI_DEBU=
G_EVENT_LOOP*/</span><br><span> </span><br><span>@@ -1773,6 +1774,13 @@</sp=
an><br><span>         o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NOT=
IFY;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (o-&gt;acc_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* If ACC is enabled server side call to find =
common acc protocols,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * will be pushed during push message */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        determine_common_acc_protocols(c);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Select cip=
her if client supports Negotiable Crypto Parameters */</span><br><span> </s=
pan><br><span>     /* if we have already created our key, we cannot *change=
* our own</span><br><span>@@ -4032,6 +4040,24 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+calculate_app_control_extra(struct context *c, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protoc=
ols(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc_ne=
gotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
CLIENT, &quot;ACC: No negotiated protocols&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf =3D alloc_buf_gc(1024, gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, c-&gt;optio=
ns=2Eacc_max_message_length, c-&gt;options=2Eacc_negotiated_protocols);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&amp=
;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> man=
agement_client_pending_auth(void *arg, const unsigned long cid, const unsig=
ned int mda_key_id,</span><br><span>                                const c=
har *extra, unsigned int timeout)</span><br><span>@@ -4042,10 +4068,22 @@</=
span><br><span>     if (mi)</span><br><span>     {</span><br><span>        =
 struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &quo=
t;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            extr=
a =3D calculate_app_control_extra(&amp;mi-&gt;context, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (!extra)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span>         struct tls_session *session =3D lookup_session_by_mda_=
key_id(multi, mda_key_id);</span><br><span> </span><br><span>         if (!=
session)</span><br><span>         {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span>             =
return false;</span><br><span>         }</span><br><span> </span><br><span>=
@@ -4053,6 +4091,7 @@</span><br><span>         bool ret =3D send_auth_pendi=
ng_messages(multi, session, extra, timeout);</span><br><span>         resch=
edule_multi_process(&amp;mi-&gt;context);</span><br><span>         multi_sc=
hedule_context_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        gc_free(&amp;gc);</span><br><span>         return ret;</s=
pan><br><span>     }</span><br><span>     return false;</span><br><span>@@ =
-4096,6 +4135,39 @@</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+management_client_acc_msg(void *=
arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
           const unsigned long cid,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                          const unsigned int mda_key_id,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
    struct buffer_list *input) /* ownership transferred */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct multi_context *m =3D (struct multi_context =
*)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mu=
lti_instance *mi =3D lookup_by_cid(m, cid);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (mi &amp;&amp; buffer_list_defined(input))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D mi-&gt;context=
=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct tls_session *session =3D lookup_session_by_mda_key_id(multi, =
mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_CLIENT, &quot;client session not found&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            buffer_list_free(input);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct options *opt =3D &amp;mi-&gt;context=
=2Eoptions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_=
send_acc_message(&amp;mi-&gt;context, multi, session, opt-&gt;acc_negotiate=
d_protocols, input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        multi_schedule_context_wakeup(m, mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
ffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static char *</span>=
<br><span> management_get_peer_info(void *arg, const unsigned long cid)</sp=
an><br><span> {</span><br><span>@@ -4132,6 +4204,7 @@</span><br><span>     =
    cb=2En_clients =3D management_callback_n_clients;</span><br><span>     =
    cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br><span>         c=
b=2Eclient_auth =3D management_client_auth;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D management_client_a=
cc_msg;</span><br><span>         cb=2Eclient_pending_auth =3D management_cl=
ient_pending_auth;</span><br><span>         cb=2Eget_peer_info =3D manageme=
nt_get_peer_info;</span><br><span>         cb=2Epush_update_broadcast =3D m=
anagement_callback_send_push_update_broadcast;</span><br><span>diff --git a=
/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 17=
8b5f6=2E=2E27540e7 100644</span><br><span>--- a/src/openvpn/options=2Ec</sp=
an><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -35,6 +35,7 @=
@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;acc=2Eh&quot;</span><br><span> #include &quot;buffer=2Eh&quot;</spa=
n><br><span> #include &quot;error=2Eh&quot;</span><br><span> #include &quot=
;common=2Eh&quot;</span><br><span>@@ -7100,6 +7101,28 @@</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&=
gt;force_key_material_export =3D true;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ap=
p-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;acc_proto=
cols =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(=
p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp=
; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        V=
ERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot=
;App custom control encoding must be base64 and ascii&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;acc_max=
_message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                           &quot;app custom message message length&quot;, A=
CC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        options-&gt;acc_negotiated_protocols =3D p[3];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if=
 (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br=
><span>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --prng opt=
ion ignored (SSL library PRNG is used)&quot;);</span><br><span>diff --git a=
/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 13=
1513e=2E=2Eef4f1fe 100644</span><br><span>--- a/src/openvpn/options=2Eh</sp=
an><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -711,6 +711,1=
6 @@</span><br><span>     /* force using TLS key material export for data c=
hannel key generation */</span><br><span>     bool force_key_material_expor=
t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /** The app custom control protocols we should announce as supported *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ac=
c_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols that=
 are negotiated with the peer=2E As a client we</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * trust the server pushed list here */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc_neg=
otiated_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the maximum =
length of an ACC control channel message */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int acc_max_message_length;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool vlan_tagging=
;</span><br><span>     enum vlan_acceptable_frames vlan_accept;</span><br><=
span>     uint16_t vlan_pvid;</span><br><span>@@ -762,8 +772,10 @@</span><b=
r><span> #define OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #d=
efine OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P=
_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define OPT_P_ACC             (1ull &lt;&lt; 32)</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DE=
FAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Options allowed in the =
normal configuration file (vs pushed options or in ccd files) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P=
_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> =
</span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2E=
c</span><br><span>index fa7bf1e=2E=2E12068b5 100644</span><br><span>--- a/s=
rc/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><s=
pan>@@ -27,6 +27,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</sp=
an><br><span> </span><br><span> #include &quot;push=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #inclu=
de &quot;options=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;=
</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -220,9 +2=
22,8 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(const st=
ruct buffer *buffer, const int adv)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+server_pushed_info(struct context *c, const struct buffer *=
buffer, const int adv)</span><br><span> {</span><br><span>     const char *=
m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *buffer;</sp=
an><br><span>@@ -232,6 +233,27 @@</span><br><span>         m =3D BSTR(&amp;=
buf);</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        int max_acc_len =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* example string to parse: ACC:1400 A:6 flower:hap=
py */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ski=
p over the ACC: prefix */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        m +=3D 4;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *p=
rotocols =3D parse_acc_parameters(m, &quot; &quot;, &amp;max_acc_len, false=
, &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (protocols)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            c-&gt;options=2Eacc_negotiated_protocols =3D protocols;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=
=2Eacc_max_message_length =3D max_acc_len;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command with in=
valid parameters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #=
ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</span><br>=
<span>     if (management)</span><br><span>@@ -284,6 +306,7 @@</span><br><s=
pan>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&#39;)&qu=
ot;, m);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Parse t=
he keyword for the AUTH_PENDING request</span><br><span>  * @param buffer  =
              buffer containing the keywords, the buffer&#39;s</span><br><s=
pan>@@ -440,7 +463,6 @@</span><br><span>     const char *const peer_info =
=3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int proto =3D ex=
tract_iv_proto(peer_info);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maximum timeo=
ut and subtract the time we already waited */</span><br><span>     unsigned=
 int max_timeout =3D</span><br><span>         max_uint(tls_multi-&gt;opt=2E=
renegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span><br><=
span>@@ -731,6 +753,11 @@</span><br><span>                 client_max_mtu, =
o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         }</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=
=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6 %s&q=
uot;, c-&gt;options=2Eacc_max_message_length, c-&gt;options=2Eacc_negotiate=
d_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span> }</span><br><span> </span><br><span> #if defined(__GNUC__)=
 || defined(__clang__)</span><br><span>diff --git a/src/openvpn/push=2Eh b/=
src/openvpn/push=2Eh</span><br><span>index dff945f=2E=2E3aca8a7 100644</spa=
n><br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/pu=
sh=2Eh</span><br><span>@@ -52,6 +52,7 @@</span><br><span> </span><br><span>=
 int process_incoming_push_request(struct context *c);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**<=
/span><br><span>  * @brief Handles the receiving of a push-update message a=
nd applies updates to the specified</span><br><span>  * options=2E</span><b=
r><span>@@ -92,7 +93,7 @@</span><br><span> </span><br><span> void receive_e=
xit_message(struct context *c);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void server_pushed_info(const struct buffer *bu=
ffer, const int adv);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void server_pushed_info(struct context *c, const struct buffer *buffer, c=
onst int adv);</span><br><span> </span><br><span> void receive_cr_response(=
struct context *c, const struct buffer *buffer);</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec<=
/span><br><span>index fcc5411=2E=2E6462a97 100644</span><br><span>--- a/src=
/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</spa=
n><br><span>@@ -370,4 +370,4 @@</span><br><span> </span><br><span>     RETU=
RN_UPDATE_STATUS(n_sent);</span><br><span> }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT *=
/</span><br><span>\ No newline at end of file</span><br><span>diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1f9=2E=
=2Ea5663e3 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><spa=
n> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span>=
 #include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;ssl_=
verify=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</spa=
n><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -2054,6 +2=
055,11 @@</span><br><span>                     }</span><br><span>          =
       }</span><br><span>             }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (session-&gt;opt-&gt;acc_protocols)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &quot;IV_A=
CC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span>         }</span><br><span>     }</span><br><span> </span><br><=
span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</=
span><br><span>index db61198=2E=2E3b326a7 100644</span><br><span>--- a/src/=
openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</sp=
an><br><span>@@ -452,6 +452,9 @@</span><br><span>     size_t ekm_size;</spa=
n><br><span> </span><br><span>     bool dco_enabled; /**&lt; Whether keys h=
ave to be installed in DCO or not */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /** The app custom control protocols we should announce as supported */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc_p=
rotocols;</span><br><span> };</span><br><span> </span><br><span> /** @addto=
group control_processor</span><br><span>diff --git a/tests/unit_tests/openv=
pn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>i=
ndex 5954902=2E=2E753e59d 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>@@ -103,9 +103,11 @@</span><br><span> 	@TEST_CFLAGS@<=
/span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYP=
TO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    test_acc=2Ec test_acc=
=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span>=
<br><span> 	mock_management=2Ec \</span><br><span> 	mock_ssl_dependencies=
=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base6=
4=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br>=
<span>@@ -127,6 +129,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/run_c=
ommand=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_nc=
p=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><span>@@ -=
375,8 +378,10 @@</span><br><span> </span><br><span> misc_testdriver_SOURCES=
 =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedule=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management=
=2Ec mock_management=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2Eh  =
\</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/ssl_util=2Ec \</span><br><span>@@ -388,6 +393,7 @@</span><br><span> 	$(top=
_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/siphash_reference=2Ec</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> push_update_msg_testdriver_CFLAGS=
 =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/co=
mpat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</span><=
br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/=
unit_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=2Ec=
ddd669 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_managemen=
t=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</s=
pan><br><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #include=
 &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> #includ=
e &quot;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span>@@ -60,4 +61,4 @@</span><br><span> void</span><br=
><span> management_sleep(const int n)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/unit_=
tests/openvpn/mock_management=2Eh</span><br><span>new file mode 100644</spa=
n><br><span>index 0000000=2E=2Ee21aec43</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Eh</span><br><sp=
an>@@ -0,0 +1,32 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
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
;">+#ifndef MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void init_mock_management(void);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void uninit_mock_management(void);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_pus=
h_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</s=
pan><br><span>index 112bcfd=2E=2Ec16d0cb 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,=
8 @@</span><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS =
| OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span>                      | O=
PT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span=
><br><span>                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY |=
 OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU |=
 OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU=
 | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     | OPT_P_ACC;</span><br><span>     return fl=
ags;</span><br><span> }</span><br><span> </span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E16b2=
b3b</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,298 @@</span><br><span style=
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
style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_a=
cc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char control_c=
hannel_mesage_sent[2048];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mock funct=
ions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string=
_dowork(struct tls_session *session,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                   const char *str, int ms=
glevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range(strlen=
(str), 0, 2048);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(control_cha=
nnel_mesage_sent, str, strlen(str));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, =
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
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    skip();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* ensure that the messages get to mock_msg */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =
=3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    managemen=
t =3D (void *)0x12345678;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* contains a TLS 1=2E3 ClientHello */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC,cck1,384,6,&q=
uot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer msg=
_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct con=
text c =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE=
]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eop=
t-&gt;mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg, si=
zeof(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rece=
ive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(mock_msg_buf, &quot;Received custom app control mes=
sage (protocol &#39;cck1&#39;)&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CL=
IENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char flower_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD=
//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg, siz=
eof(flower_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Receiv=
ed custom app control message (protocol &#39;flower&#39;)&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_=
managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aG=
Ug77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char msg_incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm=
1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg=
_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &a=
mp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *error =3D &quot;WARNING: Received malformed custom app control cha=
nnel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                &quot;(field length 62, payload length 64 mismatch) message=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            &quot;control message: 496e7367 496d316c 496a6f67 496d5a79 &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       &quot;62326369 4c434141 65475a6d 2f534a7[more=2E=2E=2E]&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG=
8gdw=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_set_read(&amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_messa=
ge(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom app contr=
ol message (protocol &#39;power&#39;, fragment)&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_=
buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* check two encoding present */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_m=
sg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94o=
CPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof(fl=
ower_msg_two_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    error =3D &quot;WARNING: Received malformed custom app control=
 channel (number of &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;encodings must be exactly one (B64=3D1, ASCII=3D1)=
) message control &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;message: 53534268 62534141 4945746c 636d3170 6443442=
f 2f534230 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, er=
ror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* no encoding present */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char flower_msg_no_encs[] =3D &quot;ACC,flower,48=
,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (v=
oid *)flower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg=
_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Rec=
eived malformed custom app control channel (number of &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;encodings must b=
e exactly one (B64=3D0, ASCII=3D0)) message control &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;message: 53534268 =
62534141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;61475567 37372b3[more=
=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_pars=
e_acc_parameters(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* parameters to INFO message */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &quot;4096 A:6 =
flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_len =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_le=
n, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1280=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* a client does not accept a le=
ngth longer than it supports */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &qu=
ot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* message with lower limit than our, should work for client and s=
erver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_ac=
c_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_ms=
g, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flowe=
r:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
otocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than supported=
=2E Server should be okay, client should fail */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B flower:h=
appy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prot=
ocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, f=
alse, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =
=3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flow=
er:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto=
cols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, fa=
lse, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capabilities=
 =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv_acc_cap=
abilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quo=
t;flower:happy:power&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* too=
 small protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_paramet=
ers(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol length */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D =
&quot;abff A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quo=
t;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* non-numerical protocol length */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:ha=
ppy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
otocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_acc_common_protocols(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct context c =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_=
multi, &amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,f=
lower:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    c=2Eoptions=2Eacc_protocols =3D &quot;power:flower:star&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(&amp;c=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(c=2Eoptions=2Ea=
cc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(c=2Eoptions=2Eacc_negotiated_p=
rotocols, &quot;flower:power&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_acc_send_message(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2E=
tls_multi, struct tls_multi, &amp;c=2Eoptions=2Egc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    c=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV=
_ACC=3D1400,A:6,flower:emergency:power&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    c=2Eoptions=2Eacc_protocols =3D &quot;power:f=
lower:emergency&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    determine_common_acc_protocols(&amp;c);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
tls_session *session =3D &amp;c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(&amp;c, c=2E=
c2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;EMERGENC=
Y BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(control_channel_mesage_sent,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DR=
ILL:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_messa=
ge(&amp;c, c=2Ec2=2Etls_multi, session, &quot;emergency&quot;, false,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E=
&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(control_channel_mesage_sent,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        &quot;ACC,emergency,=
65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* test a long message (&gt; 1000) with fragment=
 to get the maximum header size */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char long_message[1200] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        long_message[i] =3D (char)(&#39; &#39; + (i % =
95));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* last char of the message is a i and then=
 a \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(long_message[1023], &#39;i&#39;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1024], &#39;\0&#3=
9;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(&amp;=
c, c=2Ec2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           long_me=
ssage, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cc_len =3D =
strlen(control_channel_mesage_sent);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(control_channel_mesage_sent[cc_len - =
1], &#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *expected_start_cc =3D &quot;ACC,emergency,1024,AF, !\&quot;#$=
%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_memory_equal(control_channel_mesage_sent, expecte=
d_start_cc, sizeof(expected_start_cc));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/o=
penvpn/test_acc=2Eh</span><br><span>new file mode 100644</span><br><span>in=
dex 0000000=2E=2Ea64bab5</span><br><span>--- /dev/null</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             over a single TCP/UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc=2E,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_=
client_messages(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_parse_acc_parameters(void **state);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid test_acc_common_protocols(void **state);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void test_acc_send_message(void **state);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</s=
pan><br><span>index 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_common=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span=
> #define LargestIntegralType uintmax_t</span><br><span> #endif</span><br><=
span> /* redefine 2=2Ex API in terms of 1=2Ex API */</span><br><span style=
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
t_misc=2Ec</span><br><span>index a41c27b=2E=2E82292f1 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -40,11 +40,34 @@</span>=
<br><span> #include &quot;list=2Eh&quot;</span><br><span> #include &quot;mo=
ck_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> #ifdef _WIN32</span><br><span> #include &quot;win32-uti=
l=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &quot;test_schedule=2Eh&quot;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* extra mocks */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct context *c, str=
uct options *options, struct buffer *buf,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   uint64_t permission_mask, uint64_t=
 *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   struct env_set *es, bool is_update)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(struct c=
ontext *c, const char *str, msglvl_t msglevel)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    check_expected_ptr(str);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lookup_by_cid(stru=
ct multi_context *m, const unsigned long cid)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return *(m-&gt;instances);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span> </span><br><span> static void</span><=
br><span> test_compat_lzo_string(void **state)</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>index 887c492=2E=2Eaa639ff 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</span><br><span>=
 #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;openvp=
n=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* Mock function to be allowed to=
 include win32=2Ec which is required for</span><br><span>  * getting the te=
mp directory */</span><br><span> #ifdef _WIN32</span><br><span>@@ -86,6 +88=
,20 @@</span><br><span> {</span><br><span>     return;</span><br><span> }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_process(struct cont=
ext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Define a dummy dco cipher option to avoid linking against all th=
e DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * units */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers=
(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES-192-GCM:AE=
S-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* generated=
 using</span><br><span>  * openssl req -x509 -newkey ec -pkeyopt ec_paramge=
n_curve:secp384r1 -keyout - \</span><br><span>@@ -960,8 +976,11 @@</span><b=
r><span>         cmocka_unit_test(test_data_channel_known_vectors_epoch),</=
span><br><span>         cmocka_unit_test(test_data_channel_known_vectors_sh=
ortpktid),</span><br><span>         cmocka_unit_test(crypto_test_print_cert=
_details),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmo=
cka_unit_test(ssl_test_extract_peer_info)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(ssl_test_extract_peer_info),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_parse_=
client_messages),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_parse_acc_parameters),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_common_pro=
tocols),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_acc_send_message)</span><br><span>     };</span><br><spa=
n> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8=
ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--dHvo4a+KAiU=--


--===============4518699328949357508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4518699328949357508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4518699328949357508==--

