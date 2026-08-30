Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD21C61DE4
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9PxJMVCDy8uJeVKl3L1PI/CE3wPrsusbsVhTI2M1z8=; b=NmLl/pMHinVqQWjNd9HwjcDJeQ
	YKQIzhGSjDszTEoUcVh1pfR4xhw0hsKHSmpbt1Vl0RLqoIwveEMeyEfe8irzhIBWWJwLlV2uwOrLi
	CfSjAT0gB/46hfyejUl7mzaSee2lymNBU+pmQoaYRp6nyrKUXCbwQP3ApdF9fqhNKEdw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0id6-00062g-NA;
	Sun, 30 Aug 2026 16:43:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0id5-00062a-9d
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sCt8KzsMuK6ES+P5Pg/EZpRM6pfGDMniTvcbuSrdWZ8=; b=HWW/+Ipw3Kl3r437DoE2hh5tpH
 2ecXSr71qDmKk+/rPKO9MeBzp6i8m4nlvpNsQmrQTuC6Qi6xutQElag6fX2Iy6f0swfHYoVuhtv/J
 6mvbnuyNRR1NDhjjNxO4lo+sMIGFr/Zexzkg1+9lfcuI+pPwK8ZsYuPl58VVvE8DvDLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sCt8KzsMuK6ES+P5Pg/EZpRM6pfGDMniTvcbuSrdWZ8=; b=f
 nWMua/9Am9in5sY3Pw4OhoKMaOe9zG5NVWkEGbL/CSMpFdfDRVbyLISM7IbKn3Lsz1Au2IVuQGaCE
 x10KrzAyLPKuAAa68F3+RKk4Clrwfq2eHDcOEsqnZ/qONBlTT8GNqbmHuE+nmQ0dAkDw9amebhLai
 hPzOc6EuPbIsdqxY=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0id1-0003EA-Uo for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:43:32 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-482e1bfcc63so1998644f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788108205; x=1788713005; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sCt8KzsMuK6ES+P5Pg/EZpRM6pfGDMniTvcbuSrdWZ8=;
 b=Gz+sluCsYFPsYjEDW55j3brmNHONKV0kpcXcygY0oPAbhM/IVFHrzblxBEQCmCadkO
 MpZroCPnteZgbRTDA+oM7hCCRz6CGwvF5zi/T/Qs2wD2jlPdnkIjBjhXjIg34KEu1kt9
 prrYpaLvdiv0FtK1bOg77Frr4BLqClgAgTNXLSmHhqpHRTVK+7N8omnBj0Cu0l4funsx
 9lfG5nd/KtRxoXFYbFEyOVnlQBjBcLigmpIU8zSWIiV+Dac+phLPwUDzu4k4CyG4idux
 cdQRqxuE+DHWtJDxireWsDGhDNKU9vztQIaySLf1jUsTMkj4yF+qSb7jxV7S/c5iXyzZ
 bpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788108205; x=1788713005;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sCt8KzsMuK6ES+P5Pg/EZpRM6pfGDMniTvcbuSrdWZ8=;
 b=bNN3+MhPcOmFMh6q3F+2NB8QIPBERM9N6TU2Ui2J3SM7SkoJTkQHvyuQCndvvf2JsE
 au3Q4Rmj9eJuWWiwHdiJutZRka+WTZf65txvzUV7z3xbhyWQkPPOX0QzmZOUxM7jE/IY
 fsEG7zOqmoG0zY6W+swgJXcTg1SKQiv/Vl7iSOGxMGqpdecmJo5meBCmSnpizfLAEdza
 +SkUXEHlpFw9AuIQUKSdAxjLGTswimDE0u/31vnPbo6vkr0gxRfM2+SUcS8YtrmuUaJ1
 u6fo8GQq8gXTidnd6IqiZTkp7wu4ksmJqcw0UQuM4+UNzpj556matu988ns8cxGJXT9u
 J1qQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBydl7INygFngAqAM0XPk5LrEYqxC6BLl2tAVyygP7iW18U3w093UdrH88FghvJWZjQ0UsZ0SVpdzsGS+BTM@lists.sourceforge.net
X-Gm-Message-State: AFuF++mpjYDEz18REU8Vkvr2bXVbS2uuKo/nGfsPuE2ypiQqKZn9WoIO
 2XyTdMHRKsY3GzEt9DmRHKVA6qgRyxAxz6MwEYCTZvd3TeUHwXeB3ZaLAnJn72iuqmD5uaWmSgG
 oqYfD9fu0GD8bn9wWcK5tD61EkqqQyO5kzuQfGBX/s0SlL6M7PlCBNrGlvftn+Qc6jCPb
X-Gm-Gg: AYBFou2tSv156VmHT8IdIPQJ7CKarCtRcNJRsm63AzLbs3Nix65nSXrQSwHDL4HuZmP
 eVD4R1F3x9rMVmtOf978beXre/0IKhyHeIpKp9pLEKYNtTFiYJxhRTxYBpBkb1M9rGbtGhCCe9v
 BuKMphZ/Wl1t0fGeeV3PCZfa7VB/mxYeYPmhHqR4D0+6sGM6rkrjdjMayHfbnaaynNWdEcghXKw
 nkYoQLZjTrHsoVOnWRgkFK7qEQW8qzCfw7s6HfG+jCB5CMpd2a9FwTIQR9iXnrvFb2Spq4Rk9Bs
 KETSKvhGaC9S/L+iogsd0UKFuLJKoy4r6z/89jIQWg4UMPtkcSSkqSa3kN32OelxkDa+p11pxVU
 gM8EcIACTQHIOkwZQiQBA4+CxsWNz4z3iB8FDag1TCbzjVHgvp1tLra12jPIiQ9ZaqjKf1/U/3/
 2DdfmRiaxUwMpLQ7pJC197+5v4Szq430fVzUMl2pqKA/F36w5tgSBFBr3DIa8ii3H+uZe6SxCei
 BCyLJl2sFu+mEszNyh259CwysgZy4rDqy3Nj9b72sQ/paKGKLt50ujQcZqAQc9ER9enwvju2Kf0
 u0lQnWqfN74KL3R71w41IcOVIKpvXnPkerosVdTyUw+pOQzpPrI=
X-Received: by 2002:a5d:6f13:0:b0:484:3311:2578 with SMTP id
 ffacd0b85a97d-484397b7c4cmr5691340f8f.12.1788108205088; 
 Sun, 30 Aug 2026 09:43:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm17789797f8f.25.2026.08.30.09.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:43:24 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 16:43:24 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 5f6f272a11b64cf93513a54ef8b07d34ff2bd89e
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f91df07738fef659aa7eaf7f9e269db9558410b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0id1-0003EA-Uo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Work-around
 bug in mbedtls 4.1.0 and 4.2.0
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============5851257201931413167=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5851257201931413167==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ldLiLwPzFis="; charset=UTF-8

--ldLiLwPzFis=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1849?usp=3Demail )

Change subject: mbedtls: Work-around bug in mbedtls=
 4=2E1=2E0 and 4=2E2=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

mbedtls: Work-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0

=
Since the first distros have started to pick up these
versions before a fix=
 is released, let's make our tests
pass on these versions=2E

A fix is merg=
ed, so it might be fixed in 4=2E3=2E0=2E But I
didn't want to add that to t=
he version check until we
have verified that=2E

Change-Id: I694410615958af=
bb422d9ead71f04c1a60edc640
Signed-off-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849
Message-Id: <20260828201757=
=2E744-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg38802=2Ehtml
Signed-off-by: Gert Do=
ering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M sr=
c/openvpn/mbedtls_compat=2Eh
2 files changed, 14 insertions(+), 1 deletion(=
-)




diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/=
build=2Eyaml
index 29e8be2a=2E=2E56dd3ed 100644
--- a/=2Egithub/workflows/b=
uild=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -365,7 +365,7 @@
    =
   ovpnlibdesc: mbed TLS 4=2E
       # versioning=3Dsemver-coerced
       g=
hrepo: Mbed-TLS/mbedtls
-      gitref: v4=2E0=2E0
+      gitref: v4=2E2=2E0=

       libconfigure: cmake -B build -DCMAKE_INSTALL_PREFIX=3D$LIBPREFIX
  =
     libmake: cmake --build build
       libinstall: sudo cmake --install b=
uild
diff --git a/src/openvpn/mbedtls_compat=2Eh b/src/openvpn/mbedtls_comp=
at=2Eh
index 50739b6=2E=2Eec45a0f 100644
--- a/src/openvpn/mbedtls_compat=
=2Eh
+++ b/src/openvpn/mbedtls_compat=2Eh
@@ -43,6 +43,7 @@
 #include "cryp=
to_mbedtls_legacy=2Eh"
 #else
 #include <mbedtls/oid=2Eh>
+#include "crypto=
_mbedtls=2Eh"
 #endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 
 #ifdef H=
AVE_PSA_CRYPTO_H
@@ -228,6 +229,18 @@
 mbedtls_compat_pk_check_pair(const m=
bedtls_pk_context *pub, const mbedtls_pk_context *prv)
 {
 #if MBEDTLS_VERS=
ION_NUMBER >=3D 0x04000000
+    /* work around bug in mbedtls 4=2E1=2E0 by =
adding missing public key information in prv
+     * cf=2E https://github=
=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */
+#if MBEDTLS_VERSION_NUMBER >=
=3D 0x04010000
+    if (prv->MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)
+    {
=
+        mbedtls_pk_context *mut_prv =3D (mbedtls_pk_context *)prv; /* remo=
ve const */
+        ASSERT(mbed_ok(psa_export_public_key(mut_prv->MBEDTLS_=
PRIVATE(priv_id),
+                                             mut_prv->MB=
EDTLS_PRIVATE(pub_raw),
+                                             sizeo=
f(mut_prv->MBEDTLS_PRIVATE(pub_raw)),
+                                    =
         &mut_prv->MBEDTLS_PRIVATE(pub_raw_len))));
+    }
+#endif
     ret=
urn mbedtls_pk_check_pair(pub, prv);
 #else
     return mbedtls_pk_check_pa=
ir(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
=
Gerrit-Change-Number: 1849
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: MaxF <max@=
max-fillinger=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--ldLiLwPzFis=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1849?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">mbedtls: Work-around bug in mbedtls 4=2E1=
=2E0 and 4=2E2=2E0<br><br>Since the first distros have started to pick up t=
hese<br>versions before a fix is released, let&#39;s make our tests<br>pass=
 on these versions=2E<br><br>A fix is merged, so it might be fixed in 4=2E3=
=2E0=2E But I<br>didn&#39;t want to add that to the version check until we<=
br>have verified that=2E<br><br>Change-Id: I694410615958afbb422d9ead71f04c1=
a60edc640<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849<br>Message-Id: &lt;202608=
28201757=2E744-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38802=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Egithu=
b/workflows/build=2Eyaml<br>M src/openvpn/mbedtls_compat=2Eh<br>2 files cha=
nged, 14 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egith=
ub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><spa=
n>index 29e8be2a=2E=2E56dd3ed 100644</span><br><span>--- a/=2Egithub/workfl=
ows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</sp=
an><br><span>@@ -365,7 +365,7 @@</span><br><span>       ovpnlibdesc: mbed T=
LS 4=2E</span><br><span>       # versioning=3Dsemver-coerced</span><br><spa=
n>       ghrepo: Mbed-TLS/mbedtls</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      gitref: v4=2E0=2E0</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      gitref: v4=2E2=2E0</span><br><span>       libconfigu=
re: cmake -B build -DCMAKE_INSTALL_PREFIX=3D$LIBPREFIX</span><br><span>    =
   libmake: cmake --build build</span><br><span>       libinstall: sudo cma=
ke --install build</span><br><span>diff --git a/src/openvpn/mbedtls_compat=
=2Eh b/src/openvpn/mbedtls_compat=2Eh</span><br><span>index 50739b6=2E=2Eec=
45a0f 100644</span><br><span>--- a/src/openvpn/mbedtls_compat=2Eh</span><br=
><span>+++ b/src/openvpn/mbedtls_compat=2Eh</span><br><span>@@ -43,6 +43,7 =
@@</span><br><span> #include &quot;crypto_mbedtls_legacy=2Eh&quot;</span><b=
r><span> #else</span><br><span> #include &lt;mbedtls/oid=2Eh&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_mbedtls=
=2Eh&quot;</span><br><span> #endif /* MBEDTLS_VERSION_NUMBER &lt; 0x0400000=
0 */</span><br><span> </span><br><span> #ifdef HAVE_PSA_CRYPTO_H</span><br>=
<span>@@ -228,6 +229,18 @@</span><br><span> mbedtls_compat_pk_check_pair(co=
nst mbedtls_pk_context *pub, const mbedtls_pk_context *prv)</span><br><span=
> {</span><br><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* work around bug in mb=
edtls 4=2E1=2E0 by adding missing public key information in prv</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * cf=2E https://github=2Ec=
om/Mbed-TLS/TF-PSA-Crypto/issues/807 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04010000</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (prv-&gt;MBEDTLS_PRIVA=
TE(pub_raw_len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
mbedtls_pk_context *mut_prv =3D (mbedtls_pk_context *)prv; /* remove const =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(mb=
ed_ok(psa_export_public_key(mut_prv-&gt;MBEDTLS_PRIVATE(priv_id),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
    sizeof(mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw)),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
&amp;mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw_len))));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span>     return mbedtls_pk_check_pair(pu=
b, prv);</span><br><span> #else</span><br><span>     return mbedtls_pk_chec=
k_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1849?usp=3Demail">change 1849</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1849?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc=
640 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1849 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--ldLiLwPzFis=--


--===============5851257201931413167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5851257201931413167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5851257201931413167==--

