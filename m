Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFC6C61DBD
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q5jTuQVw40cH0TRMBO/ULt2aaqQSLnsOtIynhcpSW60=; b=UGY5VE+Br/MG4wpQoROloJ2Dfc
	qUtsO/AE7lhTDDSy4U63EP4vK6vPqpo30OQQoNz4MvTa64SjjMSiq4vXgS6gzi9FQF3pHsb4hl89l
	c1lAdoq7a9keTdA+LIMkttmrBWvSJrMVsCG+DUIbl2pJdtyF7DRyANqqfuCJGFBe5WVI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyzw3-0003ka-5Q;
	Tue, 25 Aug 2026 22:48:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyzw1-0003kI-EE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 22:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KkmibzZHkcEqYTCHH17sps0rRUJ65HI3FlwkWmfLxjk=; b=GOYcpunIuhW2nkn/0LcqtGai17
 xuInNJYimP9yE0iwHUcBk/wBwlQJL32YH8tYdNM92on/L5KsauaWhCWzUq8nzQmOB/KQ1/irK+Kza
 ZqxnZDEQW3486DqB+Tsvfyfy1DHXHWCuClnmjjv7TyX6UKxs2gXqgcSiPSak8W92nJiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KkmibzZHkcEqYTCHH17sps0rRUJ65HI3FlwkWmfLxjk=; b=i
 Y3E1zfRa5czzlZfyGPdPJ1TVv0MuwMSUUXaZFDz+DvzIPSNUwyzKjczHytiKwcdNXjRZZ6sgH5o3m
 ejLAWZx/dXuzSQsos/A91xi93TtcyQYGW9t7re7bOF2ORTwJPaVwDJpNHT57owD8nHVQ9J0LIbywo
 yu2vE+3BcJunxyXY=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyzvv-0004vE-KK for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 22:48:02 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c2074710751so34674966b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787698069; x=1788302869; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KkmibzZHkcEqYTCHH17sps0rRUJ65HI3FlwkWmfLxjk=;
 b=CMVCanTISBIcy8gdqQI0MGJ6Viao6PmOYz8WroLpzUfI/e/p3+rk1zJJz71UhAGbnE
 mwHEC9yyReFS/ssBZ7HeuoNU83F3GNpbPwhCjjCbtdFwAI0ZuRllJLNJizVuWMVVb/WG
 i85vqPEubHdhigoEXYGGZC1jirVa36oMSBlSsu0miJ3S5LB+T9kN6hFiewN15DNTNBtU
 tJsud0iCsHAhATcVXun7cc28KmmqFrklHAUC0GfBoD5lQzzfzRUYJShd7HonjDh/IR/V
 06AEs0u7z1cwgeq2AWR+D2pjoYO3BntLP03S5j7ocHdhzC9IRKQKEsztDLgxPTWxbaZf
 9hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698069; x=1788302869;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KkmibzZHkcEqYTCHH17sps0rRUJ65HI3FlwkWmfLxjk=;
 b=XR7MFBiuRhRwDAYnpus5pGjkiaprsueieXjmh3jeL7TTppF4VogREzokqgRBZfuxay
 WRUY/zVXHPuoY/4ghgEba9ffpLDM2ADTTmPT27wwn14i8Pu+rVIvjjIL10S49sZxy0uj
 j9QiNc5w6255S2ZeTwaWeZXpWa1VsK7ANKYgTdwDSYI9ic5QqyneDAosWzP9GGimD9Vg
 jeQGo/LyIatWkQBpud5MI/Hz1+xKQIg+9dv6Q/hWtP8+KYZ21zPmnFaqHU0FdJQXsYGB
 KrAWXfh79lItMNuTN64nWUCOLcYLG+M0Tx4fhk9ZeauthHp3lSfgHkJHicpeTpCUsGCr
 IWmw==
X-Gm-Message-State: AFuF++lpd2jChF9O8BcDa4sXJ41TIrl8Wm0yBKAEV+dmljEazUWMPR8E
 KseXu0EeqSLG/KthGPzNkwXacOcSJvV0NZCxyXmRjsYb17zJIIhJW4noWtTw+j20qv8HqHMAHrZ
 Kmy9sOCw8mb693Ti3O0uBsSWKH4iDSaaXwE8xiSR/02HqiiWmg8f9AKCmVvKsMuHl1AlDUUKbZP
 tUHIXnBg==
X-Gm-Gg: AR+sD121t4hZl9jgNrnDzeUGCG2GYyXzDXmtT/DoDCnxOIrgfK9ItGe99eXOv9P8w2h
 ivzp2ixcAXUynEYljPYZNI6WaGErU0cUNLM/+qnYKEt1tzZqJRmRx8c4sqitrePU/7aB7sRQDBY
 ZAk4p12v1NAYWhZIC7eA9s8YwGRveI6fZKNQ4iqLaCDVzS3SOTvNfNCwxBa0/NgFRZZBWT2eYYm
 Un30tkjYxyuRrxNzyQOcejQtxhtjkaVCE85n9xS6v3b1HCzBqQeWilTNZlQmoH2FOx1XDc0qeLN
 9KfcnMJaZ3PeeIMj+x1aAnsFKidz18RS+oiCRdPBfRKKOKzM9Yvf9XRZR+gkC6+WZlkF7Nnyrin
 jMcme66WHbNQVT1u0OJB6MbyUg4W1zzTc8Z/E56qHkRlt3tApOKJVQKqxmbqA3dvqhvu8kO8kie
 UNmdL+sKW0KEA5dpYiY9ljA2ncxNz/d5/UgVV37fn+YkY2U+ZV2QQiacUxi/cXgpTXLIQyKFiAs
 60tubBIHWVP5VPFMFQZhyviJwCvhvM8itv8JU9ZN0Xfd4ObTR3ZulEFRhuTzs6gy+gxmBiP0x0Y
 7QKk2JVpxUeLvl9eO1NSGh+mqzpwO3KX9bMhGDbWszmYrWBw1Co=
X-Received: by 2002:a17:907:7203:b0:c24:dd7f:3254 with SMTP id
 a640c23a62f3a-c250c4492b6mr214254766b.3.1787698068073; 
 Tue, 25 Aug 2026 15:47:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704f19sm178438466b.22.2026.08.25.15.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:47:47 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 22:47:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 94c01122c2c1b024171e86a68140a114abf66607
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <649fd9c8187dfdd45815ebfde463cc6bbc0b1662-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyzvv-0004vE-KK
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
Content-Type: multipart/mixed; boundary="===============5456509866113187968=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5456509866113187968==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mwRsbhah9Hg="; charset=UTF-8

--mwRsbhah9Hg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#6)=2E ( http://gerrit=2Eopenvpn=2E=
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
anged, 1,350 insertions(+), 28 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/58/1858/6

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
index 0000000=2E=2Ea5d6641
--- /dev/n=
ull
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,402 @@
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
+    int payload_len =3D =
0;
+    if (!buffer_read_int(&buf, &payload_len))
+    {
+        err_reaso=
n =3D "could not extract payload length field";
+        goto err;
+    }
+=

+    /* comma after the length */
+    if (buf_read_u8(&buf) !=3D ',')
+  =
  {
+        err_reason =3D "missing , after payload len";
+        goto er=
r;
+    }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_reason, &=
gc);
+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We sh=
ould have a final NUL byte in the control message buffer
+     * and thus t=
he length of the buffer should be payload_len + 1 */
+    if (buf_len(&buf)=
 !=3D payload_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc)=
;
+        snprintf(tmp, 512, "field length %d, payload length %d mismatch"=
,
+                 payload_len, buf_len(&buf) - 1);
+        err_reason =
=3D tmp;
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf, payloa=
d_len, protocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D=
_PUSH_ERRORS, "WARNING: Received malformed custom app control channel "
+  =
                     "(%s) message control message: %s",
+        err_reaso=
n,
+        format_hex(BPTR(&buf), BLEN(&buf), 80, &gc));
+    gc_free(&gc)=
;
+}
+
+
+bool
+send_acc_message(struct context *c,
+                 struc=
t tls_multi *tls_multi,
+                 struct tls_session *session,
+   =
              const char *protocol, bool fragment,
+                 const =
char *msg, bool base64)
+{
+    /*
+     * length of the protocol string + =
one ','
+     * 2 for the encoding (A or 6), potential F (fragment), and 1 =
for the ',',
+     * 4 for the message size itself and one comma
+     * 1 =
for the comma before the message itself */
+    const size_t max_header_siz=
e =3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t le=
n =3D max_header_size + strlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)=

+    {
+        msg(M_CLIENT, "message length (%zu) exceeds maximum possib=
le message length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;=

+    }
+
+    if ((int)len > c->options=2Eacc_max_message_length)
+    {
+=
        msg(M_CLIENT, "header (%zu) + message size (%zu) length (%zu) excee=
ds "
+                      "maximum allowed length negotiated with peer (%=
d)",
+            max_header_size, strlen(msg), len,
+            c->option=
s=2Eacc_max_message_length);
+        return false;
+    }
+
+    struct gc=
_arena gc =3D gc_new();
+    /* add 1 for the final \0 */
+    struct buffe=
r buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppet=
s,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", proto=
col,
+               strlen(msg),
+               base64 ? "6" : "A",
+    =
           fragment ? "F" : "",
+               msg);
+
+    send_control_c=
hannel_string_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_pr=
ocess(c);
+    gc_free(&gc);
+    return true;
+}
+
+char *
+parse_acc_para=
meters(const char *capabilities,
+                     const char *delim,
+=
                     int *max_acc_len,
+                     bool server,
+=
                     struct gc_arena *gc)
+{
+    char *tmp_message =3D str=
ing_alloc(capabilities, NULL);
+    char *tmp_message_orig =3D tmp_message;=

+    char *lasts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_messa=
ge, delim, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const c=
har *protocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode =
we allow more capabilities than our own, in client
+     * mode we reject i=
f we should use capabilities that we do not support */
+    int allowed_acc=
_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+ =
       if (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message len=
gth", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+       =
     goto done;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_ciphe=
r_list("A", token) || !tls_item_in_cipher_list("6", token)))
+        {
+  =
          msg(D_PUSH_ERRORS, "App custom control encoding must include base=
64 and ascii");
+            goto done;
+        }
+
+        if (p =3D=3D =
1 && !server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+ =
           msg(D_PUSH_ERRORS, "App custom control encoding must exactly bas=
e64 and ascii");
+            goto done;
+        }
+
+        if (p =3D=3D=
 2)
+        {
+            protocols =3D token;
+        }
+
+        if (=
p =3D=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters=
 for INFO ACC message/IV_ACC=2E");
+            goto done;
+        }
+
+  =
      token =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    =
*max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_allo=
c(protocols, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}=

+
+
+void
+determine_common_acc_protocols(struct context *c)
+{
+    if (!=
c->options=2Eacc_protocols)
+    {
+        /* No app custom protocols have=
 been configured server-side=2E */
+        return;
+    }
+    if (c->opti=
ons=2Eacc_negotiated_protocols)
+    {
+        /* We already have determin=
ed the common protocols=2E Doing this
+         * again would just add an e=
xtra string allocation to options->gc */
+        return;
+    }
+
+    str=
uct gc_arena gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,f=
lower:power */
+    const char *peer_info =3D c->c2=2Etls_multi->peer_info;=

+    char *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
=
+    if (!iv_acc)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+=
    int max_acc_len =3D 0;
+    char *protocols =3D parse_acc_parameters(iv=
_acc, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+       =
 gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info varia=
ble of peer is malformed");
+        return;
+    }
+
+    char *lasts =3D =
NULL;
+    const char *token =3D strtok_r(protocols, ":", &lasts);
+
+    s=
truct buffer common_protocols =3D alloc_buf_gc(1024, &gc);
+
+    while (to=
ken)
+    {
+        if (tls_item_in_cipher_list(token, c->options=2Eacc_pr=
otocols))
+        {
+            /* protocol is in both server and client =
list */
+            if (buf_len(&common_protocols) > 0)
+            {
+  =
              buf_write_u8(&common_protocols, ':');
+            }
+       =
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
index 8342d16=2E=2Eb444433 100=
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
@@ -4042,17 +4068,30 @@
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
-        
+
         /* sends INFO_PRE and AUTH_PENDING mes=
sages to client */
         bool ret =3D send_auth_pending_messages(multi, =
session, extra, timeout);
         reschedule_multi_process(&mi->context);
=
         multi_schedule_context_wakeup(m, mi);
+        gc_free(&gc);
     =
    return ret;
     }
     return false;
@@ -4096,6 +4135,39 @@
     retur=
n ret;
 }
 
+
+static bool
+management_client_acc_msg(void *arg,
+         =
                 const unsigned long cid,
+                          const =
unsigned int mda_key_id,
+                          struct buffer_list *inp=
ut) /* ownership transferred */
+{
+    struct multi_context *m =3D (struct=
 multi_context *)arg;
+    struct multi_instance *mi =3D lookup_by_cid(m, c=
id);
+
+    bool ret =3D false;
+    if (mi && buffer_list_defined(input))
=
+    {
+        struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+=
        struct tls_session *session =3D lookup_session_by_mda_key_id(multi,=
 mda_key_id);
+        if (!session)
+        {
+            msg(M_CLIENT, =
"client session not found");
+            buffer_list_free(input);
+       =
     return false;
+        }
+
+        struct options *opt =3D &mi->conte=
xt=2Eoptions;
+
+        ret =3D management_send_acc_message(&mi->context, =
multi, session, opt->acc_negotiated_protocols, input);
+        multi_sched=
ule_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(input);
+    retu=
rn ret;
+}
+
+
 static char *
 management_get_peer_info(void *arg, const un=
signed long cid)
 {
@@ -4132,6 +4204,7 @@
         cb=2En_clients =3D manag=
ement_callback_n_clients;
         cb=2Ekill_by_cid =3D management_kill_by_=
cid;
         cb=2Eclient_auth =3D management_client_auth;
+        cb=2Ecl=
ient_acc_msg =3D management_client_acc_msg;
         cb=2Eclient_pending_au=
th =3D management_client_pending_auth;
         cb=2Eget_peer_info =3D mana=
gement_get_peer_info;
         cb=2Epush_update_broadcast =3D management_ca=
llback_send_push_update_broadcast;
diff --git a/src/openvpn/options=2Ec b/s=
rc/openvpn/options=2Ec
index 178b5f6=2E=2E27540e7 100644
--- a/src/openvpn/=
options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #include "sy=
shead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include "error=2E=
h"
 #include "common=2Eh"
@@ -7100,6 +7101,28 @@
         VERIFY_PERMISSION=
(OPT_P_GENERAL);
         options->force_key_material_export =3D true;
    =
 }
+    else if (streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {=

+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->acc_protocols=
 =3D p[1];
+    }
+    else if (streq(p[0], "custom-control") && p[1] && p[=
2] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC);
+
+     =
   if (!streq(p[2], "A:6") && !streq(p[2], "6:A"))
+        {
+            =
msg(msglevel, "App custom control encoding must be base64 and ascii");
+   =
         goto err;
+        }
+
+        if (!atoi_constrained(p[1], &optio=
ns->acc_max_message_length,
+                              "app custom mess=
age message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        =
{
+            goto err;
+        }
+        options->acc_negotiated_protoc=
ols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3])
  =
   {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG =
is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
=
index 131513e=2E=2Eef4f1fe 100644
--- a/src/openvpn/options=2Eh
+++ b/src/o=
penvpn/options=2Eh
@@ -711,6 +711,16 @@
     /* force using TLS key materia=
l export for data channel key generation */
     bool force_key_material_ex=
port;
 
+    /** The app custom control protocols we should announce as sup=
ported */
+    const char *acc_protocols;
+
+    /** the protocols that are=
 negotiated with the peer=2E As a client we
+     * trust the server pushed=
 list here */
+    const char *acc_negotiated_protocols;
+
+    /** the max=
imum length of an ACC control channel message */
+    int acc_max_message_l=
ength;
+
     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_acce=
pt;
     uint16_t vlan_pvid;
@@ -762,8 +772,10 @@
 #define OPT_P_INLINE    =
      (1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_R=
OUTE_TABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
-#d=
efine OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0=
x0ull))
+/* Options allowed in the normal configuration file (vs pushed opt=
ions or in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_P=
ULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((opt)-=
>pull)
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index fa7=
bf1e=2E=2E12068b5 100644
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
@@ -220,9 +222,8 @@
 #endif
 }
 
-
 void
-server_pushed_info(const=
 struct buffer *buffer, const int adv)
+server_pushed_info(struct context *=
c, const struct buffer *buffer, const int adv)
 {
     const char *m =3D ""=
;
     struct buffer buf =3D *buffer;
@@ -232,6 +233,27 @@
         m =3D B=
STR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+      =
  int max_acc_len =3D 0;
+
+
+        /* example string to parse: ACC:1400 =
A:6 flower:happy */
+        /* Skip over the ACC: prefix */
+        m +=
=3D 4;
+
+        char *protocols =3D parse_acc_parameters(m, " ", &max_acc=
_len, false, &c->options=2Egc);
+        if (protocols)
+        {
+       =
     c->options=2Eacc_negotiated_protocols =3D protocols;
+            c->o=
ptions=2Eacc_max_message_length =3D max_acc_len;
+        }
+        else
+=
        {
+            msg(D_PUSH_ERRORS, "WARNING: Received ACC info comma=
nd with invalid parameters");
+        }
+    }
+
 #ifdef ENABLE_MANAGEMENT=

     struct gc_arena gc;
     if (management)
@@ -284,6 +306,7 @@
     msg=
(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse=
 the keyword for the AUTH_PENDING request
  * @param buffer                =
buffer containing the keywords, the buffer's
@@ -440,7 +463,6 @@
     const=
 char *const peer_info =3D tls_multi->peer_info;
     unsigned int proto =
=3D extract_iv_proto(peer_info);
 
-
     /* Calculate the maximum timeout =
and subtract the time we already waited */
     unsigned int max_timeout =
=3D
         max_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->=
opt=2Ehandshake_window);
@@ -731,6 +753,11 @@
                 client_max_m=
tu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
     }
+
+    if (c->opti=
ons=2Eacc_negotiated_protocols)
+    {
+        push_option_fmt(gc, push_li=
st, M_USAGE, "custom-control %d A:6 %s", c->options=2Eacc_max_message_lengt=
h, c->options=2Eacc_negotiated_protocols);
+    }
 }
 
 #if defined(__GNUC_=
_) || defined(__clang__)
diff --git a/src/openvpn/push=2Eh b/src/openvpn/pu=
sh=2Eh
index dff945f=2E=2E3aca8a7 100644
--- a/src/openvpn/push=2Eh
+++ b/s=
rc/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_incoming_push_request(=
struct context *c);
 
+
 /**
  * @brief Handles the receiving of a push-upd=
ate message and applies updates to the specified
  * options=2E
@@ -92,7 +9=
3,7 @@
 
 void receive_exit_message(struct context *c);
 
-void server_push=
ed_info(const struct buffer *buffer, const int adv);
+void server_pushed_in=
fo(struct context *c, const struct buffer *buffer, const int adv);
 
 void =
receive_cr_response(struct context *c, const struct buffer *buffer);
 
diff=
 --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index fcc541=
1=2E=2E6462a97 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/pus=
h_util=2Ec
@@ -370,4 +370,4 @@
 
     RETURN_UPDATE_STATUS(n_sent);
 }
-#en=
dif /* ifdef ENABLE_MANAGEMENT */
+#endif /* ifdef ENABLE_MANAGEMENT */
\ N=
o newline at end of file
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec
index 5f5d1f9=2E=2Ea5663e3 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/=
openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include =
"ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_bac=
kend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -2054,6 +2055,11 @@
                  =
   }
                 }
             }
+
+            if (session->opt->acc=
_protocols)
+            {
+                buf_printf(&out, "IV_ACC=3D%d,6=
:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+            }
   =
      }
     }
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_=
common=2Eh
index db61198=2E=2E3b326a7 100644
--- a/src/openvpn/ssl_common=
=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -452,6 +452,9 @@
     size_t ekm_s=
ize;
 
     bool dco_enabled; /**< Whether keys have to be installed in DCO=
 or not */
+
+    /** The app custom control protocols we should announce a=
s supported */
+    const char *acc_protocols;
 };
 
 /** @addtogroup contr=
ol_processor
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/un=
it_tests/openvpn/Makefile=2Eam
index 5954902=2E=2E753e59d 100644
--- a/test=
s/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam
@@ -103,9 +103,11 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2E=
c \
+    test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_commo=
n=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_exec=
ve=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/=
argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/buffer=2Ec \
@@ -127,6 +129,7 @@
 	$(top_srcdir)/src/openvpn/run_comma=
nd=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/=
openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top=
_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_=
mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \
@@ -375,=
8 +378,10 @@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \
 	test_schedule=
=2Ec test_schedule=2Eh \
+	mock_management=2Ec mock_management=2Eh \
 	mock=
_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/ope=
nvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/=
src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
@=
@ -388,6 +393,7 @@
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir=
)/src/openvpn/siphash_reference=2Ec
 
+
 push_update_msg_testdriver_CFLAGS =
=3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_=
srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/openvpn/mo=
ck_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index 77f6=
ce2=2E=2Ecddd669 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
=
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 
 #in=
clude "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
 #ifd=
ef ENABLE_MANAGEMENT
@@ -60,4 +61,4 @@
 void
 management_sleep(const int n)=

 {
-}
+}
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn=
/mock_management=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh
new fil=
e mode 100644
index 0000000=2E=2Ee21aec43
--- /dev/null
+++ b/tests/unit_te=
sts/openvpn/mock_management=2Eh
@@ -0,0 +1,32 @@
+/*
+ *  OpenVPN -- An app=
lication to securely tunnel IP networks
+ *             over a single TCP/U=
DP port, with support for SSL/TLS-based
+ *             session authenticat=
ion and key exchange,
+ *             packet encryption, packet authenticat=
ion, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 =
OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arn=
e@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redist=
ribute it and/or modify
+ *  it under the terms of the GNU General Public L=
icense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+=
 *  This program is distributed in the hope that it will be useful,
+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Pub=
lic License for more details=2E
+ *
+ *  You should have received a copy of=
 the GNU General Public License along
+ *  with this program; if not, write=
 to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef MOCK_MANAGEMENT_H
+#defin=
e MOCK_MANAGEMENT_H
+void init_mock_management(void);
+
+void uninit_mock_m=
anagement(void);
+
+#endif
diff --git a/tests/unit_tests/openvpn/mock_push_=
dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
inde=
x 112bcfd=2E=2Ec16d0cb 100644
--- a/tests/unit_tests/openvpn/mock_push_depe=
ndencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -=
43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P=
_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SHA=
PER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT_=
P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-        =
             | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | O=
PT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUS=
H_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
    =
 return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/te=
sts/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=
=2E16b2b3b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,=
0 +1,298 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networ=
ks
+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *=
  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This pr=
ogram is free software; you can redistribute it and/or modify
+ *  it under=
 the terms of the GNU General Public License version 2
+ *  as published by=
 the Free Software Foundation=2E
+ *
+ *  This program is distributed in th=
e hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even =
the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+=
 *  You should have received a copy of the GNU General Public License along=

+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ *=
/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshe=
ad=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2E=
h>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+=
#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include "test_common=2Eh"
+
+=
#include "mock_msg=2Eh"
+
+char control_channel_mesage_sent[2048];
+
+/* Mo=
ck functions */
+bool
+send_control_channel_string_dowork(struct tls_sessio=
n *session,
+                                   const char *str, int msglev=
el)
+{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    memcpy(contro=
l_channel_mesage_sent, str, strlen(str));
+    return true;
+}
+
+void
+sen=
d_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_cl=
ient_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#define M=
SG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+    =
                "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
=
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwC=
P" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgA=
WABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAu=
BAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDA=
wEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4T=
z2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D"
+=

+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENABLE_MAN=
AGEMENT
+    skip();
+#else
+    /* ensure that the messages get to mock_ms=
g */
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678;
+   =
 struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientHell=
o */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    struct=
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
+        long_message[i] =3D (c=
har)(' ' + (i % 95));
+    }
+
+    /* last char of the message is a i and =
then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    assert_in=
t_equal(long_message[1024], '\0');
+
+    ret =3D send_acc_message(&c, c=2E=
c2=2Etls_multi, session, "emergency", true,
+                           lon=
g_message, false);
+
+    assert_true(ret);
+    size_t cc_len =3D strlen(c=
ontrol_channel_mesage_sent);
+    assert_int_equal(control_channel_mesage_s=
ent[cc_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC,emergenc=
y,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_chan=
nel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));
+
+    gc_f=
ree(&c=2Eoptions=2Egc);
+}
\ No newline at end of file
diff --git a/tests/u=
nit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
new =
file mode 100644
index 0000000=2E=2Ea64bab5
--- /dev/null
+++ b/tests/unit_=
tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks
+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based
+ *             session authentication a=
nd key exchange,
+ *             packet encryption, packet authentication, =
and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenV=
PN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc=
2549=2Eorg>
+ *
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
+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H=

+void test_acc_parse_client_messages(void **state);
+
+void test_parse_acc=
_parameters(void **state);
+
+void test_acc_common_protocols(void **state);=

+
+void test_acc_send_message(void **state);
+#endif
diff --git a/tests/un=
it_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh=

index 8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_tests/openvpn/test_comm=
on=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -43,11 +43,13 @@
 =
#define LargestIntegralType uintmax_t
 #endif
 /* redefine 2=2Ex API in ter=
ms of 1=2Ex API */
-#define CMockaValueData             LargestIntegralType=

-#define check_expected_uint         check_expected
-#define expect_uint_v=
alue           expect_value
-#define expect_check_data           expect_che=
ck
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValueData       =
                LargestIntegralType
+#define check_expected_uint           =
        check_expected
+#define expect_uint_value                     expec=
t_value
+#define expect_check_data                     expect_check
+#defin=
e cast_ptr_to_cmocka_value(x)           (x)
+#define assert_int_in_range(va=
lue, min, max)  assert_in_range((value), (min), (max))
+#define assert_uint=
_in_range(value, min, max) assert_in_range((value), (min), (max))
 #endif
 =

 /**
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_test=
s/openvpn/test_misc=2Ec
index a41c27b=2E=2E82292f1 100644
--- a/tests/unit_=
tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@=
 -40,11 +40,34 @@
 #include "list=2Eh"
 #include "mock_msg=2Eh"
 #include "=
crypto=2Eh"
+#include "test_schedule=2Eh"
+#include "multi=2Eh"
+
 #ifdef _=
WIN32
 #include "win32-util=2Eh"
 #endif
-#include "test_schedule=2Eh"
 
+/=
* extra mocks */
+bool
+apply_push_options(struct context *c, struct option=
s *options, struct buffer *buf,
+                   uint64_t permission_mas=
k, uint64_t *option_types_found,
+                   struct env_set *es, bo=
ol is_update)
+{
+    return true;
+}
+
+bool
+send_control_channel_string(=
struct context *c, const char *str, msglvl_t msglevel)
+{
+    check_expect=
ed_ptr(str);
+    return true;
+}
+
+struct multi_instance *
+lookup_by_cid=
(struct multi_context *m, const unsigned long cid)
+{
+    return *(m->inst=
ances);
+}
 
 static void
 test_compat_lzo_string(void **state)
diff --git =
a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec
index 887c492=2E=2Eaa639ff 100644
--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #inc=
lude "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_acc=2Eh"
+
=
 /* Mock function to be allowed to include win32=2Ec which is required for
=
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
    =
 return;
 }
+void
+reschedule_multi_process(struct context *c)
+{
+}
+
+/* =
Define a dummy dco cipher option to avoid linking against all the DCO
+ * u=
nits */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphers(v=
oid)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA=
20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req -x509 -newke=
y ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -960,8 +976,11 @@
=
         cmocka_unit_test(test_data_channel_known_vectors_epoch),
         =
cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
         cmoc=
ka_unit_test(crypto_test_print_cert_details),
-        cmocka_unit_test(ssl=
_test_extract_peer_info)
-
+        cmocka_unit_test(ssl_test_extract_peer_=
info),
+        cmocka_unit_test(test_acc_parse_client_messages),
+        =
cmocka_unit_test(test_parse_acc_parameters),
+        cmocka_unit_test(test=
_acc_common_protocols),
+        cmocka_unit_test(test_acc_send_message)
  =
   };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit=
-Change-Number: 1858
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--mwRsbhah9Hg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"http://g=
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
br>27 files changed, 1,350 insertions(+), 28 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
58/1858/6</pre><pre style=3D"font-family: monospace,monospace; white-space:=
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
ode 100644</span><br><span>index 0000000=2E=2Ea5d6641</span><br><span>--- /=
dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 =
+1,402 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
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
l(120, 100%, 40%);">+    int payload_len =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!buffer_read_int(&amp;buf, &amp;payload=
_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quo=
t;could not extract payload length field&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
comma after the length */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        err_reason =3D &quot;missing , after payload le=
n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message_flags(&amp=
;buf, &amp;err_reason, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (flags &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* We should have a final NUL byte in the control=
 message buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * and thus the length of the buffer should be payload_len + 1 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf) !=
=3D payload_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char =
*tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        snprintf(tmp, 512, &quot;field length %d, payload =
length %d mismatch&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 payload_len, buf_len(&amp;buf) - 1);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
log_acc_message(c, &amp;buf, payload_len, protocol, flags);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app control=
 channel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                   &quot;(%s) message control message: %s&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        format_hex(BPTR(&amp;b=
uf), BLEN(&amp;buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi *tl=
s_multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
      struct tls_session *session,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                 const char *protocol, bool fragment,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 const cha=
r *msg, bool base64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * length of the protocol =
string + one &#39;,&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * 2 for the encoding (A or 6), potential F (fragment), and 1 for =
the &#39;,&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * 4 for the message size itself and one comma</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * 1 for the comma before the message itsel=
f */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_=
t max_header_size =3D strlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 +=
 1 + 2 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
_t len =3D max_header_size + strlen(msg);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_CLIENT, &quot;message length (%zu) exceeds maximum po=
ssible message length (%d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if ((int)len &gt; c-&gt;options=2Eacc_max_message_length)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;header (=
%zu) + message size (%zu) length (%zu) exceeds &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      &quot;maximum allow=
ed length negotiated with peer (%d)&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            max_header_size, strlen(msg), len,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=
=2Eacc_max_message_length);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 add 1 for the final \0 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf_gc(len + 1, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Mis=
s Piggy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_p=
rintf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+               strlen(msg),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+               base64 ? &quot=
;6&quot; : &quot;A&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+               fragment ? &quot;F&quot; : &quot;&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+               msg);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    send_control_channel_string_dowork(session, BST=
R(&amp;buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    reschedule_multi_process(c);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *cap=
abilities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            const char *delim,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     int *max_acc_len,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                     bool server,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                     struct gc_=
arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D s=
tring_alloc(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    char *tmp_message_orig =3D tmp_message;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_message, del=
im, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protoco=
ls =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode =
we allow more capabilities than our own, in client</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * mode we reject if we should use capab=
ilities that we do not support */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LE=
N;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(=
token, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowe=
d_acc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&=
amp; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher=
_list(&quot;6&quot;, token)))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(D_PUSH_ERRORS, &quot;App custom control encoding must inclu=
de base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            goto done;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=
=3D 1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&am=
p; strcmp(token, &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(D_PUSH_ERRORS, &quot;App custom control encoding must =
exactly base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            goto done;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p=
 =3D=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            protoco=
ls =3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too =
many parameters for INFO ACC message/IV_ACC=2E&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct con=
text *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc_=
protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* No app custo=
m protocols have been configured server-side=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protocols)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* We already have determined the comm=
on protocols=2E Doing this</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * again would just add an extra string allocation to option=
s-&gt;gc */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower=
:power */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *peer_info =3D c-&gt;c2=2Etls_multi-&gt;peer_info;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char *iv_acc =3D extract_var_peer_i=
nfo(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *pro=
tocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max_acc_len, tr=
ue, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!protocols)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;=
WARNING: IV_ACC peer info variable of peer is malformed&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *token =3D strtok_r(protocols, &quot;:&quot;, &=
amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_pr=
otocols =3D alloc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    while (token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tl=
s_item_in_cipher_list(token, c-&gt;options=2Eacc_protocols))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* protocol is in both server an=
d client list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (buf_len(&amp;common_protocols) &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                buf_write_u8(&amp;common_protoc=
ols, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     buf_printf(&amp;common_protocols, &quot;%s&quot;, token);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&=
quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_proto=
cols) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
D_PUSH_DEBUG, &quot;WARNING: No common app custom control protocol=2E&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    c-&gt;options=2Eacc_negotiated_protocols =3D strin=
g_alloc(buf_str(&amp;common_protocols), &amp;c-&gt;options=2Egc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_max_m=
essage_length =3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><span>=
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><span>new =
file mode 100644</span><br><span>index 0000000=2E=2E5d9b203</span><br><span=
>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@=
 -0,0 +1,92 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An appl=
ication to securely tunnel IP networks</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             over a single TCP/UDP port, with support =
for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fre=
e software; you can redistribute it and/or modify</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pub=
lic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, write to the Free Software Foundation, =
Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_LEN 64</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN 1280</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * This method parses an app custom control message and d=
elivers it to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 management interface=2E We leave reassembly of fragmented messages to the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * management interf=
ace=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param c            The con=
text struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m buffer       Buffer containing the control message with ACC</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+receive_acc_message(struct context *c, const struct buffer *buff=
er);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+send_acc_message(struct context *c,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 struct tls_multi *tls_multi,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct tl=
s_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 const char *protocol, bool fragment,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const char *msg, bool ba=
se64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Parses an info message from the server that contains app custom =
control info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * info=
rmation prior to the PUSH_REPLY to be able to use app custom control</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocols before sendin=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * In client mode only allow what w=
e support ourselves=2E In server mode</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * allow also capabilities that we not support ourselves=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param capabilities      The s=
tring to parse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram delim             The delimiter to use when parsing the string=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                      =
    IV_ACC uses &quot;,&quot; as delimiter while the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                          custom-contro=
l PUSH message uses &quot; &quot; as &quot;,&quot; is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                          already used =
to separate different push directives</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param max_acc_len       Set to the maximum ACC messag=
e length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param s=
erver            Whether we are server or client</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param gc                The gc arena to us=
e for allocating the resulting string</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return                  The resulting protocol string=
 or NULL on error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char=
 *capabilities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 const char *delim,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     int *max_acc_len,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     bool server,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     struc=
t gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Parses the IV_ACC of the peer and s=
ets c-&gt;options=2Eacc_negotiated_protocols</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * to the common protocols of server and client an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c-&gt;options=
=2Eacc_max_message_length  to the maximum length of the ACC message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * support by both server a=
nd client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there is no common=
 protocol or the client does not support any app custom</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * protocol c-&gt;options=2Eacc_negotia=
ted_protocols will be set to NULL=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param c     the client context to use the set the app custom protocols=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct context *=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span=
><br><span>index 2ade321=2E=2E736e975 100644</span><br><span>--- a/src/open=
vpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><sp=
an>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</span><b=
r><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #include &quo=
t;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #include=
 &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -251,11 +252,1=
1 @@</span><br><span>     }</span><br><span>     else if (buf_string_match_=
head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(buf, 8);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        server_pushed=
_info(c, buf, 8);</span><br><span>     }</span><br><span>     else if (buf_=
string_match_head_str(buf, &quot;INFO&quot;))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(b=
uf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        serv=
er_pushed_info(c, buf, 4);</span><br><span>     }</span><br><span>     else=
 if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))</span><br><sp=
an>     {</span><br><span>@@ -265,6 +266,10 @@</span><br><span>     {</span=
><br><span>         receive_auth_pending(c, buf);</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (buf_strin=
g_match_head_str(buf, &quot;ACC&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        receive_acc_message(c, buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span>     else if (buf_string_match=
_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {</span><br><span>  =
       receive_exit_message(c);</span><br><span>diff --git a/src/openvpn/in=
it=2Ec b/src/openvpn/init=2Ec</span><br><span>index 6b53686=2E=2Ee8e3a6d 10=
0644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/o=
penvpn/init=2Ec</span><br><span>@@ -2283,6 +2283,10 @@</span><br><span>    =
         buf_printf(&amp;out, &quot; aead-epoch&quot;);</span><br><span>   =
      }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot; custom-contr=
ol %d,A:6,%s&quot;, c-&gt;options=2Eacc_max_message_length, c-&gt;options=
=2Eacc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span> </span><br><span>     if (BLENZ(&amp;out) =
&gt; strlen(header))</span><br><span>     {</span><br><span>@@ -2527,6 +253=
1,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     return flags;</span><br><span> =
}</span><br><span> </span><br><span>@@ -3342,6 +3351,7 @@</span><br><span> =
    to=2Everify_hash_depth =3D options-&gt;verify_hash_depth;</span><br><sp=
an>     to=2Everify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br=
><span>     memcpy(to=2Ex509_username_field, options-&gt;x509_username_fiel=
d, sizeof(to=2Ex509_username_field));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    to=2Eacc_protocols =3D options-&gt;acc_protocols;</sp=
an><br><span>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_=
ctx =3D &amp;c-&gt;net_ctx;</span><br><span> </span><br><span>@@ -4300,6 +4=
310,27 @@</span><br><span> }</span><br><span> #endif /* ifdef TARGET_ANDROI=
D */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manag=
ement_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                   struct buffer_list *input) /* ownership transferred=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct contex=
t *c =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buffer_list_de=
fined(input) &amp;&amp; c-&gt;c2=2Etls_multi)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_sessio=
n *session =3D &amp;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct options *opt =3D &amp;c-&gt;op=
tions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_=
acc_message(c, multi, session, opt-&gt;acc_negotiated_protocols, input);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buffer_list_free(input);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGE=
MENT */</span><br><span> </span><br><span> void</span><br><span>@@ -4316,6 =
+4347,7 @@</span><br><span>         cb=2Eproxy_cmd =3D management_callback_=
proxy_cmd;</span><br><span>         cb=2Eremote_cmd =3D management_callback=
_remote_cmd;</span><br><span>         cb=2Esend_cc_message =3D management_c=
allback_send_cc_message;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cb=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef T=
ARGET_ANDROID</span><br><span>         cb=2Enetwork_change =3D management_c=
allback_network_change;</span><br><span> #endif</span><br><span>diff --git =
a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 29f=
dffc=2E=2Eabf6f8b 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span=
><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -44,8 +44,10 @@<=
/span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &qu=
ot;push=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;<=
/span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&q=
uot;</span><br><span> </span><br><span> #ifdef ENABLE_PKCS11</span><br><spa=
n> #include &quot;pkcs11=2Eh&quot;</span><br><span>@@ -1080,6 +1082,35 @@</=
span><br><span>             }</span><br><span>             break;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e IEC_CLIENT_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (man-&gt;persist=2Ecallback=2Eclient_acc_msg)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                bool status =3D (*man-=
&gt;persist=2Ecallback=2Eclient_acc_msg)(man-&gt;persist=2Ecallback=2Earg,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                                  man-&gt;connection=2Ein_e=
xtra_cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                                            man-&gt;connect=
ion=2Ein_extra_kid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                                                      man-&=
gt;connection=2Ein_extra);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                man-&gt;connection=2Ein_extra =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                report_command_s=
tatus(status, &quot;client-acc-msg&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                man_command_unsupported(&quot;client-acc-msg&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        case IEC_ACC_MSG:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecall=
back=2Eacc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      bool status =3D (*man-&gt;persist=2Ecallback=2Eacc_msg)(man-&gt;persi=
st=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                                               man-&gt;con=
nection=2Ein_extra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                man-&gt;connection=2Ein_extra =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                report_command_status(=
status, &quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           man_command_unsupported(&quot;acc-msg&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            break;</span><br><span>         =
case IEC_PK_SIGN:</span><br><span>             man-&gt;connection=2Eext_key=
_state =3D EKS_READY;</span><br><span>             buffer_list_free(man-&gt=
;connection=2Eext_key_input);</span><br><span>@@ -1204,6 +1235,29 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+man_client_acc_msg(struct managemen=
t *man, const char *cid_str,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                   const char *kid_str)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt;connection;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cid =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in=
_extra_kid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (parse_cid(cid_str, &amp;mc-&gt;in_extra_cid)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        &amp;&amp; parse_uint(kid_str, &quot=
;KID&quot;, &amp;mc-&gt;in_extra_kid))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        mc-&gt;in_extra_cmd =3D IEC_CLIENT_ACC_MSG;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        in_extra_reset(mc, IER_NEW);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_a=
cc_msg(struct management *man)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct man_connection *mc =3D &amp;man-&gt;connection;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_extra_reset(m=
c, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span> man_client_auth=
(struct management *man, const char *cid_str, const char *kid_str, const bo=
ol extra)</span><br><span> {</span><br><span>     struct man_connection *mc=
 =3D &amp;man-&gt;connection;</span><br><span>@@ -1760,6 +1814,17 @@</span>=
<br><span>             man_client_pending_auth(man, p[1], p[2], p[3], p[4])=
;</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;client-acc=
-msg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(=
man, p, 2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            man=
_client_acc_msg(man, p[1], p[2]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else i=
f (streq(p[0], &quot;acc-msg&quot;))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        man_acc_msg(man);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;rsa-sig&quot=
;))</span><br><span>     {</span><br><span>         man_pk_sig(man, &quot;r=
sa-sig&quot;);</span><br><span>@@ -3131,6 +3196,7 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> void</span><br><span> management_connec=
tion_established(struct management *management, struct man_def_auth_context=
 *mdac,</span><br><span>                                   const struct env=
_set *es)</span><br><span>@@ -4362,6 +4428,62 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
anagement_send_acc_message(struct context *c, struct tls_multi *multi, stru=
ct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            const char *negotiated_protocols, struct b=
uffer_list *input)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* also ensures=
 that are enough inputs in the list to safely call</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * buffer_list_peek without extra NULL c=
hecks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!in=
put || input-&gt;size &lt; 3)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_CLIENT, &quot;not enough input lines for sending acc message, &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      &quot;missing protocol, flag and/or messages lines&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct buffer *proto_buf =3D buffer_list_peek(inpu=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
protocol =3D string_alloc(BSTR(proto_buf), &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct buffer *encoding_buf =3D buffer_lis=
t_peek(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
har *encoding =3D buf_str(encoding_buf);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *flag =3D NULL;</span><br><span style=3D"colo=
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
                              fragment, buf_str(acc_msg_buf),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                b=
64encoding);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #el=
se /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #includ=
e &quot;win32=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2Eh=
 b/src/openvpn/manage=2Eh</span><br><span>index f752fec=2E=2Ede9303b 100644=
</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/ope=
nvpn/manage=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>     =
int (*n_clients)(void *arg);</span><br><span>     bool (*send_cc_message)(v=
oid *arg, const char *message, const char *parameter);</span><br><span>    =
 bool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_m=
sg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     bool (*client_auth)(void *arg, const unsigned long cid, const unsign=
ed int mda_key_id,</span><br><span>                         const bool auth=
, const char *reason, const char *client_reason,</span><br><span>          =
               struct buffer_list *cc_config); /* ownership transferred */<=
/span><br><span>     bool (*client_pending_auth)(void *arg, const unsigned =
long cid, const unsigned int kid,</span><br><span>                         =
        const char *extra, unsigned int timeout);</span><br><span>     char=
 *(*get_peer_info)(void *arg, const unsigned long cid);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
      const unsigned long cid,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                           const unsigned int mda_key_id,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 struct buffer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    struct buffer_list *msg);</span><br><=
span>     bool (*proxy_cmd)(void *arg, const char **p);</span><br><span>   =
  bool (*remote_cmd)(void *arg, const char **p);</span><br><span> #ifdef TA=
RGET_ANDROID</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     str=
uct command_line *in;</span><br><span>     struct buffer_list *out;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC=
_UNDEF       0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 IEC_CLIENT_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define IEC_UNDEF          0</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT=
_PF   2 *REMOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD   =
    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CL=
IENT_ACC_MSG 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne IEC_ACC_MSG        8</span><br><span>     int in_extra_cmd;</span><br><s=
pan>     struct buffer_list *in_extra;</span><br><span>     unsigned long i=
n_extra_cid;</span><br><span>@@ -503,6 +512,14 @@</span><br><span> </span><=
br><span> void man_persist_client_stats(struct management *man, struct cont=
ext *c);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/** Parses the ACC message from the input buffer_list and send to th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * session identif=
ied by session and multi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_=
session;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_=
multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message(=
struct context *c, struct tls_multi *multi, struct tls_session *session,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
      const char *negotiated_protocols, struct buffer_list *input);</span><=
br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br>=
<span> /**</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec</span><br><span>index 8342d16=2E=2Eb444433 100644</span><br><spa=
n>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</=
span><br><span>@@ -52,6 +52,7 @@</span><br><span> #include &quot;ssl_util=
=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #=
include &quot;reflect_filter=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br=
><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><spa=
n>@@ -1773,6 +1774,13 @@</span><br><span>         o-&gt;imported_protocol_f=
lags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;acc_pro=
tocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* If ACC is enabl=
ed server side call to find common acc protocols,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * will be pushed during push message=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        determin=
e_common_acc_protocols(c);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     /* Select cipher if client supports Negotiable Crypto Parame=
ters */</span><br><span> </span><br><span>     /* if we have already create=
d our key, we cannot *change* our own</span><br><span>@@ -4032,6 +4040,24 @=
@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+calculate_app_control_extra(struc=
t context *c, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 determine_common_acc_protocols(c);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!c-&gt;options=2Eacc_negotiated_protocols)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_CLIENT, &quot;ACC: No negotiated protocols&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1024, gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d=
 A:6 %s&quot;, c-&gt;options=2Eacc_max_message_length, c-&gt;options=2Eacc_=
negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return buf_str(&amp;buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 bool</span><br><span> management_client_pending_auth(void *arg, const unsi=
gned long cid, const unsigned int mda_key_id,</span><br><span>             =
                   const char *extra, unsigned int timeout)</span><br><span=
>@@ -4042,17 +4068,30 @@</span><br><span>     if (mi)</span><br><span>     =
{</span><br><span>         struct tls_multi *multi =3D mi-&gt;context=2Ec2=
=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!strcmp(extra, &quot;ACC&quot;))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            extra =3D calculate_app_control_extra(&amp;mi-&gt;co=
ntext, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (!extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span>         struct tls_session *session=
 =3D lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span> </sp=
an><br><span>         if (!session)</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</s=
pan><br><span>             return false;</span><br><span>         }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* sends INFO_=
PRE and AUTH_PENDING messages to client */</span><br><span>         bool re=
t =3D send_auth_pending_messages(multi, session, extra, timeout);</span><br=
><span>         reschedule_multi_process(&amp;mi-&gt;context);</span><br><s=
pan>         multi_schedule_context_wakeup(m, mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>  =
       return ret;</span><br><span>     }</span><br><span>     return false=
;</span><br><span>@@ -4096,6 +4135,39 @@</span><br><span>     return ret;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
client_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                          const unsigned long cid,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                          const unsign=
ed int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                         struct buffer_list *input) /* ownership transferre=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D (=
struct multi_context *)arg;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct multi_instance *mi =3D lookup_by_cid(m, cid);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_list_defined(inp=
ut))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *mul=
ti =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct tls_session *session =3D lookup_session_=
by_mda_key_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (!session)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(M_CLIENT, &quot;client session not found&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            buffer_list_=
free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct options *opt =
=3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ret =3D management_send_acc_message(&amp;mi-&gt;context, multi, session=
, opt-&gt;acc_negotiated_protocols, input);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buffer_list_free(input);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> static char *</span><br><span> management_get_peer_info(void *arg, const=
 unsigned long cid)</span><br><span> {</span><br><span>@@ -4132,6 +4204,7 @=
@</span><br><span>         cb=2En_clients =3D management_callback_n_clients=
;</span><br><span>         cb=2Ekill_by_cid =3D management_kill_by_cid;</sp=
an><br><span>         cb=2Eclient_auth =3D management_client_auth;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =
=3D management_client_acc_msg;</span><br><span>         cb=2Eclient_pending=
_auth =3D management_client_pending_auth;</span><br><span>         cb=2Eget=
_peer_info =3D management_get_peer_info;</span><br><span>         cb=2Epush=
_update_broadcast =3D management_callback_send_push_update_broadcast;</span=
><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</=
span><br><span>index 178b5f6=2E=2E27540e7 100644</span><br><span>--- a/src/=
openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br=
><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #include &quot;=
syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quo=
t;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><b=
r><span> #include &quot;common=2Eh&quot;</span><br><span>@@ -7100,6 +7101,2=
8 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><=
span>         options-&gt;force_key_material_export =3D true;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else i=
f (streq(p[0], &quot;app-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  options-&gt;acc_protocols =3D p[1];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (streq(p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &a=
mp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(=
p[2], &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(msglevel, &quot;App custom control encoding must be base64 and as=
cii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1],=
 &amp;options-&gt;acc_max_message_length,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              &quot;app custom messag=
e message length&quot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;acc_negotiated_protocols=
 =3D p[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span>     else if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &a=
mp;&amp; !p[3])</span><br><span>     {</span><br><span>         msg(M_WARN,=
 &quot;NOTICE: --prng option ignored (SSL library PRNG is used)&quot;);</sp=
an><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh=
</span><br><span>index 131513e=2E=2Eef4f1fe 100644</span><br><span>--- a/sr=
c/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><=
br><span>@@ -711,6 +711,16 @@</span><br><span>     /* force using TLS key m=
aterial export for data channel key generation */</span><br><span>     bool=
 force_key_material_export;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /** The app custom control protocols we shoul=
d announce as supported */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *acc_protocols;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /** the protocols that are negotiated with the peer=2E As a client we</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * trust the serve=
r pushed list here */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *acc_negotiated_protocols;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /** the maximum length of an ACC control channel message */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int acc_max_message_le=
ngth;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     bool vlan_tagging;</span><br><span>     enum vlan_acceptable_frames=
 vlan_accept;</span><br><span>     uint16_t vlan_pvid;</span><br><span>@@ -=
762,8 +772,10 @@</span><br><span> #define OPT_P_INLINE          (1u &lt;&lt=
; 29)</span><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span=
><br><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ACC             (1ull =
&lt;&lt; 32)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_=
PEER_ID | 0x0ull))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Options allowed in the normal configuration file (vs pushed options or in=
 ccd files) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_=
P_ACC))</span><br><span> </span><br><span> #define PULL_DEFINED(opt) ((opt)=
-&gt;pull)</span><br><span> </span><br><span>diff --git a/src/openvpn/push=
=2Ec b/src/openvpn/push=2Ec</span><br><span>index fa7bf1e=2E=2E12068b5 1006=
44</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/ope=
nvpn/push=2Ec</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #include &=
quot;syshead=2Eh&quot;</span><br><span> </span><br><span> #include &quot;pu=
sh=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quo=
t;</span><br><span> #include &quot;options=2Eh&quot;</span><br><span> #incl=
ude &quot;crypto=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</s=
pan><br><span>@@ -220,9 +222,8 @@</span><br><span> #endif</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
erver_pushed_info(const struct buffer *buffer, const int adv)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+server_pushed_info(struct context=
 *c, const struct buffer *buffer, const int adv)</span><br><span> {</span><=
br><span>     const char *m =3D &quot;&quot;;</span><br><span>     struct b=
uffer buf =3D *buffer;</span><br><span>@@ -232,6 +233,27 @@</span><br><span=
>         m =3D BSTR(&amp;buf);</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &qu=
ot;ACC:&quot;, 4) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  int max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* example string to pars=
e: ACC:1400 A:6 flower:happy */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* Skip over the ACC: prefix */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        m +=3D 4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        char *protocols =3D parse_acc_parameters(m, &quot; &=
quot;, &amp;max_acc_len, false, &amp;c-&gt;options=2Egc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Eacc_negotiated_p=
rotocols =3D protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            c-&gt;options=2Eacc_max_message_length =3D max_acc_len;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;WARNING: Rece=
ived ACC info command with invalid parameters&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     s=
truct gc_arena gc;</span><br><span>     if (management)</span><br><span>@@ =
-284,6 +306,7 @@</span><br><span>     msg(D_PUSH, &quot;CR response was sen=
t by client (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
*</span><br><span>  * Parse the keyword for the AUTH_PENDING request</span>=
<br><span>  * @param buffer                buffer containing the keywords, =
the buffer&#39;s</span><br><span>@@ -440,7 +463,6 @@</span><br><span>     c=
onst char *const peer_info =3D tls_multi-&gt;peer_info;</span><br><span>   =
  unsigned int proto =3D extract_iv_proto(peer_info);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* =
Calculate the maximum timeout and subtract the time we already waited */</s=
pan><br><span>     unsigned int max_timeout =3D</span><br><span>         ma=
x_uint(tls_multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehan=
dshake_window);</span><br><span>@@ -731,6 +753,11 @@</span><br><span>      =
           client_max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (c-&gt;options=2Eacc_negotiated_protocols)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;c=
ustom-control %d A:6 %s&quot;, c-&gt;options=2Eacc_max_message_length, c-&g=
t;options=2Eacc_negotiated_protocols);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><sp=
an> #if defined(__GNUC__) || defined(__clang__)</span><br><span>diff --git =
a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span>index dff945f=
=2E=2E3aca8a7 100644</span><br><span>--- a/src/openvpn/push=2Eh</span><br><=
span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</span><br=
><span> </span><br><span> int process_incoming_push_request(struct context =
*c);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /**</span><br><span>  * @brief Handles the receiving o=
f a push-update message and applies updates to the specified</span><br><spa=
n>  * options=2E</span><br><span>@@ -92,7 +93,7 @@</span><br><span> </span>=
<br><span> void receive_exit_message(struct context *c);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void server_pushed_inf=
o(const struct buffer *buffer, const int adv);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void server_pushed_info(struct context *c, const=
 struct buffer *buffer, const int adv);</span><br><span> </span><br><span> =
void receive_cr_response(struct context *c, const struct buffer *buffer);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/push_util=2Ec b/s=
rc/openvpn/push_util=2Ec</span><br><span>index fcc5411=2E=2E6462a97 100644<=
/span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/o=
penvpn/push_util=2Ec</span><br><span>@@ -370,4 +370,4 @@</span><br><span> <=
/span><br><span>     RETURN_UPDATE_STATUS(n_sent);</span><br><span> }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_MANA=
GEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
ifdef ENABLE_MANAGEMENT */</span><br><span>\ No newline at end of file</spa=
n><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><b=
r><span>index 5f5d1f9=2E=2Ea5663e3 100644</span><br><span>--- a/src/openvpn=
/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6=
 +55,7 @@</span><br><span> </span><br><span> #include &quot;crypto_epoch=2E=
h&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><s=
pan> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;ss=
l_backend=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span=
><br><span>@@ -2054,6 +2055,11 @@</span><br><span>                     }</s=
pan><br><span>                 }</span><br><span>             }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (session-&gt;opt-&gt;acc_protocols)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_print=
f(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;=
opt-&gt;acc_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/op=
envpn/ssl_common=2Eh</span><br><span>index db61198=2E=2E3b326a7 100644</spa=
n><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/open=
vpn/ssl_common=2Eh</span><br><span>@@ -452,6 +452,9 @@</span><br><span>    =
 size_t ekm_size;</span><br><span> </span><br><span>     bool dco_enabled; =
/**&lt; Whether keys have to be installed in DCO or not */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /** The app custom control protocols we should anno=
unce as supported */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *acc_protocols;</span><br><span> };</span><br><span> </span=
><br><span> /** @addtogroup control_processor</span><br><span>diff --git a/=
tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 5954902=2E=2E753e59d 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -103,9 +103,11 @@</span><br>=
<span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDF=
LAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D =
test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
est_acc=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test=
_common=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><span> 	moc=
k_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffe=
r=2Ec \</span><br><span>@@ -127,6 +129,7 @@</span><br><span> 	$(top_srcdir)=
/src/openvpn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
ssl_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=
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
op_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span>@@ -388,6 +393,7 @@</=
span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> push_update=
_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	=
-I$(top_srcdir)/src/compat \</span><br><span> 	-I$(top_srcdir)/tests/unit_t=
ests/openvpn \</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_m=
anagement=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><spa=
n>index 77f6ce2=2E=2Ecddd669 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/=
mock_management=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><span> </sp=
an><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</s=
pan><br><span> #include &quot;manage=2Eh&quot;</span><br><span> </span><br>=
<span> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -60,4 +61,4 @@</span><br=
><span> void</span><br><span> management_sleep(const int n)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at en=
d of file</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_manage=
ment=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh</span><br><span>new=
 file mode 100644</span><br><span>index 0000000=2E=2Ee21aec43</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/mock_manage=
ment=2Eh</span><br><span>@@ -0,0 +1,32 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@ope=
nvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  C=
opyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is free software; you can redistribute it and/or modif=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the t=
erms of the GNU General Public License version 2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundati=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed=
 in the hope that it will be useful,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mor=
e details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef MOCK_MANAGEMENT_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MOCK_MANAGEMENT_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void init_mock_management(void);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void uninit_mock_management(void);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_=
push_dependencies=2Ec</span><br><span>index 112bcfd=2E=2Ec16d0cb 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span=
><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t flags =3D OPT_P_=
UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span> =
                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_CO=
MP | OPT_P_PERSIST</span><br><span>                      | OPT_P_MESSAGES |=
 OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_PEER_ID | OPT_=
P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_ID | OP=
T_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_ACC;</span>=
<br><span>     return flags;</span><br><span> }</span><br><span> </span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_test=
s/openvpn/test_acc=2Ec</span><br><span>new file mode 100644</span><br><span=
>index 0000000=2E=2E16b2b3b</span><br><span>--- /dev/null</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,298 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to se=
curely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             over a single TCP/UDP port, with support for SSL/TLS-b=
ased</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
session authentication and key exchange,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet encryption, packet authenticatio=
n, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright=
 (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; y=
ou can redistribute it and/or modify</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  it under the terms of the GNU General Public License v=
ersion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publ=
ished by the Free Software Foundation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is distributed in the hope that it will be useful,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 GNU General Public License for more details=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  You should have received a copy of the GNU General Public Li=
cense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with=
 this program; if not, write to the Free Software Foundation, Inc=2E,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CO=
NFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;str=
ing=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;test_acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+char control_channel_mesage_sent[2048];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Mock functions */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_con=
trol_channel_string_dowork(struct tls_session *session,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                   cons=
t char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_in_range(strlen(str), 0, 2048);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 memcpy(control_channel_mesage_sent, str, strlen(str));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_reply_au=
th_token(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+auth_set_client_reason(struct tls_multi *multi, const ch=
ar *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3t=
BM&quot;                \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notF=
T0cF1d60nTS&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKA=
BrwCP&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&=
quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;93rQ=
wityP9eKSijXgcQ=3D=3D&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_parse_client_mess=
ages(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANA=
GEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    skip();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that the messages get=
 to mock_msg */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
x_debug_level =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    management =3D (void *)0x12345678;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* contains a TLS 1=2E3 ClientHello */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC=
,cck1,384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer msg_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct context c =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;s=
ession[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session=
[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf,=
 (void *)msg, sizeof(msg));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom=
 app control message (protocol &#39;cck1&#39;)&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_b=
uf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char flower_msg[] =3D &quot;ACC,flower,48,6,SSB=
hbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *=
)flower_msg, sizeof(flower_msg));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_b=
uf, &quot;Received custom app control message (protocol &#39;flower&#39;)&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIE=
tlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char msg_incorrect_len[] =3D &quot;ACC,for=
tune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=
=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_s=
et_read(&amp;msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_me=
ssage(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *error =3D &quot;WARNING: Received malformed custom=
 app control channel &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        &quot;(field length 62, payload length 64 m=
ismatch) message &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        &quot;control message: 496e7367 496d316c 496a6f=
67 496d5a79 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       &quot;62326369 4c434141 65475a6d 2f534a7[more=2E=2E=
=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(moc=
k_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char msg_fragment[] =3D &quot;ACC,p=
ower,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_fragment, sizeof(=
msg_fragment));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received=
 custom app control message (protocol &#39;power&#39;, fragment)&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check two encodi=
ng present */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char flower_msg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pd=
CD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_tw=
o_encs, sizeof(flower_msg_two_encs));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Received malformed c=
ustom app control channel (number of &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;encodings must be exactly one (B6=
4=3D1, ASCII=3D1)) message control &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;message: 53534268 62534141 4945746c=
 636d3170 6443442f 2f534230 &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* no encoding present */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg_no_encs[] =3D &=
quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_rea=
d(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_messag=
e(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D =
&quot;WARNING: Received malformed custom app control channel (number of &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;encodings must be exactly one (B64=3D0, ASCII=3D0)) message control &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;=
message: 53534268 62534141 4945746c 636d3170 6443442f 2f534230 &quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;6147556=
7 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managmen=
t_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    manageme=
nt =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_parse_acc_parameters(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* parameters to INFO message */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &=
quot;4096 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt max_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot=
;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(max_len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a client does n=
ot accept a length longer than it supports */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_m=
sg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* message with lower limit than our, should work fo=
r client and server */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_paramete=
rs(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocol=
s, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;,=
 &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(m=
ax_len, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* more encodings th=
an supported=2E Server should be okay, client should fail */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:=
6:B flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &am=
p;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_l=
en, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 120=
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;14=
00 A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot=
;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;=
max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_c=
apabilities =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters=
(iv_acc_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(prot=
ocols, &quot;flower:happy:power&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* too small protocol length */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_=
acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(proto=
cols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol le=
ngth */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc=
_msg =3D &quot;abff A:6 flower:happy 77&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_=
msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* non-numerical protocol length */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 =
flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp=
;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_acc_common_protocols(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct context c =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc =3D gc_new();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, st=
ruct tls_multi, &amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    c=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1=
400,A:6,flower:happy:power&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    c=2Eoptions=2Eacc_protocols =3D &quot;power:flower:star&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocol=
s(&amp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(c=2Eopt=
ions=2Eacc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(c=2Eoptions=2Eacc_nego=
tiated_protocols, &quot;flower:power&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;c=2Eoptions=2Egc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_acc_send_message(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Egc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=
=2Ec2=2Etls_multi, struct tls_multi, &amp;c=2Eoptions=2Egc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4=
321\nIV_ACC=3D1400,A:6,flower:emergency:power&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Eacc_protocols =3D &quot=
;power:flower:emergency&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    determine_common_acc_protocols(&amp;c);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct tls_session *session =3D &amp;c=2Ec2=2Etls_multi-&gt;session[TM_ACT=
IVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(&amp=
;c, c=2Ec2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                           &quot;=
EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, false);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(control_channel_mesage=
_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS =
NOT A DRILL:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_a=
cc_message(&amp;c, c=2Ec2=2Etls_multi, session, &quot;emergency&quot;, fals=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
          &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR=
 AREA=2E&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(control_channel_mesage_sent,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        &quot;ACC,em=
ergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AR=
EA=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* test a long message (&gt; 1000) with =
fragment to get the maximum header size */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char long_message[1200] =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        long_message[i] =3D (char)(&#39; &#39;=
 + (i % 95));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* last char of the message is a i =
and then a \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(long_message[1023], &#39;i&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1024], =
&#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_mes=
sage(&amp;c, c=2Ec2=2Etls_multi, session, &quot;emergency&quot;, true,</spa=
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
%, 40%);">+    gc_free(&amp;c=2Eoptions=2Egc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/un=
it_tests/openvpn/test_acc=2Eh</span><br><span>new file mode 100644</span><b=
r><span>index 0000000=2E=2Ea64bab5</span><br><span>--- /dev/null</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +=
1,35 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application=
 to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      session authentication and key exchange,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet encryption, packet authent=
ication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        packet compression=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softw=
are; you can redistribute it and/or modify</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lic=
ense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  a=
s published by the Free Software Foundation=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is distributed in the hope that it will be usefu=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define T=
EST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_=
acc_parse_client_messages(void **state);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void test_parse_acc_parameters(void **state);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void test_acc_common_protocols(void **state);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void test_acc_send_message(void **state);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_com=
mon=2Eh</span><br><span>index 8db4ea6=2E=2Ec865142 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_common=2Eh</span><br><span>@@ -43,11 +43,13 @@</span=
><br><span> #define LargestIntegralType uintmax_t</span><br><span> #endif</=
span><br><span> /* redefine 2=2Ex API in terms of 1=2Ex API */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define CMockaValueData           =
  LargestIntegralType</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define check_expected_uint         check_expected</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define expect_uint_value           expect_val=
ue</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define expect_chec=
k_data           expect_check</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define cast_ptr_to_cmocka_value(x) (x)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define CMockaValueData                       L=
argestIntegralType</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define check_expected_uint                   check_expected</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define expect_uint_value          =
           expect_value</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define expect_check_data                     expect_check</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define cast_ptr_to_cmocka_value=
(x)           (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine assert_int_in_range(value, min, max)  assert_in_range((value), (min),=
 (max))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define asse=
rt_uint_in_range(value, min, max) assert_in_range((value), (min), (max))</s=
pan><br><span> #endif</span><br><span> </span><br><span> /**</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec</span><br><span>index a41c27b=2E=2E82292f1 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -40,11 +40,34 =
@@</span><br><span> #include &quot;list=2Eh&quot;</span><br><span> #include=
 &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_=
schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span> #include &quot;w=
in32-util=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &quot;test_schedule=2Eh&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* extra mocks *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct context=
 *c, struct options *options, struct buffer *buf,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                   uint64_t permission_mask, =
uint64_t *option_types_found,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                   struct env_set *es, bool is_update)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(=
struct context *c, const char *str, msglvl_t msglevel)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    check_expected_ptr(str);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_i=
nstance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lookup_by_=
cid(struct multi_context *m, const unsigned long cid)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return *(m-&gt;instances);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> static void=
</span><br><span> test_compat_lzo_string(void **state)</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/t=
est_ssl=2Ec</span><br><span>index 887c492=2E=2Eaa639ff 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</span><br=
><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot=
;openvpn=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock function to be all=
owed to include win32=2Ec which is required for</span><br><span>  * getting=
 the temp directory */</span><br><span> #ifdef _WIN32</span><br><span>@@ -8=
6,6 +88,20 @@</span><br><span> {</span><br><span>     return;</span><br><sp=
an> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_process(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define a dummy dco cipher option to avoid linking against=
 all the DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * unit=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENA=
BLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_=
ciphers(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES-192=
-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* ge=
nerated using</span><br><span>  * openssl req -x509 -newkey ec -pkeyopt ec_=
paramgen_curve:secp384r1 -keyout - \</span><br><span>@@ -960,8 +976,11 @@</=
span><br><span>         cmocka_unit_test(test_data_channel_known_vectors_ep=
och),</span><br><span>         cmocka_unit_test(test_data_channel_known_vec=
tors_shortpktid),</span><br><span>         cmocka_unit_test(crypto_test_pri=
nt_cert_details),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    cmocka_unit_test(ssl_test_extract_peer_info)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(ssl_test_extract_peer_info),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc=
_parse_client_messages),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_parse_acc_parameters),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_com=
mon_protocols),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_acc_send_message)</span><br><span>     };</span><=
br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b=
2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--mwRsbhah9Hg=--


--===============5456509866113187968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5456509866113187968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5456509866113187968==--

