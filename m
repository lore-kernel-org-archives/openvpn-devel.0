Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B05CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9oy6gJ9AcFaenJYcyP81MhWVdaZILJj/8OKOPP5DaI=; b=jpJuXM2vlOVAkc170hMMqEye4T
	nt8Z6dU/iIlIurLJ5LT4SB7G0Sb6xPm2+LzRHJO3BiKnp7HtAr+KvZw8tEiE7Gkf3IKJQExBMro2r
	ymB/dsp8oSqiuWwYzxL8uBF+ZWM6C+ueAN2FuNE0uWe1Vrb1I0RLIM4PakzKolFp1gTU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDmaN-0002gw-Ii;
	Mon, 05 Oct 2026 17:34:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDmaL-0002go-Ku
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OOO8tFcQ0Yw5trpri/XW+E6kT0f0r+8bOjcxUDCkseI=; b=Jnj0jQG/B8a2pPUNI6ev5bY0+6
 TxNfxwmKVK0Z/YLudDUWOBy3WowD0YO3e8iIoU9Iyo4apAboCG8ecuwPNuR6l40c4zv3F1wKiECoy
 lCUki8pwiqPUgopV0UyEdVY8DUkvg5fPnQZpd3OrbyYkH4gxxYzqjWlexseaBhm9cqbM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OOO8tFcQ0Yw5trpri/XW+E6kT0f0r+8bOjcxUDCkseI=; b=d
 WtyA7szFDq2wAPGKqjVVqE1mgsHECqBtTh2ZQ1pNhzbrWQVPKiXyMpeWbRBqDIUTEpe6APk52yOI/
 T50gLl5ztLnpDKtF2u7Aed7CM5hLIU6eoL1Z5aNMLqUdQl/F8gjX0gkRmD6NctI86L50TfZq6Iyfu
 +KUxtVH71vA8J/KE=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDmaC-0005WF-1D for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:34:43 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so1614281f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791221669; x=1791826469; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OOO8tFcQ0Yw5trpri/XW+E6kT0f0r+8bOjcxUDCkseI=;
 b=NoCDBeGMAOY4s2i7R6ROMFk4BIRrvzdh3sNcABmJ+OoppKpvKHgDn/8GTQNIZ41DJa
 gVGoBQQlpsa9/7p+Jk7erxzmoU0JqObtJYhOXT6LtLAurTLwumx9RVxH4wS+6RMetne0
 HMMDVweFviVl8GymSR9DLzJ0k/yp7skJCjLXrrArlxQp7SH1KNCw8RPD24UOjYhsDnYv
 +wmL3rsaZDII/B3UEA/HIZiH5A7iDXdar1pl5bYUTs6iJ5oydzhGzi5gY/BgGhe02OQY
 SUIxT3h/uW1bed6v1mN7vNWDMONK/m+YRzYjZNaqUFsyxoOeFW/q7804QAByOZdabmu9
 7sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791221669; x=1791826469;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OOO8tFcQ0Yw5trpri/XW+E6kT0f0r+8bOjcxUDCkseI=;
 b=fkEYZKsneXAdNz+aPsVW4tvlht1/qagLtkjLWi7Ak4ptO7KBnU2IbNUXGc1TrxSUbE
 Prggb8GpOn56drvY0HKyVco9P478SaMg6QS/6NZdDKmxBZQeB927R0qVjfD8p3Gb2Rzp
 g3sshtdSakwzA0R00FRxyb9mn6Y/ofpa1i0Op8calMkJNFDKjYtgs9t+Jpq3vmuNy91n
 Pha2UDVLA6u96Py24NxgcFngJMd7RPz6ELJPbnMBvJ5335DPnLznmvfDKT6Jte6gDEBx
 dSaEgmv6jpUukxDW9Cc88vUw7svvT0Q/nbyR8tio0Y3evgxtjbpLK4lXNlUU0pr7zMdr
 DDXg==
X-Gm-Message-State: AFuF++n1884wd+uUbFkxaeEUQZ2bDS2uuLDrreho5EsTH/+IGNJ4Z5tC
 p4Fwu9ikcGzfuwPh01bwSWR+O6z+EbcHS/QEVkcPKpm1NPLW1Ob627+W0EEVtIj/fGG/QyDyT80
 lIvhaSEsFBAUdZyjkH2zNqyCIWqcToBC2UscjJLwEK5/Vds6QtEigoVVsFLenhRNtuz65
X-Gm-Gg: AYBFou3xtUyNBV5+bCtNlP/ygVutT6xhbvRJG9tUK4kMvv4cz5dxakz7cufYNRaMCkQ
 t1dQrqGaVB+aSLX9gElSD8+D1FH3YvCMblYXE7KdoX9suxjn8XnpnPBxel28bmT+3HfSnSTPqnW
 eFZoYpP63h1xIY0YerxM9V8Vsg6WpVbESP1/Cx/rrJzrCLx4tOjOvYjML9LTE/jvJwPEgFnqyzo
 BSwBuj0G7TY1N+pHXtxJZvrzWW93tMA3KnIH58gSfB5PFPSRynyKc+sax7WxRwjeTIdpEfFGjJv
 eRAxbATGM1cJr41mhZjnw9fG5qRI6gTy4xjTNYYUcPFV24L6VbwLy/QWNuvCswE5TkEblaYReA2
 av5ju9Jyv5ZzjJr+tyj7+AUTVPnf/nZ7LHYR768LXS3y1wqD8dnNsYwtN8BtNuNVDXV4axBw7Jo
 mqaKgt6s8MZ2obaKwzT6xXYZ90uFVW2cIs0R791mZ4qZa+c4luR0JFW2+MtXUeROe84hynpzVSI
 bEIRxJ7NEV93ZBFXrzK+FV+/g48nE502tZ97OX5p2nWsal6B5fSq1fOoM3tGjqIFh7cX5aOM9n1
 5lp0+sQZT2vYMnIoKDEcChj0tjIP1DMXBGZ+1C+u1P9jW8BzCDzdu7jG5MhL
X-Received: by 2002:a05:600c:c173:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4a1742e0157mr45725525e9.27.1791221668488; 
 Mon, 05 Oct 2026 10:34:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178db8b09sm8131415e9.13.2026.10.05.10.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:34:27 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 17:34:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: dc3618ecc0140dbbdcd943a42a15a2277efbf198
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cba599b5ed390269c9e15a230d2a92dd75ec7018-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDmaC-0005WF-1D
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
Content-Type: multipart/mixed; boundary="===============5773770620003745593=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5773770620003745593==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mKEwa6DzBWQ="; charset=UTF-8

--mKEwa6DzBWQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#10)=2E

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
M doc/management-note=
s=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=
=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=
=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/options=
=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2E=
h
M src/openvpn/push_util=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_commo=
n=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/m=
ock_management=2Ec
A tests/unit_tests/openvpn/mock_management=2Eh
M tests/u=
nit_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/openvpn/tes=
t_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_tests/openvp=
n/test_common=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tes=
ts/openvpn/test_ssl=2Ec
27 files changed, 1,344 insertions(+), 27 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58=
/1858/10

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index bac4dd4=2E=
=2Ed63d0ef 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -433,6 +=
433,8 @@
     src/compat/compat-gettimeofday=2Ec
     src/compat/compat-str=
sep=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    s=
rc/openvpn/acc=2Eh
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
    =
 src/openvpn/base64=2Ec
@@ -569,9 +571,9 @@
     src/openvpn/ps=2Ec
     sr=
c/openvpn/ps=2Eh
     src/openvpn/push=2Ec
-    src/openvpn/push_util=2Ec
 =
    src/openvpn/push=2Eh
-    src/openvpn/pushlist=2Eh
+    src/openvpn/pus=
h_util=2Ec
+        src/openvpn/pushlist=2Eh
     src/openvpn/reflect_filte=
r=2Ec
     src/openvpn/reflect_filter=2Eh
     src/openvpn/reliable=2Ec
@@ =
-821,7 +823,10 @@
             tests/unit_tests/openvpn/mock_management=2Ec=

             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
          =
   tests/unit_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_t=
ests/openvpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src=
/openvpn/argv=2Ec
+            src/openvpn/auth_token=2Ec
             src/=
openvpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             s=
rc/openvpn/crypto_mbedtls=2Ec
@@ -835,8 +840,11 @@
             src/openvpn=
/options_util=2Ec
             src/openvpn/otime=2Ec
             src/openv=
pn/packet_id=2Ec
+            src/openvpn/reliable=2Ec
+            src/ope=
nvpn/session_id=2Ec
             src/openvpn/run_command=2Ec
             s=
rc/openvpn/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
           =
  src/openvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
       =
      src/openvpn/ssl_verify_mbedtls=2Ec
@@ -853,6 +861,8 @@
     target_so=
urces(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random=
=2Ec
         tests/unit_tests/openvpn/test_schedule=2Ec
+        tests/uni=
t_tests/openvpn/mock_management=2Ec
+        src/openvpn/base64=2Ec
       =
  src/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/=
openvpn/ssl_util=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/d=
oc/man-sections/client-options=2Erst
index 87c138a=2E=2E89ba7cf 100644
--- =
a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-optio=
ns=2Erst
@@ -12,6 +12,17 @@
   When this option is set, OpenVPN will not dr=
op incoming tun packets with
   same destination as host=2E
 
+--app-custom=
-control protocollist
+  Sets the list of supported app custom control prot=
ocols=2E
+  These protocols are announced to the server when this option is=
 used
+  as a client=2E If the option is set on a server it will negotiate =
the
+  common protocols with the client=2E
+
+  The protocollist is a : sep=
arated list of protocol identifiers=2E
+
+  See management-notes=2Etxt in t=
he OpenVPN distribution  and the OpenVPN RFC
+  draft for a description of =
app custom control protocol support=2E
+
 --auth-token token
   This is not=
 an option to be used directly in any configuration files,
   but rather pu=
sh this option from a ``--client-connect`` script or a
diff --git a/doc/man=
agement-notes=2Etxt b/doc/management-notes=2Etxt
index 325f8bd=2E=2E4e4df5e=
 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@=
@ -798,6 +798,58 @@
 The client should return the response to the crtext ch=
allenge
 using the cr-response command=2E
 
+app custom control
+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" =
is passed as {EXTRA} OpenVPN will determine
+the common app custom protocol=
s between the client and the server and instruct
+the client that the serve=
r will send control messages to the client using
+the ACC protocol=2E
+
+Th=
e server should then use acc-msg command to send app custom control message=
s
+to the client to facilitate the pending authentication=2E
+
+COMMAND -- =
client-acc-msg (OpenVPN 2=2E8 or higher)
+---------------------------------=
---------
+
+On an OpenVPN instance running in server mode this command sen=
ds an
+app custom control message to a client=2E The format of the command =
is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+=
  END
+
+CID,KID -- client ID and Key ID=2E See documentation for ">CLIENT:=
"
+notification for more info=2E
+
+protocol -- the ACC protocol identifier=
 that this message should be
+            tagged with=2E
+
+flags    -- a c=
olon separated list of the encoding and the flag if
+            the messag=
e is a fragment=2E E=2Eg=2E "6:F" for a base64 encoded
+            message=
 that is also a fragment and not complete yet=2E
+
+message  -- The message=
 encoded in the encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVP=
N 2=2E8 or higher)
+------------------------------------------
+
+When Open=
VPN is running in --client mode this command sends an app
+custom command t=
o the server=2E The format of the command is
+
+  acc-msg
+  {protocol}
+  =
{flags}
+  {message}
+  END
+
+See the client-acc-msg command for more deta=
ils about the format of the
+message=2E Since a client has only one peer th=
ere is no need to specify the
+client id and key id=2E
+
+
 COMMAND -- clie=
nt-deny  (OpenVPN 2=2E1 or higher)
 ---------------------------------------=
--------
 
@@ -1272,6 +1324,23 @@
    response=2E Mechanisms that need mult=
iple rounds or more complex answers
    should implement a different respon=
se type than CR_RESPONSE=2E
 
+(6) App custom control message
+
+    This m=
essage is an application specific payload message that is transported
+    =
over the OpenVPN control channel=2E
+
+    In server mode:
+
+    >CLIENT:A=
CC,{CID},{KID},{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
=
+    >ACC:{protocol},{fragment},{msg_base64}
+
+    The protocol is a short=
 ascii string identifying the app specific custom
+    protocol=2E If fragm=
ent is set to 1, the message is not complete and the
+    next message shou=
ld be concatenated to this message to form a complete
+    message=2E
 
 Va=
riables:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2E=
am
index 7ecddff=2E=2Ec82e5af 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/=
src/openvpn/Makefile=2Eam
@@ -42,6 +42,7 @@
 sbin_PROGRAMS =3D openvpn
 
 o=
penvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=
=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -121,7 +122,8 @@
 	proto=
=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_=
util=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh =
\
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
d=
iff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 100644
=
index 0000000=2E=2Ecffd850
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 =
+1,396 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks=

+ *             over a single TCP/UDP port, with support for SSL/TLS-based=

+ *             session authentication and key exchange,
+ *             p=
acket encryption, packet authentication, and
+ *             packet compres=
sion=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  =
Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
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
 *  with this program; if not, write to the Free Software Foundation, Inc=
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
+#include <string=2Eh>
+#include "buffer=2Eh"
+#include "error=2E=
h"
+#include "acc=2Eh"
+#include "forward=2Eh"
+#include "options_util=2Eh"=

+#include "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+
+enum acc_message_flag
=
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,=

+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+log_acc_messa=
ge(struct context *c, const struct buffer *buf, int payload_len,
+         =
       const char *protocol, int flags)
+{
+    bool fragment =3D flags & A=
CC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena g=
c =3D gc_new();
+    const char *payload_msg =3D NULL;
+
+    /* For simpli=
city, we always encode payload to be base64 encoded
+     * if not already =
in base64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+     =
   char *b64out =3D NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf),=
 payload_len, &b64out) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
=
+        payload_msg =3D b64out;
+    }
+    else
+    {
+        payload_m=
sg =3D CBSTR(buf);
+    }
+
+    if (management)
+    {
+        struct tls=
_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        st=
ruct man_def_auth_context *mda =3D session->opt->mda_context;
+        if (=
c->options=2Emode =3D=3D MODE_SERVER)
+        {
+            /* server mod=
e=2E Report client context */
+            unsigned int mda_key_id =3D get_=
primary_key(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CL=
IENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol,=
 fragment, payload_msg);
+        }
+        else
+        {
+            /=
* Client mode=2E Do not a report a CLIENT id */
+            msg(M_CLIENT, =
">ACC:%s,%d,%s", protocol, fragment, payload_msg);
+        }
+    }
+    g=
c_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Receiv=
ed custom app control message (protocol '%s'%s)",
+        protocol, fragme=
nt ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses the flags field of an app =
control message and moves the
+ *  buffer past the flags string=2E If there=
 is an
+ *  error parsing the flags field the method returns -1 and
+ *  pu=
ts the error reason in err_reason
+ */
+static int
+parse_acc_message_flags=
(struct buffer *buf, const char **err_reason, struct gc_arena *gc)
+{
+    =
const char *flags =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags)
+=
    {
+        *err_reason =3D "could not extract flags field";
+        re=
turn -1;
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
mon_acc_protocols(struct context *c)
+{
+    if (!c->options=2Eacc_protocol=
s)
+    {
+        /* No app custom protocols have been configured server-s=
ide=2E */
+        return;
+    }
+    if (c->options=2Eacc_negotiated_prot=
ocols)
+    {
+        /* We already have determined the common protocols=
=2E Doing this
+         * again would just add an extra string allocation =
to options->gc */
+        return;
+    }
+
+    struct gc_arena gc =3D gc_=
new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    con=
st char *peer_info =3D c->c2=2Etls_multi->peer_info;
+    char *iv_acc =3D =
extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    =
{
+        gc_free(&gc);
+        return;
+    }
+
+    int max_acc_len =3D=
 0;
+    char *protocols =3D parse_acc_parameters(iv_acc, ",", &max_acc_len=
, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+       =
 msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of peer is malforme=
d");
+        return;
+    }
+
+    char *lasts =3D NULL;
+    const char *=
token =3D strtok_r(protocols, ":", &lasts);
+
+    struct buffer common_pro=
tocols =3D alloc_buf_gc(1024, &gc);
+
+    while (token)
+    {
+        if=
 (tls_item_in_cipher_list(token, c->options=2Eacc_protocols))
+        {
+ =
           /* protocol is in both server and client list */
+            if=
 (buf_len(&common_protocols) > 0)
+            {
+                buf_write=
_u8(&common_protocols, ':');
+            }
+            buf_printf(&common=
_protocols, "%s", token);
+        }
+        token =3D strtok_r(NULL, ":",=
 &lasts);
+    }
+
+    if (buf_len(&common_protocols) =3D=3D 0)
+    {
+  =
      gc_free(&gc);
+        msg(D_PUSH_DEBUG, "WARNING: No common app cust=
om control protocol=2E");
+        return;
+    }
+
+    c->options=2Eacc_n=
egotiated_protocols =3D string_alloc(buf_str(&common_protocols), &c->option=
s=2Egc);
+    c->options=2Eacc_max_message_length =3D max_acc_len;
+    gc_=
free(&gc);
+}
\ No newline at end of file
diff --git a/src/openvpn/acc=2Eh =
b/src/openvpn/acc=2Eh
new file mode 100644
index 0000000=2E=2E5d9b203
--- /=
dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,92 @@
+/*
+ *  OpenVPN -- An =
application to securely tunnel IP networks
+ *             over a single TC=
P/UDP port, with support for SSL/TLS-based
+ *             session authenti=
cation and key exchange,
+ *             packet encryption, packet authenti=
cation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 20=
25 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <=
arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can red=
istribute it and/or modify
+ *  it under the terms of the GNU General Publi=
c License version 2
+ *  as published by the Free Software Foundation=2E
+ =
*
+ *  This program is distributed in the hope that it will be useful,
+ * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General =
Public License for more details=2E
+ *
+ *  You should have received a copy=
 of the GNU General Public License along
+ *  with this program; if not, wr=
ite to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#define ACC_H
+=

+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG=
_LEN 1280
+
+/**
+ * This method parses an app custom control message and d=
elivers it to the
+ * management interface=2E We leave reassembly of fragme=
nted messages to the
+ * management interface=2E
+ *
+ * @param c          =
  The context struct
+ * @param buffer       Buffer containing the control =
message with ACC
+ */
+void
+receive_acc_message(struct context *c, const s=
truct buffer *buffer);
+
+
+bool
+send_acc_message(struct context *c,
+    =
             struct tls_multi *tls_multi,
+                 struct tls_sess=
ion *session,
+                 const char *protocol, bool fragment,
+     =
            const char *msg, bool base64);
+
+
+/**
+ * Parses an info mess=
age from the server that contains app custom control info
+ * information p=
rior to the PUSH_REPLY to be able to use app custom control
+ * protocols b=
efore sending
+ *
+ * In client mode only allow what we support ourselves=
=2E In server mode
+ * allow also capabilities that we not support ourselve=
s=2E
+ *
+ * @param capabilities      The string to parse
+ * @param delim =
            The delimiter to use when parsing the string=2E
+ *            =
              IV_ACC uses "," as delimiter while the
+ *                   =
       custom-control PUSH message uses " " as "," is
+ *                  =
        already used to separate different push directives
+ * @param max_a=
cc_len       Set to the maximum ACC message length
+ * @param server       =
     Whether we are server or client
+ * @param gc                The gc ar=
ena to use for allocating the resulting string
+ * @return                 =
 The resulting protocol string or NULL on error
+ */
+char *
+parse_acc_par=
ameters(const char *capabilities,
+                     const char *delim,
=
+                     int *max_acc_len,
+                     bool server,
=
+                     struct gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of=
 the peer and sets c->options=2Eacc_negotiated_protocols
+ * to the common =
protocols of server and client and
+ * c->options=2Eacc_max_message_length =
 to the maximum length of the ACC message
+ * support by both server and cl=
ient=2E
+ *
+ * If there is no common protocol or the client does not suppo=
rt any app custom
+ * protocol c->options=2Eacc_negotiated_protocols will b=
e set to NULL=2E
+ *
+ * @param c     the client context to use the set the=
 app custom protocols=2E
+ */
+void
+determine_common_acc_protocols(struct =
context *c);
+#endif
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/for=
ward=2Ec
index 1604224=2E=2Edad0764 100644
--- a/src/openvpn/forward=2Ec
++=
+ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #include=
 "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #includ=
e "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
     }
     else if (buf_string_matc=
h_head_str(buf, "INFO_PRE"))
     {
-        server_pushed_info(buf, 8);
+ =
       server_pushed_info(c, buf, 8);
     }
     else if (buf_string_match=
_head_str(buf, "INFO"))
     {
-        server_pushed_info(buf, 4);
+      =
  server_pushed_info(c, buf, 4);
     }
     else if (buf_string_match_head=
_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @@
     {
         recei=
ve_auth_pending(c, buf);
     }
+    else if (buf_string_match_head_str(buf=
, "ACC"))
+    {
+        receive_acc_message(c, buf);
+    }
     else if =
(buf_string_match_head_str(buf, "EXIT"))
     {
         receive_exit_messa=
ge(c);
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 5a5f3=
93=2E=2E090cf31 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2E=
c
@@ -2277,6 +2277,10 @@
             buf_printf(&out, " aead-epoch");
    =
     }
     }
+    if (c->options=2Eacc_negotiated_protocols)
+    {
+     =
   buf_printf(&out, " custom-control %d,A:6,%s", c->options=2Eacc_max_messa=
ge_length, c->options=2Eacc_negotiated_protocols);
+    }
 
     if (BLENZ(=
&out) > strlen(header))
     {
@@ -2521,6 +2525,11 @@
         flags |=3D (=
OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)=

+    {
+        flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ =
-3350,6 +3359,7 @@
     to=2Everify_hash_depth =3D options->verify_hash_dep=
th;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;
     memcpy=
(to=2Ex509_username_field, options->x509_username_field, sizeof(to=2Ex509_u=
sername_field));
+    to=2Eacc_protocols =3D options->acc_protocols;
     t=
o=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4304,6 +431=
4,25 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+management_ac=
c_msg(void *arg,
+                   struct buffer_list *input) /* ownershi=
p transferred */
+{
+    struct context *c =3D arg;
+
+    bool ret =3D fal=
se;
+    if (buffer_list_defined(input) && c->c2=2Etls_multi)
+    {
+     =
   struct tls_multi *multi =3D c->c2=2Etls_multi;
+        struct tls_sessi=
on *session =3D &multi->session[TM_ACTIVE];
+        struct options *opt =
=3D &c->options;
+
+        ret =3D management_send_acc_message(c, multi, s=
ession, opt->acc_negotiated_protocols, input);
+    }
+
+    buffer_list_fr=
ee(input);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 voi=
d
@@ -4320,6 +4349,7 @@
         cb=2Eproxy_cmd =3D management_callback_pro=
xy_cmd;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
      =
   cb=2Esend_cc_message =3D management_callback_send_cc_message;
+        c=
b=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Ene=
twork_change =3D management_callback_network_change;
 #endif
diff --git a/s=
rc/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index a5a7ae6=2E=2E21b05d9 1=
00644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,8 +4=
4,10 @@
 #include "dco=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#in=
clude "acc=2Eh"
 
 #include "memdbg=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef =
ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1080,6 +1082,35 @@
             }
=
             break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (ma=
n->persist=2Ecallback=2Eclient_acc_msg)
+            {
+                boo=
l status =3D (*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecal=
lback=2Earg,
+                                                             =
         man->connection=2Ein_extra_cid,
+                                 =
                                     man->connection=2Ein_extra_kid,
+     =
                                                                 man->conne=
ction=2Ein_extra);
+                man->connection=2Ein_extra =3D NULL;
+ =
               report_command_status(status, "client-acc-msg");
+          =
  }
+            else
+            {
+                man_command_unsupport=
ed("client-acc-msg");
+            }
+            break;
+
+        case IE=
C_ACC_MSG:
+            if (man->persist=2Ecallback=2Eacc_msg)
+           =
 {
+                bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(ma=
n->persist=2Ecallback=2Earg,
+                                             =
                  man->connection=2Ein_extra);
+                man->connec=
tion=2Ein_extra =3D NULL;
+                report_command_status(status, "a=
cc-msg");
+            }
+            else
+            {
+                =
man_command_unsupported("acc-msg");
+            }
+            break;
    =
     case IEC_PK_SIGN:
             man->connection=2Eext_key_state =3D EKS=
_READY;
             buffer_list_free(man->connection=2Eext_key_input);
@@ =
-1204,6 +1235,29 @@
 }
 
 static void
+man_client_acc_msg(struct management=
 *man, const char *cid_str,
+                   const char *kid_str)
+{
+  =
  struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cid =3D=
 0;
+    mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_=
cid)
+        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+   =
     mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, I=
ER_NEW);
+    }
+}
+
+static void
+man_acc_msg(struct management *man)
+{
+=
    struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cmd =
=3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_c=
lient_auth(struct management *man, const char *cid_str, const char *kid_str=
, const bool extra)
 {
     struct man_connection *mc =3D &man->connection;=

@@ -1758,6 +1812,17 @@
             man_client_pending_auth(man, p[1], p[2=
], p[3], p[4]);
         }
     }
+    else if (streq(p[0], "client-acc-msg=
"))
+    {
+        if (man_need(p, 2, 0))
+        {
+            man_clie=
nt_acc_msg(man, p[1], p[2]);
+        }
+    }
+    else if (streq(p[0], "a=
cc-msg"))
+    {
+        man_acc_msg(man);
+    }
     else if (streq(p[0]=
, "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -3131,6 +3196,=
7 @@
     }
 }
 
+
 void
 management_connection_established(struct manageme=
nt *man, struct man_def_auth_context *mdac,
                               =
    const struct env_set *es)
@@ -4360,6 +4426,62 @@
     }
 }
 
+bool
+man=
agement_send_acc_message(struct context *c, struct tls_multi *multi, struct=
 tls_session *session,
+                            const char *negotiated_=
protocols, struct buffer_list *input)
+{
+    /* also ensures that are enou=
gh inputs in the list to safely call
+     * buffer_list_peek without extra=
 NULL checks */
+    if (!input || input->size < 3)
+    {
+        msg(M_C=
LIENT, "not enough input lines for sending acc message, "
+                =
      "missing protocol, flag and/or messages lines");
+        return fals=
e;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    const struct buffe=
r *proto_buf =3D buffer_list_peek(input);
+    const char *protocol =3D str=
ing_alloc(CBSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+    struc=
t buffer *encoding_buf =3D buffer_list_peek(input);
+    char *encoding =3D=
 buf_str(encoding_buf);
+    const char *flag =3D NULL;
+    bool b64encodi=
ng =3D false;
+    bool fragment =3D false;
+
+    while ((flag =3D strsep(=
&encoding, ":")))
+    {
+        if (!strcmp(flag, "6"))
+        {
+     =
       b64encoding =3D true;
+        }
+        else if (!strcmp(flag, "F"=
))
+        {
+            fragment =3D true;
+        }
+    }
+    buffer=
_list_pop(input);
+
+    buffer_list_aggregate_separator(input, 10000, "");=

+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);
+
+    =
if (!negotiated_protocols || !tls_item_in_cipher_list(protocol, negotiated_=
protocols))
+    {
+        msg(M_CLIENT, "protocol not in the list of nego=
tiated protocols: %s", np(negotiated_protocols));
+        goto error;
+   =
 }
+
+    bool ret =3D send_acc_message(c, multi, session, protocol,
+     =
                           fragment, buf_cstr(acc_msg_buf),
+              =
                  b64encoding);
+    gc_free(&gc);
+    return ret;
+error:=

+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef ENABLE_MANAGEMENT=
 */
 
 #include "win32=2Eh"
diff --git a/src/openvpn/manage=2Eh b/src/openv=
pn/manage=2Eh
index 31577e4=2E=2E4eebf75 100644
--- a/src/openvpn/manage=2E=
h
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (*n_clients)(=
void *arg);
     bool (*send_cc_message)(void *arg, const char *message, co=
nst char *parameter);
     bool (*kill_by_cid)(void *arg, const unsigned lo=
ng cid, const char *kill_msg);
+
     bool (*client_auth)(void *arg, const =
unsigned long cid, const unsigned int mda_key_id,
                         =
const bool auth, const char *reason, const char *client_reason,
           =
              struct buffer_list *cc_config); /* ownership transferred */
 =
    bool (*client_pending_auth)(void *arg, const unsigned long cid, const u=
nsigned int kid,
                                 const char *extra, unsign=
ed int timeout);
     char *(*get_peer_info)(void *arg, const unsigned long=
 cid);
+    bool (*client_acc_msg)(void *arg,
+                           c=
onst unsigned long cid,
+                           const unsigned int mda_=
key_id,
+                           struct buffer_list *msg);
+    bool (*a=
cc_msg)(void *arg,
+                    struct buffer_list *msg);
     bool=
 (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cmd)(void *arg=
, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
     struct=
 command_line *in;
     struct buffer_list *out;
 
-#define IEC_UNDEF      =
 0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#define IEC_CL=
IENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#define =
IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#d=
efine IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#define IEC_CERTIFIC=
ATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWORD       6
+#defi=
ne IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int in_extra_cmd=
;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid;
@@ -5=
03,6 +512,14 @@
 
 void man_persist_client_stats(struct management *man, st=
ruct context *c);
 
+/** Parses the ACC message from the input buffer_list =
and send to the
+ * session identified by session and multi
+ */
+struct tl=
s_session;
+struct tls_multi;
+bool
+management_send_acc_message(struct con=
text *c, struct tls_multi *multi, struct tls_session *session,
+           =
                 const char *negotiated_protocols, struct buffer_list *inpu=
t);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index 81c2fca=2E=2Ed01a7bf 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include=
 "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#includ=
e "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1795,6 +1796,13 @@
=
         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }
 
+ =
   if (o->acc_protocols)
+    {
+        /* If ACC is enabled server side c=
all to find common acc protocols,
+         * will be pushed during push me=
ssage */
+        determine_common_acc_protocols(c);
+    }
+
     /* Selec=
t cipher if client supports Negotiable Crypto Parameters */
 
     /* if we=
 have already created our key, we cannot *change* our own
@@ -4084,6 +4092,=
24 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(struct =
context *c, struct gc_arena *gc)
+{
+    determine_common_acc_protocols(c);=

+
+    if (!c->options=2Eacc_negotiated_protocols)
+    {
+        msg(M_C=
LIENT, "ACC: No negotiated protocols");
+        return NULL;
+    }
+
+   =
 struct buffer buf =3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC=
:%d A:6 %s", c->options=2Eacc_max_message_length, c->options=2Eacc_negotiat=
ed_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 management_c=
lient_pending_auth(void *arg, const unsigned long cid, const unsigned int m=
da_key_id,
                                const char *extra, unsigned int =
timeout)
@@ -4094,10 +4120,22 @@
     if (mi)
     {
         struct tls_mu=
lti *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =
=3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+            e=
xtra =3D calculate_app_control_extra(&mi->context, &gc);
+            if (!=
extra)
+            {
+                gc_free(&gc);
+                retur=
n false;
+            }
+        }
         struct tls_session *session =3D=
 lookup_session_by_mda_key_id(multi, mda_key_id);
 
         if (!session)
=
         {
+            gc_free(&gc);
             return false;
         }=

 
@@ -4105,6 +4143,7 @@
         bool ret =3D send_auth_pending_messages(m=
ulti, session, extra, timeout);
         reschedule_multi_process(&mi->cont=
ext);
         multi_schedule_context_wakeup(m, mi);
+        gc_free(&gc);=

         return ret;
     }
     return false;
@@ -4148,6 +4187,39 @@
    =
 return ret;
 }
 
+
+static bool
+management_client_acc_msg(void *arg,
+   =
                       const unsigned long cid,
+                          =
const unsigned int mda_key_id,
+                          struct buffer_lis=
t *input) /* ownership transferred */
+{
+    struct multi_context *m =3D (=
struct multi_context *)arg;
+    struct multi_instance *mi =3D lookup_by_ci=
d(m, cid);
+
+    bool ret =3D false;
+    if (mi && buffer_list_defined(in=
put))
+    {
+        struct tls_multi *multi =3D mi->context=2Ec2=2Etls_mu=
lti;
+        struct tls_session *session =3D lookup_session_by_mda_key_id(=
multi, mda_key_id);
+        if (!session)
+        {
+            msg(M_CL=
IENT, "client session not found");
+            buffer_list_free(input);
+ =
           return false;
+        }
+
+        struct options *opt =3D &mi-=
>context=2Eoptions;
+
+        ret =3D management_send_acc_message(&mi->con=
text, multi, session, opt->acc_negotiated_protocols, input);
+        multi=
_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(input);
+  =
  return ret;
+}
+
+
 static char *
 management_get_peer_info(void *arg, co=
nst unsigned long cid)
 {
@@ -4184,6 +4256,7 @@
         cb=2En_clients =3D=
 management_callback_n_clients;
         cb=2Ekill_by_cid =3D management_ki=
ll_by_cid;
         cb=2Eclient_auth =3D management_client_auth;
+        c=
b=2Eclient_acc_msg =3D management_client_acc_msg;
         cb=2Eclient_pend=
ing_auth =3D management_client_pending_auth;
         cb=2Eget_peer_info =
=3D management_get_peer_info;
         cb=2Epush_update_broadcast =3D manag=
ement_callback_send_push_update_broadcast;
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 231a835=2E=2E30b935c 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #inc=
lude "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include "=
error=2Eh"
 #include "common=2Eh"
@@ -7133,6 +7134,28 @@
         VERIFY_PE=
RMISSION(OPT_P_GENERAL);
         options->force_key_material_export =3D tr=
ue;
     }
+    else if (streq(p[0], "app-custom-control") && p[1] && !p[2]=
)
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->acc_p=
rotocols =3D p[1];
+    }
+    else if (streq(p[0], "custom-control") && p[=
1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC);
=
+
+        if (!streq(p[2], "A:6") && !streq(p[2], "6:A"))
+        {
+    =
        msg(msglevel, "App custom control encoding must be base64 and ascii=
");
+            goto err;
+        }
+
+        if (!atoi_constrained(p[1]=
, &options->acc_max_message_length,
+                              "app cus=
tom message message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+=
        {
+            goto err;
+        }
+        options->acc_negotiate=
d_protocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !=
p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL libra=
ry PRNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opti=
ons=2Eh
index 4cd9ef5=2E=2Ef603eb0 100644
--- a/src/openvpn/options=2Eh
+++=
 b/src/openvpn/options=2Eh
@@ -712,6 +712,16 @@
     /* force using TLS key=
 material export for data channel key generation */
     bool force_key_mat=
erial_export;
 
+    /** The app custom control protocols we should announc=
e as supported */
+    const char *acc_protocols;
+
+    /** the protocols =
that are negotiated with the peer=2E As a client we
+     * trust the serve=
r pushed list here */
+    const char *acc_negotiated_protocols;
+
+    /**=
 the maximum length of an ACC control channel message */
+    int acc_max_m=
essage_length;
+
     bool vlan_tagging;
     enum vlan_acceptable_frames v=
lan_accept;
     uint16_t vlan_pvid;
@@ -763,8 +773,10 @@
 #define OPT_P_IN=
LINE          (1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define=
 OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 3=
2)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEE=
R_ID | 0x0ull))
+/* Options allowed in the normal configuration file (vs pu=
shed options or in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE |=
 OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt)=
 ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
i=
ndex 0e281d2=2E=2Ee456077 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openv=
pn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh=
"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #include "crypto=2Eh"
 #in=
clude "ssl=2Eh"
@@ -220,9 +222,8 @@
 #endif
 }
 
-
 void
-server_pushed_inf=
o(const struct buffer *buffer, const int adv)
+server_pushed_info(struct co=
ntext *c, const struct buffer *buffer, const int adv)
 {
     const char *m=
 =3D "";
     struct buffer buf =3D *buffer;
@@ -232,6 +233,27 @@
         =
m =3D BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
=
+        int max_acc_len =3D 0;
+
+
+        /* example string to parse: AC=
C:1400 A:6 flower:happy */
+        /* Skip over the ACC: prefix */
+      =
  m +=3D 4;
+
+        char *protocols =3D parse_acc_parameters(m, " ", &ma=
x_acc_len, false, &c->options=2Egc);
+        if (protocols)
+        {
+  =
          c->options=2Eacc_negotiated_protocols =3D protocols;
+           =
 c->options=2Eacc_max_message_length =3D max_acc_len;
+        }
+        e=
lse
+        {
+            msg(D_PUSH_ERRORS, "WARNING: Received ACC info =
command with invalid parameters");
+        }
+    }
+
 #ifdef ENABLE_MANAG=
EMENT
     struct gc_arena gc;
     if (management)
@@ -284,6 +306,7 @@
   =
  msg(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
+
 /**
  * =
Parse the keyword for the AUTH_PENDING request
  * @param buffer           =
     buffer containing the keywords, the buffer's
@@ -440,7 +463,6 @@
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
@@ -731,6 +753,11 @@
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
f --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 02130=
41=2E=2Eeae6c35 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/pu=
sh_util=2Ec
@@ -368,4 +368,4 @@
 
     RETURN_UPDATE_STATUS(n_sent);
 }
-#e=
ndif /* ifdef ENABLE_MANAGEMENT */
+#endif /* ifdef ENABLE_MANAGEMENT */
\ =
No newline at end of file
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ss=
l=2Ec
index aeec020=2E=2E73ca54c 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src=
/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include=
 "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_ba=
ckend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -2105,6 +2106,11 @@
                 =
    }
                 }
             }
+
+            if (session->opt->ac=
c_protocols)
+            {
+                buf_printf(&out, "IV_ACC=3D%d,=
6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+            }
  =
       }
     }
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl=
_common=2Eh
index 6b86bc0=2E=2E0270c23 100644
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
index 5430ecb=2E=2Ed864a8f 100644
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
@ -389,6 +394,7 @@
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
 	$(=
top_srcdir)/src/openvpn/session_id=2Ec
 
+
 push_update_msg_testdriver_CFLA=
GS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(t=
op_srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/openvpn=
/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index 7=
7f6ce2=2E=2Ecddd669 100644
--- a/tests/unit_tests/openvpn/mock_management=
=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 =

 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
=
 #ifdef ENABLE_MANAGEMENT
@@ -60,4 +61,4 @@
 void
 management_sleep(const i=
nt n)
 {
-}
+}
\ No newline at end of file
diff --git a/tests/unit_tests/op=
envpn/mock_management=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh
ne=
w file mode 100644
index 0000000=2E=2Ee21aec43
--- /dev/null
+++ b/tests/un=
it_tests/openvpn/mock_management=2Eh
@@ -0,0 +1,32 @@
+/*
+ *  OpenVPN -- A=
n application to securely tunnel IP networks
+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based
+ *             session authen=
tication and key exchange,
+ *             packet encryption, packet authen=
tication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) =
2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe=
 <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can r=
edistribute it and/or modify
+ *  it under the terms of the GNU General Pub=
lic License version 2
+ *  as published by the Free Software Foundation=2E
=
+ *
+ *  This program is distributed in the hope that it will be useful,
+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Genera=
l Public License for more details=2E
+ *
+ *  You should have received a co=
py of the GNU General Public License along
+ *  with this program; if not, =
write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fif=
th Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef MOCK_MANAGEMENT_H
+#=
define MOCK_MANAGEMENT_H
+void init_mock_management(void);
+
+void uninit_m=
ock_management(void);
+
+#endif
diff --git a/tests/unit_tests/openvpn/mock_=
push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec=

index 112bcfd=2E=2Ec16d0cb 100644
--- a/tests/unit_tests/openvpn/mock_push=
_dependencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec=

@@ -43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | =
OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_=
P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      |=
 OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-   =
                  | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUT=
E | OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_=
P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;=

     return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec=
 b/tests/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=
=2E=2E16b2b3b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ =
-0,0 +1,298 @@
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
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=
=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
=
+
+#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include "test_common=2Eh"
=
+
+#include "mock_msg=2Eh"
+
+char control_channel_mesage_sent[2048];
+
+/*=
 Mock functions */
+bool
+send_control_channel_string_dowork(struct tls_ses=
sion *session,
+                                   const char *str, int msg=
level)
+{
+    assert_int_in_range(strlen(str), 0, 2048);
+
+    memcpy(con=
trol_channel_mesage_sent, str, strlen(str));
+    return true;
+}
+
+void
+=
send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set=
_client_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#defin=
e MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+ =
                   "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS"=
 \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKAB=
rwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIA=
CgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AM=
AAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQ=
MDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACC=
k4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D=
"
+
+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENABLE_=
MANAGEMENT
+    skip();
+#else
+    /* ensure that the messages get to mock=
_msg */
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678;
+=
    struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientH=
ello */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    str=
uct buffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=2Emod=
e =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls=
_multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=2E=
c2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->mda=
_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void *)msg=
, sizeof(msg));
+    receive_acc_message(&c, &msg_buf);
+
+    assert_strin=
g_equal(mock_msg_buf, "Received custom app control message (protocol 'cck1'=
)");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0,"=
 MSG_PAYLOAD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAA=
IEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, =
(void *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_=
buf);
+    assert_string_equal(mock_msg_buf, "Received custom app control m=
essage (protocol 'flower')");
+    assert_string_equal(mock_managment_buf, =
">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=
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
index 052dea8=2E=2E225bcae 100644
--- a/tests/unit_=
tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@=
 -41,10 +41,34 @@
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
 #include=
 "sid_hash=2Eh"
+#include "test_schedule=2Eh"
+#include "multi=2Eh"
+
 #ifd=
ef _WIN32
 #include "win32-util=2Eh"
 #endif
-#include "test_schedule=2Eh"
=
+
+/* extra mocks */
+bool
+apply_push_options(struct context *c, struct op=
tions *options, struct buffer *buf,
+                   uint64_t permission=
_mask, uint64_t *option_types_found,
+                   struct env_set *es=
, bool is_update)
+{
+    return true;
+}
+
+bool
+send_control_channel_str=
ing(struct context *c, const char *str, msglvl_t msglevel)
+{
+    check_ex=
pected_ptr(str);
+    return true;
+}
+
+struct multi_instance *
+lookup_by=
_cid(struct multi_context *m, const unsigned long cid)
+{
+    return *(m->=
instances);
+}
 
 static void
 test_compat_lzo_string(void **state)
diff --=
git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test=
_ssl=2Ec
index 4baf8cc=2E=2Ef4841cd 100644
--- a/tests/unit_tests/openvpn/t=
est_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 =
#include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_acc=2Eh=
"
+
 /* Mock function to be allowed to include win32=2Ec which is required =
for
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
=
+/* Define a dummy dco cipher option to avoid linking against all the DCO
+=
 * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphe=
rs(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CH=
ACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req -x509 -n=
ewkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -1111,8 +1127,=
11 @@
         cmocka_unit_test(ssl_test_extract_last_matching_field),
    =
     cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
         cmock=
a_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
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
Gerrit-PatchSet: 10
Gerrit-Owner: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--mKEwa6DzBWQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #10</strong> to this change=2E</p><p>=
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
ptions=2Erst<br>M doc/management-notes=2Etxt<br>M src/openvpn/Makefile=2Eam=
<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M src/openvpn/forward=
=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn=
/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M sr=
c/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<b=
r>M src/openvpn/push_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=
_common=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tes=
ts/openvpn/mock_management=2Ec<br>A tests/unit_tests/openvpn/mock_managemen=
t=2Eh<br>M tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>A tests/u=
nit_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Eh<b=
r>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/unit_tests/openvpn/=
test_misc=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>27 files change=
d, 1,344 insertions(+), 27 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/10</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index bac=
4dd4=2E=2Ed63d0ef 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><=
span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -433,6 +433,8 @@</span><br><=
span>     src/compat/compat-gettimeofday=2Ec</span><br><span>     src/compa=
t/compat-strsep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=
=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><span>     src/ope=
nvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><span>@=
@ -569,9 +571,9 @@</span><br><span>     src/openvpn/ps=2Ec</span><br><span>=
     src/openvpn/ps=2Eh</span><br><span>     src/openvpn/push=2Ec</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/push_util=2Ec</=
span><br><span>     src/openvpn/push=2Eh</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    src/openvpn/pushlist=2Eh</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    src/openvpn/push_util=2Ec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/pushlist=2Eh</spa=
n><br><span>     src/openvpn/reflect_filter=2Ec</span><br><span>     src/op=
envpn/reflect_filter=2Eh</span><br><span>     src/openvpn/reliable=2Ec</spa=
n><br><span>@@ -821,7 +823,10 @@</span><br><span>             tests/unit_te=
sts/openvpn/mock_management=2Ec</span><br><span>             tests/unit_tes=
ts/openvpn/mock_ssl_dependencies=2Ec</span><br><span>             tests/uni=
t_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            tests/unit_tests/openvpn/test_acc=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/acc=
=2Ec</span><br><span>             src/openvpn/argv=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/auth_token=2Ec</=
span><br><span>             src/openvpn/base64=2Ec</span><br><span>        =
     src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/=
crypto_mbedtls=2Ec</span><br><span>@@ -835,8 +840,11 @@</span><br><span>   =
          src/openvpn/options_util=2Ec</span><br><span>             src/ope=
nvpn/otime=2Ec</span><br><span>             src/openvpn/packet_id=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/r=
eliable=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    src/openvpn/session_id=2Ec</span><br><span>             src/openvpn/run=
_command=2Ec</span><br><span>             src/openvpn/ssl_mbedtls=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/s=
sl_ncp=2Ec</span><br><span>             src/openvpn/ssl_openssl=2Ec</span><=
br><span>             src/openvpn/ssl_util=2Ec</span><br><span>            =
 src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -853,6 +861,8 @@</sp=
an><br><span>     target_sources(test_misc PRIVATE</span><br><span>        =
 tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>         test=
s/unit_tests/openvpn/test_schedule=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_management=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/bas=
e64=2Ec</span><br><span>         src/openvpn/options_util=2Ec</span><br><sp=
an>         src/openvpn/otime=2Ec</span><br><span>         src/openvpn/ssl_=
util=2Ec</span><br><span>diff --git a/doc/man-sections/client-options=2Erst=
 b/doc/man-sections/client-options=2Erst</span><br><span>index 87c138a=2E=
=2E89ba7cf 100644</span><br><span>--- a/doc/man-sections/client-options=2Er=
st</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><s=
pan>@@ -12,6 +12,17 @@</span><br><span>   When this option is set, OpenVPN =
will not drop incoming tun packets with</span><br><span>   same destination=
 as host=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+--app-custom-control protocollist</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  Sets the list of supported app custom control pro=
tocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  These pr=
otocols are announced to the server when this option is used</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  as a client=2E If the option is =
set on a server it will negotiate the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  common protocols with the client=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  The protocollist is a : separated list of protocol ident=
ifiers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  See management-notes=2Etxt =
in the OpenVPN distribution  and the OpenVPN RFC</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  draft for a description of app custom contro=
l protocol support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> --auth-token token</span><br><span>   This is not an op=
tion to be used directly in any configuration files,</span><br><span>   but=
 rather push this option from a ``--client-connect`` script or a</span><br>=
<span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt<=
/span><br><span>index 325f8bd=2E=2E4e4df5e 100644</span><br><span>--- a/doc=
/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</s=
pan><br><span>@@ -798,6 +798,58 @@</span><br><span> The client should retur=
n the response to the crtext challenge</span><br><span> using the cr-respon=
se command=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+app custom control</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+If the special string &quot;A=
CC&quot; is passed as {EXTRA} OpenVPN will determine</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the common app custom protocols between t=
he client and the server and instruct</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+the client that the server will send control messages to =
the client using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the=
 ACC protocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+The server should then=
 use acc-msg command to send app custom control messages</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+to the client to facilitate the pendin=
g authentication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-a=
cc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+------------------------------------------</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+On an OpenVPN instance running in server mode this command=
 sends an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+app custom=
 control message to a client=2E The format of the command is:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID -- client ID and=
 Key ID=2E See documentation for &quot;&gt;CLIENT:&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+notification for more info=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+protocol -- the ACC protocol identifier that th=
is message should be</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            tagged with=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+flags    --=
 a colon separated list of the encoding and the flag if</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            the message is a fragment=
=2E E=2Eg=2E &quot;6:F&quot; for a base64 encoded</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            message that is also a fragment a=
nd not complete yet=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+message  -- The =
message encoded in the encoding specified in flags</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND=
 -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+------------------------------------------</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+When OpenVPN is running in --client mode this command=
 sends an app</span><br><span style=3D"color: hsl(120, 100%, 40%);">+custom=
 command to the server=2E The format of the command is</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  acc-msg</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+See the client-acc-msg command for more details abou=
t the format of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
message=2E Since a client has only one peer there is no need to specify the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+client id and key i=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- clien=
t-deny  (OpenVPN 2=2E1 or higher)</span><br><span> ------------------------=
-----------------------</span><br><span> </span><br><span>@@ -1272,6 +1324,=
23 @@</span><br><span>    response=2E Mechanisms that need multiple rounds =
or more complex answers</span><br><span>    should implement a different re=
sponse type than CR_RESPONSE=2E</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+(6) App custom control message</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    This message is an application specific payload m=
essage that is transported</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    over the OpenVPN control channel=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    In server mode:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLI=
ENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    In client mode:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &gt;ACC:{protocol},{fragment},{msg_base64}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    The protocol is a short ascii string identifying the app specific =
custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocol=
=2E If fragment is set to 1, the message is not complete and the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    next message should be con=
catenated to this message to form a complete</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    message=2E</span><br><span> </span><br><span> =
Variables:</span><br><span> </span><br><span>diff --git a/src/openvpn/Makef=
ile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7ecddff=2E=2Ec82=
e5af 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span=
>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -42,6 +42,7 @@</span><b=
r><span> sbin_PROGRAMS =3D openvpn</span><br><span> </span><br><span> openv=
pn_SOURCES =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	ac=
c=2Ec acc=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	aut=
h_token=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</spa=
n><br><span>@@ -121,7 +122,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</sp=
an><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec pu=
sh=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec p=
ush=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push_util=
=2Ec \</span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2E=
c reflect_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span>=
<br><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2Ecffd850</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><b=
r><span>@@ -0,0 +1,396 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
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
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum acc_me=
ssage_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII=
 =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESS=
AGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+log_acc_message(struct context *c, const =
struct buffer *buf, int payload_len,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                const char *protocol, int flags)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool fragment =3D flags &amp; ACC_MESSAGE_F=
LAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *payload_msg =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* For simplicity, we always encode payload to be base6=
4 encoded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if =
not already in base64 format */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        char *b64out =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(openvpn_base64_encode(CBPT=
R(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        gc_addspecial(b64out, free, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D=
 b64out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        payload_msg =3D CBSTR(buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (management)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_=
ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct man_def_auth_co=
ntext *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (c-&gt;options=2Emode =3D=3D MODE_SE=
RVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* server mo=
de=2E Report client context */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=
=2Etls_multi)-&gt;mda_key_id;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 mda-&gt;cid, mda_key_id, protocol, fragment, payload_msg);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            /* Client mode=2E Do not a report a CLIENT id */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLI=
ENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payload_msg);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received =
custom app control message (protocol &#39;%s&#39;%s)&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment ? &quot;=
, fragment&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Parses the flags field of an app control message and =
moves the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  buffer=
 past the flags string=2E If there is an</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  error parsing the flags field the method returns -=
1 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  puts the e=
rror reason in err_reason</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_f=
lags(struct buffer *buf, const char **err_reason, struct gc_arena *gc)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *flags =3D buf_extract_fie=
ld(buf, &#39;,&#39;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!flag=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D &quot;c=
ould not extract flags field&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int acc_flags =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (const char *flag =3D flags; *flag !=3D &#3=
9;\0&#39;; flag++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (*fl=
ag =3D=3D &#39;A&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else if (*flag =3D=3D &#39;6&#39;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BA=
SE64;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =
=3D=3D &#39;F&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          *err_reason =3D &quot;Unknown flag in flags&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* The message should be encoded with exactly one e=
ncoding=2E Ensure that</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * only one of the flags is present */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_=
MESSAGE_FLAGS_ASCII);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool base64enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512,=
 1, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snp=
rintf(tmp, 512, &quot;number of encodings must be exactly one &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 &quot;(B64=3D%d, ASCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 base64enc, asciienc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D tmp;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return acc_flags;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+receive_acc_message(struct context *c, const struct buff=
er *buffer)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *err_reason =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *buffer;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&qu=
ot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        err_reason =3D &quot;missing , after ACC&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* extract protocol, payload length, flags sub=
strings */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char =
*protocol =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!protocol)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could not extrac=
t protocol field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int payload_len;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *payload_len_str =3D =
buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!payload_len_str || !((payload_len =
=3D atoi(payload_len_str))))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   err_reason =3D &quot;could not extract payload length field&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int flags =3D parse_acc_message_flags(&amp;buf, &amp;err=
_reason, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &lt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* We should have a final NUL byte in the control message buffe=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and thus th=
e length of the buffer should be payload_len + 1 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf) !=3D payload_le=
n + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_ma=
lloc(512, 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        snprintf(tmp, 512, &quot;field length %d, payload length %d mism=
atch&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         payload_len, buf_len(&amp;buf) - 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    log_acc_messag=
e(c, &amp;buf, payload_len, protocol, flags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH=
_ERRORS, &quot;WARNING: Received malformed custom app control channel &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
     &quot;(%s) message control message: %s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        err_reason,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        format_hex(BPTR(&amp;buf), BLEN(&amp=
;buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+send_acc_message(struct context *c,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 struct tls_multi *tls_multi,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct t=
ls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 const char *protocol, bool fragment,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 const char *msg, bool b=
ase64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * length of the protocol string + one &=
#39;,&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 2 =
for the encoding (A or 6), potential F (fragment), and 1 for the &#39;,&#39=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 4 for the =
message size itself and one comma</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * 1 for the comma before the message itself */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t max_header_s=
ize =3D strlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D max=
_header_size + strlen(msg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len=
 &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_CLIENT, &quot;message length (%zu) exceeds maximum possible message=
 length (%d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if ((int)len &gt; c-&gt;options=2Eacc_max_message_length)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;header (%zu) + message=
 size (%zu) length (%zu) exceeds &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                      &quot;maximum allowed length nego=
tiated with peer (%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            max_header_size, strlen(msg), len,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Eacc_max_mes=
sage_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* add 1 for the=
 final \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer buf =3D alloc_buf_gc(len + 1, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf=
, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+               strlen(msg),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+               base64 ? &quot;6&quot; : &=
quot;A&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
         fragment ? &quot;F&quot; : &quot;&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+               msg);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    send_control_channel_string_dowork(session, BSTR(&amp;buf),=
 D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    resche=
dule_multi_process(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
const char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    int *max_acc_len,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                     bool server,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     struct gc_arena *gc)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string_allo=
c(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *tmp_message_orig =3D tmp_message;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=
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
><br><span>index 1604224=2E=2Edad0764 100644</span><br><span>--- a/src/open=
vpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><sp=
an>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</span><b=
r><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #include &quo=
t;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #include=
 &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -257,11 +258,1=
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
an>     {</span><br><span>@@ -271,6 +272,10 @@</span><br><span>     {</span=
><br><span>         receive_auth_pending(c, buf);</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (buf_strin=
g_match_head_str(buf, &quot;ACC&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        receive_acc_message(c, buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span>     else if (buf_string_match=
_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {</span><br><span>  =
       receive_exit_message(c);</span><br><span>diff --git a/src/openvpn/in=
it=2Ec b/src/openvpn/init=2Ec</span><br><span>index 5a5f393=2E=2E090cf31 10=
0644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/o=
penvpn/init=2Ec</span><br><span>@@ -2277,6 +2277,10 @@</span><br><span>    =
         buf_printf(&amp;out, &quot; aead-epoch&quot;);</span><br><span>   =
      }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot; custom-contr=
ol %d,A:6,%s&quot;, c-&gt;options=2Eacc_max_message_length, c-&gt;options=
=2Eacc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span> </span><br><span>     if (BLENZ(&amp;out) =
&gt; strlen(header))</span><br><span>     {</span><br><span>@@ -2521,6 +252=
5,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     return flags;</span><br><span> =
}</span><br><span> </span><br><span>@@ -3350,6 +3359,7 @@</span><br><span> =
    to=2Everify_hash_depth =3D options-&gt;verify_hash_depth;</span><br><sp=
an>     to=2Everify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br=
><span>     memcpy(to=2Ex509_username_field, options-&gt;x509_username_fiel=
d, sizeof(to=2Ex509_username_field));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    to=2Eacc_protocols =3D options-&gt;acc_protocols;</sp=
an><br><span>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_=
ctx =3D &amp;c-&gt;net_ctx;</span><br><span> </span><br><span>@@ -4304,6 +4=
314,25 @@</span><br><span> }</span><br><span> #endif /* ifdef TARGET_ANDROI=
D */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manag=
ement_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                   struct buffer_list *input) /* ownership transferred=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D arg;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (buffer_list_defined(input) &a=
mp;&amp; c-&gt;c2=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100=
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
100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br=
><span> </span><br><span> void</span><br><span>@@ -4320,6 +4349,7 @@</span>=
<br><span>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span>=
<br><span>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</spa=
n><br><span>         cb=2Esend_cc_message =3D management_callback_send_cc_m=
essage;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=
=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</=
span><br><span>         cb=2Enetwork_change =3D management_callback_network=
_change;</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index a5a7ae6=2E=2E21b05=
d9 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ =
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
p;man-&gt;connection;</span><br><span>@@ -1758,6 +1812,17 @@</span><br><spa=
n>             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);</span>=
<br><span>         }</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;client-acc-msg&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            man_client_acc_msg=
(man, p[1], p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], =
&quot;acc-msg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_=
acc_msg(man);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span>     else if (streq(p[0], &quot;rsa-sig&quot;))</span><br><=
span>     {</span><br><span>         man_pk_sig(man, &quot;rsa-sig&quot;);<=
/span><br><span>@@ -3131,6 +3196,7 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> void</span><br><span> management_connection_establishe=
d(struct management *man, struct man_def_auth_context *mdac,</span><br><spa=
n>                                   const struct env_set *es)</span><br><s=
pan>@@ -4360,6 +4426,62 @@</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_mes=
sage(struct context *c, struct tls_multi *multi, struct tls_session *sessio=
n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
           const char *negotiated_protocols, struct buffer_list *input)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* also ensures that are enough input=
s in the list to safely call</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * buffer_list_peek without extra NULL checks */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size =
&lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quo=
t;not enough input lines for sending acc message, &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                      &quot;missing pr=
otocol, flag and/or messages lines&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct buffer *proto_buf =3D buffer_list_peek(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =3D string_alloc=
(CBSTR(proto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(encod=
ing_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *flag =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool b64encoding =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool fragment =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    while ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            b64encoding =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        else if (!strcmp(flag,=
 &quot;F&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            f=
ragment =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(i=
nput, 10000, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!negotiated_protocols || !tls_it=
em_in_cipher_list(protocol, negotiated_protocols))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the list of ne=
gotiated protocols: %s&quot;, np(negotiated_protocols));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool ret =3D send_acc_message(c, multi, session, protocol,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    fragment, buf_cstr(acc_msg_buf),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                b64encoding);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGE=
MENT */</span><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</=
span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh=
</span><br><span>index 31577e4=2E=2E4eebf75 100644</span><br><span>--- a/sr=
c/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br=
><span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_clients)(void *ar=
g);</span><br><span>     bool (*send_cc_message)(void *arg, const char *mes=
sage, const char *parameter);</span><br><span>     bool (*kill_by_cid)(void=
 *arg, const unsigned long cid, const char *kill_msg);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool (*client_auth=
)(void *arg, const unsigned long cid, const unsigned int mda_key_id,</span>=
<br><span>                         const bool auth, const char *reason, con=
st char *client_reason,</span><br><span>                         struct buf=
fer_list *cc_config); /* ownership transferred */</span><br><span>     bool=
 (*client_pending_auth)(void *arg, const unsigned long cid, const unsigned =
int kid,</span><br><span>                                 const char *extra=
, unsigned int timeout);</span><br><span>     char *(*get_peer_info)(void *=
arg, const unsigned long cid);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                           const unsigned long=
 cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
             const unsigned int mda_key_id,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                           struct buffer_list *msg)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg=
)(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             struct buffer_list *msg);</span><br><span>     bool (*proxy_cm=
d)(void *arg, const char **p);</span><br><span>     bool (*remote_cmd)(void=
 *arg, const char **p);</span><br><span> #ifdef TARGET_ANDROID</span><br><s=
pan>@@ -292,13 +299,15 @@</span><br><span>     struct command_line *in;</sp=
an><br><span>     struct buffer_list *out;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF         =
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIEN=
T_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE*=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SI=
GN    3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CE=
RTIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IE=
C_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e IEC_PASSWORD    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define IEC_RSA_SIGN       3</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define IEC_CERTIFICATE    4</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</=
span><br><span>     int in_extra_cmd;</span><br><span>     struct buffer_li=
st *in_extra;</span><br><span>     unsigned long in_extra_cid;</span><br><s=
pan>@@ -503,6 +512,14 @@</span><br><span> </span><br><span> void man_persis=
t_client_stats(struct management *man, struct context *c);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC=
 message from the input buffer_list and send to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * session identified by session and mult=
i</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct tls_session;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+management_send_acc_message(struct context *c, stru=
ct tls_multi *multi, struct tls_session *session,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            const char *negot=
iated_protocols, struct buffer_list *input);</span><br><span> #endif /* ifd=
ef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> /**</span><br><s=
pan>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><s=
pan>index 81c2fca=2E=2Ed01a7bf 100644</span><br><span>--- a/src/openvpn/mul=
ti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6=
 +53,7 @@</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><spa=
n> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_fil=
ter=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;acc=2Eh&quot;</span><br><span> </span><br><span> /*#define MULTI_D=
EBUG_EVENT_LOOP*/</span><br><span> </span><br><span>@@ -1795,6 +1796,13 @@<=
/span><br><span>         o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_=
NOTIFY;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (o-&gt;acc_protocols)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* If ACC is enabled server side call to fi=
nd common acc protocols,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * will be pushed during push message */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        determine_common_acc_protocols(c)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Select =
cipher if client supports Negotiable Crypto Parameters */</span><br><span> =
</span><br><span>     /* if we have already created our key, we cannot *cha=
nge* our own</span><br><span>@@ -4084,6 +4092,24 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+calculate_app_control_extra(struct context *c, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_pro=
tocols(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc=
_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_CLIENT, &quot;ACC: No negotiated protocols&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(1024, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, c-&gt;op=
tions=2Eacc_max_message_length, c-&gt;options=2Eacc_negotiated_protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&=
amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> =
management_client_pending_auth(void *arg, const unsigned long cid, const un=
signed int mda_key_id,</span><br><span>                                cons=
t char *extra, unsigned int timeout)</span><br><span>@@ -4094,10 +4120,22 @=
@</span><br><span>     if (mi)</span><br><span>     {</span><br><span>     =
    struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &=
quot;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
xtra =3D calculate_app_control_extra(&amp;mi-&gt;context, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!extra)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span>         struct tls_session *session =3D lookup_session_by_m=
da_key_id(multi, mda_key_id);</span><br><span> </span><br><span>         if=
 (!session)</span><br><span>         {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span>          =
   return false;</span><br><span>         }</span><br><span> </span><br><sp=
an>@@ -4105,6 +4143,7 @@</span><br><span>         bool ret =3D send_auth_pe=
nding_messages(multi, session, extra, timeout);</span><br><span>         re=
schedule_multi_process(&amp;mi-&gt;context);</span><br><span>         multi=
_schedule_context_wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gc_free(&amp;gc);</span><br><span>         return ret;=
</span><br><span>     }</span><br><span>     return false;</span><br><span>=
@@ -4148,6 +4187,39 @@</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_client_acc_msg(voi=
d *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
              const unsigned long cid,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          const unsigned int mda_key_id,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
       struct buffer_list *input) /* ownership transferred */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_context *m =3D (struct multi_conte=
xt *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 multi_instance *mi =3D lookup_by_cid(m, cid);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (mi &amp;&amp; buffer_list_defined(input))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D mi-&gt;cont=
ext=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        struct tls_session *session =3D lookup_session_by_mda_key_id(mult=
i, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_CLIENT, &quot;client session not found&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buffer_list_free(input);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct options *opt =3D &amp;mi-&gt;con=
text=2Eoptions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D managem=
ent_send_acc_message(&amp;mi-&gt;context, multi, session, opt-&gt;acc_negot=
iated_protocols, input);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi_schedule_context_wakeup(m, mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static char *</s=
pan><br><span> management_get_peer_info(void *arg, const unsigned long cid)=
</span><br><span> {</span><br><span>@@ -4184,6 +4256,7 @@</span><br><span> =
        cb=2En_clients =3D management_callback_n_clients;</span><br><span> =
        cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br><span>      =
   cb=2Eclient_auth =3D management_client_auth;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D management_clie=
nt_acc_msg;</span><br><span>         cb=2Eclient_pending_auth =3D managemen=
t_client_pending_auth;</span><br><span>         cb=2Eget_peer_info =3D mana=
gement_get_peer_info;</span><br><span>         cb=2Epush_update_broadcast =
=3D management_callback_send_push_update_broadcast;</span><br><span>diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>ind=
ex 231a835=2E=2E30b935c 100644</span><br><span>--- a/src/openvpn/options=2E=
c</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -35,6 +3=
5,7 @@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;acc=2Eh&quot;</span><br><span> #include &quot;buffer=2Eh&quot;=
</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> #include =
&quot;common=2Eh&quot;</span><br><span>@@ -7133,6 +7134,28 @@</span><br><sp=
an>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         opti=
ons-&gt;force_key_material_export =3D true;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &qu=
ot;app-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;acc_=
protocols =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp=
;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    VERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot=
;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, =
&quot;App custom control encoding must be base64 and ascii&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;ac=
c_max_message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              &quot;app custom message message length&quo=
t;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        options-&gt;acc_negotiated_protocols =3D p[3];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     el=
se if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</spa=
n><br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --prn=
g option ignored (SSL library PRNG is used)&quot;);</span><br><span>diff --=
git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>ind=
ex 4cd9ef5=2E=2Ef603eb0 100644</span><br><span>--- a/src/openvpn/options=2E=
h</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -712,6 +=
712,16 @@</span><br><span>     /* force using TLS key material export for d=
ata channel key generation */</span><br><span>     bool force_key_material_=
export;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /** The app custom control protocols we should announce as suppor=
ted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *acc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols=
 that are negotiated with the peer=2E As a client we</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * trust the server pushed list here =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *a=
cc_negotiated_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the ma=
ximum length of an ACC control channel message */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int acc_max_message_length;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool vlan_t=
agging;</span><br><span>     enum vlan_acceptable_frames vlan_accept;</span=
><br><span>     uint16_t vlan_pvid;</span><br><span>@@ -763,8 +773,10 @@</s=
pan><br><span> #define OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><sp=
an> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define=
 OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define OPT_P_ACC             (1ull &lt;&lt; 32)</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OP=
T_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Options allowed i=
n the normal configuration file (vs pushed options or in ccd files) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~=
(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><=
span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/p=
ush=2Ec</span><br><span>index 0e281d2=2E=2Ee456077 100644</span><br><span>-=
-- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span>=
<br><span>@@ -27,6 +27,8 @@</span><br><span> #include &quot;syshead=2Eh&quo=
t;</span><br><span> </span><br><span> #include &quot;push=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> =
#include &quot;options=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh=
&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -22=
0,9 +222,8 @@</span><br><span> #endif</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(co=
nst struct buffer *buffer, const int adv)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+server_pushed_info(struct context *c, const struct bu=
ffer *buffer, const int adv)</span><br><span> {</span><br><span>     const =
char *m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *buffe=
r;</span><br><span>@@ -232,6 +233,27 @@</span><br><span>         m =3D BSTR=
(&amp;buf);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int max_acc_len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* example string to parse: ACC:1400 A:6 fl=
ower:happy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Skip over the ACC: prefix */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        m +=3D 4;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 char *protocols =3D parse_acc_parameters(m, &quot; &quot;, &amp;max_acc_le=
n, false, &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (protocols)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            c-&gt;options=2Eacc_negotiated_protocols =3D protocols=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;=
options=2Eacc_max_message_length =3D max_acc_len;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command =
with invalid parameters&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</sp=
an><br><span>     if (management)</span><br><span>@@ -284,6 +306,7 @@</span=
><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&#=
39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Parse the keyword for the AUTH_PENDING request</span><br><span>  * @param =
buffer                buffer containing the keywords, the buffer&#39;s</spa=
n><br><span>@@ -440,7 +463,6 @@</span><br><span>     const char *const peer=
_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int proto =
=3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maximum=
 timeout and subtract the time we already waited */</span><br><span>     un=
signed int max_timeout =3D</span><br><span>         max_uint(tls_multi-&gt;=
opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span=
><br><span>@@ -731,6 +753,11 @@</span><br><span>                 client_max=
_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         }</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;opt=
ions=2Eacc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6 =
%s&quot;, c-&gt;options=2Eacc_max_message_length, c-&gt;options=2Eacc_negot=
iated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> }</span><br><span> </span><br><span> #if defined(__GNU=
C__) || defined(__clang__)</span><br><span>diff --git a/src/openvpn/push=2E=
h b/src/openvpn/push=2Eh</span><br><span>index dff945f=2E=2E3aca8a7 100644<=
/span><br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvp=
n/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</span><br><span> </span><br><s=
pan> int process_incoming_push_request(struct context *c);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/**</span><br><span>  * @brief Handles the receiving of a push-update messa=
ge and applies updates to the specified</span><br><span>  * options=2E</spa=
n><br><span>@@ -92,7 +93,7 @@</span><br><span> </span><br><span> void recei=
ve_exit_message(struct context *c);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void server_pushed_info(const struct buffer=
 *buffer, const int adv);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void server_pushed_info(struct context *c, const struct buffer *buffe=
r, const int adv);</span><br><span> </span><br><span> void receive_cr_respo=
nse(struct context *c, const struct buffer *buffer);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=
=2Ec</span><br><span>index 0213041=2E=2Eeae6c35 100644</span><br><span>--- =
a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec=
</span><br><span>@@ -368,4 +368,4 @@</span><br><span> </span><br><span>    =
 RETURN_UPDATE_STATUS(n_sent);</span><br><span> }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_MANAGEMENT */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEM=
ENT */</span><br><span>\ No newline at end of file</span><br><span>diff --g=
it a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index aeec02=
0=2E=2E73ca54c 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><=
span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br>=
<span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><s=
pan> #include &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;=
ssl_verify=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;<=
/span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -2105,=
6 +2106,11 @@</span><br><span>                     }</span><br><span>      =
           }</span><br><span>             }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (session-&gt;opt-&gt;acc_protocols)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &quot;IV=
_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span>         }</span><br><span>     }</span><br><span> </span><br=
><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh=
</span><br><span>index 6b86bc0=2E=2E0270c23 100644</span><br><span>--- a/sr=
c/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</=
span><br><span>@@ -452,6 +452,9 @@</span><br><span>     size_t ekm_size;</s=
pan><br><span> </span><br><span>     bool dco_enabled; /**&lt; Whether keys=
 have to be installed in DCO or not */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /** The app custom control protocols we should announce as supported */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *acc=
_protocols;</span><br><span> };</span><br><span> </span><br><span> /** @add=
togroup control_processor</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>index 5430ecb=2E=2Ed864a8f 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>@@ -103,9 +103,11 @@</span><br><span> 	@TEST_CFLAGS@=
</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRY=
PTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    test_acc=2Ec test_acc=
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
/ssl_util=2Ec \</span><br><span>@@ -389,6 +394,7 @@</span><br><span> 	$(top=
_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/session_id=2Ec</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> push_update_msg_testdriver_CFL=
AGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src=
/compat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tes=
ts/unit_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=
=2Ecddd669 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_manag=
ement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2E=
c</span><br><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #inc=
lude &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> #in=
clude &quot;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENAB=
LE_MANAGEMENT</span><br><span>@@ -60,4 +61,4 @@</span><br><span> void</span=
><br><span> management_sleep(const int n)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/u=
nit_tests/openvpn/mock_management=2Eh</span><br><span>new file mode 100644<=
/span><br><span>index 0000000=2E=2Ee21aec43</span><br><span>--- /dev/null</=
span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Eh</span><br=
><span>@@ -0,0 +1,32 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
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
 40%);">+#ifndef MOCK_MANAGEMENT_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define MOCK_MANAGEMENT_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void init_mock_management(void);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void uninit_mock_management(void);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec</span><br><span>index 112bcfd=2E=2Ec16d0cb 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b=
/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -43=
,7 +43,8 @@</span><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_=
EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span>                  =
    | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIS=
T</span><br><span>                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_N=
OTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUS=
H_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_P=
USH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                     | OPT_P_ACC;</span><br><span>     re=
turn flags;</span><br><span> }</span><br><span> </span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_ac=
c=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E16b2b3b</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1,298 @@</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP =
networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    over a single TCP/UDP port, with support for SSL/TLS-based</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             session authentic=
ation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet encryption, packet authentication, and</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compress=
ion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN=
 Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
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
(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmo=
cka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tes=
t_acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char contro=
l_channel_mesage_sent[2048];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mock fu=
nctions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_str=
ing_dowork(struct tls_session *session,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                   const char *str, int=
 msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range(str=
len(str), 0, 2048);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(control_=
channel_mesage_sent, str, strlen(str));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_token(struct t=
ls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+auth_set_client_reason(struct tls_multi *multi, const char *reason)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;       =
         \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quo=
t; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &=
quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;Q=
AXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    &quot;ICAgaCB=
sIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    &quot;AUEAwQDAwAtAA=
IBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    &quot;93rQwityP9eKSijXgcQ=
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
t_misc=2Ec</span><br><span>index 052dea8=2E=2E225bcae 100644</span><br><spa=
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
hSet: 10 </div>
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
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--mKEwa6DzBWQ=--


--===============5773770620003745593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5773770620003745593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5773770620003745593==--

