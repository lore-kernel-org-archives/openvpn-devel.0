Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7547606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lsB4Ep2D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EhyN20Pc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O0vPIgQl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XBtAXv6J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=G1imd3by7T5hf0giqsofTqhFLtN5Z3SlAkuz0Rd0W8o=; b=lsB4Ep2D9wpJcIl4aN9+vX3Voo
	87KUnRePPJQZhEz6xPiYwJQMS+YzbN1Djb5M+Zqg7WGoFVaNLP+uBSppxO7MhxWV7AWJyqAZelY5c
	N9d02d6ypAT6PVQ8UKOQorjhjIq0H/Ud0gzZdaImFE6nUUuV9u5fTwlVBZn/rXx4MSoM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBfV-000000000Kq-2EiY;
	Wed, 28 Oct 2026 21:58:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMBfT-000000000Kj-1k8y
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:58:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rHqXUINe30Nz/GF1dAwo+O66keWbrr9FjZ+8fYTPB3o=; b=EhyN20PcDnArhjllqVY7nZN+XH
 7musJF1WaPy/yEM/QJ//7N3Q1eW6zHk0pQaSXt/IEvcra4RGs4ypx4lA98gOxc/9KKNkU7YXRqtvj
 NJKDDnSM9UU4gUKNUBbvglDLYt0zryEwC0qu6JqSWR+Av/WYTNtEG8/VqNENr+Bl9neo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rHqXUINe30Nz/GF1dAwo+O66keWbrr9FjZ+8fYTPB3o=; b=O0vPIgQlBZ9kkPgtB+KLLmm3Wr
 pExBUMegS3eZHp4n4va8+SibUYLXadwvAHKmpiFILTe9vhGq7bilHDIcksHIvBVknTIAFVH3fi1xy
 qiyVwCs8i3Bu4zHUn/eTcQw3jY0LZoH6Qtyu6fJnQt4/BePy7BUv7Sdiper6NHwuQEQo=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMBfM-000000004AU-17aI for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:58:47 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso11406255e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793224714; x=1793829514; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rHqXUINe30Nz/GF1dAwo+O66keWbrr9FjZ+8fYTPB3o=;
 b=XBtAXv6JpLiasf4HPym4xD46N2tnmaI+O1fWxXnKyOiNiTnbzws8mS3Nk/NQ3C7MNQ
 2vAv5kvzuJs1Ud5DGYUaP3dbBV0LbTfcwRRPmdQFNXShjdCz5OS95bKou4KkgvqBNfVb
 z5Kkk2kkHNzNzZI2RODMA45yeT5YE/lnKPvJNBTfP+udeHFi3YSzOCo1QMzJnAU5vUFm
 ZpiEqgNgo6qc/1LF/9qj6889moSVSsuBYHfOqvH1dQpTHGkpN6he+zpXJEmzTHDcFzRA
 d0VRf4h+qWgT8MbzcGmRAXEYw41Xf2kUD02gCxpgC81MErBgophroSp4z9uGMpUe7eiW
 nZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793224714; x=1793829514;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rHqXUINe30Nz/GF1dAwo+O66keWbrr9FjZ+8fYTPB3o=;
 b=UONRo8BPt5KP1uT184Y4NBFJ80NmiBZPEVCxME+hOI4wodcHFnnuNt6AtR1ylYfCTG
 1Uq4R0bnUazTuLqjyvVcdv7CKUpN35RXMzO0XnI8WoDumn7CiLuYpoWNQjez0BuLcg0T
 N3DJeNXXcCoUV/UTQ0NaZ2KlDGyqQuIvZ2E+VkVXnaGBtFBi5wtqanNVpKeKxk06tvwp
 g6ouA9zDe5pibEHW4q9PiyOrBe+5cUHi3Ubb4SDAsaEi12ClEEUP+DGvrJjd4E02zHgV
 WCHhktr8il/pIXG8GZb5FquUqj8LSIEp5jW5uIj1yFaposmF3PCWFEik8Hd0z5NjNthR
 eteQ==
X-Gm-Message-State: AFq9FYI3kft5kBBlavmrmvn4/JyBggzNPqT7qLGdZ87f/PuKXFZHu8fh
 Q2S4Jc8O3PDh20YyW592so3oZXKxbtTqeWudFGjzB7vh+KqgR0ivO456dENfc8jbmV1ndQJiZG3
 Zrn+pKCg3eu4azkqMt3zAq6oZdxnjpdEiE3GZbJqiWcHXSHytnEEfeCLHkisCYw623ZoP
X-Gm-Gg: AYBFou0JjsJxKzqRohgVVbMlfvA0Tiww4v73rXENDgPPo1NERw+Irsdk+HlWLONIPVp
 6HspVtMshT7Rjxm/KnSsm3p1h0vAoFW0FViFUQbx7HVhu7D/PEUoJ9iM4V9ldqXWJy0cyjWfqoi
 724GRQWZBKTU7BH9OJHYB1glcjzYwfqIeo5tIgNkuG1uCtuhdhChcY5SM/GKYrE3J1MaAoyFagt
 8ajhCXQpGocjoy/IhzrsKbHaIRaP6Cf+GunZQfog/aFjPiMHGxaTvEE05WVNVNVOL88hVyrXYMM
 Y4bdpyCLoCrxnW3sIIM1jjThosqnjxIwiTu2QeyULHg/PodlHHlr4B22ZDSHazSuIMMPbwqfv9Q
 O64cQ7CMUp5E+/M3NsKU7v9Yx3kFV4ZZrxhL4eYrfiw1RZ0rJZmGhKPrHbBQV1XysYm8xRXYNN4
 5R0CKNfa8sLPLiNLrSNld+AItFJp0L7VHIDcOuMdYrDMDRyYYr8l/HT+JDw0lNgwZSN8i6gfYW0
 QQhtVrb2cr7XlAuQF3oNCs0EgGRhdCHFTVsf04py3Ab36rLSbgZB+I9qNr+pYaHOZbmnX2l4Eez
 ur4cheEQDAdku5djH6OKWGB1cbIwPrnxe3pMYDU9XebIg3xsOMSPYWh3KINbVq9Fq/5wdseNEDM
 7rqg0lMvh8x4ZGkB8K6RTsC7i3NUQLiMCp0mDaXWlu4LkuHPW4hKszkdvUi0A0A0Ny3NRfDwVMc
 /fLrRfTQTrG0+PT9k=
X-Received: by 2002:a05:600c:354a:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4a9678c3ca2mr82347875e9.32.1793224712584; 
 Wed, 28 Oct 2026 14:58:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94eb8a60fsm59374185e9.3.2026.10.28.14.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 14:58:32 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 21:58:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 01d4f811e40ab07cd36eaf7f554cc118c1ba6501
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5dfb8c2f40dca76f4144af1c50bffc7c31523e91-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBfM-000000004AU-17aI
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
Content-Type: multipart/mixed; boundary="===============4279751493717555413=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4279751493717555413==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sRGEec6N5II="; charset=UTF-8

--sRGEec6N5II=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#21)=2E


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
rk itself to work and can also be used before fully
authenticating the clie=
nt=2E See the management-notes=2Etxt for more
details how to use this featu=
re=2E An upcoming patch will also add
some example python scripts that show=
case this feature=2E

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
=
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M d=
oc/man-sections/client-options=2Erst
M doc/man-sections/management-options=
=2Erst
M doc/man-sections/script-options=2Erst
M doc/management-notes=2Etxt=

M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M =
src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M s=
rc/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M s=
rc/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/=
openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/unit_tests/openvpn/Mak=
efile=2Eam
M tests/unit_tests/openvpn/mock_management=2Ec
M tests/unit_test=
s/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/openvpn/test_acc=2E=
c
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_tests/openvpn/test_c=
ommon=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec
26 files changed, 1,527 i=
nsertions(+), 22 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/58/1858/21

diff --git a/CMakeLists=2Etxt b/CMakeLi=
sts=2Etxt
index 184a95a=2E=2E4deabe7 100644
--- a/CMakeLists=2Etxt
+++ b/CM=
akeLists=2Etxt
@@ -435,6 +435,8 @@
     src/compat/compat-strlcpy=2Ec
     =
src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/o=
penvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/argv=2Ec
     src/=
openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -826,6 +828,8 @@
          =
   tests/unit_tests/openvpn/mock_management=2Ec
             tests/unit_tes=
ts/openvpn/mock_ssl_dependencies=2Ec
             tests/unit_tests/openvpn/=
mock_win32_execve=2Ec
+            tests/unit_tests/openvpn/test_acc=2Ec
+ =
           src/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
          =
   src/openvpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
@@ -842=
,6 +846,7 @@
             src/openvpn/packet_id=2Ec
             src/openvp=
n/run_command=2Ec
             src/openvpn/ssl_mbedtls=2Ec
+            src=
/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_openssl=2Ec
             =
src/openvpn/ssl_util=2Ec
             src/openvpn/ssl_verify_mbedtls=2Ec
di=
ff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-=
options=2Erst
index 87c138a=2E=2E16309f9 100644
--- a/doc/man-sections/clie=
nt-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -437,6 +437=
,12 @@
         Additional authentication methods supported by the client=
=2E
         This may be set by the client UI/GUI using ``--setenv``=2E
 
+=
  :code:`IV_ACC=3D<max_msg_len>,<flags>,<protocols>`
+        If the option=
 ``--app-custom-control`` is set, the client will
+        send the support=
ed max ACC message length, the supported formats
+        as (:code:`A:6`) =
and the list of configured protocols (e=2Eg=2E
+        :code:`flower:happy=
:power`)
+
   The following flags depend on which compression formats are c=
ompiled in
   and whether compression is allowed by options=2E See `Protoco=
l options`_
   for more details=2E
diff --git a/doc/man-sections/management=
-options=2Erst b/doc/man-sections/management-options=2Erst
index 2c79d05=2E=
=2E315e567 100644
--- a/doc/man-sections/management-options=2Erst
+++ b/doc=
/man-sections/management-options=2Erst
@@ -144,3 +144,17 @@
 
 --management=
-up-down
   Report tunnel up/down events to management interface=2E
+
+--ap=
p-custom-control protocol-list
+  Sets the list of supported app custom con=
trol protocols=2E
+  These protocols are announced to the server via the IV=
_ACC peer info
+  variable when this option is used on a client=2E
+  If th=
e option is set on a server it will negotiate common protocols
+  with the =
client=2E
+
+  The protocol-list is a : separated list of protocol identifi=
ers=2E Protocol
+  identifiers must consist of alphanumeric characters, :co=
de:`-`, and
+  :code:`_`=2E
+
+  See management-notes=2Etxt in the OpenVPN =
distribution and the OpenVPN RFC
+  draft for a description of app custom c=
ontrol protocol support=2E
diff --git a/doc/man-sections/script-options=2Er=
st b/doc/man-sections/script-options=2Erst
index f420380f=2E=2E474c7fd 1006=
44
--- a/doc/man-sections/script-options=2Erst
+++ b/doc/man-sections/scrip=
t-options=2Erst
@@ -1006,3 +1006,12 @@
        X509_1_L=3DBISHKEK
        X=
509_1_ST=3DNA
        X509_1_C=3DKG
+
+:code:`acc_protocols`
+    If ``--ap=
p-custom-control`` is configured and the client supports any of the
+    pr=
otocols that server also supports, this variable contains a list of
+    co=
mmon protocols separated by :=2E
+
+:code:`acc_message_len`
+    if :code:`=
acc_protocols` is set, this variable contains the maximum
+    message leng=
th for app custom protocol message=2E
diff --git a/doc/management-notes=2Et=
xt b/doc/management-notes=2Etxt
index 4d726c4=2E=2Ea6dcc2f 100644
--- a/doc=
/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -828,6 +828,58 =
@@
 that is required to continue the connection (unlike MFA or opening a br=
owser)
 this message is not negotiated but can just be sent as a gratuitous=
 message=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+If the special string "ACC" is passed as {EXTRA} OpenVPN w=
ill determine
+the common app custom protocols between the client and the s=
erver and instruct
+the client that the server will send control messages t=
o the client using
+the ACC protocol=2E
+
+The server should then use clien=
t-acc-msg command to send app custom
+control messages to the client to fac=
ilitate the pending authentication=2E
+
+COMMAND -- client-acc-msg (OpenVPN=
 2=2E8 or higher)
+-------------------------------------------------
+
+On =
an OpenVPN instance running in server mode this command sends an
+app custo=
m control message to a client=2E The format of the command is:
+
+  client-=
acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
+CID,KID=
 -- client ID and Key ID=2E See documentation for ">CLIENT:"
+notification =
for more info=2E
+
+protocol -- the ACC protocol identifier that this messa=
ge should be
+            tagged with=2E
+
+flags    -- a colon separated l=
ist of the encoding and the flag if
+            the message is a fragment=
=2E E=2Eg=2E "6:F" for a base64 encoded
+            message that is also a=
 fragment and not complete yet=2E
+
+message  -- The message encoded in the=
 encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 or high=
er)
+------------------------------------------
+
+When OpenVPN is running =
in --client mode this command sends an app
+custom command to the server=2E=
 The format of the command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {mes=
sage}
+  END
+
+See the client-acc-msg command for more details about the f=
ormat of the
+message=2E Since a client has only one peer there is no need =
to specify the
+client id and key id=2E
+
+
 COMMAND -- client-deny  (OpenV=
PN 2=2E1 or higher)
 -----------------------------------------------
 
@@ -=
1302,6 +1354,47 @@
    response=2E Mechanisms that need multiple rounds or =
more complex answers
    should implement a different response type than CR=
_RESPONSE=2E
 
+(6) App custom control message
+
+    This message is an ap=
plication specific payload message that is transported
+    over the OpenVP=
N control channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},=
{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:{prot=
ocol},{fragment},{msg_base64}
+
+    The protocol is a short ascii string i=
dentifying the app specific custom
+    protocol=2E If fragment is set to 1=
, the message is not complete and the
+    next message should be concatena=
ted to this message to form a complete
+    message=2E
+
+    Note that the=
 OpenVPN implementation operates here with the robustness
+    principle ("=
be conservative in what you send, be liberal in what you
+    accept" - RFC=
 793 and others) and allows receiving messages longer than
+    maximum all=
owed message length=2E Implementations should be prepared to
+    handle me=
ssages that are longer than the maximum allowed message length=2E
+
+
+(7) =
App custom control protocol message
+
+   This message informs the client a=
bout the common ACC
+   protocols and the maximum message length for an ACC=
 message=2E
+
+   In client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protoco=
l_list},message_len=3D{max_msg_len}
+
+   protocol_list is the list of supp=
orted protocols by both server and client=2E
+   For example flower:power:s=
ys_info would indicate these three protocols
+   are supported=2E max_msg_l=
en specifies the maximum message length that the
+   peer supports=2E
+
+  =
 In server mode these information are available in the acc_protocols and
+ =
  acc_message_len variables of the client environment=2E
 
 Variables:
 
di=
ff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60=
a94=2E=2Eebc4db6 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/M=
akefile=2Eam
@@ -45,6 +45,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCE=
S =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_tok=
en=2Eh \
 	base64=2Ec base64=2Eh \
@@ -124,7 +125,8 @@
 	proto=2Ec proto=2E=
h \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=
=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_f=
ilter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --git a/s=
rc/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 100644
index 0000000=
=2E=2E860ffa8
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,451 @@
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
+#ifdef HAV=
E_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#inc=
lude <string=2Eh>
+#include "buffer=2Eh"
+#include "error=2Eh"
+#include "a=
cc=2Eh"
+#include "forward=2Eh"
+#include "options_util=2Eh"
+#include "ssl=
_util=2Eh"
+#include "ssl_ncp=2Eh"
+#include "multi=2Eh"
+
+enum acc_messag=
e_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64=
 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+log_ac=
c_message(struct context *c, const struct buffer *buf, int payload_len,
+  =
              const char *protocol, int flags)
+{
+    bool fragment =3D fl=
ags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_=
arena gc =3D gc_new();
+    const char *payload_msg =3D NULL;
+
+    /* For=
 simplicity, we always encode payload to be base64 encoded
+     * if not a=
lready in base64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {=

+        char *b64out =3D NULL;
+        ASSERT(openvpn_base64_encode(CBPT=
R(buf), payload_len, &b64out) >=3D 0);
+        gc_addspecial(b64out, free,=
 &gc);
+        payload_msg =3D b64out;
+    }
+    else
+    {
+        pa=
yload_msg =3D CBSTR(buf);
+    }
+
+    if (management)
+    {
+        str=
uct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+   =
     if (c->options=2Emode =3D=3D MODE_SERVER)
+        {
+            /* s=
erver mode=2E Report client context */
+            struct man_def_auth_con=
text *mda =3D session->opt->mda_context;
+            unsigned int mda_key_=
id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_C=
LIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_id=
, protocol, fragment, payload_msg);
+        }
+        else
+        {
+  =
          /* Client mode=2E Do not a report a CLIENT id */
+            msg=
(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payload_msg);
+        }
+ =
   }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PU=
SH, "Received custom app control message (protocol '%s'%s)",
+        proto=
col, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses the flags field=
 of an app control message and moves the
+ *  buffer past the flags string=
=2E If there is an
+ *  error parsing the flags field the method returns -1=
 and
+ *  puts the error reason in err_reason
+ */
+static int
+parse_acc_m=
essage_flags(struct buffer *buf, const char **err_reason, struct gc_arena *=
gc)
+{
+    const char *flags =3D buf_extract_field(buf, ',', gc);
+
+    i=
f (!flags)
+    {
+        *err_reason =3D "could not extract flags field";=

+        return -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    for (const=
 char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+        if (*flag =
=3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;=

+        }
+        else if (*flag =3D=3D '6')
+        {
+            acc=
_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (*flag =
=3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGME=
NT;
+        }
+        else
+        {
+            *err_reason =3D "Unkno=
wn flag in flags";
+            return -1;
+        }
+    }
+    /* The me=
ssage should be encoded with exactly one encoding=2E Ensure that
+     * on=
ly one of the flags is present */
+    bool asciienc =3D (bool)(acc_flags &=
 ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_flags & ACC_M=
ESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+    {
+     =
   char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "number=
 of encodings must be exactly one "
+                           "(B64=3D%d,=
 ASCII=3D%d)",
+                 base64enc, asciienc);
+        *err_reason=
 =3D tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
+
+
+void
=
+receive_acc_message(struct context *c, const struct buffer *buffer)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    const char *err_reason =3D "";
+
+ =
   /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    struct buff=
er buf =3D *buffer;
+
+    const struct tls_multi *multi =3D c->c2=2Etls_mu=
lti;
+    if (!multi->acc_negotiated_protocols)
+    {
+        err_reason =
=3D "ACC not enabled or no negotiated protocols";
+        goto err;
+    }=

+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf) !=3D ','=
)
+    {
+        err_reason =3D "missing , after ACC";
+        goto err;
=
+    }
+
+    /* extract protocol, payload length, flags substrings */
+   =
 const char *protocol =3D buf_extract_field(&buf, ',', &gc);
+    if (!prot=
ocol)
+    {
+        err_reason =3D "could not extract protocol field";
+ =
       goto err;
+    }
+
+    if (!tls_item_in_cipher_list(protocol, multi=
->acc_negotiated_protocols))
+    {
+        struct buffer msg_buf =3D allo=
c_buf_gc(1024, &gc);
+        buf_printf(&msg_buf, "protocol '%s' not in li=
st of negotiated protocols '%s'",
+                   protocol, multi->acc_=
negotiated_protocols);
+        err_reason =3D buf_cstr(&msg_buf);
+
+
+   =
     goto err;
+    }
+
+    /* We do not check the length here=2E We make =
no promises to support
+     * anything larger than our announced message l=
ength but according to
+     * the robustness principle
+     * ("be conser=
vative in what you send, be liberal in what you accept" - RFC 793 and other=
s)
+     * we accept also longer messages */
+
+    int payload_len;
+    c=
onst char *payload_len_str =3D buf_extract_field(&buf, ',', &gc);
+    if (=
!payload_len_str
+        || !atoi_constrained(payload_len_str, &payload_le=
n, "acc_payload_len", 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))
+    {
+=
        err_reason =3D "could not extract payload length field";
+        g=
oto err;
+    }
+
+    int flags =3D parse_acc_message_flags(&buf, &err_rea=
son, &gc);
+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /*=
 We should have a final NUL byte in the control message buffer
+     * and =
thus the length of the buffer should be payload_len + 1 */
+    if (buf_len=
(&buf) !=3D payload_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1=
, &gc);
+        snprintf(tmp, 512, "field length %d, payload length %d mis=
match",
+                 payload_len, buf_len(&buf) - 1);
+        err_rea=
son =3D tmp;
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf, pa=
yload_len, protocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    m=
sg(D_PUSH_ERRORS, "WARNING: Received malformed custom app control channel "=

+                       "message (%s): %s",
+        err_reason,
+        =
format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+    gc_free(&gc);
+}
+
=
+
+bool
+send_acc_message(struct context *c,
+                 struct tls_m=
ulti *multi,
+                 struct tls_session *session,
+              =
   const char *protocol, bool fragment,
+                 const char *msg, =
bool base64)
+{
+    /*
+     * length of the protocol string + one ','
+  =
   * 2 for the encoding (A or 6), potential F (fragment), and 1 for the ','=
,
+     * 4 for the message size itself and one comma
+     * 1 for the com=
ma before the message itself */
+    const size_t max_header_size =3D strle=
n("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_h=
eader_size + strlen(msg);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    {
+  =
      msg(M_CLIENT, "message length (%zu) exceeds maximum possible message =
length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+    }
+
+=
    if ((int)len > multi->acc_max_message_length)
+    {
+        msg(M_CLI=
ENT, "header (%zu) + message size (%zu) length (%zu) exceeds "
+           =
           "maximum allowed length negotiated with peer (%d)",
+           =
 max_header_size, strlen(msg), len,
+            multi->acc_max_message_len=
gth);
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_new();=

+    /* add 1 for the final \0 */
+    struct buffer buf =3D alloc_buf_gc(=
len + 1, &gc);
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy =
*/
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+               st=
rlen(msg),
+               base64 ? "6" : "A",
+               fragment ? "=
F" : "",
+               msg);
+
+    bool ret =3D send_control_channel_str=
ing_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
=
+    gc_free(&gc);
+    return ret;
+}
+
+char *
+parse_acc_parameters(cons=
t char *capabilities,
+                     const char *delim,
+           =
          int *max_acc_len,
+                     bool server,
+           =
          struct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc(c=
apabilities, NULL);
+    char *tmp_message_orig =3D tmp_message;
+    char =
*lasts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_message, delim, =
&lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const char *protoc=
ols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode we allow mo=
re capabilities than our own, in client
+     * mode we reject if we should=
 use capabilities that we do not support */
+    int allowed_acc_len =3D se=
rver ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if (=
p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message length", ACC_M=
IN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto d=
one;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A",=
 token) || !tls_item_in_cipher_list("6", token)))
+        {
+            m=
sg(D_PUSH_ERRORS, "App custom control encoding must include base64 and asci=
i");
+            goto done;
+        }
+
+        if (p =3D=3D 1 && !serve=
r && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+            =
msg(D_PUSH_ERRORS, "App custom control encoding must be exactly base64 and =
ascii");
+            goto done;
+        }
+
+        if (p =3D=3D 2)
+   =
     {
+            protocols =3D token;
+        }
+
+        if (p =3D=3D=
 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters for INF=
O ACC message/IV_ACC=2E");
+            goto done;
+        }
+
+        to=
ken =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc=
_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(protoc=
ols, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
+
+stru=
ct buffer
+get_list_intersection(struct gc_arena *gc, const char *list1, co=
nst char *list2)
+{
+    char *tmp =3D string_alloc(list1, NULL);
+    char=
 *lasts =3D NULL;
+    const char *token =3D strtok_r(tmp, ":", &lasts);
+
=
+    /* The maximum possible length is the shorter of the two input lists *=
/
+    size_t max_len =3D min_size(strlen(list1), strlen(list2));
+
+    st=
ruct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);
+
+    whil=
e (token)
+    {
+        /* check for every items is in both lists and not=
 already in the
+         * common list */
+        if (tls_item_in_cipher_=
list(token, list2)
+            && !tls_item_in_cipher_list(token, buf_cstr=
(&common_protocols)))
+        {
+            if (buf_len(&common_protocols=
) > 0)
+            {
+                buf_write_u8(&common_protocols, ':')=
;
+            }
+            buf_printf(&common_protocols, "%s", token);
+=
        }
+        token =3D strtok_r(NULL, ":", &lasts);
+    }
+    free(=
tmp);
+    return common_protocols;
+}
+
+void
+determine_common_acc_protoc=
ols(struct tls_multi *multi, struct tls_session *session)
+{
+    if (!mult=
i->opt=2Eacc_protocols)
+    {
+        /* No app custom protocols have bee=
n configured server-side=2E */
+        return;
+    }
+
+    if (multi->ac=
c_negotiated_protocols)
+    {
+        /* We already have determined the c=
ommon protocols=2E */
+        return;
+    }
+
+    struct gc_arena gc =3D=
 gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+   =
 const char *peer_info =3D multi->peer_info;
+    const char *iv_acc =3D ex=
tract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
=
+        gc_free(&gc);
+        return;
+    }
+
+    int max_acc_len =3D 0=
;
+    const char *protocols =3D parse_acc_parameters(iv_acc, ",", &max_acc=
_len, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+   =
     msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of peer is malf=
ormed");
+        return;
+    }
+
+    struct buffer common_protocols =3D =
get_list_intersection(&gc, multi->opt=2Eacc_protocols, protocols);
+
+    i=
f (buf_len(&common_protocols) =3D=3D 0)
+    {
+        msg(D_PUSH_DEBUG, "=
WARNING: No common app custom control protocol=2E");
+        gc_free(&gc);=

+        return;
+    }
+
+    multi->acc_negotiated_protocols =3D string_=
alloc(buf_str(&common_protocols), NULL);
+    multi->acc_max_message_length=
 =3D max_acc_len;
+
+    setenv_str(session->opt->es, "acc_protocols", mult=
i->acc_negotiated_protocols);
+    setenv_int(session->opt->es, "acc_messag=
e_len", multi->acc_max_message_length);
+
+    gc_free(&gc);
+}
+
+void
+no=
tify_client_acc_protocols(struct tls_multi *multi)
+{
+#ifdef ENABLE_MANAGE=
MENT
+    if (management)
+    {
+        msg(M_CLIENT, ">ACC_PROTOCOLS:pro=
tocols=3D%s,message_len=3D%d",
+            multi->acc_negotiated_protocols=
, multi->acc_max_message_length);
+    }
+#endif
+}
diff --git a/src/openvp=
n/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 0000000=2E=2E2fe=
9efd
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,113 @@
+/*
+ *  Ope=
nVPN -- An application to securely tunnel IP networks
+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based
+ *             sessi=
on authentication and key exchange,
+ *             packet encryption, pack=
et authentication, and
+ *             packet compression=2E
+ *
+ *  Copyr=
ight (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arn=
e Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; =
you can redistribute it and/or modify
+ *  it under the terms of the GNU Ge=
neral Public License version 2
+ *  as published by the Free Software Found=
ation=2E
+ *
+ *  This program is distributed in the hope that it will be u=
seful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  G=
NU General Public License for more details=2E
+ *
+ *  You should have rece=
ived a copy of the GNU General Public License along
+ *  with this program;=
 if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#def=
ine ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#define =
ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom control me=
ssage and delivers it to the
+ * management interface=2E We leave reassembl=
y of fragmented messages to the
+ * management interface=2E
+ *
+ * @param =
c            The context struct
+ * @param buffer       Buffer containing t=
he control message with ACC
+ */
+void
+receive_acc_message(struct context =
*c, const struct buffer *buffer);
+
+
+bool
+send_acc_message(struct contex=
t *c,
+                 struct tls_multi *tls_multi,
+                 stru=
ct tls_session *session,
+                 const char *protocol, bool fragm=
ent,
+                 const char *msg, bool base64);
+
+
+/**
+ * Parses a=
n info message from the server that contains app custom control info
+ * in=
formation prior to the PUSH_REPLY to be able to use app custom control
+ * =
protocols before sending
+ *
+ * In client mode only allow what we support =
ourselves=2E In server mode
+ * allow also capabilities that we not support=
 ourselves=2E
+ *
+ * @param capabilities      The string to parse
+ * @par=
am delim             The delimiter to use when parsing the string=2E
+ *   =
                       IV_ACC uses "," as delimiter while the
+ *          =
                custom-control PUSH message uses " " as "," is
+ *         =
                 already used to separate different push directives
+ * @pa=
ram max_acc_len       Set to the maximum ACC message length
+ * @param serv=
er            Whether we are server or client
+ * @param gc                =
The gc arena to use for allocating the resulting string
+ * @return        =
          The resulting protocol string or NULL on error
+ */
+char *
+pars=
e_acc_parameters(const char *capabilities,
+                     const char=
 *delim,
+                     int *max_acc_len,
+                     bool=
 server,
+                     struct gc_arena *gc);
+
+/**
+ * Parses the =
IV_ACC of the peer and sets multi=2Eacc_negotiated_protocols
+ * to the com=
mon protocols of server and client and
+ * multi=2Eacc_max_message_length  =
to the maximum length of the ACC message
+ * support by both server and cli=
ent=2E
+ *
+ * If there is no common protocol or the client does not suppor=
t any app custom
+ * protocol multi=2Eacc_negotiated_protocols will be set =
to NULL=2E
+ *
+ * @param multi      the multi instance to use the set the =
app custom protocols=2E
+ * @param session    the session to read the clien=
t env from
+ */
+void
+determine_common_acc_protocols(struct tls_multi *mul=
ti, struct tls_session *session);
+
+/**
+ * Calculates the intersection of=
 two list that are both separated by :
+ * Items in the result will have th=
e same ordering as in the list1
+ * parameters
+ * @param gc            Ret=
urned buffer will be allocated in this gc
+ * @param list1         First li=
st to intersect
+ * @param list2         Second list to intersect=2E
+ * @r=
eturn A (potentially empty) buffer containing an intersection list
+ */
+st=
ruct buffer
+get_list_intersection(struct gc_arena *gc, const char *list1, =
const char *list2);
+
+/**
+ * Notifies a client via management interface o=
f the negotiated app
+ * custom protocols
+ * @param multi the tls_multi in=
stance of the connection
+ */
+void
+notify_client_acc_protocols(struct tls=
_multi *multi);
+#endif
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/=
forward=2Ec
index 681210d=2E=2E7923b5e 100644
--- a/src/openvpn/forward=2Ec=

+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "dco=2Eh"
 #incl=
ude "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#include "acc=2Eh"
 
 #inc=
lude "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
     }
     else if (buf_string_m=
atch_head_str(buf, "INFO_PRE"))
     {
-        server_pushed_info(buf, 8);=

+        server_pushed_info(c, buf, 8);
     }
     else if (buf_string_ma=
tch_head_str(buf, "INFO"))
     {
-        server_pushed_info(buf, 4);
+   =
     server_pushed_info(c, buf, 4);
     }
     else if (buf_string_match_h=
ead_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @@
     {
         re=
ceive_auth_pending(c, buf);
     }
+    else if (buf_string_match_head_str(=
buf, "ACC"))
+    {
+        receive_acc_message(c, buf);
+    }
     else =
if (buf_string_match_head_str(buf, "EXIT"))
     {
         receive_exit_me=
ssage(c);
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 1b=
8b2a5=2E=2Ee0b99a4 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -56,6 +56,7 @@
 #include "schedule=2Eh"
 #include "options_string=
=2Eh"
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
=
 
@@ -2279,6 +2280,13 @@
         }
     }
 
+    struct tls_multi *multi =
=3D c->c2=2Etls_multi;
+    if (multi && multi->acc_negotiated_protocols)
+=
    {
+        buf_printf(&out, " custom-control %d A:6 %s",
+             =
      multi->acc_max_message_length, multi->acc_negotiated_protocols);
+   =
 }
+
     if (BLENZ(&out) > strlen(header))
     {
         msg(D_HANDSHAKE=
, "%s", BSTR(&out));
@@ -2522,6 +2530,11 @@
         flags |=3D (OPT_P_ROUT=
E | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+    {
+ =
       flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -2730,6 +2=
743,18 @@
         frame->tun_mtu =3D min_int(frame->tun_max_mtu, c->option=
s=2Ece=2Etun_mtu);
     }
 
+    if (found & OPT_P_ACC && c->options=2Epush=
ed_acc_negotiated_protocols)
+    {
+        struct tls_multi *multi =3D c-=
>c2=2Etls_multi;
+        free(multi->acc_negotiated_protocols);
+        m=
ulti->acc_negotiated_protocols =3D string_alloc(c->options=2Epushed_acc_neg=
otiated_protocols, NULL);
+        multi->acc_max_message_length =3D c->opt=
ions=2Epushed_acc_max_message_length;
+
+        msg(D_PUSH, "OPTIONS IMPOR=
T: ACC protocols: %s, msg len: %d",
+            multi->acc_negotiated_prot=
ocols, multi->acc_max_message_length);
+        notify_client_acc_protocols=
(multi);
+    }
+
     return true;
 }
 
@@ -3352,6 +3377,7 @@
     to=2Eve=
rify_hash_depth =3D options->verify_hash_depth;
     to=2Everify_hash_no_ca=
 =3D options->verify_hash_no_ca;
     memcpy(to=2Ex509_username_field, opti=
ons->x509_username_field, sizeof(to=2Ex509_username_field));
+    to=2Eacc_=
protocols =3D options->acc_protocols;
     to=2Ees =3D c->c2=2Ees;
     to=
=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,6 +4332,24 @@
 }
 #endif /* ifdef TA=
RGET_ANDROID */
 
+static bool
+management_acc_msg(void *arg,
+            =
       struct buffer_list *input) /* ownership transferred */
+{
+    struc=
t context *c =3D arg;
+
+    bool ret =3D false;
+    if (buffer_list_defin=
ed(input) && c->c2=2Etls_multi)
+    {
+        struct tls_multi *multi =3D=
 c->c2=2Etls_multi;
+        struct tls_session *session =3D &multi->sessio=
n[TM_ACTIVE];
+
+        ret =3D management_send_acc_message(c, multi, sess=
ion, input);
+    }
+
+    buffer_list_free(input);
+    return ret;
+}
 #e=
ndif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4322,6 +4366,7 @@
         c=
b=2Eproxy_cmd =3D management_callback_proxy_cmd;
         cb=2Eremote_cmd =
=3D management_callback_remote_cmd;
         cb=2Esend_cc_message =3D manag=
ement_callback_send_cc_message;
+        cb=2Eacc_msg =3D management_acc_ms=
g;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_change =3D management_callb=
ack_network_change;
 #endif
diff --git a/src/openvpn/manage=2Ec b/src/openv=
pn/manage=2Ec
index ac3d4b7=2E=2E5e4e416 100644
--- a/src/openvpn/manage=2E=
c
+++ b/src/openvpn/manage=2Ec
@@ -45,9 +45,11 @@
 #include "push=2Eh"
 #in=
clude "multi=2Eh"
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #include "=
memdbg=2Eh"
 #include "run_command=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef E=
NABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1081,6 +1083,35 @@
             }
 =
            break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (man=
->persist=2Ecallback=2Eclient_acc_msg)
+            {
+                bool=
 status =3D (*man->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecall=
back=2Earg,
+                                                              =
        man->connection=2Ein_extra_cid,
+                                  =
                                    man->connection=2Ein_extra_kid,
+      =
                                                                man->connec=
tion=2Ein_extra);
+                man->connection=2Ein_extra =3D NULL;
+  =
              report_command_status(status, "client-acc-msg");
+           =
 }
+            else
+            {
+                man_command_unsupporte=
d("client-acc-msg");
+            }
+            break;
+
+        case IEC=
_ACC_MSG:
+            if (man->persist=2Ecallback=2Eacc_msg)
+            =
{
+                bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(man=
->persist=2Ecallback=2Earg,
+                                              =
                 man->connection=2Ein_extra);
+                man->connect=
ion=2Ein_extra =3D NULL;
+                report_command_status(status, "ac=
c-msg");
+            }
+            else
+            {
+                m=
an_command_unsupported("acc-msg");
+            }
+            break;
     =
    case IEC_PK_SIGN:
             man->connection=2Eext_key_state =3D EKS_=
READY;
             buffer_list_free(man->connection=2Eext_key_input);
@@ -=
1205,6 +1236,29 @@
 }
 
 static void
+man_client_acc_msg(struct management =
*man, const char *cid_str,
+                   const char *kid_str)
+{
+   =
 struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cid =3D =
0;
+    mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_c=
id)
+        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+    =
    mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IE=
R_NEW);
+    }
+}
+
+static void
+man_acc_msg(struct management *man)
+{
+ =
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

@@ -1759,6 +1813,17 @@
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
@@ -2975,7 +3040,=
9 @@
                                        "bytes_sent=3D",
             =
                           "bytes_received=3D",
                           =
             "session_id=3D",
-                                       "sess=
ion_state=3D" };
+                                       "session_state=3D"=
,
+                                       "acc_protocols=3D",
+            =
                           "acc_message_len=3D" };
 
     if (env_filter_le=
vel =3D=3D 0)
     {
@@ -3130,6 +3197,7 @@
     }
 }
 
+
 void
 management_=
connection_established(struct management *man, struct man_def_auth_context =
*mdac,
                                   const struct env_set *es)
@@ -437=
2,6 +4440,64 @@
     }
 }
 
+bool
+management_send_acc_message(struct conte=
xt *c, struct tls_multi *multi, struct tls_session *session,
+             =
               struct buffer_list *input)
+{
+    /* also ensures that are =
enough inputs in the list to safely call
+     * buffer_list_peek without e=
xtra NULL checks */
+    if (!input || input->size < 3)
+    {
+        msg=
(M_CLIENT, "not enough input lines for sending acc message, "
+            =
          "missing protocol, flag and/or messages lines");
+        return =
false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    const struct b=
uffer *proto_buf =3D buffer_list_peek(input);
+    const char *protocol =3D=
 string_alloc(CBSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+    s=
truct buffer *encoding_buf =3D buffer_list_peek(input);
+    char *encoding=
 =3D buf_str(encoding_buf);
+    const char *flag =3D NULL;
+    bool b64en=
coding =3D false;
+    bool fragment =3D false;
+
+    while ((flag =3D str=
sep(&encoding, ":")))
+    {
+        if (!strcmp(flag, "6"))
+        {
+ =
           b64encoding =3D true;
+        }
+        else if (!strcmp(flag,=
 "F"))
+        {
+            fragment =3D true;
+        }
+    }
+    bu=
ffer_list_pop(input);
+
+    buffer_list_aggregate_separator(input, 10000, =
"");
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);
+
+=
    if (!multi->acc_negotiated_protocols
+        || !tls_item_in_cipher_li=
st(protocol, multi->acc_negotiated_protocols))
+    {
+        msg(M_CLIENT=
, "protocol not in the list of negotiated protocols: %s",
+            np(m=
ulti->acc_negotiated_protocols));
+        goto error;
+    }
+
+    bool r=
et =3D send_acc_message(c, multi, session, protocol,
+                     =
           fragment, buf_cstr(acc_msg_buf),
+                              =
  b64encoding);
+    gc_free(&gc);
+    return ret;
+error:
+    gc_free(&g=
c);
+    return false;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include =
"win32=2Eh"
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
in=
dex 157039d=2E=2Ecc9c264 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/open=
vpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (*n_clients)(void *arg);
    =
 bool (*send_cc_message)(void *arg, const char *message, const char *parame=
ter);
     bool (*kill_by_cid)(void *arg, const unsigned long cid, const ch=
ar *kill_msg);
+
     bool (*client_auth)(void *arg, const unsigned long ci=
d, const unsigned int mda_key_id,
                         const bool auth,=
 const char *reason, const char *client_reason,
                         st=
ruct buffer_list *cc_config); /* ownership transferred */
     bool (*clien=
t_pending_auth)(void *arg, const unsigned long cid, const unsigned int kid,=

                                 const char *extra, unsigned int timeout);=

     char *(*get_peer_info)(void *arg, const unsigned long cid);
+    bool=
 (*client_acc_msg)(void *arg,
+                           const unsigned lo=
ng cid,
+                           const unsigned int mda_key_id,
+       =
                    struct buffer_list *msg);
+    bool (*acc_msg)(void *ar=
g,
+                    struct buffer_list *msg);
     bool (*proxy_cmd)(vo=
id *arg, const char **p);
     bool (*remote_cmd)(void *arg, const char **p=
);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
     struct command_line *i=
n;
     struct buffer_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_=
CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 =
/* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    =
3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWO=
RD    6
+#define IEC_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#defin=
e IEC_PK_SIGN        5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_AC=
C_MSG 7
+#define IEC_ACC_MSG        8
     int in_extra_cmd;
     struct bu=
ffer_list *in_extra;
     unsigned long in_extra_cid;
@@ -503,6 +512,14 @@
=
 
 void man_persist_client_stats(struct management *man, struct context *c)=
;
 
+/** Parses the ACC message from the input buffer_list and send to the
=
+ * session identified by session and multi
+ */
+struct tls_session;
+stru=
ct tls_multi;
+bool
+management_send_acc_message(struct context *c, struct =
tls_multi *multi,
+                            struct tls_session *session,=
 struct buffer_list *input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
d=
iff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=
=2Ea3eb3ca 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@=
@ -53,6 +53,7 @@
 #include "ssl_util=2Eh"
 #include "dco=2Eh"
 #include "re=
flect_filter=2Eh"
+#include "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/=

 
@@ -4085,6 +4086,26 @@
     }
 }
 
+static const char *
+calculate_app_c=
ontrol_extra(struct multi_instance *mi, struct gc_arena *gc)
+{
+    struct=
 context *c =3D &mi->context;
+    struct tls_multi *multi =3D c->c2=2Etls_=
multi;
+
+    if (!multi->acc_negotiated_protocols)
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
:%d A:6 %s", multi->acc_max_message_length,
+               multi->acc_nego=
tiated_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 manageme=
nt_client_pending_auth(void *arg, const unsigned long cid, const unsigned i=
nt mda_key_id,
                                const char *extra, unsigned =
int timeout)
@@ -4095,10 +4116,22 @@
     if (mi)
     {
         struct tl=
s_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena=
 gc =3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+         =
   extra =3D calculate_app_control_extra(mi, &gc);
+            if (!extra)=

+            {
+                gc_free(&gc);
+                return fals=
e;
+            }
+        }
         struct tls_session *session =3D looku=
p_session_by_mda_key_id(multi, mda_key_id);
 
         if (!session)
      =
   {
+            gc_free(&gc);
             return false;
         }
 
@@ =
-4106,6 +4139,7 @@
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
@@ -4149,6 +4183,37 @@
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
+        ret =3D management_send_acc_messag=
e(&mi->context, multi, session, input);
+        multi_schedule_context_wak=
eup(m, mi);
+    }
+
+    buffer_list_free(input);
+    return ret;
+}
+
+
=
 static char *
 management_get_peer_info(void *arg, const unsigned long cid=
)
 {
@@ -4185,6 +4250,7 @@
         cb=2En_clients =3D management_callback_=
n_clients;
         cb=2Ekill_by_cid =3D management_kill_by_cid;
         c=
b=2Eclient_auth =3D management_client_auth;
+        cb=2Eclient_acc_msg =
=3D management_client_acc_msg;
         cb=2Eclient_pending_auth =3D manage=
ment_client_pending_auth;
         cb=2Eget_peer_info =3D management_get_pe=
er_info;
         cb=2Epush_update_broadcast =3D management_callback_send_p=
ush_update_broadcast;
diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec
index fb319ae=2E=2Ee0cf616 100644
--- a/src/openvpn/options=2Ec
+=
++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
=
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include "error=2Eh"
 #include =
"common=2Eh"
@@ -2552,6 +2553,8 @@
     o->push_option_types_found =3D 0;
 =
    o->push_update_options_found =3D 0;
     o->imported_protocol_flags =3D=
 0;
+    o->pushed_acc_max_message_length =3D 0;
+    o->pushed_acc_negotia=
ted_protocols =3D NULL;
 }
 
 static void
@@ -7107,6 +7110,47 @@
         V=
ERIFY_PERMISSION(OPT_P_GENERAL);
         options->force_key_material_expor=
t =3D true;
     }
+    else if (streq(p[0], "app-custom-control") && p[1] =
&& !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!s=
tring_class(p[1], CC_ALNUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))
+       =
 {
+            msg(msglevel, "App custom control protocols must only conta=
in "
+                          "alphanumeric characters, '-', and '_'=2E")=
;
+            goto err;
+        }
+        options->acc_protocols =3D p[1=
];
+    }
+    else if (streq(p[0], "custom-control") && p[1] && p[2] && p[=
3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC);
+
+        /* ch=
eck if the list from the server is a real subset of our list */
+        st=
ruct gc_arena gc_local =3D gc_new();
+        struct buffer common_list =3D=
 get_list_intersection(&gc_local, p[3], options->acc_protocols);
+
+       =
 if (buf_len(&common_list) =3D=3D 0 || !streq(p[3], buf_cstr(&common_list))=
)
+        {
+            msg(msglevel, "App custom control list from serve=
r contains "
+                          "unsupported protocols");
+        =
    gc_free(&gc_local);
+            goto err;
+        }
+        gc_free(=
&gc_local);
+
+        if (!streq(p[2], "A:6") && !streq(p[2], "A:6"))
+   =
     {
+            msg(msglevel, "App custom control encoding must be base=
64 and ascii");
+            goto err;
+        }
+
+        if (!atoi_cons=
trained(p[1], &options->pushed_acc_max_message_length,
+                   =
           "app custom message message length", ACC_MIN_MSG_LEN, ACC_MAX_MS=
G_LEN, msglevel))
+        {
+            goto err;
+        }
+        opt=
ions->pushed_acc_negotiated_protocols =3D p[3];
+    }
     else if (streq(=
p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: --prng=
 option ignored (SSL library PRNG is used)");
diff --git a/src/openvpn/opti=
ons=2Eh b/src/openvpn/options=2Eh
index 6a3bf61=2E=2Eb7945e0 100644
--- a/s=
rc/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -715,6 +715,18 @@
 =
    /* force using TLS key material export for data channel key generation =
*/
     bool force_key_material_export;
 
+    /** The app custom control p=
rotocols we should announce as supported */
+    const char *acc_protocols;=

+
+    /** the protocols that are negotiated with the peer=2E This is a
+ =
    *  a temporary variable since options=2Ec push parser cannot access
+  =
   *  tls multi struct */
+    const char *pushed_acc_negotiated_protocols;=

+
+    /** the maximum length of an ACC control channel message via push m=
essage
+     * */
+    int pushed_acc_max_message_length;
+
     bool vlan_=
tagging;
     enum vlan_acceptable_frames vlan_accept;
     uint16_t vlan_p=
vid;
@@ -764,8 +776,10 @@
 #define OPT_P_INLINE          (1u << 29)
 #defin=
e OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31=
)
+#define OPT_P_ACC             (1ull << 32)
 
-#define OPT_P_DEFAULT (~(O=
PT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allo=
wed in the normal configuration file (vs pushed options or in ccd files) */=

+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID=
 | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/sr=
c/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 42259c3=2E=2Ee8bdca1 100644=

--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #=
include "syshead=2Eh"
 
 #include "push=2Eh"
+
+#include "acc=2Eh"
 #includ=
e "options=2Eh"
 #include "crypto=2Eh"
 #include "ssl=2Eh"
@@ -221,9 +223,5=
6 @@
 #endif
 }
 
+static void
+parse_server_pushed_info_acc(struct context=
 *c, struct buffer *buf)
+{
+    int max_acc_len =3D 0;
+    struct tls_mul=
ti *multi =3D c->c2=2Etls_multi;
+
+    if (multi->acc_negotiated_protocols=
)
+    {
+        return;
+    }
+
+    if (!multi->opt=2Eacc_protocols)
+ =
   {
+        msg(D_PUSH_ERRORS, "Server tried to push app custom control l=
ist "
+                           "without client announcing support for it=
");
+        return;
+    }
+
+    /* example string to parse: ACC:1400 A:6=
 flower:happy */
+    /* Skip over the ACC: prefix */
+    buf_advance(buf,=
 4);
+
+    struct gc_arena gc =3D gc_new();
+    const char *protocols =3D=
 parse_acc_parameters(buf_cstr(buf), " ", &max_acc_len, false, &gc);
+    i=
f (!protocols)
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC in=
fo command with invalid parameters");
+        gc_free(&gc);
+        retur=
n;
+    }
+
+    /* check if the list from the server is a real subset of o=
ur list */
+    struct buffer common_list =3D get_list_intersection(&gc, pr=
otocols, multi->opt=2Eacc_protocols);
+
+    if (buf_len(&common_list) =3D=
=3D 0 || !streq(protocols, buf_cstr(&common_list)))
+    {
+        msg(D_P=
USH_ERRORS, "App custom control list from server contains "
+              =
             "unsupported protocols");
+        gc_free(&gc);
+        retu=
rn;
+    }
+
+    multi->acc_negotiated_protocols =3D string_alloc(protocol=
s, NULL);
+    multi->acc_max_message_length =3D max_acc_len;
+    notify_c=
lient_acc_protocols(multi);
+    gc_free(&gc);
+}
 
 void
-server_pushed_in=
fo(const struct buffer *buffer, const int adv)
+server_pushed_info(struct c=
ontext *c, const struct buffer *buffer, const int adv)
 {
     const char *=
m =3D "";
     struct buffer buf =3D *buffer;
@@ -233,6 +282,12 @@
        =
 m =3D BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {=

+        parse_server_pushed_info_acc(c, &buf);
+        return;
+    }
+
=
 #ifdef ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ =
-285,6 +340,7 @@
     msg(D_PUSH, "CR response was sent by client ('%s')", =
m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING request
  * @par=
am buffer                buffer containing the keywords, the buffer's
@@ -4=
41,7 +497,6 @@
     const char *const peer_info =3D tls_multi->peer_info;
 =
    unsigned int proto =3D extract_iv_proto(peer_info);
 
-
     /* Calcula=
te the maximum timeout and subtract the time we already waited */
     unsi=
gned int max_timeout =3D
         max_uint(tls_multi->opt=2Erenegotiate_sec=
onds / 2, tls_multi->opt=2Ehandshake_window);
@@ -732,6 +787,12 @@
        =
         client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
    =
 }
+
+    if (tls_multi->acc_negotiated_protocols)
+    {
+        push_opt=
ion_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s",
+              =
          tls_multi->acc_max_message_length, tls_multi->acc_negotiated_prot=
ocols);
+    }
 }
 
 static bool
diff --git a/src/openvpn/push=2Eh b/src/op=
envpn/push=2Eh
index 39302f6=2E=2Eb6695bc 100644
--- a/src/openvpn/push=2Eh=

+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_incoming_push_=
request(struct context *c);
 
+
 /**
  * @brief Handles the receiving of a =
push-update message and applies updates to the specified
  * options=2E
@@ =
-92,7 +93,7 @@
 
 void receive_exit_message(struct context *c);
 
-void ser=
ver_pushed_info(const struct buffer *buffer, const int adv);
+void server_p=
ushed_info(struct context *c, const struct buffer *buffer, const int adv);
=
 
 void receive_cr_response(struct context *c, const struct buffer *buffer)=
;
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6fc=2E=
=2E0a25149 100644
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
 
@@ -2098,6 +2100,11 @@
 #endif
         }
 
+        if (se=
ssion->opt->acc_protocols)
+        {
+            buf_printf(&out, "IV_ACC=
=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+        }
=
+
         if (session->opt->push_peer_info_detail > 1)
         {
        =
     struct env_set *es =3D session->opt->es;
@@ -2398,6 +2405,8 @@
       =
  multi->remote_ciphername =3D string_alloc("none", NULL);
     }
 
+    de=
termine_common_acc_protocols(multi, session);
+
     if (username_len < 0 |=
| password_len < 0)
     {
         msg(D_TLS_ERRORS, "TLS Error: Username =
(%d) or password (%d) too long", abs(username_len),
diff --git a/src/openvp=
n/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9a55ead=2E=2E436770b 10=
0644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -=
457,6 +457,9 @@
     size_t ekm_size;
 
     bool dco_enabled; /**< Whether=
 keys have to be installed in DCO or not */
+
+    /** The app custom contr=
ol protocols we should announce as supported */
+    const char *acc_protoc=
ols;
 };
 
 /** @addtogroup control_processor
@@ -730,6 +733,12 @@
     int=
 dco_peer_id;
 
     dco_context_t *dco;
+
+    /** the protocols that are =
negotiated with the peer=2E */
+    char *acc_negotiated_protocols;
+
+    =
/** the maximum length of an ACC control channel message */
+    int acc_ma=
x_message_length;
 };
 
 /**  gets an item  of \c key_state objects in the
=
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/open=
vpn/Makefile=2Eam
index 43a6743=2E=2E6a73e1e 100644
--- a/tests/unit_tests/=
openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -107,=
10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $=
(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
+	test_ac=
c=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_m=
anagement=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
 	$(top=
_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2E=
c \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base=
64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -132,6 +134,7 @@
 	$(t=
op_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_op=
enssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/s=
rc/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top=
_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/s=
sl_verify_openssl=2Ec \
diff --git a/tests/unit_tests/openvpn/mock_manageme=
nt=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index fff4c2b=2E=2Ef5=
72dbb 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests=
/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 
 #include "sysh=
ead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
 #ifdef ENABLE_M=
ANAGEMENT
diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec =
b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
index bf2ccf3=2E=2Ef0=
83f89 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ =
b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -43,7 +43,8 @@
   =
  uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_=
SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER=
 | OPT_P_COMP | OPT_P_PERSIST
                      | OPT_P_MESSAGES | OPT_=
P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                     | OP=
T_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+  =
                   | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROU=
TE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
     return flags;
 }=

 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/op=
envpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=2E9364d12
--- /dev=
/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,0 +1,353 @@
+/*
+ *=
  OpenVPN -- An application to securely tunnel IP networks
+ *             =
over a single TCP/UDP port, with support for SSL/TLS-based
+ *             =
session authentication and key exchange,
+ *             packet encryption,=
 packet authentication, and
+ *             packet compression=2E
+ *
+ *  =
Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 202=
5 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free softw=
are; you can redistribute it and/or modify
+ *  it under the terms of the G=
NU General Public License version 2
+ *  as published by the Free Software =
Foundation=2E
+ *
+ *  This program is distributed in the hope that it will=
 be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warrant=
y of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+=
 *  GNU General Public License for more details=2E
+ *
+ *  You should have=
 received a copy of the GNU General Public License along
+ *  with this pro=
gram; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Frankl=
in Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CO=
NFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include=
 <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2Eh>
+#include <strin=
g=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "acc=2Eh"
=
+#include "test_acc=2Eh"
+#include "test_common=2Eh"
+
+#include "mock_msg=
=2Eh"
+#include "multi=2Eh"
+
+char control_channel_message_sent[2048];
+
+=
/* Mock functions */
+bool
+send_control_channel_string_dowork(struct tls_s=
ession *session,
+                                   const char *str, unsig=
ned int msglevel)
+{
+    assert_int_in_range(strlen(str), 0, 2047);
+
+   =
 strcpy(control_channel_message_sent, str);
+    return true;
+}
+
+void
+s=
end_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_=
client_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#define=
 MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+  =
                  "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" =
\
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABr=
wCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIAC=
gAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMA=
AuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQM=
DAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk=
4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=3D=3D"=

+
+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENABLE_M=
ANAGEMENT
+    skip();
+#else
+    /* ensure that the messages get to mock_=
msg */
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678;
+ =
   struct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientHe=
llo */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    stru=
ct buffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=2Emode=
 =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_=
multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=2Ec=
2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->mda_=
context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void *)msg,=
 sizeof(msg));
+
+    receive_acc_message(&c, &msg_buf);
+    assert_string=
_equal(mock_msg_buf, "WARNING: Received malformed custom app control channe=
l message (ACC not enabled or no negotiated protocols): 4143432c 63636b31 2=
c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]");
+    =
assert_string_equal(mock_managment_buf, "");
+
+    c=2Ec2=2Etls_multi->acc=
_negotiated_protocols =3D "no:common:protocol";
+    receive_acc_message(&c=
, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WARNING: Received malf=
ormed custom app control channel message (protocol 'cck1' not in list of ne=
gotiated protocols 'no:common:protocol'): 4143432c 63636b31 2c333834 2c362c=
46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]");
+    assert_string_=
equal(mock_managment_buf, "");
+
+    c=2Ec2=2Etls_multi->acc_negotiated_pr=
otocols =3D "cck1:flower:power:fortune";
+    receive_acc_message(&c, &msg_=
buf);
+
+    assert_string_equal(mock_msg_buf, "Received custom app control=
 message (protocol 'cck1')");
+    assert_string_equal(mock_managment_buf, =
">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] =3D =
"ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+  =
  buf_set_read(&msg_buf, (void *)flower_msg, sizeof(flower_msg));
+    rece=
ive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "Rece=
ived custom app control message (protocol 'flower')");
+    assert_string_e=
qual(mock_managment_buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0=
aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    cons=
t char msg_incorrect_len[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeG=
Zm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf, (v=
oid *)msg_incorrect_len, sizeof(msg_incorrect_len));
+    receive_acc_messa=
ge(&c, &msg_buf);
+    const char *error =3D "WARNING: Received malformed c=
ustom app control channel "
+                        "message (field length=
 62, payload length 64 mismatch): "
+                        "4143432c 666f=
7274 756e652c 36322c36 2c496e73 67496d31 "
+                        "6c496a=
6f 67496d5[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error)=
;
+    assert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_manag=
ment_buf);
+    const char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=
=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragm=
ent));
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(moc=
k_msg_buf, "Received custom app control message (protocol 'power', fragment=
)");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,=
aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    /* check two enc=
oding present */
+    const char flower_msg_two_encs[] =3D "ACC,flower,48,6=
A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(=
&msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    r=
eceive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malfo=
rmed custom app control channel message "
+            "(number of encoding=
s must be exactly one (B64=3D1, ASCII=3D1)): "
+            "4143432c 666c6=
f77 65722c34 382c3641 2c535342 68625341 41494574 "
+            "6c636d3[mo=
re=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+    assert=
_string_equal(mock_managment_buf, "");
+
+    /* no encoding present */
+  =
  const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//=
SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flowe=
r_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_message(&c, &m=
sg_buf);
+
+    error =3D "WARNING: Received malformed custom app control c=
hannel message "
+            "(number of encodings must be exactly one (B6=
4=3D0, ASCII=3D0)): "
+            "4143432c 666c6f77 65722c34 382c2c53 534=
26862 53414149 45746c63 "
+            "6d31706[more=2E=2E=2E]";
+    asser=
t_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_managmen=
t_buf, "");
+
+    x_debug_level =3D 0;
+    management =3D NULL;
+    gc_f=
ree(&gc);
+#endif
+}
+
+void
+test_parse_acc_parameters(void **state)
+{
+ =
   struct gc_arena gc =3D gc_new();
+    /* parameters to INFO message */
+=
    const char *info_acc_msg =3D "4096 A:6 flower:happy";
+
+    int max_le=
n =3D 0;
+    const char *protocols =3D parse_acc_parameters(info_acc_msg, =
" ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happ=
y");
+    assert_int_equal(max_len, 1280);
+
+    /* a client does not acce=
pt a length longer than it supports */
+    protocols =3D parse_acc_paramet=
ers(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
=
+
+    /* message with lower limit than our, should work for client and ser=
ver */
+    info_acc_msg =3D "1111 A:6 flower:happy";
+    protocols =3D pa=
rse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_st=
ring_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1111)=
;
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, tr=
ue, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_=
int_equal(max_len, 1111);
+
+    /* more encodings than supported=2E Server=
 should be okay, client should fail */
+    info_acc_msg =3D "1200 A:6:B fl=
ower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &ma=
x_len, false, &gc);
+    assert_null(protocols);
+
+    protocols =3D parse=
_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string=
_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1200);
+
=
+    /* extra parameter */
+    info_acc_msg =3D "1400 A:6 flower:happy 77"=
;
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true=
, &gc);
+    assert_null(protocols);
+
+    protocols =3D parse_acc_paramet=
ers(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
=
+
+
+    const char *iv_acc_capabilities =3D "1400,A:6,flower:happy:power";=

+    protocols =3D parse_acc_parameters(iv_acc_capabilities, ",", &max_len=
, true, &gc);
+    assert_string_equal(protocols, "flower:happy:power");
+
=
+    /* too small protocol length */
+    info_acc_msg =3D "32 A:6 flower:h=
appy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len,=
 true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical protocol =
length */
+    info_acc_msg =3D "abff A:6 flower:happy";
+    protocols =3D=
 parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_=
null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protocols=
(void **state)
+{
+    struct multi_instance mi =3D { 0 };
+    struct cont=
ext *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_O=
BJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+
+    =
c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower=
:happy:power";
+    c->options=2Eacc_protocols =3D "power:flower:star";
+  =
  struct tls_multi *multi =3D c->c2=2Etls_multi;
+    multi->opt=2Eacc_prot=
ocols =3D c->options=2Eacc_protocols;
+    multi->session[TM_ACTIVE]=2Eopt =
=3D &multi->opt;
+    multi->opt=2Ees =3D env_set_create(&c->options=2Egc);=

+
+    determine_common_acc_protocols(multi, &c->c2=2Etls_multi->session[T=
M_ACTIVE]);
+
+    assert_int_equal(multi->acc_max_message_length, ACC_MAX_=
MSG_LEN);
+    assert_string_equal(multi->acc_negotiated_protocols, "power:=
flower");
+
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_prot=
ocols"), "acc_protocols=3Dpower:flower");
+    assert_string_equal(env_set_=
get(multi->opt=2Ees, "acc_message_len"), "acc_message_len=3D1280");
+
+    =
free(multi->acc_negotiated_protocols);
+    gc_free(&c->options=2Egc);
+}
+=

+void
+test_acc_send_message(void **state)
+{
+    struct multi_instance m=
i =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->options=2Egc=
 =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_mult=
i, &c->options=2Egc);
+    bool ret;
+    struct tls_multi *multi =3D c->c2=
=2Etls_multi;
+    c->options=2Eacc_protocols =3D "power:flower:emergency";=

+    multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+    multi=
->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D env_se=
t_create(&c->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PRO=
TO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power";
+    determine_common=
_acc_protocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    struc=
t tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+    r=
et =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency", true,
+=
                           "EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRI=
LL:", false);
+
+    assert_true(ret);
+    assert_string_equal(control_cha=
nnel_message_sent,
+                        "ACC,emergency,50,AF,EMERGENCY =
BROADCAST MESSAGE - THIS IS NOT A DRILL:");
+
+    ret =3D send_acc_message=
(c, c->c2=2Etls_multi, session, "emergency", false,
+                      =
     "THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E",=
 false);
+    assert_true(ret);
+    assert_string_equal(control_channel_me=
ssage_sent,
+                        "ACC,emergency,65,A,THE GOVERNMENT HAS=
 ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E");
+
+
+    /* test a lon=
g message (> 1000) with fragment to get the maximum header size */
+    cha=
r long_message[1200] =3D { 0 };
+
+    for (int i =3D 0; i < 1024; i++)
+  =
  {
+        long_message[i] =3D (char)(' ' + (i % 95));
+    }
+
+    /* l=
ast char of the message is a i and then a \0 */
+    assert_int_equal(long_=
message[1023], 'i');
+    assert_int_equal(long_message[1024], '\0');
+
+  =
  ret =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency", true=
,
+                           long_message, false);
+
+    assert_true(ret)=
;
+    size_t cc_len =3D strlen(control_channel_message_sent);
+    assert_=
int_equal(control_channel_message_sent[cc_len - 1], 'i');
+    const char *=
expected_start_cc =3D "ACC,emergency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+ =
   assert_memory_equal(control_channel_message_sent, expected_start_cc, str=
len(expected_start_cc));
+
+    free(multi->acc_negotiated_protocols);
+   =
 gc_free(&c->options=2Egc);
+}
+
+void
+test_list_intersection(void **state=
)
+{
+    const char *empty =3D "";
+    const char *protos =3D "power:flow=
er:emergency";
+
+    struct gc_arena gc =3D gc_new();
+
+    struct buffer=
 t1 =3D get_list_intersection(&gc, empty, protos);
+    assert_int_equal(bu=
f_len(&t1), 0);
+
+    struct buffer t2 =3D get_list_intersection(&gc, prot=
os, empty);
+    assert_int_equal(buf_len(&t2), 0);
+
+    struct buffer t3=
 =3D get_list_intersection(&gc, protos, protos);
+    assert_string_equal(b=
uf_cstr(&t3), protos);
+
+    const char *protos2 =3D "flower:emergency:pow=
er:mario";
+    struct buffer t4 =3D get_list_intersection(&gc, protos2, pr=
otos);
+    assert_string_equal(buf_cstr(&t4), "flower:emergency:power");
+=

+    const char *protos3 =3D "super:paper:mario:flower";
+    struct buffe=
r t5 =3D get_list_intersection(&gc, protos2, protos3);
+    assert_string_e=
qual(buf_cstr(&t5), "flower:mario");
+
+    const char *proto4 =3D "flower:=
flower:flower:flower";
+    struct buffer t6 =3D get_list_intersection(&gc,=
 proto4, "flower");
+    assert_string_equal(buf_cstr(&t6), "flower");
+
+
=
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/=
tests/unit_tests/openvpn/test_acc=2Eh
new file mode 100644
index 0000000=2E=
=2E32421fb
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Eh
@@ -0,=
0 +1,35 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single UDP port, with support for SSL/TLS-based
+ =
*             session authentication and key exchange,
+ *             pack=
et encryption, packet authentication, and
+ *             packet compressio=
n=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
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
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/=
licenses/>=2E
+ */
+
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+void test_a=
cc_parse_client_messages(void **state);
+
+void test_parse_acc_parameters(v=
oid **state);
+
+void test_acc_common_protocols(void **state);
+
+void test=
_acc_send_message(void **state);
+
+void test_list_intersection(void **stat=
e);
+#endif
diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/u=
nit_tests/openvpn/test_common=2Eh
index 8db4ea6=2E=2Ec865142 100644
--- a/t=
ests/unit_tests/openvpn/test_common=2Eh
+++ b/tests/unit_tests/openvpn/test=
_common=2Eh
@@ -43,11 +43,13 @@
 #define LargestIntegralType uintmax_t
 #en=
dif
 /* redefine 2=2Ex API in terms of 1=2Ex API */
-#define CMockaValueDat=
a             LargestIntegralType
-#define check_expected_uint         chec=
k_expected
-#define expect_uint_value           expect_value
-#define expec=
t_check_data           expect_check
-#define cast_ptr_to_cmocka_value(x) (x=
)
+#define CMockaValueData                       LargestIntegralType
+#defi=
ne check_expected_uint                   check_expected
+#define expect_uin=
t_value                     expect_value
+#define expect_check_data        =
             expect_check
+#define cast_ptr_to_cmocka_value(x)           (x=
)
+#define assert_int_in_range(value, min, max)  assert_in_range((value), (=
min), (max))
+#define assert_uint_in_range(value, min, max) assert_in_range=
((value), (min), (max))
 #endif
 
 /**
diff --git a/tests/unit_tests/openvp=
n/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2E4=
987dd0 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_=
tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #i=
nclude "openvpn=2Eh"
 
+#include "test_acc=2Eh"
+
 /* Mock function to be a=
llowed to include win32=2Ec which is required for
  * getting the temp dire=
ctory */
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
     return;
 }
+void
+resche=
dule_multi_process(struct context *c)
+{
+}
+
+/* Define a dummy dco cipher=
 option to avoid linking against all the DCO
+ * units */
+#if defined(ENAB=
LE_DCO)
+const char *
+dco_get_supported_ciphers(void)
+{
+    return "AES-=
192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
=
 
 /* generated using
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen=
_curve:secp384r1 -keyout - \
@@ -1111,8 +1127,12 @@
         cmocka_unit_te=
st(ssl_test_extract_last_matching_field),
         cmocka_unit_test(ssl_tes=
t_reject_null_in_cert_subject),
         cmocka_unit_test(ssl_test_escape_r=
fc_2253_chars_in_subject),
-        cmocka_unit_test(ssl_test_extract_peer_=
info)
-
+        cmocka_unit_test(ssl_test_extract_peer_info),
+        cmo=
cka_unit_test(test_acc_parse_client_messages),
+        cmocka_unit_test(te=
st_parse_acc_parameters),
+        cmocka_unit_test(test_acc_common_protoco=
ls),
+        cmocka_unit_test(test_acc_send_message),
+        cmocka_unit=
_test(test_list_intersection)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e158=
96b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 21
=
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--sRGEec6N5II=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #21</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vie=
w Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Implement sending/receiving app custom contro=
l protocol messages<br><br>This allows openvpn GUI/front-ends and server vi=
a management<br>to use the OpenVPN control channel to pass messages between=
 each other<br>while OpenVPN handles the marshalling/unmarshalling of these=
 and<br>negotiate the common app custom control protocols=2E<br><br>This pr=
ovides an easy to use secure channel that does not depend on<br>the network=
 itself to work and can also be used before fully<br>authenticating the cli=
ent=2E See the management-notes=2Etxt for more<br>details how to use this f=
eature=2E An upcoming patch will also add<br>some example python scripts th=
at showcase this feature=2E<br><br>Change-Id: I4a6a6ef41e15896b8b79d795b2a6=
de86b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>-=
--<br>M CMakeLists=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M do=
c/man-sections/management-options=2Erst<br>M doc/man-sections/script-option=
s=2Erst<br>M doc/management-notes=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A=
 src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M src/openvpn/forward=2Ec<=
br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/mana=
ge=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/ope=
nvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M s=
rc/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/unit_tests/op=
envpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>M =
tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>A tests/unit_tests/o=
penvpn/test_acc=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Eh<br>M tests/u=
nit_tests/openvpn/test_common=2Eh<br>M tests/unit_tests/openvpn/test_ssl=2E=
c<br>26 files changed, 1,527 insertions(+), 22 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/58/1858/21</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span=
><br><span>index 184a95a=2E=2E4deabe7 100644</span><br><span>--- a/CMakeLis=
ts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -435,6 +=
435,8 @@</span><br><span>     src/compat/compat-strlcpy=2Ec</span><br><span=
>     src/compat/compat-strsep=2Ec</span><br><span>     src/compat/compat-s=
trtok_r=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/acc=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><sp=
an>     src/openvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</s=
pan><br><span>@@ -826,6 +828,8 @@</span><br><span>             tests/unit_t=
ests/openvpn/mock_management=2Ec</span><br><span>             tests/unit_te=
sts/openvpn/mock_ssl_dependencies=2Ec</span><br><span>             tests/un=
it_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            tests/unit_tests/openvpn/test_acc=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/ac=
c=2Ec</span><br><span>             src/openvpn/argv=2Ec</span><br><span>   =
          src/openvpn/base64=2Ec</span><br><span>             src/openvpn/c=
rypto_epoch=2Ec</span><br><span>@@ -842,6 +846,7 @@</span><br><span>       =
      src/openvpn/packet_id=2Ec</span><br><span>             src/openvpn/ru=
n_command=2Ec</span><br><span>             src/openvpn/ssl_mbedtls=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/=
ssl_ncp=2Ec</span><br><span>             src/openvpn/ssl_openssl=2Ec</span>=
<br><span>             src/openvpn/ssl_util=2Ec</span><br><span>           =
  src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>diff --git a/doc/man-s=
ections/client-options=2Erst b/doc/man-sections/client-options=2Erst</span>=
<br><span>index 87c138a=2E=2E16309f9 100644</span><br><span>--- a/doc/man-s=
ections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client-=
options=2Erst</span><br><span>@@ -437,6 +437,12 @@</span><br><span>        =
 Additional authentication methods supported by the client=2E</span><br><sp=
an>         This may be set by the client UI/GUI using ``--setenv``=2E</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :cod=
e:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags&gt;,&lt;protocols&gt;`</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        If the option ``--app-=
custom-control`` is set, the client will</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        send the supported max ACC message length, the=
 supported formats</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       as (:code:`A:6`) and the list of configured protocols (e=2Eg=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        :code:`flower:ha=
ppy:power`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>   The following flags depend on which compression formats are com=
piled in</span><br><span>   and whether compression is allowed by options=
=2E See `Protocol options`_</span><br><span>   for more details=2E</span><b=
r><span>diff --git a/doc/man-sections/management-options=2Erst b/doc/man-se=
ctions/management-options=2Erst</span><br><span>index 2c79d05=2E=2E315e567 =
100644</span><br><span>--- a/doc/man-sections/management-options=2Erst</spa=
n><br><span>+++ b/doc/man-sections/management-options=2Erst</span><br><span=
>@@ -144,3 +144,17 @@</span><br><span> </span><br><span> --management-up-do=
wn</span><br><span>   Report tunnel up/down events to management interface=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+--app-custom-control protocol-list<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the list of s=
upported app custom control protocols=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  These protocols are announced to the server via the =
IV_ACC peer info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  v=
ariable when this option is used on a client=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  If the option is set on a server it will nego=
tiate common protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  with the client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The protocol-=
list is a : separated list of protocol identifiers=2E Protocol</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  identifiers must consist of al=
phanumeric characters, :code:`-`, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  :code:`_`=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See =
management-notes=2Etxt in the OpenVPN distribution and the OpenVPN RFC</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  draft for a descriptio=
n of app custom control protocol support=2E</span><br><span>diff --git a/do=
c/man-sections/script-options=2Erst b/doc/man-sections/script-options=2Erst=
</span><br><span>index f420380f=2E=2E474c7fd 100644</span><br><span>--- a/d=
oc/man-sections/script-options=2Erst</span><br><span>+++ b/doc/man-sections=
/script-options=2Erst</span><br><span>@@ -1006,3 +1006,12 @@</span><br><spa=
n>        X509_1_L=3DBISHKEK</span><br><span>        X509_1_ST=3DNA</span><=
br><span>        X509_1_C=3DKG</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`a=
cc_protocols`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    If=
 ``--app-custom-control`` is configured and the client supports any of the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols that s=
erver also supports, this variable contains a list of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    common protocols separated by :=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+:code:`acc_message_len`</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if :code:`acc_protocols` is set, =
this variable contains the maximum</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    message length for app custom protocol message=2E</span>=
<br><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2E=
txt</span><br><span>index 4d726c4=2E=2Ea6dcc2f 100644</span><br><span>--- a=
/doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etx=
t</span><br><span>@@ -828,6 +828,58 @@</span><br><span> that is required to=
 continue the connection (unlike MFA or opening a browser)</span><br><span>=
 this message is not negotiated but can just be sent as a gratuitous messag=
e=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+app custom control</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+If the special string &quot;ACC&quot; =
is passed as {EXTRA} OpenVPN will determine</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+the common app custom protocols between the client =
and the server and instruct</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+the client that the server will send control messages to the client=
 using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ACC proto=
col=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+The server should then use clien=
t-acc-msg command to send app custom</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+control messages to the client to facilitate the pending a=
uthentication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-acc-=
msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+-------------------------------------------------</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+On an OpenVPN instance running in server mode this com=
mand sends an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+app cu=
stom control message to a client=2E The format of the command is:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID -- client ID a=
nd Key ID=2E See documentation for &quot;&gt;CLIENT:&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+notification for more info=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+protocol -- the ACC protocol identifier that =
this message should be</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            tagged with=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+flags    =
-- a colon separated list of the encoding and the flag if</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            the message is a fragment=
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
-----------------------</span><br><span> </span><br><span>@@ -1302,6 +1354,=
47 @@</span><br><span>    response=2E Mechanisms that need multiple rounds =
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
: hsl(120, 100%, 40%);">+    message=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    Note that the OpenVPN implementation operates here with the robustness=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    principle (&quo=
t;be conservative in what you send, be liberal in what you</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    accept&quot; - RFC 793 and other=
s) and allows receiving messages longer than</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    maximum allowed message length=2E Implementati=
ons should be prepared to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    handle messages that are longer than the maximum allowed message =
length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+(7) App custom control protocol message</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+   This message informs the client about the co=
mmon ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protocol=
s and the maximum message length for an ACC message=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+   In client mode:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   &=
gt;ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{max_msg_len}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   protocol_list is the list of supported=
 protocols by both server and client=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   For example flower:power:sys_info would indicate the=
se three protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
  are supported=2E max_msg_len specifies the maximum message length that th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   peer supports=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+   In server mode these information=
 are available in the acc_protocols and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   acc_message_len variables of the client environment=
=2E</span><br><span> </span><br><span> Variables:</span><br><span> </span><=
br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam=
</span><br><span>index 8a60a94=2E=2Eebc4db6 100644</span><br><span>--- a/sr=
c/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</sp=
an><br><span>@@ -45,6 +45,7 @@</span><br><span> sbin_PROGRAMS =3D openvpn</=
span><br><span> </span><br><span> openvpn_SOURCES =3D \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><br><span> 	ar=
gv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=2Eh \</span><=
br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -124,7 +125,8 @@</spa=
n><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \=
</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br><span> 	pushlist=2E=
h \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><br><sp=
an> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git a/src/openvpn/a=
cc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2E860ffa8</span><br><span>--- /dev/null</span><br><=
span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,451 @@</span><br>=
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
sl(120, 100%, 40%);">+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* server mode=2E =
Report client context */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            struct man_def_auth_context *mda =3D session-&gt;opt-&gt;m=
da_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt;m=
da_key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                mda-&gt;cid, mda_k=
ey_id, protocol, fragment, payload_msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /* Client mode=2E Do not a report a CLIENT id */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;ACC:=
%s,%d,%s&quot;, protocol, fragment, payload_msg);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received custom app control =
message (protocol &#39;%s&#39;%s)&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        protocol, fragment ? &quot;, fragment&quot; : =
&quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  Parses the flags field of an app control message and moves the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  buffer past the flags str=
ing=2E If there is an</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  error parsing the flags field the method returns -1 and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  puts the error reason in err_=
reason</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(struct buffer =
*buf, const char **err_reason, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *flags =3D buf_extract_field(buf, &#39;,&#39=
;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        *err_reason =3D &quot;could not extract f=
lags field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A&#=
39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=
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
20, 100%, 40%);">+    const struct tls_multi *multi =3D c-&gt;c2=2Etls_mult=
i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&g=
t;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  err_reason =3D &quot;ACC not enabled or no negotiated protocols&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&quot;ACC&quot;)) |=
| buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        err_reason =3D &quot;missing , after ACC&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* extract protocol, payload length, flags substrings */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =
=3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!protocol)</span><br><span style=
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
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!payload_len_str</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !atoi_constrai=
ned(payload_len_str, &amp;payload_len, &quot;acc_payload_len&quot;, 0, TLS_=
CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(1=
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
             &quot;message (%s): %s&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        err_reason,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        format_hex(CBPTR(buffer), BLEN(buffer), 80, =
&amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sen=
d_acc_message(struct context *c,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 struct tls_multi *multi,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 struct tls_session *ses=
sion,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   const char *protocol, bool fragment,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 const char *msg, bool base64)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * length of the protocol string + one &#39;,&#39;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 2 for the encodin=
g (A or 6), potential F (fragment), and 1 for the &#39;,&#39;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * 4 for the message size it=
self and one comma</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * 1 for the comma before the message itself */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const size_t max_header_size =3D strlen(=
&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D max_header_size + =
strlen(msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANN=
EL_BUF_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT,=
 &quot;message length (%zu) exceeds maximum possible message length (%d)&qu=
ot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &=
gt; multi-&gt;acc_max_message_length)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_CLIENT, &quot;header (%zu) + message size (%zu) length (%=
zu) exceeds &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                     &quot;maximum allowed length negotiated with peer (%d)=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
max_header_size, strlen(msg), len,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            multi-&gt;acc_max_message_length);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_bu=
f_gc(len + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example =
message: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&=
quot;, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
            strlen(msg),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+               base64 ? &quot;6&quot; : &quot;A&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+               fragment ? &quot;F&q=
uot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+               msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D =
send_control_channel_string_dowork(session, BSTR(&amp;buf), D_PUSH);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    reschedule_multi_proce=
ss(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+parse_acc_parameters(const char *capabilities,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                     const char *delim=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   int *max_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     bool server,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                     struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *tmp_message =3D string_alloc(capabilities, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_me=
ssage_orig =3D tmp_message;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *token =3D strtok_r(tmp_message, delim, &amp;lasts);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int acclen =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *protocols =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* In server mode we allow more capabilities th=
an our own, in client</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * mode we reject if we should use capabilities that we do not suppor=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int allowed=
_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    while (token)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p =3D=3D 0 &amp;&amp; !atoi_constrained(token, &amp;acclen, &quot;ACC=
 message length&quot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; (!tls_item_in_cipher_lis=
t(&quot;A&quot;, token) || !tls_item_in_cipher_list(&quot;6&quot;, token)))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS=
, &quot;App custom control encoding must include base64 and ascii&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto done=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; !server &amp;=
&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; strcmp(token, &quot;6:A&quo=
t;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ER=
RORS, &quot;App custom control encoding must be exactly base64 and ascii&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            go=
to done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 2)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            protocols =3D token;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (p =3D=3D 3)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(D_PUSH_ERRORS, &quot;Too many parameters for INFO =
ACC message/IV_ACC=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            goto done;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        token =
=3D strtok_r(NULL, delim, &amp;lasts);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        p++;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *max_acc_len =3D =
min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ret =3D string_alloc(protocols, gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    free(tmp_message_orig);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena=
 *gc, const char *list1, const char *list2)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *tmp =3D string_alloc(list1, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp=
, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Th=
e maximum possible length is the shorter of the two input lists */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    size_t max_len =3D min_s=
ize(strlen(list1), strlen(list2));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* check for every items is in both lists and not alread=
y in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
common list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (tls_item_in_cipher_list(token, list2)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &amp;&amp; !tls_item_in_cipher_list(to=
ken, buf_cstr(&amp;common_protocols)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (buf_len(&amp;common_protocols) &gt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                buf_write_u8(&amp;com=
mon_protocols, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            buf_printf(&amp;common_protocols, &quot;%s&quot;, token);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL,=
 &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
ree(tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 common_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+determine_common_acc_protocols(struct tls_multi *mult=
i, struct tls_session *session)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!multi-&gt;opt=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* No app custom protocols have been configured server-side=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (multi-&gt;acc_negotiated_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* We already have determined the common=
 protocols=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D2048,6:A,=
flower:power */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *peer_info =3D multi-&gt;peer_info;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *iv_acc =3D extract_var_peer_info=
(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_len =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
protocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max_acc_len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!protocols)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &qu=
ot;WARNING: IV_ACC peer info variable of peer is malformed&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer common_protocols =3D get_list_intersection(&amp=
;gc, multi-&gt;opt=2Eacc_protocols, protocols);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (buf_len(&amp;common_protocols) =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING: No common =
app custom control protocol=2E&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&g=
t;acc_negotiated_protocols =3D string_alloc(buf_str(&amp;common_protocols),=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&g=
t;acc_max_message_length =3D max_acc_len;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    setenv_str(session-&gt;opt-&gt;es, &quot;acc_protocols&quot;, multi-=
&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    setenv_int(session-&gt;opt-&gt;es, &quot;acc_message_len&quo=
t;, multi-&gt;acc_max_message_length);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct tls_multi *mult=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;&gt;ACC_PROTOCOL=
S:protocols=3D%s,message_len=3D%d&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi-&gt;acc_negotiated_protocols, multi-=
&gt;acc_max_message_length);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><span>new =
file mode 100644</span><br><span>index 0000000=2E=2E2fe9efd</span><br><span=
>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@=
 -0,0 +1,113 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An app=
lication to securely tunnel IP networks</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             session authentication and key exchange,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet=
 authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet compression=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Sch=
wabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fr=
ee software; you can redistribute it and/or modify</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pu=
blic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  as published by the Free Software Foundation=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  This program is distributed in the hope that it will =
be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  GNU General Public License for more details=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gen=
eral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  with this program; if not, write to the Free Software Foundation,=
 Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Fran=
klin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_LEN 64</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN 1280</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * This method parses an app custom control message and =
delivers it to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* management interface=2E We leave reassembly of fragmented messages to the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * management inter=
face=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c            The co=
ntext struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buffer       Buffer containing the control message with ACC</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+receive_acc_message(struct context *c, const struct buffer *buf=
fer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+send_acc_message(struct context *c,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 struct tls_multi *tls_multi,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct t=
ls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 const char *protocol, bool fragment,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 const char *msg, bool b=
ase64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Parses an info message from the server that contains app custom=
 control info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * inf=
ormation prior to the PUSH_REPLY to be able to use app custom control</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocols before sendi=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * In client mode only allow what =
we support ourselves=2E In server mode</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * allow also capabilities that we not support ourselves=
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
ets multi=2Eacc_negotiated_protocols</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * to the common protocols of server and client and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi=2Eacc_max_message=
_length  to the maximum length of the ACC message</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * support by both server and client=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * If there is no common protocol or the =
client does not support any app custom</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * protocol multi=2Eacc_negotiated_protocols will be set=
 to NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi      the =
multi instance to use the set the app custom protocols=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param session    the session to r=
ead the client env from</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protoc=
ols(struct tls_multi *multi, struct tls_session *session);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Calculates the intersection of two list that are both separated by :=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Items in the res=
ult will have the same ordering as in the list1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * parameters</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param gc            Returned buffer will be alloc=
ated in this gc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param list1         First list to intersect</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param list2         Second list to intersect=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return A (poten=
tially empty) buffer containing an intersection list</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+get_list_intersection(struct gc_arena *gc, const char *list1, c=
onst char *list2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Notifies a client via management =
interface of the negotiated app</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * custom protocols</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param multi the tls_multi instance of the connection</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+notify_client_acc_protocols(struct tls_multi *multi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><=
span>index 681210d=2E=2E7923b5e 100644</span><br><span>--- a/src/openvpn/fo=
rward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ =
-42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</span><br><spa=
n> #include &quot;auth_token=2Eh&quot;</span><br><span> #include &quot;tun_=
afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #include &quot=
;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -257,11 +258,11 @@</=
span><br><span>     }</span><br><span>     else if (buf_string_match_head_s=
tr(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(buf, 8);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        server_pushed_info(=
c, buf, 8);</span><br><span>     }</span><br><span>     else if (buf_string=
_match_head_str(buf, &quot;INFO&quot;))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(buf, 4)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        server_pus=
hed_info(c, buf, 4);</span><br><span>     }</span><br><span>     else if (b=
uf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))</span><br><span>   =
  {</span><br><span>@@ -271,6 +272,10 @@</span><br><span>     {</span><br><=
span>         receive_auth_pending(c, buf);</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (buf_string_matc=
h_head_str(buf, &quot;ACC&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        receive_acc_message(c, buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span>     else if (buf_string_match_head_=
str(buf, &quot;EXIT&quot;))</span><br><span>     {</span><br><span>        =
 receive_exit_message(c);</span><br><span>diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec</span><br><span>index 1b8b2a5=2E=2Ee0b99a4 100644</=
span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn=
/init=2Ec</span><br><span>@@ -56,6 +56,7 @@</span><br><span> #include &quot=
;schedule=2Eh&quot;</span><br><span> #include &quot;options_string=2Eh&quot=
;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><s=
pan> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </s=
pan><br><span>@@ -2279,6 +2280,13 @@</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (multi &amp;&amp; multi-=
&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    buf_printf(&amp;out, &quot; custom-control %d A:6 %s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                   multi-&gt;ac=
c_max_message_length, multi-&gt;acc_negotiated_protocols);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     if (BLENZ(&amp;out) &gt; str=
len(header))</span><br><span>     {</span><br><span>         msg(D_HANDSHAK=
E, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>@@ -2522,6 +2530,11 @@<=
/span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     return flags;</span><br><span> }</spa=
n><br><span> </span><br><span>@@ -2730,6 +2743,18 @@</span><br><span>      =
   frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_mtu, c-&gt;options=2Ece=
=2Etun_mtu);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (found &amp; OPT_P_ACC &amp;&amp; =
c-&gt;options=2Epushed_acc_negotiated_protocols)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(multi-&gt=
;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        multi-&gt;acc_negotiated_protocols =3D string_alloc(c-&gt;o=
ptions=2Epushed_acc_negotiated_protocols, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        multi-&gt;acc_max_message_length =3D c=
-&gt;options=2Epushed_acc_max_message_length;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: ACC protocols: %s, msg len=
: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    multi-&gt;acc_negotiated_protocols, multi-&gt;acc_max_message_length);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        notify_clien=
t_acc_protocols(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     return true;</span><br><span> }</span><br><span> </span><br><sp=
an>@@ -3352,6 +3377,7 @@</span><br><span>     to=2Everify_hash_depth =3D op=
tions-&gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_no_ca =
=3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex509_us=
ername_field, options-&gt;x509_username_field, sizeof(to=2Ex509_username_fi=
eld));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eacc_=
protocols =3D options-&gt;acc_protocols;</span><br><span>     to=2Ees =3D c=
-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_ctx;</sp=
an><br><span> </span><br><span>@@ -4306,6 +4332,24 @@</span><br><span> }</s=
pan><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                   struct =
buffer_list *input) /* ownership transferred */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_multi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D=
 c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct tls_session *session =3D &amp;multi-&gt;session[TM_ACTIVE=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_=
message(c, multi, session, input);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_fr=
ee(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><spa=
n> void</span><br><span>@@ -4322,6 +4366,7 @@</span><br><span>         cb=
=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><span>         cb=
=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><span>         =
cb=2Esend_cc_message =3D management_callback_send_cc_message;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D manageme=
nt_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>        =
 cb=2Enetwork_change =3D management_callback_network_change;</span><br><spa=
n> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn=
/manage=2Ec</span><br><span>index ac3d4b7=2E=2E5e4e416 100644</span><br><sp=
an>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2E=
c</span><br><span>@@ -45,9 +45,11 @@</span><br><span> #include &quot;push=
=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span>=
 #include &quot;resolve=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><spa=
n> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;run_comm=
and=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE=
_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span>@@=
 -1081,6 +1083,35 @@</span><br><span>             }</span><br><span>       =
      break;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Eclient=
_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(man-&gt;pers=
ist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                                                      man=
-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                                               =
       man-&gt;connection=2Ein_extra_kid,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                                     =
                 man-&gt;connection=2Ein_extra);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_extra =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      report_command_status(status, &quot;client-acc-msg&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                man_command_unsupported(&quot=
;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IEC_ACC_M=
SG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                bool status =3D (*man-&gt;persist=2Ecallback=2E=
acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                                    =
           man-&gt;connection=2Ein_extra);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_extra =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
report_command_status(status, &quot;acc-msg&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                man_command_unsupported(&quot;acc-msg&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</=
span><br><span>         case IEC_PK_SIGN:</span><br><span>             man-=
&gt;connection=2Eext_key_state =3D EKS_READY;</span><br><span>             =
buffer_list_free(man-&gt;connection=2Eext_key_input);</span><br><span>@@ -1=
205,6 +1236,29 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_client_=
acc_msg(struct management *man, const char *cid_str,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   const char *kid_str)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;=
man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in_extra_cid)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; p=
arse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IEC_CLIENT_ACC=
_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_ext=
ra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+man_acc_msg(struct management *man)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt;connection;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra=
_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span> man_client_auth(struct management *man, const char *cid_str, const c=
har *kid_str, const bool extra)</span><br><span> {</span><br><span>     str=
uct man_connection *mc =3D &amp;man-&gt;connection;</span><br><span>@@ -175=
9,6 +1813,17 @@</span><br><span>             man_client_pending_auth(man, p=
[1], p[2], p[3], p[4]);</span><br><span>         }</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[=
0], &quot;client-acc-msg&quot;))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (man_need(p, 2, 0))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            man_client_acc_msg(man, p[1], p[2]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (streq(p[0], &quot;acc-msg&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        man_acc_msg(man);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &=
quot;rsa-sig&quot;))</span><br><span>     {</span><br><span>         man_pk=
_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2975,7 +3040,9 @@</span=
><br><span>                                        &quot;bytes_sent=3D&quot=
;,</span><br><span>                                        &quot;bytes_rece=
ived=3D&quot;,</span><br><span>                                        &quo=
t;session_id=3D&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                       &quot;session_state=3D&quot; };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                &quot;session_state=3D&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                       &quot;acc_=
protocols=3D&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                       &quot;acc_message_len=3D&quot; };</s=
pan><br><span> </span><br><span>     if (env_filter_level =3D=3D 0)</span><=
br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> void</span><br><span> management_conne=
ction_established(struct management *man, struct man_def_auth_context *mdac=
,</span><br><span>                                   const struct env_set *=
es)</span><br><span>@@ -4372,6 +4440,64 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+managem=
ent_send_acc_message(struct context *c, struct tls_multi *multi, struct tls=
_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                           struct buffer_list *input)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* also ensures that are enough inputs in the list to s=
afely call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * bu=
ffer_list_peek without extra NULL checks */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough input=
 lines for sending acc message, &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                      &quot;missing protocol, flag and/o=
r messages lines&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *pro=
to_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *protocol =3D string_alloc(CBSTR(proto_buf),=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffe=
r_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer *e=
ncoding_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *encoding =3D buf_str(encoding_buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *flag =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool b64encod=
ing =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool fragment =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while ((fla=
g =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            b64encoding =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else if (!strcmp(flag, &quot;F&quot;))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            fragment =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(input, 10000, &q=
uot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct buffer *acc_msg_buf =3D buffer_list_peek(input);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        || !tls_item_in_cipher_=
list(protocol, multi-&gt;acc_negotiated_protocols))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the list of=
 negotiated protocols: %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            np(multi-&gt;acc_negotiated_protocols));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool ret =3D send_acc_message(c, multi, session, protoco=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
               fragment, buf_cstr(acc_msg_buf),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                b64encoding);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef EN=
ABLE_MANAGEMENT */</span><br><span> </span><br><span> #include &quot;win32=
=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvp=
n/manage=2Eh</span><br><span>index 157039d=2E=2Ecc9c264 100644</span><br><s=
pan>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=
=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_cli=
ents)(void *arg);</span><br><span>     bool (*send_cc_message)(void *arg, c=
onst char *message, const char *parameter);</span><br><span>     bool (*kil=
l_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool=
 (*client_auth)(void *arg, const unsigned long cid, const unsigned int mda_=
key_id,</span><br><span>                         const bool auth, const cha=
r *reason, const char *client_reason,</span><br><span>                     =
    struct buffer_list *cc_config); /* ownership transferred */</span><br><=
span>     bool (*client_pending_auth)(void *arg, const unsigned long cid, c=
onst unsigned int kid,</span><br><span>                                 con=
st char *extra, unsigned int timeout);</span><br><span>     char *(*get_pee=
r_info)(void *arg, const unsigned long cid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                           const=
 unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           const unsigned int mda_key_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                           struct buf=
fer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    struct buffer_list *msg);</span><br><span>     b=
ool (*proxy_cmd)(void *arg, const char **p);</span><br><span>     bool (*re=
mote_cmd)(void *arg, const char **p);</span><br><span> #ifdef TARGET_ANDROI=
D</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     struct command=
_line *in;</span><br><span>     struct buffer_list *out;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF     =
  0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT=
_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_=
UNDEF          0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 *RE=
MOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_=
MSG 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_AC=
C_MSG        8</span><br><span>     int in_extra_cmd;</span><br><span>     =
struct buffer_list *in_extra;</span><br><span>     unsigned long in_extra_c=
id;</span><br><span>@@ -503,6 +512,14 @@</span><br><span> </span><br><span>=
 void man_persist_client_stats(struct management *man, struct context *c);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
* Parses the ACC message from the input buffer_list and send to the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * session identified by se=
ssion and multi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_session;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message(struct co=
ntext *c, struct tls_multi *multi,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            struct tls_session *session, str=
uct buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT=
 */</span><br><span> </span><br><span> /**</span><br><span>diff --git a/src=
/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=
=2Ea3eb3ca 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br>=
<span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dc=
o=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quo=
t;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</s=
pan><br><span> </span><br><span>@@ -4085,6 +4086,26 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+calculate_app_control_extra(struct multi_instance *mi, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct contex=
t *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC: No neg=
otiated protocols&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D =
alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(=
&amp;buf, &quot;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_message_length,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+               multi-&gt=
;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return buf_str(&amp;buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic bool</span><br><span> management_client_pending_auth(void *arg, const=
 unsigned long cid, const unsigned int mda_key_id,</span><br><span>        =
                        const char *extra, unsigned int timeout)</span><br>=
<span>@@ -4095,10 +4116,22 @@</span><br><span>     if (mi)</span><br><span>=
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
span><br><span>@@ -4106,6 +4139,7 @@</span><br><span>         bool ret =3D =
send_auth_pending_messages(multi, session, extra, timeout);</span><br><span=
>         reschedule_multi_process(&amp;mi-&gt;context);</span><br><span>  =
       multi_schedule_context_wakeup(m, mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>        =
 return ret;</span><br><span>     }</span><br><span>     return false;</spa=
n><br><span>@@ -4149,6 +4183,37 @@</span><br><span>     return ret;</span><=
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
style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_=
message(&amp;mi-&gt;context, multi, session, input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_context_wakeup(m, =
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static char *</span><br><span> management_get_peer_info(void=
 *arg, const unsigned long cid)</span><br><span> {</span><br><span>@@ -4185=
,6 +4250,7 @@</span><br><span>         cb=2En_clients =3D management_callba=
ck_n_clients;</span><br><span>         cb=2Ekill_by_cid =3D management_kill=
_by_cid;</span><br><span>         cb=2Eclient_auth =3D management_client_au=
th;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Ecli=
ent_acc_msg =3D management_client_acc_msg;</span><br><span>         cb=2Ecl=
ient_pending_auth =3D management_client_pending_auth;</span><br><span>     =
    cb=2Eget_peer_info =3D management_get_peer_info;</span><br><span>      =
   cb=2Epush_update_broadcast =3D management_callback_send_push_update_broa=
dcast;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/o=
ptions=2Ec</span><br><span>index fb319ae=2E=2Ee0cf616 100644</span><br><spa=
n>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span>=
 #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&=
quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><span>@@ -=
2552,6 +2553,8 @@</span><br><span>     o-&gt;push_option_types_found =3D 0;=
</span><br><span>     o-&gt;push_update_options_found =3D 0;</span><br><spa=
n>     o-&gt;imported_protocol_flags =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_max_message_length =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_neg=
otiated_protocols =3D NULL;</span><br><span> }</span><br><span> </span><br>=
<span> static void</span><br><span>@@ -7107,6 +7110,47 @@</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-=
&gt;force_key_material_export =3D true;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;a=
pp-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!string_class(p[=
1], CC_ALNUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control =
protocols must only contain &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          &quot;alphanumeric characters, &#3=
9;-&#39;, and &#39;_&#39;=2E&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;acc_protocols =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (streq(p[0], &quot;custom-control&quot;) &a=
mp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* check if the list from the server i=
s a real subset of our list */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct gc_arena gc_local =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer common_list =3D=
 get_list_intersection(&amp;gc_local, p[3], options-&gt;acc_protocols);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (buf_len(&amp;common_list) =3D=
=3D 0 || !streq(p[3], buf_cstr(&amp;common_list)))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control lis=
t from server contains &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                          &quot;unsupported protocols&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&am=
p;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free=
(&amp;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2=
], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;A:6&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custo=
m control encoding must be base64 and ascii&quot;);</span><br><span style=
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
an>index 42259c3=2E=2Ee8bdca1 100644</span><br><span>--- a/src/openvpn/push=
=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +2=
7,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;push=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;option=
s=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><spa=
n> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -221,9 +223,56 @@</span>=
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
, 100%, 40%);">+    notify_client_acc_protocols(multi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server_pushed_inf=
o(const struct buffer *buffer, const int adv)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+server_pushed_info(struct context *c, const struc=
t buffer *buffer, const int adv)</span><br><span> {</span><br><span>     co=
nst char *m =3D &quot;&quot;;</span><br><span>     struct buffer buf =3D *b=
uffer;</span><br><span>@@ -233,6 +282,12 @@</span><br><span>         m =3D =
BSTR(&amp;buf);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4=
) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        parse_server_p=
ushed_info_acc(c, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct gc_arena gc;<=
/span><br><span>     if (management)</span><br><span>@@ -285,6 +340,7 @@</s=
pan><br><span>     msg(D_PUSH, &quot;CR response was sent by client (&#39;%=
s&#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span> =
 * Parse the keyword for the AUTH_PENDING request</span><br><span>  * @para=
m buffer                buffer containing the keywords, the buffer&#39;s</s=
pan><br><span>@@ -441,7 +497,6 @@</span><br><span>     const char *const pe=
er_info =3D tls_multi-&gt;peer_info;</span><br><span>     unsigned int prot=
o =3D extract_iv_proto(peer_info);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Calculate the maxi=
mum timeout and subtract the time we already waited */</span><br><span>    =
 unsigned int max_timeout =3D</span><br><span>         max_uint(tls_multi-&=
gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</s=
pan><br><span>@@ -732,6 +787,12 @@</span><br><span>                 client_=
max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         =
}</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_mu=
lti-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        push_option_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6=
 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               tls_multi-&gt;acc_max_message_length, tls_multi-&gt;acc_nego=
tiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span> }</span><br><span> </span><br><span> static bool</spa=
n><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span>=
<br><span>index 39302f6=2E=2Eb6695bc 100644</span><br><span>--- a/src/openv=
pn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -=
52,6 +52,7 @@</span><br><span> </span><br><span> int process_incoming_push_=
request(struct context *c);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * @brief =
Handles the receiving of a push-update message and applies updates to the s=
pecified</span><br><span>  * options=2E</span><br><span>@@ -92,7 +93,7 @@</=
span><br><span> </span><br><span> void receive_exit_message(struct context =
*c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void server_pushed_info(const struct buffer *buffer, const int adv);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void server_pushed_info(s=
truct context *c, const struct buffer *buffer, const int adv);</span><br><s=
pan> </span><br><span> void receive_cr_response(struct context *c, const st=
ruct buffer *buffer);</span><br><span> </span><br><span>diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2E0a25=
149 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </sp=
an><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #inclu=
de &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;ssl_verify=
=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br>=
<span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -1279,6 +1280,7 =
@@</span><br><span>     free(multi-&gt;locked_cn);</span><br><span>     fre=
e(multi-&gt;locked_username);</span><br><span>     free(multi-&gt;locked_or=
iginal_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free(multi-&gt;acc_negotiated_protocols);</span><br><span> </span><br><sp=
an>     cert_hash_free(multi-&gt;locked_cert_hash_set);</span><br><span> </=
span><br><span>@@ -2098,6 +2100,11 @@</span><br><span> #endif</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (session-&gt;opt-&gt;acc_protocols)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;IV_ACC=
=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (=
session-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><br><span>         =
{</span><br><span>             struct env_set *es =3D session-&gt;opt-&gt;e=
s;</span><br><span>@@ -2398,6 +2405,8 @@</span><br><span>         multi-&gt=
;remote_ciphername =3D string_alloc(&quot;none&quot;, NULL);</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    determine_common_acc_protocols(multi, session);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (username_l=
en &lt; 0 || password_len &lt; 0)</span><br><span>     {</span><br><span>  =
       msg(D_TLS_ERRORS, &quot;TLS Error: Username (%d) or password (%d) to=
o long&quot;, abs(username_len),</span><br><span>diff --git a/src/openvpn/s=
sl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9a55ead=2E=
=2E436770b 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -457,6 +457,9 @=
@</span><br><span>     size_t ekm_size;</span><br><span> </span><br><span> =
    bool dco_enabled; /**&lt; Whether keys have to be installed in DCO or n=
ot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom control pr=
otocols we should announce as supported */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><span> };</=
span><br><span> </span><br><span> /** @addtogroup control_processor</span><=
br><span>@@ -730,6 +733,12 @@</span><br><span>     int dco_peer_id;</span><=
br><span> </span><br><span>     dco_context_t *dco;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /** the protocols that are negotiated with the peer=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *acc_nego=
tiated_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the maximum l=
ength of an ACC control channel message */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int acc_max_message_length;</span><br><span> };<=
/span><br><span> </span><br><span> /**  gets an item  of \c key_state objec=
ts in the</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2E=
am b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 43a6743=
=2E=2E6a73e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><=
br><span>@@ -107,10 +107,12 @@</span><br><span> 	@TEST_CFLAGS@</span><br><s=
pan> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</sp=
an><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	test_acc=2Ec test_acc=2Eh \</span><br>=
<span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_=
management=2Ec \</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32_exe=
cve=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/acc=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -132,6 +134,7 @@</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/ssl_mbedtls=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/ssl_verify_mbedtls=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
ssl_verify_openssl=2Ec \</span><br><span>diff --git a/tests/unit_tests/open=
vpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</spa=
n><br><span>index fff4c2b=2E=2Ef572dbb 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_test=
s/openvpn/mock_management=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><=
span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=
=2Eh&gt;</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> =
</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn=
/mock_push_dependencies=2Ec</span><br><span>index bf2ccf3=2E=2Ef083f89 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec=
</span><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t flags =3D =
OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><=
span>                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OP=
T_P_COMP | OPT_P_PERSIST</span><br><span>                      | OPT_P_MESS=
AGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_PEER_ID =
| OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_I=
D | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_ACC;<=
/span><br><span>     return flags;</span><br><span> }</span><br><span> </sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/uni=
t_tests/openvpn/test_acc=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2E9364d12</span><br><span>--- /dev/null</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1=
,353 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
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
sl(120, 100%, 40%);">+char control_channel_message_sent[2048];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Mock functions */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+send_control_channel_string_dowork(struct tls_session *session,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
              const char *str, unsigned int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_in_range(strlen(str), 0, 2047);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    strcpy(control_channel_message_sent, str);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send=
_push_reply_auth_token(struct tls_multi *multi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
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
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;W=
ARNING: Received malformed custom app control channel message (ACC not enab=
led or no negotiated protocols): 4143432c 63636b31 2c333834 2c362c46 674d42=
41 526b4241 41455641 774e616[more=2E=2E=2E]&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_bu=
f, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_mult=
i-&gt;acc_negotiated_protocols =3D &quot;no:common:protocol&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp=
;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(mock_msg_buf, &quot;WARNING: Received malformed cust=
om app control channel message (protocol &#39;cck1&#39; not in list of nego=
tiated protocols &#39;no:common:protocol&#39;): 4143432c 63636b31 2c333834 =
2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock=
_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
c2=2Etls_multi-&gt;acc_negotiated_protocols =3D &quot;cck1:flower:power:for=
tune&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rece=
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
                &quot;message (field length 62, payload length 64 mismatch)=
: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             &quot;4143432c 666f7274 756e652c 36322c36 2c496e73 67496d31 &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;6c496a6f 67496d5[more=2E=2E=2E]&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_manag=
ment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock=
_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&=
amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;=
msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(mock_msg_buf, &quot;Received custom app control message (prot=
ocol &#39;power&#39;, fragment)&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;C=
LIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* check two encoding present */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg_two_encs[] =
=3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=
=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two=
_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive=
_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 error =3D &quot;WARNING: Received malformed custom app control channel mes=
sage &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &quot;(number of encodings must be exactly one (B64=3D1, ASCII=3D1)): &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;4143432c 666c6f77 65722c34 382c3641 2c535342 68625341 41494574 &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;6c6=
36d3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* no encoding present */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg_no_en=
cs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAA=
A=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_set_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_=
encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_=
acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
error =3D &quot;WARNING: Received malformed custom app control channel mess=
age &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;(number of encodings must be exactly one (B64=3D0, ASCII=3D0)): &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;4143432c 666c6f77 65722c34 382c2c53 53426862 53414149 45746c63 &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;6d31=
706[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(mock_msg_buf, error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_bu=
f, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_parse_acc_parameters(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* parameters to INFO message */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &quo=
t;4096 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
max_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, =
&amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ma=
x_len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a client does not =
accept a length longer than it supports */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg,=
 &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* message with lower limit than our, should work for c=
lient and server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(=
info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, =
&quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(max_len, 1111);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &a=
mp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_=
len, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than =
supported=2E Server should be okay, client should fail */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B=
 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;m=
ax_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
otocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 =
A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, =
&amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capa=
bilities =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv=
_acc_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protoco=
ls, &quot;flower:happy:power&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* too small protocol length */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc=
_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol lengt=
h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_ms=
g =3D &quot;abff A:6 flower:happy&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &=
quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_acc_common_protocols(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct co=
ntext *c =3D &amp;mi=2Econtext;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &a=
mp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2E=
tls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower=
:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    c-&gt;options=2Eacc_protocols =3D &quot;power:flower:star&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *mult=
i =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    multi-&gt;opt=2Eacc_protocols =3D c-&gt;options=2Eacc_protocols=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;sess=
ion[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Ees =3D env_set_create(&amp;c-&=
gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_=
acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(multi-&gt;acc_max_me=
ssage_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(multi-&gt;acc_negotiated_protocols, &qu=
ot;power:flower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;=
acc_protocols=3Dpower:flower&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &q=
uot;acc_message_len&quot;), &quot;acc_message_len=3D1280&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_protocols);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;=
options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_acc_send_message(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=2Eco=
ntext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;opt=
ions=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_C=
LEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi=
 =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    c-&gt;options=2Eacc_protocols =3D &quot;power:flower:emergency&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;=
opt=2Eacc_protocols =3D c-&gt;options=2Eacc_protocols;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =
=3D &amp;multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    multi-&gt;opt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =
=3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common=
_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_session *session =3D &amp;=
c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;=
emergency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           &quot;EMERGENCY BROADCAST MESSAGE - THIS IS N=
OT A DRILL:&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(control_channel_message_sent,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        &quot;ACC,emergency,50,AF,E=
MERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, se=
ssion, &quot;emergency&quot;, false,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                           &quot;THE GOVERNMENT HAS ISSUED=
 A RAINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(control_cha=
nnel_message_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A=
 RAINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* te=
st a long message (&gt; 1000) with fragment to get the maximum header size =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char long_mes=
sage[1200] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; 1024; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
ong_message[i] =3D (char)(&#39; &#39; + (i % 95));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* last char of the message is a i and then a \0 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1023], =
&#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(long_message[1024], &#39;\0&#39;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &=
quot;emergency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           long_message, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size_t cc_len =3D strlen(control_channel_message_se=
nt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(control_channel_message_sent[cc_len - 1], &#39;i&#39;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *expected_start_cc=
 =3D &quot;ACC,emergency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memor=
y_equal(control_channel_message_sent, expected_start_cc, strlen(expected_st=
art_cc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negoti=
ated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_list_intersection(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *empty =3D &quot;&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pr=
otos =3D &quot;power:flower:emergency&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer t1 =3D get_list_intersection(&amp;gc, empty, protos);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(buf_len(&amp;t1), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er t2 =3D get_list_intersection(&amp;gc, protos, empty);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t2),=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t3 =3D get_list_=
intersection(&amp;gc, protos, protos);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t3), protos);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *protos2 =3D &quot;flower:=
emergency:power:mario&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer t4 =3D get_list_intersection(&amp;gc, protos2, p=
rotos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(buf_cstr(&amp;t4), &quot;flower:emergency:power&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *protos3 =3D &quot;super:paper:=
mario:flower&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer t5 =3D get_list_intersection(&amp;gc, protos2, protos3);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(buf_cstr(&amp;t5), &quot;flower:mario&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *proto4 =3D &quot;flower:flower:flower:flower&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r t6 =3D get_list_intersection(&amp;gc, proto4, &quot;flower&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(bu=
f_cstr(&amp;t6), &quot;flower&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openv=
pn/test_acc=2Eh</span><br><span>new file mode 100644</span><br><span>index =
0000000=2E=2E32421fb</span><br><span>--- /dev/null</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single UDP port, with support for SSL/TLS-based</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session au=
thentication and key exchange,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet c=
ompression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-=
2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color=
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
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_client_message=
s(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_parse_acc_pa=
rameters(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_c=
ommon_protocols(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_acc_send_message(void **state);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
test_list_intersection(void **state);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</span><br><s=
pan>index 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_common=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span> #define =
LargestIntegralType uintmax_t</span><br><span> #endif</span><br><span> /* r=
edefine 2=2Ex API in terms of 1=2Ex API */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define CMockaValueData             LargestIntegralTyp=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define check_expect=
ed_uint         check_expected</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define expect_uint_value           expect_value</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define expect_check_data           exp=
ect_check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define cast=
_ptr_to_cmocka_value(x) (x)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define CMockaValueData                       LargestIntegralType</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define check_expecte=
d_uint                   check_expected</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define expect_uint_value                     expect_va=
lue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_c=
heck_data                     expect_check</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x)           (x)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_int_in_=
range(value, min, max)  assert_in_range((value), (min), (max))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define assert_uint_in_range(val=
ue, min, max) assert_in_range((value), (min), (max))</span><br><span> #endi=
f</span><br><span> </span><br><span> /**</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</s=
pan><br><span>index 4baf8cc=2E=2E4987dd0 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</span><br><span> #inclu=
de &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /* Mock function to be allowed to includ=
e win32=2Ec which is required for</span><br><span>  * getting the temp dire=
ctory */</span><br><span> #ifdef _WIN32</span><br><span>@@ -86,6 +88,20 @@<=
/span><br><span> {</span><br><span>     return;</span><br><span> }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_process(struct context *=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Define a dummy dco cipher option to avoid linking against all the DCO=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * units */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128=
-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* generated usin=
g</span><br><span>  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_cur=
ve:secp384r1 -keyout - \</span><br><span>@@ -1111,8 +1127,12 @@</span><br><=
span>         cmocka_unit_test(ssl_test_extract_last_matching_field),</span=
><br><span>         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),=
</span><br><span>         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_i=
n_subject),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cm=
ocka_unit_test(ssl_test_extract_peer_info)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(ssl_test_extract_peer_info),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_parse=
_client_messages),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_parse_acc_parameters),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_common_=
protocols),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_acc_send_message),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_list_intersection)</span=
><br><span>     };</span><br><span> </span><br><span> #if defined(ENABLE_CR=
YPTO_OPENSSL)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896=
b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@o=
penvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--sRGEec6N5II=--


--===============4279751493717555413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4279751493717555413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4279751493717555413==--

