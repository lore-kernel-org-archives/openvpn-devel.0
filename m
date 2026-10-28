Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AE606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=afpVphRL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=itsdYBf6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dHHUfuHh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Gq6MsaAv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=w2e7+kVxI+vDZjEjjK5hV/RQhirY+7EQV8USGDHpHjY=; b=afpVphRL0VHdVpqjdDeNbO3h90
	dYjXOTexp3hnVEYqAUoJUoke1wAdqjcR82JcUDWByspoePHJQx+o3vtDDrKnBWnIpra3fUf1XJIw4
	aaqOe7LU7yokhAhESHFnNsJu7Zo4X8XbdnNbr1SobToJg+aM7QdPLU90UQZ1PkVjGOoU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8mo-000000006zW-0Ef2;
	Wed, 28 Oct 2026 18:54:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8mn-000000006zP-104q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DoihI8wkd7601sPryiJVQLzd8SlXcgleHM9OHvRSGhk=; b=itsdYBf674/jOAlYllDuIFsY6H
 QqZuHEgXCN8ofL+QXet+gq4RIDhFWLiTtZVCaOEZ7w9S0vZ0NSehfTYWj0+E2YIk5XNQ1SXLzRuaW
 qF9rFDXA1NvtwRJ6NbMWL0fPCK1WjfhBUY4S2e+AHfnRpP3ajyXTMaU2zcqne0/IyZ1o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DoihI8wkd7601sPryiJVQLzd8SlXcgleHM9OHvRSGhk=; b=dHHUfuHhzNK9WHpT2ngKvg3lEU
 UNQe9p8fTHNwyMXEUbDkBwkxEqWmYWmZmVDdxxIES9fW1W4a2kXvglJILRSwbdTO3BUOTizolDaNC
 1t4rv6TEdmuJW9sbhjgn5AISeo1MzxUprFGZH4dR7FFcXS/yyiHPF43Oi6giK2H2hR9E=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8me-000000001Pi-2m7p for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:54:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so12738985e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793213634; x=1793818434; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DoihI8wkd7601sPryiJVQLzd8SlXcgleHM9OHvRSGhk=;
 b=Gq6MsaAvjEtVMpyUHq+5cIvXS3CwRxX/MA94d7VGNG5ABFn6+kev9GAPT+p2X1qqNp
 SEGGJozBm5H8hjrZ/Bh2nW3TMdv727jS+rElL7vjqlrs9rdHnYgl7Fus25j9k5UM2VQv
 TNghTUuCAdYs/Xh36w7fZJmgzFofSBre7UAzBqiKyZiaygTzDyJUZmvQtcF88wYa2C4I
 PGZ/r9yo/KMisj1wmyIDBdoC+FljlDrM9TVpFtg38AANw7rnfnNpDToPVdddZ/MWQfsA
 Bwe7gUtWnsozeAicE8fQCBF44zNuaFnEhoVg6UvEHtQ4ByDor4E/LPFwLkA/YkvUKFIW
 RNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793213634; x=1793818434;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DoihI8wkd7601sPryiJVQLzd8SlXcgleHM9OHvRSGhk=;
 b=N+nt+KGvLTPV8sSzSvFg/V57hZGUprFgVRT6nU0fsMPVOVaLJ1fvhswMuX2d+DxeRE
 Giaw3KRraFCgTa8OZU2makpfRBufeKotqE9IKo20CXg2GKW/91cbXUOwVqpG8G3dB93v
 0XHE1BkB/C5v0iGM7UUGnfalbacObN15ezF8Wxxi/6/uZtz1CgTHKj5w3UTyCG9HguSZ
 3/WKlB18RNx7NR4u62UxYv2/Eiav2Uq9h2URuP6tzXmr2joIrRSuQ7gfF3+0T+V1swYt
 Qlcge9gihUikBBiuRIFYE/hIcZNdGvbNxjr5uWy6b6n2mj+H2vfWOQRkroUo85VYnawE
 7vUQ==
X-Gm-Message-State: AFq9FYJ+LE6iNFyU8SCJJqvzOF3jlRoZBb0nXlx+wTa32qFTi8PUvbRq
 Yimr7SqMgh8Ltqi1OMOjKqFHxI259A2lXXiB/Kb93SNga5cpKP05MgouGO6c4/ycVK5RUHu/7MS
 vAqmLiy/TiEusgATr0wV6NsMRb42YEEL43gARpDqjsSZ/6Pdk/z0yhSdFKHLfWGDo6072
X-Gm-Gg: AYBFou35qWaV28AKwQkMpS7DcXDUfq4l4It+rpC9zfaALnbdEUhcOxZ6NE5+zbsFIOF
 ZE6Rotds3gy2NqKGD9ZkordiVnVYa72mZ3ROf9e2O5gvFpbZCSj4bcrUCFd7Mjcqu8xzTLZY0XQ
 BR9E7DEdJeEVxIibn/gQXVY0NM34a3lf9iC8R1IjD0LM7Kc1uAFMz0nAlWfnUA4xqVE1R8fUpGH
 SXVKoaIvOmfRPm8CQX3/y0jVyHwm0ltfJ2IlPg+QSxN0CzoJEYqBPCb3FXcJSXvkHnb9Qss1pHR
 t4pimGdyPX8Rrgc/uzXJTuUWYpTA9aYAQrhiPTxvVCi4gqDlqW+uw5YOgHKklxFo/Zl01Kaes5w
 QKr8vEDTy8jyh21LeaGOTeIQWqAXUL+/lRrqNgy4HTW2unOIHmBJrm2y5v//SfzFKDa02NtwcEt
 Txyz8iQdT1TZxiTVpMld9pAKoZ93LPOJKT0qsqokbmaOWh0bDhqXZ674BAaqTVWh8VLeonGBsJ7
 6g4GbxqRTcST261tpwIZLwMxWxUPCSV5UtmwAbNJIB9fUYhURgtGR0D3uFU1ys8an7edLU6j8B+
 mziUSSqq7uRHqVPlyLfHFscCLouJPnL0g2s/rjyeHeAaCWOzVq26rSR3IkKH2IO/nUdymKIz3aG
 UCrXf3tIbuaYeW4K3wUTdmqSMX41MqJ6QXQD2SLSynlSyn9MsmzQrijnXgPti7WTNmbD8Hur08h
 wBUQy1n53ntg6oPck=
X-Received: by 2002:a05:600c:4e55:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4aa876b951cmr10586595e9.9.1793213632815; 
 Wed, 28 Oct 2026 11:53:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92e104d8csm40701835e9.0.2026.10.28.11.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:53:52 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:53:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 3f0211e80590dc0a4b7a4b972877b12fc58deaed
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c8a227c62024edcfa0e6d6f3b5517fa6982becf9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM8me-000000001Pi-2m7p
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
Content-Type: multipart/mixed; boundary="===============8243902229538123437=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8243902229538123437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T2swp8555Wg="; charset=UTF-8

--T2swp8555Wg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#19)=2E

The following=
 approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojo=
caru


Change subject: Implement sending/receiving app custom control proto=
col messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Implement sending/receiving app custom control protocol messages

This al=
lows openvpn GUI/front-ends and server via management
to use the OpenVPN co=
ntrol channel to pass messages between each other
while OpenVPN handles the=
 marshalling/unmarshalling of these and
negotiate the common app custom con=
trol protocols=2E

This provides an easy to use secure channel that does no=
t depend on
the network itself to work and can also used before fully authe=
nticating
the client=2E See the management-notes=2Etxt for more details how=
 to use
this feature=2E An upcoming patch will also add some example python=

script that showcase this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795=
b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMa=
keLists=2Etxt
M doc/man-sections/client-options=2Erst
M doc/man-sections/ma=
nagement-options=2Erst
M doc/man-sections/script-options=2Erst
M doc/manage=
ment-notes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/op=
envpn/acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvp=
n/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn=
/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn=
/push=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_t=
ests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
M=
 tests/unit_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/ope=
nvpn/test_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_test=
s/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec
26 files =
changed, 1,518 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/58/1858/19

diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt
index 184a95a=2E=2E13bd1f0 100644
--- a/CMakeList=
s=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,6 +435,8 @@
     src/compat/compat-s=
trlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_=
r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/ar=
gv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -571,8 +573=
,8 @@
     src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/openvpn/push=
=2Ec
-    src/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
+    src/open=
vpn/push_util=2Ec
     src/openvpn/pushlist=2Eh
     src/openvpn/reflect_fi=
lter=2Ec
     src/openvpn/reflect_filter=2Eh
@@ -826,7 +828,10 @@
         =
    tests/unit_tests/openvpn/mock_management=2Ec
             tests/unit_te=
sts/openvpn/mock_ssl_dependencies=2Ec
             tests/unit_tests/openvpn=
/mock_win32_execve=2Ec
+            tests/unit_tests/openvpn/test_acc=2Ec
+=
            src/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
+        =
    src/openvpn/auth_token=2Ec
             src/openvpn/base64=2Ec
        =
     src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=
=2Ec
@@ -840,8 +845,11 @@
             src/openvpn/options_util=2Ec
       =
      src/openvpn/otime=2Ec
             src/openvpn/packet_id=2Ec
+       =
     src/openvpn/reliable=2Ec
+            src/openvpn/session_id=2Ec
     =
        src/openvpn/run_command=2Ec
             src/openvpn/ssl_mbedtls=2E=
c
+            src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_openssl=
=2Ec
             src/openvpn/ssl_util=2Ec
             src/openvpn/ssl_ver=
ify_mbedtls=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/doc/ma=
n-sections/client-options=2Erst
index 87c138a=2E=2Eb204d6a 100644
--- a/doc=
/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=2E=
rst
@@ -12,6 +12,17 @@
   When this option is set, OpenVPN will not drop in=
coming tun packets with
   same destination as host=2E
 
+--app-custom-cont=
rol protocollist
+  Sets the list of supported app custom control protocols=
=2E
+  These protocols are announced to the server when this option is used=

+  as a client=2E If the option is set on a server it will negotiate the
+=
  common protocols with the client=2E
+
+  The protocollist is a : separate=
d list of protocol identifiers=2E
+
+  See management-notes=2Etxt in the Op=
enVPN distribution and the OpenVPN RFC
+  draft for a description of app cu=
stom control protocol support=2E
+
 --auth-token token
   This is not an op=
tion to be used directly in any configuration files,
   but rather push thi=
s option from a ``--client-connect`` script or a
@@ -437,6 +448,12 @@
     =
    Additional authentication methods supported by the client=2E
         T=
his may be set by the client UI/GUI using ``--setenv``=2E
 
+  :code:`IV_AC=
C=3D<max_msg_len>,<flags>,<protocols>`
+        If the option ``--app-custo=
m-control`` is set, the client will
+        send the supported max ACC mes=
sage length, the supported formats
+        as (:code:`A:6`) and the list o=
f configured protocols (e=2Eg=2E
+        :code:`flower:happy:power`)
+
   =
The following flags depend on which compression formats are compiled in
   =
and whether compression is allowed by options=2E See `Protocol options`_
  =
 for more details=2E
diff --git a/doc/man-sections/management-options=2Erst=
 b/doc/man-sections/management-options=2Erst
index 2c79d05=2E=2Ea7f7ead 100=
644
--- a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sections/=
management-options=2Erst
@@ -144,3 +144,9 @@
 
 --management-up-down
   Rep=
ort tunnel up/down events to management interface=2E
+
+--app-custom-contro=
l protocol-list
+  Sets the app custom control protocols that are supported=
 and should be
+  negotiated=2E protocol-list is a list of allowed protocol=
s separated by :
+  A client will announce these protocols via the IV_ACC v=
ariable and the
+  server will notify the client about the common protocols=
=2E
diff --git a/doc/man-sections/script-options=2Erst b/doc/man-sections/s=
cript-options=2Erst
index f420380f=2E=2E9c17c3b 100644
--- a/doc/man-sectio=
ns/script-options=2Erst
+++ b/doc/man-sections/script-options=2Erst
@@ -100=
6,3 +1006,12 @@
        X509_1_L=3DBISHKEK
        X509_1_ST=3DNA
        X=
509_1_C=3DKG
+
+:code:`acc_protocols`
+    If ``--app-custom-control`` is c=
onfigured and the client supports any of the
+    protocols that server als=
o supports, this variable contains a list of
+    common protocols separate=
d by :=2E
+
+:code:`acc_message_len`
+    if :code:`acc_protocols` is set, =
this variable contains the maximum
+    message length for app custom proto=
col message=2E
\ No newline at end of file
diff --git a/doc/management-note=
s=2Etxt b/doc/management-notes=2Etxt
index 4d726c4=2E=2E1a7de8c 100644
--- =
a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -828,6 +82=
8,58 @@
 that is required to continue the connection (unlike MFA or opening=
 a browser)
 this message is not negotiated but can just be sent as a gratu=
itous message=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed as {EXTRA} Ope=
nVPN will determine
+the common app custom protocols between the client and=
 the server and instruct
+the client that the server will send control mess=
ages to the client using
+the ACC protocol=2E
+
+The server should then use=
 client-acc-msg command to send app custom
+control messages to the client =
to facilitate the pending authentication=2E
+
+COMMAND -- client-acc-msg (O=
penVPN 2=2E8 or higher)
+-------------------------------------------------
=
+
+On an OpenVPN instance running in server mode this command sends an
+app=
 custom control message to a client=2E The format of the command is:
+
+  c=
lient-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
+C=
ID,KID -- client ID and Key ID=2E See documentation for ">CLIENT:"
+notific=
ation for more info=2E
+
+protocol -- the ACC protocol identifier that this=
 message should be
+            tagged with=2E
+
+flags    -- a colon separ=
ated list of the encoding and the flag if
+            the message is a fra=
gment=2E E=2Eg=2E "6:F" for a base64 encoded
+            message that is a=
lso a fragment and not complete yet=2E
+
+message  -- The message encoded i=
n the encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or=
 higher)
+------------------------------------------
+
+When OpenVPN is run=
ning in --client mode this command sends an app
+custom command to the serv=
er=2E The format of the command is
+
+  acc-msg
+  {protocol}
+  {flags}
+ =
 {message}
+  END
+
+See the client-acc-msg command for more details about =
the format of the
+message=2E Since a client has only one peer there is no =
need to specify the
+client id and key id=2E
+
+
 COMMAND -- client-deny  (=
OpenVPN 2=2E1 or higher)
 -----------------------------------------------
 =

@@ -1302,6 +1354,47 @@
    response=2E Mechanisms that need multiple round=
s or more complex answers
    should implement a different response type th=
an CR_RESPONSE=2E
 
+(6) App custom control message
+
+    This message is =
an application specific payload message that is transported
+    over the O=
penVPN control channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{=
KID},{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:=
{protocol},{fragment},{msg_base64}
+
+    The protocol is a short ascii str=
ing identifying the app specific custom
+    protocol=2E If fragment is set=
 to 1, the message is not complete and the
+    next message should be conc=
atenated to this message to form a complete
+    message=2E
+
+    Note tha=
t the OpenVPN implementation operates here with the robustness
+    princip=
le ("be conservative in what you send, be liberal in what you
+    accept" =
- RFC 793 and others) and allows receiving messages longer than
+    maximu=
m allowed message length=2E Implementations should be prepared to
+    hand=
le messages that are longer than the maximum allowed message length=2E
+
+
=
+(7) App custom control protocol message
+
+   This message informs the cli=
ent about the common ACC
+   protocols and the maximum message length for a=
n ACC message=2E
+
+   In client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{pr=
otocol_list},message_len=3D{max_msg_len}
+
+   protocol_list is the list of=
 supported protocols by both server and client=2E
+   For example flower:po=
wer:sys_info would indicate these three protocols
+   arne supported=2E max=
_msg_len specifies the maximum message length that the
+   peer supports=2E=

+
+   In server mode these information are available in the acc_protocols =
and
+   acc_message_len variables of the client environment=2E
 
 Variables=
:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
inde=
x 8a60a94=2E=2Eebc4db6 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/ope=
nvpn/Makefile=2Eam
@@ -45,6 +45,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_=
SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec au=
th_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -124,7 +125,8 @@
 	proto=2Ec pr=
oto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2E=
c push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 	ref=
lect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --g=
it a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 100644
index 0=
000000=2E=2E2ab87e2
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,438 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based
+ *   =
          session authentication and key exchange,
+ *             packet e=
ncryption, packet authentication, and
+ *             packet compression=2E=

+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyrig=
ht (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is =
free software; you can redistribute it and/or modify
+ *  it under the term=
s of the GNU General Public License version 2
+ *  as published by the Free=
 Software Foundation=2E
+ *
+ *  This program is distributed in the hope th=
at it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impli=
ed warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You s=
hould have received a copy of the GNU General Public License along
+ *  wit=
h this program; if not, write to the Free Software Foundation, Inc=2E,
+ * =
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifd=
ef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+=

+#include <string=2Eh>
+#include "buffer=2Eh"
+#include "error=2Eh"
+#incl=
ude "acc=2Eh"
+#include "forward=2Eh"
+#include "options_util=2Eh"
+#includ=
e "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+#include "multi=2Eh"
+
+enum acc_=
message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_=
BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+=
log_acc_message(struct context *c, const struct buffer *buf, int payload_le=
n,
+                const char *protocol, int flags)
+{
+    bool fragment =
=3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    stru=
ct gc_arena gc =3D gc_new();
+    const char *payload_msg =3D NULL;
+
+    =
/* For simplicity, we always encode payload to be base64 encoded
+     * if=
 not already in base64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
=
+    {
+        char *b64out =3D NULL;
+        ASSERT(openvpn_base64_encod=
e(CBPTR(buf), payload_len, &b64out) >=3D 0);
+        gc_addspecial(b64out,=
 free, &gc);
+        payload_msg =3D b64out;
+    }
+    else
+    {
+    =
    payload_msg =3D CBSTR(buf);
+    }
+
+    if (management)
+    {
+     =
   struct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
=
+
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+        {
+          =
  /* server mode=2E Report client context */
+            struct man_def_au=
th_context *mda =3D session->opt->mda_context;
+            unsigned int md=
a_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_id;
+            m=
sg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_=
key_id, protocol, fragment, payload_msg);
+        }
+        else
+       =
 {
+            /* Client mode=2E Do not a report a CLIENT id */
+         =
   msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payload_msg);
+      =
  }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    ms=
g(D_PUSH, "Received custom app control message (protocol '%s'%s)",
+       =
 protocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses the flags=
 field of an app control message and moves the
+ *  buffer past the flags s=
tring=2E If there is an
+ *  error parsing the flags field the method retur=
ns -1 and
+ *  puts the error reason in err_reason
+ */
+static int
+parse_=
acc_message_flags(struct buffer *buf, const char **err_reason, struct gc_ar=
ena *gc)
+{
+    const char *flags =3D buf_extract_field(buf, ',', gc);
+
+=
    if (!flags)
+    {
+        *err_reason =3D "could not extract flags fi=
eld";
+        return -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    for (=
const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+        if (*f=
lag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_AS=
CII;
+        }
+        else if (*flag =3D=3D '6')
+        {
+           =
 acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (*fla=
g =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAG=
MENT;
+        }
+        else
+        {
+            *err_reason =3D "Unk=
nown flag in flags";
+            return -1;
+        }
+    }
+    /* The =
message should be encoded with exactly one encoding=2E Ensure that
+     * =
only one of the flags is present */
+    bool asciienc =3D (bool)(acc_flags=
 & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_flags & ACC=
_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+    {
+   =
     char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "numb=
er of encodings must be exactly one "
+                           "(B64=3D%=
d, ASCII=3D%d)",
+                 base64enc, asciienc);
+        *err_reas=
on =3D tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
+
+
+voi=
d
+receive_acc_message(struct context *c, const struct buffer *buffer)
+{
+=
    struct gc_arena gc =3D gc_new();
+    const char *err_reason =3D "";
+
=
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    struct bu=
ffer buf =3D *buffer;
+
+    const struct tls_multi *multi =3D c->c2=2Etls_=
multi;
+    if (!multi->acc_negotiated_protocols)
+    {
+        err_reaso=
n =3D "ACC not enabled or no negotiated protocols";
+        goto err;
+   =
 }
+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf) !=3D '=
,')
+    {
+        err_reason =3D "missing , after ACC";
+        goto err=
;
+    }
+
+    /* extract protocol, payload length, flags substrings */
+ =
   const char *protocol =3D buf_extract_field(&buf, ',', &gc);
+    if (!pr=
otocol)
+    {
+        err_reason =3D "could not extract protocol field";
=
+        goto err;
+    }
+
+    if (!tls_item_in_cipher_list(protocol, mul=
ti->acc_negotiated_protocols))
+    {
+        struct buffer msg_buf =3D al=
loc_buf_gc(1024, &gc);
+        buf_printf(&msg_buf, "protocol '%s' not in =
list of negotiated protocols '%s'",
+                   protocol, multi->ac=
c_negotiated_protocols);
+        err_reason =3D buf_cstr(&msg_buf);
+
+
+ =
       goto err;
+    }
+
+    /* We do not check the length here=2E We mak=
e no promises to support
+     * anything larger than our announced message=
 length but according to
+     * the robustness principle
+     * ("be cons=
ervative in what you send, be liberal in what you accept" - RFC 793 and oth=
ers)
+     * we accept also longer messages */
+
+    int payload_len;
+   =
 const char *payload_len_str =3D buf_extract_field(&buf, ',', &gc);
+    if=
 (!payload_len_str || !((payload_len =3D atoi(payload_len_str))))
+    {
+ =
       err_reason =3D "could not extract payload length field";
+        go=
to err;
+    }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_reas=
on, &gc);
+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* =
We should have a final NUL byte in the control message buffer
+     * and t=
hus the length of the buffer should be payload_len + 1 */
+    if (buf_len(=
&buf) !=3D payload_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1,=
 &gc);
+        snprintf(tmp, 512, "field length %d, payload length %d mism=
atch",
+                 payload_len, buf_len(&buf) - 1);
+        err_reas=
on =3D tmp;
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf, pay=
load_len, protocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    ms=
g(D_PUSH_ERRORS, "WARNING: Received malformed custom app control channel "
=
+                       "message (%s): %s",
+        err_reason,
+        f=
ormat_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+    gc_free(&gc);
+}
+
+=

+bool
+send_acc_message(struct context *c,
+                 struct tls_mu=
lti *multi,
+                 struct tls_session *session,
+               =
  const char *protocol, bool fragment,
+                 const char *msg, b=
ool base64)
+{
+    /*
+     * length of the protocol string + one ','
+   =
  * 2 for the encoding (A or 6), potential F (fragment), and 1 for the ',',=

+     * 4 for the message size itself and one comma
+     * 1 for the comm=
a before the message itself */
+    const size_t max_header_size =3D strlen=
("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_he=
ader_size + strlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    {
+   =
     msg(M_CLIENT, "message length (%zu) exceeds maximum possible message l=
ength (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+    }
+
+ =
   if ((int)len > multi->acc_max_message_length)
+    {
+        msg(M_CLIE=
NT, "header (%zu) + message size (%zu) length (%zu) exceeds "
+            =
          "maximum allowed length negotiated with peer (%d)",
+            =
max_header_size, strlen(msg), len,
+            multi->acc_max_message_leng=
th);
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_new();
=
+    /* add 1 for the final \0 */
+    struct buffer buf =3D alloc_buf_gc(l=
en + 1, &gc);
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy *=
/
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+               str=
len(msg),
+               base64 ? "6" : "A",
+               fragment ? "F=
" : "",
+               msg);
+
+    send_control_channel_string_dowork(ses=
sion, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
+    gc_free(&=
gc);
+    return true;
+}
+
+char *
+parse_acc_parameters(const char *capab=
ilities,
+                     const char *delim,
+                     int=
 *max_acc_len,
+                     bool server,
+                     str=
uct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc(capabilities, =
NULL);
+    char *tmp_message_orig =3D tmp_message;
+    char *lasts =3D NU=
LL;
+
+    const char *token =3D strtok_r(tmp_message, delim, &lasts);
+
+ =
   int p =3D 0;
+    int acclen =3D 0;
+    const char *protocols =3D NULL;=

+    char *ret =3D NULL;
+
+    /* In server mode we allow more capabiliti=
es than our own, in client
+     * mode we reject if we should use capabili=
ties that we do not support */
+    int allowed_acc_len =3D server ? INT_MA=
X : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if (p =3D=3D 0 &&=
 !atoi_constrained(token, &acclen, "ACC message length", ACC_MIN_MSG_LEN, a=
llowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto done;
+       =
 }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A", token) || !t=
ls_item_in_cipher_list("6", token)))
+        {
+            msg(D_PUSH_ERR=
ORS, "App custom control encoding must include base64 and ascii");
+       =
     goto done;
+        }
+
+        if (p =3D=3D 1 && !server && strcmp(t=
oken, "A:6") && strcmp(token, "6:A"))
+        {
+            msg(D_PUSH_ER=
RORS, "App custom control encoding must exactly base64 and ascii");
+      =
      goto done;
+        }
+
+        if (p =3D=3D 2)
+        {
+        =
    protocols =3D token;
+        }
+
+        if (p =3D=3D 3)
+        {
+=
            msg(D_PUSH_ERRORS, "Too many parameters for INFO ACC message/IV=
_ACC=2E");
+            goto done;
+        }
+
+        token =3D strtok_r=
(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc_len =3D min_int=
(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(protocols, gc);
+
+don=
e:
+    free(tmp_message_orig);
+    return ret;
+}
+
+struct buffer
+get_l=
ist_intersection(struct gc_arena *gc, const char *list1, const char *list2)=

+{
+    char *tmp =3D string_alloc(list1, NULL);
+    char *lasts =3D NULL=
;
+    const char *token =3D strtok_r(tmp, ":", &lasts);
+
+    /* The maxi=
mum possible length is the shorter of the two input lists */
+    size_t ma=
x_len =3D min_size(strlen(list1), strlen(list2));
+
+    struct buffer comm=
on_protocols =3D alloc_buf_gc(max_len + 1, gc);
+
+    while (token)
+    {=

+        /* check for every items is in both lists and not already in the
=
+         * common list */
+        if (tls_item_in_cipher_list(token, list=
2)
+            && !tls_item_in_cipher_list(token, buf_cstr(&common_protoco=
ls)))
+        {
+            if (buf_len(&common_protocols) > 0)
+        =
    {
+                buf_write_u8(&common_protocols, ':');
+            }=

+            buf_printf(&common_protocols, "%s", token);
+        }
+     =
   token =3D strtok_r(NULL, ":", &lasts);
+    }
+    free(tmp);
+    retur=
n common_protocols;
+}
+
+void
+determine_common_acc_protocols(struct tls_m=
ulti *multi, struct tls_session *session)
+{
+    if (!multi->opt=2Eacc_pro=
tocols)
+    {
+        /* No app custom protocols have been configured ser=
ver-side=2E */
+        return;
+    }
+
+    if (multi->acc_negotiated_pro=
tocols)
+    {
+        /* We already have determined the common protocols=
=2E */
+        return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+ =
   /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    const char *pe=
er_info =3D multi->peer_info;
+    const char *iv_acc =3D extract_var_peer_=
info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+        gc_fre=
e(&gc);
+        return;
+    }
+
+    int max_acc_len =3D 0;
+    const ch=
ar *protocols =3D parse_acc_parameters(iv_acc, ",", &max_acc_len, true, &gc=
);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+        msg(D_PUSH=
_ERRORS, "WARNING: IV_ACC peer info variable of peer is malformed");
+     =
   return;
+    }
+
+    struct buffer common_protocols =3D get_list_inters=
ection(&gc, multi->opt=2Eacc_protocols, protocols);
+
+    if (buf_len(&com=
mon_protocols) =3D=3D 0)
+    {
+        msg(D_PUSH_DEBUG, "WARNING: No com=
mon app custom control protocol=2E");
+        gc_free(&gc);
+        retur=
n;
+    }
+
+    multi->acc_negotiated_protocols =3D string_alloc(buf_str(&=
common_protocols), NULL);
+    multi->acc_max_message_length =3D max_acc_le=
n;
+
+    setenv_str(session->opt->es, "acc_protocols", multi->acc_negotiat=
ed_protocols);
+    setenv_int(session->opt->es, "acc_message_len", multi->=
acc_max_message_length);
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/a=
cc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 0000000=2E=2E4a388f=
7
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,105 @@
+/*
+ *  OpenVP=
N -- An application to securely tunnel IP networks
+ *             over a s=
ingle TCP/UDP port, with support for SSL/TLS-based
+ *             session =
authentication and key exchange,
+ *             packet encryption, packet =
authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrigh=
t (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne S=
chwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you=
 can redistribute it and/or modify
+ *  it under the terms of the GNU Gener=
al Public License version 2
+ *  as published by the Free Software Foundati=
on=2E
+ *
+ *  This program is distributed in the hope that it will be usef=
ul,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU =
General Public License for more details=2E
+ *
+ *  You should have receive=
d a copy of the GNU General Public License along
+ *  with this program; if=
 not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Stree=
t, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#define=
 ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC=
_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom control messa=
ge and delivers it to the
+ * management interface=2E We leave reassembly o=
f fragmented messages to the
+ * management interface=2E
+ *
+ * @param c  =
          The context struct
+ * @param buffer       Buffer containing the =
control message with ACC
+ */
+void
+receive_acc_message(struct context *c,=
 const struct buffer *buffer);
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
+                 const char *msg, bool base64);
+
+
+/**
+ * Parses an i=
nfo message from the server that contains app custom control info
+ * infor=
mation prior to the PUSH_REPLY to be able to use app custom control
+ * pro=
tocols before sending
+ *
+ * In client mode only allow what we support our=
selves=2E In server mode
+ * allow also capabilities that we not support ou=
rselves=2E
+ *
+ * @param capabilities      The string to parse
+ * @param =
delim             The delimiter to use when parsing the string=2E
+ *      =
                    IV_ACC uses "," as delimiter while the
+ *             =
             custom-control PUSH message uses " " as "," is
+ *            =
              already used to separate different push directives
+ * @param=
 max_acc_len       Set to the maximum ACC message length
+ * @param server =
           Whether we are server or client
+ * @param gc                The=
 gc arena to use for allocating the resulting string
+ * @return           =
       The resulting protocol string or NULL on error
+ */
+char *
+parse_a=
cc_parameters(const char *capabilities,
+                     const char *d=
elim,
+                     int *max_acc_len,
+                     bool se=
rver,
+                     struct gc_arena *gc);
+
+/**
+ * Parses the IV_=
ACC of the peer and sets multi=2Eacc_negotiated_protocols
+ * to the common=
 protocols of server and client and
+ * multi=2Eacc_max_message_length  to =
the maximum length of the ACC message
+ * support by both server and client=
=2E
+ *
+ * If there is no common protocol or the client does not support a=
ny app custom
+ * protocol multi=2Eacc_negotiated_protocols will be set to =
NULL=2E
+ *
+ * @param multi      the multi instance to use the set the app=
 custom protocols=2E
+ * @param session    the session to read the client e=
nv from
+ */
+void
+determine_common_acc_protocols(struct tls_multi *multi,=
 struct tls_session *session);
+
+/**
+ * Calculates the intersection of tw=
o list that are both separated by :
+ * Items in the result will have the s=
ame ordering as in the list1
+ * parameters
+ * @param gc            Return=
ed buffer will be allocated in this gc
+ * @param list1         First list =
to intersect
+ * @param list2         Second list to intersect=2E
+ * @retu=
rn A (potentially empty) buffer containing an intersection list
+ */
+struc=
t buffer
+get_list_intersection(struct gc_arena *gc, const char *list1, con=
st char *list2);
+#endif
diff --git a/src/openvpn/forward=2Ec b/src/openvpn=
/forward=2Ec
index 681210d=2E=2E7923b5e 100644
--- a/src/openvpn/forward=2E=
c
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #inc=
lude "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #in=
clude "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
     }
     else if (buf_string_=
match_head_str(buf, "INFO_PRE"))
     {
-        server_pushed_info(buf, 8)=
;
+        server_pushed_info(c, buf, 8);
     }
     else if (buf_string_m=
atch_head_str(buf, "INFO"))
     {
-        server_pushed_info(buf, 4);
+  =
      server_pushed_info(c, buf, 4);
     }
     else if (buf_string_match_=
head_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @@
     {
         r=
eceive_auth_pending(c, buf);
     }
+    else if (buf_string_match_head_str=
(buf, "ACC"))
+    {
+        receive_acc_message(c, buf);
+    }
     else=
 if (buf_string_match_head_str(buf, "EXIT"))
     {
         receive_exit_m=
essage(c);
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 1=
b8b2a5=2E=2Efe1582b 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/ini=
t=2Ec
@@ -2279,6 +2279,13 @@
         }
     }
 
+    struct tls_multi *mul=
ti =3D c->c2=2Etls_multi;
+    if (multi && multi->acc_negotiated_protocols=
)
+    {
+        buf_printf(&out, " custom-control %d A:6 %s",
+          =
         multi->acc_max_message_length, multi->acc_negotiated_protocols);
+=
    }
+
     if (BLENZ(&out) > strlen(header))
     {
         msg(D_HANDSH=
AKE, "%s", BSTR(&out));
@@ -2522,6 +2529,11 @@
         flags |=3D (OPT_P_R=
OUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+    {=

+        flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -2730,6=
 +2742,17 @@
         frame->tun_mtu =3D min_int(frame->tun_max_mtu, c->opt=
ions=2Ece=2Etun_mtu);
     }
 
+    if (found & OPT_P_ACC && c->options=2Ep=
ushed_acc_negotiated_protocols)
+    {
+        struct tls_multi *multi =3D=
 c->c2=2Etls_multi;
+        free(multi->acc_negotiated_protocols);
+      =
  multi->acc_negotiated_protocols =3D string_alloc(c->options=2Epushed_acc_=
negotiated_protocols, NULL);
+        multi->acc_max_message_length =3D c->=
options=2Epushed_acc_max_message_length;
+
+        msg(D_PUSH, "OPTIONS IM=
PORT: ACC protocols: %s, msg len: %d",
+            multi->acc_negotiated_p=
rotocols, multi->acc_max_message_length);
+    }
+
     return true;
 }
 
@=
@ -3352,6 +3375,7 @@
     to=2Everify_hash_depth =3D options->verify_hash_d=
epth;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;
     memc=
py(to=2Ex509_username_field, options->x509_username_field, sizeof(to=2Ex509=
_username_field));
+    to=2Eacc_protocols =3D options->acc_protocols;
    =
 to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,6 +4=
330,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+management_=
acc_msg(void *arg,
+                   struct buffer_list *input) /* owners=
hip transferred */
+{
+    struct context *c =3D arg;
+
+    bool ret =3D f=
alse;
+    if (buffer_list_defined(input) && c->c2=2Etls_multi)
+    {
+   =
     struct tls_multi *multi =3D c->c2=2Etls_multi;
+        struct tls_ses=
sion *session =3D &multi->session[TM_ACTIVE];
+
+        ret =3D management=
_send_acc_message(c, multi, session, input);
+    }
+
+    buffer_list_free=
(input);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
=
@@ -4322,6 +4364,7 @@
         cb=2Eproxy_cmd =3D management_callback_proxy=
_cmd;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
        =
 cb=2Esend_cc_message =3D management_callback_send_cc_message;
+        cb=
=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enet=
work_change =3D management_callback_network_change;
 #endif
diff --git a/sr=
c/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ac3d4b7=2E=2E5e4e416 10=
0644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45,9 +45=
,11 @@
 #include "push=2Eh"
 #include "multi=2Eh"
 #include "resolve=2Eh"
+=
#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 #include "run_command=2Eh"
+#i=
nclude "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -108=
1,6 +1083,35 @@
             }
             break;
 
+        case IEC_CLIE=
NT_ACC_MSG:
+            if (man->persist=2Ecallback=2Eclient_acc_msg)
+   =
         {
+                bool status =3D (*man->persist=2Ecallback=2Ecli=
ent_acc_msg)(man->persist=2Ecallback=2Earg,
+                              =
                                        man->connection=2Ein_extra_cid,
+  =
                                                                    man->co=
nnection=2Ein_extra_kid,
+                                                 =
                     man->connection=2Ein_extra);
+                man->con=
nection=2Ein_extra =3D NULL;
+                report_command_status(status,=
 "client-acc-msg");
+            }
+            else
+            {
+      =
          man_command_unsupported("client-acc-msg");
+            }
+      =
      break;
+
+        case IEC_ACC_MSG:
+            if (man->persist=2Ec=
allback=2Eacc_msg)
+            {
+                bool status =3D (*man->p=
ersist=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+              =
                                                 man->connection=2Ein_extra=
);
+                man->connection=2Ein_extra =3D NULL;
+                r=
eport_command_status(status, "acc-msg");
+            }
+            else
+=
            {
+                man_command_unsupported("acc-msg");
+       =
     }
+            break;
         case IEC_PK_SIGN:
             man->con=
nection=2Eext_key_state =3D EKS_READY;
             buffer_list_free(man->c=
onnection=2Eext_key_input);
@@ -1205,6 +1236,29 @@
 }
 
 static void
+man_c=
lient_acc_msg(struct management *man, const char *cid_str,
+               =
    const char *kid_str)
+{
+    struct man_connection *mc =3D &man->connec=
tion;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
+    if (pa=
rse_cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_str, "KID", =
&mc->in_extra_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG=
;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void
+man_acc_m=
sg(struct management *man)
+{
+    struct man_connection *mc =3D &man->conn=
ection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER_=
NEW);
+}
+
+static void
 man_client_auth(struct management *man, const char=
 *cid_str, const char *kid_str, const bool extra)
 {
     struct man_connec=
tion *mc =3D &man->connection;
@@ -1759,6 +1813,17 @@
             man_clie=
nt_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
+    else i=
f (streq(p[0], "client-acc-msg"))
+    {
+        if (man_need(p, 2, 0))
+ =
       {
+            man_client_acc_msg(man, p[1], p[2]);
+        }
+    =
}
+    else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_msg(man);
+=
    }
     else if (streq(p[0], "rsa-sig"))
     {
         man_pk_sig(man,=
 "rsa-sig");
@@ -2975,7 +3040,9 @@
                                        =
"bytes_sent=3D",
                                        "bytes_received=3D=
",
                                        "session_id=3D",
-              =
                         "session_state=3D" };
+                           =
            "session_state=3D",
+                                       "ac=
c_protocols=3D",
+                                       "acc_message_len=
=3D" };
 
     if (env_filter_level =3D=3D 0)
     {
@@ -3130,6 +3197,7 @@
=
     }
 }
 
+
 void
 management_connection_established(struct management *m=
an, struct man_def_auth_context *mdac,
                                   c=
onst struct env_set *es)
@@ -4372,6 +4440,64 @@
     }
 }
 
+bool
+manageme=
nt_send_acc_message(struct context *c, struct tls_multi *multi, struct tls_=
session *session,
+                            struct buffer_list *input)
+=
{
+    /* also ensures that are enough inputs in the list to safely call
+ =
    * buffer_list_peek without extra NULL checks */
+    if (!input || inpu=
t->size < 3)
+    {
+        msg(M_CLIENT, "not enough input lines for send=
ing acc message, "
+                      "missing protocol, flag and/or me=
ssages lines");
+        return false;
+    }
+
+    struct gc_arena gc =3D=
 gc_new();
+
+    const struct buffer *proto_buf =3D buffer_list_peek(input=
);
+    const char *protocol =3D string_alloc(CBSTR(proto_buf), &gc);
+    =
buffer_list_pop(input);
+
+    struct buffer *encoding_buf =3D buffer_list_=
peek(input);
+    char *encoding =3D buf_str(encoding_buf);
+    const char=
 *flag =3D NULL;
+    bool b64encoding =3D false;
+    bool fragment =3D fa=
lse;
+
+    while ((flag =3D strsep(&encoding, ":")))
+    {
+        if (!=
strcmp(flag, "6"))
+        {
+            b64encoding =3D true;
+        }=

+        else if (!strcmp(flag, "F"))
+        {
+            fragment =3D=
 true;
+        }
+    }
+    buffer_list_pop(input);
+
+    buffer_list_ag=
gregate_separator(input, 10000, "");
+    const struct buffer *acc_msg_buf =
=3D buffer_list_peek(input);
+
+    if (!multi->acc_negotiated_protocols
+ =
       || !tls_item_in_cipher_list(protocol, multi->acc_negotiated_protocol=
s))
+    {
+        msg(M_CLIENT, "protocol not in the list of negotiated p=
rotocols: %s",
+            np(multi->acc_negotiated_protocols));
+        =
goto error;
+    }
+
+    bool ret =3D send_acc_message(c, multi, session, =
protocol,
+                                fragment, buf_cstr(acc_msg_buf),=

+                                b64encoding);
+    gc_free(&gc);
+    ret=
urn ret;
+error:
+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef E=
NABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff --git a/src/openvpn/manage=
=2Eh b/src/openvpn/manage=2Eh
index 157039d=2E=2Ecc9c264 100644
--- a/src/o=
penvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     i=
nt (*n_clients)(void *arg);
     bool (*send_cc_message)(void *arg, const c=
har *message, const char *parameter);
     bool (*kill_by_cid)(void *arg, c=
onst unsigned long cid, const char *kill_msg);
+
     bool (*client_auth)(v=
oid *arg, const unsigned long cid, const unsigned int mda_key_id,
         =
                const bool auth, const char *reason, const char *client_rea=
son,
                         struct buffer_list *cc_config); /* ownership =
transferred */
     bool (*client_pending_auth)(void *arg, const unsigned l=
ong cid, const unsigned int kid,
                                 const cha=
r *extra, unsigned int timeout);
     char *(*get_peer_info)(void *arg, con=
st unsigned long cid);
+    bool (*client_acc_msg)(void *arg,
+            =
               const unsigned long cid,
+                           const u=
nsigned int mda_key_id,
+                           struct buffer_list *msg=
);
+    bool (*acc_msg)(void *arg,
+                    struct buffer_list =
*msg);
     bool (*proxy_cmd)(void *arg, const char **p);
     bool (*remot=
e_cmd)(void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,1=
5 @@
     struct command_line *in;
     struct buffer_list *out;
 
-#define=
 IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0=

+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATU=
RE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_P=
K_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#def=
ine IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWOR=
D       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     =
int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_=
extra_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(struct man=
agement *man, struct context *c);
 
+/** Parses the ACC message from the in=
put buffer_list and send to the
+ * session identified by session and multi=

+ */
+struct tls_session;
+struct tls_multi;
+bool
+management_send_acc_me=
ssage(struct context *c, struct tls_multi *multi,
+                        =
    struct tls_session *session, struct buffer_list *input);
 #endif /* ifd=
ef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec
index e302a81=2E=2Ea3eb3ca 100644
--- a/src/openvpn/multi=2E=
c
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include "ssl_util=2Eh"
 #=
include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#include "acc=2Eh"
 
 /*#=
define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +4086,26 @@
     }
 }
 
+stati=
c const char *
+calculate_app_control_extra(struct multi_instance *mi, stru=
ct gc_arena *gc)
+{
+    struct context *c =3D &mi->context;
+    struct tl=
s_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->acc_negotiated_pro=
tocols)
+    {
+        msg(M_CLIENT, "ACC: No negotiated protocols");
+   =
     return NULL;
+    }
+
+    struct buffer buf =3D alloc_buf_gc(1024, gc=
);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi->acc_max_message_length,
=
+               multi->acc_negotiated_protocols);
+    return buf_str(&buf)=
;
+}
+
+
 static bool
 management_client_pending_auth(void *arg, const unsi=
gned long cid, const unsigned int mda_key_id,
                             =
   const char *extra, unsigned int timeout)
@@ -4095,10 +4116,22 @@
     if=
 (mi)
     {
         struct tls_multi *multi =3D mi->context=2Ec2=2Etls_mu=
lti;
+
+        struct gc_arena gc =3D gc_new();
+        if (!strcmp(extra=
, "ACC"))
+        {
+            extra =3D calculate_app_control_extra(mi,=
 &gc);
+            if (!extra)
+            {
+                gc_free(&gc=
);
+                return false;
+            }
+        }
         struct=
 tls_session *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
=
 
         if (!session)
         {
+            gc_free(&gc);
            =
 return false;
         }
 
@@ -4106,6 +4139,7 @@
         bool ret =3D sen=
d_auth_pending_messages(multi, session, extra, timeout);
         reschedul=
e_multi_process(&mi->context);
         multi_schedule_context_wakeup(m, mi=
);
+        gc_free(&gc);
         return ret;
     }
     return false;
@@=
 -4149,6 +4183,37 @@
     return ret;
 }
 
+
+static bool
+management_clien=
t_acc_msg(void *arg,
+                          const unsigned long cid,
+ =
                         const unsigned int mda_key_id,
+                  =
        struct buffer_list *input) /* ownership transferred */
+{
+    stru=
ct multi_context *m =3D (struct multi_context *)arg;
+    struct multi_inst=
ance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+    if (mi =
&& buffer_list_defined(input))
+    {
+        struct tls_multi *multi =3D =
mi->context=2Ec2=2Etls_multi;
+        struct tls_session *session =3D look=
up_session_by_mda_key_id(multi, mda_key_id);
+        if (!session)
+      =
  {
+            msg(M_CLIENT, "client session not found");
+            bu=
ffer_list_free(input);
+            return false;
+        }
+
+        ret=
 =3D management_send_acc_message(&mi->context, multi, session, input);
+   =
     multi_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(i=
nput);
+    return ret;
+}
+
+
 static char *
 management_get_peer_info(voi=
d *arg, const unsigned long cid)
 {
@@ -4185,6 +4250,7 @@
         cb=2En_c=
lients =3D management_callback_n_clients;
         cb=2Ekill_by_cid =3D man=
agement_kill_by_cid;
         cb=2Eclient_auth =3D management_client_auth;
=
+        cb=2Eclient_acc_msg =3D management_client_acc_msg;
         cb=2Ec=
lient_pending_auth =3D management_client_pending_auth;
         cb=2Eget_pe=
er_info =3D management_get_peer_info;
         cb=2Epush_update_broadcast =
=3D management_callback_send_push_update_broadcast;
diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec
index fb319ae=2E=2Ebb854da 100644
-=
-- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @=
@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #=
include "error=2Eh"
 #include "common=2Eh"
@@ -7107,6 +7108,41 @@
         =
VERIFY_PERMISSION(OPT_P_GENERAL);
         options->force_key_material_expo=
rt =3D true;
     }
+    else if (streq(p[0], "app-custom-control") && p[1]=
 && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        optio=
ns->acc_protocols =3D p[1];
+    }
+    else if (streq(p[0], "custom-contro=
l") && p[1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT=
_P_ACC);
+
+        /* check if the list from the server is a real subset o=
f our list */
+        struct gc_arena gc_local =3D gc_new();
+        stru=
ct buffer common_list =3D get_list_intersection(&gc_local, p[3], options->a=
cc_protocols);
+
+        if (buf_len(&common_list) =3D=3D 0 || !streq(p[3]=
, buf_cstr(&common_list)))
+        {
+            msg(msglevel, "App custo=
m control list from server contains "
+                          "unsupport=
ed protocols");
+            gc_free(&gc_local);
+            goto err;
+  =
      }
+        gc_free(&gc_local);
+
+        if (!streq(p[2], "A:6") && =
!streq(p[2], "6:A"))
+        {
+            msg(msglevel, "App custom cont=
rol encoding must be base64 and ascii");
+            goto err;
+        }
=
+
+        if (!atoi_constrained(p[1], &options->pushed_acc_max_message_len=
gth,
+                              "app custom message message length", AC=
C_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        {
+            goto err=
;
+        }
+        options->pushed_acc_negotiated_protocols =3D p[3];
+ =
   }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         ms=
g(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is used)");
diff=
 --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 6a3bf61=2E=
=2Eb7945e0 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=
=2Eh
@@ -715,6 +715,18 @@
     /* force using TLS key material export for d=
ata channel key generation */
     bool force_key_material_export;
 
+    /=
** The app custom control protocols we should announce as supported */
+   =
 const char *acc_protocols;
+
+    /** the protocols that are negotiated wi=
th the peer=2E This is a
+     *  a temporary variable since options=2Ec pu=
sh parser cannot access
+     *  tls multi struct */
+    const char *pushe=
d_acc_negotiated_protocols;
+
+    /** the maximum length of an ACC control=
 channel message via push message
+     * */
+    int pushed_acc_max_messag=
e_length;
+
     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_a=
ccept;
     uint16_t vlan_pvid;
@@ -764,8 +776,10 @@
 #define OPT_P_INLINE =
         (1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_=
P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
=
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID =
| 0x0ull))
+/* Options allowed in the normal configuration file (vs pushed =
options or in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_=
P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((op=
t)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index =
42259c3=2E=2E8f3bf81 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/pu=
sh=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh"
+
+=
#include "acc=2Eh"
 #include "options=2Eh"
 #include "crypto=2Eh"
 #include=
 "ssl=2Eh"
@@ -221,9 +223,61 @@
 #endif
 }
 
+static void
+parse_server_pus=
hed_info_acc(struct context *c, struct buffer *buf)
+{
+    int max_acc_len=
 =3D 0;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (mult=
i->acc_negotiated_protocols)
+    {
+        return;
+    }
+
+    if (!mul=
ti->opt=2Eacc_protocols)
+    {
+        msg(D_PUSH_ERRORS, "Server tried t=
o push app custom control list "
+                           "without clien=
t announcing support for it");
+        return;
+    }
+
+    /* example st=
ring to parse: ACC:1400 A:6 flower:happy */
+    /* Skip over the ACC: pref=
ix */
+    buf_advance(buf, 4);
+
+    struct gc_arena gc =3D gc_new();
+  =
  const char *protocols =3D parse_acc_parameters(buf_cstr(buf), " ", &max_a=
cc_len, false, &gc);
+    if (!protocols)
+    {
+        msg(D_PUSH_ERRORS=
, "WARNING: Received ACC info command with invalid parameters");
+        g=
c_free(&gc);
+        return;
+    }
+
+    /* check if the list from the s=
erver is a real subset of our list */
+    struct buffer common_list =3D ge=
t_list_intersection(&gc, protocols, multi->opt=2Eacc_protocols);
+
+    if =
(buf_len(&common_list) =3D=3D 0 || !streq(protocols, buf_cstr(&common_list)=
))
+    {
+        msg(D_PUSH_ERRORS, "App custom control list from server =
contains "
+                           "unsupported protocols");
+        g=
c_free(&gc);
+        return;
+    }
+
+    multi->acc_negotiated_protocols=
 =3D string_alloc(protocols, NULL);
+    multi->acc_max_message_length =3D =
max_acc_len;
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+     =
   msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d", protocol=
s, max_acc_len);
+    }
+#endif
+}
 
 void
-server_pushed_info(const struct=
 buffer *buffer, const int adv)
+server_pushed_info(struct context *c, cons=
t struct buffer *buffer, const int adv)
 {
     const char *m =3D "";
     =
struct buffer buf =3D *buffer;
@@ -233,6 +287,12 @@
         m =3D BSTR(&bu=
f);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        parse=
_server_pushed_info_acc(c, &buf);
+        return;
+    }
+
 #ifdef ENABLE_=
MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ -285,6 +345,7 @=
@
     msg(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
+
 /**=

  * Parse the keyword for the AUTH_PENDING request
  * @param buffer      =
          buffer containing the keywords, the buffer's
@@ -441,7 +502,6 @@
=
     const char *const peer_info =3D tls_multi->peer_info;
     unsigned in=
t proto =3D extract_iv_proto(peer_info);
 
-
     /* Calculate the maximum =
timeout and subtract the time we already waited */
     unsigned int max_ti=
meout =3D
         max_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_m=
ulti->opt=2Ehandshake_window);
@@ -732,6 +792,12 @@
                 client=
_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
     }
+
+    if (t=
ls_multi->acc_negotiated_protocols)
+    {
+        push_option_fmt(gc, pus=
h_list, M_USAGE, "custom-control %d A:6 %s",
+                        tls_m=
ulti->acc_max_message_length, tls_multi->acc_negotiated_protocols);
+    }
=
 }
 
 static bool
diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
=
index 39302f6=2E=2Eb6695bc 100644
--- a/src/openvpn/push=2Eh
+++ b/src/open=
vpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_incoming_push_request(struct =
context *c);
 
+
 /**
  * @brief Handles the receiving of a push-update mes=
sage and applies updates to the specified
  * options=2E
@@ -92,7 +93,7 @@
=
 
 void receive_exit_message(struct context *c);
 
-void server_pushed_info=
(const struct buffer *buffer, const int adv);
+void server_pushed_info(stru=
ct context *c, const struct buffer *buffer, const int adv);
 
 void receive=
_cr_response(struct context *c, const struct buffer *buffer);
 
diff --git =
a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6fc=2E=2E139b11d 1006=
44
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
=
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #incl=
ude "ssl_verify=2Eh"
 #include "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@=
 -1279,6 +1280,7 @@
     free(multi->locked_cn);
     free(multi->locked_us=
ername);
     free(multi->locked_original_username);
+    free(multi->acc_n=
egotiated_protocols);
 
     cert_hash_free(multi->locked_cert_hash_set);
 =

@@ -2098,6 +2100,11 @@
 #endif
         }
 
+        if (session->opt->acc=
_protocols)
+        {
+            buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n"=
, ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+        }
+
         if (=
session->opt->push_peer_info_detail > 1)
         {
             struct env=
_set *es =3D session->opt->es;
@@ -2117,6 +2124,8 @@
                     }=

                 }
             }
+
+
         }
     }
 
@@ -2398,6 +2407=
,8 @@
         multi->remote_ciphername =3D string_alloc("none", NULL);
   =
  }
 
+    determine_common_acc_protocols(multi, session);
+
     if (usern=
ame_len < 0 || password_len < 0)
     {
         msg(D_TLS_ERRORS, "TLS Err=
or: Username (%d) or password (%d) too long", abs(username_len),
diff --git=
 a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9a55ead=2E=
=2E436770b 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_co=
mmon=2Eh
@@ -457,6 +457,9 @@
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
@@ -730,6 +733,1=
2 @@
     int dco_peer_id;
 
     dco_context_t *dco;
+
+    /** the protoc=
ols that are negotiated with the peer=2E */
+    char *acc_negotiated_proto=
cols;
+
+    /** the maximum length of an ACC control channel message */
+ =
   int acc_max_message_length;
 };
 
 /**  gets an item  of \c key_state ob=
jects in the
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/un=
it_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2Ef827a4c 100644
--- a/test=
s/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TE=
ST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=
=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_commo=
n=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_exec=
ve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/sr=
c/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/=
src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -132,6=
 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+=
	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_ut=
il=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdi=
r)/src/openvpn/ssl_verify_openssl=2Ec \
@@ -392,9 +395,11 @@
 
 misc_testdr=
iver_SOURCES =3D test_misc=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
+	=
mock_management=2Ec \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=
=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/=
openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdi=
r)/src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec =
\
@@ -407,6 +412,7 @@
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
 =
	$(top_srcdir)/src/openvpn/session_id=2Ec
 
+
 push_update_msg_testdriver_C=
FLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I=
$(top_srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/open=
vpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
inde=
x fff4c2b=2E=2Ef572dbb 100644
--- a/tests/unit_tests/openvpn/mock_managemen=
t=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
=
 
 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 =

 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests/openvpn/mock_push_=
dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
inde=
x bf2ccf3=2E=2Ef083f89 100644
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
=2Edde1ad8
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,=
0 +1,358 @@
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
+#include "multi=2Eh"
+
+char control_channel_messa=
ge_sent[2048];
+
+/* Mock functions */
+bool
+send_control_channel_string_d=
owork(struct tls_session *session,
+                                   cons=
t char *str, unsigned int msglevel)
+{
+    assert_int_in_range(strlen(str)=
, 0, 2047);
+
+    strcpy(control_channel_message_sent, str);
+    return t=
rue;
+}
+
+void
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
=
+
+void
+auth_set_client_reason(struct tls_multi *multi, const char *reason=
)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"   =
             \
+                    "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z=
/notFT0cF1d60nTS" \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqM=
yqwCvALwCewCTAKABrwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8=
BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMB=
BAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoIC=
wgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAA=
IBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwity=
P9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_messages(void **state)
+{=

+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    /* ensure that the mes=
sages get to mock_msg */
+    x_debug_level =3D 3;
+    management =3D (voi=
d *)0x12345678;
+    struct gc_arena gc =3D gc_new();
+
+    /* contains a =
TLS 1=2E3 ClientHello */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PA=
YLOAD;
+
+    struct buffer msg_buf;
+    struct context c =3D { 0 };
+    =
c=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_=
multi, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE=
]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_A=
CTIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg=
_buf, (void *)msg, sizeof(msg));
+
+    receive_acc_message(&c, &msg_buf);
=
+    assert_string_equal(mock_msg_buf, "WARNING: Received malformed custom =
app control channel message (ACC not enabled or no negotiated protocols): 4=
143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=
=2E=2E=2E]");
+    assert_string_equal(mock_managment_buf, "");
+
+    c=2E=
c2=2Etls_multi->acc_negotiated_protocols =3D "no:common:protocol";
+    rec=
eive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WAR=
NING: Received malformed custom app control channel message (protocol 'cck1=
' not in list of negotiated protocols 'no:common:protocol'): 4143432c 63636=
b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]");
=
+    assert_string_equal(mock_managment_buf, "");
+
+    c=2Ec2=2Etls_multi=
->acc_negotiated_protocols =3D "cck1:flower:power:fortune";
+    receive_ac=
c_message(&c, &msg_buf);
+
+    assert_string_equal(mock_msg_buf, "Received=
 custom app control message (protocol 'cck1')");
+    assert_string_equal(m=
ock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD);
+
+    const cha=
r flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJ=
vZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_msg, sizeof(flow=
er_msg));
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(=
mock_msg_buf, "Received custom app control message (protocol 'flower')");
+=
    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,flower,0,SSBhb=
SAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+    CLEAR(mock_managm=
ent_buf);
+    const char msg_incorrect_len[] =3D "ACC,fortune,62,6,InsgIm1=
lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D";
+    buf_se=
t_read(&msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));
+  =
  receive_acc_message(&c, &msg_buf);
+    const char *error =3D "WARNING: R=
eceived malformed custom app control channel "
+                        "me=
ssage (field length 62, payload length 64 mismatch): "
+                   =
     "4143432c 666f7274 756e652c 36322c36 2c496e73 67496d31 "
+            =
            "6c496a6f 67496d5[more=2E=2E=2E]";
+
+    assert_string_equal(m=
ock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+ =
   CLEAR(mock_managment_buf);
+    const char msg_fragment[] =3D "ACC,power=
,12,6F,aGVsbG8gdw=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_fragment,=
 sizeof(msg_fragment));
+    receive_acc_message(&c, &msg_buf);
+    assert=
_string_equal(mock_msg_buf, "Received custom app control message (protocol =
'power', fragment)");
+    assert_string_equal(mock_managment_buf, ">CLIENT=
:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+   =
 /* check two encoding present */
+    const char flower_msg_two_encs[] =3D=
 "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+=
    buf_set_read(&msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_t=
wo_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNIN=
G: Received malformed custom app control channel message "
+            "(n=
umber of encodings must be exactly one (B64=3D1, ASCII=3D1)): "
+          =
  "4143432c 666c6f77 65722c34 382c3641 2c535342 68625341 41494574 "
+      =
      "6c636d3[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, er=
ror);
+    assert_string_equal(mock_managment_buf, "");
+
+    /* no encodi=
ng present */
+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBh=
bSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_b=
uf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_a=
cc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed cus=
tom app control channel message "
+            "(number of encodings must b=
e exactly one (B64=3D0, ASCII=3D0)): "
+            "4143432c 666c6f77 6572=
2c34 382c2c53 53426862 53414149 45746c63 "
+            "6d31706[more=2E=2E=
=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_string_eq=
ual(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    management =
=3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_parameters(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* parameters t=
o INFO message */
+    const char *info_acc_msg =3D "4096 A:6 flower:happy"=
;
+
+    int max_len =3D 0;
+    const char *protocols =3D parse_acc_parame=
ters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(prot=
ocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a c=
lient does not accept a length longer than it supports */
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
c_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* no=
n-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flower:happy=
";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, tru=
e, &gc);
+    assert_null(protocols);
+
+    /* extra parameter */
+    inf=
o_acc_msg =3D "1400 A:6 flower:happy 77";
+    protocols =3D parse_acc_para=
meters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols)=
;
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protocols(void **state)
=
+{
+    struct multi_instance mi =3D { 0 };
+    struct context *c =3D &mi=
=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c-=
>c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+
+    c->c2=2Etls_mu=
lti->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";=

+    c->options=2Eacc_protocols =3D "power:flower:star";
+    struct tls_m=
ulti *multi =3D c->c2=2Etls_multi;
+    multi->opt=2Eacc_protocols =3D c->o=
ptions=2Eacc_protocols;
+    multi->session[TM_ACTIVE]=2Eopt =3D &multi->op=
t;
+    multi->opt=2Ees =3D env_set_create(&c->options=2Egc);
+
+    determ=
ine_common_acc_protocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
=
+    assert_int_equal(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+   =
 assert_string_equal(multi->acc_negotiated_protocols, "power:flower");
+
+ =
   assert_string_equal(env_set_get(multi->opt=2Ees, "acc_protocols"), "acc_=
protocols=3Dpower:flower");
+    assert_string_equal(env_set_get(multi->opt=
=2Ees, "acc_message_len"), "acc_message_len=3D1280");
+
+    free(multi->ac=
c_negotiated_protocols);
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_a=
cc_send_message(void **state)
+{
+    struct multi_instance mi =3D { 0 };
+=
    struct context *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();=

+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=
=2Egc);
+    bool ret;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
=
+    c->options=2Eacc_protocols =3D "power:flower:emergency";
+    multi->o=
pt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+    multi->session[TM_A=
CTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D env_set_create(&c->o=
ptions=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_=
ACC=3D1400,A:6,flower:emergency:power";
+    determine_common_acc_protocols=
(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    struct tls_session =
*session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+    ret =3D send_ac=
c_message(c, c->c2=2Etls_multi, session, "emergency", true,
+              =
             "EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
=
+
+    assert_true(ret);
+    assert_string_equal(control_channel_message_s=
ent,
+                        "ACC,emergency,50,AF,EMERGENCY BROADCAST MESS=
AGE - THIS IS NOT A DRILL:");
+
+    ret =3D send_acc_message(c, c->c2=2Etl=
s_multi, session, "emergency", false,
+                           "THE GOVE=
RNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    =
assert_true(ret);
+    assert_string_equal(control_channel_message_sent,
+ =
                       "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAIN=
BOW COLOURED ALERT FOR YOUR AREA=2E");
+
+
+    /* test a long message (> 1=
000) with fragment to get the maximum header size */
+    char long_message=
[1200] =3D { 0 };
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+        l=
ong_message[i] =3D (char)(' ' + (i % 95));
+    }
+
+    /* last char of th=
e message is a i and then a \0 */
+    assert_int_equal(long_message[1023],=
 'i');
+    assert_int_equal(long_message[1024], '\0');
+
+    ret =3D send=
_acc_message(c, c->c2=2Etls_multi, session, "emergency", true,
+           =
                long_message, false);
+
+    assert_true(ret);
+    size_t =
cc_len =3D strlen(control_channel_message_sent);
+    assert_int_equal(cont=
rol_channel_message_sent[cc_len - 1], 'i');
+    const char *expected_start=
_cc =3D "ACC,emergency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memo=
ry_equal(control_channel_message_sent, expected_start_cc, strlen(expected_s=
tart_cc));
+
+    free(multi->acc_negotiated_protocols);
+    gc_free(&c->o=
ptions=2Egc);
+}
+
+void
+test_list_intersection(void **state)
+{
+    cons=
t char *empty =3D "";
+    const char *protos =3D "power:flower:emergency";=

+
+    struct gc_arena gc =3D gc_new();
+
+    struct buffer t1 =3D get_li=
st_intersection(&gc, empty, protos);
+    assert_int_equal(buf_len(&t1), 0)=
;
+
+    struct buffer t2 =3D get_list_intersection(&gc, protos, empty);
+ =
   assert_int_equal(buf_len(&t2), 0);
+
+    struct buffer t3 =3D get_list_=
intersection(&gc, protos, protos);
+    assert_string_equal(buf_cstr(&t3), =
protos);
+
+    const char *protos2 =3D "flower:emergency:power:mario";
+  =
  struct buffer t4 =3D get_list_intersection(&gc, protos2, protos);
+    as=
sert_string_equal(buf_cstr(&t4), "flower:emergency:power");
+
+    const ch=
ar *protos3 =3D "super:paper:mario:flower";
+    struct buffer t5 =3D get_l=
ist_intersection(&gc, protos2, protos3);
+    assert_string_equal(buf_cstr(=
&t5), "flower:mario");
+
+    const char *proto4 =3D "flower:flower:flower:=
flower";
+    struct buffer t6 =3D get_list_intersection(&gc, proto4, "flow=
er");
+    assert_string_equal(buf_cstr(&t6), "flower");
+
+
+    gc_free(&=
gc);
+}
diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tes=
ts/openvpn/test_acc=2Eh
new file mode 100644
index 0000000=2E=2E32421fb
---=
 /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*=

+ *  OpenVPN -- An application to securely tunnel IP networks
+ *         =
    over a single UDP port, with support for SSL/TLS-based
+ *             =
session authentication and key exchange,
+ *             packet encryption,=
 packet authentication, and
+ *             packet compression=2E
+ *
+ *  =
Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This pro=
gram is free software; you can redistribute it and/or modify
+ *  it under =
the terms of the GNU General Public License version 2
+ *  as published by =
the Free Software Foundation=2E
+ *
+ *  This program is distributed in the=
 hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ =
*  You should have received a copy of the GNU General Public License along
=
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
=
+ */
+
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+void test_acc_parse_clien=
t_messages(void **state);
+
+void test_parse_acc_parameters(void **state);
=
+
+void test_acc_common_protocols(void **state);
+
+void test_acc_send_mess=
age(void **state);
+
+void test_list_intersection(void **state);
+#endif
di=
ff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/open=
vpn/test_common=2Eh
index 8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_test=
s/openvpn/test_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@=
 -43,11 +43,13 @@
 #define LargestIntegralType uintmax_t
 #endif
 /* redefi=
ne 2=2Ex API in terms of 1=2Ex API */
-#define CMockaValueData             =
LargestIntegralType
-#define check_expected_uint         check_expected
-#d=
efine expect_uint_value           expect_value
-#define expect_check_data  =
         expect_check
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMo=
ckaValueData                       LargestIntegralType
+#define check_expec=
ted_uint                   check_expected
+#define expect_uint_value       =
              expect_value
+#define expect_check_data                     e=
xpect_check
+#define cast_ptr_to_cmocka_value(x)           (x)
+#define ass=
ert_int_in_range(value, min, max)  assert_in_range((value), (min), (max))
+=
#define assert_uint_in_range(value, min, max) assert_in_range((value), (min=
), (max))
 #endif
 
 /**
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec=
 b/tests/unit_tests/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2E4987dd0 100644
=
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/=
test_ssl=2Ec
@@ -52,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvp=
n=2Eh"
 
+#include "test_acc=2Eh"
+
 /* Mock function to be allowed to incl=
ude win32=2Ec which is required for
  * getting the temp directory */
 #ifd=
ef _WIN32
@@ -86,6 +88,20 @@
 {
     return;
 }
+void
+reschedule_multi_pro=
cess(struct context *c)
+{
+}
+
+/* Define a dummy dco cipher option to avo=
id linking against all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const=
 char *
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-GCM:AES-12=
8-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generate=
d using
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384=
r1 -keyout - \
@@ -1111,8 +1127,12 @@
         cmocka_unit_test(ssl_test_ex=
tract_last_matching_field),
         cmocka_unit_test(ssl_test_reject_null_=
in_cert_subject),
         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_=
in_subject),
-        cmocka_unit_test(ssl_test_extract_peer_info)
-
+     =
   cmocka_unit_test(ssl_test_extract_peer_info),
+        cmocka_unit_test(=
test_acc_parse_client_messages),
+        cmocka_unit_test(test_parse_acc_p=
arameters),
+        cmocka_unit_test(test_acc_common_protocols),
+        =
cmocka_unit_test(test_acc_send_message),
+        cmocka_unit_test(test_lis=
t_intersection)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a=
6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 19
Gerrit-Owner: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>

--T2swp8555Wg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #19</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vie=
w Change</a></p><p>The following approvals got outdated and were removed:
C=
ode-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Implement sending/rec=
eiving app custom control protocol messages<br><br>This allows openvpn GUI/=
front-ends and server via management<br>to use the OpenVPN control channel =
to pass messages between each other<br>while OpenVPN handles the marshallin=
g/unmarshalling of these and<br>negotiate the common app custom control pro=
tocols=2E<br><br>This provides an easy to use secure channel that does not =
depend on<br>the network itself to work and can also used before fully auth=
enticating<br>the client=2E See the management-notes=2Etxt for more details=
 how to use<br>this feature=2E An upcoming patch will also add some example=
 python<br>script that showcase this feature=2E<br><br>Change-Id: I4a6a6ef4=
1e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/client-o=
ptions=2Erst<br>M doc/man-sections/management-options=2Erst<br>M doc/man-se=
ctions/script-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/openvp=
n/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M src/=
openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<b=
r>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/opti=
ons=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/ope=
nvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M=
 tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_=
management=2Ec<br>M tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>=
A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests/openvpn/test_=
acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/unit_tests=
/openvpn/test_ssl=2Ec<br>26 files changed, 1,518 insertions(+), 23 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/58/1858/19</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CM=
akeLists=2Etxt</span><br><span>index 184a95a=2E=2E13bd1f0 100644</span><br>=
<span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><=
br><span>@@ -435,6 +435,8 @@</span><br><span>     src/compat/compat-strlcpy=
=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span><br><span>    =
 src/compat/compat-strtok_r=2Ec</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     src/openvpn/ar=
gv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><span>     src/o=
penvpn/base64=2Ec</span><br><span>@@ -571,8 +573,8 @@</span><br><span>     =
src/openvpn/ps=2Ec</span><br><span>     src/openvpn/ps=2Eh</span><br><span>=
     src/openvpn/push=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    src/openvpn/push_util=2Ec</span><br><span>     src/openvpn/push=2Eh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pus=
h_util=2Ec</span><br><span>     src/openvpn/pushlist=2Eh</span><br><span>  =
   src/openvpn/reflect_filter=2Ec</span><br><span>     src/openvpn/reflect_=
filter=2Eh</span><br><span>@@ -826,7 +828,10 @@</span><br><span>           =
  tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>            =
 tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>       =
      tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/test=
_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 src/openvpn/acc=2Ec</span><br><span>             src/openvpn/argv=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/=
auth_token=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><b=
r><span>             src/openvpn/crypto_epoch=2Ec</span><br><span>         =
    src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -840,8 +845,11 @@</sp=
an><br><span>             src/openvpn/options_util=2Ec</span><br><span>    =
         src/openvpn/otime=2Ec</span><br><span>             src/openvpn/pac=
ket_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   src/openvpn/reliable=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            src/openvpn/session_id=2Ec</span><br><span>            =
 src/openvpn/run_command=2Ec</span><br><span>             src/openvpn/ssl_m=
bedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   src/openvpn/ssl_ncp=2Ec</span><br><span>             src/openvpn/ssl_ope=
nssl=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec</span><br><s=
pan>             src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>diff --=
git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-optio=
ns=2Erst</span><br><span>index 87c138a=2E=2Eb204d6a 100644</span><br><span>=
--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-s=
ections/client-options=2Erst</span><br><span>@@ -12,6 +12,17 @@</span><br><=
span>   When this option is set, OpenVPN will not drop incoming tun packets=
 with</span><br><span>   same destination as host=2E</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-custom-control pro=
tocollist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the=
 list of supported app custom control protocols=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  These protocols are announced to the serve=
r when this option is used</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  as a client=2E If the option is set on a server it will negotiate =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  common protoco=
ls with the client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The protocollis=
t is a : separated list of protocol identifiers=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  See management-notes=2Etxt in the OpenVPN distribution and th=
e OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  draf=
t for a description of app custom control protocol support=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --auth-token to=
ken</span><br><span>   This is not an option to be used directly in any con=
figuration files,</span><br><span>   but rather push this option from a ``-=
-client-connect`` script or a</span><br><span>@@ -437,6 +448,12 @@</span><b=
r><span>         Additional authentication methods supported by the client=
=2E</span><br><span>         This may be set by the client UI/GUI using ``-=
-setenv``=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags&gt;,&lt;protocol=
s&gt;`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        If th=
e option ``--app-custom-control`` is set, the client will</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        send the supported max ACC me=
ssage length, the supported formats</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        as (:code:`A:6`) and the list of configured protoco=
ls (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 :code:`flower:happy:power`)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>   The following flags depend on which compressio=
n formats are compiled in</span><br><span>   and whether compression is all=
owed by options=2E See `Protocol options`_</span><br><span>   for more deta=
ils=2E</span><br><span>diff --git a/doc/man-sections/management-options=2Er=
st b/doc/man-sections/management-options=2Erst</span><br><span>index 2c79d0=
5=2E=2Ea7f7ead 100644</span><br><span>--- a/doc/man-sections/management-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/management-options=2Erst<=
/span><br><span>@@ -144,3 +144,9 @@</span><br><span> </span><br><span> --ma=
nagement-up-down</span><br><span>   Report tunnel up/down events to managem=
ent interface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-custom-control p=
rotocol-list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets =
the app custom control protocols that are supported and should be</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  negotiated=2E protocol-list=
 is a list of allowed protocols separated by :</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  A client will announce these protocols via the=
 IV_ACC variable and the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  server will notify the client about the common protocols=2E</span><b=
r><span>diff --git a/doc/man-sections/script-options=2Erst b/doc/man-sectio=
ns/script-options=2Erst</span><br><span>index f420380f=2E=2E9c17c3b 100644<=
/span><br><span>--- a/doc/man-sections/script-options=2Erst</span><br><span=
>+++ b/doc/man-sections/script-options=2Erst</span><br><span>@@ -1006,3 +10=
06,12 @@</span><br><span>        X509_1_L=3DBISHKEK</span><br><span>       =
 X509_1_ST=3DNA</span><br><span>        X509_1_C=3DKG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+:code:`acc_protocols`</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    If ``--app-custom-control`` is configured and the clie=
nt supports any of the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    protocols that server also supports, this variable contains a list o=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    common protoco=
ls separated by :=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`acc_message=
_len`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if :code:`=
acc_protocols` is set, this variable contains the maximum</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    message length for app custom pro=
tocol message=2E</span><br><span>\ No newline at end of file</span><br><spa=
n>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</spa=
n><br><span>index 4d726c4=2E=2E1a7de8c 100644</span><br><span>--- a/doc/man=
agement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span>=
<br><span>@@ -828,6 +828,58 @@</span><br><span> that is required to continu=
e the connection (unlike MFA or opening a browser)</span><br><span> this me=
ssage is not negotiated but can just be sent as a gratuitous message=2E</sp=
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
e=3D"color: hsl(120, 100%, 40%);">+The server should then use client-acc-ms=
g command to send app custom</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+control messages to the client to facilitate the pending authentic=
ation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (Ope=
nVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+-------------------------------------------------</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+On an OpenVPN instance running in server mode this command s=
ends an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+app custom c=
ontrol message to a client=2E The format of the command is:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID -- client ID and Key=
 ID=2E See documentation for &quot;&gt;CLIENT:&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+notification for more info=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+protocol -- the ACC protocol identifier that this =
message should be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          tagged with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+flags    -- a =
colon separated list of the encoding and the flag if</span><br><span style=
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
20, 100%, 40%);">+When OpenVPN is running in --client mode this command sen=
ds an app</span><br><span style=3D"color: hsl(120, 100%, 40%);">+custom com=
mand to the server=2E The format of the command is</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  acc-msg</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {fl=
ags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+See the client-acc-msg command for more details about th=
e format of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mess=
age=2E Since a client has only one peer there is no need to specify the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+client id and key id=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- client-de=
ny  (OpenVPN 2=2E1 or higher)</span><br><span> ----------------------------=
-------------------</span><br><span> </span><br><span>@@ -1302,6 +1354,47 @=
@</span><br><span>    response=2E Mechanisms that need multiple rounds or m=
ore complex answers</span><br><span>    should implement a different respon=
se type than CR_RESPONSE=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+(6) App custom control message</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    This message is an application specific payload messa=
ge that is transported</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    over the OpenVPN control channel=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    In server mode:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIENT:=
ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    In client mode:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt=
;ACC:{protocol},{fragment},{msg_base64}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    The protocol is a short ascii string identifying the app specific cust=
om</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocol=2E I=
f fragment is set to 1, the message is not complete and the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    next message should be concaten=
ated to this message to form a complete</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    message=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
Note that the OpenVPN implementation operates here with the robustness</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    principle (&quot;be =
conservative in what you send, be liberal in what you</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    accept&quot; - RFC 793 and others) an=
d allows receiving messages longer than</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    maximum allowed message length=2E Implementations s=
hould be prepared to</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    handle messages that are longer than the maximum allowed message lengt=
h=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+(7) App custom control protocol message</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+   This message informs the client about the common =
ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protocols and=
 the maximum message length for an ACC message=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+   In client mode:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   &gt;AC=
C_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{max_msg_len}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   protocol_list is the list of supported prot=
ocols by both server and client=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   For example flower:power:sys_info would indicate these th=
ree protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   arn=
e supported=2E max_msg_len specifies the maximum message length that the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+   peer supports=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   In server mode these information are a=
vailable in the acc_protocols and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+   acc_message_len variables of the client environment=2E</sp=
an><br><span> </span><br><span> Variables:</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span>=
<br><span>index 8a60a94=2E=2Eebc4db6 100644</span><br><span>--- a/src/openv=
pn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br>=
<span>@@ -45,6 +45,7 @@</span><br><span> sbin_PROGRAMS =3D openvpn</span><b=
r><span> </span><br><span> openvpn_SOURCES =3D \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><br><span> 	argv=2Ec =
argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=2Eh \</span><br><spa=
n> 	base64=2Ec base64=2Eh \</span><br><span>@@ -124,7 +125,8 @@</span><br><=
span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \</span>=
<br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	push_util=2Ec \</span><br><span> 	pushlist=2Eh \</sp=
an><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><br><span> 	re=
liable=2Ec reliable=2Eh \</span><br><span>diff --git a/src/openvpn/acc=2Ec =
b/src/openvpn/acc=2Ec</span><br><span>new file mode 100644</span><br><span>=
index 0000000=2E=2E2ab87e2</span><br><span>--- /dev/null</span><br><span>++=
+ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,438 @@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  over a single TCP/UDP port, with support for SSL/TLS-based</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticat=
ion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet encryption, packet authentication, and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN I=
nc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  This program is free software; you can redistribute=
 it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  it under the terms of the GNU General Public License version 2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free S=
oftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progra=
m is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, write to the Free Software Foundation, Inc=2E,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
forward=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;options_util=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+enum acc_message_flag</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_FRA=
GMENT =3D 4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+log_acc_message(struct context *c, const struct buffer *buf, int pay=
load_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      const char *protocol, int flags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool fragment =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *payload_msg =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* For =
simplicity, we always encode payload to be base64 encoded</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * if not already in base64 forma=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &=
amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    char *b64out =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ASSERT(openvpn_base64_encode(CBPTR(buf), payload_len, &amp;b=
64out) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       gc_addspecial(b64out, free, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        payload_msg =3D b64out;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      payload_msg =3D CBSTR(buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (management)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *sessi=
on =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            /* server mode=2E Repo=
rt client context */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            struct man_def_auth_context *mda =3D session-&gt;opt-&gt;mda_c=
ontext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
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
 100%, 40%);">+    const struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;a=
cc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
rr_reason =3D &quot;ACC not enabled or no negotiated protocols&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&quot;ACC&quot;)) || b=
uf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        err_reason =3D &quot;missing , after ACC&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* extract protocol, payload length, flags substrings */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =3D=
 buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!protocol)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        err_reason =3D &quot;could not extract protocol=
 field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!tls_item_in_cipher_list(protocol=
, multi-&gt;acc_negotiated_protocols))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct buffer msg_buf =3D alloc_buf_gc(1024, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;msg=
_buf, &quot;protocol &#39;%s&#39; not in list of negotiated protocols &#39;=
%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              protocol, multi-&gt;acc_negotiated_protocols);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D buf_cstr(&a=
mp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* We do not check the length here=2E We make no promises to support</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * anything larger than=
 our announced message length but according to</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * the robustness principle</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * (&quot;be conservative in wha=
t you send, be liberal in what you accept&quot; - RFC 793 and others)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * we accept also lon=
ger messages */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int payload_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *payloa=
d_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!payload_len_str || !(=
(payload_len =3D atoi(payload_len_str))))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        err_reason =3D &quot;could not extract payload length field=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message_flags(&amp;=
buf, &amp;err_reason, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(flags &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* We should have a final NUL byte in the control =
message buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* and thus the length of the buffer should be payload_len + 1 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf) !=3D=
 payload_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tm=
p =3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        snprintf(tmp, 512, &quot;field length %d, payload len=
gth %d mismatch&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 payload_len, buf_len(&amp;buf) - 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    log_a=
cc_message(c, &amp;buf, payload_len, protocol, flags);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app control chan=
nel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              &quot;message (%s): %s&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        err_reason,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        format_hex(CBPTR(buffer), BLEN(buffer), 80,=
 &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
send_acc_message(struct context *c,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 struct tls_multi *multi,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 struct tls_session *=
session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
      const char *protocol, bool fragment,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 const char *msg, bool base64)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * length of the protocol string + one &#39;,&#39;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 2 for the en=
coding (A or 6), potential F (fragment), and 1 for the &#39;,&#39;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * 4 for the message si=
ze itself and one comma</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * 1 for the comma before the message itself */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const size_t max_header_size =3D st=
rlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D max_header_si=
ze + strlen(msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_=
CHANNEL_BUF_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CL=
IENT, &quot;message length (%zu) exceeds maximum possible message length (%=
d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((int)=
len &gt; multi-&gt;acc_max_message_length)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_CLIENT, &quot;header (%zu) + message size (%zu) leng=
th (%zu) exceeds &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                      &quot;maximum allowed length negotiated with peer=
 (%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     max_header_size, strlen(msg), len,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi-&gt;acc_max_message_length);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
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
=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena *gc, cons=
t char *list1, const char *list2)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char *tmp =3D string_alloc(list1, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp, &quot;:&=
quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The maximum =
possible length is the shorter of the two input lists */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    size_t max_len =3D min_size(strlen=
(list1), strlen(list2));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer common_protocols =3D alloc_buf_gc(max_len + 1, gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    while (token)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* check for every items is in both lists and not already in the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * common lis=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tls=
_item_in_cipher_list(token, list2)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &amp;&amp; !tls_item_in_cipher_list(token, buf_c=
str(&amp;common_protocols)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (buf_len(&amp;common_protocols) &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                buf_write_u8(&amp;common_protoc=
ols, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     buf_printf(&amp;common_protocols, &quot;%s&quot;, token);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&=
quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(tmp);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return common_p=
rotocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+determine_common_acc_protocols(struct tls_multi *multi, struct=
 tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-=
&gt;opt=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* No app custom protocols have been configured server-side=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (multi-&gt;acc_negotiated_protocols)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* We already have determined the common protoc=
ols=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:p=
ower */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *peer_info =3D multi-&gt;peer_info;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *iv_acc =3D extract_var_peer_info(peer_in=
fo, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!iv_acc)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_len =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocol=
s =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max_acc_len, true, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!protocols)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNI=
NG: IV_ACC peer info variable of peer is malformed&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer common_protocols =3D get_list_intersection(&amp;gc, mul=
ti-&gt;opt=2Eacc_protocols, protocols);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (buf_len(&amp;common_protocols) =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING: No common app cust=
om control protocol=2E&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_ne=
gotiated_protocols =3D string_alloc(buf_str(&amp;common_protocols), NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_ma=
x_message_length =3D max_acc_len;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
etenv_str(session-&gt;opt-&gt;es, &quot;acc_protocols&quot;, multi-&gt;acc_=
negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    setenv_int(session-&gt;opt-&gt;es, &quot;acc_message_len&quot;, mult=
i-&gt;acc_max_message_length);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><b=
r><span>new file mode 100644</span><br><span>index 0000000=2E=2E4a388f7</sp=
an><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span>=
<br><span>@@ -0,0 +1,105 @@</span><br><span style=3D"color: hsl(120, 100%, =
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
 of the peer and sets multi=2Eacc_negotiated_protocols</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * to the common protocols of server and=
 client and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi=
=2Eacc_max_message_length  to the maximum length of the ACC message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * support by both server a=
nd client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there is no common=
 protocol or the client does not support any app custom</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * protocol multi=2Eacc_negotiated_prot=
ocols will be set to NULL=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m multi      the multi instance to use the set the app custom protocols=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param session   =
 the session to read the client env from</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+determine_=
common_acc_protocols(struct tls_multi *multi, struct tls_session *session);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Calculates the intersection of two list that are bo=
th separated by :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Items in the result will have the same ordering as in the list1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * parameters</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param gc            Returned buf=
fer will be allocated in this gc</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param list1         First list to intersect</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param list2         Second lis=
t to intersect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return A (potentially empty) buffer containing an intersection list</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena *gc, cons=
t char *list1, const char *list2);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/forward=2Ec =
b/src/openvpn/forward=2Ec</span><br><span>index 681210d=2E=2E7923b5e 100644=
</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/op=
envpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #inclu=
de &quot;dco=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;=
</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><s=
pan> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </s=
pan><br><span>@@ -257,11 +258,11 @@</span><br><span>     }</span><br><span>=
     else if (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  server_pushed_info(buf, 8);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        server_pushed_info(c, buf, 8);</span><br><span>     }</sp=
an><br><span>     else if (buf_string_match_head_str(buf, &quot;INFO&quot;)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        server_pushed_info(buf, 4);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        server_pushed_info(c, buf, 4);</span><br><span> =
    }</span><br><span>     else if (buf_string_match_head_str(buf, &quot;CR=
_RESPONSE&quot;))</span><br><span>     {</span><br><span>@@ -271,6 +272,10 =
@@</span><br><span>     {</span><br><span>         receive_auth_pending(c, =
buf);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (buf_string_match_head_str(buf, &quot;ACC&quot;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        receive_acc_message(c, buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
>     else if (buf_string_match_head_str(buf, &quot;EXIT&quot;))</span><br>=
<span>     {</span><br><span>         receive_exit_message(c);</span><br><s=
pan>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><spa=
n>index 1b8b2a5=2E=2Efe1582b 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2279,6 =
+2279,13 @@</span><br><span>         }</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_=
multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (multi &amp;&amp; multi-&gt;acc_negotiated_protoc=
ols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, =
&quot; custom-control %d A:6 %s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                   multi-&gt;acc_max_message_length, mul=
ti-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     if (BLENZ(&amp;out) &gt; strlen(header))</span><br><s=
pan>     {</span><br><span>         msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&=
amp;out));</span><br><span>@@ -2522,6 +2529,11 @@</span><br><span>         =
flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&g=
t;options=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 flags |=3D OPT_P_ACC;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     return flags;</span><br><span> }</span><br><span> </span><br><sp=
an>@@ -2730,6 +2742,17 @@</span><br><span>         frame-&gt;tun_mtu =3D mi=
n_int(frame-&gt;tun_max_mtu, c-&gt;options=2Ece=2Etun_mtu);</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (found &amp; OPT_P_ACC &amp;&amp; c-&gt;options=2Epushed_acc_n=
egotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        free(multi-&gt;acc_negotiated_protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;ac=
c_negotiated_protocols =3D string_alloc(c-&gt;options=2Epushed_acc_negotiat=
ed_protocols, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        multi-&gt;acc_max_message_length =3D c-&gt;options=2Epushed_acc_ma=
x_message_length;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH, &=
quot;OPTIONS IMPORT: ACC protocols: %s, msg len: %d&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_negotiated=
_protocols, multi-&gt;acc_max_message_length);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     return true;</span><br><span> }</span><b=
r><span> </span><br><span>@@ -3352,6 +3375,7 @@</span><br><span>     to=2Ev=
erify_hash_depth =3D options-&gt;verify_hash_depth;</span><br><span>     to=
=2Everify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>   =
  memcpy(to=2Ex509_username_field, options-&gt;x509_username_field, sizeof(=
to=2Ex509_username_field));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    to=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><sp=
an>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &a=
mp;c-&gt;net_ctx;</span><br><span> </span><br><span>@@ -4306,6 +4330,24 @@<=
/span><br><span> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_=
msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              struct buffer_list *input) /* ownership transferred */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct context *c =3D arg;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-=
&gt;c2=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct tls_session *session =3D &amp;multi-=
&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D=
 management_send_acc_message(c, multi, session, input);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><=
span> </span><br><span> void</span><br><span>@@ -4322,6 +4364,7 @@</span><b=
r><span>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><b=
r><span>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</span>=
<br><span>         cb=2Esend_cc_message =3D management_callback_send_cc_mes=
sage;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Ea=
cc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span=
><br><span>         cb=2Enetwork_change =3D management_callback_network_cha=
nge;</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/manag=
e=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ac3d4b7=2E=2E5e4e416 1=
00644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/sr=
c/openvpn/manage=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><span> #i=
nclude &quot;push=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;=
</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span=
> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #inclu=
de &quot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><sp=
an> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</=
span><br><span>@@ -1081,6 +1083,35 @@</span><br><span>             }</span>=
<br><span>             break;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2E=
callback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_=
msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                                        =
              man-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                              =
                        man-&gt;connection=2Ein_extra_kid,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
                                  man-&gt;connection=2Ein_extra);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;conne=
ction=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                report_command_status(status, &quot;client-acc-msg&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                man_command_=
unsupported(&quot;client-acc-msg&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                bool status =3D (*man-&gt;pers=
ist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
                            man-&gt;connection=2Ein_extra);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection=
=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                report_command_status(status, &quot;acc-msg&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                man_command_unsupported(=
&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        break;</span><br><span>         case IEC_PK_SIGN:</span><br><span> =
            man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><br><sp=
an>             buffer_list_free(man-&gt;connection=2Eext_key_input);</span=
><br><span>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+man_client_acc_msg(struct management *man, const char *cid_str,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                   const c=
har *kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_connectio=
n *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt=
;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D=
 IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;ma=
n-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span> man_client_auth(struct management *man, const cha=
r *cid_str, const char *kid_str, const bool extra)</span><br><span> {</span=
><br><span>     struct man_connection *mc =3D &amp;man-&gt;connection;</spa=
n><br><span>@@ -1759,6 +1813,17 @@</span><br><span>             man_client_=
pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
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
pan>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2975=
,7 +3040,9 @@</span><br><span>                                        &quot=
;bytes_sent=3D&quot;,</span><br><span>                                     =
   &quot;bytes_received=3D&quot;,</span><br><span>                         =
               &quot;session_id=3D&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                       &quot;session_st=
ate=3D&quot; };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                   &quot;session_state=3D&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
         &quot;acc_protocols=3D&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                       &quot;acc_message=
_len=3D&quot; };</span><br><span> </span><br><span>     if (env_filter_leve=
l =3D=3D 0)</span><br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><spa=
n> management_connection_established(struct management *man, struct man_def=
_auth_context *mdac,</span><br><span>                                   con=
st struct env_set *es)</span><br><span>@@ -4372,6 +4440,64 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+management_send_acc_message(struct context *c, struct tls_multi=
 *multi, struct tls_session *session,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                            struct buffer_list *input)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* also ensures that are enough inpu=
ts in the list to safely call</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * buffer_list_peek without extra NULL checks */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size=
 &lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &qu=
ot;not enough input lines for sending acc message, &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                      &quot;missing p=
rotocol, flag and/or messages lines&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct buffer *proto_buf =3D buffer_list_peek(input);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =3D string_allo=
c(CBSTR(proto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(enco=
ding_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *flag =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool b64encoding =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    bool fragment =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    while ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            b64encoding =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!strcmp(flag=
, &quot;F&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
fragment =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(=
input, 10000, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_proto=
cols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !tls=
_item_in_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not =
in the list of negotiated protocols: %s&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            np(multi-&gt;acc_negotiated_protocol=
s));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto er=
ror;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool ret =3D send_acc_message(c, multi, sess=
ion, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                           fragment, buf_cstr(acc_msg_buf),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                b64=
encoding);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else=
 /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #include =
&quot;win32=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b=
/src/openvpn/manage=2Eh</span><br><span>index 157039d=2E=2Ecc9c264 100644</=
span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openv=
pn/manage=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>     in=
t (*n_clients)(void *arg);</span><br><span>     bool (*send_cc_message)(voi=
d *arg, const char *message, const char *parameter);</span><br><span>     b=
ool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     bool (*client_auth)(void *arg, const unsigned long cid, const unsigned=
 int mda_key_id,</span><br><span>                         const bool auth, =
const char *reason, const char *client_reason,</span><br><span>            =
             struct buffer_list *cc_config); /* ownership transferred */</s=
pan><br><span>     bool (*client_pending_auth)(void *arg, const unsigned lo=
ng cid, const unsigned int kid,</span><br><span>                           =
      const char *extra, unsigned int timeout);</span><br><span>     char *=
(*get_peer_info)(void *arg, const unsigned long cid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
    const unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                           const unsigned int mda_key_id,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           s=
truct buffer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    struct buffer_list *msg);</span><br><sp=
an>     bool (*proxy_cmd)(void *arg, const char **p);</span><br><span>     =
bool (*remote_cmd)(void *arg, const char **p);</span><br><span> #ifdef TARG=
ET_ANDROID</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     struc=
t command_line *in;</span><br><span>     struct buffer_list *out;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_U=
NDEF       0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define I=
EC_CLIENT_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine IEC_UNDEF          0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_P=
F   2 *REMOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span style=
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
struct context *c, struct tls_multi *multi,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                            struct tls_session *ses=
sion, struct buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_M=
ANAGEMENT */</span><br><span> </span><br><span> /**</span><br><span>diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e=
302a81=2E=2Ea3eb3ca 100644</span><br><span>--- a/src/openvpn/multi=2Ec</spa=
n><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</=
span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include=
 &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ac=
c=2Eh&quot;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_=
LOOP*/</span><br><span> </span><br><span>@@ -4085,6 +4086,26 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+calculate_app_control_extra(struct multi_insta=
nce *mi, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protoco=
ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;AC=
C: No negotiated protocols&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf =3D alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_message_len=
gth,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return buf_str(&amp;buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static bool</span><br><span> management_client_pending_auth(void *a=
rg, const unsigned long cid, const unsigned int mda_key_id,</span><br><span=
>                                const char *extra, unsigned int timeout)</=
span><br><span>@@ -4095,10 +4116,22 @@</span><br><span>     if (mi)</span><=
br><span>     {</span><br><span>         struct tls_multi *multi =3D mi-&gt=
;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!strcmp(extra, &quot;ACC&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            extra =3D calculate_app_control_extra(m=
i, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (!extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span>         struct tls_session *session =3D=
 lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span> </span><=
br><span>         if (!session)</span><br><span>         {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span>=
<br><span>             return false;</span><br><span>         }</span><br><=
span> </span><br><span>@@ -4106,6 +4139,7 @@</span><br><span>         bool =
ret =3D send_auth_pending_messages(multi, session, extra, timeout);</span><=
br><span>         reschedule_multi_process(&amp;mi-&gt;context);</span><br>=
<span>         multi_schedule_context_wakeup(m, mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
>         return ret;</span><br><span>     }</span><br><span>     return fa=
lse;</span><br><span>@@ -4149,6 +4183,37 @@</span><br><span>     return ret=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manageme=
nt_client_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                          const unsigned long cid,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                          const uns=
igned int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                          struct buffer_list *input) /* ownership transfe=
rred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =
=3D (struct multi_context *)arg;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct multi_instance *mi =3D lookup_by_cid(m, cid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_list_define=
d(input))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi=
 *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct tls_session *session =3D lookup_ses=
sion_by_mda_key_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!session)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_CLIENT, &quot;client session not found&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buffer_=
list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D managemen=
t_send_acc_message(&amp;mi-&gt;context, multi, session, input);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_context_=
wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static char *</span><br><span> management_get_peer_i=
nfo(void *arg, const unsigned long cid)</span><br><span> {</span><br><span>=
@@ -4185,6 +4250,7 @@</span><br><span>         cb=2En_clients =3D managemen=
t_callback_n_clients;</span><br><span>         cb=2Ekill_by_cid =3D managem=
ent_kill_by_cid;</span><br><span>         cb=2Eclient_auth =3D management_c=
lient_auth;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cb=2Eclient_acc_msg =3D management_client_acc_msg;</span><br><span>        =
 cb=2Eclient_pending_auth =3D management_client_pending_auth;</span><br><sp=
an>         cb=2Eget_peer_info =3D management_get_peer_info;</span><br><spa=
n>         cb=2Epush_update_broadcast =3D management_callback_send_push_upd=
ate_broadcast;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/o=
penvpn/options=2Ec</span><br><span>index fb319ae=2E=2Ebb854da 100644</span>=
<br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/o=
ptions=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><s=
pan> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br>=
<span> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;erro=
r=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><spa=
n>@@ -7107,6 +7108,41 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
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
=3D"color: hsl(120, 100%, 40%);">+        /* check if the list from the ser=
ver is a real subset of our list */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct gc_arena gc_local =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct buffer common_lis=
t =3D get_list_intersection(&amp;gc_local, p[3], options-&gt;acc_protocols)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (buf_len(&amp;common_list)=
 =3D=3D 0 || !streq(p[3], buf_cstr(&amp;common_list)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control=
 list from server contains &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                          &quot;unsupported protocols&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free=
(&amp;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_=
free(&amp;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq=
(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot;))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App cus=
tom control encoding must be base64 and ascii&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;pushed_acc_max_=
message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                          &quot;app custom message message length&quot;, AC=
C_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        options-&gt;pushed_acc_negotiated_protocols =3D p[3];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     e=
lse if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</sp=
an><br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --pr=
ng option ignored (SSL library PRNG is used)&quot;);</span><br><span>diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>in=
dex 6a3bf61=2E=2Eb7945e0 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -715,=
6 +715,18 @@</span><br><span>     /* force using TLS key material export fo=
r data channel key generation */</span><br><span>     bool force_key_materi=
al_export;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /** The app custom control protocols we should announce as sup=
ported */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *acc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protoc=
ols that are negotiated with the peer=2E This is a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *  a temporary variable since options=
=2Ec push parser cannot access</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     *  tls multi struct */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *pushed_acc_negotiated_protocols;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC control c=
hannel message via push message</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int pushed_acc_max_message_length;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     bool vlan_tagging;</span><br><sp=
an>     enum vlan_acceptable_frames vlan_accept;</span><br><span>     uint1=
6_t vlan_pvid;</span><br><span>@@ -764,8 +776,10 @@</span><br><span> #defin=
e OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUS=
H_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE   =
  (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OPT_P_ACC             (1ull &lt;&lt; 32)</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_=
INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Options allowed in the normal configur=
ation file (vs pushed options or in ccd files) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT=
_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </span><br><spa=
n> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><=
span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><sp=
an>index 42259c3=2E=2E8f3bf81 100644</span><br><span>--- a/src/openvpn/push=
=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +2=
7,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;push=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;option=
s=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><spa=
n> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -221,9 +223,61 @@</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+parse_server_pushed_info_acc(struct context *c, =
struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_le=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=
=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PU=
SH_ERRORS, &quot;Server tried to push app custom control list &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 &quot;without client announcing support for it&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* example string to parse: ACC:1400 A:6 flower:happy */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Skip over the ACC: prefix =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(b=
uf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *protocols =3D parse_acc_parameters(buf_cstr(buf), &quot; &quot;, &amp;max=
_acc_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command with invalid p=
arameters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* check if the list from the=
 server is a real subset of our list */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer common_list =3D get_list_intersection=
(&amp;gc, protocols, multi-&gt;opt=2Eacc_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (buf_len(&amp;common_list) =3D=3D 0 || !streq(protoco=
ls, buf_cstr(&amp;common_list)))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(D_PUSH_ERRORS, &quot;App custom control list from server contain=
s &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                &quot;unsupported protocols&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    multi-&gt;acc_negotiated_protocols =3D string_alloc(protocols, NULL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_=
max_message_length =3D max_acc_len;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
def ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_CLIENT, &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&quot;, pr=
otocols, max_acc_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-serv=
er_pushed_info(const struct buffer *buffer, const int adv)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+server_pushed_info(struct context *c=
, const struct buffer *buffer, const int adv)</span><br><span> {</span><br>=
<span>     const char *m =3D &quot;&quot;;</span><br><span>     struct buff=
er buf =3D *buffer;</span><br><span>@@ -233,6 +287,12 @@</span><br><span>  =
       m =3D BSTR(&amp;buf);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;=
ACC:&quot;, 4) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
arse_server_pushed_info_acc(c, &amp;buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct =
gc_arena gc;</span><br><span>     if (management)</span><br><span>@@ -285,6=
 +345,7 @@</span><br><span>     msg(D_PUSH, &quot;CR response was sent by c=
lient (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</spa=
n><br><span>  * Parse the keyword for the AUTH_PENDING request</span><br><s=
pan>  * @param buffer                buffer containing the keywords, the bu=
ffer&#39;s</span><br><span>@@ -441,7 +502,6 @@</span><br><span>     const c=
har *const peer_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsi=
gned int proto =3D extract_iv_proto(peer_info);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calcul=
ate the maximum timeout and subtract the time we already waited */</span><b=
r><span>     unsigned int max_timeout =3D</span><br><span>         max_uint=
(tls_multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake=
_window);</span><br><span>@@ -732,6 +792,12 @@</span><br><span>            =
     client_max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (tls_multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;custom-co=
ntrol %d A:6 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        tls_multi-&gt;acc_max_message_length, tls_multi-=
&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> stat=
ic bool</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/pus=
h=2Eh</span><br><span>index 39302f6=2E=2Eb6695bc 100644</span><br><span>---=
 a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><b=
r><span>@@ -52,6 +52,7 @@</span><br><span> </span><br><span> int process_in=
coming_push_request(struct context *c);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span=
>  * @brief Handles the receiving of a push-update message and applies upda=
tes to the specified</span><br><span>  * options=2E</span><br><span>@@ -92,=
7 +93,7 @@</span><br><span> </span><br><span> void receive_exit_message(str=
uct context *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void server_pushed_info(const struct buffer *buffer, const int=
 adv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void server_p=
ushed_info(struct context *c, const struct buffer *buffer, const int adv);<=
/span><br><span> </span><br><span> void receive_cr_response(struct context =
*c, const struct buffer *buffer);</span><br><span> </span><br><span>diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6=
fc=2E=2E139b11d 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br>=
<span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br=
><span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><=
span> #include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot=
;ssl_verify=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;=
</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -1279=
,6 +1280,7 @@</span><br><span>     free(multi-&gt;locked_cn);</span><br><sp=
an>     free(multi-&gt;locked_username);</span><br><span>     free(multi-&g=
t;locked_original_username);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br><span> </s=
pan><br><span>     cert_hash_free(multi-&gt;locked_cert_hash_set);</span><b=
r><span> </span><br><span>@@ -2098,6 +2100,11 @@</span><br><span> #endif</s=
pan><br><span>         }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (session-&gt;opt-&gt;acc_protocols)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &q=
uot;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_pr=
otocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
      if (session-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><br><span=
>         {</span><br><span>             struct env_set *es =3D session-&gt=
;opt-&gt;es;</span><br><span>@@ -2117,6 +2124,8 @@</span><br><span>        =
             }</span><br><span>                 }</span><br><span>         =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         }</span=
><br><span>     }</span><br><span> </span><br><span>@@ -2398,6 +2407,8 @@</=
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
/span><br><span>index 43a6743=2E=2Ef827a4c 100644</span><br><span>--- a/tes=
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
=2Ec \</span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	=
mock_get_random=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-str=
lcpy=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span=
>@@ -407,6 +412,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_re=
ference=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/ope=
nvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span> 	-I$=
(top_srcdir)/tests/unit_tests/openvpn \</span><br><span>diff --git a/tests/=
unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_mana=
gement=2Ec</span><br><span>index fff4c2b=2E=2Ef572dbb 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>@@ -29,6 +29,7=
 @@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;stdlib=2Eh&gt;</span><br><span> #include &quot;manage=2Eh&quot;</sp=
an><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit=
_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>index bf2ccf3=2E=
=2Ef083f89 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_=
dependencies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_d=
ependencies=2Ec</span><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint=
64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFL=
AGS</span><br><span>                      | OPT_P_SETENV | OPT_P_SHAPER | O=
PT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span>                   =
   | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     |=
 OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
 | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  | OPT_P_ACC;</span><br><span>     return flags;</span><br><span> }</span>=
<br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=
=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>new file mode =
100644</span><br><span>index 0000000=2E=2Edde1ad8</span><br><span>--- /dev/=
null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br>=
<span>@@ -0,0 +1,358 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
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
 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;std=
io=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+char control_channel_message_sent[2=
048];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Mock functions */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+send_control_channel_string_dowork(struct tls_s=
ession *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                const char *str, unsigned int msglevel)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range(strlen(str), 0, 2=
047);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    strcpy(control_channel_messag=
e_sent, str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+send_push_reply_auth_token(struct tls_multi *multi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_set_client_reason(s=
truct tls_multi *multi, const char *reason)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBA=
RkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;                \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;r4engpg/cDg=
S48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;4md4OJwoQAwEwIT=
AxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;AJwBnwArAFAA5wAnAEwAz=
AQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;QAXAB4AGQAYAQABAQECAQMBBAAW=
AAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEG=
AQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2=
FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    &quot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_acc_parse_client_messages(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    skip();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* ensure that the messages get to mock_msg */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 3;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    management =3D (void *)0x12345678;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* contains a TLS =
1=2E3 ClientHello */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char msg[] =3D &quot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer msg_buf;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Emode =3D M=
ODE_SERVER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2E=
c2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2E=
tls_multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp=
;c=2Ec2=2Emda_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_set_read(&amp;msg_buf, (void *)msg, sizeof(msg));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mo=
ck_msg_buf, &quot;WARNING: Received malformed custom app control channel me=
ssage (ACC not enabled or no negotiated protocols): 4143432c 63636b31 2c333=
834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
c=2Ec2=2Etls_multi-&gt;acc_negotiated_protocols =3D &quot;no:common:protoco=
l&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive=
_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;WARNING: Receiv=
ed malformed custom app control channel message (protocol &#39;cck1&#39; no=
t in list of negotiated protocols &#39;no:common:protocol&#39;): 4143432c 6=
3636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_negotiated_protocols =3D &quot;cck1=
:flower:power:fortune&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custo=
m app control message (protocol &#39;cck1&#39;)&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_=
buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char flower_msg[] =3D &quot;ACC,flower,48,6,SS=
BhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void =
*)flower_msg, sizeof(flower_msg));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_=
buf, &quot;Received custom app control message (protocol &#39;flower&#39;)&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAI=
Etlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char msg_incorrect_len[] =3D &quot;ACC,=
fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=
=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_set_read(&amp;msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_le=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc=
_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *error =3D &quot;WARNING: Received malformed cus=
tom app control channel &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        &quot;message (field length 62, payload =
length 64 mismatch): &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        &quot;4143432c 666f7274 756e652c 36322c36 2=
c496e73 67496d31 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        &quot;6c496a6f 67496d5[more=2E=2E=2E]&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, err=
or);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGV=
sbG8gdw=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_set_read(&amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_me=
ssage(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(mock_msg_buf, &quot;Received custom app co=
ntrol message (protocol &#39;power&#39;, fragment)&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managme=
nt_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* check two encoding present */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flowe=
r_msg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+=
94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof=
(flower_msg_two_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    error =3D &quot;WARNING: Received malformed custom app cont=
rol channel message &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;(number of encodings must be exactly one (B64=3D1,=
 ASCII=3D1)): &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;4143432c 666c6f77 65722c34 382c3641 2c535342 68625341 41=
494574 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;6c636d3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &q=
uot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no encoding present=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char f=
lower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77=
+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof=
(flower_msg_no_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    error =3D &quot;WARNING: Received malformed custom app contr=
ol channel message &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;(number of encodings must be exactly one (B64=3D0, =
ASCII=3D0)): &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;4143432c 666c6f77 65722c34 382c2c53 53426862 53414149 457=
46c63 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;6d31706[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock=
_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_de=
bug_level =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 management =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_parse_acc_parameters(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* parameters to INFO message */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *info_acc=
_msg =3D &quot;4096 A:6 flower:happy&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int max_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *protocols =3D parse_acc_parameters(info_acc_msg, &q=
uot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happ=
y&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(max_len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a cli=
ent does not accept a length longer than it supports */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(=
info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* message with lower limit than our, shou=
ld work for client and server */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_ac=
c_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quo=
t; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(max_len, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* more en=
codings than supported=2E Server should be okay, client should fail */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &qu=
ot;1200 A:6:B flower:happy&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &=
quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, =
&amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ma=
x_len, 1200);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =
=3D &quot;1400 A:6 flower:happy 77&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, =
&quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; =
&quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *iv_acc_capabilities =3D &quot;1400,A:6,flower:happy:power&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_a=
cc_parameters(iv_acc_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(protocols, &quot;flower:happy:power&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* too small protocol length */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:hap=
py&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-numeric=
al protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    info_acc_msg =3D &quot;abff A:6 flower:happy&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameter=
s(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flo=
wer:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;ma=
x_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_acc_common_protocols(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=
=2Econtext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&g=
t;options=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_=
OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Eg=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_i=
nfo =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2E=
acc_protocols =3D &quot;power:flower:star&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls=
_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&g=
t;opt=2Eacc_protocols =3D c-&gt;options=2Eacc_protocols;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt=
 =3D &amp;multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    multi-&gt;opt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(multi,=
 &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(multi-&gt;acc_max_message_length, ACC_M=
AX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(multi-&gt;acc_negotiated_protocols, &quot;power:flower&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_ge=
t(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;acc_protocols=3Dpow=
er:flower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len=
&quot;), &quot;acc_message_len=3D1280&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_acc_send_message(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct context *c =3D &amp;mi=2Econtext;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2E=
tls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls=
_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;op=
tions=2Eacc_protocols =3D &quot;power:flower:emergency&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_protocols=
 =3D c-&gt;options=2Eacc_protocols;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;o=
pt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;op=
t=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D=
4321\nIV_ACC=3D1400,A:6,flower:emergency:power&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(multi,=
 &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct tls_session *session =3D &amp;c-&gt;c2=2Etls_mult=
i-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D s=
end_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, tr=
ue,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
           &quot;EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, =
false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(contr=
ol_channel_message_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST =
MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emerge=
ncy&quot;, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                         &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED=
 ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(control_channel_message_sent,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED A=
LERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* test a long message (=
&gt; 1000) with fragment to get the maximum header size */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char long_message[1200] =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i=
++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        long_message[i] =3D (c=
har)(&#39; &#39; + (i % 95));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* last char of the=
 message is a i and then a \0 */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(long_message[1023], &#39;i&#39;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_m=
essage[1024], &#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot=
;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                long_message, false);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    size_t cc_len =3D strlen(control_channel_message_sent);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(control_chann=
el_message_sent[cc_len - 1], &#39;i&#39;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *expected_start_cc =3D &quot;ACC,emer=
gency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(control_cha=
nnel_message_sent, expected_start_cc, strlen(expected_start_cc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_protocols);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt=
;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_list_intersection(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *empty =3D &quot;&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *protos =3D &quot;powe=
r:flower:emergency&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er t1 =3D get_list_intersection(&amp;gc, empty, protos);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1),=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t2 =3D get_list_=
intersection(&amp;gc, protos, empty);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t2), 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer t3 =3D get_list_intersection(&amp;g=
c, protos, protos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(buf_cstr(&amp;t3), protos);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *protos2 =3D &quot;flower:emergency:power:mar=
io&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer t4 =3D get_list_intersection(&amp;gc, protos2, protos);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cst=
r(&amp;t4), &quot;flower:emergency:power&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *protos3 =3D &quot;super:paper:mario:flower&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t=
5 =3D get_list_intersection(&amp;gc, protos2, protos3);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t=
5), &quot;flower:mario&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *proto4 =3D &quot;flower:flower:flower:flower&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t6 =3D get_list_i=
ntersection(&amp;gc, proto4, &quot;flower&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t6), &q=
uot;flower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E32421f=
b</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a=
 single UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is free software; you can redistribute it and/or modify</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that=
 it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define TEST_ACC_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void test_acc_parse_client_messages(void **state);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void test_parse_acc_parameters(void **state)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_protocols(void *=
*state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_send_message(voi=
d **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void test_list_intersection=
(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span>diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/=
tests/unit_tests/openvpn/test_common=2Eh</span><br><span>index 8db4ea6=2E=
=2Ec865142 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_commo=
n=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_common=2Eh</span>=
<br><span>@@ -43,11 +43,13 @@</span><br><span> #define LargestIntegralType =
uintmax_t</span><br><span> #endif</span><br><span> /* redefine 2=2Ex API in=
 terms of 1=2Ex API */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define CMockaValueData             LargestIntegralType</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define check_expected_uint         chec=
k_expected</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define exp=
ect_uint_value           expect_value</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define expect_check_data           expect_check</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define cast_ptr_to_cmocka_value=
(x) (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CMoc=
kaValueData                       LargestIntegralType</span><br><span style=
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
/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index=
 4baf8cc=2E=2E4987dd0 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</=
span><br><span>@@ -52,6 +52,8 @@</span><br><span> #include &quot;ssl_verify=
=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
est_acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> /* Mock function to be allowed to include win32=2Ec which i=
s required for</span><br><span>  * getting the temp directory */</span><br>=
<span> #ifdef _WIN32</span><br><span>@@ -86,6 +88,20 @@</span><br><span> {<=
/span><br><span>     return;</span><br><span> }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+reschedule_multi_process(struct context *c)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy =
dco cipher option to avoid linking against all the DCO</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * units */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-=
128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> </span><br><span> /* generated using</span><br><span>  *=
 openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout =
- \</span><br><span>@@ -1111,8 +1127,12 @@</span><br><span>         cmocka_=
unit_test(ssl_test_extract_last_matching_field),</span><br><span>         c=
mocka_unit_test(ssl_test_reject_null_in_cert_subject),</span><br><span>    =
     cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_te=
st_extract_peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(ssl_test_extract_peer_info),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_acc_parse_client_messages),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_parse_acc_parameters),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_acc_common_protocols),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_a=
cc_send_message),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_list_intersection)</span><br><span>     };</spa=
n><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--T2swp8555Wg=--


--===============8243902229538123437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8243902229538123437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8243902229538123437==--

