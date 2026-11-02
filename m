Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1026606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RqzVtBWJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZY8VuUwU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lWtnK2X/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZweeDveq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jXNUS+yO6LBQD+iNXGeTDukHrSLqLhc6Wrg3QEVzTWA=; b=RqzVtBWJ0YFkFgJRkERs+erKJO
	BTNUCGf4SEXbuzSxZWST8ZlRSE5Sd9N9jcDPOk+8/N8ZdiM1lgQmWH8E5fWEqiJwuhpnV1jlM8TjT
	/02G1HqAI7+6j1CxNfUPxv44qYILEhijnlkTeZVa4U8EooD3AWaVU5cfUatSUCDeduXA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNs1e-000000006OL-3ClN;
	Mon, 02 Nov 2026 13:24:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNs1d-000000006OD-15Yg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oFbUYDyNUPm5HWpMFST3aopJolBaHZaCKiCvz+fvEtA=; b=ZY8VuUwU2TWK6fSiNHjgqxM/6r
 ZRLuGbAWc++i7MHKhuFeYlg8/cUoDqD07rNVAa2ZPAYQru5oAcqEyCBnuuua1LRy7Ihwe6gsvKjLC
 ne2AxQ2Cho8j7DGqKbvD3k+l6T2HihLrpxUSHKV31BN4PtwL6NFZU6ejQR0dYNOQWpFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oFbUYDyNUPm5HWpMFST3aopJolBaHZaCKiCvz+fvEtA=; b=lWtnK2X/Qo+dTAm4xEadu9x6xj
 A9sgUtpQHe0smk07fsZ5/Z1CdQ8SAGEVaVhBUviK6kbZNtNhQn3va3kWrVmNiLv+3DnF6hke5y02q
 +PMKfT2n7IklCQfIVPd/C+lCLm6UiYUknOvxXsOB37uVQfosPr9waNkXjsh+kPMaAELg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNs1X-000000008G0-01NX for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:24:37 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so32038485e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625864; x=1794230664; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oFbUYDyNUPm5HWpMFST3aopJolBaHZaCKiCvz+fvEtA=;
 b=ZweeDveqDz+SxJs2xq1cYij1k0aI1NUkXEJ1eH+P5g2krbgEtZ83tTbKkBQF0nykyB
 Kchk7tTAW09Mp0g/qXrKGRRpohUFSSSy+ROkEE5kibI7g0Viq66PTm1ZJ+Hbm9C5Ixwt
 VZoMiRcFw5Q5tSTGPRMSv2PXMiX+WlSSd89goFi+HeuE9B+4uAHyghfcb6iOe6dXd7Y6
 ouvnlMQoZK/g22aGC8R4GRnjZoK2gFaUyBS5OJpZggWxBaj8yDs2XTUi40Apx6yU2wVH
 oBe3L65wmskwu300ihh1xGsahJ4a//ZEZVvqV+6sXHRXw8kjAAZupbMwd2uKNKk0bLh3
 6k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625864; x=1794230664;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oFbUYDyNUPm5HWpMFST3aopJolBaHZaCKiCvz+fvEtA=;
 b=AiTxQa05Pnka4NbRiWx2g4OUm5lolYB0uii5/sDBax8C9tJqMu3eYx9QFW4gnkJbBi
 4+IMwfFOZjGnldA/JqokyjvcOsIXkYN0NPJGMIRxm+HDMexC2Ii6rr2lbH4eH6w2ky7Z
 RjF6WUa5xfU6YvpXyU+j+75AtlS6Rh4C71Yrn1RiCDNI9Zjz6gnrTcpOCv7isvISBFfm
 zSMM16jf8Nz0RqOcbnnhLy8iXNPpMY/KIHaqF8ppDhDGFoGsPz2ivoBLy07q0HlBhVPy
 arBrOotqfI/Bt87nsZWqpcA7QCE5wZDkwf7hlktTxkBH/HjbErWDm5uDLOLhtJ+zCBW6
 hhng==
X-Gm-Message-State: AFq9FYJihGb/B2ylzVr8ItPcgaGGPJQzRibEQY11/wkpYgF+6ViFqRU5
 QYm+ljKIYOeb2Ov0XJfxmrd4vF4ZPZ2sWmhCFBMek6JEBXJxgWGMNqQGJ+DS3LZhmV9GSEINHLj
 pqCivaGDKVPwn408QOOY/lBP75wwVjLpzvxuRCxotiMUlacBhRmH+zOJvnplQKA2MaoIW15Q3xn
 eaLYE1hw==
X-Gm-Gg: AYBFou1TxfFDyJ+NXCOo8DWxpW1BXbchCaGWEyw1FjZwBnfh5GzJUPAifzTtrID8faK
 9QdEIULx9xFlQ/cNkaRVG+95MCI0YOoUYPwbOxzJSaV9XbcOCgNVM3jo/pJy0bcSwVP9qQM2Uwf
 P6p3WO0y+NQbFHDjW7qIE51NbVgVpZp6deurGRQf7UGgOgtFZWQwOSGTW3JYj0q9j8tEqByBQ/v
 fRaxjZ+Oel2ZBnyJZsiV5FMLMcRI4tfKAtlF3nETv2jTuermgP8adqUhFmUWTaJgspTlIBSB0dF
 wRFGnjaX+E0ua8+3NI0b3nrqEouX8gQxr/0RhXPE1C9bGyYPYVBOxoq4RK77BxpxlGd7Ya/gDli
 jYl7IZ791MN04+EJuOrDnSLjQAY6YDJBTyMgDvKI4SgAyyCpSCUNij9QDY2vxs33B/I7MlmhCsw
 zdhXHiEIKQeLjtZbREc2e13oBPcmldcqEnzXhB7qW6Cz41bYAaDtIrnwRuQlx9jolu6a9qDCtcZ
 At0IahbIzQpE5KdaUAm4E1PD2iKJyPRHGoMvTt3nB3Lj95x0s4E0Dajtq+qgykqmVO1rCHj5K0V
 MbJMQ0ZthrmYbk2J5gOND3UoRFRsfXxRWGLaTqZQfj5CPQFxqy36DL3hDeglxl6Iw/vE9QzeYcl
 AV3ac6FgZ0J5bpBYp+MkrGTxS+jlSfbKv26QyaQkeAvQBL/L5bg3m3sb9S4vu4UVgWkdnC5XaWT
 qI741M2aBVsk1v9Q==
X-Received: by 2002:a05:600c:a012:b0:4a1:d675:b031 with SMTP id
 5b1f17b1804b1-4ac17b2bc4dmr228177905e9.6.1793625863710; 
 Mon, 02 Nov 2026 05:24:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b286a0sm228543655e9.4.2026.11.02.05.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:24:22 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:24:19 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: a2a2cc01358e3a525aeec49707cd02330e0a3924
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4def29c4b1e0e83078d3d708c2ae588bc0e06cc9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNs1X-000000008G0-01NX
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
Content-Type: multipart/mixed; boundary="===============4151949775463477115=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4151949775463477115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oGXZ6N7Ug9o="; charset=UTF-8

--oGXZ6N7Ug9o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Hello Frank Lic=
htenheld, 

I'd like you to reexamine a change=2E Please visit

    https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail

to look at the new pa=
tch set (#3)=2E

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
M src/openvpn/optio=
ns_string=2Eh
M src/openvpn/ssl=2Ec
M tests/unit_tests/openvpn/test_crypto=
=2Ec
M tests/unit_tests/openvpn/test_pkt=2Ec
18 files changed, 246 insertio=
ns(+), 507 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/81/2081/3

diff --git a/Changes=2Emd b/Changes=2Emd
index=
 b5ae881=2E=2Edd12391 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6=
 +23,13 @@
   the characters mentioned above were already escaped=2E Howeve=
r, the behavior of
   Mbed TLS is slightly different from OpenSSL in that i=
t also escapes "=3D"=2E
 
+* **`secret` has been removed**
+
+  Static key =
mode (non-TLS) is no longer considered "good and secure enough" for
+  toda=
y's requirements=2E Use TLS mode instead=2E If deploying a PKI CA is consid=
ered
+  "too complicated", using `--peer-fingerprint` makes TLS mode about =
as easy as
+  using `--secret`=2E
+ 
 ## Maintainer-visible changes
 
 - Th=
e configure-time option `--enable-debug` is no longer  available
diff --git=
 a/INSTALL b/INSTALL
index 486b1ae=2E=2Ed0ffaf0 100644
--- a/INSTALL
+++ b/=
INSTALL
@@ -144,8 +144,7 @@
 
 Test Crypto:
 
-=2E/openvpn --genkey secret =
key
-=2E/openvpn --test-crypto --secret key
+=2E/openvpn --test-crypto
 
 T=
est SSL/TLS negotiations (runs for 2 minutes):
 
diff --git a/doc/man-secti=
ons/protocol-options=2Erst b/doc/man-sections/protocol-options=2Erst
index =
52ce5a8=2E=2Eb785ebe 100644
--- a/doc/man-sections/protocol-options=2Erst
+=
++ b/doc/man-sections/protocol-options=2Erst
@@ -212,11 +212,6 @@
   have b=
een configured with ``--enable-small``
   (typically used on routers or oth=
er embedded devices)=2E
 
-
---allow-deprecated-insecure-static-crypto
-   =
**DEPRECATED** This allow using OpenVPN without TLS=2E This is deprecated
-=
   and will be removed in OpenVPN 2=2E8=2E
-
 --tran-window n
   Transition=
 window -- our old key can live this many seconds after a new
   a key rene=
gotiation begins (default :code:`3600` seconds)=2E This feature
diff --git =
a/doc/man-sections/unsupported-options=2Erst b/doc/man-sections/unsupported=
-options=2Erst
index c273905=2E=2E0bb5e4b 100644
--- a/doc/man-sections/uns=
upported-options=2Erst
+++ b/doc/man-sections/unsupported-options=2Erst
@@ =
-70,3 +70,9 @@
   Removed in OpenVPN 2=2E8=2E This option caused the Mbed T=
LS 3 random number
   generator to be reseeded on every call=2E It has been=
 removed because this
   is excessive=2E
+
+--secret
+  Removed in OpenVPN =
2=2E8=2E Static encryption without a transient key
+  (generated by DH or E=
CDH) has been considered problematic for many
+  years=2E Please use ``--pe=
er-fingerprint`` and self-signed certificates
+  for small setups=2E
diff -=
-git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2E=
c
index 83654b2=2E=2E90dbb4e 100644
--- a/src/openvpn/check_file_access=2Ec=

+++ b/src/openvpn/check_file_access=2Ec
@@ -312,10 +312,6 @@
             =
                             ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2")=
;
     }
 
-    errs |=3D
-        check_file_access_inline(options->shared=
_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                       =
          options->shared_secret_file, R_OK, "--secret");
-
     errs |=3D =
check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_fil=
e,
                               R_OK | W_OK, "--replay-persist");
 
diff =
--git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index ff17b22=2E=2E=
d375273 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@=
 -872,7 +872,7 @@
  * Build a struct key_type=2E
  */
 void
-init_key_type(=
struct key_type *kt, const char *ciphername, const char *authname, bool tls=
_mode,
+init_key_type(struct key_type *kt, const char *ciphername, const ch=
ar *authname,
               bool warn)
 {
     bool aead_cipher =3D false;=

@@ -891,9 +891,9 @@
 
         /* check legal cipher mode */
         aead=
_cipher =3D cipher_kt_mode_aead(kt->cipher);
-        if (!(cipher_kt_mode_=
cbc(kt->cipher) || (tls_mode && aead_cipher)
+        if (!(cipher_kt_mode_=
cbc(kt->cipher) || aead_cipher
 #ifdef ENABLE_OFB_CFB_MODE
-              |=
| (tls_mode && cipher_kt_mode_ofb_cfb(kt->cipher))
+              || cipher=
_kt_mode_ofb_cfb(kt->cipher)
 #endif
                   ))
         {
diff =
--git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index dbe0802=2E=2E=
203f77b 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@=
 -420,11 +420,9 @@
  * @param kt          The struct key_type to initialize=

  * @param ciphername  The name of the cipher to use
  * @param authname  =
  The name of the HMAC digest to use
- * @param tls_mode    Specifies wheth=
er we are running in TLS mode, which allows
- *                    more cip=
hers than static key mode=2E
  * @param warn        Print warnings when nul=
l cipher / auth is used=2E
  */
-void init_key_type(struct key_type *kt, co=
nst char *ciphername, const char *authname, bool tls_mode,
+void init_key_t=
ype(struct key_type *kt, const char *ciphername, const char *authname,
    =
                bool warn);
 
 /*
diff --git a/src/openvpn/helper=2Ec b/src=
/openvpn/helper=2Ec
index d29895b=2E=2E6b5fcee6 100644
--- a/src/openvpn/he=
lper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -266,12 +266,6 @@
             msg=
(M_USAGE, "--server and --server-bridge cannot be used together");
        =
 }
 
-        if (o->shared_secret_file)
-        {
-            msg(M_USAG=
E,
-                "--server and --secret cannot be used together (you mus=
t use SSL/TLS keys)");
-        }
-
         if (!(o->server_flags & SF_NOP=
OOL) && o->ifconfig_pool_defined)
         {
             msg(M_USAGE,
@@ -=
461,12 +455,6 @@
                 "--server-bridge already defines an ifcon=
fig-pool, so you can't also specify --ifconfig-pool explicitly");
         =
}
 
-        if (o->shared_secret_file)
-        {
-            msg(M_USAGE=
,
-                "--server-bridge and --secret cannot be used together (y=
ou must use SSL/TLS keys)");
-        }
-
         if (dev !=3D DEV_TYPE_TA=
P)
         {
             msg(M_USAGE, "--server-bridge directive only mak=
es sense with --dev tap");
diff --git a/src/openvpn/init=2Ec b/src/openvpn/=
init=2Ec
index 24cf532=2E=2E9299c4f 100644
--- a/src/openvpn/init=2Ec
+++ b=
/src/openvpn/init=2Ec
@@ -996,35 +996,10 @@
         platform_mlockall(true=
);
     }
 
-    /*
-     * We do not want user to use --genkey with --secr=
et=2E In the transistion
-     * phase we for secret=2E
-     */
-    if (o=
ptions->genkey && options->genkey_type !=3D GENKEY_SECRET && options->share=
d_secret_file)
-    {
-        msg(M_USAGE, "Using --genkey type with --sec=
ret filename is "
-                     "not supported=2E  Use --genkey typ=
e filename instead=2E");
-    }
     if (options->genkey && options->genkey=
_type =3D=3D GENKEY_SECRET)
     {
         int nbits_written;
         con=
st char *genkey_filename =3D options->genkey_filename;
-        if (options=
->shared_secret_file && options->genkey_filename)
-        {
-            m=
sg(M_USAGE, "You must provide a filename to either --genkey "
-            =
             "or --secret, not both");
-        }
-
-        /*
-         *=
 Copy filename from shared_secret_file to genkey_filename to support
-     =
    * the old --genkey --secret foo=2Efile syntax=2E
-         */
-        =
if (options->shared_secret_file)
-        {
-            msg(M_WARN, "WARNI=
NG: Using --genkey --secret filename is "
-                        "DEPRECA=
TED=2E  Use --genkey secret filename instead=2E");
-            genkey_file=
name =3D options->shared_secret_file;
-        }
 
         nbits_written =
=3D write_key_file(2, genkey_filename);
         if (nbits_written < 0)
@@ =
-1033,7 +1008,7 @@
         }
 
         msg(D_GENKEY | M_NOPREFIX, "Random=
ly generated %d bit key written to %s", nbits_written,
-            options=
->shared_secret_file);
+            options->genkey_filename ? options->gen=
key_filename : "stdout");
         return true;
     }
     else if (option=
s->genkey && options->genkey_type =3D=3D GENKEY_TLS_CRYPTV2_SERVER)
@@ -107=
9,7 +1054,7 @@
     /* sanity check on options for --mktun or --rmtun */
  =
   notnull(options->dev, "TUN/TAP device (--dev)");
     if (options->ce=2E=
remote || options->ifconfig_local || options->ifconfig_remote_netmask
-    =
    || options->shared_secret_file || options->tls_server || options->tls_c=
lient)
+        || options->tls_server || options->tls_client)
     {
     =
    msg(M_FATAL | M_OPTERR,
             "options --mktun or --rmtun should=
 only be used together with --dev");
@@ -3011,8 +2986,7 @@
     ASSERT(!key=
_ctx_bi_defined(&c->c1=2Eks=2Estatic_key));
 
     /* Init cipher and hash =
algorithm */
-    init_key_type(&c->c1=2Eks=2Ekey_type, options->ciphername=
, options->authname,
-                  options->test_crypto, true);
+    i=
nit_key_type(&c->c1=2Eks=2Ekey_type, options->ciphername, options->authname=
, true);
 
     generate_test_crypto_random_key(&c->c1=2Eks=2Ekey_type, &c-=
>c1=2Eks=2Estatic_key,
                                     "test crypto ke=
y");
@@ -3022,50 +2996,6 @@
 }
 
 /*
- * Static Key Mode (using a pre-share=
d key)
- */
-static void
-do_init_crypto_static(struct context *c, const un=
signed int flags)
-{
-    const struct options *options =3D &c->options;
- =
   ASSERT(options->shared_secret_file);
-
-    init_crypto_pre(c, flags);
-=

-    /* Initialize flags */
-    if (c->options=2Emute_replay_warnings)
- =
   {
-        c->c2=2Ecrypto_options=2Eflags |=3D CO_MUTE_REPLAY_WARNINGS;
=
-    }
-
-    /* Initialize packet ID tracking */
-    packet_id_init(&c->c=
2=2Ecrypto_options=2Epacket_id, options->replay_window, options->replay_tim=
e,
-                   "STATIC", 0);
-    c->c2=2Ecrypto_options=2Epid_pers=
ist =3D &c->c1=2Epid_persist;
-    c->c2=2Ecrypto_options=2Eflags |=3D CO_P=
ACKET_ID_LONG_FORM;
-    packet_id_persist_load_obj(&c->c1=2Epid_persist, &=
c->c2=2Ecrypto_options=2Epacket_id);
-
-    if (!key_ctx_bi_defined(&c->c1=
=2Eks=2Estatic_key))
-    {
-        /* Get cipher & hash algorithms */
-  =
      init_key_type(&c->c1=2Eks=2Ekey_type, options->ciphername, options->a=
uthname,
-                      options->test_crypto, true);
-
-        /* =
Read cipher and hmac keys from shared secret file */
-        crypto_read_o=
penvpn_key(&c->c1=2Eks=2Ekey_type, &c->c1=2Eks=2Estatic_key,
-             =
                   options->shared_secret_file, options->shared_secret_file=
_inline,
-                                options->key_direction, "Static K=
ey Encryption", "secret", NULL);
-    }
-    else
-    {
-        msg(M_INF=
O, "Re-using pre-shared static key");
-    }
-
-    /* Get key schedule */
=
-    c->c2=2Ecrypto_options=2Ekey_ctx_bi =3D c->c1=2Eks=2Estatic_key;
-}
-
=
-/*
  * Initialize the tls-auth/crypt key context
  */
 static void
@@ -320=
4,7 +3134,7 @@
 
         /* Do not warn if the cipher is used only in OCC =
*/
         bool warn =3D options->enable_ncp_fallback;
-        init_key_t=
ype(&c->c1=2Eks=2Ekey_type, ciphername, options->authname, true, warn);
+  =
      init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, options->authname, =
warn);
 
         /* initialize tls-auth/crypt/crypt-v2 key */
         do_=
init_tls_wrap_key(c);
@@ -3492,41 +3422,6 @@
     }
 }
 
-/*
- * No encrypt=
ion or authentication=2E
- */
-static void
-do_init_crypto_none(struct cont=
ext *c)
-{
-    ASSERT(!c->options=2Etest_crypto);
-
-    /* Initialise key=
_type with auth/cipher "none", so the key_type struct is
-     * valid */
-=
    init_key_type(&c->c1=2Eks=2Ekey_type, "none", "none", c->options=2Etest=
_crypto, true);
-
-    msg(M_WARN, "******* WARNING *******: All encryption=
 and authentication features "
-                "disabled -- All data will =
be tunnelled as clear text and will not be "
-                "protected ag=
ainst man-in-the-middle changes=2E "
-                "PLEASE DO RECONSIDER=
 THIS CONFIGURATION!");
-}
-
-static void
-do_init_crypto(struct context *c=
, const unsigned int flags)
-{
-    if (c->options=2Eshared_secret_file)
- =
   {
-        do_init_crypto_static(c, flags);
-    }
-    else if (c->opti=
ons=2Etls_server || c->options=2Etls_client)
-    {
-        do_init_crypto=
_tls(c, flags);
-    }
-    else /* no encryption or authentication=2E */
-=
    {
-        do_init_crypto_none(c);
-    }
-}
-
 static void
 do_init_fr=
ame(struct context *c)
 {
@@ -4564,7 +4459,7 @@
         {
             cry=
pto_flags =3D CF_INIT_TLS_MULTI;
         }
-        do_init_crypto(c, cryp=
to_flags);
+        do_init_crypto_tls(c, crypto_flags);
         if (IS_SI=
G(c) && !child)
         {
             goto sig;
diff --git a/src/openvpn/=
mtu=2Ec b/src/openvpn/mtu=2Ec
index f3c2874=2E=2E5ce40c8 100644
--- a/src/o=
penvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -51,7 +51,6 @@
 unsigned int
 c=
alc_packet_id_size_dc(const struct options *options, const struct key_type =
*kt)
 {
-    bool tlsmode =3D options->tls_server || options->tls_client;
 =
    bool epoch =3D options->imported_protocol_flags & CO_EPOCH_DATA_KEY_FOR=
MAT;
 
     /* epoch format uses a 64-bit packet id: 16 bit epoch + 48 bit =
per-epoch counter */
@@ -60,7 +59,7 @@
         return sizeof(uint64_t);
  =
   }
 
-    bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb=
(kt->cipher);
+    bool packet_id_long_form =3D cipher_kt_mode_ofb_cfb(kt->=
cipher);
 
     return packet_id_size(packet_id_long_form);
 }
@@ -72,8 +71=
,6 @@
     /* Sum of all the overhead that reduces the usable packet size *=
/
     size_t header_size =3D 0;
 
-    bool tlsmode =3D options->tls_serve=
r || options->tls_client;
-
     /* A socks proxy adds extra header to each=
 packet
      * (we only support Socks with IPv4, this value is different f=
or IPv6) */
     if (options->ce=2Esocks_proxy_server && proto_is_udp(optio=
ns->ce=2Eproto))
@@ -88,10 +85,7 @@
     }
 
     /* Add the opcode and pee=
rid */
-    if (tlsmode)
-    {
-        header_size +=3D options->use_peer=
_id ? 4 : 1;
-    }
+    header_size +=3D options->use_peer_id ? 4 : 1;
 
 =
    unsigned int pkt_id_size =3D calc_packet_id_size_dc(options, kt);
 
@@ =
-156,13 +150,6 @@
 {
     struct key_type occ_kt;
 
-    /* neither --secre=
t nor TLS mode */
-    if (!o->tls_client && !o->tls_server && !o->shared_s=
ecret_file)
-    {
-        init_key_type(&occ_kt, "none", "none", false, f=
alse);
-        return frame_calculate_payload_size(frame, o, &occ_kt);
-  =
  }
-
     /* o->ciphername might be BF-CBC even though the underlying SSL =
library
      * does not support it=2E For this reason we workaround this c=
orner case
      * by pretending to have no encryption enabled and by manua=
lly adding
@@ -184,9 +171,7 @@
         ciphername =3D "none";
     }
 
-  =
  /* We pass tlsmode always true here since as we do not need to check if
-=
     * the ciphers are actually valid for non tls in occ calucation */
-   =
 init_key_type(&occ_kt, ciphername, o->authname, true, false);
+    init_ke=
y_type(&occ_kt, ciphername, o->authname, false);
 
     size_t payload =3D =
frame_calculate_payload_size(frame, o, &occ_kt);
     overhead +=3D frame_c=
alculate_protocol_header_size(&occ_kt, o, true);
diff --git a/src/openvpn/o=
ptions=2Ec b/src/openvpn/options=2Ec
index 8e0c602=2E=2E386f412 100644
--- =
a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1587,6 +1587,10=
 @@
 static void
 options_postprocess_verify_ce(const struct options *optio=
ns, const struct connection_entry *ce)
 {
+    if (options->test_crypto)
+ =
   {
+        return;
+    }
     struct options defaults;
     int dev =3D=
 DEV_TYPE_UNDEF;
     bool pull =3D false;
@@ -2012,27 +2016,9 @@
     /*
 =
     * SSL/TLS mode sanity checks=2E
      */
-    if (options->tls_server =
+ options->tls_client + (options->shared_secret_file !=3D NULL) > 1)
+    i=
f (options->tls_server + options->tls_client + options->test_crypto !=3D 1)=

     {
-        msg(M_USAGE, "specify only one of --tls-server, --tls-clie=
nt, or --secret");
-    }
-
-    if (!options->tls_server && !options->tls_=
client && !options->test_crypto)
-    {
-        msglvl_t msglevel =3D M_US=
AGE;
-        if (options->allow_deprecated_insecure_static_crypto)
-      =
  {
-            msglevel =3D M_INFO;
-        }
-
-        msg(msglevel, "=
DEPRECATION: No tls-client or tls-server option in "
-                     =
 "configuration detected=2E OpenVPN 2=2E8 will remove the "
-              =
        "functionality to run a VPN without TLS=2E "
-                     =
 "See the examples section in the manual page for "
-                      =
"examples of a similar quick setup with peer-fingerprint=2E "
-            =
          "OpenVPN 2=2E7 allows using this configuration when using "
-    =
                  "--allow-deprecated-insecure-static-crypto but you should=
 move "
-                      "to a proper configuration using TLS as soon=
 as possible=2E");
+        msg(M_USAGE, "OpenVPN configuration must use ei=
ther --tls-server or --tls-client");
     }
 
     if (options->ssl_flags &=
 (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
@@ -2052,188 =
+2038,136 @@
         msg(M_USAGE, "--tls-version-min bigger than --tls-ver=
sion-max");
     }
 
-    if (options->tls_server || options->tls_client)
-=
    {
-        check_ca_required(options);
+
+    check_ca_required(options=
);
 #ifdef ENABLE_PKCS11
-        if (!options->pkcs11_providers[0] && opti=
ons->pkcs11_id)
-        {
-            msg(M_WARN, "Option pkcs11-id is ig=
nored as no pkcs11-providers are specified");
-        }
-        else if (=
!options->pkcs11_providers[0] && options->pkcs11_id_management)
-        {
=
-            msg(M_WARN,
-                "Option pkcs11-id-management is i=
gnored as no pkcs11-providers are specified");
-        }
+    if (!options=
->pkcs11_providers[0] && options->pkcs11_id)
+    {
+        msg(M_WARN, "O=
ption pkcs11-id is ignored as no pkcs11-providers are specified");
+    }
+=
    else if (!options->pkcs11_providers[0] && options->pkcs11_id_management=
)
+    {
+        msg(M_WARN,
+            "Option pkcs11-id-management is =
ignored as no pkcs11-providers are specified");
+    }
 
-        if (optio=
ns->pkcs11_providers[0])
-        {
-            if (options->pkcs11_id_man=
agement && options->pkcs11_id !=3D NULL)
-            {
-                ms=
g(M_USAGE,
-                    "Parameter --pkcs11-id cannot be used when =
--pkcs11-id-management is also specified=2E");
-            }
-            =
if (!options->pkcs11_id_management && options->pkcs11_id =3D=3D NULL)
-    =
        {
-                msg(M_USAGE,
-                    "Parameter --p=
kcs11-id or --pkcs11-id-management should be specified=2E");
-            }=

-            const char use_err[] =3D
-                "Parameter --%s can=
not be used when --pkcs11-provider is also specified=2E";
-            MUST=
_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "ke=
y");
-            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
-            MUST_B=
E_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-k=
ey");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CE=
RT, "management-external-cert");
-#ifdef ENABLE_CRYPTOAPI
-            MUST=
_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
-#endif
-        }
-        els=
e
-#endif /* ifdef ENABLE_PKCS11 */
-#ifdef ENABLE_CRYPTOAPI
-            i=
f (options->cryptoapi_cert)
-        {
-            const char use_err[] =
=3D
-                "Parameter --%s cannot be used when --cryptoapicert is=
 also specified=2E";
-            MUST_BE_UNDEF(cert_file, "cert");
-      =
      MUST_BE_UNDEF(priv_key_file, "key");
-            MUST_BE_UNDEF(pkcs1=
2_file, "pkcs12");
-            MUST_BE_FALSE(options->management_flags & M=
F_EXTERNAL_KEY, "management-external-key");
-            MUST_BE_FALSE(opti=
ons->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
-   =
     }
-        else
-#endif
-            if (options->pkcs12_file)
-      =
  {
-#ifdef ENABLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter --pk=
cs12 cannot be used with the mbed TLS version of OpenVPN=2E");
-#else
-    =
        const char use_err[] =3D "Parameter --%s cannot be used when --pkcs=
12 is also specified=2E";
-            MUST_BE_UNDEF(ca_path, "capath");
- =
           MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(pri=
v_key_file, "key");
-            MUST_BE_FALSE(options->management_flags & =
MF_EXTERNAL_KEY, "management-external-key");
-            MUST_BE_FALSE(opt=
ions->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
-#e=
ndif       /* ifdef ENABLE_CRYPTO_MBEDTLS */
-        }
-        else /* ce=
rt/key from none of pkcs11, pkcs12, cryptoapi */
-        {
-            if=
 ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
=
-            {
-                msg(M_USAGE, "--key and --management-extern=
al-key are mutually exclusive");
-            }
-            if ((options->=
management_flags & MF_EXTERNAL_CERT))
-            {
-                if (o=
ptions->cert_file)
-                {
-                    msg(M_USAGE, "--=
cert and --management-external-cert are mutually exclusive");
-            =
    }
-                else if (!(options->management_flags & MF_EXTERNAL_K=
EY))
-                {
-                    msg(M_USAGE,
-                =
        "--management-external-cert must be used with --management-external=
-key");
-                }
-            }
-            if (pull)
-         =
   {
-                const int sum =3D
-                    ((options->cer=
t_file !=3D NULL) || (options->management_flags & MF_EXTERNAL_CERT))
-     =
               + ((options->priv_key_file !=3D NULL)
-                     =
  || (options->management_flags & MF_EXTERNAL_KEY));
-
-                if =
(sum =3D=3D 0)
-                {
-                    if (!options->auth_u=
ser_pass_file)
-                    {
-                        msg(M_USAGE,=
 "No client-side authentication method is "
-                              =
       "specified=2E  You must use either "
-                              =
       "--cert/--key, --pkcs12, or "
-                                     =
"--auth-user-pass");
-                    }
-                }
-           =
     else if (sum !=3D 2)
-                {
-                    msg(M_USA=
GE, "If you use one of --cert or --key, you must use them both");
-        =
        }
-            }
-            else
-            {
-                =
if (!(options->management_flags & MF_EXTERNAL_CERT))
-                {
-  =
                  notnull(options->cert_file,
-                            =
"certificate file (--cert) or PKCS#12 file (--pkcs12)");
-                }=

-                if (!(options->management_flags & MF_EXTERNAL_KEY))
-    =
            {
-                    notnull(options->priv_key_file,
-       =
                     "private key file (--key) or PKCS#12 file (--pkcs12)")=
;
-                }
-            }
-        }
-        if (ce->tls_auth_fi=
le && ce->tls_crypt_file)
-        {
-            msg(M_USAGE, "--tls-auth =
and --tls-crypt are mutually exclusive");
-        }
-        if (options->=
tls_client && ce->tls_crypt_v2_file
-            && (ce->tls_auth_file || c=
e->tls_crypt_file))
+    if (options->pkcs11_providers[0])
+    {
+        =
if (options->pkcs11_id_management && options->pkcs11_id !=3D NULL)
        =
 {
             msg(M_USAGE,
-                "--tls-crypt-v2, --tls-auth a=
nd --tls-crypt are mutually exclusive in client mode");
+                "P=
arameter --pkcs11-id cannot be used when --pkcs11-id-management is also spe=
cified=2E");
         }
-    }
-    else
-    {
-        /*
-         * Mak=
e sure user doesn't specify any TLS options
-         * when in non-TLS mod=
e=2E
-         */
-
-        const char use_err[] =3D "Parameter %s can onl=
y be specified in TLS-mode, "
-                               "i=2Ee=2E whe=
re --tls-server or --tls-client is also specified=2E";
-
-        MUST_BE_U=
NDEF(ca_file, "ca");
-        MUST_BE_UNDEF(ca_path, "capath");
-        MU=
ST_BE_UNDEF(dh_file, "dh");
+        if (!options->pkcs11_id_management && =
options->pkcs11_id =3D=3D NULL)
+        {
+            msg(M_USAGE,
+     =
           "Parameter --pkcs11-id or --pkcs11-id-management should be speci=
fied=2E");
+        }
+        const char use_err[] =3D
+            "Param=
eter --%s cannot be used when --pkcs11-provider is also specified=2E";
    =
     MUST_BE_UNDEF(cert_file, "cert");
         MUST_BE_UNDEF(priv_key_file=
, "key");
-#ifndef ENABLE_CRYPTO_MBEDTLS
         MUST_BE_UNDEF(pkcs12_file=
, "pkcs12");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL=
_KEY, "management-external-key");
+        MUST_BE_FALSE(options->managemen=
t_flags & MF_EXTERNAL_CERT, "management-external-cert");
+#ifdef ENABLE_CRY=
PTOAPI
+        MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
 #endif
-  =
      MUST_BE_UNDEF(cipher_list, "tls-cipher");
-        MUST_BE_UNDEF(ciph=
er_list_tls13, "tls-ciphersuites");
-        MUST_BE_UNDEF(tls_cert_profile=
, "tls-cert-profile");
-        MUST_BE_UNDEF(tls_verify, "tls-verify");
- =
       MUST_BE_UNDEF(tls_export_peer_cert_dir, "tls-export-cert");
-       =
 MUST_BE_UNDEF(verify_x509_name, "verify-x509-name");
-        MUST_BE_UNDE=
F(tls_timeout, "tls-timeout");
-        MUST_BE_UNDEF(renegotiate_bytes, "r=
eneg-bytes");
-        MUST_BE_UNDEF(renegotiate_packets, "reneg-pkts");
- =
       MUST_BE_UNDEF(renegotiate_seconds, "reneg-sec");
-        MUST_BE_UN=
DEF(handshake_window, "hand-window");
-        MUST_BE_UNDEF(transition_win=
dow, "tran-window");
-        MUST_BE_UNDEF(tls_auth_file, "tls-auth");
-  =
      MUST_BE_UNDEF(tls_crypt_file, "tls-crypt");
-        MUST_BE_UNDEF(tl=
s_crypt_v2_file, "tls-crypt-v2");
-        MUST_BE_UNDEF(single_session, "s=
ingle-session");
-        MUST_BE_UNDEF(push_peer_info, "push-peer-info");
=
-        MUST_BE_UNDEF(tls_exit, "tls-exit");
-        MUST_BE_UNDEF(crl_fi=
le, "crl-verify");
-        MUST_BE_UNDEF(ns_cert_type, "ns-cert-type");
- =
       MUST_BE_UNDEF(remote_cert_ku[0], "remote-cert-ku");
-        MUST_BE=
_UNDEF(remote_cert_eku, "remote-cert-eku");
-#ifdef ENABLE_PKCS11
-        =
MUST_BE_UNDEF(pkcs11_providers[0], "pkcs11-providers");
-        MUST_BE_UN=
DEF(pkcs11_private_mode[0], "pkcs11-private-mode");
-        MUST_BE_UNDEF(=
pkcs11_id, "pkcs11-id");
-        MUST_BE_UNDEF(pkcs11_id_management, "pkcs=
11-id-management");
+    }
+    else
+#endif /* ifdef ENABLE_PKCS11 */
+#if=
def ENABLE_CRYPTOAPI
+        if (options->cryptoapi_cert)
+    {
+        =
const char use_err[] =3D
+            "Parameter --%s cannot be used when -=
-cryptoapicert is also specified=2E";
+        MUST_BE_UNDEF(cert_file, "ce=
rt");
+        MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_UNDEF(=
pkcs12_file, "pkcs12");
+        MUST_BE_FALSE(options->management_flags & =
MF_EXTERNAL_KEY, "management-external-key");
+        MUST_BE_FALSE(options=
->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
+    }
=
+    else
 #endif
-
+        if (options->pkcs12_file)
+    {
+#ifdef ENABL=
E_CRYPTO_MBEDTLS
+        msg(M_USAGE, "Parameter --pkcs12 cannot be used w=
ith the mbed TLS version of OpenVPN=2E");
+#else
+        const char use_er=
r[] =3D "Parameter --%s cannot be used when --pkcs12 is also specified=2E";=

+        MUST_BE_UNDEF(ca_path, "capath");
+        MUST_BE_UNDEF(cert_fil=
e, "cert");
+        MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_=
FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key=
");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "m=
anagement-external-cert");
+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */
+   =
 }
+    else /* cert/key from none of pkcs11, pkcs12, cryptoapi */
+    {
+=
        if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_=
key_file)
+        {
+            msg(M_USAGE, "--key and --management-exte=
rnal-key are mutually exclusive");
+        }
+        if ((options->manage=
ment_flags & MF_EXTERNAL_CERT))
+        {
+            if (options->cert_f=
ile)
+            {
+                msg(M_USAGE, "--cert and --management-=
external-cert are mutually exclusive");
+            }
+            else if=
 (!(options->management_flags & MF_EXTERNAL_KEY))
+            {
+         =
       msg(M_USAGE,
+                    "--management-external-cert must b=
e used with --management-external-key");
+            }
+        }
        =
 if (pull)
         {
-            msg(M_USAGE, use_err, "--pull");
+      =
      const int sum =3D
+                ((options->cert_file !=3D NULL) ||=
 (options->management_flags & MF_EXTERNAL_CERT))
+                + ((optio=
ns->priv_key_file !=3D NULL)
+                   || (options->management_fl=
ags & MF_EXTERNAL_KEY));
+
+            if (sum =3D=3D 0)
+            {
+ =
               if (!options->auth_user_pass_file)
+                {
+     =
               msg(M_USAGE, "No client-side authentication method is "
+   =
                              "specified=2E  You must use either "
+       =
                          "--cert/--key, --pkcs12, or "
+                  =
               "--auth-user-pass");
+                }
+            }
+    =
        else if (sum !=3D 2)
+            {
+                msg(M_USAGE, "=
If you use one of --cert or --key, you must use them both");
+            }=

+        }
+        else
+        {
+            if (!(options->management=
_flags & MF_EXTERNAL_CERT))
+            {
+                notnull(options=
->cert_file,
+                        "certificate file (--cert) or PKCS#12=
 file (--pkcs12)");
+            }
+            if (!(options->management_f=
lags & MF_EXTERNAL_KEY))
+            {
+                notnull(options->p=
riv_key_file,
+                        "private key file (--key) or PKCS#12=
 file (--pkcs12)");
+            }
         }
     }
+    if (ce->tls_auth_=
file && ce->tls_crypt_file)
+    {
+        msg(M_USAGE, "--tls-auth and --=
tls-crypt are mutually exclusive");
+    }
+    if (options->tls_client && =
ce->tls_crypt_v2_file
+        && (ce->tls_auth_file || ce->tls_crypt_file)=
)
+    {
+        msg(M_USAGE,
+            "--tls-crypt-v2, --tls-auth and=
 --tls-crypt are mutually exclusive in client mode");
+    }
+
+
     if (o=
ptions->auth_user_pass_file && !options->pull)
     {
         msg(M_USAGE,=
 "--auth-user-pass requires --pull");
@@ -6957,32 +6891,6 @@
             g=
oto err;
         }
     }
-    else if (streq(p[0], "secret") && p[1] && !=
p[3])
-    {
-        msg(M_WARN, "DEPRECATED OPTION: The option --secret i=
s deprecated=2E");
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE)=
;
-        options->shared_secret_file =3D p[1];
-        options->shared_s=
ecret_file_inline =3D is_inline;
-        if (!is_inline && p[2])
-        =
{
-            int key_direction;
-
-            key_direction =3D ascii2ke=
ydirection(msglevel, p[2]);
-            if (key_direction >=3D 0)
-       =
     {
-                options->key_direction =3D key_direction;
-        =
    }
-            else
-            {
-                goto err;
-        =
    }
-        }
-    }
-    else if (streq(p[0], "allow-deprecated-insecur=
e-static-crypto"))
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-     =
   options->allow_deprecated_insecure_static_crypto =3D true;
-    }
     e=
lse if (streq(p[0], "genkey") && !p[4])
     {
         VERIFY_PERMISSION(O=
PT_P_GENERAL);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh
index c58530a=2E=2E129267f 100644
--- a/src/openvpn/options=2Eh
+++ b/=
src/openvpn/options=2Eh
@@ -569,9 +569,6 @@
     struct static_challenge_in=
fo sc_info;
 #endif
     /* Cipher parms */
-    const char *shared_secret_=
file;
-    bool shared_secret_file_inline;
-    bool allow_deprecated_insec=
ure_static_crypto;
     int key_direction;
     const char *ciphername;
   =
  bool enable_ncp_fallback; /**< If defined fall back to
diff --git a/src/o=
penvpn/options_show=2Ec b/src/openvpn/options_show=2Ec
index 80d36f0=2E=2E3=
21a37b 100644
--- a/src/openvpn/options_show=2Ec
+++ b/src/openvpn/options_=
show=2Ec
@@ -491,7 +491,6 @@
     }
 #endif
 
-    SHOW_STR_INLINE(shared_s=
ecret_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direct=
ion, false, true), "%s");
     SHOW_STR(ciphername);
     SHOW_STR(ncp_ciph=
ers);
diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_str=
ing=2Ec
index cfc0595=2E=2E2fd90dd 100644
--- a/src/openvpn/options_string=
=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -140,83 +140,72 @@
     /*
   =
   * Crypto Options
      */
-    if (o->shared_secret_file || TLS_CLIENT |=
| TLS_SERVER)
+    struct key_type kt;
+
+    ASSERT((TLS_CLIENT =3D=3D tru=
e) + (TLS_SERVER =3D=3D true) <=3D 1);
+
+    /* Skip resolving BF-CBC to a=
llow SSL libraries without BF-CBC
+     * to work here in the default confi=
guration */
+    const char *ciphername =3D o->ciphername;
+    size_t keys=
ize =3D 0;
+
+    if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
     {
-   =
     struct key_type kt;
-
-        ASSERT((o->shared_secret_file !=3D NULL=
) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
-
-       =
 /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
-         *=
 to work here in the default configuration */
-        const char *cipherna=
me =3D o->ciphername;
-        size_t keysize =3D 0;
-
-        if (strcmp(=
o->ciphername, "BF-CBC") =3D=3D 0)
+        init_key_type(&kt, "none", o->a=
uthname, false);
+        keysize =3D 128;
+    }
+    else
+    {
+       =
 init_key_type(&kt, o->ciphername, o->authname, false);
+        ciphername=
 =3D cipher_kt_name(kt=2Ecipher);
+        if (cipher_defined(o->ciphername=
))
         {
-            init_key_type(&kt, "none", o->authname, true, fa=
lse);
-            keysize =3D 128;
-        }
-        else
-        {
-  =
          init_key_type(&kt, o->ciphername, o->authname, true, false);
-   =
         ciphername =3D cipher_kt_name(kt=2Ecipher);
-            if (ciphe=
r_defined(o->ciphername))
-            {
-                keysize =3D ciphe=
r_kt_key_size(kt=2Ecipher) * 8;
-            }
-        }
-        /* Only =
announce the cipher to our peer if we are willing to
-         * support it=
 */
-        if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_c=
iphers))
-        {
-            buf_printf(&out, ",cipher %s", ciphername)=
;
-        }
-        buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest))=
;
-        buf_printf(&out, ",keysize %zu", keysize);
-        if (o->share=
d_secret_file)
-        {
-            buf_printf(&out, ",secret");
+      =
      keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;
         }
     }
+ =
   /* Only announce the cipher to our peer if we are willing to
+     * sup=
port it */
+    if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->nc=
p_ciphers))
+    {
+        buf_printf(&out, ",cipher %s", ciphername);
+  =
  }
+    buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest));
+    buf_pr=
intf(&out, ",keysize %zu", keysize);
 
     /*
      * SSL Options
      */=

+    if (o->ce=2Etls_auth_file)
     {
-        if (TLS_CLIENT || TLS_SERV=
ER)
-        {
-            if (o->ce=2Etls_auth_file)
-            {
-    =
            buf_printf(&out, ",tls-auth");
-            }
-            /* N=
ot adding tls-crypt here, because we won't reach this code if
-            =
 * tls-auth/tls-crypt does not match=2E  Removing tls-auth here would
-    =
         * break stuff, so leaving that in place=2E */
+        buf_printf(=
&out, ",tls-auth");
+    }
+    /* Not adding tls-crypt here, because we wo=
n't reach this code if
+     * tls-auth/tls-crypt does not match=2E  Removi=
ng tls-auth here would
+     * break stuff, so leaving that in place=2E */
=
 
-            buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-        }=

+    buf_printf(&out, ",key-method %d", KEY_METHOD_2);
 
-        if (remo=
te)
+
+    if (remote)
+    {
+        if (TLS_CLIENT)
         {
-        =
    if (TLS_CLIENT)
-            {
-                buf_printf(&out, ",tls-=
server");
-            }
-            else if (TLS_SERVER)
-            {
-=
                buf_printf(&out, ",tls-client");
-            }
+          =
  buf_printf(&out, ",tls-server");
         }
-        else
+        else i=
f (TLS_SERVER)
         {
-            if (TLS_CLIENT)
-            {
-    =
            buf_printf(&out, ",tls-client");
-            }
-            el=
se if (TLS_SERVER)
-            {
-                buf_printf(&out, ",tls-s=
erver");
-            }
+            buf_printf(&out, ",tls-client");
+    =
    }
+    }
+    else
+    {
+        if (TLS_CLIENT)
+        {
+        =
    buf_printf(&out, ",tls-client");
+        }
+        else if (TLS_SERVE=
R)
+        {
+            buf_printf(&out, ",tls-server");
         }
    =
 }
 
diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/options_stri=
ng=2Eh
index 02efed3=2E=2E6d5518a 100644
--- a/src/openvpn/options_string=
=2Eh
+++ b/src/openvpn/options_string=2Eh
@@ -59,7 +59,6 @@
  *
  * --ciphe=
r
  * --auth
- * --secret
  *
  * SSL Options:
  *
diff --git a/src/openvpn=
/ssl=2Ec b/src/openvpn/ssl=2Ec
index ddee3eb=2E=2E55043e5 100644
--- a/src/=
openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1644,7 +1644,7 @@
         re=
turn true;
     }
 
-    init_key_type(&session->opt->key_type, options->ci=
phername, options->authname, true, true);
+    init_key_type(&session->opt-=
>key_type, options->ciphername, options->authname, true);
 
     bool packe=
t_id_long_form =3D cipher_kt_mode_ofb_cfb(session->opt->key_type=2Ecipher);=

     session->opt->crypto_flags &=3D ~(CO_PACKET_ID_LONG_FORM);
diff --git=
 a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test=
_crypto=2Ec
index 07c54b4=2E=2Ebcc63db 100644
--- a/tests/unit_tests/openvp=
n/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -237,70=
 +237,58 @@
     /* common defaults */
     o=2Ece=2Etun_mtu =3D 1400;
    =
 o=2Ece=2Eproto =3D PROTO_UDP;
+    o=2Etls_client =3D true;
+    o=2Epull =
=3D true;
 
-    /* No crypto at all */
+    /*  auth none, cipher none */
=
     o=2Eciphername =3D "none";
     o=2Eauthname =3D "none";
     linkmtu =
=3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 14=
00);
+    assert_int_equal(linkmtu, 1405);
 
-    /* Static key OCC example=
s */
-    o=2Eshared_secret_file =3D "not null";
-
-    /* secret, auth non=
e, cipher none */
-    o=2Eciphername =3D "none";
-    o=2Eauthname =3D "no=
ne";
-    linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int=
_equal(linkmtu, 1408);
-
-    /* secret, cipher AES-128-CBC, auth none */
+=
    /* cipher AES-128-CBC, auth none */
     o=2Eciphername =3D "AES-128-CB=
C";
     o=2Eauthname =3D "none";
     linkmtu =3D calc_options_string_link=
_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1440);
+    assert_int_equal(l=
inkmtu, 1437);
 
-    /* secret, cipher none, auth SHA256 */
+    /* cipher=
 none, auth SHA256 */
     o=2Eciphername =3D "none";
     o=2Eauthname =3D=
 "SHA256";
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    asse=
rt_int_equal(linkmtu, 1440);
+    assert_int_equal(linkmtu, 1437);
 
-    /=
* secret, cipher BF-CBC, auth SHA1 */
+    /* cipher BF-CBC, auth SHA1 */
 =
    o=2Eciphername =3D "BF-CBC";
     o=2Eauthname =3D "SHA1";
     linkmtu=
 =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1=
444);
+    assert_int_equal(linkmtu, 1441);
 
-    /* secret, cipher BF-CBC=
, auth SHA1, tcp-client */
+    /* cipher BF-CBC, auth SHA1, tcp-client */
=
     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;
     linkmtu =3D calc_options_str=
ing_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1446);
+    assert_int=
_equal(linkmtu, 1443);
 
     o=2Ece=2Eproto =3D PROTO_UDP;
 
 #if defined(=
USE_COMP)
     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;
 
-    /* secret, comp-lzo =
yes, cipher BF-CBC, auth SHA1 */
+    /*  comp-lzo yes, cipher BF-CBC, auth=
 SHA1 */
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert=
_int_equal(linkmtu, 1445);
+    assert_int_equal(linkmtu, 1442);
 
 #if def=
ined(ENABLE_FRAGMENT)
-    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA=
1, fragment 1200 */
+    /* comp-lzo yes, cipher BF-CBC, auth SHA1, fragmen=
t 1200 */
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D calc_options_st=
ring_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1449);
+    assert_in=
t_equal(linkmtu, 1446);
     o=2Ece=2Efragment =3D 0;
 #endif
 
     o=2Eco=
mp=2Ealg =3D COMP_ALG_UNDEF;
 #endif
 
-    /* TLS mode */
-    o=2Eshared_=
secret_file =3D NULL;
-    o=2Etls_client =3D true;
-    o=2Epull =3D true;=

-
     /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */
     o=2E=
authname =3D "SHA1";
     o=2Eciphername =3D "AES-128-CBC";
@@ -315,15 +303=
,8 @@
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
     assert_in=
t_equal(linkmtu, 1457);
 
-    /* tls client, cipher none, auth none */
+  =
  /* tls client, auth none, cipher AES-256-GCM */
     o=2Eauthname =3D "no=
ne";
-    o=2Eciphername =3D "none";
-
-    linkmtu =3D calc_options_string=
_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1405);
-
-    /* tls clie=
nt, auth SHA1, cipher AES-256-GCM */
-    o=2Eauthname =3D "SHA1";
     o=
=2Eciphername =3D "AES-256-GCM";
     linkmtu =3D calc_options_string_link_=
mtu(&o, &f);
     assert_int_equal(linkmtu, 1449);
@@ -332,12 +313,12 @@
 #=
if defined(USE_COMP) && defined(ENABLE_FRAGMENT)
     o=2Ecomp=2Ealg =3D CO=
MP_ALG_LZO;
 
-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, =
comp-lzo yes */
+    /* tls client, auth none, cipher AES-256-GCM, fragment=
, comp-lzo yes */
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D calc_op=
tions_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1454);
 
-   =
 /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes, sock=
s */
+    /* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo =
yes, socks */
     o=2Ece=2Esocks_proxy_server =3D "socks=2Eexample=2Ecom";=

     linkmtu =3D calc_options_string_link_mtu(&o, &f);
     assert_int_equ=
al(linkmtu, 1464);
@@ -358,50 +339,48 @@
     o=2Ece=2Etun_mtu =3D 1400;
  =
   o=2Ece=2Emssfix =3D 1000;
     o=2Ece=2Eproto =3D PROTO_UDP;
+    o=2Etl=
s_client =3D true;
 
     /* No crypto at all */
     o=2Eciphername =3D "n=
one";
     o=2Eauthname =3D "none";
     struct key_type kt;
-    init_key_=
type(&kt, o=2Eciphername, o=2Eauthname, false, false);
+    init_key_type(&=
kt, o=2Eciphername, o=2Eauthname, false);
 
-    /* No encryption, just pac=
ket id (8) + TCP payload(20) + IP payload(20) */
+    /* No encryption, jus=
t packet id (4) + opcode (1) + TCP payload(20) + IP payload(20) */
     fra=
me_calculate_dynamic(&f, &kt, &o, NULL);
-    assert_int_equal(f=2Emss_fix,=
 952);
+    assert_int_equal(f=2Emss_fix, 955);
 
-    /* Static key OCC ex=
amples */
-    o=2Eshared_secret_file =3D "not null";
-
-    /* secret, aut=
h none, cipher none */
+    /* auth none, cipher none */
     o=2Eciphernam=
e =3D "none";
     o=2Eauthname =3D "none";
-    init_key_type(&kt, o=2Ecip=
hername, o=2Eauthname, false, false);
+    init_key_type(&kt, o=2Eciphernam=
e, o=2Eauthname, false);
     frame_calculate_dynamic(&f, &kt, &o, NULL);
-=
    assert_int_equal(f=2Emss_fix, 952);
+    assert_int_equal(f=2Emss_fix, =
955);
 
     /* secret, cipher AES-128-CBC, auth none */
     o=2Eciphernam=
e =3D "AES-128-CBC";
     o=2Eauthname =3D "none";
-    init_key_type(&kt, =
o=2Eciphername, o=2Eauthname, false, false);
+    init_key_type(&kt, o=2Eci=
phername, o=2Eauthname, false);
 
-    for (int i =3D 990; i <=3D 1010; i++=
)
+    for (int i =3D 990; i <=3D 1015; i++)
     {
         /* 992 - 1008 =
should end up with the same mssfix value all they
-         * all result in=
 the same CBC block size/padding and <=3D 991 and >=3D1008
+         * all =
result in the same CBC block size/padding and <=3D 992 and >=3D1009
       =
   * should be one block less and more respectively */
         o=2Ece=2Ems=
sfix =3D i;
         frame_calculate_dynamic(&f, &kt, &o, NULL);
-        i=
f (i <=3D 991)
+        if (i <=3D 992)
         {
-            assert_int_=
equal(f=2Emss_fix, 911);
+            assert_int_equal(f=2Emss_fix, 915);
 =
        }
-        else if (i >=3D 1008)
+        else if (i >=3D 1009)
   =
      {
-            assert_int_equal(f=2Emss_fix, 943);
+            asser=
t_int_equal(f=2Emss_fix, 947);
         }
         else
         {
-       =
     assert_int_equal(f=2Emss_fix, 927);
+            assert_int_equal(f=2E=
mss_fix, 931);
         }
     }
 #ifdef USE_COMP
@@ -413,33 +392,32 @@
   =
  for (int i =3D 990; i <=3D 1010; i++)
     {
         /* 992 - 1008 shoul=
d end up with the same mssfix value all they
-         * all result in the =
same CBC block size/padding and <=3D 991 and >=3D1008
+         * all resul=
t in the same CBC block size/padding and <=3D 992 and >=3D1009
          * =
should be one block less and more respectively */
         o=2Ece=2Emssfix =
=3D i;
         frame_calculate_dynamic(&f, &kt, &o, NULL);
-        if (i =
<=3D 991)
+        if (i <=3D 992)
         {
-            assert_int_equal=
(f=2Emss_fix, 910);
+            assert_int_equal(f=2Emss_fix, 914);
      =
   }
-        else if (i >=3D 1008)
+        else if (i >=3D 1009)
        =
 {
-            assert_int_equal(f=2Emss_fix, 942);
+            assert_int=
_equal(f=2Emss_fix, 946);
         }
         else
         {
-            =
assert_int_equal(f=2Emss_fix, 926);
+            assert_int_equal(f=2Emss_f=
ix, 930);
         }
     }
     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;
 #endif=
 /* ifdef USE_COMP */
 
-    /* tls client, auth SHA1, cipher AES-256-GCM *=
/
+    /*  auth SHA1, cipher AES-256-GCM */
     o=2Eauthname =3D "SHA1";
 =
    o=2Eciphername =3D "AES-256-GCM";
-    o=2Etls_client =3D true;
     o=
=2Epeer_id =3D 77;
     o=2Euse_peer_id =3D true;
-    init_key_type(&kt, o=
=2Eciphername, o=2Eauthname, true, false);
+    init_key_type(&kt, o=2Eciph=
ername, o=2Eauthname, false);
 
     for (int i =3D 900; i <=3D 1200; i++)
=
     {
@@ -685,7 +663,7 @@
 
     data->gc =3D gc_new();
 
-    init_key_ty=
pe(&data->kt, "AES-128-GCM", "none", true, false);
+    init_key_type(&data=
->kt, "AES-128-GCM", "none", false);
 
     /* have an epoch key that uses =
0x23 for the key for all bytes */
     struct epoch_key epoch1send =3D { =
=2Eepoch =3D 1, =2Eepoch_key =3D { 0x23 } };
@@ -907,7 +885,7 @@
     struc=
t epoch_key e17 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 } };
     =
struct key_type kt =3D { 0 };
     struct key_parameters key_parameters =3D=
 { 0 };
-    init_key_type(&kt, "AES-192-GCM", "none", true, false);
+    i=
nit_key_type(&kt, "AES-192-GCM", "none", false);
 
 
     epoch_data_key_de=
rive(&key_parameters, &e17, &kt);
diff --git a/tests/unit_tests/openvpn/tes=
t_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fbbb40f=2E=2E49ba83=
3 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests=
/openvpn/test_pkt=2Ec
@@ -173,7 +173,7 @@
     tas=2Etls_wrap=2Eopt=2Eflags=
 |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
 
     struct key_typ=
e tls_crypt_kt;
-    init_key_type(&tls_crypt_kt, "none", "SHA1", true, fal=
se);
+    init_key_type(&tls_crypt_kt, "none", "SHA1", false);
 
     crypt=
o_read_openvpn_key(&tls_crypt_kt, &tas=2Etls_wrap=2Eopt=2Ekey_ctx_bi, stati=
c_key, true,
                             key_direction, "Control Channel A=
uthentication", "tls-auth", NULL);

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Gerrit-Change=
-Number: 2081
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--oGXZ6N7Ug9o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"https://gerr=
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
tring=2Ec<br>M src/openvpn/options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>M=
 tests/unit_tests/openvpn/test_crypto=2Ec<br>M tests/unit_tests/openvpn/tes=
t_pkt=2Ec<br>18 files changed, 246 insertions(+), 507 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/81/2081/3</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><=
br><span>index b5ae881=2E=2Edd12391 100644</span><br><span>--- a/Changes=2E=
md</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,13 @@</s=
pan><br><span>   the characters mentioned above were already escaped=2E How=
ever, the behavior of</span><br><span>   Mbed TLS is slightly different fro=
m OpenSSL in that it also escapes &quot;=3D&quot;=2E</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+* **`secret` has been re=
moved**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  Static key mode (non-TLS) is =
no longer considered &quot;good and secure enough&quot; for</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  today&#39;s requirements=2E Use T=
LS mode instead=2E If deploying a PKI CA is considered</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &quot;too complicated&quot;, using `--=
peer-fingerprint` makes TLS mode about as easy as</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  using `--secret`=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ </span><br><span> ## Maintainer-visible =
changes</span><br><span> </span><br><span> - The configure-time option `--e=
nable-debug` is no longer  available</span><br><span>diff --git a/INSTALL b=
/INSTALL</span><br><span>index 486b1ae=2E=2Ed0ffaf0 100644</span><br><span>=
--- a/INSTALL</span><br><span>+++ b/INSTALL</span><br><span>@@ -144,8 +144,=
7 @@</span><br><span> </span><br><span> Test Crypto:</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --genkey secre=
t key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --te=
st-crypto --secret key</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+=2E/openvpn --test-crypto</span><br><span> </span><br><span> Test SSL/TL=
S negotiations (runs for 2 minutes):</span><br><span> </span><br><span>diff=
 --git a/doc/man-sections/protocol-options=2Erst b/doc/man-sections/protoco=
l-options=2Erst</span><br><span>index 52ce5a8=2E=2Eb785ebe 100644</span><br=
><span>--- a/doc/man-sections/protocol-options=2Erst</span><br><span>+++ b/=
doc/man-sections/protocol-options=2Erst</span><br><span>@@ -212,11 +212,6 @=
@</span><br><span>   have been configured with ``--enable-small``</span><br=
><span>   (typically used on routers or other embedded devices)=2E</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>---allow-deprecated-insecure-static-crypto</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   **DEPRECATED** This allow using OpenVPN withou=
t TLS=2E This is deprecated</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   and will be removed in OpenVPN 2=2E8=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> --tran-window n</span><br><spa=
n>   Transition window -- our old key can live this many seconds after a ne=
w</span><br><span>   a key renegotiation begins (default :code:`3600` secon=
ds)=2E This feature</span><br><span>diff --git a/doc/man-sections/unsupport=
ed-options=2Erst b/doc/man-sections/unsupported-options=2Erst</span><br><sp=
an>index c273905=2E=2E0bb5e4b 100644</span><br><span>--- a/doc/man-sections=
/unsupported-options=2Erst</span><br><span>+++ b/doc/man-sections/unsupport=
ed-options=2Erst</span><br><span>@@ -70,3 +70,9 @@</span><br><span>   Remov=
ed in OpenVPN 2=2E8=2E This option caused the Mbed TLS 3 random number</spa=
n><br><span>   generator to be reseeded on every call=2E It has been remove=
d because this</span><br><span>   is excessive=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+--secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  Removed in OpenVPN 2=2E8=2E Static encryption without a transient key</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  (generated by DH or E=
CDH) has been considered problematic for many</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  years=2E Please use ``--peer-fingerprint`` and =
self-signed certificates</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  for small setups=2E</span><br><span>diff --git a/src/openvpn/check_f=
ile_access=2Ec b/src/openvpn/check_file_access=2Ec</span><br><span>index 83=
654b2=2E=2E90dbb4e 100644</span><br><span>--- a/src/openvpn/check_file_acce=
ss=2Ec</span><br><span>+++ b/src/openvpn/check_file_access=2Ec</span><br><s=
pan>@@ -312,10 +312,6 @@</span><br><span>                                  =
        ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    errs |=3D</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        check_file_access_inline(options-&gt;shared_secret_file_inline=
, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                 options-&gt;shared_secret_file, =
R_OK, &quot;--secret&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     errs |=3D check_file_access(CHKACC_DIRPATH | C=
HKACC_FILEXSTWR, options-&gt;packet_id_file,</span><br><span>              =
                 R_OK | W_OK, &quot;--replay-persist&quot;);</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypt=
o=2Ec</span><br><span>index ff17b22=2E=2Ed375273 100644</span><br><span>---=
 a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</spa=
n><br><span>@@ -872,7 +872,7 @@</span><br><span>  * Build a struct key_type=
=2E</span><br><span>  */</span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-init_key_type(struct key_type *kt, const char *cip=
hername, const char *authname, bool tls_mode,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+init_key_type(struct key_type *kt, const char *ci=
phername, const char *authname,</span><br><span>               bool warn)</=
span><br><span> {</span><br><span>     bool aead_cipher =3D false;</span><b=
r><span>@@ -891,9 +891,9 @@</span><br><span> </span><br><span>         /* c=
heck legal cipher mode */</span><br><span>         aead_cipher =3D cipher_k=
t_mode_aead(kt-&gt;cipher);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (!(cipher_kt_mode_cbc(kt-&gt;cipher) || (tls_mode &amp;&am=
p; aead_cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!(cipher_kt_mode_cbc(kt-&gt;cipher) || aead_cipher</span><br><span>=
 #ifdef ENABLE_OFB_CFB_MODE</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-              || (tls_mode &amp;&amp; cipher_kt_mode_ofb_cfb(kt-&gt;c=
ipher))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
  || cipher_kt_mode_ofb_cfb(kt-&gt;cipher)</span><br><span> #endif</span><b=
r><span>                   ))</span><br><span>         {</span><br><span>di=
ff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>=
index dbe0802=2E=2E203f77b 100644</span><br><span>--- a/src/openvpn/crypto=
=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -420,1=
1 +420,9 @@</span><br><span>  * @param kt          The struct key_type to i=
nitialize</span><br><span>  * @param ciphername  The name of the cipher to =
use</span><br><span>  * @param authname    The name of the HMAC digest to u=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param tls_mode =
   Specifies whether we are running in TLS mode, which allows</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *                    more ciphers =
than static key mode=2E</span><br><span>  * @param warn        Print warnin=
gs when null cipher / auth is used=2E</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void init_key_type(struct key_type *kt=
, const char *ciphername, const char *authname, bool tls_mode,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void init_key_type(struct key_ty=
pe *kt, const char *ciphername, const char *authname,</span><br><span>     =
               bool warn);</span><br><span> </span><br><span> /*</span><br>=
<span>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><b=
r><span>index d29895b=2E=2E6b5fcee6 100644</span><br><span>--- a/src/openvp=
n/helper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><span>@=
@ -266,12 +266,6 @@</span><br><span>             msg(M_USAGE, &quot;--serve=
r and --server-bridge cannot be used together&quot;);</span><br><span>     =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                &quot;--server and --secret cannot be used togethe=
r (you must use SSL/TLS keys)&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span>         if (!(o-&gt;server_flags &amp; SF_NOPOOL) &am=
p;&amp; o-&gt;ifconfig_pool_defined)</span><br><span>         {</span><br><=
span>             msg(M_USAGE,</span><br><span>@@ -461,12 +455,6 @@</span><=
br><span>                 &quot;--server-bridge already defines an ifconfig=
-pool, so you can&#39;t also specify --ifconfig-pool explicitly&quot;);</sp=
an><br><span>         }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (o-&gt;shared_secret_file)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(M_USAGE,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                &quot;--server-bridge and --secr=
et cannot be used together (you must use SSL/TLS keys)&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>         if (dev !=3D DEV_TYP=
E_TAP)</span><br><span>         {</span><br><span>             msg(M_USAGE,=
 &quot;--server-bridge directive only makes sense with --dev tap&quot;);</s=
pan><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</spa=
n><br><span>index 24cf532=2E=2E9299c4f 100644</span><br><span>--- a/src/ope=
nvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@=
 -996,35 +996,10 @@</span><br><span>         platform_mlockall(true);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * We do not want user to use --genkey with --secret=2E In the transisti=
on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * phase we for=
 secret=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;genke=
y &amp;&amp; options-&gt;genkey_type !=3D GENKEY_SECRET &amp;&amp; options-=
&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
USAGE, &quot;Using --genkey type with --secret filename is &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                     &quot;not =
supported=2E  Use --genkey type filename instead=2E&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     if (option=
s-&gt;genkey &amp;&amp; options-&gt;genkey_type =3D=3D GENKEY_SECRET)</span=
><br><span>     {</span><br><span>         int nbits_written;</span><br><sp=
an>         const char *genkey_filename =3D options-&gt;genkey_filename;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;=
shared_secret_file &amp;&amp; options-&gt;genkey_filename)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;You must provide a =
filename to either --genkey &quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                         &quot;or --secret, not both&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         * Copy filename from shared_secret_file to genkey_filename=
 to support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 the old --genkey --secret foo=2Efile syntax=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (options-&gt;shared_secret_file)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: Using --ge=
nkey --secret filename is &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        &quot;DEPRECATED=2E  Use --genkey secret=
 filename instead=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            genkey_filename =3D options-&gt;shared_secret_file;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>=
 </span><br><span>         nbits_written =3D write_key_file(2, genkey_filen=
ame);</span><br><span>         if (nbits_written &lt; 0)</span><br><span>@@=
 -1033,7 +1008,7 @@</span><br><span>         }</span><br><span> </span><br>=
<span>         msg(D_GENKEY | M_NOPREFIX, &quot;Randomly generated %d bit k=
ey written to %s&quot;, nbits_written,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            options-&gt;shared_secret_file);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;genkey_fi=
lename ? options-&gt;genkey_filename : &quot;stdout&quot;);</span><br><span=
>         return true;</span><br><span>     }</span><br><span>     else if =
(options-&gt;genkey &amp;&amp; options-&gt;genkey_type =3D=3D GENKEY_TLS_CR=
YPTV2_SERVER)</span><br><span>@@ -1079,7 +1054,7 @@</span><br><span>     /*=
 sanity check on options for --mktun or --rmtun */</span><br><span>     not=
null(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><br><span>=
     if (options-&gt;ce=2Eremote || options-&gt;ifconfig_local || options-&=
gt;ifconfig_remote_netmask</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        || options-&gt;shared_secret_file || options-&gt;tls_server ||=
 options-&gt;tls_client)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        || options-&gt;tls_server || options-&gt;tls_client)</span><br=
><span>     {</span><br><span>         msg(M_FATAL | M_OPTERR,</span><br><s=
pan>             &quot;options --mktun or --rmtun should only be used toget=
her with --dev&quot;);</span><br><span>@@ -3011,8 +2986,7 @@</span><br><spa=
n>     ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c1=2Eks=2Estatic_key));</span>=
<br><span> </span><br><span>     /* Init cipher and hash algorithm */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;c-&g=
t;c1=2Eks=2Ekey_type, options-&gt;ciphername, options-&gt;authname,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                  options-&gt=
;test_crypto, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;ciphername, o=
ptions-&gt;authname, true);</span><br><span> </span><br><span>     generate=
_test_crypto_random_key(&amp;c-&gt;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=2Eks=
=2Estatic_key,</span><br><span>                                     &quot;t=
est crypto key&quot;);</span><br><span>@@ -3022,50 +2996,6 @@</span><br><sp=
an> }</span><br><span> </span><br><span> /*</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Static Key Mode (using a pre-shared key)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-do_init_crypto_static(struct context *c, const unsigned int=
 flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const struct options *options =
=3D &amp;c-&gt;options;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ASSERT(options-&gt;shared_secret_file);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    init_crypto_pre(c, flags);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* In=
itialize flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (c-&gt;options=2Emute_replay_warnings)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_MUTE_REPLAY_WARNINGS;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* Initialize packet ID tracking */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    packet_id_init(&amp;c-&gt;c2=2Ecrypt=
o_options=2Epacket_id, options-&gt;replay_window, options-&gt;replay_time,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &qu=
ot;STATIC&quot;, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   c-&gt;c2=2Ecrypto_options=2Epid_persist =3D &amp;c-&gt;c1=2Epid_persist;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto=
_options=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    packet_id_persist_load_obj(&amp;c-&gt;c1=2Epid_=
persist, &amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!key_ctx_bi_defined(&amp;c-&gt;c1=2Eks=2Estatic_key))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        /* Get cipher &amp; hash algorit=
hms */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        init_ke=
y_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;ciphername, options-&gt;a=
uthname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
         options-&gt;test_crypto, true);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* Read cipher and hmac keys from shared secret file */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        crypto_read_openvpn_key(&am=
p;c-&gt;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=2Eks=2Estatic_key,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                opti=
ons-&gt;shared_secret_file, options-&gt;shared_secret_file_inline,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
  options-&gt;key_direction, &quot;Static Key Encryption&quot;, &quot;secre=
t&quot;, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Re-using pre-shared stati=
c key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Get key schedule */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_options=2Ekey_ct=
x_bi =3D c-&gt;c1=2Eks=2Estatic_key;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Ini=
tialize the tls-auth/crypt key context</span><br><span>  */</span><br><span=
> static void</span><br><span>@@ -3204,7 +3134,7 @@</span><br><span> </span=
><br><span>         /* Do not warn if the cipher is used only in OCC */</sp=
an><br><span>         bool warn =3D options-&gt;enable_ncp_fallback;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        init_key_type(&amp;c=
-&gt;c1=2Eks=2Ekey_type, ciphername, options-&gt;authname, true, warn);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        init_key_type(&=
amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, options-&gt;authname, warn);</spa=
n><br><span> </span><br><span>         /* initialize tls-auth/crypt/crypt-v=
2 key */</span><br><span>         do_init_tls_wrap_key(c);</span><br><span>=
@@ -3492,41 +3422,6 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * No encryption or authenticatio=
n=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_init_crypto_none(struct context *c)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(!c-&gt;options=2Etest_crypto);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* Initialise key_type with auth/cipher &qu=
ot;none&quot;, so the key_type struct is</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * valid */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, &quot;none&qu=
ot;, &quot;none&quot;, c-&gt;options=2Etest_crypto, true);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    msg(M_WARN, &quot;******* WARNING *******: All encrypti=
on and authentication features &quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                &quot;disabled -- All data will be tunnelle=
d as clear text and will not be &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                &quot;protected against man-in-the-middle =
changes=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            &quot;PLEASE DO RECONSIDER THIS CONFIGURATION!&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_ini=
t_crypto(struct context *c, const unsigned int flags)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (c-&gt;options=2Eshared_secret_file)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        do_init_crypto_static(c, flags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else if (c-&gt;options=2Etls_server || c-&gt;optio=
ns=2Etls_client)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_crypt=
o_tls(c, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else /* no encryp=
tion or authentication=2E */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        d=
o_init_crypto_none(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span=
><br><span> do_init_frame(struct context *c)</span><br><span> {</span><br><=
span>@@ -4564,7 +4459,7 @@</span><br><span>         {</span><br><span>     =
        crypto_flags =3D CF_INIT_TLS_MULTI;</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_crypto(c, =
crypto_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   do_init_crypto_tls(c, crypto_flags);</span><br><span>         if (IS_SIG=
(c) &amp;&amp; !child)</span><br><span>         {</span><br><span>         =
    goto sig;</span><br><span>diff --git a/src/openvpn/mtu=2Ec b/src/openvp=
n/mtu=2Ec</span><br><span>index f3c2874=2E=2E5ce40c8 100644</span><br><span=
>--- a/src/openvpn/mtu=2Ec</span><br><span>+++ b/src/openvpn/mtu=2Ec</span>=
<br><span>@@ -51,7 +51,6 @@</span><br><span> unsigned int</span><br><span> =
calc_packet_id_size_dc(const struct options *options, const struct key_type=
 *kt)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    bool tlsmode =3D options-&gt;tls_server || options-&gt;tls_client;</=
span><br><span>     bool epoch =3D options-&gt;imported_protocol_flags &amp=
; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span> </span><br><span>     /* epoch=
 format uses a 64-bit packet id: 16 bit epoch + 48 bit per-epoch counter */=
</span><br><span>@@ -60,7 +59,7 @@</span><br><span>         return sizeof(u=
int64_t);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    bool packet_id_long_form =3D !tlsmode || c=
ipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool packet_id_long_form =3D cipher_kt_mode_ofb_cfb(k=
t-&gt;cipher);</span><br><span> </span><br><span>     return packet_id_size=
(packet_id_long_form);</span><br><span> }</span><br><span>@@ -72,8 +71,6 @@=
</span><br><span>     /* Sum of all the overhead that reduces the usable pa=
cket size */</span><br><span>     size_t header_size =3D 0;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool tlsmode =
=3D options-&gt;tls_server || options-&gt;tls_client;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* A socks proxy adds=
 extra header to each packet</span><br><span>      * (we only support Socks=
 with IPv4, this value is different for IPv6) */</span><br><span>     if (o=
ptions-&gt;ce=2Esocks_proxy_server &amp;&amp; proto_is_udp(options-&gt;ce=
=2Eproto))</span><br><span>@@ -88,10 +85,7 @@</span><br><span>     }</span>=
<br><span> </span><br><span>     /* Add the opcode and peerid */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (tlsmode)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        header_size +=3D options-&gt;use_peer_id ? 4 =
: 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    header_size +=3D options-&g=
t;use_peer_id ? 4 : 1;</span><br><span> </span><br><span>     unsigned int =
pkt_id_size =3D calc_packet_id_size_dc(options, kt);</span><br><span> </spa=
n><br><span>@@ -156,13 +150,6 @@</span><br><span> {</span><br><span>     st=
ruct key_type occ_kt;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* neither --secret nor TLS mode */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;tls_client &amp;&amp; !o=
-&gt;tls_server &amp;&amp; !o-&gt;shared_secret_file)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        init_key_type(&amp;occ_kt, &quot;none&quot;, &quot;=
none&quot;, false, false);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return frame_calculate_payload_size(frame, o, &amp;occ_kt);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* o-&gt;ciphernam=
e might be BF-CBC even though the underlying SSL library</span><br><span>  =
    * does not support it=2E For this reason we workaround this corner case=
</span><br><span>      * by pretending to have no encryption enabled and by=
 manually adding</span><br><span>@@ -184,9 +171,7 @@</span><br><span>      =
   ciphername =3D &quot;none&quot;;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* We pass tlsmo=
de always true here since as we do not need to check if</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * the ciphers are actually valid for=
 non tls in occ calucation */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    init_key_type(&amp;occ_kt, ciphername, o-&gt;authname, true, fa=
lse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_t=
ype(&amp;occ_kt, ciphername, o-&gt;authname, false);</span><br><span> </spa=
n><br><span>     size_t payload =3D frame_calculate_payload_size(frame, o, =
&amp;occ_kt);</span><br><span>     overhead +=3D frame_calculate_protocol_h=
eader_size(&amp;occ_kt, o, true);</span><br><span>diff --git a/src/openvpn/=
options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8e0c602=2E=2E38=
6f412 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>=
+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1587,6 +1587,10 @@</span>=
<br><span> static void</span><br><span> options_postprocess_verify_ce(const=
 struct options *options, const struct connection_entry *ce)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options=
-&gt;test_crypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n>     struct options defaults;</span><br><span>     int dev =3D DEV_TYPE_U=
NDEF;</span><br><span>     bool pull =3D false;</span><br><span>@@ -2012,27=
 +2016,9 @@</span><br><span>     /*</span><br><span>      * SSL/TLS mode sa=
nity checks=2E</span><br><span>      */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (options-&gt;tls_server + options-&gt;tls_client +=
 (options-&gt;shared_secret_file !=3D NULL) &gt; 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_server + options-=
&gt;tls_client + options-&gt;test_crypto !=3D 1)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quo=
t;specify only one of --tls-server, --tls-client, or --secret&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_clie=
nt &amp;&amp; !options-&gt;test_crypto)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msglvl_t msglevel =3D M_USAGE;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (options-&gt;allow_deprecated_insecure_static=
_crypto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msglevel =3D =
M_INFO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;DEPRECATION: No tls=
-client or tls-server option in &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                      &quot;configuration detected=2E Open=
VPN 2=2E8 will remove the &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                      &quot;functionality to run a VPN without T=
LS=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
             &quot;See the examples section in the manual page for &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      &=
quot;examples of a similar quick setup with peer-fingerprint=2E &quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                      &quo=
t;OpenVPN 2=2E7 allows using this configuration when using &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                      &quot;--a=
llow-deprecated-insecure-static-crypto but you should move &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                      &quot;to =
a proper configuration using TLS as soon as possible=2E&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Open=
VPN configuration must use either --tls-server or --tls-client&quot;);</spa=
n><br><span>     }</span><br><span> </span><br><span>     if (options-&gt;s=
sl_flags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))=
</span><br><span>@@ -2052,188 +2038,136 @@</span><br><span>         msg(M_U=
SAGE, &quot;--tls-version-min bigger than --tls-version-max&quot;);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (options-&gt;tls_server || options-&gt;tls_client)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        check_ca_required(options);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    check_ca_required(options);</span><br><spa=
n> #ifdef ENABLE_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (!options-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs1=
1_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quo=
t;Option pkcs11-id is ignored as no pkcs11-providers are specified&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        else if (!options-&gt;pkcs=
11_providers[0] &amp;&amp; options-&gt;pkcs11_id_management)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                &quot;Option pkcs11-id-managem=
ent is ignored as no pkcs11-providers are specified&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!options-&gt;pkcs11_providers[0] &amp;&=
amp; options-&gt;pkcs11_id)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN, &quot;Option pkcs11-id is ignored as no pkcs11-providers are =
specified&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (!op=
tions-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id_management)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;Option pkcs11-id=
-management is ignored as no pkcs11-providers are specified&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;p=
kcs11_providers[0])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (options-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_id !=3D NU=
LL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAG=
E,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 &quot;Parameter --pkcs11-id cannot be used when --pkcs11-id-management is =
also specified=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (!options-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11=
_id =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              &quot;Parameter --pkcs11-id or --pkcs11-id-management should =
be specified=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      const char use_err[] =3D</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                &quot;Parameter --%s cannot be used when --pkcs11-=
provider is also specified=2E&quot;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(=
priv_key_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(=
options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-extern=
al-key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &qu=
ot;management-external-cert&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            MUST_BE_UNDEF(cryptoapi_cert, &quot;cryptoapice=
rt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_PKCS11 */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;crypto=
api_cert)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char u=
se_err[] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       &quot;Parameter --%s cannot be used when --cryptoapicert is also spe=
cified=2E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(priv_key_file, &quot=
;key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;manageme=
nt_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(o=
ptions-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-extern=
al-cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;pkcs12_file)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &qu=
ot;Parameter --pkcs12 cannot be used with the mbed TLS version of OpenVPN=
=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char use=
_err[] =3D &quot;Parameter --%s cannot be used when --pkcs12 is also specif=
ied=2E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &quot;cert&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUS=
T_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_flag=
s &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-=
&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-cert=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif       =
/* ifdef ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else /* cert/key from none of pkcs11, pkcs12, cryptoapi */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if ((options-&gt;management_fl=
ags &amp; MF_EXTERNAL_KEY) &amp;&amp; options-&gt;priv_key_file)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;--key=
 and --management-external-key are mutually exclusive&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if ((options-&gt;management_fla=
gs &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              if (options-&gt;cert_file)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    msg(M_USAGE, &quot;--cert and --manageme=
nt-external-cert are mutually exclusive&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                else if (!(options-&gt;management_fla=
gs &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        &quot;--management-external-cert must b=
e used with --management-external-key&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (pull)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                const int sum =3D</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    ((options-&gt;cert_file !=3D NULL) || (=
options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    + ((options-&gt;priv_ke=
y_file !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                   || (options-&gt;management_flags &amp; MF_EXTERNAL_KEY))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                if (sum =3D=3D 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    if (!options-=
&gt;auth_user_pass_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        msg(M_USAGE, &quot;No client-side authentication=
 method is &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                                 &quot;specified=2E  You must use either &q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                    &quot;--cert/--key, --pkcs12, or &quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
&quot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                else if (sum !=3D 2)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    msg(M_USAGE, &quot;If you use one of --=
cert or --key, you must use them both&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (!(options-&gt;management_flags &amp; MF_EXTERNAL_CERT))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    notnul=
l(options-&gt;cert_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                            &quot;certificate file (--cert) or PKCS#12 f=
ile (--pkcs12)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    notnull(o=
ptions-&gt;priv_key_file,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                            &quot;private key file (--key) or PKCS#12 f=
ile (--pkcs12)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ce-&gt;tls_=
auth_file &amp;&amp; ce-&gt;tls_crypt_file)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_USAGE, &quot;--tls-auth and --tls-crypt are mut=
ually exclusive&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (options-&gt;tls_client &amp;&amp; ce-&gt;tls_crypt_v2_file</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (ce-&gt;tls_a=
uth_file || ce-&gt;tls_crypt_file))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (options-&gt;pkcs11_providers[0])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (options-&gt;pkcs11_id_management &amp;&a=
mp; options-&gt;pkcs11_id !=3D NULL)</span><br><span>         {</span><br><=
span>             msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                &quot;--tls-crypt-v2, --tls-auth and --tls-crypt a=
re mutually exclusive in client mode&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                &quot;Parameter --pkcs11-id cannot=
 be used when --pkcs11-id-management is also specified=2E&quot;);</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * Make sure user doesn&#39;t specify any TLS option=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * when in n=
on-TLS mode=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        const char use_err[] =3D &quot=
;Parameter %s can only be specified in TLS-mode, &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                               &quot;i=2E=
e=2E where --tls-server or --tls-client is also specified=2E&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ca_file, &quot;ca&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ca=
_path, &quot;capath&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        MUST_BE_UNDEF(dh_file, &quot;dh&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!options-&gt;pkcs11_id_manage=
ment &amp;&amp; options-&gt;pkcs11_id =3D=3D NULL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_USAGE,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                &quot;Parameter --pkcs11-id or --=
pkcs11-id-management should be specified=2E&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const char use_err[] =3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;Parameter --%s canno=
t be used when --pkcs11-provider is also specified=2E&quot;;</span><br><spa=
n>         MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span>    =
     MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><sp=
an>         MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;m=
anagement_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FA=
LSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-e=
xternal-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        MUST_BE_UNDEF(cryptoapi_cert, &quot;cryptoapicert&quot;);</spa=
n><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      MUST_BE_UNDEF(cipher_list, &quot;tls-cipher&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(cipher_list_tls13=
, &quot;tls-ciphersuites&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        MUST_BE_UNDEF(tls_cert_profile, &quot;tls-cert-profile&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE=
_UNDEF(tls_verify, &quot;tls-verify&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_export_peer_cert_dir, &quot=
;tls-export-cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        MUST_BE_UNDEF(verify_x509_name, &quot;verify-x509-name&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(t=
ls_timeout, &quot;tls-timeout&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_bytes, &quot;reneg-bytes&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_B=
E_UNDEF(renegotiate_packets, &quot;reneg-pkts&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_seconds, =
&quot;reneg-sec&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        MUST_BE_UNDEF(handshake_window, &quot;hand-window&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(transit=
ion_window, &quot;tran-window&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MUST_BE_UNDEF(tls_auth_file, &quot;tls-auth&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF=
(tls_crypt_file, &quot;tls-crypt&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_crypt_v2_file, &quot;tls-crypt=
-v2&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MU=
ST_BE_UNDEF(single_session, &quot;single-session&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(push_peer_info, &q=
uot;push-peer-info&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        MUST_BE_UNDEF(tls_exit, &quot;tls-exit&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(crl_file, &quot=
;crl-verify&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      MUST_BE_UNDEF(ns_cert_type, &quot;ns-cert-type&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(remote_cert_ku=
[0], &quot;remote-cert-ku&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        MUST_BE_UNDEF(remote_cert_eku, &quot;remote-cert-eku&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PK=
CS11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_U=
NDEF(pkcs11_providers[0], &quot;pkcs11-providers&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_private_mod=
e[0], &quot;pkcs11-private-mode&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_id, &quot;pkcs11-id&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(=
pkcs11_id_management, &quot;pkcs11-id-management&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ifdef ENABLE_PKCS11 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (options-&gt;cryptoapi_cert)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const char use_err[] =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Parameter=
 --%s cannot be used when --cryptoapicert is also specified=2E&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cer=
t_file, &quot;cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(pkcs12_file=
, &quot;pkcs12&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY=
, &quot;management-external-key&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &amp=
; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (options-&gt;pkcs12_file)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Parameter --pkcs12 =
cannot be used with the mbed TLS version of OpenVPN=2E&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const char use_err[] =3D &quot;Paramet=
er --%s cannot be used when --pkcs12 is also specified=2E&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(ca_path,=
 &quot;capath&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(priv_key_file, &quo=
t;key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;m=
anagement-external-key&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTE=
RNAL_CERT, &quot;management-external-cert&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else /* cert/key from none of pk=
cs11, pkcs12, cryptoapi */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if ((options-&gt;management_flags &amp; MF_EXTERNAL_KEY) &amp;&amp; option=
s-&gt;priv_key_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_USAGE, &quot;--key and --management-external-key are mutually excl=
usive&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((opt=
ions-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (options-&gt;cert_file)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot;--cert=
 and --management-external-cert are mutually exclusive&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            else if (!(options-&gt;man=
agement_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(M_USAGE,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    &quot;--management-external-cert m=
ust be used with --management-external-key&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         if (pull)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(M_USAGE, use_err, &quot;--pull&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            const int sum =3D</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ((options-&gt;=
cert_file !=3D NULL) || (options-&gt;management_flags &amp; MF_EXTERNAL_CER=
T))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
+ ((options-&gt;priv_key_file !=3D NULL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                   || (options-&gt;management_flags &a=
mp; MF_EXTERNAL_KEY));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
sum =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    if (!options-&gt;auth_user_pass_file)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    msg(M_USAGE, &quot;No client-side a=
uthentication method is &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                 &quot;specified=2E  You must us=
e either &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                             &quot;--cert/--key, --pkcs12, or &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
       &quot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            else if (sum !=3D 2)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                msg(M_USAGE, &quot;If you use one of --cer=
t or --key, you must use them both&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!(options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                notnull(options-&gt;cer=
t_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            &quot;certificate file (--cert) or PKCS#12 file (--pkcs12)&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!(opti=
ons-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                notnull(options-&gt;priv_key_file,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   &quot;private key file (--key) or PKCS#12 file (--pkcs12)&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan>         }</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (ce-&gt;tls_auth_file &amp;&amp; ce-&gt;tls_crypt_=
file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;-=
-tls-auth and --tls-crypt are mutually exclusive&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (options-&gt;tls_client &amp;&amp; ce-&gt;tls=
_crypt_v2_file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &amp;&amp; (ce-&gt;tls_auth_file || ce-&gt;tls_crypt_file))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_USAGE,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;--tls-crypt-v2, --tls-auth =
and --tls-crypt are mutually exclusive in client mode&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     if (options-&gt;auth_user_pass_file &amp;&am=
p; !options-&gt;pull)</span><br><span>     {</span><br><span>         msg(M=
_USAGE, &quot;--auth-user-pass requires --pull&quot;);</span><br><span>@@ -=
6957,32 +6891,6 @@</span><br><span>             goto err;</span><br><span> =
        }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else if (streq(p[0], &quot;secret&quot;) &amp;&amp; p[1] &am=
p;&amp; !p[3])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &qu=
ot;DEPRECATED OPTION: The option --secret is deprecated=2E&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_=
P_GENERAL | OPT_P_INLINE);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        options-&gt;shared_secret_file =3D p[1];</span><br><span style=
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
pan>     }</span><br><span> </span><br><span>diff --git a/src/openvpn/optio=
ns_string=2Eh b/src/openvpn/options_string=2Eh</span><br><span>index 02efed=
3=2E=2E6d5518a 100644</span><br><span>--- a/src/openvpn/options_string=2Eh<=
/span><br><span>+++ b/src/openvpn/options_string=2Eh</span><br><span>@@ -59=
,7 +59,6 @@</span><br><span>  *</span><br><span>  * --cipher</span><br><spa=
n>  * --auth</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --secr=
et</span><br><span>  *</span><br><span>  * SSL Options:</span><br><span>  *=
</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</sp=
an><br><span>index ddee3eb=2E=2E55043e5 100644</span><br><span>--- a/src/op=
envpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ =
-1644,7 +1644,7 @@</span><br><span>         return true;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    init_key_type(&amp;session-&gt;opt-&gt;key_type, options-&gt;ciphernam=
e, options-&gt;authname, true, true);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    init_key_type(&amp;session-&gt;opt-&gt;key_type, opti=
ons-&gt;ciphername, options-&gt;authname, true);</span><br><span> </span><b=
r><span>     bool packet_id_long_form =3D cipher_kt_mode_ofb_cfb(session-&g=
t;opt-&gt;key_type=2Ecipher);</span><br><span>     session-&gt;opt-&gt;cryp=
to_flags &amp;=3D ~(CO_PACKET_ID_LONG_FORM);</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_cry=
pto=2Ec</span><br><span>index 07c54b4=2E=2Ebcc63db 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_crypto=2Ec</span><br><span>@@ -237,70 +237,58 @@</sp=
an><br><span>     /* common defaults */</span><br><span>     o=2Ece=2Etun_m=
tu =3D 1400;</span><br><span>     o=2Ece=2Eproto =3D PROTO_UDP;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    o=2Etls_client =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=2Epull =3D true;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* No crypto at all */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /*  auth none, cipher none */</span><br><span>     o=2Eciphername =
=3D &quot;none&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot=
;;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &a=
mp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_=
equal(linkmtu, 1400);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(linkmtu, 1405);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* Static key OCC examples */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =
=3D &quot;not null&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, au=
th none, cipher none */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    o=2Eciphername =3D &quot;none&quot;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    o=2Eauthname =3D &quot;none&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    linkmtu =3D calc_options_string_l=
ink_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    assert_int_equal(linkmtu, 1408);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* secret, cipher AES-128-CBC, auth none */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* cipher AES-128-CBC, auth none */</span><br>=
<span>     o=2Eciphername =3D &quot;AES-128-CBC&quot;;</span><br><span>    =
 o=2Eauthname =3D &quot;none&quot;;</span><br><span>     linkmtu =3D calc_o=
ptions_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1440);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1437);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
secret, cipher none, auth SHA256 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* cipher none, auth SHA256 */</span><br><span>     o=
=2Eciphername =3D &quot;none&quot;;</span><br><span>     o=2Eauthname =3D &=
quot;SHA256&quot;;</span><br><span>     linkmtu =3D calc_options_string_lin=
k_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_int_equal(linkmtu, 1440);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(linkmtu, 1437);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher BF=
-CBC, auth SHA1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* cipher BF-CBC, auth SHA1 */</span><br><span>     o=2Eciphername =3D &=
quot;BF-CBC&quot;;</span><br><span>     o=2Eauthname =3D &quot;SHA1&quot;;<=
/span><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;=
f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equ=
al(linkmtu, 1444);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(linkmtu, 1441);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher BF-CBC, auth SHA1, tc=
p-client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* c=
ipher BF-CBC, auth SHA1, tcp-client */</span><br><span>     o=2Ece=2Eproto =
=3D PROTO_TCP_CLIENT;</span><br><span>     linkmtu =3D calc_options_string_=
link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    assert_int_equal(linkmtu, 1446);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1443);</span><br><span> =
</span><br><span>     o=2Ece=2Eproto =3D PROTO_UDP;</span><br><span> </span=
><br><span> #if defined(USE_COMP)</span><br><span>     o=2Ecomp=2Ealg =3D C=
OMP_ALG_LZO;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /*  comp-lzo yes, cipher =
BF-CBC, auth SHA1 */</span><br><span>     linkmtu =3D calc_options_string_l=
ink_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    assert_int_equal(linkmtu, 1445);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1442);</span><br><span> <=
/span><br><span> #if defined(ENABLE_FRAGMENT)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* secret, comp-lzo yes, cipher BF-CBC, auth SH=
A1, fragment 1200 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */</span><br>=
<span>     o=2Ece=2Efragment =3D 1200;</span><br><span>     linkmtu =3D cal=
c_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1449);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1446);<=
/span><br><span>     o=2Ece=2Efragment =3D 0;</span><br><span> #endif</span=
><br><span> </span><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* TLS mode */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    o=2Eshared_secret_file =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    o=2Etls_client =3D true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    o=2Epull =3D true;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* tls client, ciph=
er AES-128-CBC, auth SHA1, tls-auth */</span><br><span>     o=2Eauthname =
=3D &quot;SHA1&quot;;</span><br><span>     o=2Eciphername =3D &quot;AES-128=
-CBC&quot;;</span><br><span>@@ -315,15 +303,8 @@</span><br><span>     linkm=
tu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span>     a=
ssert_int_equal(linkmtu, 1457);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* tls client, cipher none, auth none */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls client, aut=
h none, cipher AES-256-GCM */</span><br><span>     o=2Eauthname =3D &quot;n=
one&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Ecip=
hername =3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    linkmtu =
=3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1405);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, cipher AES-256-GCM */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eauthname =3D &q=
uot;SHA1&quot;;</span><br><span>     o=2Eciphername =3D &quot;AES-256-GCM&q=
uot;;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o,=
 &amp;f);</span><br><span>     assert_int_equal(linkmtu, 1449);</span><br><=
span>@@ -332,12 +313,12 @@</span><br><span> #if defined(USE_COMP) &amp;&amp=
; defined(ENABLE_FRAGMENT)</span><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG=
_LZO;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls client=
, auth none, cipher AES-256-GCM, fragment, comp-lzo yes */</span><br><span>=
     o=2Ece=2Efragment =3D 1200;</span><br><span>     linkmtu =3D calc_opti=
ons_string_link_mtu(&amp;o, &amp;f);</span><br><span>     assert_int_equal(=
linkmtu, 1454);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, com=
p-lzo yes, socks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo yes, s=
ocks */</span><br><span>     o=2Ece=2Esocks_proxy_server =3D &quot;socks=2E=
example=2Ecom&quot;;</span><br><span>     linkmtu =3D calc_options_string_l=
ink_mtu(&amp;o, &amp;f);</span><br><span>     assert_int_equal(linkmtu, 146=
4);</span><br><span>@@ -358,50 +339,48 @@</span><br><span>     o=2Ece=2Etun=
_mtu =3D 1400;</span><br><span>     o=2Ece=2Emssfix =3D 1000;</span><br><sp=
an>     o=2Ece=2Eproto =3D PROTO_UDP;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    o=2Etls_client =3D true;</span><br><span> </span><br>=
<span>     /* No crypto at all */</span><br><span>     o=2Eciphername =3D &=
quot;none&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</s=
pan><br><span>     struct key_type kt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, f=
alse, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
it_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* No encryption=
, just packet id (8) + TCP payload(20) + IP payload(20) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* No encryption, just packet id=
 (4) + opcode (1) + TCP payload(20) + IP payload(20) */</span><br><span>   =
  frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(f=2Emss_fix, 952);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(f=2Emss_fix, 955);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* Static key OCC examples */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D &quot;not null&=
quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* secret, auth none, cipher non=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* auth non=
e, cipher none */</span><br><span>     o=2Eciphername =3D &quot;none&quot;;=
</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphernam=
e, o=2Eauthname, false, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false)=
;</span><br><span>     frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NUL=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equ=
al(f=2Emss_fix, 952);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(f=2Emss_fix, 955);</span><br><span> </span><br><span=
>     /* secret, cipher AES-128-CBC, auth none */</span><br><span>     o=2E=
ciphername =3D &quot;AES-128-CBC&quot;;</span><br><span>     o=2Eauthname =
=3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false, false);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;=
kt, o=2Eciphername, o=2Eauthname, false);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 990; i &lt;=3D 101=
0; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int=
 i =3D 990; i &lt;=3D 1015; i++)</span><br><span>     {</span><br><span>   =
      /* 992 - 1008 should end up with the same mssfix value all they</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         * all result in th=
e same CBC block size/padding and &lt;=3D 991 and &gt;=3D1008</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * all result in the same=
 CBC block size/padding and &lt;=3D 992 and &gt;=3D1009</span><br><span>   =
       * should be one block less and more respectively */</span><br><span>=
         o=2Ece=2Emssfix =3D i;</span><br><span>         frame_calculate_dy=
namic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (i &lt;=3D 991)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (i &lt;=3D 992)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_i=
nt_equal(f=2Emss_fix, 911);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            assert_int_equal(f=2Emss_fix, 915);</span><br><span>   =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else i=
f (i &gt;=3D 1008)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else if (i &gt;=3D 1009)</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_f=
ix, 943);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  assert_int_equal(f=2Emss_fix, 947);</span><br><span>         }</span><br>=
<span>         else</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 927);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_int=
_equal(f=2Emss_fix, 931);</span><br><span>         }</span><br><span>     }=
</span><br><span> #ifdef USE_COMP</span><br><span>@@ -413,33 +392,32 @@</sp=
an><br><span>     for (int i =3D 990; i &lt;=3D 1010; i++)</span><br><span>=
     {</span><br><span>         /* 992 - 1008 should end up with the same m=
ssfix value all they</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * all result in the same CBC block size/padding and &lt;=3D 991 and=
 &gt;=3D1008</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * all result in the same CBC block size/padding and &lt;=3D 992 and &gt;=
=3D1009</span><br><span>          * should be one block less and more respe=
ctively */</span><br><span>         o=2Ece=2Emssfix =3D i;</span><br><span>=
         frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (i &lt;=3D 991)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i &lt;=3D 992=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            assert_int_equal(f=2Emss_fix, 910);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix=
, 914);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        else if (i &gt;=3D 1008)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else if (i &gt;=3D 1009)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 assert_int_equal(f=2Emss_fix, 942);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            assert_int_equal(f=2Emss_fix, 946);</span><br>=
<span>         }</span><br><span>         else</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_int_=
equal(f=2Emss_fix, 926);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            assert_int_equal(f=2Emss_fix, 930);</span><br><span>      =
   }</span><br><span>     }</span><br><span>     o=2Ecomp=2Ealg =3D COMP_AL=
G_UNDEF;</span><br><span> #endif /* ifdef USE_COMP */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth S=
HA1, cipher AES-256-GCM */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /*  auth SHA1, cipher AES-256-GCM */</span><br><span>     o=2Eau=
thname =3D &quot;SHA1&quot;;</span><br><span>     o=2Eciphername =3D &quot;=
AES-256-GCM&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 o=2Etls_client =3D true;</span><br><span>     o=2Epeer_id =3D 77;</span><b=
r><span>     o=2Euse_peer_id =3D true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, t=
rue, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false);</span><br><span> =
</span><br><span>     for (int i =3D 900; i &lt;=3D 1200; i++)</span><br><s=
pan>     {</span><br><span>@@ -685,7 +663,7 @@</span><br><span> </span><br>=
<span>     data-&gt;gc =3D gc_new();</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;data-&gt;kt, &quot;=
AES-128-GCM&quot;, &quot;none&quot;, true, false);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;data-&gt;kt, &quot;AE=
S-128-GCM&quot;, &quot;none&quot;, false);</span><br><span> </span><br><spa=
n>     /* have an epoch key that uses 0x23 for the key for all bytes */</sp=
an><br><span>     struct epoch_key epoch1send =3D { =2Eepoch =3D 1, =2Eepoc=
h_key =3D { 0x23 } };</span><br><span>@@ -907,7 +885,7 @@</span><br><span> =
    struct epoch_key e17 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 }=
 };</span><br><span>     struct key_type kt =3D { 0 };</span><br><span>    =
 struct key_parameters key_parameters =3D { 0 };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, &quot;AES-192-GCM&quo=
t;, &quot;none&quot;, true, false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    init_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;n=
one&quot;, false);</span><br><span> </span><br><span> </span><br><span>    =
 epoch_data_key_derive(&amp;key_parameters, &amp;e17, &amp;kt);</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/=
openvpn/test_pkt=2Ec</span><br><span>index fbbb40f=2E=2E49ba833 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -173,7 +173,7 @=
@</span><br><span>     tas=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_=
ID | CO_PACKET_ID_LONG_FORM);</span><br><span> </span><br><span>     struct=
 key_type tls_crypt_kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    init_key_type(&amp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, =
true, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
it_key_type(&amp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, false);<=
/span><br><span> </span><br><span>     crypto_read_openvpn_key(&amp;tls_cry=
pt_kt, &amp;tas=2Etls_wrap=2Eopt=2Ekey_ctx_bi, static_key, true,</span><br>=
<span>                             key_direction, &quot;Control Channel Aut=
hentication&quot;, &quot;tls-auth&quot;, NULL);</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Dema=
il">change 2081</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2081?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2081 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</=
body></html>
--oGXZ6N7Ug9o=--


--===============4151949775463477115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4151949775463477115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4151949775463477115==--

