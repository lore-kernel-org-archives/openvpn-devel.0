Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C3C61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vrqOlZbUXn/Y6T2Rf21JQm5/BthEoT465Rc2FW7U41w=; b=gODIqN4ZQnaszxwA5XpZLVaCMm
	dyyGWzcAIJGSbxeBpGIF34zcSF+W3RFa0JAaXk2iyBWy8yu8QxrI+iQtI7r3hJ7LB3hlQ/gyVZv7Y
	nFPDEraPN99jofj5WFKXKnRFSRS9pP8oGLkvxIMHGDEyt9MOzfCtN+IZLUwwhaKYz7zI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0id3-0004PK-Cz;
	Sun, 30 Aug 2026 16:43:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0id1-0004PD-RL
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pJz11fuBE1QcQY3+1evfS9ucLO4IRBrQtJ/1tstR7bQ=; b=eGXd5xjoQZoY3XnLsVFdVTWEVo
 f2rsjAJs3O1Jk6BeDpRgz+16fKXMdoYKlRRzU4r70FZjSY1U5OBcd2CzeKKBnHPXHXn4umFcQwaJj
 t6UFFescPtkhlh9tY0naXCC4dCk1Yaqkt6NVhBtW/rSRWKOzvgPNIERCrcWtU5/GV5Xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pJz11fuBE1QcQY3+1evfS9ucLO4IRBrQtJ/1tstR7bQ=; b=b
 VdpHNu3+HUElrfhhXJqLe51dfqBANIIyQeHHsxyA3KTc42s/sXsHdaCCb7D36Ao53lysb0q9n4zZt
 Z2LLqV9yhIycvtikTh/HCehkQ++EBbUN7tTVr1i2yVY3Cmk43QV0QSodTs0GAQ5mW3oRffYm6JupL
 mijL71zHjkUtVosc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0id1-0000XW-0B for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:43:31 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso6100675e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788108204; x=1788713004; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pJz11fuBE1QcQY3+1evfS9ucLO4IRBrQtJ/1tstR7bQ=;
 b=SJA/3TeWMn67Cl6yulEyfR4QLX6D5SZuZU3gvhU95r1toDoOJiXPmgWtNzGF0YZXxp
 BZWjXByXyFmCjMvy8MdAGMhCLTTgHw2+gc239utg0PSA5JJ5KTfKNadWTGuU1TwkNBGF
 5i0dR47RHjFIdWT6+xXxgvqcINVC9ql8vVh7mAgOYAbrGSNZzB6I+CODwJnBeiVCKm3h
 rDWXKun3cOG4aqA69K28gtCiPCb9xvDW/fggv006/5s5+V34Su+4z455oCgQar3F5p6g
 F8yKyX1fla/AVIZ53GHVR/OEut7fvvj+6YYC6EKG32y6ry4yL2vKWoaALlpTNECMIOsk
 QbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788108204; x=1788713004;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pJz11fuBE1QcQY3+1evfS9ucLO4IRBrQtJ/1tstR7bQ=;
 b=mPE9zM4ZCrgG0bbEH8RHOTM/mj0kX8xi25FH8iJNMSyUg6G/9HmU1gz2ViTPmFwPAo
 7ut37PpanOT9MJNel2jG9/4+LRCbm5wdKIUixe6fulHBdsBwwXjBdRfvKa0/6F5W6Rvk
 I6m17YugODXNDZXtoLY28pbUSNVYeTczfDtSeHladK6zP7GrAE9eSjtERgCS0RnWF2Py
 DrLXThkoAdW5b6hIPeOi0j1Xr3lgYVcByP0v6R3BbWBaRO0IOzDwMYiU8deXrTEM6qWz
 oMypa57SzyneetVgJyYcUo826WE773SQ3GAY/WpFXI+4typIL+/lZZv8PeyXZoVyQD7l
 PfHg==
X-Gm-Message-State: AFuF++mHNc2a62R32UXmZZA/S20fz84BAevPuekAaq55f1J6o1m+iPWI
 guT0kV7OLx0+9DBuxnNahjfCga3U9kfjzOXXg4TiWsfsluCpFQ4U6xNk2+vzW92lkHCtmwFhtQJ
 tdiPik+PcGZjNf8wMRDKHORA7vx09XOkubkQ6CgGNJA3SZZkYERbVj7/OJcfFP8OKQqXi
X-Gm-Gg: AR+sD13Kur244jRv4EZMBm4PjF+Vvct5KlKvnsT4SqINhZrAMvtT0dFH2125wBkA8pM
 FImI8X4A+TOACZbCUOfIq67+dBmWFgdMMp+b0K2591RUagYJQrP2hFUk72HyogL1o7ABjAdqpbd
 xJpFfulE9PIH6jqUGPJVU1wiE5hwp9RiOxGm7tLBNvGYAdjJ2kmlohfxvv1ZN1ISFgm81oKTRG7
 ClFEiZj9XnZ03uIXcfRP96P9WM1czLpZw+MfgIWAkbzTlx9kYVsd5+hVHrMz0IVfIhrcdgwC6Dg
 m6KzuQCclBnfRcIzPozxnBH23fG38enfmPK/zv40t+cuCMKAinr7S3udxQ852n90rb3c4qR/B/b
 RYrAhiCsANE4SgdcBLbcUefiAhrbDlHxf7hqSIU4h7SKrDO7TVQu2Tse1E2eqJ9qXMb6FDEXpmZ
 jdOKCMLD0XDIC9vya9/gwQZ1AhWSueoI/wGhQgkp4tW5rgRpPeJCfKB/Ej7hAiU8A0cSXU6PSH9
 YGLA/03Kxkv2nWsvtPjVlEWCi7XmVwawQ/2jaTfjeGPmtpqMMCWLPq0noAiQqu4azad/3Q5J67j
 I+q3vEtq+W0nQMeFR8LUdpKIJRmgJ7bmpjVOnsJnJ0VhdV/VeKVf
X-Received: by 2002:a05:600c:b85:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49cc96ad411mr225106685e9.12.1788108203995; 
 Sun, 30 Aug 2026 09:43:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dc0f57sm247270385e9.2.2026.08.30.09.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:43:23 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 16:43:22 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 5f6f272a11b64cf93513a54ef8b07d34ff2bd89e
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f91df07738fef659aa7eaf7f9e269db9558410b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0id1-0000XW-0B
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
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============1680767455125710737=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1680767455125710737==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SluRhO4NH/Y="; charset=UTF-8

--SluRhO4NH/Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: mbedtls: Work-around bug in mbedtls 4=2E1=2E0 =
and 4=2E2=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


mbedtls: Work-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0

Since the fi=
rst distros have started to pick up these
versions before a fix is released=
, let's make our tests
pass on these versions=2E

A fix is merged, so it mi=
ght be fixed in 4=2E3=2E0=2E But I
didn't want to add that to the version c=
heck until we
have verified that=2E

Change-Id: I694410615958afbb422d9ead71=
f04c1a60edc640
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
A=
cked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1849
Message-Id: <20260828201757=2E744-1-gert@=
greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg38802=2Ehtml
Signed-off-by: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M src/openvpn/mbed=
tls_compat=2Eh
2 files changed, 14 insertions(+), 1 deletion(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1849/3

diff -=
-git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
=
index 29e8be2a=2E=2E56dd3ed 100644
--- a/=2Egithub/workflows/build=2Eyaml
+=
++ b/=2Egithub/workflows/build=2Eyaml
@@ -365,7 +365,7 @@
       ovpnlibdes=
c: mbed TLS 4=2E
       # versioning=3Dsemver-coerced
       ghrepo: Mbed-T=
LS/mbedtls
-      gitref: v4=2E0=2E0
+      gitref: v4=2E2=2E0
       libco=
nfigure: cmake -B build -DCMAKE_INSTALL_PREFIX=3D$LIBPREFIX
       libmake:=
 cmake --build build
       libinstall: sudo cmake --install build
diff --g=
it a/src/openvpn/mbedtls_compat=2Eh b/src/openvpn/mbedtls_compat=2Eh
index =
50739b6=2E=2Eec45a0f 100644
--- a/src/openvpn/mbedtls_compat=2Eh
+++ b/src/=
openvpn/mbedtls_compat=2Eh
@@ -43,6 +43,7 @@
 #include "crypto_mbedtls_lega=
cy=2Eh"
 #else
 #include <mbedtls/oid=2Eh>
+#include "crypto_mbedtls=2Eh"
 =
#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 
 #ifdef HAVE_PSA_CRYPTO_=
H
@@ -228,6 +229,18 @@
 mbedtls_compat_pk_check_pair(const mbedtls_pk_conte=
xt *pub, const mbedtls_pk_context *prv)
 {
 #if MBEDTLS_VERSION_NUMBER >=3D=
 0x04000000
+    /* work around bug in mbedtls 4=2E1=2E0 by adding missing =
public key information in prv
+     * cf=2E https://github=2Ecom/Mbed-TLS/T=
F-PSA-Crypto/issues/807 */
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04010000
+   =
 if (prv->MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)
+    {
+        mbedtls_pk=
_context *mut_prv =3D (mbedtls_pk_context *)prv; /* remove const */
+      =
  ASSERT(mbed_ok(psa_export_public_key(mut_prv->MBEDTLS_PRIVATE(priv_id),
+=
                                             mut_prv->MBEDTLS_PRIVATE(pub_r=
aw),
+                                             sizeof(mut_prv->MBEDTLS_=
PRIVATE(pub_raw)),
+                                             &mut_prv->=
MBEDTLS_PRIVATE(pub_raw_len))));
+    }
+#endif
     return mbedtls_pk_chec=
k_pair(pub, prv);
 #else
     return mbedtls_pk_check_pair(pub, prv, mbedtl=
s_ctr_drbg_random, rand_ctx_get());

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1849?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
Gerrit-Change-=
Number: 1849
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: MaxF <max@max-fillinger=
=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--SluRhO4NH/Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">mbedtls: Work-around bug=
 in mbedtls 4=2E1=2E0 and 4=2E2=2E0<br><br>Since the first distros have sta=
rted to pick up these<br>versions before a fix is released, let&#39;s make =
our tests<br>pass on these versions=2E<br><br>A fix is merged, so it might =
be fixed in 4=2E3=2E0=2E But I<br>didn&#39;t want to add that to the versio=
n check until we<br>have verified that=2E<br><br>Change-Id: I694410615958af=
bb422d9ead71f04c1a60edc640<br>Signed-off-by: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849<br>Messa=
ge-Id: &lt;20260828201757=2E744-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3880=
2=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M =2Egithub/workflows/build=2Eyaml<br>M src/openvpn/mbedtls_compat=
=2Eh<br>2 files changed, 14 insertions(+), 1 deletion(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/4=
9/1849/3</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/=
workflows/build=2Eyaml</span><br><span>index 29e8be2a=2E=2E56dd3ed 100644</=
span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b=
/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -365,7 +365,7 @@</span=
><br><span>       ovpnlibdesc: mbed TLS 4=2E</span><br><span>       # versi=
oning=3Dsemver-coerced</span><br><span>       ghrepo: Mbed-TLS/mbedtls</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      gitref: v4=2E0=2E0</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      gitref: v4=2E2=
=2E0</span><br><span>       libconfigure: cmake -B build -DCMAKE_INSTALL_PR=
EFIX=3D$LIBPREFIX</span><br><span>       libmake: cmake --build build</span=
><br><span>       libinstall: sudo cmake --install build</span><br><span>di=
ff --git a/src/openvpn/mbedtls_compat=2Eh b/src/openvpn/mbedtls_compat=2Eh<=
/span><br><span>index 50739b6=2E=2Eec45a0f 100644</span><br><span>--- a/src=
/openvpn/mbedtls_compat=2Eh</span><br><span>+++ b/src/openvpn/mbedtls_compa=
t=2Eh</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #include &quot;cry=
pto_mbedtls_legacy=2Eh&quot;</span><br><span> #else</span><br><span> #inclu=
de &lt;mbedtls/oid=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;crypto_mbedtls=2Eh&quot;</span><br><span> #endif /* M=
BEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><span> </span><br><span>=
 #ifdef HAVE_PSA_CRYPTO_H</span><br><span>@@ -228,6 +229,18 @@</span><br><s=
pan> mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbed=
tls_pk_context *prv)</span><br><span> {</span><br><span> #if MBEDTLS_VERSIO=
N_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* work around bug in mbedtls 4=2E1=2E0 by adding missing publi=
c key information in prv</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * cf=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION=
_NUMBER &gt;=3D 0x04010000</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (prv-&gt;MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        mbedtls_pk_context *mut_prv =3D (mbedtl=
s_pk_context *)prv; /* remove const */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ASSERT(mbed_ok(psa_export_public_key(mut_prv-&gt=
;MBEDTLS_PRIVATE(priv_id),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                             mut_prv-&gt;MBEDTLS_PRI=
VATE(pub_raw),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                        sizeof(mut_prv-&gt;MBEDTLS_PRIVATE(=
pub_raw)),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                    &amp;mut_prv-&gt;MBEDTLS_PRIVATE(pub_ra=
w_len))));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
     return mbedtls_pk_check_pair(pub, prv);</span><br><span> #else</span><=
br><span>     return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_rando=
m, rand_ctx_get());</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">change 1=
849</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I694410615958afbb422d9ead71f04c1a60edc640 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1849 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@max-fillinger=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--SluRhO4NH/Y=--


--===============1680767455125710737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1680767455125710737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1680767455125710737==--

