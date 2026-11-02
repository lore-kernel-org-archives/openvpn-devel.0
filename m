Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96281606D25C
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mllvuApq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=db+XPaSV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YhLAgSU5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YmEQcjQs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GE75Ecg+78BEqvj99dw14zTDOxuhLwhD2oIVljwQDoA=; b=mllvuApqu3/nrJpQaBDEjHJkVB
	OFAMh0pv2qKzwb6UM1smcpRv85hvTWqiHF56xsKShh6+uVljWVZEVtC+7cbdaSAeEJrg+EOfgEiuW
	Q/jePWHyOd7viU6+KDr0UUrl20g6JNMETOzsS+tJPNaDvxCOat6PDLN8TXGwabdoHVi8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNr50-000000002Sf-1Dwt;
	Mon, 02 Nov 2026 12:24:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNr4y-000000002SM-0SeF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QnY4iJP5M6D7Fmp0tJHi46tSU+akcJlgRQEnx28rJTA=; b=db+XPaSV3hRGBdjFK4ivuOOzRZ
 lTnA7R4XdWURmVl+etLTi/8qp7DTUaN5FOtFtSF0Y+jXUHLM8UoDCuyE3p2F3ucVdswhHXsuXXuWI
 ja+p3mT4W9mH9jN8o0Vmt3oqPkwZqayyG50cFW3/Fc7OkB9HNrCPT1j5mUhRK6F7WnLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QnY4iJP5M6D7Fmp0tJHi46tSU+akcJlgRQEnx28rJTA=; b=YhLAgSU5fd/vN7ZTWjJuWZDDBD
 nbE/4FCPr1sx2T6IcEXIig4dBtz4sykzlZ9+qzYGul0veGEmddIOiDAfBMbYNRYHseDMf928Dpk3X
 4r+NcBGfl5oZu/etwIWLuM/3gOaXME/F0/ieGUIvLeeczJk2RcAB1GDNRoXiW11JVIcc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNr4o-000000006ip-3F6q for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:24:00 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so24349335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793622224; x=1794227024; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QnY4iJP5M6D7Fmp0tJHi46tSU+akcJlgRQEnx28rJTA=;
 b=YmEQcjQsIl3oUB7w9vtv3OosR3P9zV+uZJyZayDXYDdWikfjeYqfNyzBbOBTUaKrtp
 EHn6RdThLzwgiCuN/ynvY59zoQ3ytx4vAWLdMSu2BVG/PfOrKbX1191u1V+Zu8ffpp8+
 /fMx7s5CEavtHido9c6H6weBsVRPmY1n28pHj0M8O98U89bKNX2tDWJXNbmXJHFDGsJF
 8Iao60FcpMNUfZfQxDkHulFjZNlEGTvs4IRmuBBaoiU2gTWBipCGn8IC2AngtPOwVitO
 0mG3Gk2gI1DSU2LmjKVSOEysTisTaqjT4DcgpPlm9TMT/sYQ4/nDd3a/9NEfRp+850IJ
 o35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793622224; x=1794227024;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QnY4iJP5M6D7Fmp0tJHi46tSU+akcJlgRQEnx28rJTA=;
 b=ai07GyEBnPu92FzxEgPXZd52a4TZQRBWOw85RlCVTzh6fXeyJdKuMyXBUi24KiyZ7X
 k3WxtxG4amcjbY/gojKkg+kEMlXtXNGamzvLYlamUl7a9E1CTQSjwOQDqudPEkSl79qv
 0G/CyNqEroaoYrC0tRbuUyXTw2pCeiLZz1aVSoIr9mx1sukG8fSS8kIxzT8cMKpc+4IC
 VfszapkpkE8wD8ajNB/vLtgRASqNtrD6MStTms5FFDfMFDQvCattlV/If59VTnqG/A03
 0/0u3Arn3vKJKAafw/PCPK1IKl/M70QuDYWBNDf0BuAlp/Qz+/PluVxaa3XAA6attugB
 RRaQ==
X-Gm-Message-State: AFq9FYJ5aZKXkrQ59RBt3G3O7vhYZYMTgJ/0dH5rwpqlIkN8EAaqeubh
 sND3/OHEHuiwxNQCFfszyzLW39NMh+mJLe1Wx0WeiCOQQbiuMg7qA8PbTSNlJl8FHKRMC8QUn3N
 00aSibiRbsf93+dFGi25zqIBHqgmkoOVrAPg6KjwchT4vp1uPY6L7dXDmGNP/xH51CzpGqWVF0B
 nw/64yKw==
X-Gm-Gg: AYBFou3LleD6NeMvucLD/bHUq6x5SMj6BdJB8xzejDzj0YyTAGXm29wkbVhCAmf1m/X
 4HWuUStWGvYFK69y7tjLSL8IKxL+5qJqk2P6Wp3LvhGQABVEMUeMx5GoR2nYgArZ1Pp6hRtP4Ja
 NYhZi3+c+p/j9cwZJKVMg261cfdgiMeGYNyc47uWBAHuUil2CxQthNS2EbQdgOiPAPmnl/4xp5p
 n0oABmllgA4GSUxjxQwCfMHZkS8rspuR+DnvfNEwsTOco+EaSsR9nvu7PcL0VJ8BeRVKkI12oJF
 jMzdWOA8GFdGyUqYj3EthPCTV9b73qBbLYYDq118mc3inq0jNHe0KoRlJZWhyY8Zd6tlrgCud+G
 C0oKJCAQ1qaZMNEVgayGCQ73svYd6Mszm5xpZN+M2A0Nn3XybEPMoHT1lHGT7rlQX9DCeIGJjGs
 8U+PkkDzm2oMUiPFprDJbYrBqyMd4T/CRKPdK8wEOm0uaJv8/h2NoHOAzpf0geLPP8JzhR8bHJf
 36+SX0OwF1SwVj3flDzPRo6PQmidisWtt0kSwRL6PArFY37fQ/vrYxuzurUQYkkLWXbGm+88poU
 IeOKJGaAmBSYLzfJZeqY3ER/JhCzJwJLpdPNZSxSHdbo8p2pio5A0z5qu+FdWlr6fwmgyVzdfzg
 q+2H7oDKHlHToRT8Ufe/thM4EvgtQkrh09995NyazsNGLPTWvKLDp+AuH8kESFceSWMOiVUQ166
 xQn6kY7zu8nFMJKQ==
X-Received: by 2002:a05:600d:e:b0:4ad:181a:4350 with SMTP id
 5b1f17b1804b1-4ad181a44a0mr144867835e9.21.1793622223238; 
 Mon, 02 Nov 2026 04:23:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78c10sm19343410f8f.25.2026.11.02.04.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:23:42 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:23:39 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 68fd83945956945d64655703fdb33041757f812d
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4eae42e69491fc2f6a91e187af7f186ab9c40a21-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNr4o-000000006ip-3F6q
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2385081209887385750=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2385081209887385750==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qrYF5cLqXiI="; charset=UTF-8

--qrYF5cLqXiI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Hello Frank Lic=
htenheld, 

I'd like you to reexamine a change=2E Please visit

    https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail

to look at the new pa=
tch set (#2)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by Frank Lichtenheld


Change subject: Remove support for --secr=
et
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove sup=
port for --secret

This has been announced for a long time and good alterna=
tives exist=2E

Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M Changes=2Emd
M INSTALL
M d=
oc/man-sections/protocol-options=2Erst
M doc/man-sections/unsupported-optio=
ns=2Erst
M src/openvpn/check_file_access=2Ec
M src/openvpn/crypto=2Ec
M src=
/openvpn/crypto=2Eh
M src/openvpn/helper=2Ec
M src/openvpn/init=2Ec
M src/o=
penvpn/mtu=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/op=
envpn/options_show=2Ec
M src/openvpn/options_string=2Ec
M src/openvpn/ssl=
=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M tests/unit_tests/openvpn/=
test_pkt=2Ec
17 files changed, 244 insertions(+), 497 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/2081/2

dif=
f --git a/Changes=2Emd b/Changes=2Emd
index b5ae881=2E=2Edd12391 100644
---=
 a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,13 @@
   the characters men=
tioned above were already escaped=2E However, the behavior of
   Mbed TLS i=
s slightly different from OpenSSL in that it also escapes "=3D"=2E
 
+* **`=
secret` has been removed**
+
+  Static key mode (non-TLS) is no longer cons=
idered "good and secure enough" for
+  today's requirements=2E Use TLS mode=
 instead=2E If deploying a PKI CA is considered
+  "too complicated", using=
 `--peer-fingerprint` makes TLS mode about as easy as
+  using `--secret`=
=2E
+ 
 ## Maintainer-visible changes
 
 - The configure-time option `--ena=
ble-debug` is no longer  available
diff --git a/INSTALL b/INSTALL
index 486=
b1ae=2E=2Ed0ffaf0 100644
--- a/INSTALL
+++ b/INSTALL
@@ -144,8 +144,7 @@
 
=
 Test Crypto:
 
-=2E/openvpn --genkey secret key
-=2E/openvpn --test-crypto=
 --secret key
+=2E/openvpn --test-crypto
 
 Test SSL/TLS negotiations (runs=
 for 2 minutes):
 
diff --git a/doc/man-sections/protocol-options=2Erst b/d=
oc/man-sections/protocol-options=2Erst
index 52ce5a8=2E=2Eb785ebe 100644
--=
- a/doc/man-sections/protocol-options=2Erst
+++ b/doc/man-sections/protocol=
-options=2Erst
@@ -212,11 +212,6 @@
   have been configured with ``--enable=
-small``
   (typically used on routers or other embedded devices)=2E
 
-
--=
-allow-deprecated-insecure-static-crypto
-   **DEPRECATED** This allow usin=
g OpenVPN without TLS=2E This is deprecated
-   and will be removed in Open=
VPN 2=2E8=2E
-
 --tran-window n
   Transition window -- our old key can liv=
e this many seconds after a new
   a key renegotiation begins (default :cod=
e:`3600` seconds)=2E This feature
diff --git a/doc/man-sections/unsupported=
-options=2Erst b/doc/man-sections/unsupported-options=2Erst
index c273905=
=2E=2E0bb5e4b 100644
--- a/doc/man-sections/unsupported-options=2Erst
+++ b=
/doc/man-sections/unsupported-options=2Erst
@@ -70,3 +70,9 @@
   Removed in=
 OpenVPN 2=2E8=2E This option caused the Mbed TLS 3 random number
   genera=
tor to be reseeded on every call=2E It has been removed because this
   is =
excessive=2E
+
+--secret
+  Removed in OpenVPN 2=2E8=2E Static encryption w=
ithout a transient key
+  (generated by DH or ECDH) has been considered pro=
blematic for many
+  years=2E Please use ``--peer-fingerprint`` and self-si=
gned certificates
+  for small setups=2E
diff --git a/src/openvpn/check_fil=
e_access=2Ec b/src/openvpn/check_file_access=2Ec
index 83654b2=2E=2E90dbb4e=
 100644
--- a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn/check_fil=
e_access=2Ec
@@ -312,10 +312,6 @@
                                         =
 ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-    errs |=3D
- =
       check_file_access_inline(options->shared_secret_file_inline, CHKACC_=
FILE | CHKACC_PRIVATE,
-                                 options->shared_se=
cret_file, R_OK, "--secret");
-
     errs |=3D check_file_access(CHKACC_DIR=
PATH | CHKACC_FILEXSTWR, options->packet_id_file,
                         =
      R_OK | W_OK, "--replay-persist");
 
diff --git a/src/openvpn/crypto=
=2Ec b/src/openvpn/crypto=2Ec
index 386b164=2E=2E382bfd8 100644
--- a/src/o=
penvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -872,7 +872,7 @@
  * Buil=
d a struct key_type=2E
  */
 void
-init_key_type(struct key_type *kt, const=
 char *ciphername, const char *authname, bool tls_mode,
+init_key_type(stru=
ct key_type *kt, const char *ciphername, const char *authname,
            =
   bool warn)
 {
     bool aead_cipher =3D false;
@@ -891,9 +891,9 @@
 
   =
      /* check legal cipher mode */
         aead_cipher =3D cipher_kt_mode=
_aead(kt->cipher);
-        if (!(cipher_kt_mode_cbc(kt->cipher) || (tls_mo=
de && aead_cipher)
+        if (!(cipher_kt_mode_cbc(kt->cipher) || aead_ci=
pher
 #ifdef ENABLE_OFB_CFB_MODE
-              || (tls_mode && cipher_kt_m=
ode_ofb_cfb(kt->cipher))
+              || cipher_kt_mode_ofb_cfb(kt->ciphe=
r)
 #endif
                   ))
         {
@@ -1716,7 +1716,7 @@
     prin=
tf("%s  (%u bit key, ", cipher_kt_name(ciphername), cipher_kt_key_size(ciph=
ername) * 8);
 
     if (cipher_kt_block_size(ciphername) =3D=3D 1)
-    {
=
+   {
         printf("stream cipher");
     }
     else
diff --git a/src/o=
penvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index dbe0802=2E=2E203f77b 10064=
4
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -420,11 +420=
,9 @@
  * @param kt          The struct key_type to initialize
  * @param c=
iphername  The name of the cipher to use
  * @param authname    The name of=
 the HMAC digest to use
- * @param tls_mode    Specifies whether we are run=
ning in TLS mode, which allows
- *                    more ciphers than sta=
tic key mode=2E
  * @param warn        Print warnings when null cipher / au=
th is used=2E
  */
-void init_key_type(struct key_type *kt, const char *cip=
hername, const char *authname, bool tls_mode,
+void init_key_type(struct ke=
y_type *kt, const char *ciphername, const char *authname,
                 =
   bool warn);
 
 /*
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/help=
er=2Ec
index d29895b=2E=2E6b5fcee6 100644
--- a/src/openvpn/helper=2Ec
+++ =
b/src/openvpn/helper=2Ec
@@ -266,12 +266,6 @@
             msg(M_USAGE, "--=
server and --server-bridge cannot be used together");
         }
 
-       =
 if (o->shared_secret_file)
-        {
-            msg(M_USAGE,
-         =
       "--server and --secret cannot be used together (you must use SSL/TLS=
 keys)");
-        }
-
         if (!(o->server_flags & SF_NOPOOL) && o->if=
config_pool_defined)
         {
             msg(M_USAGE,
@@ -461,12 +455,6=
 @@
                 "--server-bridge already defines an ifconfig-pool, so =
you can't also specify --ifconfig-pool explicitly");
         }
 
-        =
if (o->shared_secret_file)
-        {
-            msg(M_USAGE,
-          =
      "--server-bridge and --secret cannot be used together (you must use S=
SL/TLS keys)");
-        }
-
         if (dev !=3D DEV_TYPE_TAP)
         {=

             msg(M_USAGE, "--server-bridge directive only makes sense with=
 --dev tap");
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
inde=
x 24cf532=2E=2E9299c4f 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/=
init=2Ec
@@ -996,35 +996,10 @@
         platform_mlockall(true);
     }
 
-=
    /*
-     * We do not want user to use --genkey with --secret=2E In the =
transistion
-     * phase we for secret=2E
-     */
-    if (options->genke=
y && options->genkey_type !=3D GENKEY_SECRET && options->shared_secret_file=
)
-    {
-        msg(M_USAGE, "Using --genkey type with --secret filename =
is "
-                     "not supported=2E  Use --genkey type filename in=
stead=2E");
-    }
     if (options->genkey && options->genkey_type =3D=3D =
GENKEY_SECRET)
     {
         int nbits_written;
         const char *genk=
ey_filename =3D options->genkey_filename;
-        if (options->shared_secr=
et_file && options->genkey_filename)
-        {
-            msg(M_USAGE, "=
You must provide a filename to either --genkey "
-                         =
"or --secret, not both");
-        }
-
-        /*
-         * Copy filenam=
e from shared_secret_file to genkey_filename to support
-         * the old=
 --genkey --secret foo=2Efile syntax=2E
-         */
-        if (options->=
shared_secret_file)
-        {
-            msg(M_WARN, "WARNING: Using --g=
enkey --secret filename is "
-                        "DEPRECATED=2E  Use -=
-genkey secret filename instead=2E");
-            genkey_filename =3D opti=
ons->shared_secret_file;
-        }
 
         nbits_written =3D write_key_=
file(2, genkey_filename);
         if (nbits_written < 0)
@@ -1033,7 +1008,=
7 @@
         }
 
         msg(D_GENKEY | M_NOPREFIX, "Randomly generated %=
d bit key written to %s", nbits_written,
-            options->shared_secre=
t_file);
+            options->genkey_filename ? options->genkey_filename :=
 "stdout");
         return true;
     }
     else if (options->genkey && o=
ptions->genkey_type =3D=3D GENKEY_TLS_CRYPTV2_SERVER)
@@ -1079,7 +1054,7 @@=

     /* sanity check on options for --mktun or --rmtun */
     notnull(opt=
ions->dev, "TUN/TAP device (--dev)");
     if (options->ce=2Eremote || opti=
ons->ifconfig_local || options->ifconfig_remote_netmask
-        || options=
->shared_secret_file || options->tls_server || options->tls_client)
+      =
  || options->tls_server || options->tls_client)
     {
         msg(M_FATA=
L | M_OPTERR,
             "options --mktun or --rmtun should only be used =
together with --dev");
@@ -3011,8 +2986,7 @@
     ASSERT(!key_ctx_bi_define=
d(&c->c1=2Eks=2Estatic_key));
 
     /* Init cipher and hash algorithm */
-=
    init_key_type(&c->c1=2Eks=2Ekey_type, options->ciphername, options->aut=
hname,
-                  options->test_crypto, true);
+    init_key_type(&=
c->c1=2Eks=2Ekey_type, options->ciphername, options->authname, true);
 
   =
  generate_test_crypto_random_key(&c->c1=2Eks=2Ekey_type, &c->c1=2Eks=2Esta=
tic_key,
                                     "test crypto key");
@@ -3022,=
50 +2996,6 @@
 }
 
 /*
- * Static Key Mode (using a pre-shared key)
- */
-s=
tatic void
-do_init_crypto_static(struct context *c, const unsigned int fla=
gs)
-{
-    const struct options *options =3D &c->options;
-    ASSERT(opti=
ons->shared_secret_file);
-
-    init_crypto_pre(c, flags);
-
-    /* Initi=
alize flags */
-    if (c->options=2Emute_replay_warnings)
-    {
-        =
c->c2=2Ecrypto_options=2Eflags |=3D CO_MUTE_REPLAY_WARNINGS;
-    }
-
-    =
/* Initialize packet ID tracking */
-    packet_id_init(&c->c2=2Ecrypto_opt=
ions=2Epacket_id, options->replay_window, options->replay_time,
-          =
         "STATIC", 0);
-    c->c2=2Ecrypto_options=2Epid_persist =3D &c->c1=
=2Epid_persist;
-    c->c2=2Ecrypto_options=2Eflags |=3D CO_PACKET_ID_LONG_=
FORM;
-    packet_id_persist_load_obj(&c->c1=2Epid_persist, &c->c2=2Ecrypto=
_options=2Epacket_id);
-
-    if (!key_ctx_bi_defined(&c->c1=2Eks=2Estatic_=
key))
-    {
-        /* Get cipher & hash algorithms */
-        init_key_=
type(&c->c1=2Eks=2Ekey_type, options->ciphername, options->authname,
-     =
                 options->test_crypto, true);
-
-        /* Read cipher and=
 hmac keys from shared secret file */
-        crypto_read_openvpn_key(&c->=
c1=2Eks=2Ekey_type, &c->c1=2Eks=2Estatic_key,
-                            =
    options->shared_secret_file, options->shared_secret_file_inline,
-     =
                           options->key_direction, "Static Key Encryption",=
 "secret", NULL);
-    }
-    else
-    {
-        msg(M_INFO, "Re-using pr=
e-shared static key");
-    }
-
-    /* Get key schedule */
-    c->c2=2Ecr=
ypto_options=2Ekey_ctx_bi =3D c->c1=2Eks=2Estatic_key;
-}
-
-/*
  * Initial=
ize the tls-auth/crypt key context
  */
 static void
@@ -3204,7 +3134,7 @@
=
 
         /* Do not warn if the cipher is used only in OCC */
         boo=
l warn =3D options->enable_ncp_fallback;
-        init_key_type(&c->c1=2Eks=
=2Ekey_type, ciphername, options->authname, true, warn);
+        init_key_=
type(&c->c1=2Eks=2Ekey_type, ciphername, options->authname, warn);
 
      =
   /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_wrap_k=
ey(c);
@@ -3492,41 +3422,6 @@
     }
 }
 
-/*
- * No encryption or authenti=
cation=2E
- */
-static void
-do_init_crypto_none(struct context *c)
-{
-   =
 ASSERT(!c->options=2Etest_crypto);
-
-    /* Initialise key_type with auth=
/cipher "none", so the key_type struct is
-     * valid */
-    init_key_ty=
pe(&c->c1=2Eks=2Ekey_type, "none", "none", c->options=2Etest_crypto, true);=

-
-    msg(M_WARN, "******* WARNING *******: All encryption and authentica=
tion features "
-                "disabled -- All data will be tunnelled as=
 clear text and will not be "
-                "protected against man-in-th=
e-middle changes=2E "
-                "PLEASE DO RECONSIDER THIS CONFIGURA=
TION!");
-}
-
-static void
-do_init_crypto(struct context *c, const unsigne=
d int flags)
-{
-    if (c->options=2Eshared_secret_file)
-    {
-        d=
o_init_crypto_static(c, flags);
-    }
-    else if (c->options=2Etls_serve=
r || c->options=2Etls_client)
-    {
-        do_init_crypto_tls(c, flags);=

-    }
-    else /* no encryption or authentication=2E */
-    {
-        =
do_init_crypto_none(c);
-    }
-}
-
 static void
 do_init_frame(struct cont=
ext *c)
 {
@@ -4564,7 +4459,7 @@
         {
             crypto_flags =3D C=
F_INIT_TLS_MULTI;
         }
-        do_init_crypto(c, crypto_flags);
+   =
     do_init_crypto_tls(c, crypto_flags);
         if (IS_SIG(c) && !child)=

         {
             goto sig;
diff --git a/src/openvpn/mtu=2Ec b/src/o=
penvpn/mtu=2Ec
index f3c2874=2E=2E5ce40c8 100644
--- a/src/openvpn/mtu=2Ec
=
+++ b/src/openvpn/mtu=2Ec
@@ -51,7 +51,6 @@
 unsigned int
 calc_packet_id_s=
ize_dc(const struct options *options, const struct key_type *kt)
 {
-    bo=
ol tlsmode =3D options->tls_server || options->tls_client;
     bool epoch =
=3D options->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT;
 
     /* =
epoch format uses a 64-bit packet id: 16 bit epoch + 48 bit per-epoch count=
er */
@@ -60,7 +59,7 @@
         return sizeof(uint64_t);
     }
 
-    boo=
l packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
+=
    bool packet_id_long_form =3D cipher_kt_mode_ofb_cfb(kt->cipher);
 
    =
 return packet_id_size(packet_id_long_form);
 }
@@ -72,8 +71,6 @@
     /* S=
um of all the overhead that reduces the usable packet size */
     size_t h=
eader_size =3D 0;
 
-    bool tlsmode =3D options->tls_server || options->t=
ls_client;
-
     /* A socks proxy adds extra header to each packet
      *=
 (we only support Socks with IPv4, this value is different for IPv6) */
   =
  if (options->ce=2Esocks_proxy_server && proto_is_udp(options->ce=2Eproto)=
)
@@ -88,10 +85,7 @@
     }
 
     /* Add the opcode and peerid */
-    if =
(tlsmode)
-    {
-        header_size +=3D options->use_peer_id ? 4 : 1;
- =
   }
+    header_size +=3D options->use_peer_id ? 4 : 1;
 
     unsigned in=
t pkt_id_size =3D calc_packet_id_size_dc(options, kt);
 
@@ -156,13 +150,6 =
@@
 {
     struct key_type occ_kt;
 
-    /* neither --secret nor TLS mode =
*/
-    if (!o->tls_client && !o->tls_server && !o->shared_secret_file)
-  =
  {
-        init_key_type(&occ_kt, "none", "none", false, false);
-       =
 return frame_calculate_payload_size(frame, o, &occ_kt);
-    }
-
     /* o=
->ciphername might be BF-CBC even though the underlying SSL library
      *=
 does not support it=2E For this reason we workaround this corner case
    =
  * by pretending to have no encryption enabled and by manually adding
@@ -=
184,9 +171,7 @@
         ciphername =3D "none";
     }
 
-    /* We pass tl=
smode always true here since as we do not need to check if
-     * the ciph=
ers are actually valid for non tls in occ calucation */
-    init_key_type(=
&occ_kt, ciphername, o->authname, true, false);
+    init_key_type(&occ_kt,=
 ciphername, o->authname, false);
 
     size_t payload =3D frame_calculate=
_payload_size(frame, o, &occ_kt);
     overhead +=3D frame_calculate_protoc=
ol_header_size(&occ_kt, o, true);
diff --git a/src/openvpn/options=2Ec b/sr=
c/openvpn/options=2Ec
index 8e0c602=2E=2E386f412 100644
--- a/src/openvpn/o=
ptions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1587,6 +1587,10 @@
 static voi=
d
 options_postprocess_verify_ce(const struct options *options, const struc=
t connection_entry *ce)
 {
+    if (options->test_crypto)
+    {
+        r=
eturn;
+    }
     struct options defaults;
     int dev =3D DEV_TYPE_UNDEF=
;
     bool pull =3D false;
@@ -2012,27 +2016,9 @@
     /*
      * SSL/TLS =
mode sanity checks=2E
      */
-    if (options->tls_server + options->tls_=
client + (options->shared_secret_file !=3D NULL) > 1)
+    if (options->tls=
_server + options->tls_client + options->test_crypto !=3D 1)
     {
-      =
  msg(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret=
");
-    }
-
-    if (!options->tls_server && !options->tls_client && !opti=
ons->test_crypto)
-    {
-        msglvl_t msglevel =3D M_USAGE;
-        i=
f (options->allow_deprecated_insecure_static_crypto)
-        {
-          =
  msglevel =3D M_INFO;
-        }
-
-        msg(msglevel, "DEPRECATION: No=
 tls-client or tls-server option in "
-                      "configuration=
 detected=2E OpenVPN 2=2E8 will remove the "
-                      "functi=
onality to run a VPN without TLS=2E "
-                      "See the examp=
les section in the manual page for "
-                      "examples of a =
similar quick setup with peer-fingerprint=2E "
-                      "Open=
VPN 2=2E7 allows using this configuration when using "
-                   =
   "--allow-deprecated-insecure-static-crypto but you should move "
-      =
                "to a proper configuration using TLS as soon as possible=2E=
");
+        msg(M_USAGE, "OpenVPN configuration must use either --tls-serv=
er or --tls-client");
     }
 
     if (options->ssl_flags & (SSLF_CLIENT_C=
ERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
@@ -2052,188 +2038,136 @@
  =
       msg(M_USAGE, "--tls-version-min bigger than --tls-version-max");
   =
  }
 
-    if (options->tls_server || options->tls_client)
-    {
-        =
check_ca_required(options);
+
+    check_ca_required(options);
 #ifdef ENAB=
LE_PKCS11
-        if (!options->pkcs11_providers[0] && options->pkcs11_id)=

-        {
-            msg(M_WARN, "Option pkcs11-id is ignored as no pkc=
s11-providers are specified");
-        }
-        else if (!options->pkcs1=
1_providers[0] && options->pkcs11_id_management)
-        {
-            ms=
g(M_WARN,
-                "Option pkcs11-id-management is ignored as no pk=
cs11-providers are specified");
-        }
+    if (!options->pkcs11_provid=
ers[0] && options->pkcs11_id)
+    {
+        msg(M_WARN, "Option pkcs11-id=
 is ignored as no pkcs11-providers are specified");
+    }
+    else if (!o=
ptions->pkcs11_providers[0] && options->pkcs11_id_management)
+    {
+     =
   msg(M_WARN,
+            "Option pkcs11-id-management is ignored as no p=
kcs11-providers are specified");
+    }
 
-        if (options->pkcs11_prov=
iders[0])
-        {
-            if (options->pkcs11_id_management && opti=
ons->pkcs11_id !=3D NULL)
-            {
-                msg(M_USAGE,
-   =
                 "Parameter --pkcs11-id cannot be used when --pkcs11-id-man=
agement is also specified=2E");
-            }
-            if (!options->p=
kcs11_id_management && options->pkcs11_id =3D=3D NULL)
-            {
-    =
            msg(M_USAGE,
-                    "Parameter --pkcs11-id or --p=
kcs11-id-management should be specified=2E");
-            }
-            c=
onst char use_err[] =3D
-                "Parameter --%s cannot be used whe=
n --pkcs11-provider is also specified=2E";
-            MUST_BE_UNDEF(cert_=
file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "key");
-         =
   MUST_BE_UNDEF(pkcs12_file, "pkcs12");
-            MUST_BE_FALSE(options=
->management_flags & MF_EXTERNAL_KEY, "management-external-key");
-        =
    MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management=
-external-cert");
-#ifdef ENABLE_CRYPTOAPI
-            MUST_BE_UNDEF(crypt=
oapi_cert, "cryptoapicert");
-#endif
-        }
-        else
-#endif /* if=
def ENABLE_PKCS11 */
-#ifdef ENABLE_CRYPTOAPI
-            if (options->cry=
ptoapi_cert)
-        {
-            const char use_err[] =3D
-            =
    "Parameter --%s cannot be used when --cryptoapicert is also specified=
=2E";
-            MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_U=
NDEF(priv_key_file, "key");
-            MUST_BE_UNDEF(pkcs12_file, "pkcs12=
");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY,=
 "management-external-key");
-            MUST_BE_FALSE(options->management=
_flags & MF_EXTERNAL_CERT, "management-external-cert");
-        }
-       =
 else
-#endif
-            if (options->pkcs12_file)
-        {
-#ifdef ENA=
BLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter --pkcs12 cannot be =
used with the mbed TLS version of OpenVPN=2E");
-#else
-            const c=
har use_err[] =3D "Parameter --%s cannot be used when --pkcs12 is also spec=
ified=2E";
-            MUST_BE_UNDEF(ca_path, "capath");
-            MUST=
_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "ke=
y");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY=
, "management-external-key");
-            MUST_BE_FALSE(options->managemen=
t_flags & MF_EXTERNAL_CERT, "management-external-cert");
-#endif       /* i=
fdef ENABLE_CRYPTO_MBEDTLS */
-        }
-        else /* cert/key from non=
e of pkcs11, pkcs12, cryptoapi */
-        {
-            if ((options->man=
agement_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
-            {
=
-                msg(M_USAGE, "--key and --management-external-key are mutu=
ally exclusive");
-            }
-            if ((options->management_flag=
s & MF_EXTERNAL_CERT))
-            {
-                if (options->cert_fi=
le)
-                {
-                    msg(M_USAGE, "--cert and --mana=
gement-external-cert are mutually exclusive");
-                }
-        =
        else if (!(options->management_flags & MF_EXTERNAL_KEY))
-         =
       {
-                    msg(M_USAGE,
-                        "--mana=
gement-external-cert must be used with --management-external-key");
-      =
          }
-            }
-            if (pull)
-            {
-         =
       const int sum =3D
-                    ((options->cert_file !=3D NUL=
L) || (options->management_flags & MF_EXTERNAL_CERT))
-                    =
+ ((options->priv_key_file !=3D NULL)
-                       || (options->=
management_flags & MF_EXTERNAL_KEY));
-
-                if (sum =3D=3D 0)
=
-                {
-                    if (!options->auth_user_pass_file)
=
-                    {
-                        msg(M_USAGE, "No client-sid=
e authentication method is "
-                                     "specifi=
ed=2E  You must use either "
-                                     "--cert/=
--key, --pkcs12, or "
-                                     "--auth-user-pa=
ss");
-                    }
-                }
-                else if (s=
um !=3D 2)
-                {
-                    msg(M_USAGE, "If you use=
 one of --cert or --key, you must use them both");
-                }
-    =
        }
-            else
-            {
-                if (!(options->=
management_flags & MF_EXTERNAL_CERT))
-                {
-                 =
   notnull(options->cert_file,
-                            "certificate fi=
le (--cert) or PKCS#12 file (--pkcs12)");
-                }
-             =
   if (!(options->management_flags & MF_EXTERNAL_KEY))
-                {
-=
                    notnull(options->priv_key_file,
-                      =
      "private key file (--key) or PKCS#12 file (--pkcs12)");
-            =
    }
-            }
-        }
-        if (ce->tls_auth_file && ce->tls_c=
rypt_file)
-        {
-            msg(M_USAGE, "--tls-auth and --tls-crypt=
 are mutually exclusive");
-        }
-        if (options->tls_client && c=
e->tls_crypt_v2_file
-            && (ce->tls_auth_file || ce->tls_crypt_fi=
le))
+    if (options->pkcs11_providers[0])
+    {
+        if (options->pk=
cs11_id_management && options->pkcs11_id !=3D NULL)
         {
            =
 msg(M_USAGE,
-                "--tls-crypt-v2, --tls-auth and --tls-crypt =
are mutually exclusive in client mode");
+                "Parameter --pkcs=
11-id cannot be used when --pkcs11-id-management is also specified=2E");
  =
       }
-    }
-    else
-    {
-        /*
-         * Make sure user doe=
sn't specify any TLS options
-         * when in non-TLS mode=2E
-         =
*/
-
-        const char use_err[] =3D "Parameter %s can only be specified =
in TLS-mode, "
-                               "i=2Ee=2E where --tls-server=
 or --tls-client is also specified=2E";
-
-        MUST_BE_UNDEF(ca_file, "=
ca");
-        MUST_BE_UNDEF(ca_path, "capath");
-        MUST_BE_UNDEF(dh_=
file, "dh");
+        if (!options->pkcs11_id_management && options->pkcs11=
_id =3D=3D NULL)
+        {
+            msg(M_USAGE,
+                "Par=
ameter --pkcs11-id or --pkcs11-id-management should be specified=2E");
+   =
     }
+        const char use_err[] =3D
+            "Parameter --%s canno=
t be used when --pkcs11-provider is also specified=2E";
         MUST_BE_UN=
DEF(cert_file, "cert");
         MUST_BE_UNDEF(priv_key_file, "key");
-#ifn=
def ENABLE_CRYPTO_MBEDTLS
         MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+ =
       MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "manageme=
nt-external-key");
+        MUST_BE_FALSE(options->management_flags & MF_EX=
TERNAL_CERT, "management-external-cert");
+#ifdef ENABLE_CRYPTOAPI
+       =
 MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
 #endif
-        MUST_BE_U=
NDEF(cipher_list, "tls-cipher");
-        MUST_BE_UNDEF(cipher_list_tls13, =
"tls-ciphersuites");
-        MUST_BE_UNDEF(tls_cert_profile, "tls-cert-pro=
file");
-        MUST_BE_UNDEF(tls_verify, "tls-verify");
-        MUST_BE_=
UNDEF(tls_export_peer_cert_dir, "tls-export-cert");
-        MUST_BE_UNDEF(=
verify_x509_name, "verify-x509-name");
-        MUST_BE_UNDEF(tls_timeout, =
"tls-timeout");
-        MUST_BE_UNDEF(renegotiate_bytes, "reneg-bytes");
-=
        MUST_BE_UNDEF(renegotiate_packets, "reneg-pkts");
-        MUST_BE_=
UNDEF(renegotiate_seconds, "reneg-sec");
-        MUST_BE_UNDEF(handshake_w=
indow, "hand-window");
-        MUST_BE_UNDEF(transition_window, "tran-wind=
ow");
-        MUST_BE_UNDEF(tls_auth_file, "tls-auth");
-        MUST_BE_U=
NDEF(tls_crypt_file, "tls-crypt");
-        MUST_BE_UNDEF(tls_crypt_v2_file=
, "tls-crypt-v2");
-        MUST_BE_UNDEF(single_session, "single-session")=
;
-        MUST_BE_UNDEF(push_peer_info, "push-peer-info");
-        MUST_B=
E_UNDEF(tls_exit, "tls-exit");
-        MUST_BE_UNDEF(crl_file, "crl-verify=
");
-        MUST_BE_UNDEF(ns_cert_type, "ns-cert-type");
-        MUST_BE_=
UNDEF(remote_cert_ku[0], "remote-cert-ku");
-        MUST_BE_UNDEF(remote_c=
ert_eku, "remote-cert-eku");
-#ifdef ENABLE_PKCS11
-        MUST_BE_UNDEF(p=
kcs11_providers[0], "pkcs11-providers");
-        MUST_BE_UNDEF(pkcs11_priv=
ate_mode[0], "pkcs11-private-mode");
-        MUST_BE_UNDEF(pkcs11_id, "pkc=
s11-id");
-        MUST_BE_UNDEF(pkcs11_id_management, "pkcs11-id-managemen=
t");
+    }
+    else
+#endif /* ifdef ENABLE_PKCS11 */
+#ifdef ENABLE_CRYP=
TOAPI
+        if (options->cryptoapi_cert)
+    {
+        const char use_=
err[] =3D
+            "Parameter --%s cannot be used when --cryptoapicert =
is also specified=2E";
+        MUST_BE_UNDEF(cert_file, "cert");
+        =
MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_UNDEF(pkcs12_file, "p=
kcs12");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY=
, "management-external-key");
+        MUST_BE_FALSE(options->management_fl=
ags & MF_EXTERNAL_CERT, "management-external-cert");
+    }
+    else
 #end=
if
-
+        if (options->pkcs12_file)
+    {
+#ifdef ENABLE_CRYPTO_MBEDTL=
S
+        msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TL=
S version of OpenVPN=2E");
+#else
+        const char use_err[] =3D "Parame=
ter --%s cannot be used when --pkcs12 is also specified=2E";
+        MUST_=
BE_UNDEF(ca_path, "capath");
+        MUST_BE_UNDEF(cert_file, "cert");
+  =
      MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_FALSE(options->=
management_flags & MF_EXTERNAL_KEY, "management-external-key");
+        MU=
ST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-exter=
nal-cert");
+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */
+    }
+    else /*=
 cert/key from none of pkcs11, pkcs12, cryptoapi */
+    {
+        if ((op=
tions->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
+    =
    {
+            msg(M_USAGE, "--key and --management-external-key are mu=
tually exclusive");
+        }
+        if ((options->management_flags & MF=
_EXTERNAL_CERT))
+        {
+            if (options->cert_file)
+         =
   {
+                msg(M_USAGE, "--cert and --management-external-cert a=
re mutually exclusive");
+            }
+            else if (!(options->ma=
nagement_flags & MF_EXTERNAL_KEY))
+            {
+                msg(M_US=
AGE,
+                    "--management-external-cert must be used with --m=
anagement-external-key");
+            }
+        }
         if (pull)
    =
     {
-            msg(M_USAGE, use_err, "--pull");
+            const int=
 sum =3D
+                ((options->cert_file !=3D NULL) || (options->mana=
gement_flags & MF_EXTERNAL_CERT))
+                + ((options->priv_key_fi=
le !=3D NULL)
+                   || (options->management_flags & MF_EXTERN=
AL_KEY));
+
+            if (sum =3D=3D 0)
+            {
+                =
if (!options->auth_user_pass_file)
+                {
+                    =
msg(M_USAGE, "No client-side authentication method is "
+                  =
               "specified=2E  You must use either "
+                      =
           "--cert/--key, --pkcs12, or "
+                                 =
"--auth-user-pass");
+                }
+            }
+            else if=
 (sum !=3D 2)
+            {
+                msg(M_USAGE, "If you use one =
of --cert or --key, you must use them both");
+            }
+        }
+  =
      else
+        {
+            if (!(options->management_flags & MF_EXT=
ERNAL_CERT))
+            {
+                notnull(options->cert_file,
+ =
                       "certificate file (--cert) or PKCS#12 file (--pkcs12=
)");
+            }
+            if (!(options->management_flags & MF_EXTER=
NAL_KEY))
+            {
+                notnull(options->priv_key_file,
+=
                        "private key file (--key) or PKCS#12 file (--pkcs12=
)");
+            }
         }
     }
+    if (ce->tls_auth_file && ce->tls=
_crypt_file)
+    {
+        msg(M_USAGE, "--tls-auth and --tls-crypt are m=
utually exclusive");
+    }
+    if (options->tls_client && ce->tls_crypt_v=
2_file
+        && (ce->tls_auth_file || ce->tls_crypt_file))
+    {
+     =
   msg(M_USAGE,
+            "--tls-crypt-v2, --tls-auth and --tls-crypt ar=
e mutually exclusive in client mode");
+    }
+
+
     if (options->auth_us=
er_pass_file && !options->pull)
     {
         msg(M_USAGE, "--auth-user-p=
ass requires --pull");
@@ -6957,32 +6891,6 @@
             goto err;
      =
   }
     }
-    else if (streq(p[0], "secret") && p[1] && !p[3])
-    {
- =
       msg(M_WARN, "DEPRECATED OPTION: The option --secret is deprecated=2E=
");
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
-        opti=
ons->shared_secret_file =3D p[1];
-        options->shared_secret_file_inli=
ne =3D is_inline;
-        if (!is_inline && p[2])
-        {
-            =
int key_direction;
-
-            key_direction =3D ascii2keydirection(msgl=
evel, p[2]);
-            if (key_direction >=3D 0)
-            {
-       =
         options->key_direction =3D key_direction;
-            }
-        =
    else
-            {
-                goto err;
-            }
-        =
}
-    }
-    else if (streq(p[0], "allow-deprecated-insecure-static-crypto=
"))
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->all=
ow_deprecated_insecure_static_crypto =3D true;
-    }
     else if (streq(p=
[0], "genkey") && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
=
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index c58530=
a=2E=2E129267f 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/optio=
ns=2Eh
@@ -569,9 +569,6 @@
     struct static_challenge_info sc_info;
 #end=
if
     /* Cipher parms */
-    const char *shared_secret_file;
-    bool s=
hared_secret_file_inline;
-    bool allow_deprecated_insecure_static_crypto=
;
     int key_direction;
     const char *ciphername;
     bool enable_ncp=
_fallback; /**< If defined fall back to
diff --git a/src/openvpn/options_sh=
ow=2Ec b/src/openvpn/options_show=2Ec
index 80d36f0=2E=2E321a37b 100644
---=
 a/src/openvpn/options_show=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -491,=
7 +491,6 @@
     }
 #endif
 
-    SHOW_STR_INLINE(shared_secret_file);
    =
 SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true)=
, "%s");
     SHOW_STR(ciphername);
     SHOW_STR(ncp_ciphers);
diff --git =
a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec
index cfc=
0595=2E=2E2fd90dd 100644
--- a/src/openvpn/options_string=2Ec
+++ b/src/ope=
nvpn/options_string=2Ec
@@ -140,83 +140,72 @@
     /*
      * Crypto Option=
s
      */
-    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
+   =
 struct key_type kt;
+
+    ASSERT((TLS_CLIENT =3D=3D true) + (TLS_SERVER =
=3D=3D true) <=3D 1);
+
+    /* Skip resolving BF-CBC to allow SSL librarie=
s without BF-CBC
+     * to work here in the default configuration */
+    =
const char *ciphername =3D o->ciphername;
+    size_t keysize =3D 0;
+
+   =
 if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
     {
-        struct key_t=
ype kt;
-
-        ASSERT((o->shared_secret_file !=3D NULL) + (TLS_CLIENT =
=3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
-
-        /* Skip resolvi=
ng BF-CBC to allow SSL libraries without BF-CBC
-         * to work here in=
 the default configuration */
-        const char *ciphername =3D o->cipher=
name;
-        size_t keysize =3D 0;
-
-        if (strcmp(o->ciphername, "=
BF-CBC") =3D=3D 0)
+        init_key_type(&kt, "none", o->authname, false);=

+        keysize =3D 128;
+    }
+    else
+    {
+        init_key_type(&=
kt, o->ciphername, o->authname, false);
+        ciphername =3D cipher_kt_n=
ame(kt=2Ecipher);
+        if (cipher_defined(o->ciphername))
         {
- =
           init_key_type(&kt, "none", o->authname, true, false);
-         =
   keysize =3D 128;
-        }
-        else
-        {
-            init_k=
ey_type(&kt, o->ciphername, o->authname, true, false);
-            ciphern=
ame =3D cipher_kt_name(kt=2Ecipher);
-            if (cipher_defined(o->cip=
hername))
-            {
-                keysize =3D cipher_kt_key_size(kt=
=2Ecipher) * 8;
-            }
-        }
-        /* Only announce the cip=
her to our peer if we are willing to
-         * support it */
-        if =
(p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
-      =
  {
-            buf_printf(&out, ",cipher %s", ciphername);
-        }
-  =
      buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest));
-        buf_p=
rintf(&out, ",keysize %zu", keysize);
-        if (o->shared_secret_file)
-=
        {
-            buf_printf(&out, ",secret");
+            keysize =
=3D cipher_kt_key_size(kt=2Ecipher) * 8;
         }
     }
+    /* Only ann=
ounce the cipher to our peer if we are willing to
+     * support it */
+  =
  if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+ =
   {
+        buf_printf(&out, ",cipher %s", ciphername);
+    }
+    buf_p=
rintf(&out, ",auth %s", md_kt_name(kt=2Edigest));
+    buf_printf(&out, ",k=
eysize %zu", keysize);
 
     /*
      * SSL Options
      */
+    if (o->c=
e=2Etls_auth_file)
     {
-        if (TLS_CLIENT || TLS_SERVER)
-        {=

-            if (o->ce=2Etls_auth_file)
-            {
-                bu=
f_printf(&out, ",tls-auth");
-            }
-            /* Not adding tls-=
crypt here, because we won't reach this code if
-             * tls-auth/tl=
s-crypt does not match=2E  Removing tls-auth here would
-             * bre=
ak stuff, so leaving that in place=2E */
+        buf_printf(&out, ",tls-au=
th");
+    }
+    /* Not adding tls-crypt here, because we won't reach this=
 code if
+     * tls-auth/tls-crypt does not match=2E  Removing tls-auth he=
re would
+     * break stuff, so leaving that in place=2E */
 
-           =
 buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-        }
+    buf_prin=
tf(&out, ",key-method %d", KEY_METHOD_2);
 
-        if (remote)
+
+    if =
(remote)
+    {
+        if (TLS_CLIENT)
         {
-            if (TLS_CL=
IENT)
-            {
-                buf_printf(&out, ",tls-server");
-   =
         }
-            else if (TLS_SERVER)
-            {
-              =
  buf_printf(&out, ",tls-client");
-            }
+            buf_printf(&=
out, ",tls-server");
         }
-        else
+        else if (TLS_SERVER)=

         {
-            if (TLS_CLIENT)
-            {
-                bu=
f_printf(&out, ",tls-client");
-            }
-            else if (TLS_SER=
VER)
-            {
-                buf_printf(&out, ",tls-server");
-    =
        }
+            buf_printf(&out, ",tls-client");
+        }
+    }
+=
    else
+    {
+        if (TLS_CLIENT)
+        {
+            buf_printf=
(&out, ",tls-client");
+        }
+        else if (TLS_SERVER)
+        {
=
+            buf_printf(&out, ",tls-server");
         }
     }
 
diff --gi=
t a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ddee3eb=2E=2E55043e5 10=
0644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1644,7 +1644,7=
 @@
         return true;
     }
 
-    init_key_type(&session->opt->key_ty=
pe, options->ciphername, options->authname, true, true);
+    init_key_type=
(&session->opt->key_type, options->ciphername, options->authname, true);
 
=
     bool packet_id_long_form =3D cipher_kt_mode_ofb_cfb(session->opt->key_=
type=2Ecipher);
     session->opt->crypto_flags &=3D ~(CO_PACKET_ID_LONG_FO=
RM);
diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tes=
ts/openvpn/test_crypto=2Ec
index 07c54b4=2E=2Edde4ef5 100644
--- a/tests/un=
it_tests/openvpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=
=2Ec
@@ -237,70 +237,58 @@
     /* common defaults */
     o=2Ece=2Etun_mtu=
 =3D 1400;
     o=2Ece=2Eproto =3D PROTO_UDP;
+    o=2Etls_client =3D true;=

+    o=2Epull =3D true;
 
-    /* No crypto at all */
+    /*  auth none, =
cipher none */
     o=2Eciphername =3D "none";
     o=2Eauthname =3D "none"=
;
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_eq=
ual(linkmtu, 1400);
+    assert_int_equal(linkmtu, 1405);
 
-    /* Static =
key OCC examples */
-    o=2Eshared_secret_file =3D "not null";
-
-    /* s=
ecret, auth none, cipher none */
-    o=2Eciphername =3D "none";
-    o=2Ea=
uthname =3D "none";
-    linkmtu =3D calc_options_string_link_mtu(&o, &f);
=
-    assert_int_equal(linkmtu, 1408);
-
-    /* secret, cipher AES-128-CBC,=
 auth none */
+    /* cipher AES-128-CBC, auth none */
     o=2Eciphername =
=3D "AES-128-CBC";
     o=2Eauthname =3D "none";
     linkmtu =3D calc_opti=
ons_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1440);
+    ass=
ert_int_equal(linkmtu, 1437);
 
-    /* secret, cipher none, auth SHA256 */=

+    /* cipher none, auth SHA256 */
     o=2Eciphername =3D "none";
     o=
=2Eauthname =3D "SHA256";
     linkmtu =3D calc_options_string_link_mtu(&o,=
 &f);
-    assert_int_equal(linkmtu, 1440);
+    assert_int_equal(linkmtu, =
1437);
 
-    /* secret, cipher BF-CBC, auth SHA1 */
+    /* cipher BF-CBC,=
 auth SHA1 */
     o=2Eciphername =3D "BF-CBC";
     o=2Eauthname =3D "SHA1=
";
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_e=
qual(linkmtu, 1444);
+    assert_int_equal(linkmtu, 1441);
 
-    /* secret=
, cipher BF-CBC, auth SHA1, tcp-client */
+    /* cipher BF-CBC, auth SHA1,=
 tcp-client */
     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;
     linkmtu =3D c=
alc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1446);
=
+    assert_int_equal(linkmtu, 1443);
 
     o=2Ece=2Eproto =3D PROTO_UDP;
=
 
 #if defined(USE_COMP)
     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;
 
-    /* se=
cret, comp-lzo yes, cipher BF-CBC, auth SHA1 */
+    /*  comp-lzo yes, ciph=
er BF-CBC, auth SHA1 */
     linkmtu =3D calc_options_string_link_mtu(&o, &=
f);
-    assert_int_equal(linkmtu, 1445);
+    assert_int_equal(linkmtu, 14=
42);
 
 #if defined(ENABLE_FRAGMENT)
-    /* secret, comp-lzo yes, cipher B=
F-CBC, auth SHA1, fragment 1200 */
+    /* comp-lzo yes, cipher BF-CBC, aut=
h SHA1, fragment 1200 */
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D =
calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1449);=

+    assert_int_equal(linkmtu, 1446);
     o=2Ece=2Efragment =3D 0;
 #endi=
f
 
     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;
 #endif
 
-    /* TLS mode */
-=
    o=2Eshared_secret_file =3D NULL;
-    o=2Etls_client =3D true;
-    o=
=2Epull =3D true;
-
     /* tls client, cipher AES-128-CBC, auth SHA1, tls-=
auth */
     o=2Eauthname =3D "SHA1";
     o=2Eciphername =3D "AES-128-CBC"=
;
@@ -358,50 +346,48 @@
     o=2Ece=2Etun_mtu =3D 1400;
     o=2Ece=2Emssfi=
x =3D 1000;
     o=2Ece=2Eproto =3D PROTO_UDP;
+    o=2Etls_client =3D true=
;
 
     /* No crypto at all */
     o=2Eciphername =3D "none";
     o=2Eau=
thname =3D "none";
     struct key_type kt;
-    init_key_type(&kt, o=2Ecip=
hername, o=2Eauthname, false, false);
+    init_key_type(&kt, o=2Eciphernam=
e, o=2Eauthname, false);
 
-    /* No encryption, just packet id (8) + TCP =
payload(20) + IP payload(20) */
+    /* No encryption, just packet id (4) +=
 opcode (1) + TCP payload(20) + IP payload(20) */
     frame_calculate_dyna=
mic(&f, &kt, &o, NULL);
-    assert_int_equal(f=2Emss_fix, 952);
+    asser=
t_int_equal(f=2Emss_fix, 955);
 
-    /* Static key OCC examples */
-    o=
=2Eshared_secret_file =3D "not null";
-
-    /* secret, auth none, cipher n=
one */
+    /* auth none, cipher none */
     o=2Eciphername =3D "none";
  =
   o=2Eauthname =3D "none";
-    init_key_type(&kt, o=2Eciphername, o=2Eaut=
hname, false, false);
+    init_key_type(&kt, o=2Eciphername, o=2Eauthname,=
 false);
     frame_calculate_dynamic(&f, &kt, &o, NULL);
-    assert_int_e=
qual(f=2Emss_fix, 952);
+    assert_int_equal(f=2Emss_fix, 955);
 
     /* =
secret, cipher AES-128-CBC, auth none */
     o=2Eciphername =3D "AES-128-C=
BC";
     o=2Eauthname =3D "none";
-    init_key_type(&kt, o=2Eciphername, =
o=2Eauthname, false, false);
+    init_key_type(&kt, o=2Eciphername, o=2Eau=
thname, false);
 
-    for (int i =3D 990; i <=3D 1010; i++)
+    for (int =
i =3D 990; i <=3D 1015; i++)
     {
         /* 992 - 1008 should end up wi=
th the same mssfix value all they
-         * all result in the same CBC bl=
ock size/padding and <=3D 991 and >=3D1008
+         * all result in the sa=
me CBC block size/padding and <=3D 992 and >=3D1009
          * should be o=
ne block less and more respectively */
         o=2Ece=2Emssfix =3D i;
    =
     frame_calculate_dynamic(&f, &kt, &o, NULL);
-        if (i <=3D 991)
+=
        if (i <=3D 992)
         {
-            assert_int_equal(f=2Emss_fi=
x, 911);
+            assert_int_equal(f=2Emss_fix, 915);
         }
-     =
   else if (i >=3D 1008)
+        else if (i >=3D 1009)
         {
-       =
     assert_int_equal(f=2Emss_fix, 943);
+            assert_int_equal(f=2E=
mss_fix, 947);
         }
         else
         {
-            assert_int_=
equal(f=2Emss_fix, 927);
+            assert_int_equal(f=2Emss_fix, 931);
 =
        }
     }
 #ifdef USE_COMP
@@ -413,33 +399,32 @@
     for (int i =3D=
 990; i <=3D 1010; i++)
     {
         /* 992 - 1008 should end up with th=
e same mssfix value all they
-         * all result in the same CBC block s=
ize/padding and <=3D 991 and >=3D1008
+         * all result in the same CB=
C block size/padding and <=3D 992 and >=3D1009
          * should be one bl=
ock less and more respectively */
         o=2Ece=2Emssfix =3D i;
         =
frame_calculate_dynamic(&f, &kt, &o, NULL);
-        if (i <=3D 991)
+     =
   if (i <=3D 992)
         {
-            assert_int_equal(f=2Emss_fix, 91=
0);
+            assert_int_equal(f=2Emss_fix, 914);
         }
-        el=
se if (i >=3D 1008)
+        else if (i >=3D 1009)
         {
-            =
assert_int_equal(f=2Emss_fix, 942);
+            assert_int_equal(f=2Emss_f=
ix, 946);
         }
         else
         {
-            assert_int_equal=
(f=2Emss_fix, 926);
+            assert_int_equal(f=2Emss_fix, 930);
      =
   }
     }
     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;
 #endif /* ifdef USE_CO=
MP */
 
-    /* tls client, auth SHA1, cipher AES-256-GCM */
+    /*  auth =
SHA1, cipher AES-256-GCM */
     o=2Eauthname =3D "SHA1";
     o=2Ecipherna=
me =3D "AES-256-GCM";
-    o=2Etls_client =3D true;
     o=2Epeer_id =3D 77=
;
     o=2Euse_peer_id =3D true;
-    init_key_type(&kt, o=2Eciphername, o=
=2Eauthname, true, false);
+    init_key_type(&kt, o=2Eciphername, o=2Eauth=
name, false);
 
     for (int i =3D 900; i <=3D 1200; i++)
     {
@@ -685,7=
 +670,7 @@
 
     data->gc =3D gc_new();
 
-    init_key_type(&data->kt, "A=
ES-128-GCM", "none", true, false);
+    init_key_type(&data->kt, "AES-128-G=
CM", "none", false);
 
     /* have an epoch key that uses 0x23 for the key=
 for all bytes */
     struct epoch_key epoch1send =3D { =2Eepoch =3D 1, =
=2Eepoch_key =3D { 0x23 } };
@@ -907,7 +892,7 @@
     struct epoch_key e17 =
=3D { =2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 } };
     struct key_type =
kt =3D { 0 };
     struct key_parameters key_parameters =3D { 0 };
-    ini=
t_key_type(&kt, "AES-192-GCM", "none", true, false);
+    init_key_type(&kt=
, "AES-192-GCM", "none", false);
 
 
     epoch_data_key_derive(&key_parame=
ters, &e17, &kt);
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/test=
s/unit_tests/openvpn/test_pkt=2Ec
index fbbb40f=2E=2E49ba833 100644
--- a/t=
ests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pk=
t=2Ec
@@ -173,7 +173,7 @@
     tas=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE=
_PACKET_ID | CO_PACKET_ID_LONG_FORM);
 
     struct key_type tls_crypt_kt;
=
-    init_key_type(&tls_crypt_kt, "none", "SHA1", true, false);
+    init_k=
ey_type(&tls_crypt_kt, "none", "SHA1", false);
 
     crypto_read_openvpn_k=
ey(&tls_crypt_kt, &tas=2Etls_wrap=2Eopt=2Ekey_ctx_bi, static_key, true,
   =
                          key_direction, "Control Channel Authentication", =
"tls-auth", NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2081?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Gerrit-Change-Number: 2081
Ge=
rrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>

--qrYF5cLqXiI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Change</a></p><p>The =
following approvals got outdated and were removed:
Code-Review-1 by Frank L=
ichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">Remove support for --secret<br><br>This has bee=
n announced for a long time and good alternatives exist=2E<br><br>Change-Id=
: Icadbee50a3af55f0f2069f6d6f1ccc746180f368<br>Signed-off-by: Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=2Emd<br>M INSTALL<br>M doc/m=
an-sections/protocol-options=2Erst<br>M doc/man-sections/unsupported-option=
s=2Erst<br>M src/openvpn/check_file_access=2Ec<br>M src/openvpn/crypto=2Ec<=
br>M src/openvpn/crypto=2Eh<br>M src/openvpn/helper=2Ec<br>M src/openvpn/in=
it=2Ec<br>M src/openvpn/mtu=2Ec<br>M src/openvpn/options=2Ec<br>M src/openv=
pn/options=2Eh<br>M src/openvpn/options_show=2Ec<br>M src/openvpn/options_s=
tring=2Ec<br>M src/openvpn/ssl=2Ec<br>M tests/unit_tests/openvpn/test_crypt=
o=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>17 files changed, 244 i=
nsertions(+), 497 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/2081/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/Changes=2Emd b/Changes=2Emd</span><br><span>index b5ae881=2E=2Edd1239=
1 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=
=2Emd</span><br><span>@@ -23,6 +23,13 @@</span><br><span>   the characters =
mentioned above were already escaped=2E However, the behavior of</span><br>=
<span>   Mbed TLS is slightly different from OpenSSL in that it also escape=
s &quot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+* **`secret` has been removed**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  Static key mode (non-TLS) is no longer considered &quot;good =
and secure enough&quot; for</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  today&#39;s requirements=2E Use TLS mode instead=2E If deploying =
a PKI CA is considered</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &quot;too complicated&quot;, using `--peer-fingerprint` makes TLS mode=
 about as easy as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
using `--secret`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 </span><br><span> ## Maintainer-visible changes</span><br><span> </span><b=
r><span> - The configure-time option `--enable-debug` is no longer  availab=
le</span><br><span>diff --git a/INSTALL b/INSTALL</span><br><span>index 486=
b1ae=2E=2Ed0ffaf0 100644</span><br><span>--- a/INSTALL</span><br><span>+++ =
b/INSTALL</span><br><span>@@ -144,8 +144,7 @@</span><br><span> </span><br><=
span> Test Crypto:</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-=2E/openvpn --genkey secret key</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-=2E/openvpn --test-crypto --secret key</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+=2E/openvpn --test-crypto</span=
><br><span> </span><br><span> Test SSL/TLS negotiations (runs for 2 minutes=
):</span><br><span> </span><br><span>diff --git a/doc/man-sections/protocol=
-options=2Erst b/doc/man-sections/protocol-options=2Erst</span><br><span>in=
dex 52ce5a8=2E=2Eb785ebe 100644</span><br><span>--- a/doc/man-sections/prot=
ocol-options=2Erst</span><br><span>+++ b/doc/man-sections/protocol-options=
=2Erst</span><br><span>@@ -212,11 +212,6 @@</span><br><span>   have been co=
nfigured with ``--enable-small``</span><br><span>   (typically used on rout=
ers or other embedded devices)=2E</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>---allow-deprecated-insecu=
re-static-crypto</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   **=
DEPRECATED** This allow using OpenVPN without TLS=2E This is deprecated</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   and will be removed in=
 OpenVPN 2=2E8=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> --tran-window n</span><br><span>   Transition window -- our o=
ld key can live this many seconds after a new</span><br><span>   a key rene=
gotiation begins (default :code:`3600` seconds)=2E This feature</span><br><=
span>diff --git a/doc/man-sections/unsupported-options=2Erst b/doc/man-sect=
ions/unsupported-options=2Erst</span><br><span>index c273905=2E=2E0bb5e4b 1=
00644</span><br><span>--- a/doc/man-sections/unsupported-options=2Erst</spa=
n><br><span>+++ b/doc/man-sections/unsupported-options=2Erst</span><br><spa=
n>@@ -70,3 +70,9 @@</span><br><span>   Removed in OpenVPN 2=2E8=2E This opt=
ion caused the Mbed TLS 3 random number</span><br><span>   generator to be =
reseeded on every call=2E It has been removed because this</span><br><span>=
   is excessive=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+--secret</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2=2E8=2E S=
tatic encryption without a transient key</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  (generated by DH or ECDH) has been considered proble=
matic for many</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  yea=
rs=2E Please use ``--peer-fingerprint`` and self-signed certificates</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  for small setups=2E</spa=
n><br><span>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/ch=
eck_file_access=2Ec</span><br><span>index 83654b2=2E=2E90dbb4e 100644</span=
><br><span>--- a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b/sr=
c/openvpn/check_file_access=2Ec</span><br><span>@@ -312,10 +312,6 @@</span>=
<br><span>                                          ce-&gt;tls_crypt_v2_fil=
e, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_file_access_=
inline(options-&gt;shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
            options-&gt;shared_secret_file, R_OK, &quot;--secret&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     er=
rs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;pa=
cket_id_file,</span><br><span>                               R_OK | W_OK, &=
quot;--replay-persist&quot;);</span><br><span> </span><br><span>diff --git =
a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 386=
b164=2E=2E382bfd8 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span=
><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -872,7 +872,7 @@=
</span><br><span>  * Build a struct key_type=2E</span><br><span>  */</span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_k=
ey_type(struct key_type *kt, const char *ciphername, const char *authname, =
bool tls_mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_=
key_type(struct key_type *kt, const char *ciphername, const char *authname,=
</span><br><span>               bool warn)</span><br><span> {</span><br><sp=
an>     bool aead_cipher =3D false;</span><br><span>@@ -891,9 +891,9 @@</sp=
an><br><span> </span><br><span>         /* check legal cipher mode */</span=
><br><span>         aead_cipher =3D cipher_kt_mode_aead(kt-&gt;cipher);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(cipher_kt_m=
ode_cbc(kt-&gt;cipher) || (tls_mode &amp;&amp; aead_cipher)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!(cipher_kt_mode_cbc(kt=
-&gt;cipher) || aead_cipher</span><br><span> #ifdef ENABLE_OFB_CFB_MODE</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-              || (tls_mod=
e &amp;&amp; cipher_kt_mode_ofb_cfb(kt-&gt;cipher))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              || cipher_kt_mode_ofb_cfb(k=
t-&gt;cipher)</span><br><span> #endif</span><br><span>                   ))=
</span><br><span>         {</span><br><span>@@ -1716,7 +1716,7 @@</span><br=
><span>     printf(&quot;%s  (%u bit key, &quot;, cipher_kt_name(ciphername=
), cipher_kt_key_size(ciphername) * 8);</span><br><span> </span><br><span> =
    if (cipher_kt_block_size(ciphername) =3D=3D 1)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   {</span><br><span>         printf(&quot;stream cipher&quo=
t;);</span><br><span>     }</span><br><span>     else</span><br><span>diff =
--git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>ind=
ex dbe0802=2E=2E203f77b 100644</span><br><span>--- a/src/openvpn/crypto=2Eh=
</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -420,11 +4=
20,9 @@</span><br><span>  * @param kt          The struct key_type to initi=
alize</span><br><span>  * @param ciphername  The name of the cipher to use<=
/span><br><span>  * @param authname    The name of the HMAC digest to use</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param tls_mode    S=
pecifies whether we are running in TLS mode, which allows</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *                    more ciphers than=
 static key mode=2E</span><br><span>  * @param warn        Print warnings w=
hen null cipher / auth is used=2E</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void init_key_type(struct key_type *kt, co=
nst char *ciphername, const char *authname, bool tls_mode,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void init_key_type(struct key_type *=
kt, const char *ciphername, const char *authname,</span><br><span>         =
           bool warn);</span><br><span> </span><br><span> /*</span><br><spa=
n>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><br><s=
pan>index d29895b=2E=2E6b5fcee6 100644</span><br><span>--- a/src/openvpn/he=
lper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><span>@@ -2=
66,12 +266,6 @@</span><br><span>             msg(M_USAGE, &quot;--server an=
d --server-bridge cannot be used together&quot;);</span><br><span>         =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                &quot;--server and --secret cannot be used together (y=
ou must use SSL/TLS keys)&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>         if (!(o-&gt;server_flags &amp; SF_NOPOOL) &amp;&a=
mp; o-&gt;ifconfig_pool_defined)</span><br><span>         {</span><br><span=
>             msg(M_USAGE,</span><br><span>@@ -461,12 +455,6 @@</span><br><=
span>                 &quot;--server-bridge already defines an ifconfig-poo=
l, so you can&#39;t also specify --ifconfig-pool explicitly&quot;);</span><=
br><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (o-&gt;shared_secret_file)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_USAGE,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &quot;--server-bridge and --secret c=
annot be used together (you must use SSL/TLS keys)&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>         if (dev !=3D DEV_TYPE_TA=
P)</span><br><span>         {</span><br><span>             msg(M_USAGE, &qu=
ot;--server-bridge directive only makes sense with --dev tap&quot;);</span>=
<br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><b=
r><span>index 24cf532=2E=2E9299c4f 100644</span><br><span>--- a/src/openvpn=
/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -99=
6,35 +996,10 @@</span><br><span>         platform_mlockall(true);</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* We do not want user to use --genkey with --secret=2E In the transistion</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * phase we for sec=
ret=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;genkey &a=
mp;&amp; options-&gt;genkey_type !=3D GENKEY_SECRET &amp;&amp; options-&gt;=
shared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAG=
E, &quot;Using --genkey type with --secret filename is &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                     &quot;not supp=
orted=2E  Use --genkey type filename instead=2E&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     if (options-&g=
t;genkey &amp;&amp; options-&gt;genkey_type =3D=3D GENKEY_SECRET)</span><br=
><span>     {</span><br><span>         int nbits_written;</span><br><span> =
        const char *genkey_filename =3D options-&gt;genkey_filename;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;shar=
ed_secret_file &amp;&amp; options-&gt;genkey_filename)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;You must provide a file=
name to either --genkey &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         &quot;or --secret, not both&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * Copy filename from shared_secret_file to genkey_filename to =
support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * the=
 old --genkey --secret foo=2Efile syntax=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (options-&gt;shared_secret_file)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: Using --genkey=
 --secret filename is &quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        &quot;DEPRECATED=2E  Use --genkey secret fil=
ename instead=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            genkey_filename =3D options-&gt;shared_secret_file;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span> </s=
pan><br><span>         nbits_written =3D write_key_file(2, genkey_filename)=
;</span><br><span>         if (nbits_written &lt; 0)</span><br><span>@@ -10=
33,7 +1008,7 @@</span><br><span>         }</span><br><span> </span><br><spa=
n>         msg(D_GENKEY | M_NOPREFIX, &quot;Randomly generated %d bit key w=
ritten to %s&quot;, nbits_written,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            options-&gt;shared_secret_file);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            options-&gt;genkey_filena=
me ? options-&gt;genkey_filename : &quot;stdout&quot;);</span><br><span>   =
      return true;</span><br><span>     }</span><br><span>     else if (opt=
ions-&gt;genkey &amp;&amp; options-&gt;genkey_type =3D=3D GENKEY_TLS_CRYPTV=
2_SERVER)</span><br><span>@@ -1079,7 +1054,7 @@</span><br><span>     /* san=
ity check on options for --mktun or --rmtun */</span><br><span>     notnull=
(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><br><span>    =
 if (options-&gt;ce=2Eremote || options-&gt;ifconfig_local || options-&gt;i=
fconfig_remote_netmask</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        || options-&gt;shared_secret_file || options-&gt;tls_server || opt=
ions-&gt;tls_client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        || options-&gt;tls_server || options-&gt;tls_client)</span><br><sp=
an>     {</span><br><span>         msg(M_FATAL | M_OPTERR,</span><br><span>=
             &quot;options --mktun or --rmtun should only be used together =
with --dev&quot;);</span><br><span>@@ -3011,8 +2986,7 @@</span><br><span>  =
   ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c1=2Eks=2Estatic_key));</span><br>=
<span> </span><br><span>     /* Init cipher and hash algorithm */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;c-&gt;c1=
=2Eks=2Ekey_type, options-&gt;ciphername, options-&gt;authname,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                  options-&gt;tes=
t_crypto, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;ciphername, optio=
ns-&gt;authname, true);</span><br><span> </span><br><span>     generate_tes=
t_crypto_random_key(&amp;c-&gt;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=2Eks=2Esta=
tic_key,</span><br><span>                                     &quot;test cr=
ypto key&quot;);</span><br><span>@@ -3022,50 +2996,6 @@</span><br><span> }<=
/span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Static Key Mode (using a pre-shared key)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-do_init_crypto_static(struct context *c, const unsigned int flags=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const struct options *options =3D &a=
mp;c-&gt;options;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(options-&gt;shared_secret_file);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 init_crypto_pre(c, flags);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initiali=
ze flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-=
&gt;options=2Emute_replay_warnings)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_MUTE_REPLAY_WARNINGS;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* Initialize packet ID tracking */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    packet_id_init(&amp;c-&gt;c2=2Ecrypto_opti=
ons=2Epacket_id, options-&gt;replay_window, options-&gt;replay_time,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                   &quot;STA=
TIC&quot;, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&=
gt;c2=2Ecrypto_options=2Epid_persist =3D &amp;c-&gt;c1=2Epid_persist;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_optio=
ns=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    packet_id_persist_load_obj(&amp;c-&gt;c1=2Epid_persis=
t, &amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!key_ctx_bi_defined(&amp;c-&gt;c1=2Eks=2Estatic_key))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        /* Get cipher &amp; hash algorithms */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        init_key_type=
(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;ciphername, options-&gt;authnam=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
   options-&gt;test_crypto, true);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* Read cipher and hmac keys from shared secret file */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        crypto_read_openvpn_key(&amp;c-&g=
t;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=2Eks=2Estatic_key,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                options-&g=
t;shared_secret_file, options-&gt;shared_secret_file_inline,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                opti=
ons-&gt;key_direction, &quot;Static Key Encryption&quot;, &quot;secret&quot=
;, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(M_INFO, &quot;Re-using pre-shared static key&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Get key schedule */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_options=2Ekey_ctx_bi =3D=
 c-&gt;c1=2Eks=2Estatic_key;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Initialize =
the tls-auth/crypt key context</span><br><span>  */</span><br><span> static=
 void</span><br><span>@@ -3204,7 +3134,7 @@</span><br><span> </span><br><sp=
an>         /* Do not warn if the cipher is used only in OCC */</span><br><=
span>         bool warn =3D options-&gt;enable_ncp_fallback;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        init_key_type(&amp;c-&gt;c1=
=2Eks=2Ekey_type, ciphername, options-&gt;authname, true, warn);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        init_key_type(&amp;c-&=
gt;c1=2Eks=2Ekey_type, ciphername, options-&gt;authname, warn);</span><br><=
span> </span><br><span>         /* initialize tls-auth/crypt/crypt-v2 key *=
/</span><br><span>         do_init_tls_wrap_key(c);</span><br><span>@@ -349=
2,41 +3422,6 @@</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * No encryption or authentication=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-do_init_crypto_none(struct context *c)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(!c-&gt;options=2Etest_crypto);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* Initialise key_type with auth/cipher &quot;none&q=
uot;, so the key_type struct is</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     * valid */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, &quot;none&quot;, &quo=
t;none&quot;, c-&gt;options=2Etest_crypto, true);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    msg(M_WARN, &quot;******* WARNING *******: All encryption and au=
thentication features &quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                &quot;disabled -- All data will be tunnelled as clea=
r text and will not be &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                &quot;protected against man-in-the-middle changes=
=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     &quot;PLEASE DO RECONSIDER THIS CONFIGURATION!&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_crypt=
o(struct context *c, const unsigned int flags)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (c-&gt;options=2Eshared_secret_file)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        do_init_crypto_static(c, flags);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else if (c-&gt;options=2Etls_server || c-&gt;options=2E=
tls_client)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_crypto_tls=
(c, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else /* no encryption =
or authentication=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_ini=
t_crypto_none(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br>=
<span> do_init_frame(struct context *c)</span><br><span> {</span><br><span>=
@@ -4564,7 +4459,7 @@</span><br><span>         {</span><br><span>          =
   crypto_flags =3D CF_INIT_TLS_MULTI;</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_crypto(c, crypt=
o_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do=
_init_crypto_tls(c, crypto_flags);</span><br><span>         if (IS_SIG(c) &=
amp;&amp; !child)</span><br><span>         {</span><br><span>             g=
oto sig;</span><br><span>diff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=
=2Ec</span><br><span>index f3c2874=2E=2E5ce40c8 100644</span><br><span>--- =
a/src/openvpn/mtu=2Ec</span><br><span>+++ b/src/openvpn/mtu=2Ec</span><br><=
span>@@ -51,7 +51,6 @@</span><br><span> unsigned int</span><br><span> calc_=
packet_id_size_dc(const struct options *options, const struct key_type *kt)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  bool tlsmode =3D options-&gt;tls_server || options-&gt;tls_client;</span>=
<br><span>     bool epoch =3D options-&gt;imported_protocol_flags &amp; CO_=
EPOCH_DATA_KEY_FORMAT;</span><br><span> </span><br><span>     /* epoch form=
at uses a 64-bit packet id: 16 bit epoch + 48 bit per-epoch counter */</spa=
n><br><span>@@ -60,7 +59,7 @@</span><br><span>         return sizeof(uint64=
_t);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    bool packet_id_long_form =3D !tlsmode || cipher=
_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool packet_id_long_form =3D cipher_kt_mode_ofb_cfb(kt-&gt=
;cipher);</span><br><span> </span><br><span>     return packet_id_size(pack=
et_id_long_form);</span><br><span> }</span><br><span>@@ -72,8 +71,6 @@</spa=
n><br><span>     /* Sum of all the overhead that reduces the usable packet =
size */</span><br><span>     size_t header_size =3D 0;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool tlsmode =3D opt=
ions-&gt;tls_server || options-&gt;tls_client;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>     /* A socks proxy adds extra =
header to each packet</span><br><span>      * (we only support Socks with I=
Pv4, this value is different for IPv6) */</span><br><span>     if (options-=
&gt;ce=2Esocks_proxy_server &amp;&amp; proto_is_udp(options-&gt;ce=2Eproto)=
)</span><br><span>@@ -88,10 +85,7 @@</span><br><span>     }</span><br><span=
> </span><br><span>     /* Add the opcode and peerid */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (tlsmode)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        header_size +=3D options-&gt;use_peer_id ? 4 : 1;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    header_size +=3D options-&gt;use_pee=
r_id ? 4 : 1;</span><br><span> </span><br><span>     unsigned int pkt_id_si=
ze =3D calc_packet_id_size_dc(options, kt);</span><br><span> </span><br><sp=
an>@@ -156,13 +150,6 @@</span><br><span> {</span><br><span>     struct key_=
type occ_kt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* neither --secret nor TLS mode */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!o-&gt;tls_client &amp;&amp; !o-&gt;tls_=
server &amp;&amp; !o-&gt;shared_secret_file)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        init_key_type(&amp;occ_kt, &quot;none&quot;, &quot;none&quot=
;, false, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return frame_calculate_payload_size(frame, o, &amp;occ_kt);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     /* o-&gt;ciphername might b=
e BF-CBC even though the underlying SSL library</span><br><span>      * doe=
s not support it=2E For this reason we workaround this corner case</span><b=
r><span>      * by pretending to have no encryption enabled and by manually=
 adding</span><br><span>@@ -184,9 +171,7 @@</span><br><span>         cipher=
name =3D &quot;none&quot;;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* We pass tlsmode always=
 true here since as we do not need to check if</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * the ciphers are actually valid for non tls =
in occ calucation */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   init_key_type(&amp;occ_kt, ciphername, o-&gt;authname, true, false);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;=
occ_kt, ciphername, o-&gt;authname, false);</span><br><span> </span><br><sp=
an>     size_t payload =3D frame_calculate_payload_size(frame, o, &amp;occ_=
kt);</span><br><span>     overhead +=3D frame_calculate_protocol_header_siz=
e(&amp;occ_kt, o, true);</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8e0c602=2E=2E386f412 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -1587,6 +1587,10 @@</span><br><sp=
an> static void</span><br><span> options_postprocess_verify_ce(const struct=
 options *options, const struct connection_entry *ce)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;te=
st_crypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     =
struct options defaults;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</=
span><br><span>     bool pull =3D false;</span><br><span>@@ -2012,27 +2016,=
9 @@</span><br><span>     /*</span><br><span>      * SSL/TLS mode sanity ch=
ecks=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (options-&gt;tls_server + options-&gt;tls_client + (optio=
ns-&gt;shared_secret_file !=3D NULL) &gt; 1)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (options-&gt;tls_server + options-&gt;tls_c=
lient + options-&gt;test_crypto !=3D 1)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quot;specify=
 only one of --tls-server, --tls-client, or --secret&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_client &amp;&=
amp; !options-&gt;test_crypto)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msglvl_t msglevel =3D M_USAGE;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (options-&gt;allow_deprecated_insecure_static_crypto)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msglevel =3D M_INFO;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(msglevel, &quot;DEPRECATION: No tls-client o=
r tls-server option in &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                      &quot;configuration detected=2E OpenVPN 2=2E8=
 will remove the &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                      &quot;functionality to run a VPN without TLS=2E &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
    &quot;See the examples section in the manual page for &quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                      &quot;exam=
ples of a similar quick setup with peer-fingerprint=2E &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                      &quot;OpenVPN=
 2=2E7 allows using this configuration when using &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                      &quot;--allow-depr=
ecated-insecure-static-crypto but you should move &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                      &quot;to a proper =
configuration using TLS as soon as possible=2E&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;OpenVPN confi=
guration must use either --tls-server or --tls-client&quot;);</span><br><sp=
an>     }</span><br><span> </span><br><span>     if (options-&gt;ssl_flags =
&amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))</span><b=
r><span>@@ -2052,188 +2038,136 @@</span><br><span>         msg(M_USAGE, &qu=
ot;--tls-version-min bigger than --tls-version-max&quot;);</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (options-&gt;tls_server || options-&gt;tls_client)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        check_ca_required(options);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    check_ca_required(options);</span><br><span> #ifdef=
 ENABLE_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!options-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Option =
pkcs11-id is ignored as no pkcs11-providers are specified&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else if (!options-&gt;pkcs11_provid=
ers[0] &amp;&amp; options-&gt;pkcs11_id_management)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                &quot;Option pkcs11-id-management is =
ignored as no pkcs11-providers are specified&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!options-&gt;pkcs11_providers[0] &amp;&amp; o=
ptions-&gt;pkcs11_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_WARN, &quot;Option pkcs11-id is ignored as no pkcs11-providers are specif=
ied&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (!options-=
&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id_management)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;Option pkcs11-id-manag=
ement is ignored as no pkcs11-providers are specified&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;pkcs11_=
providers[0])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (opti=
ons-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_id !=3D NULL)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot=
;Parameter --pkcs11-id cannot be used when --pkcs11-id-management is also s=
pecified=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (!options-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_id =
=3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
sg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          &quot;Parameter --pkcs11-id or --pkcs11-id-management should be s=
pecified=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  const char use_err[] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                &quot;Parameter --%s cannot be used when --pkcs11-prov=
ider is also specified=2E&quot;;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(priv=
_key_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(opti=
ons-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-k=
ey&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;m=
anagement-external-cert&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            MUST_BE_UNDEF(cryptoapi_cert, &quot;cryptoapicert&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_PKCS11 */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;cryptoapi_=
cert)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            const char use_e=
rr[] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   &quot;Parameter --%s cannot be used when --cryptoapicert is also specifi=
ed=2E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(priv_key_file, &quot;key=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            M=
UST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_f=
lags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(optio=
ns-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-c=
ert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if (options-&gt;pkcs12_file)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;P=
arameter --pkcs12 cannot be used with the mbed TLS version of OpenVPN=2E&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            const char use_err[]=
 =3D &quot;Parameter --%s cannot be used when --pkcs12 is also specified=2E=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MU=
ST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &quot;cert&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_U=
NDEF(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_flags &amp=
; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;ma=
nagement_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif       /* ifd=
ef ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  else /* cert/key from none of pkcs11, pkcs12, cryptoapi */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if ((options-&gt;management_flags &a=
mp; MF_EXTERNAL_KEY) &amp;&amp; options-&gt;priv_key_file)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;--key and -=
-management-external-key are mutually exclusive&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if ((options-&gt;management_flags &am=
p; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        if (options-&gt;cert_file)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    msg(M_USAGE, &quot;--cert and --management-ext=
ernal-cert are mutually exclusive&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                else if (!(options-&gt;management_flags &am=
p; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        &quot;--management-external-cert must be used=
 with --management-external-key&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (pull)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              const int sum =3D</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    ((options-&gt;cert_file !=3D NULL) || (option=
s-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    + ((options-&gt;priv_key_file=
 !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
             || (options-&gt;management_flags &amp; MF_EXTERNAL_KEY));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                if (sum =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    if (!options-&gt;au=
th_user_pass_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     msg(M_USAGE, &quot;No client-side authentication metho=
d is &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                           &quot;specified=2E  You must use either &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
              &quot;--cert/--key, --pkcs12, or &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                     &quot;=
--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               else if (sum !=3D 2)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    msg(M_USAGE, &quot;If you use one of --cert o=
r --key, you must use them both&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         if (!(options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    notnull(opti=
ons-&gt;cert_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                         &quot;certificate file (--cert) or PKCS#12 file (-=
-pkcs12)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    notnull(options=
-&gt;priv_key_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          &quot;private key file (--key) or PKCS#12 file (-=
-pkcs12)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ce-&gt;tls_auth_f=
ile &amp;&amp; ce-&gt;tls_crypt_file)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            msg(M_USAGE, &quot;--tls-auth and --tls-crypt are mutually =
exclusive&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (opti=
ons-&gt;tls_client &amp;&amp; ce-&gt;tls_crypt_v2_file</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (ce-&gt;tls_auth_fi=
le || ce-&gt;tls_crypt_file))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (options-&gt;pkcs11_providers[0])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (options-&gt;pkcs11_id_management &amp;&amp; op=
tions-&gt;pkcs11_id !=3D NULL)</span><br><span>         {</span><br><span> =
            msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                &quot;--tls-crypt-v2, --tls-auth and --tls-crypt are mut=
ually exclusive in client mode&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                &quot;Parameter --pkcs11-id cannot be us=
ed when --pkcs11-id-management is also specified=2E&quot;);</span><br><span=
>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * Make sure user doesn&#39;t specify any TLS options</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         * when in non-TLS=
 mode=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char use_err[] =3D &quot;Para=
meter %s can only be specified in TLS-mode, &quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                               &quot;i=2Ee=2E =
where --tls-server or --tls-client is also specified=2E&quot;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        MUST_BE_UNDEF(ca_file, &quot;ca&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ca_path=
, &quot;capath&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        MUST_BE_UNDEF(dh_file, &quot;dh&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!options-&gt;pkcs11_id_management =
&amp;&amp; options-&gt;pkcs11_id =3D=3D NULL)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(M_USAGE,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                &quot;Parameter --pkcs11-id or --pkcs1=
1-id-management should be specified=2E&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const char use_err[] =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;Parameter --%s cannot be us=
ed when --pkcs11-provider is also specified=2E&quot;;</span><br><span>     =
    MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span>         MU=
ST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>      =
   MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management=
_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(optio=
ns-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-c=
ert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef E=
NABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    MUST_BE_UNDEF(cryptoapi_cert, &quot;cryptoapicert&quot;);</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUS=
T_BE_UNDEF(cipher_list, &quot;tls-cipher&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(cipher_list_tls13, &quot;t=
ls-ciphersuites&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        MUST_BE_UNDEF(tls_cert_profile, &quot;tls-cert-profile&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tl=
s_verify, &quot;tls-verify&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        MUST_BE_UNDEF(tls_export_peer_cert_dir, &quot;tls-expo=
rt-cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  MUST_BE_UNDEF(verify_x509_name, &quot;verify-x509-name&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_timeou=
t, &quot;tls-timeout&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        MUST_BE_UNDEF(renegotiate_bytes, &quot;reneg-bytes&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(r=
enegotiate_packets, &quot;reneg-pkts&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_seconds, &quot;ren=
eg-sec&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 MUST_BE_UNDEF(handshake_window, &quot;hand-window&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(transition_windo=
w, &quot;tran-window&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        MUST_BE_UNDEF(tls_auth_file, &quot;tls-auth&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_cryp=
t_file, &quot;tls-crypt&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        MUST_BE_UNDEF(tls_crypt_v2_file, &quot;tls-crypt-v2&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UND=
EF(single_session, &quot;single-session&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(push_peer_info, &quot;push-=
peer-info&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    MUST_BE_UNDEF(tls_exit, &quot;tls-exit&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(crl_file, &quot;crl-veri=
fy&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUS=
T_BE_UNDEF(ns_cert_type, &quot;ns-cert-type&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(remote_cert_ku[0], &q=
uot;remote-cert-ku&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        MUST_BE_UNDEF(remote_cert_eku, &quot;remote-cert-eku&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PKCS11</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pk=
cs11_providers[0], &quot;pkcs11-providers&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_private_mode[0], &=
quot;pkcs11-private-mode&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        MUST_BE_UNDEF(pkcs11_id, &quot;pkcs11-id&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_=
id_management, &quot;pkcs11-id-management&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif /* ifdef ENABLE_PKCS11 */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (options-&gt;cryptoapi_cert)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const char use_err[] =3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;Parameter --%s c=
annot be used when --cryptoapicert is also specified=2E&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cert_file,=
 &quot;cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(pkcs12_file, &quot=
;pkcs12&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot=
;management-external-key&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EX=
TERNAL_CERT, &quot;management-external-cert&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span> #endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (options-&gt;pkcs12_file)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Parameter --pkcs12 cann=
ot be used with the mbed TLS version of OpenVPN=2E&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const char use_err[] =3D &quot;Parameter -=
-%s cannot be used when --pkcs12 is also specified=2E&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(ca_path, &qu=
ot;capath&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(priv_key_file, &quot;ke=
y&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MU=
ST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;manag=
ement-external-key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL=
_CERT, &quot;management-external-cert&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else /* cert/key from none of pkcs11=
, pkcs12, cryptoapi */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
((options-&gt;management_flags &amp; MF_EXTERNAL_KEY) &amp;&amp; options-&g=
t;priv_key_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_USAGE, &quot;--key and --management-external-key are mutually exclusiv=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((options=
-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (options-&gt;cert_file)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot;--cert and=
 --management-external-cert are mutually exclusive&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else if (!(options-&gt;manage=
ment_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                msg(M_USAGE,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    &quot;--management-external-cert must=
 be used with --management-external-key&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span>         if (pull)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(M_USAGE, use_err, &quot;--pull&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const int sum =3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ((options-&gt;c=
ert_file !=3D NULL) || (options-&gt;management_flags &amp; MF_EXTERNAL_CERT=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                +=
 ((options-&gt;priv_key_file !=3D NULL)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                   || (options-&gt;management_flags &am=
p; MF_EXTERNAL_KEY));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (s=
um =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (!options-&gt;auth_user_pass_file)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    msg(M_USAGE, &quot;No client-side au=
thentication method is &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                 &quot;specified=2E  You must use=
 either &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                            &quot;--cert/--key, --pkcs12, or &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
      &quot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            else if (sum !=3D 2)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                msg(M_USAGE, &quot;If you use one of --cert=
 or --key, you must use them both&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (!(options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                notnull(options-&gt;cert=
_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           &quot;certificate file (--cert) or PKCS#12 file (--pkcs12)&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!(optio=
ns-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                notnull(options-&gt;priv_key_file,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  &quot;private key file (--key) or PKCS#12 file (--pkcs12)&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (ce-&gt;tls_auth_file &amp;&amp; ce-&gt;tls_crypt_f=
ile)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;--=
tls-auth and --tls-crypt are mutually exclusive&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (options-&gt;tls_client &amp;&amp; ce-&gt;tls_=
crypt_v2_file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; (ce-&gt;tls_auth_file || ce-&gt;tls_crypt_file))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_USAGE,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;--tls-crypt-v2, --tls-auth a=
nd --tls-crypt are mutually exclusive in client mode&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     if (options-&gt;auth_user_pass_file &amp;&amp=
; !options-&gt;pull)</span><br><span>     {</span><br><span>         msg(M_=
USAGE, &quot;--auth-user-pass requires --pull&quot;);</span><br><span>@@ -6=
957,32 +6891,6 @@</span><br><span>             goto err;</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else if (streq(p[0], &quot;secret&quot;) &amp;&amp; p[1] &amp=
;&amp; !p[3])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quo=
t;DEPRECATED OPTION: The option --secret is deprecated=2E&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P=
_GENERAL | OPT_P_INLINE);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        options-&gt;shared_secret_file =3D p[1];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;shared_secret_file_inli=
ne =3D is_inline;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (!is_inline &amp;&amp; p[2])</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            int key_direction;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  key_direction =3D ascii2keydirection(msglevel, p[2]);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (key_direction &gt;=3D 0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;ke=
y_direction =3D key_direction;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;allow-deprec=
ated-insecure-static-crypto&quot;))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        options-&gt;allow_deprecated_insecure_static_cryp=
to =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span>     else if (streq(p[0], &quot;genkey&quot;) &amp;&amp; !p[4]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
ENERAL);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn=
/options=2Eh</span><br><span>index c58530a=2E=2E129267f 100644</span><br><s=
pan>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=
=2Eh</span><br><span>@@ -569,9 +569,6 @@</span><br><span>     struct static=
_challenge_info sc_info;</span><br><span> #endif</span><br><span>     /* Ci=
pher parms */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t char *shared_secret_file;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    bool shared_secret_file_inline;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    bool allow_deprecated_insecure_static_crypto;</span=
><br><span>     int key_direction;</span><br><span>     const char *ciphern=
ame;</span><br><span>     bool enable_ncp_fallback; /**&lt; If defined fall=
 back to</span><br><span>diff --git a/src/openvpn/options_show=2Ec b/src/op=
envpn/options_show=2Ec</span><br><span>index 80d36f0=2E=2E321a37b 100644</s=
pan><br><span>--- a/src/openvpn/options_show=2Ec</span><br><span>+++ b/src/=
openvpn/options_show=2Ec</span><br><span>@@ -491,7 +491,6 @@</span><br><spa=
n>     }</span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(shared_secret_file);</span=
><br><span>     SHOW_PARM(key_direction, keydirection2ascii(o-&gt;key_direc=
tion, false, true), &quot;%s&quot;);</span><br><span>     SHOW_STR(cipherna=
me);</span><br><span>     SHOW_STR(ncp_ciphers);</span><br><span>diff --git=
 a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec</span><b=
r><span>index cfc0595=2E=2E2fd90dd 100644</span><br><span>--- a/src/openvpn=
/options_string=2Ec</span><br><span>+++ b/src/openvpn/options_string=2Ec</s=
pan><br><span>@@ -140,83 +140,72 @@</span><br><span>     /*</span><br><span=
>      * Crypto Options</span><br><span>      */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (o-&gt;shared_secret_file || TLS_CLIENT |=
| TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct key_type kt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT((TLS_CLIEN=
T =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=3D 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Skip resolving BF-CBC to allow SSL libraries without =
BF-CBC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to wor=
k here in the default configuration */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *ciphername =3D o-&gt;ciphername;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t keysize =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(o-&gt;ciphername, &quot;B=
F-CBC&quot;) =3D=3D 0)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct key_type kt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ASSERT((o-&gt;shared_secret_file !=3D NULL) + (TLS_CLIEN=
T =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=3D 1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* Skip resolving BF-CBC to allow SSL libraries without =
BF-CBC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * to w=
ork here in the default configuration */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        const char *ciphername =3D o-&gt;ciphername;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        size_t keysize =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (strcmp(o-&gt;ciphername,=
 &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        init_key_type(&amp;kt, &quot;none&quot;, o-&gt;authname,=
 false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key=
size =3D 128;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        init_key_type(&amp;kt, o-&gt;cipherna=
me, o-&gt;authname, false);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ciphername =3D cipher_kt_name(kt=2Ecipher);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (cipher_defined(o-&gt;ci=
phername))</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            init_key_type(&amp;kt, &quot;none&quot;, o-&gt;=
authname, true, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            keysize =3D 128;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            init_key_typ=
e(&amp;kt, o-&gt;ciphername, o-&gt;authname, true, false);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            ciphername =3D cipher_kt_n=
ame(kt=2Ecipher);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (cipher_defined(o-&gt;ciphername))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                keysize =3D cipher_kt_key_size(kt=2Ecipher)=
 * 8;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* Only announce the cipher =
to our peer if we are willing to</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         * support it */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (p2p_nopull || tls_item_in_cipher_list(ciphername,=
 o-&gt;ncp_ciphers))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            b=
uf_printf(&amp;out, &quot;,cipher %s&quot;, ciphername);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,auth %s&quot;, m=
d_kt_name(kt=2Edigest));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        buf_printf(&amp;out, &quot;,keysize %zu&quot;, keysize);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;shared_secr=
et_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&a=
mp;out, &quot;,secret&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;</spa=
n><br><span>         }</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Only announce the cipher to our peer if we=
 are willing to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * support it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (p2p_nopull || tls_item_in_cipher_list(ciphername, o-&gt;ncp_ciphers))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot=
;,cipher %s&quot;, ciphername);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out,=
 &quot;,keysize %zu&quot;, keysize);</span><br><span> </span><br><span>    =
 /*</span><br><span>      * SSL Options</span><br><span>      */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;ce=2Etls_auth_fi=
le)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (o-&gt;ce=2Etls_auth_file)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-auth&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Not addi=
ng tls-crypt here, because we won&#39;t reach this code if</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-             * tls-auth/tls-crypt does=
 not match=2E  Removing tls-auth here would</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-             * break stuff, so leaving that in place=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_p=
rintf(&amp;out, &quot;,tls-auth&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Not adding tls-crypt here, because we won&#39;t reach this cod=
e if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * tls-auth=
/tls-crypt does not match=2E  Removing tls-auth here would</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * break stuff, so leaving that =
in place=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            buf_printf(&amp;out, &quot;,key-method %d&quot;, KEY=
_METHOD_2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;=
out, &quot;,key-method %d&quot;, KEY_METHOD_2);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (remote)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (remote)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (TLS_CLIENT)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (TLS_CLIENT)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quo=
t;,tls-server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    else if (TLS_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,tls-s=
erver&quot;);</span><br><span>         }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else if (TLS_SERVER)</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (TLS_CLIENT)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp=
;out, &quot;,tls-client&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            else if (TLS_SERVER)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                buf_printf(&amp;out, &quot;,tls-server&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &q=
uot;,tls-client&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (TLS_CLIENT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,tls-client&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (TLS_S=
ERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(=
&amp;out, &quot;,tls-server&quot;);</span><br><span>         }</span><br><s=
pan>     }</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index ddee3eb=2E=2E55043e5 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -1644,7 +1644,7 @@</span><br><span>         r=
eturn true;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;session-&gt;opt-&gt;=
key_type, options-&gt;ciphername, options-&gt;authname, true, true);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;ses=
sion-&gt;opt-&gt;key_type, options-&gt;ciphername, options-&gt;authname, tr=
ue);</span><br><span> </span><br><span>     bool packet_id_long_form =3D ci=
pher_kt_mode_ofb_cfb(session-&gt;opt-&gt;key_type=2Ecipher);</span><br><spa=
n>     session-&gt;opt-&gt;crypto_flags &amp;=3D ~(CO_PACKET_ID_LONG_FORM);=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/te=
sts/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index 07c54b4=2E=2Ed=
de4ef5 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br>=
<span>@@ -237,70 +237,58 @@</span><br><span>     /* common defaults */</spa=
n><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span>     o=2Ece=2Ep=
roto =3D PROTO_UDP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    o=2Etls_client =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    o=2Epull =3D true;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* No crypto at all */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /*  auth none, cipher none */</span>=
<br><span>     o=2Eciphername =3D &quot;none&quot;;</span><br><span>     o=
=2Eauthname =3D &quot;none&quot;;</span><br><span>     linkmtu =3D calc_opt=
ions_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    assert_int_equal(linkmtu, 1400);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1405);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* S=
tatic key OCC examples */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    o=2Eshared_secret_file =3D &quot;not null&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* secret, auth none, cipher none */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    o=2Eciphername =3D &quot;none&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eauthname =3D &q=
uot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    li=
nkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1408);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* secret, cipher AES-128-CBC, auth none */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher AES-1=
28-CBC, auth none */</span><br><span>     o=2Eciphername =3D &quot;AES-128-=
CBC&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><b=
r><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkm=
tu, 1440);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(linkmtu, 1437);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* secret, cipher none, auth SHA256 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher none, auth SHA=
256 */</span><br><span>     o=2Eciphername =3D &quot;none&quot;;</span><br>=
<span>     o=2Eauthname =3D &quot;SHA256&quot;;</span><br><span>     linkmt=
u =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1440);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkm=
tu, 1437);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* secret, cipher BF-CBC, auth SHA1 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SHA1 */</span><br>=
<span>     o=2Eciphername =3D &quot;BF-CBC&quot;;</span><br><span>     o=2E=
authname =3D &quot;SHA1&quot;;</span><br><span>     linkmtu =3D calc_option=
s_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_int_equal(linkmtu, 1444);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1441);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secre=
t, cipher BF-CBC, auth SHA1, tcp-client */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SHA1, tcp-client */</span=
><br><span>     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;</span><br><span>     l=
inkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1446);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(li=
nkmtu, 1443);</span><br><span> </span><br><span>     o=2Ece=2Eproto =3D PRO=
TO_UDP;</span><br><span> </span><br><span> #if defined(USE_COMP)</span><br>=
<span>     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp-lzo yes, cipher=
 BF-CBC, auth SHA1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*  comp-lzo yes, cipher BF-CBC, auth SHA1 */</span><br><span>     li=
nkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1445);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(lin=
kmtu, 1442);</span><br><span> </span><br><span> #if defined(ENABLE_FRAGMENT=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp-=
lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* comp-lzo yes, cipher BF-CBC, auth =
SHA1, fragment 1200 */</span><br><span>     o=2Ece=2Efragment =3D 1200;</sp=
an><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(=
linkmtu, 1449);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(linkmtu, 1446);</span><br><span>     o=2Ece=2Efragment =3D=
 0;</span><br><span> #endif</span><br><span> </span><br><span>     o=2Ecomp=
=2Ealg =3D COMP_ALG_UNDEF;</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS mode */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Etls_clie=
nt =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Ep=
ull =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */</sp=
an><br><span>     o=2Eauthname =3D &quot;SHA1&quot;;</span><br><span>     o=
=2Eciphername =3D &quot;AES-128-CBC&quot;;</span><br><span>@@ -358,50 +346,=
48 @@</span><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span>     =
o=2Ece=2Emssfix =3D 1000;</span><br><span>     o=2Ece=2Eproto =3D PROTO_UDP=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=2Etls_client=
 =3D true;</span><br><span> </span><br><span>     /* No crypto at all */</s=
pan><br><span>     o=2Eciphername =3D &quot;none&quot;;</span><br><span>   =
  o=2Eauthname =3D &quot;none&quot;;</span><br><span>     struct key_type k=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&=
amp;kt, o=2Eciphername, o=2Eauthname, false, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername=
, o=2Eauthname, false);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* No encryption, just packet id (8) + TCP payload(=
20) + IP payload(20) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* No encryption, just packet id (4) + opcode (1) + TCP payload(20)=
 + IP payload(20) */</span><br><span>     frame_calculate_dynamic(&amp;f, &=
amp;kt, &amp;o, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_int_equal(f=2Emss_fix, 952);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(f=2Emss_fix, 955);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Static key =
OCC examples */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
=2Eshared_secret_file =3D &quot;not null&quot;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* secret, auth none, cipher none */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* auth none, cipher none */</span><br><span>=
     o=2Eciphername =3D &quot;none&quot;;</span><br><span>     o=2Eauthname=
 =3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false, false);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp=
;kt, o=2Eciphername, o=2Eauthname, false);</span><br><span>     frame_calcu=
late_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_int_equal(f=2Emss_fix, 952);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(f=2Emss_fix=
, 955);</span><br><span> </span><br><span>     /* secret, cipher AES-128-CB=
C, auth none */</span><br><span>     o=2Eciphername =3D &quot;AES-128-CBC&q=
uot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciph=
ername, o=2Eauthname, false, false);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, f=
alse);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    for (int i =3D 990; i &lt;=3D 1010; i++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (int i =3D 990; i &lt;=3D 1015; i++)</s=
pan><br><span>     {</span><br><span>         /* 992 - 1008 should end up w=
ith the same mssfix value all they</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         * all result in the same CBC block size/padding and &=
lt;=3D 991 and &gt;=3D1008</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * all result in the same CBC block size/padding and &lt;=3D=
 992 and &gt;=3D1009</span><br><span>          * should be one block less a=
nd more respectively */</span><br><span>         o=2Ece=2Emssfix =3D i;</sp=
an><br><span>         frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (i &lt;=
=3D 991)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(i &lt;=3D 992)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 911);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_int_equ=
al(f=2Emss_fix, 915);</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        else if (i &gt;=3D 1008)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else if (i &gt;=3D 1009)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            assert_int_equal(f=2Emss_fix, 943);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix, 94=
7);</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   assert_int_equal(f=2Emss_fix, 927);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix, 931);</span><b=
r><span>         }</span><br><span>     }</span><br><span> #ifdef USE_COMP<=
/span><br><span>@@ -413,33 +399,32 @@</span><br><span>     for (int i =3D 9=
90; i &lt;=3D 1010; i++)</span><br><span>     {</span><br><span>         /*=
 992 - 1008 should end up with the same mssfix value all they</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * all result in the same C=
BC block size/padding and &lt;=3D 991 and &gt;=3D1008</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * all result in the same CBC blo=
ck size/padding and &lt;=3D 992 and &gt;=3D1009</span><br><span>          *=
 should be one block less and more respectively */</span><br><span>        =
 o=2Ece=2Emssfix =3D i;</span><br><span>         frame_calculate_dynamic(&a=
mp;f, &amp;kt, &amp;o, NULL);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (i &lt;=3D 991)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (i &lt;=3D 992)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_int_equal=
(f=2Emss_fix, 910);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            assert_int_equal(f=2Emss_fix, 914);</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (i &gt=
;=3D 1008)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse if (i &gt;=3D 1009)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 942)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            assert=
_int_equal(f=2Emss_fix, 946);</span><br><span>         }</span><br><span>  =
       else</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 926);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=
=2Emss_fix, 930);</span><br><span>         }</span><br><span>     }</span><=
br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;</span><br><span> #endif /*=
 ifdef USE_COMP */</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* tls client, auth SHA1, cipher AES-256-GCM */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /*  auth SHA1, cipher AE=
S-256-GCM */</span><br><span>     o=2Eauthname =3D &quot;SHA1&quot;;</span>=
<br><span>     o=2Eciphername =3D &quot;AES-256-GCM&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    o=2Etls_client =3D true;</span><br=
><span>     o=2Epeer_id =3D 77;</span><br><span>     o=2Euse_peer_id =3D tr=
ue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(=
&amp;kt, o=2Eciphername, o=2Eauthname, true, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername=
, o=2Eauthname, false);</span><br><span> </span><br><span>     for (int i =
=3D 900; i &lt;=3D 1200; i++)</span><br><span>     {</span><br><span>@@ -68=
5,7 +670,7 @@</span><br><span> </span><br><span>     data-&gt;gc =3D gc_new=
();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    init_key_type(&amp;data-&gt;kt, &quot;AES-128-GCM&quot;, &quot;none&quo=
t;, true, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  init_key_type(&amp;data-&gt;kt, &quot;AES-128-GCM&quot;, &quot;none&quot;=
, false);</span><br><span> </span><br><span>     /* have an epoch key that =
uses 0x23 for the key for all bytes */</span><br><span>     struct epoch_ke=
y epoch1send =3D { =2Eepoch =3D 1, =2Eepoch_key =3D { 0x23 } };</span><br><=
span>@@ -907,7 +892,7 @@</span><br><span>     struct epoch_key e17 =3D { =
=2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 } };</span><br><span>     struct=
 key_type kt =3D { 0 };</span><br><span>     struct key_parameters key_para=
meters =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
init_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;none&quot;, true, fal=
se);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_ty=
pe(&amp;kt, &quot;AES-192-GCM&quot;, &quot;none&quot;, false);</span><br><s=
pan> </span><br><span> </span><br><span>     epoch_data_key_derive(&amp;key=
_parameters, &amp;e17, &amp;kt);</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br>=
<span>index fbbb40f=2E=2E49ba833 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_pkt=2Ec</span><br><span>@@ -173,7 +173,7 @@</span><br><span>     tas=2Etl=
s_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</=
span><br><span> </span><br><span>     struct key_type tls_crypt_kt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;tls_cr=
ypt_kt, &quot;none&quot;, &quot;SHA1&quot;, true, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;tls_crypt_kt, =
&quot;none&quot;, &quot;SHA1&quot;, false);</span><br><span> </span><br><sp=
an>     crypto_read_openvpn_key(&amp;tls_crypt_kt, &amp;tas=2Etls_wrap=2Eop=
t=2Ekey_ctx_bi, static_key, true,</span><br><span>                         =
    key_direction, &quot;Control Channel Authentication&quot;, &quot;tls-au=
th&quot;, NULL);</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af=
55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--qrYF5cLqXiI=--


--===============2385081209887385750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2385081209887385750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2385081209887385750==--

