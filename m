Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D232606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bMnc4dkh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gw1M/568;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BCg2BLC3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cgGIHckO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o28kXIJoXjcftI+DdGz0VQ3j/gzICVGhBrRl3KyBwJM=; b=bMnc4dkhm/gBPEXAZT4y4eKxaq
	AqjphTQWf8PbBci5pGfjs6h2wDAaroL7waf4qeaTmQiool7PX5NP1tYz72JifCEUprGucosvC6azZ
	YWuDyk6gXJj8RIJTIqlVmzMUnNDWwzZAKeV1MKo69EOZ5PHliczZlRLeO3KiImYTeVmI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLQau-000000007JQ-2yXv;
	Mon, 26 Oct 2026 19:42:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLQat-000000007JD-2uOP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TD5aD2uGjTdYPcFUzmfzNfz9JZFLI3x+F/ITi6MJuE=; b=Gw1M/568K+xxYUs3KJ+tMmuHDL
 YGQKhUXznueao6Ixe8/JnRAVmKoSLZUO2Qo3tUspCs/5mzcvjYUKi0OcEoPf8zmu591YTFyGvgfe8
 9ggdkyWXVmNP1LGYUxRfBdqSNHy7WeUESPRtQd+OhFthY79t4ihm63GQOnp/RZ05sgdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TD5aD2uGjTdYPcFUzmfzNfz9JZFLI3x+F/ITi6MJuE=; b=BCg2BLC3XNg3PhKXqH/txRHmUR
 E0QUR5SMCcfqiHBNxN4g+wE9EH5reHd3fIDfKh+QsUaBQWYesHvF5tq2VFW8LAPqVILW+zV2Wpi7g
 HI1xkfipgx+uDWdp+VvsE5fn/1Js2BoPrTVoymxTrswEZeULzXPKu2W96EWWEwSpBfn0=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLQaj-000000003XK-0wgq for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:55 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso22456155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793043759; x=1793648559; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4TD5aD2uGjTdYPcFUzmfzNfz9JZFLI3x+F/ITi6MJuE=;
 b=cgGIHckOs8rY665kB+MYt4ENdq/0WMCoFgQaPkXBjww0A8+gH3Wj4Of3HpnN0wQ0hL
 zYAAAKLPZNcKI35cm3e11DYzInXzE4T/CYYhz38EYaA5NiSoEZ5+8Cwpmew7x1RGa4AU
 HwcYF3cPMZEvFEFgfQwZ2nvZZqBYV0A2chv6okdtPCMb9pJSRBLhIX+Q4il0p63r7Qkg
 tyV0uXOljOaqtNIXzqMWbqVPFS1fCnopl0vF+LsMT6xWWiuvsx3o/x7e5eeJ8c9AF1mr
 iLxk8d+9oFEe5xJ75qVOkZSDkmIix+wiS9KY6vp+yd385MJ7ypn6+m8bSp1xfnHKHm79
 vUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793043759; x=1793648559;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4TD5aD2uGjTdYPcFUzmfzNfz9JZFLI3x+F/ITi6MJuE=;
 b=ETj6MSIZwjCmye0vI3bQ1hEin/qj4zONlg6VMmh5s5KMPYiYABVeBqUZkSkAVhddki
 hkreihFdnfzKF0RWyArSF2RklrXd9b7Iw5WofDKvEiIfiRt7FQLOeXi5pxbtx39pQcfB
 bxhDH0dJQV+qbVL7bV/0gwNkkTEgdgOWuSS1ZbxeUaIRo142UgNl5OIaqbpC+A+N6yDY
 9eMTNnQSkucRfzg8XxKIH3yIS77sqG091NQzjgbzI/JklXPj/WgW3EQMaBZ/1fXHGxRQ
 fGNAcXdFcpvQR36vk6NpcpaGjKKasy/9cVu3ydMJ9E/c1wpciyKgHyxDxxffh3O/TKzV
 ZEag==
X-Gm-Message-State: AFq9FYJJIX4U7/IGXBeiLytyrUnVaOkvFX0tp/zMA+A4S0S9+0tWwY+S
 OQGHbeG1CIwfyplpll8GbsPLsqYbU7ZefU/OSc8M7FA+mCsb/M2OLifyOaZSv4QPWd1b0+dIWcy
 dyTduQSjFmY6exLKVE8N+TdvfNoRGr3hbJt0g38qx7+gwk7BjsLxGmePndqFqvnDHfn4o
X-Gm-Gg: AYBFou1XHfA83KmuQ6VoalA4rCjKRBVVnO4fJ+il6dOekBYxED38U6YliWaO8hSQVUw
 3KGhiNWPC+KP/Su3BKqLuC/e1kRnOuDnAfkYVuXomCfWaJ4YDKXb8C+JbTKVnm81Y2Lk0MLFQHI
 ojQhJAOAaJbTN5DeixQkwz2rjixJT8Z9agtF38XGqGU8z0UIMEUFUKS4hXLYK4W2t2aoPkKWL5T
 MH1gHrfR1dVerBMZwmz70cnEcE4IatjAI0lDXqzOML98s3DmvmYvdjNz5bEf+lKjtA120hKztF/
 xjF1fkdY0IdlXULmvXce9rKI7RoqSmfrpK9tKIyb2oYrCBC/JhP6gw+OtjFBUdgphy3LeaVMDHz
 4oH6kGwUZqBpZVsYBq1O4azfylbOZ/ZLE150B1Ra/7lsG7KEb3f179Ivom+XaySPZs41eNuRpFU
 mSs3qs1ZaVrYm9uzm7dvx7L+3St5Wt6jlcmYR3Kk+nkrCqj2G0q1GTyiF03Ucx88qmGZdVq7fpN
 roee01c84aQI14Rhsk1pwx+11qBOvCBiqXYVPdGHm08mrSLBXd19rsMsAfEGmvTfTas8hYTq9u2
 UZcmD8ITMLFS1xwEVO3u/18oJ9qInHA6eMBjCAy30l8IET8Njeg+0CKwqcLVrqJW+4ZmOOZLUEa
 Y/sOEzl2G8OYbArsJJtXgApwjZxD3BzDAaF3XK4hBbw==
X-Received: by 2002:a05:600c:8b66:b0:4a2:a8c:22b0 with SMTP id
 5b1f17b1804b1-4a35ac3b3d9mr139533345e9.1.1793043757459; 
 Mon, 26 Oct 2026 12:42:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm18186845f8f.34.2026.10.26.12.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:42:36 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 19:42:27 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 1a0beff41115a8b57eff4c8aa856392cf8f5de70
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2ab77538e6b813e6d30e73c3f8c0fd2424f3841d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLQaj-000000003XK-0wgq
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 chugly <charlie.vigue@openvpn.com>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5302652622735125553=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5302652622735125553==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yvdq/g6kkM8="; charset=UTF-8

--yvdq/g6kkM8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail

to look at the new patch set (#13)=2E
=


Change subject: Implement sending/receiving app custom control protocol m=
essages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Impl=
ement sending/receiving app custom control protocol messages

This allows o=
penvpn GUI/front-ends and server via management
to use the OpenVPN control =
channel to pass messages between each other
while OpenVPN handles the marsh=
alling/unmarshalling of these and
negotiate the common app custom control p=
rotocols=2E

This provides an easy to use secure channel that does not depe=
nd on
the network itself to work and can also used before fully authenticat=
ing
the client=2E See the management-notes=2Etxt for more details how to us=
e
this feature=2E An upcoming patch will also add some example python
scrip=
t that showcase this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de=
86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeList=
s=2Etxt
M doc/man-sections/client-options=2Erst
M doc/man-sections/manageme=
nt-options=2Erst
M doc/man-sections/script-options=2Erst
M doc/management-n=
otes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/=
acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/mana=
ge=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/optio=
ns=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=
=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_tests/=
openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
A test=
s/unit_tests/openvpn/mock_management=2Eh
M tests/unit_tests/openvpn/mock_pu=
sh_dependencies=2Ec
A tests/unit_tests/openvpn/test_acc=2Ec
A tests/unit_te=
sts/openvpn/test_acc=2Eh
M tests/unit_tests/openvpn/test_common=2Eh
M tests=
/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
2=
8 files changed, 1,515 insertions(+), 26 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/13

diff --git a/CM=
akeLists=2Etxt b/CMakeLists=2Etxt
index 184a95a=2E=2E00caa2d 100644
--- a/C=
MakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,6 +435,8 @@
     src/compat/=
compat-strlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat=
-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/op=
envpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -57=
1,8 +573,8 @@
     src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/open=
vpn/push=2Ec
-    src/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
+    =
src/openvpn/push_util=2Ec
     src/openvpn/pushlist=2Eh
     src/openvpn/re=
flect_filter=2Ec
     src/openvpn/reflect_filter=2Eh
@@ -826,7 +828,10 @@
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
@@ -840,8 +845,11 @@
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
@@ -858,6 +866,8 @@
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
index 87c138a=2E=2Eb204d6a 100644
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
ion and the OpenVPN RFC
+  draft for a description of app custom control pr=
otocol support=2E
+
 --auth-token token
   This is not an option to be used=
 directly in any configuration files,
   but rather push this option from a=
 ``--client-connect`` script or a
@@ -437,6 +448,12 @@
         Additional =
authentication methods supported by the client=2E
         This may be set =
by the client UI/GUI using ``--setenv``=2E
 
+  :code:`IV_ACC=3D<max_msg_le=
n>,<flags>,<protocols>`
+        If the option ``--app-custom-control`` is =
set, the client will
+        send the supported max ACC message length, th=
e supported formats
+        as (:code:`A:6`) and the list of configured pr=
otocols (e=2Eg=2E
+        :code:`flower:happy:power`)
+
   The following f=
lags depend on which compression formats are compiled in
   and whether com=
pression is allowed by options=2E See `Protocol options`_
   for more detai=
ls=2E
diff --git a/doc/man-sections/management-options=2Erst b/doc/man-sect=
ions/management-options=2Erst
index e2e0773=2E=2E9840eb7 100644
--- a/doc/m=
an-sections/management-options=2Erst
+++ b/doc/man-sections/management-opti=
ons=2Erst
@@ -144,3 +144,9 @@
 
 --management-up-down
   Report tunnel up/d=
own events to management interface=2E
+
+--app-custom-control protocol-list=

+  Sets the app custom control protocols that are supported and should be
=
+  negotiated=2E protocol-list is a list of allowed protocols separated by =
:
+  A client will announced these protocols via the IV_ACC variable and th=
e
+  server will notify the client about the common protocols=2E
diff --git=
 a/doc/man-sections/script-options=2Erst b/doc/man-sections/script-options=
=2Erst
index f420380f=2E=2E9c17c3b 100644
--- a/doc/man-sections/script-opt=
ions=2Erst
+++ b/doc/man-sections/script-options=2Erst
@@ -1006,3 +1006,12 =
@@
        X509_1_L=3DBISHKEK
        X509_1_ST=3DNA
        X509_1_C=3DKG
=
+
+:code:`acc_protocols`
+    If ``--app-custom-control`` is configured and=
 the client supports any of the
+    protocols that server also supports, t=
his variable contains a list of
+    common protocols separated by :=2E
+
+=
:code:`acc_message_len`
+    if :code:`acc_protocols` is set, this variable=
 contains the maximum
+    message length for app custom protocol message=
=2E
\ No newline at end of file
diff --git a/doc/management-notes=2Etxt b/d=
oc/management-notes=2Etxt
index 4d726c4=2E=2E383fe10 100644
--- a/doc/manag=
ement-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -828,6 +828,59 @@
 th=
at is required to continue the connection (unlike MFA or opening a browser)=

 this message is not negotiated but can just be sent as a gratuitous messa=
ge=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+If the special string "ACC" is passed as {EXTRA} OpenVPN will de=
termine
+the common app custom protocols between the client and the server =
and instruct
+the client that the server will send control messages to the =
client using
+the ACC protocol=2E
+
+The server should then use acc-msg com=
mand to send app custom control messages
+to the client to facilitate the p=
ending authentication=2E
+
+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or hig=
her)
+------------------------------------------
+
+On an OpenVPN instance =
running in server mode this command sends an
+app custom control message to=
 a client=2E The format of the command is:
+
+  client-acc-msg {CID} {KID}
=
+  {protocol}
+  {flags}
+  {message}
+  END
+
+CID,KID -- client ID and Ke=
y ID=2E See documentation for ">CLIENT:"
+notification for more info=2E
+
+=
protocol -- the ACC protocol identifier that this message should be
+      =
      tagged with=2E
+
+flags    -- a colon separated list of the encoding =
and the flag if
+            the message is a fragment=2E E=2Eg=2E "6:F" fo=
r a base64 encoded
+            message that is also a fragment and not com=
plete yet=2E
+
+message  -- The message encoded in the encoding specified i=
n flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)
+----------------=
--------------------------
+
+When OpenVPN is running in --client mode this=
 command sends an app
+custom command to the server=2E The format of the co=
mmand is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {message}
+  END
+
+See t=
he client-acc-msg command for more details about the format of the
+message=
=2E Since a client has only one peer there is no need to specify the
+clien=
t id and key id=2E
+
+>>>>>>> fd23ffa35a (Implement sending/receiving app c=
ustom control protocol messages)
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 =
or higher)
 -----------------------------------------------
 
@@ -1302,6 +1=
355,39 @@
    response=2E Mechanisms that need multiple rounds or more comp=
lex answers
    should implement a different response type than CR_RESPONSE=
=2E
 
+(6) App custom control message
+
+    This message is an application=
 specific payload message that is transported
+    over the OpenVPN control=
 channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{protocol=
},{fragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:{protocol},{fr=
agment},{msg_base64}
+
+    The protocol is a short ascii string identifyin=
g the app specific custom
+    protocol=2E If fragment is set to 1, the mes=
sage is not complete and the
+    next message should be concatenated to th=
is message to form a complete
+    message=2E
+
+(7) App custom control pro=
tocol message
+
+   This message informs the client about the common ACC
+ =
  protocols and the maximum message length for an ACC message=2E
+
+   In c=
lient mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=3D=
{max_msg_len}
+
+   protocol_list is a list of supported protocols by the c=
lient=2E For example
+   flower:power:sys_info would indicate these three p=
rotocols to be supported=2E
+   max_msg_len specifies the maximum message l=
ength that the peer supports=2E
+
+   In server mode these are available in=
 the acc_protocols and
+   acc_message_length variables of the client envir=
onment=2E
 
 Variables:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/open=
vpn/Makefile=2Eam
index 8a60a94=2E=2Eebc4db6 100644
--- a/src/openvpn/Makef=
ile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -45,6 +45,7 @@
 sbin_PROGRAMS =
=3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2E=
h \
 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -124,7 +=
125,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
=
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \=

 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec =
reliable=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new f=
ile mode 100644
index 0000000=2E=2E4297cb9
--- /dev/null
+++ b/src/openvpn/=
acc=2Ec
@@ -0,0 +1,414 @@
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
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#=
include "syshead=2Eh"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#inc=
lude "error=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"
+#include "opt=
ions_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+#include "=
multi=2Eh"
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
RT(openvpn_base64_encode(CBPTR(buf), payload_len, &b64out) >=3D 0);
+      =
  gc_addspecial(b64out, free, &gc);
+        payload_msg =3D b64out;
+    }=

+    else
+    {
+        payload_msg =3D CBSTR(buf);
+    }
+
+    if (ma=
nagement)
+    {
+        struct tls_session *session =3D &c->c2=2Etls_mult=
i->session[TM_ACTIVE];
+
+        if (c->options=2Emode =3D=3D MODE_SERVER)=

+        {
+            /* server mode=2E Report client context */
+      =
      struct man_def_auth_context *mda =3D session->opt->mda_context;
+    =
        unsigned int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda=
_key_id;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+       =
         mda->cid, mda_key_id, protocol, fragment, payload_msg);
+        }=

+        else
+        {
+            /* Client mode=2E Do not a report a =
CLIENT id */
+            msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment=
, payload_msg);
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABL=
E_MANAGEMENT */
+    msg(D_PUSH, "Received custom app control message (prot=
ocol '%s'%s)",
+        protocol, fragment ? ", fragment" : "");
+}
+
+
+/*=
*
+ *  Parses the flags field of an app control message and moves the
+ *  =
buffer past the flags string=2E If there is an
+ *  error parsing the flags=
 field the method returns -1 and
+ *  puts the error reason in err_reason
+=
 */
+static int
+parse_acc_message_flags(struct buffer *buf, const char **e=
rr_reason, struct gc_arena *gc)
+{
+    const char *flags =3D buf_extract_f=
ield(buf, ',', gc);
+
+    if (!flags)
+    {
+        *err_reason =3D "cou=
ld not extract flags field";
+        return -1;
+    }
+
+
+    int acc_fl=
ags =3D 0;
+
+    for (const char *flag =3D flags; *flag !=3D '\0'; flag++)=

+    {
+        if (*flag =3D=3D 'A')
+        {
+            acc_flags |=
=3D ACC_MESSAGE_FLAGS_ASCII;
+        }
+        else if (*flag =3D=3D '6')=

+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        =
}
+        else if (*flag =3D=3D 'F')
+        {
+            acc_flags |=
=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
+        else
+        {
+      =
      *err_reason =3D "Unknown flag in flags";
+            return -1;
+   =
     }
+    }
+    /* The message should be encoded with exactly one encodi=
ng=2E Ensure that
+     * only one of the flags is present */
+    bool asc=
iienc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =
=3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + as=
ciienc !=3D 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, gc);
+      =
  snprintf(tmp, 512, "number of encodings must be exactly one "
+          =
                 "(B64=3D%d, ASCII=3D%d)",
+                 base64enc, asc=
iienc);
+        *err_reason =3D tmp;
+        return -1;
+    }
+
+    ret=
urn acc_flags;
+}
+
+
+void
+receive_acc_message(struct context *c, const s=
truct buffer *buffer)
+{
+    struct gc_arena gc =3D gc_new();
+    const c=
har *err_reason =3D "";
+
+    /* Example message: ACC,muppets,15,A,I am Mi=
ss Piggy */
+    struct buffer buf =3D *buffer;
+
+    if (!buf_advance(&bu=
f, strlen("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+        err_reason=
 =3D "missing , after ACC";
+        goto err;
+    }
+
+    /* extract pro=
tocol, payload length, flags substrings */
+    const char *protocol =3D bu=
f_extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
+        err_re=
ason =3D "could not extract protocol field";
+        goto err;
+    }
+
+ =
   int payload_len;
+    const char *payload_len_str =3D buf_extract_field(=
&buf, ',', &gc);
+    if (!payload_len_str || !((payload_len =3D atoi(paylo=
ad_len_str))))
+    {
+        err_reason =3D "could not extract payload le=
ngth field";
+        goto err;
+    }
+
+    int flags =3D parse_acc_messa=
ge_flags(&buf, &err_reason, &gc);
+
+    if (flags < 0)
+    {
+        got=
o err;
+    }
+
+    /* We should have a final NUL byte in the control mess=
age buffer
+     * and thus the length of the buffer should be payload_len =
+ 1 */
+    if (buf_len(&buf) !=3D payload_len + 1)
+    {
+        char *t=
mp =3D gc_malloc(512, 1, &gc);
+        snprintf(tmp, 512, "field length %d=
, payload length %d mismatch",
+                 payload_len, buf_len(&buf)=
 - 1);
+        err_reason =3D tmp;
+        goto err;
+    }
+
+
+    log_=
acc_message(c, &buf, payload_len, protocol, flags);
+    gc_free(&gc);
+   =
 return;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: Received malformed custo=
m app control channel "
+                       "(%s) message control messa=
ge: %s",
+        err_reason,
+        format_hex(BPTR(&buf), BLEN(&buf), 8=
0, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_acc_message(struct context =
*c,
+                 struct tls_multi *multi,
+                 struct tls=
_session *session,
+                 const char *protocol, bool fragment,
+=
                 const char *msg, bool base64)
+{
+    /*
+     * length of=
 the protocol string + one ','
+     * 2 for the encoding (A or 6), potenti=
al F (fragment), and 1 for the ',',
+     * 4 for the message size itself a=
nd one comma
+     * 1 for the comma before the message itself */
+    cons=
t size_t max_header_size =3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 =
+ 2 + 1;
+    size_t len =3D max_header_size + strlen(msg);
+
+    if (len =
> TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CLIENT, "message length (%zu)=
 exceeds maximum possible message length (%d)", len, TLS_CHANNEL_BUF_SIZE);=

+        return false;
+    }
+
+    if ((int)len > multi->acc_max_message=
_length)
+    {
+        msg(M_CLIENT, "header (%zu) + message size (%zu) l=
ength (%zu) exceeds "
+                      "maximum allowed length negoti=
ated with peer (%d)",
+            max_header_size, strlen(msg), len,
+    =
        multi->acc_max_message_length);
+        return false;
+    }
+
+  =
  struct gc_arena gc =3D gc_new();
+    /* add 1 for the final \0 */
+    s=
truct buffer buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example message:=
 ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s=
,%s", protocol,
+               strlen(msg),
+               base64 ? "6" :=
 "A",
+               fragment ? "F" : "",
+               msg);
+
+    sen=
d_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
+    reschedu=
le_multi_process(c);
+    gc_free(&gc);
+    return true;
+}
+
+char *
+par=
se_acc_parameters(const char *capabilities,
+                     const cha=
r *delim,
+                     int *max_acc_len,
+                     boo=
l server,
+                     struct gc_arena *gc)
+{
+    char *tmp_mess=
age =3D string_alloc(capabilities, NULL);
+    char *tmp_message_orig =3D t=
mp_message;
+    char *lasts =3D NULL;
+
+    const char *token =3D strtok_=
r(tmp_message, delim, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+=
    const char *protocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In s=
erver mode we allow more capabilities than our own, in client
+     * mode =
we reject if we should use capabilities that we do not support */
+    int =
allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token=
)
+    {
+        if (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC =
message length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+       =
 {
+            goto done;
+        }
+
+        if (p =3D=3D 1 && (!tls_it=
em_in_cipher_list("A", token) || !tls_item_in_cipher_list("6", token)))
+  =
      {
+            msg(D_PUSH_ERRORS, "App custom control encoding must i=
nclude base64 and ascii");
+            goto done;
+        }
+
+        if=
 (p =3D=3D 1 && !server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+ =
       {
+            msg(D_PUSH_ERRORS, "App custom control encoding must =
exactly base64 and ascii");
+            goto done;
+        }
+
+        i=
f (p =3D=3D 2)
+        {
+            protocols =3D token;
+        }
+
+ =
       if (p =3D=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many=
 parameters for INFO ACC message/IV_ACC=2E");
+            goto done;
+    =
    }
+
+        token =3D strtok_r(NULL, delim, &lasts);
+        p++;
+  =
  }
+
+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D =
string_alloc(protocols, gc);
+
+done:
+    free(tmp_message_orig);
+    ret=
urn ret;
+}
+
+struct buffer
+get_list_intersection(struct gc_arena *gc, co=
nst char *list1, const char *list2)
+{
+    char *tmp =3D strdup(list1);
+ =
   char *lasts =3D NULL;
+    const char *token =3D strtok_r(tmp, ":", &las=
ts);
+
+    /* The maximum possible length is the shorter of the two input =
lists */
+    size_t max_len =3D min_size(strlen(list1), strlen(list2));
+
=
+    struct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);
+
+ =
   while (token)
+    {
+        if (tls_item_in_cipher_list(token, list2))=

+        {
+            /* protocol is in both server and client list */
+=
            if (buf_len(&common_protocols) > 0)
+            {
+           =
     buf_write_u8(&common_protocols, ':');
+            }
+            buf_=
printf(&common_protocols, "%s", token);
+        }
+        token =3D strto=
k_r(NULL, ":", &lasts);
+    }
+    free(tmp);
+    return common_protocols=
;
+}
+
+void
+determine_common_acc_protocols(struct tls_multi *multi, struc=
t tls_session *session)
+{
+    if (!multi->opt=2Eacc_protocols)
+    {
+  =
      /* No app custom protocols have been configured server-side=2E */
+  =
      return;
+    }
+
+    if (multi->acc_negotiated_protocols)
+    {
+  =
      /* We already have determined the common protocols=2E Doing this
+   =
      * again would just add an extra string allocation to options->gc */
+=
        return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    /* ex=
ample IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    const char *peer_info =
=3D multi->peer_info;
+    const char *iv_acc =3D extract_var_peer_info(pee=
r_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);
=
+        return;
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
+    struct buffer common_protocols =3D get_list_intersection(&gc, se=
ssion->opt->acc_protocols, protocols);
+
+    if (buf_len(&common_protocols=
) =3D=3D 0)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_DEBUG, "WARNI=
NG: No common app custom control protocol=2E");
+        gc_free(&gc);
+   =
     return;
+    }
+
+    multi->acc_negotiated_protocols =3D string_alloc=
(buf_str(&common_protocols), NULL);
+    multi->acc_max_message_length =3D =
max_acc_len;
+
+    setenv_str(session->opt->es, "acc_protocols", multi->ac=
c_negotiated_protocols);
+    setenv_int(session->opt->es, "acc_message_len=
", multi->acc_max_message_length);
+
+    gc_free(&gc);
+}
diff --git a/src=
/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 0000000=
=2E=2E4a388f7
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,105 @@
+/*=

+ *  OpenVPN -- An application to securely tunnel IP networks
+ *         =
    over a single TCP/UDP port, with support for SSL/TLS-based
+ *         =
    session authentication and key exchange,
+ *             packet encrypt=
ion, packet authentication, and
+ *             packet compression=2E
+ *
+=
 *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C)=
 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free s=
oftware; you can redistribute it and/or modify
+ *  it under the terms of t=
he GNU General Public License version 2
+ *  as published by the Free Softw=
are Foundation=2E
+ *
+ *  This program is distributed in the hope that it =
will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See t=
he
+ *  GNU General Public License for more details=2E
+ *
+ *  You should =
have received a copy of the GNU General Public License along
+ *  with this=
 program; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Fr=
anklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef AC=
C_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
=
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom c=
ontrol message and delivers it to the
+ * management interface=2E We leave =
reassembly of fragmented messages to the
+ * management interface=2E
+ *
+ =
* @param c            The context struct
+ * @param buffer       Buffer con=
taining the control message with ACC
+ */
+void
+receive_acc_message(struct=
 context *c, const struct buffer *buffer);
+
+
+bool
+send_acc_message(stru=
ct context *c,
+                 struct tls_multi *tls_multi,
+            =
     struct tls_session *session,
+                 const char *protocol, b=
ool fragment,
+                 const char *msg, bool base64);
+
+
+/**
+ *=
 Parses an info message from the server that contains app custom control in=
fo
+ * information prior to the PUSH_REPLY to be able to use app custom con=
trol
+ * protocols before sending
+ *
+ * In client mode only allow what we=
 support ourselves=2E In server mode
+ * allow also capabilities that we no=
t support ourselves=2E
+ *
+ * @param capabilities      The string to parse=

+ * @param delim             The delimiter to use when parsing the string=
=2E
+ *                          IV_ACC uses "," as delimiter while the
+ *=
                          custom-control PUSH message uses " " as "," is
+ =
*                          already used to separate different push directiv=
es
+ * @param max_acc_len       Set to the maximum ACC message length
+ * @=
param server            Whether we are server or client
+ * @param gc      =
          The gc arena to use for allocating the resulting string
+ * @retu=
rn                  The resulting protocol string or NULL on error
+ */
+ch=
ar *
+parse_acc_parameters(const char *capabilities,
+                     =
const char *delim,
+                     int *max_acc_len,
+               =
      bool server,
+                     struct gc_arena *gc);
+
+/**
+ * P=
arses the IV_ACC of the peer and sets multi=2Eacc_negotiated_protocols
+ * =
to the common protocols of server and client and
+ * multi=2Eacc_max_messag=
e_length  to the maximum length of the ACC message
+ * support by both serv=
er and client=2E
+ *
+ * If there is no common protocol or the client does =
not support any app custom
+ * protocol multi=2Eacc_negotiated_protocols wi=
ll be set to NULL=2E
+ *
+ * @param multi      the multi instance to use th=
e set the app custom protocols=2E
+ * @param session    the session to read=
 the client env from
+ */
+void
+determine_common_acc_protocols(struct tls_=
multi *multi, struct tls_session *session);
+
+/**
+ * Calculates the inter=
section of two list that are both separated by :
+ * Items in the result wi=
ll have the same ordering as in the list1
+ * parameters
+ * @param gc     =
       Returned buffer will be allocated in this gc
+ * @param list1       =
  First list to intersect
+ * @param list2         Second list to intersect=
=2E
+ * @return A (potentially empty) buffer containing an intersection lis=
t
+ */
+struct buffer
+get_list_intersection(struct gc_arena *gc, const cha=
r *list1, const char *list2);
+#endif
diff --git a/src/openvpn/forward=2Ec =
b/src/openvpn/forward=2Ec
index 681210d=2E=2E7923b5e 100644
--- a/src/openv=
pn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "d=
co=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#include "ac=
c=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
     }
     else if=
 (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        server_pushed=
_info(buf, 8);
+        server_pushed_info(c, buf, 8);
     }
     else if =
(buf_string_match_head_str(buf, "INFO"))
     {
-        server_pushed_info=
(buf, 4);
+        server_pushed_info(c, buf, 4);
     }
     else if (buf_=
string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @@
    =
 {
         receive_auth_pending(c, buf);
     }
+    else if (buf_string_m=
atch_head_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf);
+  =
  }
     else if (buf_string_match_head_str(buf, "EXIT"))
     {
         r=
eceive_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec
index bd890e5=2E=2E6e119b2 100644
--- a/src/openvpn/init=2Ec
+++ b/sr=
c/openvpn/init=2Ec
@@ -2279,6 +2279,13 @@
         }
     }
 
+    struct t=
ls_multi *multi =3D c->c2=2Etls_multi;
+    if (multi->acc_negotiated_proto=
cols)
+    {
+        buf_printf(&out, " custom-control %d,A:6,%s",
+      =
             multi->acc_max_message_length, multi->acc_negotiated_protocols=
);
+    }
+
     if (BLENZ(&out) > strlen(header))
     {
         msg(D_HA=
NDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2529,11 @@
         flags |=3D (OPT=
_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+ =
   {
+        flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -27=
30,6 +2742,17 @@
         frame->tun_mtu =3D min_int(frame->tun_max_mtu, c-=
>options=2Ece=2Etun_mtu);
     }
 
+    if (found & OPT_P_ACC && c->options=
=2Epushed_acc_negotiated_protocols)
+    {
+        struct tls_multi *multi=
 =3D c->c2=2Etls_multi;
+        free(multi->acc_negotiated_protocols);
+  =
      multi->acc_negotiated_protocols =3D string_alloc(c->options=2Epushed_=
acc_negotiated_protocols, NULL);
+        multi->acc_max_message_length =3D=
 c->options=2Epushed_acc_max_message_length;
+
+        msg(D_PUSH, "OPTION=
S IMPORT: ACC protocols: %s, msg len: %d",
+            multi->acc_negotiat=
ed_protocols, multi->acc_max_message_length);
+    }
+
     return true;
 }=

 
@@ -3352,6 +3375,7 @@
     to=2Everify_hash_depth =3D options->verify_ha=
sh_depth;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;
     =
memcpy(to=2Ex509_username_field, options->x509_username_field, sizeof(to=2E=
x509_username_field));
+    to=2Eacc_protocols =3D options->acc_protocols;
=
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,=
6 +4330,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+managem=
ent_acc_msg(void *arg,
+                   struct buffer_list *input) /* ow=
nership transferred */
+{
+    struct context *c =3D arg;
+
+    bool ret =
=3D false;
+    if (buffer_list_defined(input) && c->c2=2Etls_multi)
+    {=

+        struct tls_multi *multi =3D c->c2=2Etls_multi;
+        struct tl=
s_session *session =3D &multi->session[TM_ACTIVE];
+
+        ret =3D manag=
ement_send_acc_message(c, multi, session, input);
+    }
+
+    buffer_list=
_free(input);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 =
void
@@ -4322,6 +4364,7 @@
         cb=2Eproxy_cmd =3D management_callback_=
proxy_cmd;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
   =
      cb=2Esend_cc_message =3D management_callback_send_cc_message;
+      =
  cb=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=
=2Enetwork_change =3D management_callback_network_change;
 #endif
diff --gi=
t a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ccf66b43=2E=2E86d=
82ba 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -4=
5,9 +45,11 @@
 #include "push=2Eh"
 #include "multi=2Eh"
 #include "resolve=
=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 #include "run_command=
=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh=
"
@@ -1082,6 +1084,35 @@
             }
             break;
 
+        case=
 IEC_CLIENT_ACC_MSG:
+            if (man->persist=2Ecallback=2Eclient_acc_=
msg)
+            {
+                bool status =3D (*man->persist=2Ecallb=
ack=2Eclient_acc_msg)(man->persist=2Ecallback=2Earg,
+                     =
                                                 man->connection=2Ein_extra=
_cid,
+                                                                    =
  man->connection=2Ein_extra_kid,
+                                        =
                              man->connection=2Ein_extra);
+               =
 man->connection=2Ein_extra =3D NULL;
+                report_command_statu=
s(status, "client-acc-msg");
+            }
+            else
+            =
{
+                man_command_unsupported("client-acc-msg");
+            =
}
+            break;
+
+        case IEC_ACC_MSG:
+            if (man->pe=
rsist=2Ecallback=2Eacc_msg)
+            {
+                bool status =3D=
 (*man->persist=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+     =
                                                          man->connection=
=2Ein_extra);
+                man->connection=2Ein_extra =3D NULL;
+      =
          report_command_status(status, "acc-msg");
+            }
+       =
     else
+            {
+                man_command_unsupported("acc-msg"=
);
+            }
+            break;
         case IEC_PK_SIGN:
          =
   man->connection=2Eext_key_state =3D EKS_READY;
             buffer_list_=
free(man->connection=2Eext_key_input);
@@ -1206,6 +1237,29 @@
 }
 
 static =
void
+man_client_acc_msg(struct management *man, const char *cid_str,
+    =
               const char *kid_str)
+{
+    struct man_connection *mc =3D &=
man->connection;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
=
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_s=
tr, "KID", &mc->in_extra_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLI=
ENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void=

+man_acc_msg(struct management *man)
+{
+    struct man_connection *mc =3D=
 &man->connection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_res=
et(mc, IER_NEW);
+}
+
+static void
 man_client_auth(struct management *man,=
 const char *cid_str, const char *kid_str, const bool extra)
 {
     struct=
 man_connection *mc =3D &man->connection;
@@ -1760,6 +1814,17 @@
          =
   man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
=
+    else if (streq(p[0], "client-acc-msg"))
+    {
+        if (man_need(p=
, 2, 0))
+        {
+            man_client_acc_msg(man, p[1], p[2]);
+    =
    }
+    }
+    else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_=
msg(man);
+    }
     else if (streq(p[0], "rsa-sig"))
     {
         man_=
pk_sig(man, "rsa-sig");
@@ -2978,7 +3043,9 @@
                             =
           "bytes_sent=3D",
                                        "bytes_=
received=3D",
                                        "session_id=3D",
-   =
                                    "session_state=3D" };
+                =
                       "session_state=3D",
+                               =
        "acc_protocols=3D",
+                                       "acc_me=
ssage_len=3D" };
 
     if (env_filter_level =3D=3D 0)
     {
@@ -3133,6 +3=
200,7 @@
     }
 }
 
+
 void
 management_connection_established(struct mana=
gement *man, struct man_def_auth_context *mdac,
                           =
        const struct env_set *es)
@@ -4375,6 +4443,64 @@
     }
 }
 
+bool
=
+management_send_acc_message(struct context *c, struct tls_multi *multi, st=
ruct tls_session *session,
+                            struct buffer_list =
*input)
+{
+    /* also ensures that are enough inputs in the list to safel=
y call
+     * buffer_list_peek without extra NULL checks */
+    if (!inpu=
t || input->size < 3)
+    {
+        msg(M_CLIENT, "not enough input lines=
 for sending acc message, "
+                      "missing protocol, flag =
and/or messages lines");
+        return false;
+    }
+
+    struct gc_are=
na gc =3D gc_new();
+
+    const struct buffer *proto_buf =3D buffer_list_p=
eek(input);
+    const char *protocol =3D string_alloc(CBSTR(proto_buf), &g=
c);
+    buffer_list_pop(input);
+
+    struct buffer *encoding_buf =3D buf=
fer_list_peek(input);
+    char *encoding =3D buf_str(encoding_buf);
+    c=
onst char *flag =3D NULL;
+    bool b64encoding =3D false;
+    bool fragme=
nt =3D false;
+
+    while ((flag =3D strsep(&encoding, ":")))
+    {
+    =
    if (!strcmp(flag, "6"))
+        {
+            b64encoding =3D true;
+=
        }
+        else if (!strcmp(flag, "F"))
+        {
+            fra=
gment =3D true;
+        }
+    }
+    buffer_list_pop(input);
+
+    buffe=
r_list_aggregate_separator(input, 10000, "");
+    const struct buffer *acc=
_msg_buf =3D buffer_list_peek(input);
+
+    if (!multi->acc_negotiated_pro=
tocols
+        || !tls_item_in_cipher_list(protocol, multi->acc_negotiated=
_protocols))
+    {
+        msg(M_CLIENT, "protocol not in the list of neg=
otiated protocols: %s",
+            np(multi->acc_negotiated_protocols));
=
+        goto error;
+    }
+
+    bool ret =3D send_acc_message(c, multi, =
session, protocol,
+                                fragment, buf_cstr(acc_=
msg_buf),
+                                b64encoding);
+    gc_free(&gc);=

+    return ret;
+error:
+    gc_free(&gc);
+    return false;
+}
 #else /=
* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff --git a/src/openv=
pn/manage=2Eh b/src/openvpn/manage=2Eh
index 157039d=2E=2Ecc9c264 100644
--=
- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 =
@@
     int (*n_clients)(void *arg);
     bool (*send_cc_message)(void *arg=
, const char *message, const char *parameter);
     bool (*kill_by_cid)(voi=
d *arg, const unsigned long cid, const char *kill_msg);
+
     bool (*clien=
t_auth)(void *arg, const unsigned long cid, const unsigned int mda_key_id,
=
                         const bool auth, const char *reason, const char *c=
lient_reason,
                         struct buffer_list *cc_config); /* o=
wnership transferred */
     bool (*client_pending_auth)(void *arg, const u=
nsigned long cid, const unsigned int kid,
                                 =
const char *extra, unsigned int timeout);
     char *(*get_peer_info)(void =
*arg, const unsigned long cid);
+    bool (*client_acc_msg)(void *arg,
+   =
                        const unsigned long cid,
+                         =
  const unsigned int mda_key_id,
+                           struct buffer_=
list *msg);
+    bool (*acc_msg)(void *arg,
+                    struct buf=
fer_list *msg);
     bool (*proxy_cmd)(void *arg, const char **p);
     boo=
l (*remote_cmd)(void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,=
13 +299,15 @@
     struct command_line *in;
     struct buffer_list *out;
 =

-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF  =
        0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMO=
VED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#def=
ine IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN     =
  3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define IE=
C_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG      =
  8
     int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned=
 long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(s=
truct management *man, struct context *c);
 
+/** Parses the ACC message fr=
om the input buffer_list and send to the
+ * session identified by session =
and multi
+ */
+struct tls_session;
+struct tls_multi;
+bool
+management_se=
nd_acc_message(struct context *c, struct tls_multi *multi,
+               =
             struct tls_session *session, struct buffer_list *input);
 #end=
if /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec
index e302a81=2E=2E0ae503d 100644
--- a/src/openvpn=
/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include "ssl_uti=
l=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#include "acc=2E=
h"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1735,8 +1736,9 @@
  * - peer=
 id
  */
 static bool
-multi_client_set_protocol_options(struct context *c)=

+multi_client_set_protocol_options(struct multi_instance *mi)
 {
+    stru=
ct context *c =3D &mi->context;
     struct tls_multi *tls_multi =3D c->c2=
=2Etls_multi;
     const char *const peer_info =3D tls_multi->peer_info;
  =
   struct options *o =3D &c->options;
@@ -2380,7 +2382,7 @@
      * peer mu=
st be added before iroutes=2E For other platforms it doesn't matter=2E */
 =

     /* authentication complete, calculate dynamic client specific options=
 */
-    if (!multi_client_set_protocol_options(&mi->context))
+    if (!mu=
lti_client_set_protocol_options(mi))
     {
         mi->context=2Ec2=2Etls=
_multi->multi_state =3D CAS_FAILED;
     }
@@ -4085,6 +4087,26 @@
     }
 }=

 
+static const char *
+calculate_app_control_extra(struct multi_instance =
*mi, struct gc_arena *gc)
+{
+    struct context *c =3D &mi->context;
+    =
struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->acc_negot=
iated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negotiated protocol=
s");
+        return NULL;
+    }
+
+    struct buffer buf =3D alloc_buf_gc=
(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi->acc_max_message=
_length,
+               multi->acc_negotiated_protocols);
+    return buf_=
str(&buf);
+}
+
+
 static bool
 management_client_pending_auth(void *arg, c=
onst unsigned long cid, const unsigned int mda_key_id,
                    =
            const char *extra, unsigned int timeout)
@@ -4095,10 +4117,22 @=
@
     if (mi)
     {
         struct tls_multi *multi =3D mi->context=2Ec2=
=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new();
+        if (!str=
cmp(extra, "ACC"))
+        {
+            extra =3D calculate_app_control_=
extra(mi, &gc);
+            if (!extra)
+            {
+                gc=
_free(&gc);
+                return false;
+            }
+        }
      =
   struct tls_session *session =3D lookup_session_by_mda_key_id(multi, mda_=
key_id);
 
         if (!session)
         {
+            gc_free(&gc);
   =
          return false;
         }
 
@@ -4106,6 +4140,7 @@
         bool re=
t =3D send_auth_pending_messages(multi, session, extra, timeout);
         =
reschedule_multi_process(&mi->context);
         multi_schedule_context_wak=
eup(m, mi);
+        gc_free(&gc);
         return ret;
     }
     return =
false;
@@ -4149,6 +4184,37 @@
     return ret;
 }
 
+
+static bool
+managem=
ent_client_acc_msg(void *arg,
+                          const unsigned lon=
g cid,
+                          const unsigned int mda_key_id,
+         =
                 struct buffer_list *input) /* ownership transferred */
+{
=
+    struct multi_context *m =3D (struct multi_context *)arg;
+    struct m=
ulti_instance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+  =
  if (mi && buffer_list_defined(input))
+    {
+        struct tls_multi *m=
ulti =3D mi->context=2Ec2=2Etls_multi;
+        struct tls_session *session=
 =3D lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (!session=
)
+        {
+            msg(M_CLIENT, "client session not found");
+     =
       buffer_list_free(input);
+            return false;
+        }
+
+  =
      ret =3D management_send_acc_message(&mi->context, multi, session, inp=
ut);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_li=
st_free(input);
+    return ret;
+}
+
+
 static char *
 management_get_peer=
_info(void *arg, const unsigned long cid)
 {
@@ -4185,6 +4251,7 @@
        =
 cb=2En_clients =3D management_callback_n_clients;
         cb=2Ekill_by_ci=
d =3D management_kill_by_cid;
         cb=2Eclient_auth =3D management_clie=
nt_auth;
+        cb=2Eclient_acc_msg =3D management_client_acc_msg;
      =
   cb=2Eclient_pending_auth =3D management_client_pending_auth;
         cb=
=2Eget_peer_info =3D management_get_peer_info;
         cb=2Epush_update_br=
oadcast =3D management_callback_send_push_update_broadcast;
diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec
index fb319ae=2E=2E04b553e =
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
@@ -7107,6 +7108,41 @@
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
+        /* check if the list from the server is a real =
subset of our list */
+        struct gc_arena gc =3D gc_new();
+        st=
ruct buffer common_list =3D get_list_intersection(&gc, p[3], options->acc_p=
rotocols);
+
+        if (buf_len(&common_list) =3D=3D 0 || !streq(p[3], bu=
f_cstr(&common_list)))
+        {
+            msg(msglevel, "App custom co=
ntrol list from server contains "
+                          "unsupported p=
rotocols");
+            gc_free(&gc);
+            goto err;
+        }
+ =
       gc_free(&gc);
+
+        if (!streq(p[2], "A:6") && !streq(p[2], "6:=
A"))
+        {
+            msg(msglevel, "App custom control encoding mus=
t be base64 and ascii");
+            goto err;
+        }
+
+        if (!=
atoi_constrained(p[1], &options->pushed_acc_max_message_length,
+          =
                    "app custom message message length", ACC_MIN_MSG_LEN, A=
CC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
+        }
+  =
      options->pushed_acc_negotiated_protocols =3D p[3];
+    }
     else i=
f (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTIC=
E: --prng option ignored (SSL library PRNG is used)");
diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh
index 6a3bf61=2E=2Eb7945e0 10064=
4
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -715,6 +71=
5,18 @@
     /* force using TLS key material export for data channel key ge=
neration */
     bool force_key_material_export;
 
+    /** The app custom =
control protocols we should announce as supported */
+    const char *acc_p=
rotocols;
+
+    /** the protocols that are negotiated with the peer=2E Thi=
s is a
+     *  a temporary variable since options=2Ec push parser cannot a=
ccess
+     *  tls multi struct */
+    const char *pushed_acc_negotiated_p=
rotocols;
+
+    /** the maximum length of an ACC control channel message v=
ia push message
+     * */
+    int pushed_acc_max_message_length;
+
     b=
ool vlan_tagging;
     enum vlan_acceptable_frames vlan_accept;
     uint16=
_t vlan_pvid;
@@ -764,8 +776,10 @@
 #define OPT_P_INLINE          (1u << 29=
)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     =
(1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
-#define OPT_P_DEF=
AULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Opt=
ions allowed in the normal configuration file (vs pushed options or in ccd =
files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_=
P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff -=
-git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 42259c3=2E=2E320f8=
9d 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -27,6 +2=
7,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh"
+
+#include "acc=2Eh"=

 #include "options=2Eh"
 #include "crypto=2Eh"
 #include "ssl=2Eh"
@@ -221=
,9 +223,58 @@
 #endif
 }
 
+static void
+parse_server_pushed_info_acc(struc=
t context *c, struct buffer *buf)
+{
+    int max_acc_len =3D 0;
+    struc=
t tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->opt=2Eacc_prot=
ocols)
+    {
+        msg(D_PUSH_ERRORS, "Server tried to push app custom =
control list"
+                           "without client announcing suppor=
t for it");
+        return;
+    }
+
+    /* example string to parse: ACC:=
1400 A:6 flower:happy */
+    /* Skip over the ACC: prefix */
+    buf_adva=
nce(buf, 4);
+
+    struct gc_arena gc =3D gc_new();
+    char *protocols =
=3D parse_acc_parameters(buf_cstr(buf), " ", &max_acc_len, false, &gc);
+
+=
    /* check if the list from the server is a real subset of our list */
+ =
   struct buffer common_list =3D get_list_intersection(&gc, protocols, mult=
i->opt=2Eacc_protocols);
+
+    if (buf_len(&common_list) =3D=3D 0 || !stre=
q(protocols, buf_cstr(&common_list)))
+    {
+        msg(D_PUSH_ERRORS, "A=
pp custom control list from server contains "
+                           "=
unsupported protocols");
+        gc_free(&gc);
+        return;
+    }
+  =
  gc_free(&gc);
+
+    if (protocols)
+    {
+        multi->acc_negotiated=
_protocols =3D string_alloc(protocols, &c->options=2Egc);
+        multi->a=
cc_max_message_length =3D max_acc_len;
+
+#ifdef ENABLE_MANAGEMENT
+       =
 if (management)
+        {
+            msg(M_CLIENT, ">ACC_PROTOCOLS:prot=
ocols=3D%s,message_len=3D%d", protocols, max_acc_len);
+        }
+#endif
+=
    }
+    else
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC i=
nfo command with invalid parameters");
+    }
+}
 
 void
-server_pushed_inf=
o(const struct buffer *buffer, const int adv)
+server_pushed_info(struct co=
ntext *c, const struct buffer *buffer, const int adv)
 {
     const char *m=
 =3D "";
     struct buffer buf =3D *buffer;
@@ -233,6 +284,12 @@
         =
m =3D BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
=
+        parse_server_pushed_info_acc(c, &buf);
+        return;
+    }
+
 =
#ifdef ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ -=
285,6 +342,7 @@
     msg(D_PUSH, "CR response was sent by client ('%s')", m=
);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING request
  * @para=
m buffer                buffer containing the keywords, the buffer's
@@ -44=
1,7 +499,6 @@
     const char *const peer_info =3D tls_multi->peer_info;
  =
   unsigned int proto =3D extract_iv_proto(peer_info);
 
-
     /* Calculat=
e the maximum timeout and subtract the time we already waited */
     unsig=
ned int max_timeout =3D
         max_uint(tls_multi->opt=2Erenegotiate_seco=
nds / 2, tls_multi->opt=2Ehandshake_window);
@@ -732,6 +789,12 @@
         =
        client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
     =
}
+
+    if (tls_multi->acc_negotiated_protocols)
+    {
+        push_opti=
on_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s",
+               =
         tls_multi->acc_max_message_length, tls_multi->acc_negotiated_proto=
cols);
+    }
 }
 
 static bool
diff --git a/src/openvpn/push=2Eh b/src/ope=
nvpn/push=2Eh
index 39302f6=2E=2Eb6695bc 100644
--- a/src/openvpn/push=2Eh
=
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_incoming_push_r=
equest(struct context *c);
 
+
 /**
  * @brief Handles the receiving of a p=
ush-update message and applies updates to the specified
  * options=2E
@@ -=
92,7 +93,7 @@
 
 void receive_exit_message(struct context *c);
 
-void serv=
er_pushed_info(const struct buffer *buffer, const int adv);
+void server_pu=
shed_info(struct context *c, const struct buffer *buffer, const int adv);
 =

 void receive_cr_response(struct context *c, const struct buffer *buffer);=

 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6fc=2E=
=2Ee84d32d 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -5=
5,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
+#include "=
acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_backend=2Eh"
 #include "=
ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
     free(multi->locked_cn);
     free(m=
ulti->locked_username);
     free(multi->locked_original_username);
+    fr=
ee(multi->acc_negotiated_protocols);
 
     cert_hash_free(multi->locked_ce=
rt_hash_set);
 
@@ -2117,6 +2119,11 @@
                     }
             =
    }
             }
+
+            if (session->opt->acc_protocols)
+     =
       {
+                buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_=
MSG_LEN, session->opt->acc_protocols);
+            }
         }
     }
 
@=
@ -2398,6 +2405,8 @@
         multi->remote_ciphername =3D string_alloc("no=
ne", NULL);
     }
 
+    determine_common_acc_protocols(multi, session);
+=

     if (username_len < 0 || password_len < 0)
     {
         msg(D_TLS_E=
RRORS, "TLS Error: Username (%d) or password (%d) too long", abs(username_l=
en),
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
i=
ndex 9a55ead=2E=2E436770b 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src=
/openvpn/ssl_common=2Eh
@@ -457,6 +457,9 @@
     size_t ekm_size;
 
     bo=
ol dco_enabled; /**< Whether keys have to be installed in DCO or not */
+
+=
    /** The app custom control protocols we should announce as supported */=

+    const char *acc_protocols;
 };
 
 /** @addtogroup control_processor
@=
@ -730,6 +733,12 @@
     int dco_peer_id;
 
     dco_context_t *dco;
+
+   =
 /** the protocols that are negotiated with the peer=2E */
+    char *acc_n=
egotiated_protocols;
+
+    /** the maximum length of an ACC control channe=
l message */
+    int acc_max_message_length;
 };
 
 /**  gets an item  of =
\c key_state objects in the
diff --git a/tests/unit_tests/openvpn/Makefile=
=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E86326af 1=
00644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/o=
penvpn/Makefile=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_testdriver_=
LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES=
 =3D test_ssl=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=
=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec =
mock_win32_execve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$=
(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 =
	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
@@ -132,6 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	=
$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl=
_mbedtls=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec=
 \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \
@@ -392,9 +395,11 @=
@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \
 	test_schedule=2Ec test_s=
chedule=2Eh \
+	mock_management=2Ec mock_management=2Eh \
 	mock_msg=2Ec te=
st_common=2Eh  \
 	mock_get_random=2Ec \
 	$(top_srcdir)/src/compat/compat-=
strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/=
openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top=
_srcdir)/src/openvpn/ssl_util=2Ec \
@@ -407,6 +412,7 @@
 	$(top_srcdir)/src=
/openvpn/siphash_reference=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec=

 
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 =
	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
=
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_test=
s/openvpn/mock_management=2Ec
index fff4c2b=2E=2Ef572dbb 100644
--- a/tests=
/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock=
_management=2Ec
@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 
+#include <st=
dlib=2Eh>
 #include "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/t=
ests/unit_tests/openvpn/mock_management=2Eh b/tests/unit_tests/openvpn/mock=
_management=2Eh
new file mode 100644
index 0000000=2E=2E80dcfc2
--- /dev/nu=
ll
+++ b/tests/unit_tests/openvpn/mock_management=2Eh
@@ -0,0 +1,29 @@
+/*
=
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *          =
   over a single UDP port, with support for SSL/TLS-based
+ *             s=
ession authentication and key exchange,
+ *             packet encryption, =
packet authentication, and
+ *             packet compression=2E
+ *
+ *  C=
opyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This prog=
ram is free software; you can redistribute it and/or modify
+ *  it under t=
he terms of the GNU General Public License version 2
+ *  as published by t=
he Free Software Foundation=2E
+ *
+ *  This program is distributed in the =
hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *=
  You should have received a copy of the GNU General Public License along
+=
 *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+=
 */
+
+#ifndef MOCK_MANAGEMENT_H
+#define MOCK_MANAGEMENT_H
+void init_mock=
_management(void);
+
+void uninit_mock_management(void);
+
+#endif
diff --g=
it a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests=
/openvpn/mock_push_dependencies=2Ec
index bf2ccf3=2E=2Ef083f89 100644
--- a=
/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests=
/openvpn/mock_push_dependencies=2Ec
@@ -43,7 +43,8 @@
     uint64_t flags =
=3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
       =
               | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | O=
PT_P_PERSIST
                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY=
 | OPT_P_ECHO | OPT_P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT=
_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+                   =
  | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDN=
S
+                     | OPT_P_ACC;
     return flags;
 }
 
diff --git a/t=
ests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2E=
c
new file mode 100644
index 0000000=2E=2Edb291b8
--- /dev/null
+++ b/tests=
/unit_tests/openvpn/test_acc=2Ec
@@ -0,0 +1,332 @@
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
+ *  Copyright (C) 202=
5 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <a=
rne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redi=
stribute it and/or modify
+ *  it under the terms of the GNU General Public=
 License version 2
+ *  as published by the Free Software Foundation=2E
+ *=

+ *  This program is distributed in the hope that it will be useful,
+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General P=
ublic License for more details=2E
+ *
+ *  You should have received a copy =
of the GNU General Public License along
+ *  with this program; if not, wri=
te to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth =
Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include =
"config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#in=
clude <stdlib=2Eh>
+#include <stdarg=2Eh>
+#include <string=2Eh>
+#include =
<setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "acc=2Eh"
+#include "test_a=
cc=2Eh"
+#include "test_common=2Eh"
+
+#include "mock_msg=2Eh"
+#include "m=
ulti=2Eh"
+
+char control_channel_mesage_sent[2048];
+
+/* Mock functions *=
/
+bool
+send_control_channel_string_dowork(struct tls_session *session,
+ =
                                  const char *str, unsigned int msglevel)
+=
{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    memcpy(control_cha=
nnel_mesage_sent, str, strlen(str));
+    return true;
+}
+
+void
+send_pus=
h_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_client_=
reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#define MSG_PA=
YLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+         =
           "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+    =
                "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
=
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQA=
H" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFA=
wYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAg=
QCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/=
2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D"
+
+voi=
d
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENABLE_MANAGEME=
NT
+    skip();
+#else
+    /* ensure that the messages get to mock_msg */
=
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678;
+    stru=
ct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientHello */
=
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    struct buff=
er msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=2Emode =3D MO=
DE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, =
&gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls=
_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->mda_context=
 =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void *)msg, sizeof=
(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_equal(=
mock_msg_buf, "Received custom app control message (protocol 'cck1')");
+  =
  assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAY=
LOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIEtlcm1p=
dCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)=
flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_buf);
+ =
   assert_string_equal(mock_msg_buf, "Received custom app control message (=
protocol 'flower')");
+    assert_string_equal(mock_managment_buf, ">CLIENT=
:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+=

+    CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[] =3D "A=
CC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB=
9Ig=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, sizeof(m=
sg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+    const char=
 *error =3D "WARNING: Received malformed custom app control channel "
+    =
                    "(field length 62, payload length 64 mismatch) message =
"
+                        "control message: 496e7367 496d316c 496a6f67 496=
d5a79 "
+                        "62326369 4c434141 65475a6d 2f534a7[more=
=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+    assert_s=
tring_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment_buf);
+   =
 const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+    buf=
_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));
+    recei=
ve_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "Recei=
ved custom app control message (protocol 'power', fragment)");
+    assert_=
string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D"=
);
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding present */
=
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1=
pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *=
)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive_acc_messag=
e(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom app c=
ontrol channel (number of "
+            "encodings must be exactly one (B6=
4=3D1, ASCII=3D1)) message control "
+            "message: 53534268 625341=
41 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[mor=
e=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_st=
ring_equal(mock_managment_buf, "");
+
+    /* no encoding present */
+    c=
onst char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0=
aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_m=
sg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_message(&c, &msg_=
buf);
+
+    error =3D "WARNING: Received malformed custom app control chan=
nel (number of "
+            "encodings must be exactly one (B64=3D0, ASCI=
I=3D0)) message control "
+            "message: 53534268 62534141 4945746c=
 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[more=2E=2E=2E]=
";
+    assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(=
mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    management =3D NU=
LL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_parameters(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* parameters to INFO=
 message */
+    const char *info_acc_msg =3D "4096 A:6 flower:happy";
+
+ =
   int max_len =3D 0;
+    const char *protocols =3D parse_acc_parameters(i=
nfo_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols,=
 "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a client =
does not accept a length longer than it supports */
+    protocols =3D pars=
e_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null=
(protocols);
+
+    /* message with lower limit than our, should work for c=
lient and server */
+    info_acc_msg =3D "1111 A:6 flower:happy";
+    pro=
tocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+=
    assert_string_equal(protocols, "flower:happy");
+    assert_int_equal(m=
ax_len, 1111);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ",=
 &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy");=

+    assert_int_equal(max_len, 1111);
+
+    /* more encodings than suppor=
ted=2E Server should be okay, client should fail */
+    info_acc_msg =3D "=
1200 A:6:B flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_=
msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+    protoc=
ols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    =
assert_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_l=
en, 1200);
+
+    /* extra parameter */
+    info_acc_msg =3D "1400 A:6 flo=
wer:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &=
max_len, true, &gc);
+    assert_null(protocols);
+
+    protocols =3D pars=
e_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null=
(protocols);
+
+
+    const char *iv_acc_capabilities =3D "1400,A:6,flower:=
happy:power";
+    protocols =3D parse_acc_parameters(iv_acc_capabilities, =
",", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happ=
y:power");
+
+    /* too small protocol length */
+    info_acc_msg =3D "32=
 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, "=
,", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* non-numeri=
cal protocol length */
+    info_acc_msg =3D "abff A:6 flower:happy 77";
+ =
   protocols =3D parse_acc_parameters(info_acc_msg, ",", &max_len, true, &g=
c);
+    assert_null(protocols);
+
+    /* non-numerical protocol length */=

+    info_acc_msg =3D "abff A:6 flower:happy 77";
+    protocols =3D parse=
_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+    assert_null(p=
rotocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protocols(void =
**state)
+{
+    struct multi_instance mi =3D { 0 };
+    struct context *c=
 =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLE=
AR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+
+    c->c2=
=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happ=
y:power";
+    c->options=2Eacc_protocols =3D "power:flower:star";
+
+    s=
truct tls_multi *multi =3D c->c2=2Etls_multi;
+    determine_common_acc_pro=
tocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    assert_int_eq=
ual(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equ=
al(multi->acc_negotiated_protocols, "power:flower");
+
+    gc_free(&c->opt=
ions=2Egc);
+}
+
+void
+test_acc_send_message(void **state)
+{
+    struct =
multi_instance mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+   =
 c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi,=
 struct tls_multi, &c->options=2Egc);
+    bool ret;
+    struct tls_multi =
*multi =3D c->c2=2Etls_multi;
+
+
+    c->c2=2Etls_multi->peer_info =3D "IV=
_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power";
+    c->options=
=2Eacc_protocols =3D "power:flower:emergency";
+    determine_common_acc_pr=
otocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+
+    struct tls=
_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+    ret =
=3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency", true,
+   =
                        "EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:=
", false);
+
+    assert_true(ret);
+    assert_string_equal(control_channe=
l_mesage_sent,
+                        "ACC,emergency,50,AF,EMERGENCY BROA=
DCAST MESSAGE - THIS IS NOT A DRILL:");
+
+    ret =3D send_acc_message(c, =
c->c2=2Etls_multi, session, "emergency", false,
+                          =
 "THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", fal=
se);
+    assert_true(ret);
+    assert_string_equal(control_channel_mesage=
_sent,
+                        "ACC,emergency,65,A,THE GOVERNMENT HAS ISSU=
ED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E");
+
+
+    /* test a long mes=
sage (> 1000) with fragment to get the maximum header size */
+    char lon=
g_message[1200] =3D { 0 };
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+=
        long_message[i] =3D (char)(' ' + (i % 95));
+    }
+
+    /* last c=
har of the message is a i and then a \0 */
+    assert_int_equal(long_messa=
ge[1023], 'i');
+    assert_int_equal(long_message[1024], '\0');
+
+    ret=
 =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency", true,
+  =
                         long_message, false);
+
+    assert_true(ret);
+  =
  size_t cc_len =3D strlen(control_channel_mesage_sent);
+    assert_int_eq=
ual(control_channel_mesage_sent[cc_len - 1], 'i');
+    const char *expecte=
d_start_cc =3D "ACC,emergency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    asse=
rt_memory_equal(control_channel_mesage_sent, expected_start_cc, sizeof(expe=
cted_start_cc));
+
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_list_in=
tersection(void **state)
+{
+    const char *empty =3D "";
+    const char =
*protos =3D "power:flower:emergency";
+
+    struct gc_arena gc =3D gc_new(=
);
+
+    struct buffer t1 =3D get_list_intersection(&gc, empty, protos);
+=
    assert_int_equal(buf_len(&t1), 0);
+
+    struct buffer t2 =3D get_list=
_intersection(&gc, protos, empty);
+    assert_int_equal(buf_len(&t2), 0);
=
+
+    struct buffer t3 =3D get_list_intersection(&gc, protos, protos);
+  =
  assert_string_equal(buf_cstr(&t3), protos);
+
+    const char *protos2 =
=3D "flower:emergency:power:mario";
+    struct buffer t4 =3D get_list_inte=
rsection(&gc, protos2, protos);
+    assert_string_equal(buf_cstr(&t4), "fl=
ower:emergency:power");
+
+    const char *protos3 =3D "super:paper:mario:f=
lower";
+    struct buffer t5 =3D get_list_intersection(&gc, protos2, proto=
s3);
+    assert_string_equal(buf_cstr(&t5), "flower:mario");
+
+    gc_fre=
e(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_=
tests/openvpn/test_acc=2Eh
new file mode 100644
index 0000000=2E=2E32421fb
=
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
=
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *      =
       over a single UDP port, with support for SSL/TLS-based
+ *          =
   session authentication and key exchange,
+ *             packet encrypti=
on, packet authentication, and
+ *             packet compression=2E
+ *
+ =
*  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This =
program is free software; you can redistribute it and/or modify
+ *  it und=
er the terms of the GNU General Public License version 2
+ *  as published =
by the Free Software Foundation=2E
+ *
+ *  This program is distributed in =
the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *=

+ *  You should have received a copy of the GNU General Public License alo=
ng
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+void test_acc_parse_c=
lient_messages(void **state);
+
+void test_parse_acc_parameters(void **stat=
e);
+
+void test_acc_common_protocols(void **state);
+
+void test_acc_send_=
message(void **state);
+
+void test_list_intersection(void **state);
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
index aea40f0=2E=2E7405198 1=
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
index 4baf8cc=2E=2E4987dd0 100644
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
@@ -1111,8 +1127,12 @@
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
nit_test(test_acc_send_message),
+        cmocka_unit_test(test_list_inters=
ection)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8a=
e4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 13
Gerrit-Owner: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>

--yvdq/g6kkM8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #13</strong> to this ch=
ange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?us=
p=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Implement sending/receiving app=
 custom control protocol messages<br><br>This allows openvpn GUI/front-ends=
 and server via management<br>to use the OpenVPN control channel to pass me=
ssages between each other<br>while OpenVPN handles the marshalling/unmarsha=
lling of these and<br>negotiate the common app custom control protocols=2E<=
br><br>This provides an easy to use secure channel that does not depend on<=
br>the network itself to work and can also used before fully authenticating=
<br>the client=2E See the management-notes=2Etxt for more details how to us=
e<br>this feature=2E An upcoming patch will also add some example python<br=
>script that showcase this feature=2E<br><br>Change-Id: I4a6a6ef41e15896b8b=
79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eor=
g&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/client-options=2Er=
st<br>M doc/man-sections/management-options=2Erst<br>M doc/man-sections/scr=
ipt-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/openvpn/Makefile=
=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M src/openvpn/fo=
rward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/op=
envpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br=
>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=
=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/un=
it_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_managemen=
t=2Ec<br>A tests/unit_tests/openvpn/mock_management=2Eh<br>M tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_ac=
c=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/open=
vpn/test_common=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/=
unit_tests/openvpn/test_ssl=2Ec<br>28 files changed, 1,515 insertions(+), 2=
6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/58/1858/13</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=2E00caa2d 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -435,6 +435,8 @@</span><br><span>     src/compat/=
compat-strlcpy=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span>=
<br><span>     src/compat/compat-strtok_r=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     =
src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><s=
pan>     src/openvpn/base64=2Ec</span><br><span>@@ -571,8 +573,8 @@</span><=
br><span>     src/openvpn/ps=2Ec</span><br><span>     src/openvpn/ps=2Eh</s=
pan><br><span>     src/openvpn/push=2Ec</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    src/openvpn/push_util=2Ec</span><br><span>     src/op=
envpn/push=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
rc/openvpn/push_util=2Ec</span><br><span>     src/openvpn/pushlist=2Eh</spa=
n><br><span>     src/openvpn/reflect_filter=2Ec</span><br><span>     src/op=
envpn/reflect_filter=2Eh</span><br><span>@@ -826,7 +828,10 @@</span><br><sp=
an>             tests/unit_tests/openvpn/mock_management=2Ec</span><br><spa=
n>             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br=
><span>             tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests=
/openvpn/test_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            src/openvpn/acc=2Ec</span><br><span>             src/openvpn/=
argv=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 src/openvpn/auth_token=2Ec</span><br><span>             src/openvpn/base64=
=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br><s=
pan>             src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -840,8 +=
845,11 @@</span><br><span>             src/openvpn/options_util=2Ec</span><=
br><span>             src/openvpn/otime=2Ec</span><br><span>             sr=
c/openvpn/packet_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            src/openvpn/reliable=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            src/openvpn/session_id=2Ec</span><br><span=
>             src/openvpn/run_command=2Ec</span><br><span>             src/=
openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            src/openvpn/ssl_ncp=2Ec</span><br><span>             src/op=
envpn/ssl_openssl=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec=
</span><br><span>             src/openvpn/ssl_verify_mbedtls=2Ec</span><br>=
<span>@@ -858,6 +866,8 @@</span><br><span>     target_sources(test_misc PRI=
VATE</span><br><span>         tests/unit_tests/openvpn/mock_get_random=2Ec<=
/span><br><span>         tests/unit_tests/openvpn/test_schedule=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/op=
envpn/mock_management=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        src/openvpn/base64=2Ec</span><br><span>         src/openvpn/o=
ptions_util=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><br><s=
pan>         src/openvpn/ssl_util=2Ec</span><br><span>diff --git a/doc/man-=
sections/client-options=2Erst b/doc/man-sections/client-options=2Erst</span=
><br><span>index 87c138a=2E=2Eb204d6a 100644</span><br><span>--- a/doc/man-=
sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client=
-options=2Erst</span><br><span>@@ -12,6 +12,17 @@</span><br><span>   When t=
his option is set, OpenVPN will not drop incoming tun packets with</span><b=
r><span>   same destination as host=2E</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+--app-custom-control protocollist</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the list of suppo=
rted app custom control protocols=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  These protocols are announced to the server when this op=
tion is used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as a =
client=2E If the option is set on a server it will negotiate the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  common protocols with the cl=
ient=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  The protocollist is a : separ=
ated list of protocol identifiers=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
See management-notes=2Etxt in the OpenVPN distribution and the OpenVPN RFC<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  draft for a descri=
ption of app custom control protocol support=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> --auth-token token</span><br>=
<span>   This is not an option to be used directly in any configuration fil=
es,</span><br><span>   but rather push this option from a ``--client-connec=
t`` script or a</span><br><span>@@ -437,6 +448,12 @@</span><br><span>      =
   Additional authentication methods supported by the client=2E</span><br><=
span>         This may be set by the client UI/GUI using ``--setenv``=2E</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :c=
ode:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags&gt;,&lt;protocols&gt;`</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        If the option ``--ap=
p-custom-control`` is set, the client will</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        send the supported max ACC message length, t=
he supported formats</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        as (:code:`A:6`) and the list of configured protocols (e=2Eg=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        :code:`flower:=
happy:power`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>   The following flags depend on which compression formats are c=
ompiled in</span><br><span>   and whether compression is allowed by options=
=2E See `Protocol options`_</span><br><span>   for more details=2E</span><b=
r><span>diff --git a/doc/man-sections/management-options=2Erst b/doc/man-se=
ctions/management-options=2Erst</span><br><span>index e2e0773=2E=2E9840eb7 =
100644</span><br><span>--- a/doc/man-sections/management-options=2Erst</spa=
n><br><span>+++ b/doc/man-sections/management-options=2Erst</span><br><span=
>@@ -144,3 +144,9 @@</span><br><span> </span><br><span> --management-up-dow=
n</span><br><span>   Report tunnel up/down events to management interface=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+--app-custom-control protocol-list<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the app custo=
m control protocols that are supported and should be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  negotiated=2E protocol-list is a list o=
f allowed protocols separated by :</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  A client will announced these protocols via the IV_ACC var=
iable and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  serv=
er will notify the client about the common protocols=2E</span><br><span>dif=
f --git a/doc/man-sections/script-options=2Erst b/doc/man-sections/script-o=
ptions=2Erst</span><br><span>index f420380f=2E=2E9c17c3b 100644</span><br><=
span>--- a/doc/man-sections/script-options=2Erst</span><br><span>+++ b/doc/=
man-sections/script-options=2Erst</span><br><span>@@ -1006,3 +1006,12 @@</s=
pan><br><span>        X509_1_L=3DBISHKEK</span><br><span>        X509_1_ST=
=3DNA</span><br><span>        X509_1_C=3DKG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+:code:`acc_protocols`</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    If ``--app-custom-control`` is configured and the client support=
s any of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pro=
tocols that server also supports, this variable contains a list of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    common protocols separat=
ed by :=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+:code:`acc_message_len`</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if :code:`acc_protoc=
ols` is set, this variable contains the maximum</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    message length for app custom protocol mess=
age=2E</span><br><span>\ No newline at end of file</span><br><span>diff --g=
it a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><spa=
n>index 4d726c4=2E=2E383fe10 100644</span><br><span>--- a/doc/management-no=
tes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>=
@@ -828,6 +828,59 @@</span><br><span> that is required to continue the conn=
ection (unlike MFA or opening a browser)</span><br><span> this message is n=
ot negotiated but can just be sent as a gratuitous message=2E</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+app custom cont=
rol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+If the special string &quot;ACC&quot; is passed as {EXT=
RA} OpenVPN will determine</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+the common app custom protocols between the client and the server an=
d instruct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the clien=
t that the server will send control messages to the client using</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+the ACC protocol=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+The server should then use acc-msg command to sen=
d app custom control messages</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+to the client to facilitate the pending authentication=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or hi=
gher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--------------=
----------------------------</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+On an Open=
VPN instance running in server mode this command sends an</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+app custom control message to a clien=
t=2E The format of the command is:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  cl=
ient-acc-msg {CID} {KID}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
{flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+CID,KID -- client ID and Key ID=2E See documentation =
for &quot;&gt;CLIENT:&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+notification for more info=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p=
rotocol -- the ACC protocol identifier that this message should be</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            tagged with=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+flags    -- a colon separated list of th=
e encoding and the flag if</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            the message is a fragment=2E E=2Eg=2E &quot;6:F&quot; fo=
r a base64 encoded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           message that is also a fragment and not complete yet=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+message  -- The message encoded in the encoding=
 specified in flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or h=
igher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-------------=
-----------------------------</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+When Open=
VPN is running in --client mode this command sends an app</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+custom command to the server=2E The f=
ormat of the command is</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+See the=
 client-acc-msg command for more details about the format of the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+message=2E Since a client has =
only one peer there is no need to specify the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+client id and key id=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+&gt;&gt;&gt;&gt;&gt;&gt;&gt; fd23ffa35a (Implement sending/recei=
ving app custom control protocol messages)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- client-deny  (OpenVPN 2=
=2E1 or higher)</span><br><span> ------------------------------------------=
-----</span><br><span> </span><br><span>@@ -1302,6 +1355,39 @@</span><br><s=
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
nforms the client about the common ACC</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   protocols and the maximum message length for an ACC m=
essage=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   In client mode:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list},=
message_len=3D{max_msg_len}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protocol=
_list is a list of supported protocols by the client=2E For example</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   flower:power:sys_info wo=
uld indicate these three protocols to be supported=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   max_msg_len specifies the maximum mess=
age length that the peer supports=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
 In server mode these are available in the acc_protocols and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+   acc_message_length variables of=
 the client environment=2E</span><br><span> </span><br><span> Variables:</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/sr=
c/openvpn/Makefile=2Eam</span><br><span>index 8a60a94=2E=2Eebc4db6 100644</=
span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/op=
envpn/Makefile=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><br><span> sbin=
_PROGRAMS =3D openvpn</span><br><span> </span><br><span> openvpn_SOURCES =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=
=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=
=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><=
span>@@ -124,7 +125,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br>=
<span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \<=
/span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec refle=
ct_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><sp=
an>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2E4297cb9</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span=
>@@ -0,0 +1,414 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
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
 40%);">+ *  with this program; if not, write to the Free Software Foundati=
on, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
yshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum ac=
c_message_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_A=
SCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_=
MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+log_acc_message(struct context *c, co=
nst struct buffer *buf, int payload_len,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                const char *protocol, int flags)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D flags &amp; ACC_MES=
SAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *payload_msg =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* For simplicity, we always encode payload to be=
 base64 encoded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * if not already in base64 format */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        char *b64out =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(openvpn_base64_encod=
e(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b64out, free, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        payload=
_msg =3D b64out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D CBSTR(buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (management)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;se=
ssion[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;opt=
ions=2Emode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* server mode=2E Report client context */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct man_def_auth_contex=
t *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            unsigned int mda_key_id =3D get_primary=
_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%=
u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              mda-&gt;cid, mda_key_id, protocol, fragment, payload_msg);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* Client mode=2E Do not a report a C=
LIENT id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payload=
_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &q=
uot;Received custom app control message (protocol &#39;%s&#39;%s)&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        protocol, frag=
ment ? &quot;, fragment&quot; : &quot;&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Parses the flags field of an app control =
message and moves the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  buffer past the flags string=2E If there is an</span><br><span style=
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
+    const char *protocol =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!proto=
col)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;=
could not extract protocol field&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int payload=
_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *payload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!payload_len_s=
tr || !((payload_len =3D atoi(payload_len_str))))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        err_reason =3D &quot;could not extract payload leng=
th field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message_fla=
gs(&amp;buf, &amp;err_reason, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (flags &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* We should have a final NUL byte in the =
control message buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * and thus the length of the buffer should be payload_len + 1 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;b=
uf) !=3D payload_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
char *tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        snprintf(tmp, 512, &quot;field length %d, pay=
load length %d mismatch&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                 payload_len, buf_len(&amp;buf) - 1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   log_acc_message(c, &amp;buf, payload_len, protocol, flags);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app cont=
rol channel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                      &quot;(%s) message control message: %s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        format_hex(BPTR(&am=
p;buf), BLEN(&amp;buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi =
*multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
     struct tls_session *session,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 const char *protocol, bool fragment,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                 const char=
 *msg, bool base64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * length of the protocol s=
tring + one &#39;,&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * 2 for the encoding (A or 6), potential F (fragment), and 1 for t=
he &#39;,&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * 4 for the message size itself and one comma</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * 1 for the comma before the message itself=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t=
 max_header_size =3D strlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + =
1 + 2 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t len =3D max_header_size + strlen(msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_CLIENT, &quot;message length (%zu) exceeds maximum pos=
sible message length (%d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if ((int)len &gt; multi-&gt;acc_max_message_length)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;header (%zu) =
+ message size (%zu) length (%zu) exceeds &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                      &quot;maximum allowed le=
ngth negotiated with peer (%d)&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            max_header_size, strlen(msg), len,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_max_=
message_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* add 1 for =
the final \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D alloc_buf_gc(len + 1, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;=
buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+               strlen(msg),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+               base64 ? &quot;6&quot; : =
&quot;A&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
          fragment ? &quot;F&quot; : &quot;&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+               msg);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    send_control_channel_string_dowork(session, BSTR(&amp;bu=
f), D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res=
chedule_multi_process(c);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   const char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     int *max_acc_len,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     bool server,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     struct gc_arena *gc=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string_all=
oc(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char *tmp_message_orig =3D tmp_message;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *token =3D strtok_r(tmp_message, delim, &amp;=
lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we allo=
w more capabilities than our own, in client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * mode we reject if we should use capabilities=
 that we do not support */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=
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
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_list_inte=
rsection(struct gc_arena *gc, const char *list1, const char *list2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *tmp =3D strdup(list1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D =
strtok_r(tmp, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* The maximum possible length is the shorter of the two input lists=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t max_l=
en =3D min_size(strlen(list1), strlen(list2));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (tls_item_in_cipher_list(token, list2))</=
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
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
free(tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n common_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct tls_multi *mul=
ti, struct tls_session *session)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!multi-&gt;opt=2Eacc_protocols)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* No app custom protocols have been configured server-side=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (multi-&gt;acc_negotiated_protocols)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* We already have determined the commo=
n protocols=2E Doing this</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * again would just add an extra string allocation to options=
-&gt;gc */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:=
power */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *peer_info =3D multi-&gt;peer_info;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *iv_acc =3D extract_var_peer_info(peer_i=
nfo, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!iv_acc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_len =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocols =3D=
 parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max_acc_len, true, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!protocols)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING:=
 IV_ACC peer info variable of peer is malformed&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer common_protocols =3D get_list_intersection(&amp;gc, sess=
ion-&gt;opt-&gt;acc_protocols, protocols);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (buf_len(&amp;common_protocols) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING: No commo=
n app custom control protocol=2E&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-=
&gt;acc_negotiated_protocols =3D string_alloc(buf_str(&amp;common_protocols=
), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-=
&gt;acc_max_message_length =3D max_acc_len;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    setenv_str(session-&gt;opt-&gt;es, &quot;acc_protocols&quot;, mult=
i-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    setenv_int(session-&gt;opt-&gt;es, &quot;acc_message_len&q=
uot;, multi-&gt;acc_max_message_length);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2E=
h</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E4=
a388f7</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=
=2Eh</span><br><span>@@ -0,0 +1,105 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copy=
right (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  This program is free software; you can redistribute it and/or modify</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the term=
s of the GNU General Public License version 2</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
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
 hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_M=
IN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * This method parses an app cus=
tom control message and delivers it to the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * management interface=2E We leave reassembly of fr=
agmented messages to the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * management interface=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram c            The context struct</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buffer       Buffer containing the control messa=
ge with ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, =
const struct buffer *buffer);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct t=
ls_multi *tls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 struct tls_session *session,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                 const char *protocol, bool frag=
ment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   const char *msg, bool base64);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Parses an info message from the serve=
r that contains app custom control info</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * information prior to the PUSH_REPLY to be able to us=
e app custom control</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * protocols before sending</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In cl=
ient mode only allow what we support ourselves=2E In server mode</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * allow also capabilities tha=
t we not support ourselves=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am capabilities      The string to parse</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param delim             The delimiter to use when =
parsing the string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                          IV_ACC uses &quot;,&quot; as delimiter while =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
            custom-control PUSH message uses &quot; &quot; as &quot;,&quot;=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
            already used to separate different push directives</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len       Set =
to the maximum ACC message length</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param server            Whether we are server or client</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc         =
       The gc arena to use for allocating the resulting string</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return                  The =
resulting protocol string or NULL on error</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_=
acc_parameters(const char *capabilities,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     const char *delim,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     int *max_acc_=
len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      bool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    struct gc_arena *gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses the=
 IV_ACC of the peer and sets multi=2Eacc_negotiated_protocols</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * to the common protocols of ser=
ver and client and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* multi=2Eacc_max_message_length  to the maximum length of the ACC message<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * support by both s=
erver and client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there is no=
 common protocol or the client does not support any app custom</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * protocol multi=2Eacc_negotiat=
ed_protocols will be set to NULL=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param multi      the multi instance to use the set the app custom protoc=
ols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ses=
sion    the session to read the client env from</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+det=
ermine_common_acc_protocols(struct tls_multi *multi, struct tls_session *se=
ssion);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Calculates the intersection of two list that=
 are both separated by :</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Items in the result will have the same ordering as in the list1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * parameters</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc            Retur=
ned buffer will be allocated in this gc</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param list1         First list to intersect</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param list2         Sec=
ond list to intersect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return A (potentially empty) buffer containing an intersection lis=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena *g=
c, const char *list1, const char *list2);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/forwa=
rd=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 681210d=2E=2E7923b5e=
 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b=
/src/openvpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span>=
 #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;auth_token=2E=
h&quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span=
><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><sp=
an> </span><br><span>@@ -257,11 +258,11 @@</span><br><span>     }</span><br=
><span>     else if (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        server_pushed_info(buf, 8);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        server_pushed_info(c, buf, 8);</span><br><span>   =
  }</span><br><span>     else if (buf_string_match_head_str(buf, &quot;INFO=
&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        server_pushed_info(buf, 4);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        server_pushed_info(c, buf, 4);</span><br>=
<span>     }</span><br><span>     else if (buf_string_match_head_str(buf, &=
quot;CR_RESPONSE&quot;))</span><br><span>     {</span><br><span>@@ -271,6 +=
272,10 @@</span><br><span>     {</span><br><span>         receive_auth_pend=
ing(c, buf);</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (buf_string_match_head_str(buf, &quot;ACC&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        receive_acc_message(c, =
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span>     else if (buf_string_match_head_str(buf, &quot;EXIT&quot;))</sp=
an><br><span>     {</span><br><span>         receive_exit_message(c);</span=
><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><=
br><span>index bd890e5=2E=2E6e119b2 100644</span><br><span>--- a/src/openvp=
n/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2=
279,6 +2279,13 @@</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_protocols)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot; cust=
om-control %d,A:6,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                   multi-&gt;acc_max_message_length, multi-&gt;acc_=
negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     if (BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {<=
/span><br><span>         msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));<=
/span><br><span>@@ -2522,6 +2529,11 @@</span><br><span>         flags |=3D =
(OPT_P_ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=
=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=
=3D OPT_P_ACC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   return flags;</span><br><span> }</span><br><span> </span><br><span>@@ -2=
730,6 +2742,17 @@</span><br><span>         frame-&gt;tun_mtu =3D min_int(fr=
ame-&gt;tun_max_mtu, c-&gt;options=2Ece=2Etun_mtu);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (found &amp; OPT_P_ACC &amp;&amp; c-&gt;options=2Epushed_acc_negotiate=
d_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_mu=
lti *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        free(multi-&gt;acc_negotiated_protocols);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_negoti=
ated_protocols =3D string_alloc(c-&gt;options=2Epushed_acc_negotiated_proto=
cols, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 multi-&gt;acc_max_message_length =3D c-&gt;options=2Epushed_acc_max_messag=
e_length;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH, &quot;OPT=
IONS IMPORT: ACC protocols: %s, msg len: %d&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_negotiated_protoco=
ls, multi-&gt;acc_max_message_length);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     return true;</span><br><span> }</span><br><span>=
 </span><br><span>@@ -3352,6 +3375,7 @@</span><br><span>     to=2Everify_ha=
sh_depth =3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everif=
y_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy=
(to=2Ex509_username_field, options-&gt;x509_username_field, sizeof(to=2Ex50=
9_username_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    to=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><span>     =
to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt=
;net_ctx;</span><br><span> </span><br><span>@@ -4306,6 +4330,24 @@</span><b=
r><span> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void=
 *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
      struct buffer_list *input) /* ownership transferred */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=
=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_m=
ulti *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;se=
ssion[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D manag=
ement_send_acc_message(c, multi, session, input);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> =
</span><br><span> void</span><br><span>@@ -4322,6 +4364,7 @@</span><br><spa=
n>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><spa=
n>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><s=
pan>         cb=2Esend_cc_message =3D management_callback_send_cc_message;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg=
 =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><=
span>         cb=2Enetwork_change =3D management_callback_network_change;</=
span><br><span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec =
b/src/openvpn/manage=2Ec</span><br><span>index ccf66b43=2E=2E86d82ba 100644=
</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/ope=
nvpn/manage=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><span> #includ=
e &quot;push=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</spa=
n><br><span> #include &quot;resolve=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </s=
pan><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &q=
uot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #=
ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span>=
<br><span>@@ -1082,6 +1084,35 @@</span><br><span>             }</span><br><=
span>             break;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallb=
ack=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(=
man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                             =
         man-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                                   =
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
><span>@@ -1206,6 +1237,29 @@</span><br><span> }</span><br><span> </span><b=
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
%, 40%);">+        if (man_need(p, 2, 0))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (str=
eq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><span>     =
    man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2978,7 +3043,=
9 @@</span><br><span>                                        &quot;bytes_se=
nt=3D&quot;,</span><br><span>                                        &quot;=
bytes_received=3D&quot;,</span><br><span>                                  =
      &quot;session_id=3D&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                       &quot;session_state=3D&qu=
ot; };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                          &quot;session_state=3D&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
&quot;acc_protocols=3D&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                       &quot;acc_message_len=3D&q=
uot; };</span><br><span> </span><br><span>     if (env_filter_level =3D=3D =
0)</span><br><span>     {</span><br><span>@@ -3133,6 +3200,7 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> manage=
ment_connection_established(struct management *man, struct man_def_auth_con=
text *mdac,</span><br><span>                                   const struct=
 env_set *es)</span><br><span>@@ -4375,6 +4443,64 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+management_send_acc_message(struct context *c, struct tls_multi *multi, =
struct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                            struct buffer_list *input)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* also ensures that are enough inputs in the=
 list to safely call</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * buffer_list_peek without extra NULL checks */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not en=
ough input lines for sending acc message, &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                      &quot;missing protocol, =
flag and/or messages lines&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct b=
uffer *proto_buf =3D buffer_list_peek(input);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *protocol =3D string_alloc(CBSTR(p=
roto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(encoding_buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *fl=
ag =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l b64encoding =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool fragment =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
hile ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
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
lor: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !tls_item_in=
_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the l=
ist of negotiated protocols: %s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            np(multi-&gt;acc_negotiated_protocols));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool ret =3D send_acc_message(c, multi, session, pro=
tocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                   fragment, buf_cstr(acc_msg_buf),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                b64encodi=
ng);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else /* if=
def ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #include &quot;=
win32=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/o=
penvpn/manage=2Eh</span><br><span>index 157039d=2E=2Ecc9c264 100644</span><=
br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/man=
age=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_=
clients)(void *arg);</span><br><span>     bool (*send_cc_message)(void *arg=
, const char *message, const char *parameter);</span><br><span>     bool (*=
kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     b=
ool (*client_auth)(void *arg, const unsigned long cid, const unsigned int m=
da_key_id,</span><br><span>                         const bool auth, const =
char *reason, const char *client_reason,</span><br><span>                  =
       struct buffer_list *cc_config); /* ownership transferred */</span><b=
r><span>     bool (*client_pending_auth)(void *arg, const unsigned long cid=
, const unsigned int kid,</span><br><span>                                 =
const char *extra, unsigned int timeout);</span><br><span>     char *(*get_=
peer_info)(void *arg, const unsigned long cid);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                           co=
nst unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           const unsigned int mda_key_id,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           struct =
buffer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    struct buffer_list *msg);</span><br><span>   =
  bool (*proxy_cmd)(void *arg, const char **p);</span><br><span>     bool (=
*remote_cmd)(void *arg, const char **p);</span><br><span> #ifdef TARGET_AND=
ROID</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     struct comm=
and_line *in;</span><br><span>     struct buffer_list *out;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF  =
     0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLI=
ENT_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define I=
EC_UNDEF          0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 =
*REMOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC=
_MSG 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_A=
CC_MSG        8</span><br><span>     int in_extra_cmd;</span><br><span>    =
 struct buffer_list *in_extra;</span><br><span>     unsigned long in_extra_=
cid;</span><br><span>@@ -503,6 +512,14 @@</span><br><span> </span><br><span=
> void man_persist_client_stats(struct management *man, struct context *c);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
** Parses the ACC message from the input buffer_list and send to the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * session identified by s=
ession and multi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_session;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message(struct c=
ontext *c, struct tls_multi *multi,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            struct tls_session *session, st=
ruct buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_MANAGEMEN=
T */</span><br><span> </span><br><span> /**</span><br><span>diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=
=2E=2E0ae503d 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><=
br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot=
;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&=
quot;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/=
</span><br><span> </span><br><span>@@ -1735,8 +1736,9 @@</span><br><span>  =
* - peer id</span><br><span>  */</span><br><span> static bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-multi_client_set_protocol_options(s=
truct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mu=
lti_client_set_protocol_options(struct multi_instance *mi)</span><br><span>=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct contex=
t *c =3D &amp;mi-&gt;context;</span><br><span>     struct tls_multi *tls_mu=
lti =3D c-&gt;c2=2Etls_multi;</span><br><span>     const char *const peer_i=
nfo =3D tls_multi-&gt;peer_info;</span><br><span>     struct options *o =3D=
 &amp;c-&gt;options;</span><br><span>@@ -2380,7 +2382,7 @@</span><br><span>=
      * peer must be added before iroutes=2E For other platforms it doesn&#=
39;t matter=2E */</span><br><span> </span><br><span>     /* authentication =
complete, calculate dynamic client specific options */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!multi_client_set_protocol_options=
(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!multi_client_set_protocol_options(mi))</span><br><span>     {</=
span><br><span>         mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state =3D=
 CAS_FAILED;</span><br><span>     }</span><br><span>@@ -4085,6 +4087,26 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+calculate_app_control_extra(struct =
multi_instance *mi, struct gc_arena *gc)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etl=
s_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotia=
ted_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIEN=
T, &quot;ACC: No negotiated protocols&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(1024, gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_=
message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
           multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return buf_str(&amp;buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static bool</span><br><span> management_client_pending_a=
uth(void *arg, const unsigned long cid, const unsigned int mda_key_id,</spa=
n><br><span>                                const char *extra, unsigned int=
 timeout)</span><br><span>@@ -4095,10 +4117,22 @@</span><br><span>     if (=
mi)</span><br><span>     {</span><br><span>         struct tls_multi *multi=
 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!strcmp(extra, &quot;ACC&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            extra =3D calculate_app_cont=
rol_extra(mi, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!extra)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span>         struct tls_session *=
session =3D lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><spa=
n> </span><br><span>         if (!session)</span><br><span>         {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;=
gc);</span><br><span>             return false;</span><br><span>         }<=
/span><br><span> </span><br><span>@@ -4106,6 +4140,7 @@</span><br><span>   =
      bool ret =3D send_auth_pending_messages(multi, session, extra, timeou=
t);</span><br><span>         reschedule_multi_process(&amp;mi-&gt;context);=
</span><br><span>         multi_schedule_context_wakeup(m, mi);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span=
><br><span>         return ret;</span><br><span>     }</span><br><span>    =
 return false;</span><br><span>@@ -4149,6 +4184,37 @@</span><br><span>     =
return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+management_client_acc_msg(void *arg,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          const unsigned long cid,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
 const unsigned int mda_key_id,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                          struct buffer_list *input) /* ownersh=
ip transferred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_con=
text *m =3D (struct multi_context *)arg;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct multi_instance *mi =3D lookup_by_cid(m, cid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_lis=
t_defined(input))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct t=
ls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *session =3D l=
ookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!session)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_CLIENT, &quot;client session not foun=
d&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D =
management_send_acc_message(&amp;mi-&gt;context, multi, session, input);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_schedule=
_context_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(input);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> static char *</span><br><span> management_=
get_peer_info(void *arg, const unsigned long cid)</span><br><span> {</span>=
<br><span>@@ -4185,6 +4251,7 @@</span><br><span>         cb=2En_clients =3D=
 management_callback_n_clients;</span><br><span>         cb=2Ekill_by_cid =
=3D management_kill_by_cid;</span><br><span>         cb=2Eclient_auth =3D m=
anagement_client_auth;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cb=2Eclient_acc_msg =3D management_client_acc_msg;</span><br><sp=
an>         cb=2Eclient_pending_auth =3D management_client_pending_auth;</s=
pan><br><span>         cb=2Eget_peer_info =3D management_get_peer_info;</sp=
an><br><span>         cb=2Epush_update_broadcast =3D management_callback_se=
nd_push_update_broadcast;</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index fb319ae=2E=2E04b553e 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> <=
/span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot=
;</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span> #includ=
e &quot;error=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</s=
pan><br><span>@@ -7107,6 +7108,41 @@</span><br><span>         VERIFY_PERMIS=
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
<span style=3D"color: hsl(120, 100%, 40%);">+        /* check if the list f=
rom the server is a real subset of our list */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer commo=
n_list =3D get_list_intersection(&amp;gc, p[3], options-&gt;acc_protocols);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (buf_len(&amp;common_list) =
=3D=3D 0 || !streq(p[3], buf_cstr(&amp;common_list)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control =
list from server contains &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                          &quot;unsupported protocols&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2], &quot;=
A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control =
encoding must be base64 and ascii&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!atoi_constrained(p[1], &amp;options-&gt;pushed_acc_max_message_leng=
th,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
              &quot;app custom message message length&quot;, ACC_MIN_MSG_LE=
N, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 options-&gt;pushed_acc_negotiated_protocols =3D p[3];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (stre=
q(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span=
>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --prng option ig=
nored (SSL library PRNG is used)&quot;);</span><br><span>diff --git a/src/o=
penvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 6a3bf61=
=2E=2Eb7945e0 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><b=
r><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -715,6 +715,18 @@<=
/span><br><span>     /* force using TLS key material export for data channe=
l key generation */</span><br><span>     bool force_key_material_export;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/** The app custom control protocols we should announce as supported */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc_pro=
tocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols that are =
negotiated with the peer=2E This is a</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     *  a temporary variable since options=2Ec push parse=
r cannot access</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 *  tls multi struct */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *pushed_acc_negotiated_protocols;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /** the maximum length of an ACC control channel message=
 via push message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int push=
ed_acc_max_message_length;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     bool vlan_tagging;</span><br><span>     enum v=
lan_acceptable_frames vlan_accept;</span><br><span>     uint16_t vlan_pvid;=
</span><br><span>@@ -764,8 +776,10 @@</span><br><span> #define OPT_P_INLINE=
          (1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUSH_MTU        (=
1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt;=
 31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_A=
CC             (1ull &lt;&lt; 32)</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | O=
PT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Options allowed in the normal configuration file (=
vs pushed options or in ccd files) */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE=
 | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </span><br><span> #define P=
ULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><span>diff --=
git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 422=
59c3=2E=2E320f89d 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><=
br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +27,8 @@</span=
><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><s=
pan> #include &quot;push=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;acc=2Eh&quot;</span><br><span> #include &quot;options=2Eh&quot;<=
/span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #include =
&quot;ssl=2Eh&quot;</span><br><span>@@ -221,9 +223,58 @@</span><br><span> #=
endif</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+parse_server_pushed_info_acc(struct context *c, struct buffe=
r *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_len =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *m=
ulti =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!multi-&gt;opt=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_PUSH_ERRORS, &quot;Server tried to push app custom control list=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              &quot;without client announcing support for it&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* example string to parse: ACC:1400 A:6 flower:happy */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip over the A=
CC: prefix */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_advance(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *protocols =3D parse_acc_parameters(buf_cstr(buf), &quot; &quot;, &am=
p;max_acc_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
check if the list from the server is a real subset of our list */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_list=
 =3D get_list_intersection(&amp;gc, protocols, multi-&gt;opt=2Eacc_protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_list) =
=3D=3D 0 || !streq(protocols, buf_cstr(&amp;common_list)))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;App custom contro=
l list from server contains &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                           &quot;unsupported protocols&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (protocols)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi-&gt;acc_negotiated_protocols =3D string_alloc(p=
rotocols, &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi-&gt;acc_max_message_length =3D max_acc_len;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (management)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC_P=
ROTOCOLS:protocols=3D%s,message_len=3D%d&quot;, protocols, max_acc_len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command with invalid par=
ameters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-server_pushed_info(const struct buffer *buffer, const int adv)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+server_pushed_info(struct cont=
ext *c, const struct buffer *buffer, const int adv)</span><br><span> {</spa=
n><br><span>     const char *m =3D &quot;&quot;;</span><br><span>     struc=
t buffer buf =3D *buffer;</span><br><span>@@ -233,6 +284,12 @@</span><br><s=
pan>         m =3D BSTR(&amp;buf);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, =
&quot;ACC:&quot;, 4) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     parse_server_pushed_info_acc(c, &amp;buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     s=
truct gc_arena gc;</span><br><span>     if (management)</span><br><span>@@ =
-285,6 +342,7 @@</span><br><span>     msg(D_PUSH, &quot;CR response was sen=
t by client (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
*</span><br><span>  * Parse the keyword for the AUTH_PENDING request</span>=
<br><span>  * @param buffer                buffer containing the keywords, =
the buffer&#39;s</span><br><span>@@ -441,7 +499,6 @@</span><br><span>     c=
onst char *const peer_info =3D tls_multi-&gt;peer_info;</span><br><span>   =
  unsigned int proto =3D extract_iv_proto(peer_info);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* =
Calculate the maximum timeout and subtract the time we already waited */</s=
pan><br><span>     unsigned int max_timeout =3D</span><br><span>         ma=
x_uint(tls_multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehan=
dshake_window);</span><br><span>@@ -732,6 +789,12 @@</span><br><span>      =
           client_max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (tls_multi-&gt;acc_negotiated_protocols)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;c=
ustom-control %d A:6 %s&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        tls_multi-&gt;acc_max_message_length, tl=
s_multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/ope=
nvpn/push=2Eh</span><br><span>index 39302f6=2E=2Eb6695bc 100644</span><br><=
span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh<=
/span><br><span>@@ -52,6 +52,7 @@</span><br><span> </span><br><span> int pr=
ocess_incoming_push_request(struct context *c);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><=
br><span>  * @brief Handles the receiving of a push-update message and appl=
ies updates to the specified</span><br><span>  * options=2E</span><br><span=
>@@ -92,7 +93,7 @@</span><br><span> </span><br><span> void receive_exit_mes=
sage(struct context *c);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void server_pushed_info(const struct buffer *buffer, c=
onst int adv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
server_pushed_info(struct context *c, const struct buffer *buffer, const in=
t adv);</span><br><span> </span><br><span> void receive_cr_response(struct =
context *c, const struct buffer *buffer);</span><br><span> </span><br><span=
>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>ind=
ex 086a6fc=2E=2Ee84d32d 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</s=
pan><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</=
span><br><span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</sp=
an><br><span> #include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #inclu=
de &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;ssl_backend=
=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><spa=
n>@@ -1279,6 +1280,7 @@</span><br><span>     free(multi-&gt;locked_cn);</sp=
an><br><span>     free(multi-&gt;locked_username);</span><br><span>     fre=
e(multi-&gt;locked_original_username);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br>=
<span> </span><br><span>     cert_hash_free(multi-&gt;locked_cert_hash_set)=
;</span><br><span> </span><br><span>@@ -2117,6 +2119,11 @@</span><br><span>=
                     }</span><br><span>                 }</span><br><span> =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (session-&=
gt;opt-&gt;acc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                buf_printf(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_=
MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span=
><br><span>     }</span><br><span> </span><br><span>@@ -2398,6 +2405,8 @@</=
span><br><span>         multi-&gt;remote_ciphername =3D string_alloc(&quot;=
none&quot;, NULL);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(=
multi, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     if (username_len &lt; 0 || password_len &lt; 0)</span><b=
r><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS Error: =
Username (%d) or password (%d) too long&quot;, abs(username_len),</span><br=
><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh=
</span><br><span>index 9a55ead=2E=2E436770b 100644</span><br><span>--- a/sr=
c/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</=
span><br><span>@@ -457,6 +457,9 @@</span><br><span>     size_t ekm_size;</s=
pan><br><span> </span><br><span>     bool dco_enabled; /**&lt; Whether keys=
 have to be installed in DCO or not */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /** The app custom control protocols we should announce as supported */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc=
_protocols;</span><br><span> };</span><br><span> </span><br><span> /** @add=
togroup control_processor</span><br><span>@@ -730,6 +733,12 @@</span><br><s=
pan>     int dco_peer_id;</span><br><span> </span><br><span>     dco_contex=
t_t *dco;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols that ar=
e negotiated with the peer=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    char *acc_negotiated_protocols;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /** the maximum length of an ACC control channel message */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int acc_max_messa=
ge_length;</span><br><span> };</span><br><span> </span><br><span> /**  gets=
 an item  of \c key_state objects in the</span><br><span>diff --git a/tests=
/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>index 43a6743=2E=2E86326af 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/=
openvpn/Makefile=2Eam</span><br><span>@@ -107,10 +107,12 @@</span><br><span=
> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@=
  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_=
ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_acc=
=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=
=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><span> 	mock_ssl_d=
ependencies=2Ec mock_win32_execve=2Ec \</span><br><span> 	$(top_srcdir)/src=
/compat/compat-strlcpy=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base6=
4=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br>=
<span>@@ -132,6 +134,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/run_c=
ommand=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_nc=
p=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><span>@@ -=
392,9 +395,11 @@</span><br><span> </span><br><span> misc_testdriver_SOURCES=
 =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedule=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management=
=2Ec mock_management=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2Eh  =
\</span><br><span> 	mock_get_random=2Ec \</span><br><span> 	$(top_srcdir)/s=
rc/compat/compat-strlcpy=2Ec \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=
=2Ec \</span><br><span>@@ -407,6 +412,7 @@</span><br><span> 	$(top_srcdir)/=
src/openvpn/siphash_reference=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/session_id=2Ec</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> push_update_msg_testdriver_CFLAGS =3D -=
I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \=
</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_t=
ests/openvpn/mock_management=2Ec</span><br><span>index fff4c2b=2E=2Ef572dbb=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</span><b=
r><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #include &quot=
;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> #include &quo=
t;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=
=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2E80dcfc2</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=
=2Eh</span><br><span>@@ -0,0 +1,29 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
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
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifndef MOCK_MANAGEMENT_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define MOCK_MANAGEMENT_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void init_mock_management(void);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void uninit_mock_management(void);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests=
/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/m=
ock_push_dependencies=2Ec</span><br><span>index bf2ccf3=2E=2Ef083f89 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</=
span><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t flags =3D OP=
T_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><sp=
an>                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_=
P_COMP | OPT_P_PERSIST</span><br><span>                      | OPT_P_MESSAG=
ES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_PEER_ID | =
OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_ID =
| OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_ACC;</s=
pan><br><span>     return flags;</span><br><span> }</span><br><span> </span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_=
tests/openvpn/test_acc=2Ec</span><br><span>new file mode 100644</span><br><=
span>index 0000000=2E=2Edb291b8</span><br><span>--- /dev/null</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,3=
32 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application t=
o securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             over a single TCP/UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    session authentication and key exchange,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet encryption, packet authentic=
ation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdar=
g=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+char control_channel_mesage_sent[2048];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Mock functions */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+send_control_channel_string_dowork(struct tls_session *session,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
             const char *str, unsigned int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_in_range(strlen(str), 0, 2048);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    memcpy(control_channel_mesage_sent, str, strlen=
(str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+send_push_reply_auth_token(struct tls_multi *multi)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+auth_set_client_reason(struct =
tls_multi *multi, const char *reason)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAE=
VAwNanUalkEDDxLBpZw9JnjI3tBM&quot;                \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;r4engpg/cDgS48D=
MaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;4md4OJwoQAwEwITAxMBwC=
zAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP=
8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFw=
AAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAw=
EDAgQCBQIGAgArA&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfO=
IV4gn/NyJ&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  &quot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_acc_parse_client_messages(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    skip();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
ensure that the messages get to mock_msg */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    x_debug_level =3D 3;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    management =3D (void *)0x12345678;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* contains a TLS 1=2E3 C=
lientHello */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char msg[] =3D &quot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer msg_buf;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Emode =3D MODE_SER=
VER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etl=
s_multi, struct tls_multi, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_mul=
ti-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
c2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=
=2Emda_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf_set_read(&amp;msg_buf, (void *)msg, sizeof(msg));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_=
buf, &quot;Received custom app control message (protocol &#39;cck1&#39;)&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PA=
YLOAD);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg[] =3D=
 &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_=
read(&amp;msg_buf, (void *)flower_msg, sizeof(flower_msg));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &am=
p;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(mock_msg_buf, &quot;Received custom app control message (pr=
otocol &#39;flower&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:A=
CC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_incorre=
ct_len[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiA=
iSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_incorrect_len, =
sizeof(msg_incorrect_len));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *error =3D &quot;WARNING:=
 Received malformed custom app control channel &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;(field leng=
th 62, payload length 64 mismatch) message &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        &quot;control message=
: 496e7367 496d316c 496a6f67 496d5a79 &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        &quot;62326369 4c434141 65=
475a6d 2f534a7[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_f=
ragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (voi=
d *)msg_fragment, sizeof(msg_fragment));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(moc=
k_msg_buf, &quot;Received custom app control message (protocol &#39;power&#=
39;, fragment)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,pow=
er,1,aGVsbG8gdw=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* check two encoding present */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char flower_msg_two_encs[] =3D &quot;ACC,flowe=
r,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_b=
uf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, =
&amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARN=
ING: Received malformed custom app control channel (number of &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;encoding=
s must be exactly one (B64=3D1, ASCII=3D1)) message control &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;message: 5=
3534268 62534141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;61475567 37372b3[=
more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &qu=
ot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no encoding present =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char fl=
ower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+=
94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof(=
flower_msg_no_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    error =3D &quot;WARNING: Received malformed custom app contro=
l channel (number of &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;encodings must be exactly one (B64=3D0, ASCII=3D0=
)) message control &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;message: 53534268 62534141 4945746c 636d3170 644344=
2f 2f534230 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, e=
rror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    x_debug_level =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    management =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_parse_acc_parameters(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* parameters to INFO m=
essage */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *info_acc_msg =3D &quot;4096 A:6 flower:happy&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int max_len =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *protocols =3D parse_acc_parameters(in=
fo_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &qu=
ot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(max_len, 1280);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* a client does not accept a length longer than it supports */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_a=
cc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(proto=
cols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* message with lower limit =
than our, should work for client and server */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1111 A:6 flower:happy=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocol=
s =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(in=
fo_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &qu=
ot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(max_len, 1111);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* more encodings than supported=2E Server should be okay, client sho=
uld fail */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info=
_acc_msg =3D &quot;1200 A:6:B flower:happy&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_a=
cc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg,=
 &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:h=
appy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(max_len, 1200);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ex=
tra parameter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 info_acc_msg =3D &quot;1400 A:6 flower:happy 77&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(=
info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc=
_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *iv_acc_capabilities =3D &quot;1400,A:6,flower:happy:pow=
er&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoc=
ols =3D parse_acc_parameters(iv_acc_capabilities, &quot;,&quot;, &amp;max_l=
en, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(protocols, &quot;flower:happy:power&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* too small protocol length */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;32 =
A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &am=
p;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* non-numerical protocol length */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:happy 77&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D pa=
rse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(p=
rotocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protoco=
l length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info=
_acc_msg =3D &quot;abff A:6 flower:happy 77&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_=
acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_common_protocols(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance=
 mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct context *c =3D &amp;mi=2Econtext;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_m=
ulti, &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&=
gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:=
6,flower:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    c-&gt;options=2Eacc_protocols =3D &quot;power:flower:star&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt=
;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;sessio=
n[TM_ACTIVE]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mul=
ti-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(multi-&gt;acc_negotiat=
ed_protocols, &quot;power:flower&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_acc_send_message(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D {=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct con=
text *c =3D &amp;mi=2Econtext;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &am=
p;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&=
gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:=
6,flower:emergency:power&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    c-&gt;options=2Eacc_protocols =3D &quot;power:flower:emerge=
ncy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    deter=
mine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_A=
CTIVE]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct tls_session *session =3D &amp;c-&gt;c2=
=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergenc=
y&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                      &quot;EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRI=
LL:&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(control_channel_mesage_sent,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        &quot;ACC,emergency,50,AF,EMERGENCY =
BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &q=
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
i] =3D (char)(&#39; &#39; + (i % 95));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* last ch=
ar of the message is a i and then a \0 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(long_message[1023], &#39;i&#39;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(long_message[1024], &#39;\0&#39;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergen=
cy&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                       long_message, false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t cc_len =3D strlen(control_channel_mesage_sent);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(control=
_channel_mesage_sent[cc_len - 1], &#39;i&#39;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *expected_start_cc =3D &quot;ACC=
,emergency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(contro=
l_channel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_list_intersection(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *empty =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *protos =3D &quot;power:flower:emergency&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer t1 =3D get_list_int=
ersection(&amp;gc, empty, protos);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1), 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer t2 =3D get_list_intersection(&amp;gc, =
protos, empty);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(buf_len(&amp;t2), 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer t3 =3D get_list_intersection(&amp;gc, protos, protos);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(buf_cstr(&amp;t3), protos);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *protos2 =3D &quot;flower:emergency:power:mario&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t4 =3D get_list_=
intersection(&amp;gc, protos2, protos);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t4), &quot;flower=
:emergency:power&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *protos3 =3D &quot;super:paper:mario:flower&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer t5 =3D get_list_interse=
ction(&amp;gc, protos2, protos3);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t5), &quot;flower:mario=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_ac=
c=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E32421fb</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP n=
etworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   over a single UDP port, with support for SSL/TLS-based</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication=
 and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             packet encryption, packet authentication, and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more deta=
ils=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_client_messages(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_parse_acc_parameter=
s(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_p=
rotocols(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_s=
end_message(void **state);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_li=
st_intersection(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>ind=
ex 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_comm=
on=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span> #define Largest=
IntegralType uintmax_t</span><br><span> #endif</span><br><span> /* redefine=
 2=2Ex API in terms of 1=2Ex API */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define CMockaValueData             LargestIntegralType</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define check_expected_uint=
         check_expected</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define expect_uint_value           expect_value</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define expect_check_data           expect_che=
ck</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define cast_ptr_to=
_cmocka_value(x) (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define CMockaValueData                       LargestIntegralType</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define check_expected_uint =
                  check_expected</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define expect_uint_value                     expect_value</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_check_da=
ta                     expect_check</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x)           (x)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_int_in_range(v=
alue, min, max)  assert_in_range((value), (min), (max))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define assert_uint_in_range(value, min=
, max) assert_in_range((value), (min), (max))</span><br><span> #endif</span=
><br><span> </span><br><span> /**</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>index aea40f0=2E=2E7405198 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>@@ -41,10 +41,34 @@</span><br><span> #includ=
e &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;=
</span><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #ifdef _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;=
</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#include &quot;test_schedule=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* extra mocks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_push_opt=
ions(struct context *c, struct options *options, struct buffer *buf,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                   uint64_=
t permission_mask, uint64_t *option_types_found,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   struct env_set *es, bool is=
_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_cont=
rol_channel_string(struct context *c, const char *str, msglvl_t msglevel)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(str);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+lookup_by_cid(struct multi_context *m, const unsigned long cid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return *(m-&gt;instances);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br=
><span> static void</span><br><span> test_compat_lzo_string(void **state)</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/u=
nit_tests/openvpn/test_ssl=2Ec</span><br><span>index 4baf8cc=2E=2E4987dd0 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6=
 +52,8 @@</span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><s=
pan> #include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock=
 function to be allowed to include win32=2Ec which is required for</span><b=
r><span>  * getting the temp directory */</span><br><span> #ifdef _WIN32</s=
pan><br><span>@@ -86,6 +88,20 @@</span><br><span> {</span><br><span>     re=
turn;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reschedule=
_multi_process(struct context *c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy dco cipher option to av=
oid linking against all the DCO</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * units */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_get_supported_ciphers(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY13=
05&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> /* generated using</span><br><span>  * openssl req -x509 -new=
key ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>@@ =
-1111,8 +1127,12 @@</span><br><span>         cmocka_unit_test(ssl_test_extr=
act_last_matching_field),</span><br><span>         cmocka_unit_test(ssl_tes=
t_reject_null_in_cert_subject),</span><br><span>         cmocka_unit_test(s=
sl_test_escape_rfc_2253_chars_in_subject),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_extract_peer_info)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract=
_peer_info),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_acc_parse_client_messages),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_parse_acc_para=
meters),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_acc_common_protocols),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_send_message),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_list_intersection)</span><br><span>     };</span><br><span> </span><b=
r><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">=
change 1858</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--yvdq/g6kkM8=--


--===============5302652622735125553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5302652622735125553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5302652622735125553==--

