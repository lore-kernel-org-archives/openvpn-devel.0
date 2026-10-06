Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4979CCA6002
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ri2dCY96O/Q5scw2NRpOmpA2LrKTEydivcicROk3A4E=; b=HXvwIkikSiaFj+
	lMaw63HBkb551XtuBeruMbohdAqGWP11Gvwd8MOeMuyJBLWN4vsXIf4IFSK7zgkQyX9k2H4Nkh8nC
	/G0mtSsusmE8kubs4FG7ol963qowyr9GnpA94DLVopbUMeufvf/pBi2smX8VRnbfwxE9nUAPhqCxF
	s0Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE3RM-0002fm-GH;
	Tue, 06 Oct 2026 11:34:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE3RK-0002ff-Ej
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 11:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0k9B38dq4yiBuCdLXJ1QHXRo7QzMF+8t0KPVAflozk=; b=HWStnJeeLqepTckecRiH3zyvZF
 gcjjbKlGdQXFOO4oSbAXXDXJ8TpENQXJxV9m/XzIJsbfAhdZWsYgiRs2qKlqPqT7PVL+TCeYKRLIW
 PAbIwt02gfXDaTxPpf4zf14ts6sI+MrK1e9YAzUDe2DCMH7bkavmAAr4QV2dgMvinG1k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O0k9B38dq4yiBuCdLXJ1QHXRo7QzMF+8t0KPVAflozk=; b=n
 SlVwj4Ne5SiCb7i4di+U942oTmuRcuVPVqdjGHSQE2w/MPDONtC1N9wOXNvbYD1xLheonvYUQIXWG
 yzlOIolDHbPkjIrLCkP+y58qlNSb+kgyIqUfXLFciwvPf4cxU388UecLV6Emnpu5zJLDDF1uTKOE9
 nla7s3xQutk3Mf1Q=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE3RC-0003oP-Hf for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 11:34:35 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso24948905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791286460; x=1791891260; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O0k9B38dq4yiBuCdLXJ1QHXRo7QzMF+8t0KPVAflozk=;
 b=bMMK099DhIX6SuXhbS6KkF1mhWpDVxvmI2Gwf3ohNMTmSjHontrJN9mCbooY81+OtK
 nT62D4nWv7LfI+UvAO37W0To2epGUpPb6vYQcBKBp90JyhiqvmXCWiGgGmaqv/dwwSQA
 KMz3gD7/5RFsatDo/bm7VC5PzkZDL1ovZCdud9TkrFmeTvZFRczhEH1P4nK88p5nBcL4
 myC5lxCow3o6R2y7ds14TumiFO17Fwh5RAxFO/1VxOUZZpNpLpdm7ongfhpmHC3SUqVw
 gYlcaGjGLly8oCoP6YL28iCrhoPV6lvCNRcaLnagYuVVEUvq2SCtb0uz+hx2b432Myuz
 queg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791286460; x=1791891260;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O0k9B38dq4yiBuCdLXJ1QHXRo7QzMF+8t0KPVAflozk=;
 b=R5nNtR02hL5qWGkENBHAupNgUIE+WgxmbZ2rqc9SG4ipemAn5APrGQUDlTh93kVZIr
 i56E28fFXCungtGiMdJknKnMJwVd4T1+nWgG+bjYmzQ5I7o10RRt2G86QeeDpHg+gSsy
 QO9d+4PGzbIhvehHrbaQSQlyOim9AwcDftepHkMgBS2oedYiPPTVz4qOJuo/WmAFXdEm
 cyAAtUXwWez4Glv88j8vsPI7qOt6Ce8Ke88A22bqwP+Lq6KQrP4qUpM0hpvVYYFUBc8F
 OQ4oVENV2rWIGoms9hysNdft1BC50CJZgdyJeXbHB0LPpqGtngpdrQzv4f74EqZAZoRo
 j5wA==
X-Gm-Message-State: AFuF++lYW1N1w9iO+6eRmMslVcc400ZXUzEJP+XhF/uLB28QRLBnLC7Z
 SMtDhra0ljufCBm/Y/NufqHXsLWwHhpw649DmZMnm0cMewbXQs+1iC80fSwFlHBTcM9J5r8baNH
 rULI5XRXclnZ9uuom0EaNEOvzEts9hcrcRhff+q+u0ylfh9yeFf4Pu4cLCxhQ0Qoyfwtv
X-Gm-Gg: AYBFou1jEo/eXTzQf3XVso5TKR1p/t2tAmxZsRvHhldxsVCVac/CkmuUGcfYUXPyq0d
 ZowMnBauJBWKL6TzOPZiaTvaNoX+w35crSD0fXgNwRK5YNC+91+7CflQLbMrmjQ8vJrcsg/QIjY
 JMcFFZHXdjRGLLJLqY1brnYeu/sjFSiWYGbN2Vdjla0SGaY49jPdIdZ05YgmMgNsqtwG4wv7F9o
 GJqzBSq/zq4xOLDPLke2JFhC656Tm4i+UCzvQ2LtF1pu/+yWsjDk2ddRn3G5etpuWJslqoOTjF3
 MShpgX4mg7tkdzoZvV2+p1yD+IZUHOJYqbS+SXFRgYU/XZiLrpSHRq+FyyhfPl8eTwfIEVqKZSg
 VvT6+/3O8ZH4Di8o3pfE0ixw3tinbbfmbBjSZG99MfIF8TFtuRFqLBytGAdxFntvZmMPyRXXWFZ
 QYaDqROeyFpsx8P24RsiwZXW7DQIsgdMzeXlmIWi4aViUmiU5jxlHcsRzCayWyifDHGmMknz02F
 Rg0aoUfVPOIGO6+78VzQc4z/wdip995dIgz2E9NZ61fq0cu+4kNQDcu2asaUZQfDXAZf7P3lhiL
 be0xFChaf2vPEcUjnvRKLGnn4e2CaTLaSAS2zVrj3kKuLoGU2afZtJV9bq0R
X-Received: by 2002:a05:600c:3b13:b0:4a0:263c:704f with SMTP id
 5b1f17b1804b1-4a17b541f6cmr19355495e9.16.1791286459102; 
 Tue, 06 Oct 2026 04:34:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c50f54sm62151945e9.10.2026.10.06.04.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 04:34:18 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 11:34:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I25fad88fb4bb8e841a50981e3197d5b8d8f9069b
X-Gerrit-Change-Number: 1982
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1982?usp=email>
X-Gerrit-Commit: a56b4a206a7a97c5521e2eabfe969704a5d8232e
References: <gerrit.1791286452000.I25fad88fb4bb8e841a50981e3197d5b8d8f9069b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkyNWZhZDg4ZmI0YmI4ZTg0MWE1MDk4MWUzMTk3ZDViOGQ4ZjkwNjliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0df331960096b1a0266fd72fb41136f20e9a61c2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE3RC-0003oP-Hf
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: clarify RX peer
 ID naming and types
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1047300127541944837=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1047300127541944837==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dEFxKmpwcRM="; charset=UTF-8

--dEFxKmpwcRM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1982?usp=3Demail

to review the following change=2E
=


Change subject: dco: clarify RX peer ID naming and types
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: clarify RX peer ID nami=
ng and types

The peer ID used to address a peer in DCO is its local RX ID=
=2E Make that
explicit in the installed-peer handle, notification fields, a=
nd DCO API
parameters across all backends=2E

Use an unsigned local RX ID w=
hen creating a peer and make conversions
explicit at the signed DCO handle =
and Linux notification/statistics
boundaries=2E Keep DCO handles signed for=
 their -1 sentinel=2E

This prepares asymmetric peer ID support without cha=
nging behavior for
valid peer IDs=2E

Change-Id: I25fad88fb4bb8e841a50981e3=
197d5b8d8f9069b
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M src/o=
penvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/op=
envpn/dco_freebsd=2Eh
M src/openvpn/dco_internal=2Eh
M src/openvpn/dco_linu=
x=2Ec
M src/openvpn/dco_linux=2Eh
M src/openvpn/dco_win=2Ec
M src/openvpn/d=
co_win=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/=
ssl=2Ec
M src/openvpn/ssl_common=2Eh
13 files changed, 181 insertions(+), 1=
81 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/82/1982/1

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2E=
c
index 9fc0e3b=2E=2E15f32e1 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/ope=
nvpn/dco=2Ec
@@ -57,8 +57,8 @@
 
 {
     bool epoch =3D ks->crypto_options=
=2Eflags & CO_EPOCH_DATA_KEY_FORMAT;
-    msg(D_DCO_DEBUG, "%s: peer_id=3D%=
d keyid=3D%d epoch=3D%d, currently %d keys installed",
-        __func__, m=
ulti->dco_peer_id, ks->key_id, epoch, multi->dco_keys_installed);
+    msg(=
D_DCO_DEBUG, "%s: rx_peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys =
installed",
+        __func__, multi->dco_rx_peer_id, ks->key_id, epoch, mu=
lti->dco_keys_installed);
 
     /* Install a key in the PRIMARY slot only =
when no other key exist=2E
      * From that moment on, any new key will be=
 installed in the SECONDARY
@@ -71,7 +71,7 @@
         slot =3D OVPN_KEY_SL=
OT_SECONDARY;
     }
 
-    int ret =3D dco_new_key(multi->dco, multi->dco_=
peer_id, ks->key_id, slot, encrypt_key, encrypt_iv,
+    int ret =3D dco_ne=
w_key(multi->dco, multi->dco_rx_peer_id, ks->key_id, slot, encrypt_key, enc=
rypt_iv,
                           decrypt_key, decrypt_iv, ciphername, ep=
och);
     if (ret =3D=3D 0)
     {
@@ -148,14 +148,14 @@
     {
         m=
sg(D_DCO, "No encryption key found=2E Purging data channel keys");
 
-     =
   int ret =3D dco_del_key(dco, multi->dco_peer_id, OVPN_KEY_SLOT_PRIMARY);=

+        int ret =3D dco_del_key(dco, multi->dco_rx_peer_id, OVPN_KEY_SLOT=
_PRIMARY);
         if (ret < 0)
         {
             msg(D_DCO, "Cannot=
 delete primary key during wipe: %s (%d)", strerror(-ret), ret);
          =
   return false;
         }
 
-        ret =3D dco_del_key(dco, multi->dco_=
peer_id, OVPN_KEY_SLOT_SECONDARY);
+        ret =3D dco_del_key(dco, multi-=
>dco_rx_peer_id, OVPN_KEY_SLOT_SECONDARY);
         if (ret < 0)
         {=

             msg(D_DCO, "Cannot delete secondary key during wipe: %s (%d)"=
, strerror(-ret), ret);
@@ -172,8 +172,8 @@
     if (primary->dco_status =
=3D=3D DCO_NOT_INSTALLED)
     {
         msg(D_DCO, "DCO key state mismatc=
h: selected primary key is not installed "
-                   "(peer_id=3D=
%d, key_id=3D%d, dco_keys_installed=3D%d)",
-            multi->dco_peer_id=
, primary->key_id, multi->dco_keys_installed);
+                   "(rx_pee=
r_id=3D%d, key_id=3D%d, dco_keys_installed=3D%d)",
+            multi->dco_=
rx_peer_id, primary->key_id, multi->dco_keys_installed);
         return fa=
lse;
     }
 
@@ -202,12 +202,12 @@
         if (secondary && secondary->dc=
o_status !=3D DCO_INSTALLED_PRIMARY)
         {
             msg(D_DCO, "DC=
O key state mismatch: expected old primary key is not installed as DCO prim=
ary before swap "
-                       "(peer_id=3D%d, new_primary_key_i=
d=3D%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dco_keys_inst=
alled=3D%d)",
-                multi->dco_peer_id, primary->key_id, seconda=
ry->key_id, secondary->dco_status, multi->dco_keys_installed);
+           =
            "(rx_peer_id=3D%d, new_primary_key_id=3D%d, old_primary_key_id=
=3D%d, old_primary_dco_status=3D%d, dco_keys_installed=3D%d)",
+           =
     multi->dco_rx_peer_id, primary->key_id, secondary->key_id, secondary->=
dco_status, multi->dco_keys_installed);
             return false;
        =
 }
 
-        int ret =3D dco_swap_keys(dco, multi->dco_peer_id);
+        =
int ret =3D dco_swap_keys(dco, multi->dco_rx_peer_id);
         if (ret < 0=
)
         {
             msg(D_DCO, "Cannot swap keys: %s (%d)", strerror(=
-ret), ret);
@@ -224,7 +224,7 @@
     /* if we have no secondary key anymor=
e, inform DCO about it */
     if (!secondary && multi->dco_keys_installed =
=3D=3D 2)
     {
-        int ret =3D dco_del_key(dco, multi->dco_peer_id, =
OVPN_KEY_SLOT_SECONDARY);
+        int ret =3D dco_del_key(dco, multi->dco_=
rx_peer_id, OVPN_KEY_SLOT_SECONDARY);
         if (ret < 0)
         {
    =
         msg(D_DCO, "Cannot delete secondary key: %s (%d)", strerror(-ret),=
 ret);
@@ -538,10 +538,10 @@
 #ifdef TARGET_FREEBSD
     /* In Linux in P2P=
 mode the kernel automatically removes an existing peer
      * when adding=
 a new peer=2E FreeBSD needs to explicitly be told to do that */
-    if (c=
->c2=2Etls_multi->dco_peer_id !=3D -1)
+    if (c->c2=2Etls_multi->dco_rx_p=
eer_id !=3D -1)
     {
-        dco_del_peer(&c->c1=2Etuntap->dco, c->c2=2E=
tls_multi->dco_peer_id);
-        c->c2=2Etls_multi->dco_peer_id =3D -1;
+ =
       dco_del_peer(&c->c1=2Etuntap->dco, c->c2=2Etls_multi->dco_rx_peer_id=
);
+        c->c2=2Etls_multi->dco_rx_peer_id =3D -1;
     }
 #endif
     i=
nt ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->sd, =
NULL,
@@ -552,7 +552,7 @@
         return ret;
     }
 
-    c->c2=2Etls_mu=
lti->dco_peer_id =3D multi->rx_peer_id;
+    c->c2=2Etls_multi->dco_rx_peer=
_id =3D (int)multi->rx_peer_id;
 
     return 0;
 }
@@ -565,10 +565,10 @@
 =
        return;
     }
 
-    if (c->c1=2Etuntap && c->c2=2Etls_multi && c-=
>c2=2Etls_multi->dco_peer_id !=3D -1)
+    if (c->c1=2Etuntap && c->c2=2Etl=
s_multi && c->c2=2Etls_multi->dco_rx_peer_id !=3D -1)
     {
-        dco_d=
el_peer(&c->c1=2Etuntap->dco, c->c2=2Etls_multi->dco_peer_id);
-        c->=
c2=2Etls_multi->dco_peer_id =3D -1;
+        dco_del_peer(&c->c1=2Etuntap->=
dco, c->c2=2Etls_multi->dco_rx_peer_id);
+        c->c2=2Etls_multi->dco_rx=
_peer_id =3D -1;
     }
 }
 
@@ -627,7 +627,7 @@
 {
     const struct conte=
xt *c =3D &mi->context;
 
-    int peer_id =3D c->c2=2Etls_multi->rx_peer_i=
d;
+    uint32_t rx_peer_id =3D c->c2=2Etls_multi->rx_peer_id;
     struct =
sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage loc=
al =3D { 0 };
     const socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]=
->sd;
@@ -665,13 +665,13 @@
     }
 
     int ret =3D
-        dco_new_peer=
(&c->c1=2Etuntap->dco, peer_id, sd, localaddr, remoteaddr, vpn_addr4, vpn_a=
ddr6);
+        dco_new_peer(&c->c1=2Etuntap->dco, rx_peer_id, sd, localadd=
r, remoteaddr, vpn_addr4, vpn_addr6);
     if (ret < 0)
     {
         ret=
urn ret;
     }
 
-    c->c2=2Etls_multi->dco_peer_id =3D peer_id;
+    c->=
c2=2Etls_multi->dco_rx_peer_id =3D (int)rx_peer_id;
 
     return 0;
 }
dif=
f --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index d074257=2E=2E0a8c=
9da 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -180,14 +=
180,14 @@
  * and -1 (do not touch)=2E
  *
  * @param dco                DC=
O device context
- * @param peer_id            the ID of the peer to be mod=
ified
+ * @param rx_peer_id         the RX ID of the peer to be modified
  =
* @param keepalive_interval keepalive interval in seconds
  * @param keepal=
ive_timeout  keepalive timeout in seconds
  * @param mss                TCP=
 MSS value
  *
  * @return                   0 on success or a negative err=
or code otherwise
  */
-int dco_set_peer(dco_context_t *dco, unsigned int p=
eerid, int keepalive_interval,
+int dco_set_peer(dco_context_t *dco, unsign=
ed int rx_peer_id, int keepalive_interval,
                  int keepalive_=
timeout, int mss);
 
 /**
@@ -349,7 +349,7 @@
 }
 
 static inline int
-dco_=
set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interval, i=
nt keepalive_timeout,
+dco_set_peer(dco_context_t *dco, unsigned int rx_pee=
r_id, int keepalive_interval, int keepalive_timeout,
              int mss)=

 {
     return 0;
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/d=
co_freebsd=2Ec
index 9ace240=2E=2E178b754 100644
--- a/src/openvpn/dco_free=
bsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -133,7 +133,7 @@
 }
 
 int
-dc=
o_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr=
 *localaddr,
+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, int=
 sd, struct sockaddr *localaddr,
              struct sockaddr *remoteaddr,=
 const struct in_addr *vpn_ipv4,
              const struct in6_addr *vpn_i=
pv6)
 {
@@ -143,7 +143,7 @@
 
     nvl =3D nvlist_create(0);
 
-    msg(D_D=
CO_DEBUG, "%s: peer-id %u, fd %d", __func__, peerid, sd);
+    msg(D_DCO_DE=
BUG, "%s: rx-peer-id %u, fd %d", __func__, rx_peer_id, sd);
 
     if (loca=
laddr)
     {
@@ -168,7 +168,7 @@
     }
 
     nvlist_add_number(nvl, "fd"=
, sd);
-    nvlist_add_number(nvl, "peerid", peerid);
+    nvlist_add_numbe=
r(nvl, "peerid", rx_peer_id);
 
     CLEAR(drv);
     snprintf(drv=2Eifd_na=
me, IFNAMSIZ, "%s", dco->ifname);
@@ -353,16 +353,16 @@
 }
 
 int
-dco_swap=
_keys(dco_context_t *dco, unsigned int peerid)
+dco_swap_keys(dco_context_t=
 *dco, unsigned int rx_peer_id)
 {
     struct ifdrv drv;
     nvlist_t *nv=
l;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid=
);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", __func__, rx_peer_id);
 
    =
 nvl =3D nvlist_create(0);
-    nvlist_add_number(nvl, "peerid", peerid);
+=
    nvlist_add_number(nvl, "peerid", rx_peer_id);
 
     CLEAR(drv);
     s=
nprintf(drv=2Eifd_name, IFNAMSIZ, "%s", dco->ifname);
@@ -382,16 +382,16 @@=

 }
 
 int
-dco_del_peer(dco_context_t *dco, unsigned int peerid)
+dco_del_=
peer(dco_context_t *dco, unsigned int rx_peer_id)
 {
     struct ifdrv drv;=

     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %u"=
, __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", __func__, r=
x_peer_id);
 
     nvl =3D nvlist_create(0);
-    nvlist_add_number(nvl, "p=
eerid", peerid);
+    nvlist_add_number(nvl, "peerid", rx_peer_id);
 
     =
CLEAR(drv);
     snprintf(drv=2Eifd_name, IFNAMSIZ, "%s", dco->ifname);
@@ =
-411,17 +411,17 @@
 }
 
 int
-dco_del_key(dco_context_t *dco, unsigned int =
peerid, dco_key_slot_t slot)
+dco_del_key(dco_context_t *dco, unsigned int =
rx_peer_id, dco_key_slot_t slot)
 {
     struct ifdrv drv;
     nvlist_t *n=
vl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __func=
__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, slot %d", __fu=
nc__, rx_peer_id, slot);
 
     nvl =3D nvlist_create(0);
     nvlist_add_n=
umber(nvl, "slot", slot);
-    nvlist_add_number(nvl, "peerid", peerid);
+ =
   nvlist_add_number(nvl, "peerid", rx_peer_id);
 
     CLEAR(drv);
     sn=
printf(drv=2Eifd_name, IFNAMSIZ, "%s", dco->ifname);
@@ -480,7 +480,7 @@
 }=

 
 int
-dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dc=
o_key_slot_t slot,
+dco_new_key(dco_context_t *dco, unsigned int rx_peer_id=
, int keyid, dco_key_slot_t slot,
             const uint8_t *encrypt_key, =
const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
             const u=
int8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
@@ -488,14 +488,=
14 @@
     nvlist_t *nvl, *encrypt_nvl, *decrypt_nvl;
     int ret;
 
-    =
msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d",=
 __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id =
%d, rx-peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, rx_peer_id,=

         ciphername, epoch);
 
     nvl =3D nvlist_create(0);
 
     nvlis=
t_add_number(nvl, "slot", slot);
     nvlist_add_number(nvl, "keyid", keyid=
);
-    nvlist_add_number(nvl, "peerid", peerid);
+    nvlist_add_number(nv=
l, "peerid", rx_peer_id);
 
     encrypt_nvl =3D key_to_nvlist(encrypt_key,=
 encrypt_iv, ciphername);
     decrypt_nvl =3D key_to_nvlist(decrypt_key, d=
ecrypt_iv, ciphername);
@@ -527,18 +527,18 @@
 }
 
 int
-dco_set_peer(dco_c=
ontext_t *dco, unsigned int peerid, int keepalive_interval, int keepalive_t=
imeout,
+dco_set_peer(dco_context_t *dco, unsigned int rx_peer_id, int keep=
alive_interval, int keepalive_timeout,
              int mss)
 {
     struc=
t ifdrv drv;
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s:=
 peer-id %u, ping interval %d, ping timeout %d", __func__, peerid,
+    msg=
(D_DCO_DEBUG, "%s: rx-peer-id %u, ping interval %d, ping timeout %d", __fun=
c__, rx_peer_id,
         keepalive_interval, keepalive_timeout);
 
     nv=
l =3D nvlist_create(0);
-    nvlist_add_number(nvl, "peerid", peerid);
+   =
 nvlist_add_number(nvl, "peerid", rx_peer_id);
     nvlist_add_number(nvl, =
"interval", keepalive_interval);
     nvlist_add_number(nvl, "timeout", kee=
palive_timeout);
 
@@ -560,21 +560,21 @@
 }
 
 static void
-dco_update_peer=
_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
+dco_u=
pdate_peer_stat(struct multi_context *m, uint32_t rx_peer_id, const nvlist_=
t *nvl)
 {
-    if (peerid >=3D m->max_clients || !m->instances[peerid])
+ =
   if (rx_peer_id >=3D m->max_clients || !m->instances[rx_peer_id])
     {
=
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %u returned by =
kernel", peerid);
+        msg(M_WARN, "dco_update_peer_stat: invalid peer =
RX ID %u returned by kernel", rx_peer_id);
         return;
     }
 
-    s=
truct multi_instance *mi =3D m->instances[peerid];
+    struct multi_instan=
ce *mi =3D m->instances[rx_peer_id];
 
     mi->context=2Ec2=2Edco_read_byt=
es =3D nvlist_get_number(nvl, "in");
     mi->context=2Ec2=2Edco_write_byte=
s =3D nvlist_get_number(nvl, "out");
 
-    msg(D_DCO_DEBUG, "%s: peer-id %=
u, dco_read_bytes: " counter_format " dco_write_bytes: " counter_format,
- =
       __func__, peerid, mi->context=2Ec2=2Edco_read_bytes, mi->context=2Ec=
2=2Edco_write_bytes);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, dco_read_by=
tes: " counter_format " dco_write_bytes: " counter_format,
+        __func_=
_, rx_peer_id, mi->context=2Ec2=2Edco_read_bytes, mi->context=2Ec2=2Edco_wr=
ite_bytes);
 }
 
 int
@@ -609,10 +609,10 @@
         return -EINVAL;
     }=

 
-    /* dco_message_peer_id is signed int, because other parts of the
+ =
   /* dco_message_rx_peer_id is signed int, because other parts of the
    =
  * code treat "-1" as "this is a message not specific to one peer"
      *=
/
-    dco->dco_message_peer_id =3D (int)nvlist_get_number(nvl, "peerid");
=
+    dco->dco_message_rx_peer_id =3D (int)nvlist_get_number(nvl, "peerid");=

 
     type =3D (enum ovpn_notif_type)nvlist_get_number(nvl, "notification=
");
 
@@ -633,8 +633,8 @@
                     dco->dco_del_peer_reason =3D=
 OVPN_DEL_PEER_REASON_USERSPACE;
                 }
             }
-       =
     msg(D_DCO_DEBUG, "%s: received NOTIF_DEL_PEER for peer-id=3D%d, reason=
=3D%d", __func__,
-                dco->dco_message_peer_id, dco->dco_del_p=
eer_reason);
+            msg(D_DCO_DEBUG, "%s: received NOTIF_DEL_PEER for=
 rx-peer-id=3D%d, reason=3D%d", __func__,
+                dco->dco_message=
_rx_peer_id, dco->dco_del_peer_reason);
 
             if (nvlist_exists_nv=
list(nvl, "bytes"))
             {
@@ -642,7 +642,7 @@
 
                 i=
f (dco->c->mode =3D=3D CM_TOP)
                 {
-                    dco_=
update_peer_stat(dco->c->multi, dco->dco_message_peer_id, bytes);
+        =
            dco_update_peer_stat(dco->c->multi, dco->dco_message_rx_peer_id=
, bytes);
                 }
                 else
                 {
@@ -6=
55,8 +655,8 @@
             break;
 
         case OVPN_NOTIF_ROTATE_KEY:
-=
            msg(D_DCO_DEBUG, "%s: received NOTIF_ROTATE_KEY for peer-id=3D%=
d", __func__,
-                dco->dco_message_peer_id);
+            msg(=
D_DCO_DEBUG, "%s: received NOTIF_ROTATE_KEY for rx-peer-id=3D%d", __func__,=

+                dco->dco_message_rx_peer_id);
             dco->dco_messa=
ge_type =3D OVPN_CMD_SWAP_KEYS;
             break;
 
@@ -676,8 +676,8 @@
 =
                msg(M_WARN, "Failed to parse float notification");
        =
         break;
             }
-            msg(D_DCO_DEBUG, "%s: received =
NOTIF_FLOAT for peer-id=3D%d", __func__,
-                dco->dco_message_=
peer_id);
+            msg(D_DCO_DEBUG, "%s: received NOTIF_FLOAT for rx-pe=
er-id=3D%d", __func__,
+                dco->dco_message_rx_peer_id);
     =
        dco->dco_message_type =3D OVPN_CMD_FLOAT_PEER;
             break;
=
         }
@@ -885,7 +885,7 @@
     for (size_t i =3D 0; i < npeers; i++)
 =
    {
         const nvlist_t *peer =3D nvpeers[i];
-        uint32_t peeri=
d =3D (uint32_t)nvlist_get_number(peer, "peerid");
+        uint32_t rx_pee=
r_id =3D (uint32_t)nvlist_get_number(peer, "peerid");
         const nvlist=
_t *bytes =3D nvlist_get_nvlist(peer, "bytes");
 
         /* we can end he=
re in p2mp mode, or in p2p mode via
@@ -893,7 +893,7 @@
          */
      =
   if (dco->c->mode =3D=3D CM_TOP)
         {
-            dco_update_peer_=
stat(dco->c->multi, peerid, bytes);
+            dco_update_peer_stat(dco->=
c->multi, rx_peer_id, bytes);
         }
         else
         {
@@ -914,9=
 +914,9 @@
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_=
on_err)
 {
     ASSERT(c->c2=2Etls_multi);
-    msg(D_DCO_DEBUG, "%s: peer-=
id %d", __func__, c->c2=2Etls_multi->dco_peer_id);
+    msg(D_DCO_DEBUG, "%=
s: rx-peer-id %d", __func__, c->c2=2Etls_multi->dco_rx_peer_id);
 
-    if =
(c->c2=2Etls_multi->dco_peer_id < 0)
+    if (c->c2=2Etls_multi->dco_rx_pee=
r_id < 0)
     {
         return -EINVAL; /* DCO not active yet */
     }
d=
iff --git a/src/openvpn/dco_freebsd=2Eh b/src/openvpn/dco_freebsd=2Eh
index=
 5e2a552=2E=2E7b278fd 100644
--- a/src/openvpn/dco_freebsd=2Eh
+++ b/src/op=
envpn/dco_freebsd=2Eh
@@ -58,7 +58,7 @@
     char ifname[IFNAMSIZ];
 
     =
int dco_message_type;
-    int dco_message_peer_id;
+    int dco_message_rx=
_peer_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_fl=
oat_peer_ss;
 
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_=
internal=2Eh
index fcf8aca=2E=2Ec507184 100644
--- a/src/openvpn/dco_intern=
al=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -59,18 +59,18 @@
  * They are =
implemented by dco_linux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, u=
nsigned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
+in=
t dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, socket_descript=
or_t sd, struct sockaddr *localaddr,
                  struct sockaddr *rem=
oteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
=
 
-int dco_del_peer(dco_context_t *dco, unsigned int peerid);
+int dco_del_=
peer(dco_context_t *dco, unsigned int rx_peer_id);
 
-int dco_new_key(dco_c=
ontext_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
+int dc=
o_new_key(dco_context_t *dco, unsigned int rx_peer_id, int keyid, dco_key_s=
lot_t slot,
                 const uint8_t *encrypt_key, const uint8_t *enc=
rypt_iv, const uint8_t *decrypt_key,
                 const uint8_t *decryp=
t_iv, const char *ciphername, bool epoch);
 
-int dco_del_key(dco_context_t=
 *dco, unsigned int peerid, dco_key_slot_t slot);
+int dco_del_key(dco_cont=
ext_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot);
 
-int dco_swap_=
keys(dco_context_t *dco, unsigned int peerid);
+int dco_swap_keys(dco_conte=
xt_t *dco, unsigned int rx_peer_id);
 
 #endif /* defined(ENABLE_DCO) */
 #=
endif /* ifndef DCO_INTERNAL_H */
diff --git a/src/openvpn/dco_linux=2Ec b/=
src/openvpn/dco_linux=2Ec
index eabb3ea=2E=2E96b7521 100644
--- a/src/openv=
pn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -523,7 +523,7 @@
 }
 
 =
int
-dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct s=
ockaddr *localaddr,
+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_=
id, int sd, struct sockaddr *localaddr,
              struct sockaddr *remo=
teaddr, const struct in_addr *vpn_ipv4,
              const struct in6_addr=
 *vpn_ipv6)
 {
@@ -533,13 +533,13 @@
     {
         remotestr =3D print_so=
ckaddr(remoteaddr, &gc);
     }
-    msg(D_DCO_DEBUG, "%s: peer-id %u, fd %=
d, remote addr: %s", __func__, peerid, sd, remotestr);
+    msg(D_DCO_DEBUG=
, "%s: rx-peer-id %u, fd %d, remote addr: %s", __func__, rx_peer_id, sd, re=
motestr);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_=
CMD_PEER_NEW);
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_P=
EER);
     int ret =3D -EMSGSIZE;
 
-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID=
, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);
     NLA_P=
UT_U32(nl_msg, OVPN_A_PEER_SOCKET, sd);
 
     /* Set the remote endpoint i=
f defined (for UDP) */
@@ -754,7 +754,7 @@
 
     nl_socket_set_cb(dco->nl_=
sock, dco->nl_cb);
 
-    dco->dco_message_peer_id =3D -1;
+    dco->dco_me=
ssage_rx_peer_id =3D -1;
     nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, ovpn_nl_c=
b_error, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_FINISH, NL_CB_CUST=
OM, ovpn_nl_cb_finish, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_ACK,=
 NL_CB_CUSTOM, ovpn_nl_cb_finish, &dco->status);
@@ -880,9 +880,9 @@
 }
 
 =
int
-dco_swap_keys(dco_context_t *dco, unsigned int peerid)
+dco_swap_keys(=
dco_context_t *dco, unsigned int rx_peer_id)
 {
-    msg(D_DCO_DEBUG, "%s: =
peer-id %u", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", =
__func__, rx_peer_id);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_crea=
te(dco, OVPN_CMD_KEY_SWAP);
     if (!nl_msg)
@@ -892,7 +892,7 @@
 
     st=
ruct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
     int ret =
=3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
+ =
   NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);
     nla_nest_e=
nd(nl_msg, attr);
 
     ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
@=
@ -904,9 +904,9 @@
 
 
 int
-dco_del_peer(dco_context_t *dco, unsigned int =
peerid)
+dco_del_peer(dco_context_t *dco, unsigned int rx_peer_id)
 {
-    =
msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %u", __func__, peerid);
+    ms=
g(D_DCO_DEBUG | M_NOIPREFIX, "%s: rx-peer-id %u", __func__, rx_peer_id);
 
=
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL=
);
     if (!nl_msg)
@@ -916,7 +916,7 @@
 
     struct nlattr *attr =3D nla=
_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
-    NLA_PUT_=
U32(nl_msg, OVPN_A_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_I=
D, rx_peer_id);
     nla_nest_end(nl_msg, attr);
 
     ret =3D ovpn_nl_msg=
_send(dco, nl_msg, __func__);
@@ -928,10 +928,10 @@
 
 
 int
-dco_del_key(d=
co_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
+dco_del_key(d=
co_context_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot)
 {
     in=
t ret =3D -EMSGSIZE;
-    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __fun=
c__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, slot %d", __f=
unc__, rx_peer_id, slot);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_c=
reate(dco, OVPN_CMD_KEY_DEL);
     if (!nl_msg)
@@ -940,7 +940,7 @@
     }
=
 
     struct nlattr *keyconf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
-=
    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
+    NLA_PUT_U32(n=
l_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);
     NLA_PUT_U32(nl_msg, OVPN_A=
_KEYCONF_SLOT, slot);
     nla_nest_end(nl_msg, keyconf);
 
@@ -952,11 +952=
,11 @@
 }
 
 int
-dco_new_key(dco_context_t *dco, unsigned int peerid, int =
keyid, dco_key_slot_t slot,
+dco_new_key(dco_context_t *dco, unsigned int r=
x_peer_id, int keyid, dco_key_slot_t slot,
             const uint8_t *encr=
ypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
           =
  const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    ms=
g(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d", _=
_func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d=
, rx-peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, rx_peer_id,
 =
        ciphername, epoch);
 
     const size_t key_len =3D cipher_kt_key_s=
ize(ciphername);
@@ -974,7 +974,7 @@
     int ret =3D -EMSGSIZE;
 
     str=
uct nlattr *key_conf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
-    NLA_P=
UT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OV=
PN_A_KEYCONF_PEER_ID, rx_peer_id);
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_=
SLOT, slot);
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_KEY_ID, keyid);
     N=
LA_PUT_U32(nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, dco_cipher);
@@ -1006,10 +100=
6,10 @@
 }
 
 int
-dco_set_peer(dco_context_t *dco, unsigned int peerid, in=
t keepalive_interval, int keepalive_timeout,
+dco_set_peer(dco_context_t *d=
co, unsigned int rx_peer_id, int keepalive_interval, int keepalive_timeout,=

              int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive=
 %d/%d, mss %d", __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u=
, keepalive %d/%d, mss %d", __func__, rx_peer_id,
         keepalive_interv=
al, keepalive_timeout, mss);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlms=
g_create(dco, OVPN_CMD_PEER_SET);
@@ -1020,7 +1020,7 @@
 
     struct nlatt=
r *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE=
;
-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg=
, OVPN_A_PEER_ID, rx_peer_id);
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALI=
VE_INTERVAL, keepalive_interval);
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEP=
ALIVE_TIMEOUT, keepalive_timeout);
     nla_nest_end(nl_msg, attr);
@@ -116=
3,7 +1163,7 @@
 }
 
 static void
-dco_update_peer_stat(struct context_2 *c2=
, struct nlattr *tb[], uint32_t id)
+dco_update_peer_stat(struct context_2 =
*c2, struct nlattr *tb[], uint32_t rx_id)
 {
     if (tb[OVPN_A_PEER_LINK_R=
X_BYTES])
     {
@@ -1172,7 +1172,7 @@
     }
     else
     {
-        msg=
(M_WARN, "%s: no link RX bytes provided in reply for peer %u", __func__, id=
);
+        msg(M_WARN, "%s: no link RX bytes provided in reply for peer wi=
th RX ID %u", __func__, rx_id);
     }
 
     if (tb[OVPN_A_PEER_LINK_TX_BY=
TES])
@@ -1182,7 +1182,7 @@
     }
     else
     {
-        msg(M_WARN, "%=
s: no link TX bytes provided in reply for peer %u", __func__, id);
+       =
 msg(M_WARN, "%s: no link TX bytes provided in reply for peer with RX ID %u=
", __func__, rx_id);
     }
 
     if (tb[OVPN_A_PEER_VPN_RX_BYTES])
@@ -11=
92,7 +1192,7 @@
     }
     else
     {
-        msg(M_WARN, "%s: no VPN RX=
 bytes provided in reply for peer %u", __func__, id);
+        msg(M_WARN, =
"%s: no VPN RX bytes provided in reply for peer with RX ID %u", __func__, r=
x_id);
     }
 
     if (tb[OVPN_A_PEER_VPN_TX_BYTES])
@@ -1202,7 +1202,7 @=
@
     }
     else
     {
-        msg(M_WARN, "%s: no VPN TX bytes provide=
d in reply for peer %u", __func__, id);
+        msg(M_WARN, "%s: no VPN TX=
 bytes provided in reply for peer with RX ID %u", __func__, rx_id);
     }
=
 }
 
@@ -1220,43 +1220,43 @@
 
     if (!tb_peer[OVPN_A_PEER_ID])
     {
- =
       msg(M_WARN, "ovpn-dco: no peer-id provided in PEER_GET reply");
+   =
     msg(M_WARN, "ovpn-dco: no rx-peer-id provided in PEER_GET reply");
   =
      return NL_SKIP;
     }
 
-    uint32_t peer_id =3D nla_get_u32(tb_pee=
r[OVPN_A_PEER_ID]);
+    uint32_t rx_peer_id =3D nla_get_u32(tb_peer[OVPN_A=
_PEER_ID]);
     struct context_2 *c2;
 
-    msg(D_DCO_DEBUG | M_NOIPREFIX=
, "%s: parsing message for peer %u=2E=2E=2E", __func__, peer_id);
+    msg(=
D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer with RX ID %u=2E=
=2E=2E", __func__, rx_peer_id);
 
     if (dco->ifmode =3D=3D OVPN_MODE_P2P=
)
     {
         c2 =3D &dco->c->c2;
-        if (c2->tls_multi->dco_peer_=
id !=3D (int)peer_id)
+        if ((uint32_t)c2->tls_multi->dco_rx_peer_id =
!=3D rx_peer_id)
         {
             return NL_SKIP;
         }
     }
=
     else
     {
-        if (peer_id >=3D dco->c->multi->max_clients)
+   =
     if (rx_peer_id >=3D dco->c->multi->max_clients)
         {
-          =
  msg(M_WARN, "%s: received out of bound peer_id %u (max=3D%u)", __func__, =
peer_id,
+            msg(M_WARN, "%s: received out of bound rx_peer_id %u =
(max=3D%u)", __func__, rx_peer_id,
                 dco->c->multi->max_clie=
nts);
             return NL_SKIP;
         }
 
-        struct multi_insta=
nce *mi =3D dco->c->multi->instances[peer_id];
+        struct multi_instan=
ce *mi =3D dco->c->multi->instances[rx_peer_id];
         if (!mi)
        =
 {
-            msg(M_WARN | M_NOIPREFIX, "%s: received data for a non-exis=
ting peer %u", __func__, peer_id);
+            msg(M_WARN | M_NOIPREFIX, "=
%s: received data for a non-existing peer with RX ID %u", __func__, rx_peer=
_id);
             return NL_SKIP;
         }
 
         c2 =3D &mi->contex=
t=2Ec2;
     }
 
-    dco_update_peer_stat(c2, tb_peer, peer_id);
+    dco_=
update_peer_stat(c2, tb_peer, rx_peer_id);
 
     return NL_OK;
 }
@@ -1311=
,16 +1311,16 @@
     }
     if (!dp_attrs[OVPN_A_PEER_ID])
     {
-        =
msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
+=
        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no rx-peer-id in PEER_DEL_NTF m=
essage");
         return NL_STOP;
     }
 
     int reason =3D nla_get_u32=
(dp_attrs[OVPN_A_PEER_DEL_REASON]);
-    unsigned int peerid =3D nla_get_u3=
2(dp_attrs[OVPN_A_PEER_ID]);
+    unsigned int rx_peer_id =3D nla_get_u32(d=
p_attrs[OVPN_A_PEER_ID]);
 
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: =
received CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d",
-        d=
co->ifindex, peerid, reason);
-    dco->dco_message_peer_id =3D peerid;
+  =
  msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifin=
dex: %d, rx-peer-id %u, reason: %d",
+        dco->ifindex, rx_peer_id, rea=
son);
+    dco->dco_message_rx_peer_id =3D rx_peer_id;
     dco->dco_del_pe=
er_reason =3D reason;
     dco->dco_message_type =3D OVPN_CMD_PEER_DEL_NTF;=

 
@@ -1350,10 +1350,10 @@
 
     if (!fp_attrs[OVPN_A_PEER_ID])
     {
-  =
      msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF message");
+      =
  msg(D_DCO, "ovpn-dco: no rx-peer-id in PEER_FLOAT_NTF message");
        =
 return NL_STOP;
     }
-    uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_=
A_PEER_ID]);
+    uint32_t rx_peer_id =3D nla_get_u32(fp_attrs[OVPN_A_PEER_=
ID]);
 
     if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&dco->=
dco_float_peer_ss))
     {
@@ -1361,9 +1361,9 @@
     }
 
     struct gc_ar=
ena gc =3D gc_new();
-    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_FLO=
AT_NTF, ifindex: %u, peer-id %u, address: %s",
-        dco->ifindex, peeri=
d, print_sockaddr((struct sockaddr *)&dco->dco_float_peer_ss, &gc));
-    d=
co->dco_message_peer_id =3D (int)peerid;
+    msg(D_DCO_DEBUG, "ovpn-dco: r=
eceived CMD_PEER_FLOAT_NTF, ifindex: %u, rx-peer-id %u, address: %s",
+    =
    dco->ifindex, rx_peer_id, print_sockaddr((struct sockaddr *)&dco->dco_f=
loat_peer_ss, &gc));
+    dco->dco_message_rx_peer_id =3D (int)rx_peer_id;
=
     dco->dco_message_type =3D OVPN_CMD_PEER_FLOAT_NTF;
 
     gc_free(&gc)=
;
@@ -1393,7 +1393,7 @@
     }
     if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])
=
     {
-        msg(D_DCO, "ovpn-dco: no peer-id in KEY_SWAP_NTF message");=

+        msg(D_DCO, "ovpn-dco: no rx-peer-id in KEY_SWAP_NTF message");
  =
       return NL_STOP;
     }
     if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])
@@=
 -1403,11 +1403,11 @@
     }
 
     int key_id =3D nla_get_u16(dp_attrs[OVP=
N_A_KEYCONF_KEY_ID]);
-    unsigned int peer_id =3D nla_get_u32(dp_attrs[OV=
PN_A_KEYCONF_PEER_ID]);
+    unsigned int rx_peer_id =3D nla_get_u32(dp_att=
rs[OVPN_A_KEYCONF_PEER_ID]);
 
-    msg(D_DCO_DEBUG, "ovpn-dco: received CM=
D_KEY_SWAP_NTF, ifindex: %u, peer-id %u, key-id: %d",
-        dco->ifindex=
, peer_id, key_id);
-    dco->dco_message_peer_id =3D peer_id;
+    msg(D_D=
CO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, rx-peer-id %u,=
 key-id: %d",
+        dco->ifindex, rx_peer_id, key_id);
+    dco->dco_mes=
sage_rx_peer_id =3D (int)rx_peer_id;
     dco->dco_message_key_id =3D key_i=
d;
     dco->dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;
 
@@ -1521,28 +152=
1,28 @@
 }
 
 static int
-dco_get_peer(dco_context_t *dco, int peer_id, con=
st bool raise_sigusr1_on_err)
+dco_get_peer(dco_context_t *dco, int rx_peer=
_id, const bool raise_sigusr1_on_err)
 {
     ASSERT(dco);
 
-    /* peer_i=
d =3D=3D -1 means "dump all peers", but this is allowed in MP mode only=2E
=
+    /* rx_peer_id =3D=3D -1 means "dump all peers", but this is allowed in=
 MP mode only=2E
      * If it happens in P2P mode it means that the DCO pe=
er was deleted and we
      * can simply bail out
      */
-    if (peer_id=
 =3D=3D -1 && dco->ifmode =3D=3D OVPN_MODE_P2P)
+    if (rx_peer_id =3D=3D =
-1 && dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
         return 0;
     }
 
=
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__, peer_id);
+=
    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: rx-peer-id %u", __func__, rx_peer_i=
d);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PE=
ER_GET);
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
=
     int ret =3D -EMSGSIZE;
 
-    if (peer_id !=3D -1)
+    if (rx_peer_id=
 !=3D -1)
     {
-        NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
+  =
      NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);
     }
     else
   =
  {
@@ -1573,7 +1573,7 @@
         return -1;
     }
 
-    return dco_get_=
peer(&c->c1=2Etuntap->dco, c->c2=2Etls_multi->dco_peer_id, raise_sigusr1_on=
_err);
+    return dco_get_peer(&c->c1=2Etuntap->dco, c->c2=2Etls_multi->dc=
o_rx_peer_id, raise_sigusr1_on_err);
 }
 
 int
diff --git a/src/openvpn/dco=
_linux=2Eh b/src/openvpn/dco_linux=2Eh
index c487581=2E=2Ef79e5b1 100644
--=
- a/src/openvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_linux=2Eh
@@ -87,7 +87,=
7 @@
     unsigned int ifindex;
 
     int dco_message_type;
-    int dco_m=
essage_peer_id;
+    int dco_message_rx_peer_id;
     int dco_message_key_i=
d;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_pee=
r_ss;
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index =
dbe8b78=2E=2Ef1e0418 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn=
/dco_win=2Ec
@@ -405,11 +405,11 @@
 }
 
 int
-dco_new_peer(dco_context_t *d=
co, unsigned int peerid, socket_descriptor_t sd,
+dco_new_peer(dco_context_=
t *dco, unsigned int rx_peer_id, socket_descriptor_t sd,
              stru=
ct sockaddr *localaddr, struct sockaddr *remoteaddr,
              const st=
ruct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_=
DEBUG, "%s: peer-id %u, fd " SOCKET_PRINTF, __func__, peerid, sd);
+    msg=
(D_DCO_DEBUG, "%s: rx-peer-id %u, fd " SOCKET_PRINTF, __func__, rx_peer_id,=
 sd);
 
     if (dco->ifmode =3D=3D DCO_MODE_P2P)
     {
@@ -444,7 +444,7 @=
@
         newPeer=2EVpnAddr6 =3D *vpn_ipv6;
     }
 
-    newPeer=2EPeerId=
 =3D peerid;
+    newPeer=2EPeerId =3D rx_peer_id;
 
     DWORD bytesReturn=
ed;
     if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_NEW_PEER, &newPe=
er, sizeof(newPeer), NULL, 0,
@@ -458,11 +458,11 @@
 }
 
 int
-dco_del_peer=
(dco_context_t *dco, unsigned int peerid)
+dco_del_peer(dco_context_t *dco,=
 unsigned int rx_peer_id)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %u", __func=
__, peerid);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", __func__, rx_peer_i=
d);
 
-    OVPN_MP_DEL_PEER del_peer =3D { peerid };
+    OVPN_MP_DEL_PEER =
del_peer =3D { rx_peer_id };
     VOID *buf =3D NULL;
     DWORD len =3D 0;=

     DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;
@@ -484,13 +484,13 @@
 }
 
 int
=
-dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interv=
al, int keepalive_timeout,
-             int mss)
+dco_set_peer(dco_context=
_t *dco, unsigned int rx_peer_id, int keepalive_interval,
+             int=
 keepalive_timeout, int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %u, keep=
alive %d/%d, mss %d", __func__, peerid,
-        keepalive_interval, keepal=
ive_timeout, mss);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, keepalive %d/%=
d, mss %d", __func__,
+        rx_peer_id, keepalive_interval, keepalive_ti=
meout, mss);
 
-    OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interv=
al, keepalive_timeout, mss };
+    OVPN_MP_SET_PEER mp_peer =3D { rx_peer_i=
d, keepalive_interval, keepalive_timeout, mss };
     OVPN_SET_PEER peer =
=3D { keepalive_interval, keepalive_timeout, mss };
     VOID *buf =3D NULL=
;
     DWORD len =3D 0;
@@ -518,11 +518,11 @@
 }
 
 int
-dco_new_key(dco_co=
ntext_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
+dco_new=
_key(dco_context_t *dco, unsigned int rx_peer_id, int keyid, dco_key_slot_t=
 slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, =
const uint8_t *decrypt_key,
             const uint8_t *decrypt_iv, const c=
har *ciphername, bool epoch)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id =
%d, peer-id %u, cipher %s", __func__, slot, keyid, peerid,
+    msg(D_DCO_D=
EBUG, "%s: slot %d, key-id %d, rx-peer-id %u, cipher %s", __func__, slot, k=
eyid, rx_peer_id,
         ciphername);
 
     const int nonce_len =3D 8;
@=
@ -537,7 +537,7 @@
     v1->CipherAlg =3D dco_get_cipher(ciphername);
     =
ASSERT(keyid >=3D 0 && keyid <=3D UCHAR_MAX);
     v1->KeyId =3D (unsigned =
char)keyid;
-    v1->PeerId =3D peerid;
+    v1->PeerId =3D rx_peer_id;
   =
  v1->KeySlot =3D slot;
 
     /* for epoch we use key material as a seed, =
no as actual key */
@@ -573,19 +573,19 @@
 }
 
 int
-dco_del_key(dco_contex=
t_t *dco, unsigned int peerid, dco_key_slot_t slot)
+dco_del_key(dco_contex=
t_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot)
 {
-    msg(D_DCO, =
"%s: peer-id %u, slot %d called but ignored", __func__, peerid, slot);
+   =
 msg(D_DCO, "%s: rx-peer-id %u, slot %d called but ignored", __func__, rx_p=
eer_id, slot);
     /* FIXME: Implement in driver first */
     return 0;
 =
}
 
 int
-dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
+dco_swap=
_keys(dco_context_t *dco, unsigned int rx_peer_id)
 {
-    msg(D_DCO_DEBUG,=
 "%s: peer-id %u", __func__, peer_id);
+    msg(D_DCO_DEBUG, "%s: rx-peer-i=
d %u", __func__, rx_peer_id);
 
-    OVPN_MP_SWAP_KEYS swap =3D { peer_id }=
;
+    OVPN_MP_SWAP_KEYS swap =3D { rx_peer_id };
     DWORD ioctl =3D OVPN=
_IOCTL_SWAP_KEYS;
     VOID *buf =3D NULL;
     DWORD len =3D 0;
@@ -676,7 =
+676,7 @@
         msg(D_DCO_DEBUG, "%s: completion%s success [%lu]", __fun=
c__, queued ? "" : " non-queued",
             bytes_read);
 
-        dco-=
>dco_message_peer_id =3D dco->notif_buf=2EPeerId;
+        dco->dco_message=
_rx_peer_id =3D dco->notif_buf=2EPeerId;
         dco->dco_message_type =3D=
 dco->notif_buf=2ECmd;
         dco->dco_del_peer_reason =3D dco->notif_buf=
=2EDelPeerReason;
         dco->dco_float_peer_ss =3D dco->notif_buf=2EFloa=
tAddress;
@@ -695,7 +695,7 @@
         ASSERT(false);
     }
 
-    dco->dc=
o_message_peer_id =3D -1;
+    dco->dco_message_rx_peer_id =3D -1;
     dco=
->dco_message_type =3D 0;
 
     switch (dco->iostate)
@@ -833,7 +833,7 @@
=
 
         if (stat->PeerId >=3D (int)dco->c->multi->max_clients)
         =
{
-            msg(M_WARN, "%s: received out of bound peer_id %d (max=3D%u)=
", __func__, stat->PeerId,
+            msg(M_WARN, "%s: received out of bo=
und rx_peer_id %d (max=3D%u)", __func__, stat->PeerId,
                 dco=
->c->multi->max_clients);
             continue;
         }
@@ -841,7 +841,=
7 @@
         struct multi_instance *mi =3D dco->c->multi->instances[stat->=
PeerId];
         if (!mi)
         {
-            msg(M_WARN, "%s: receive=
d data for a non-existing peer %d", __func__, stat->PeerId);
+            m=
sg(M_WARN, "%s: received data for a non-existing peer with RX ID %u", __fun=
c__, stat->PeerId);
             continue;
         }
 
@@ -904,7 +904,7 @@=

     }
 
     /* first, try a new ioctl */
-    OVPN_GET_PEER_STATS ps =3D=
 { =2EPeerId =3D c->c2=2Etls_multi->dco_peer_id };
+    OVPN_GET_PEER_STATS=
 ps =3D { =2EPeerId =3D c->c2=2Etls_multi->dco_rx_peer_id };
 
     OVPN_PE=
ER_STATS peer_stats =3D { 0 };
     DWORD bytes_returned =3D 0;
@@ -1014,16=
 +1014,16 @@
 
 void
 dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t=
 dst, unsigned int netbits,
-                        unsigned int peer_id)
=
+                        unsigned int rx_peer_id)
 {
     struct gc_arena g=
c =3D gc_new();
 
     OVPN_MP_IROUTE route =3D {
-        =2EAddr=2EAddr4=
=2ES_un=2ES_addr =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =
=2EIPv6 =3D 0
+        =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =
=3D netbits, =2EPeerId =3D rx_peer_id, =2EIPv6 =3D 0
     };
 
-    msg(D_D=
CO_DEBUG, "%s: %s/%u -> peer %u", __func__, print_in_addr_t(dst, IA_NET_ORD=
ER, &gc),
-        netbits, peer_id);
+    msg(D_DCO_DEBUG, "%s: %s/%d -> r=
x-peer-id %u", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
+        =
netbits, rx_peer_id);
 
     DWORD bytes_returned =3D 0;
     if (!DeviceIo=
Control(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NUL=
L, 0,
@@ -1037,14 +1037,14 @@
 
 void
 dco_win_add_iroute_ipv6(dco_context_=
t *dco, struct in6_addr dst, unsigned int netbits,
-                       =
 unsigned int peer_id)
+                        unsigned int rx_peer_id)
 {=

     struct gc_arena gc =3D gc_new();
 
-    OVPN_MP_IROUTE route =3D { =
=2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =2E=
IPv6 =3D 1 };
+    OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2EN=
etbits =3D netbits, =2EPeerId =3D rx_peer_id, =2EIPv6 =3D 1 };
 
-    msg(D=
_DCO_DEBUG, "%s: %s/%u -> peer %u", __func__, print_in6_addr(dst, IA_NET_OR=
DER, &gc),
-        netbits, peer_id);
+    msg(D_DCO_DEBUG, "%s: %s/%d -> =
rx-peer-id %u", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
+        =
netbits, rx_peer_id);
 
     DWORD bytes_returned =3D 0;
     if (!DeviceIo=
Control(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NUL=
L, 0,
diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index =
a92e5ad=2E=2Efc9d698 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn=
/dco_win=2Eh
@@ -50,7 +50,7 @@
     struct rw_handle rwhandle;   /**< Used =
to hook async I/O to the OpenVPN event loop=2E */
     int ov_ret;         =
         /**< Win32 error code for overlapped operation, 0 for success */
 =

-    int dco_message_peer_id;
+    int dco_message_rx_peer_id;
     int dc=
o_message_type;
     int dco_del_peer_reason;
     struct sockaddr_storage =
dco_float_peer_ss;
@@ -68,10 +68,10 @@
 bool dco_win_supports_multipeer(voi=
d);
 
 void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsi=
gned int netbits,
-                             unsigned int peer_id);
+   =
                          unsigned int rx_peer_id);
 
 void dco_win_add_iro=
ute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,
-  =
                           unsigned int peer_id);
+                        =
     unsigned int rx_peer_id);
 
 void dco_win_del_iroute_ipv4(dco_context_=
t *dco, in_addr_t dst, unsigned int netbits);
 
diff --git a/src/openvpn/fo=
rward=2Ec b/src/openvpn/forward=2Ec
index 1604224=2E=2E1f5670b 100644
--- a=
/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -151,7 +151,7 @@
=
     }
 
     /* no active peer (p2p tls-server mode) */
-    if (c->c2=2Et=
ls_multi->dco_peer_id =3D=3D -1)
+    if (c->c2=2Etls_multi->dco_rx_peer_id=
 =3D=3D -1)
     {
         return;
     }
@@ -1270,15 +1270,15 @@
 #if def=
ined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
    =
 struct context *c =3D dco->c;
 
-    /* FreeBSD currently sends us removal=
 notifcation with the old peer-id in
+    /* FreeBSD currently sends us rem=
oval notifcation with the old RX peer ID in
      * p2p mode with the ping =
timeout reason, so ignore that one to not shoot
      * ourselves in the fo=
ot and removing the just established session */
-    if (dco->dco_message_p=
eer_id !=3D c->c2=2Etls_multi->dco_peer_id)
+    if (dco->dco_message_rx_pe=
er_id !=3D c->c2=2Etls_multi->dco_rx_peer_id)
     {
         msg(D_DCO_DEB=
UG,
-            "%s: received message for mismatching peer-id %d, "
+     =
       "%s: received message for mismatching rx-peer-id %d, "
             =
"expected %d",
-            __func__, dco->dco_message_peer_id, c->c2=2Etls=
_multi->dco_peer_id);
+            __func__, dco->dco_message_rx_peer_id, c=
->c2=2Etls_multi->dco_rx_peer_id);
         return;
     }
 
@@ -1286,21 +1=
286,21 @@
     {
         case OVPN_CMD_DEL_PEER:
             /* peer is g=
one, unset ID to prevent more kernel calls */
-            c->c2=2Etls_mult=
i->dco_peer_id =3D -1;
+            c->c2=2Etls_multi->dco_rx_peer_id =3D -=
1;
             if (dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EX=
PIRED)
             {
                 msg(D_DCO_DEBUG,
-                  =
  "%s: received peer expired notification of for peer-id "
+               =
     "%s: received peer expired notification of for rx-peer-id "
          =
           "%d",
-                    __func__, dco->dco_message_peer_id);
=
+                    __func__, dco->dco_message_rx_peer_id);
              =
   trigger_ping_timeout_signal(c);
                 return;
             }
=
             break;
 
         case OVPN_CMD_SWAP_KEYS:
-            msg(D_=
DCO_DEBUG, "%s: received key rotation notification for peer-id %d", __func_=
_,
-                dco->dco_message_peer_id);
+            msg(D_DCO_DEBUG=
, "%s: received key rotation notification for rx-peer-id %d", __func__,
+  =
              dco->dco_message_rx_peer_id);
             tls_session_soft_r=
eset(c->c2=2Etls_multi);
             break;
 
diff --git a/src/openvpn/mul=
ti=2Ec b/src/openvpn/multi=2Ec
index 1cf2a21=2E=2E2cf5495 100644
--- a/src/=
openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3277,7 +3277,7 @@
 
     =
/* When kernel already deleted the peer, the socket is no longer
      * in=
stalled, and we do not need to clean up the state in the kernel */
-    mi-=
>context=2Ec2=2Etls_multi->dco_peer_id =3D -1;
+    mi->context=2Ec2=2Etls_=
multi->dco_rx_peer_id =3D -1;
     mi->context=2Esig->signal_text =3D reaso=
n;
     multi_signal_instance(m, mi, SIGTERM);
 }
@@ -3289,19 +3289,19 @@
 =

     struct multi_context *m =3D dco->c->multi;
 
-    int peer_id =3D dco=
->dco_message_peer_id;
+    int rx_peer_id =3D dco->dco_message_rx_peer_id;=

 
     /* no peer-specific message delivered -> nothing to process=2E
    =
  * bail out right away
      */
-    if (peer_id < 0)
+    if (rx_peer_id =
< 0)
     {
         return;
     }
 
-    if (((uint32_t)peer_id < m->max_=
clients) && m->instances[peer_id])
+    if (((uint32_t)rx_peer_id < m->max_=
clients) && m->instances[rx_peer_id])
     {
-        struct multi_instance=
 *mi =3D m->instances[peer_id];
+        struct multi_instance *mi =3D m->i=
nstances[rx_peer_id];
         set_prefix(mi);
         if (dco->dco_messag=
e_type =3D=3D OVPN_CMD_DEL_PEER)
         {
@@ -3338,9 +3338,9 @@
         =
    msglevel =3D D_DCO_DEBUG;
         }
         msg(msglevel,
-          =
  "Received DCO message for unknown peer-id: %d, "
+            "Received D=
CO message for unknown rx-peer-id: %d, "
             "type %d, del_peer_re=
ason %d",
-            peer_id, dco->dco_message_type, dco->dco_del_peer_re=
ason);
+            rx_peer_id, dco->dco_message_type, dco->dco_del_peer_re=
ason);
     }
 }
 #endif /* if defined(ENABLE_DCO) */
diff --git a/src/open=
vpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index aeec020=2E=2E137e340 100644
--- a/s=
rc/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1179,7 +1179,7 @@
 
     /=
* get command line derived options */
     ret->opt =3D *tls_options;
-    =
ret->dco_peer_id =3D -1;
+    ret->dco_rx_peer_id =3D -1;
     ret->use_asy=
mmetric_peer_id =3D false;
     /* The rx_peer_id is also used to identify =
DCO clients */
     ret->rx_peer_id =3D MAX_PEER_ID;
@@ -1685,12 +1685,12 @=
@
          * ping-exit or mssfix are set to update in-kernel config */
   =
      if (options->ping_send_timeout || options->ping_rec_timeout || frame-=
>mss_fix)
         {
-            int ret =3D dco_set_peer(dco, multi->dco_=
peer_id, options->ping_send_timeout,
+            int ret =3D dco_set_peer(=
dco, multi->dco_rx_peer_id, options->ping_send_timeout,
                   =
                 options->ping_rec_timeout, frame->mss_fix);
             i=
f (ret < 0)
             {
-                msg(D_DCO, "Cannot set DCO peer=
 parameters for peer (id=3D%d): %s",
-                    multi->dco_peer_i=
d, strerror(-ret));
+                msg(D_DCO, "Cannot set DCO peer parame=
ters for peer (rx-id=3D%u): %s",
+                    multi->dco_rx_peer_id=
, strerror(-ret));
                 return false;
             }
         }=

diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index=
 f6392f9=2E=2Ef32d188 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/ope=
nvpn/ssl_common=2Eh
@@ -719,10 +719,10 @@
      * This is the handle that D=
CO uses to identify this session with the
      * kernel=2E
      *
-     *=
 We keep this separate as the normal peer_id can change during
+     * We k=
eep this separate as the normal rx_peer_id can change during
      * p2p NC=
P and we need to track the id that is really used=2E
      */
-    int dco_=
peer_id;
+    int dco_rx_peer_id;
 
     dco_context_t *dco;
 };

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1982?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I25fad88fb4bb8e841a50981e31=
97d5b8d8f9069b
Gerrit-Change-Number: 1982
Gerrit-PatchSet: 1
Gerrit-Owner: =
Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--dEFxKmpwcRM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1982?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">dco: clarify RX peer ID naming and types<br><br>The pee=
r ID used to address a peer in DCO is its local RX ID=2E Make that<br>expli=
cit in the installed-peer handle, notification fields, and DCO API<br>param=
eters across all backends=2E<br><br>Use an unsigned local RX ID when creati=
ng a peer and make conversions<br>explicit at the signed DCO handle and Lin=
ux notification/statistics<br>boundaries=2E Keep DCO handles signed for the=
ir -1 sentinel=2E<br><br>This prepares asymmetric peer ID support without c=
hanging behavior for<br>valid peer IDs=2E<br><br>Change-Id: I25fad88fb4bb8e=
841a50981e3197d5b8d8f9069b<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=
=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M sr=
c/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_freebsd=2Eh<br>M src/openvpn=
/dco_internal=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_linux=
=2Eh<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/dco_win=2Eh<br>M src/ope=
nvpn/forward=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/ssl=2Ec<br>M s=
rc/openvpn/ssl_common=2Eh<br>13 files changed, 181 insertions(+), 181 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/82/1982/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec=
 b/src/openvpn/dco=2Ec</span><br><span>index 9fc0e3b=2E=2E15f32e1 100644</s=
pan><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/d=
co=2Ec</span><br><span>@@ -57,8 +57,8 @@</span><br><span> </span><br><span>=
 {</span><br><span>     bool epoch =3D ks-&gt;crypto_options=2Eflags &amp; =
CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    msg(D_DCO_DEBUG, &quot;%s: peer_id=3D%d keyid=3D%d epoch=3D%d, curr=
ently %d keys installed&quot;,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        __func__, multi-&gt;dco_peer_id, ks-&gt;key_id, epoch, mul=
ti-&gt;dco_keys_installed);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx_peer_id=3D%d keyid=3D%d epoch=3D%=
d, currently %d keys installed&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        __func__, multi-&gt;dco_rx_peer_id, ks-&gt;key_id=
, epoch, multi-&gt;dco_keys_installed);</span><br><span> </span><br><span> =
    /* Install a key in the PRIMARY slot only when no other key exist=2E</s=
pan><br><span>      * From that moment on, any new key will be installed in=
 the SECONDARY</span><br><span>@@ -71,7 +71,7 @@</span><br><span>         s=
lot =3D OVPN_KEY_SLOT_SECONDARY;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new=
_key(multi-&gt;dco, multi-&gt;dco_peer_id, ks-&gt;key_id, slot, encrypt_key=
, encrypt_iv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t ret =3D dco_new_key(multi-&gt;dco, multi-&gt;dco_rx_peer_id, ks-&gt;key_i=
d, slot, encrypt_key, encrypt_iv,</span><br><span>                         =
  decrypt_key, decrypt_iv, ciphername, epoch);</span><br><span>     if (ret=
 =3D=3D 0)</span><br><span>     {</span><br><span>@@ -148,14 +148,14 @@</sp=
an><br><span>     {</span><br><span>         msg(D_DCO, &quot;No encryption=
 key found=2E Purging data channel keys&quot;);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int ret =3D dco_del_key=
(dco, multi-&gt;dco_peer_id, OVPN_KEY_SLOT_PRIMARY);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int ret =3D dco_del_key(dco, mult=
i-&gt;dco_rx_peer_id, OVPN_KEY_SLOT_PRIMARY);</span><br><span>         if (=
ret &lt; 0)</span><br><span>         {</span><br><span>             msg(D_D=
CO, &quot;Cannot delete primary key during wipe: %s (%d)&quot;, strerror(-r=
et), ret);</span><br><span>             return false;</span><br><span>     =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ret =3D dco_del_key(dco, multi-&gt;dco_peer_id, OVPN_KEY_SLOT_SEC=
ONDARY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
 =3D dco_del_key(dco, multi-&gt;dco_rx_peer_id, OVPN_KEY_SLOT_SECONDARY);</=
span><br><span>         if (ret &lt; 0)</span><br><span>         {</span><b=
r><span>             msg(D_DCO, &quot;Cannot delete secondary key during wi=
pe: %s (%d)&quot;, strerror(-ret), ret);</span><br><span>@@ -172,8 +172,8 @=
@</span><br><span>     if (primary-&gt;dco_status =3D=3D DCO_NOT_INSTALLED)=
</span><br><span>     {</span><br><span>         msg(D_DCO, &quot;DCO key s=
tate mismatch: selected primary key is not installed &quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                   &quot;(peer_id=3D%=
d, key_id=3D%d, dco_keys_installed=3D%d)&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            multi-&gt;dco_peer_id, primary-&gt;ke=
y_id, multi-&gt;dco_keys_installed);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                   &quot;(rx_peer_id=3D%d, key_id=3D%d, dc=
o_keys_installed=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            multi-&gt;dco_rx_peer_id, primary-&gt;key_id, multi-&=
gt;dco_keys_installed);</span><br><span>         return false;</span><br><s=
pan>     }</span><br><span> </span><br><span>@@ -202,12 +202,12 @@</span><b=
r><span>         if (secondary &amp;&amp; secondary-&gt;dco_status !=3D DCO=
_INSTALLED_PRIMARY)</span><br><span>         {</span><br><span>            =
 msg(D_DCO, &quot;DCO key state mismatch: expected old primary key is not i=
nstalled as DCO primary before swap &quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                       &quot;(peer_id=3D%d, new_primar=
y_key_id=3D%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dco_ke=
ys_installed=3D%d)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                multi-&gt;dco_peer_id, primary-&gt;key_id, secondary-&g=
t;key_id, secondary-&gt;dco_status, multi-&gt;dco_keys_installed);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                       &quot=
;(rx_peer_id=3D%d, new_primary_key_id=3D%d, old_primary_key_id=3D%d, old_pr=
imary_dco_status=3D%d, dco_keys_installed=3D%d)&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;dco_rx_peer_id=
, primary-&gt;key_id, secondary-&gt;key_id, secondary-&gt;dco_status, multi=
-&gt;dco_keys_installed);</span><br><span>             return false;</span>=
<br><span>         }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        int ret =3D dco_swap_keys(dco, multi-&gt;dco_peer_=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ret=
 =3D dco_swap_keys(dco, multi-&gt;dco_rx_peer_id);</span><br><span>        =
 if (ret &lt; 0)</span><br><span>         {</span><br><span>             ms=
g(D_DCO, &quot;Cannot swap keys: %s (%d)&quot;, strerror(-ret), ret);</span=
><br><span>@@ -224,7 +224,7 @@</span><br><span>     /* if we have no second=
ary key anymore, inform DCO about it */</span><br><span>     if (!secondary=
 &amp;&amp; multi-&gt;dco_keys_installed =3D=3D 2)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int ret =3D dco=
_del_key(dco, multi-&gt;dco_peer_id, OVPN_KEY_SLOT_SECONDARY);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        int ret =3D dco_del_key(=
dco, multi-&gt;dco_rx_peer_id, OVPN_KEY_SLOT_SECONDARY);</span><br><span>  =
       if (ret &lt; 0)</span><br><span>         {</span><br><span>         =
    msg(D_DCO, &quot;Cannot delete secondary key: %s (%d)&quot;, strerror(-=
ret), ret);</span><br><span>@@ -538,10 +538,10 @@</span><br><span> #ifdef T=
ARGET_FREEBSD</span><br><span>     /* In Linux in P2P mode the kernel autom=
atically removes an existing peer</span><br><span>      * when adding a new=
 peer=2E FreeBSD needs to explicitly be told to do that */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2=2Etls_multi-&gt;dco_p=
eer_id !=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id !=3D -1)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_del_peer(=
&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_multi-&gt;dco_peer_id);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_mul=
ti-&gt;dco_peer_id =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        dco_del_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_=
multi-&gt;dco_rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id =3D -1;</span><br><s=
pan>     }</span><br><span> #endif</span><br><span>     int ret =3D dco_new=
_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NU=
LL,</span><br><span>@@ -552,7 +552,7 @@</span><br><span>         return ret=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt=
;rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&=
gt;c2=2Etls_multi-&gt;dco_rx_peer_id =3D (int)multi-&gt;rx_peer_id;</span><=
br><span> </span><br><span>     return 0;</span><br><span> }</span><br><spa=
n>@@ -565,10 +565,10 @@</span><br><span>         return;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (c-&gt;c1=2Etuntap &amp;&amp; c-&gt;c2=2Etls_multi &amp;&amp; c-&gt=
;c2=2Etls_multi-&gt;dco_peer_id !=3D -1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (c-&gt;c1=2Etuntap &amp;&amp; c-&gt;c2=2Etls_mu=
lti &amp;&amp; c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id !=3D -1)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dc=
o_del_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_multi-&gt;dco_pee=
r_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c=
2=2Etls_multi-&gt;dco_peer_id =3D -1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        dco_del_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&g=
t;c2=2Etls_multi-&gt;dco_rx_peer_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id =3D -1;</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span>=
@@ -627,7 +627,7 @@</span><br><span> {</span><br><span>     const struct co=
ntext *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2=2Etls_multi-&g=
t;rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt32_t rx_peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span>=
     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>    =
 struct sockaddr_storage local =3D { 0 };</span><br><span>     const socket=
_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><span>@@ =
-665,13 +665,13 @@</span><br><span>     }</span><br><span> </span><br><span=
>     int ret =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, peer_id, sd, localaddr, re=
moteaddr, vpn_addr4, vpn_addr6);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, rx_peer_i=
d, sd, localaddr, remoteaddr, vpn_addr4, vpn_addr6);</span><br><span>     i=
f (ret &lt; 0)</span><br><span>     {</span><br><span>         return ret;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D peer_id;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_mul=
ti-&gt;dco_rx_peer_id =3D (int)rx_peer_id;</span><br><span> </span><br><spa=
n>     return 0;</span><br><span> }</span><br><span>diff --git a/src/openvp=
n/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index d074257=2E=2E0a8c9da =
100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/=
openvpn/dco=2Eh</span><br><span>@@ -180,14 +180,14 @@</span><br><span>  * a=
nd -1 (do not touch)=2E</span><br><span>  *</span><br><span>  * @param dco =
               DCO device context</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @param peer_id            the ID of the peer to be modified<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param rx_peer_id=
         the RX ID of the peer to be modified</span><br><span>  * @param ke=
epalive_interval keepalive interval in seconds</span><br><span>  * @param k=
eepalive_timeout  keepalive timeout in seconds</span><br><span>  * @param m=
ss                TCP MSS value</span><br><span>  *</span><br><span>  * @re=
turn                   0 on success or a negative error code otherwise</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int d=
co_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interval=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_set_peer(d=
co_context_t *dco, unsigned int rx_peer_id, int keepalive_interval,</span><=
br><span>                  int keepalive_timeout, int mss);</span><br><span=
> </span><br><span> /**</span><br><span>@@ -349,7 +349,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static inline int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-dco_set_peer(dco_context_t *dco, unsigne=
d int peerid, int keepalive_interval, int keepalive_timeout,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_set_peer(dco_context_t *dco, u=
nsigned int rx_peer_id, int keepalive_interval, int keepalive_timeout,</spa=
n><br><span>              int mss)</span><br><span> {</span><br><span>     =
return 0;</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/op=
envpn/dco_freebsd=2Ec</span><br><span>index 9ace240=2E=2E178b754 100644</sp=
an><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/op=
envpn/dco_freebsd=2Ec</span><br><span>@@ -133,7 +133,7 @@</span><br><span> =
}</span><br><span> </span><br><span> int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco, unsigned int peerid, in=
t sd, struct sockaddr *localaddr,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, int=
 sd, struct sockaddr *localaddr,</span><br><span>              struct socka=
ddr *remoteaddr, const struct in_addr *vpn_ipv4,</span><br><span>          =
    const struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>@@ =
-143,7 +143,7 @@</span><br><span> </span><br><span>     nvl =3D nvlist_crea=
te(0);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd %d&quot;, __func__, peerid=
, sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO=
_DEBUG, &quot;%s: rx-peer-id %u, fd %d&quot;, __func__, rx_peer_id, sd);</s=
pan><br><span> </span><br><span>     if (localaddr)</span><br><span>     {<=
/span><br><span>@@ -168,7 +168,7 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     nvlist_add_number(nvl, &quot;fd&quot;, sd);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    nvlist_add_number(nvl, &qu=
ot;peerid&quot;, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    nvlist_add_number(nvl, &quot;peerid&quot;, rx_peer_id);</span><br=
><span> </span><br><span>     CLEAR(drv);</span><br><span>     snprintf(drv=
=2Eifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);</span><br><span>@@ =
-353,16 +353,16 @@</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_swap_keys(dco_co=
ntext_t *dco, unsigned int peerid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_swap_keys(dco_context_t *dco, unsigned int rx_peer_id)</=
span><br><span> {</span><br><span>     struct ifdrv drv;</span><br><span>  =
   nvlist_t *nvl;</span><br><span>     int ret;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: =
peer-id %u&quot;, __func__, peerid);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u&quot;, __func=
__, rx_peer_id);</span><br><span> </span><br><span>     nvl =3D nvlist_crea=
te(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nvlist_add_=
number(nvl, &quot;peerid&quot;, peerid);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    nvlist_add_number(nvl, &quot;peerid&quot;, rx_peer=
_id);</span><br><span> </span><br><span>     CLEAR(drv);</span><br><span>  =
   snprintf(drv=2Eifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);</spa=
n><br><span>@@ -382,16 +382,16 @@</span><br><span> }</span><br><span> </spa=
n><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_d=
el_peer(dco_context_t *dco, unsigned int peerid)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dco_del_peer(dco_context_t *dco, unsigned int =
rx_peer_id)</span><br><span> {</span><br><span>     struct ifdrv drv;</span=
><br><span>     nvlist_t *nvl;</span><br><span>     int ret;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBU=
G, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u&=
quot;, __func__, rx_peer_id);</span><br><span> </span><br><span>     nvl =
=3D nvlist_create(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    nvlist_add_number(nvl, &quot;peerid&quot;, peerid);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    nvlist_add_number(nvl, &quot;peerid=
&quot;, rx_peer_id);</span><br><span> </span><br><span>     CLEAR(drv);</sp=
an><br><span>     snprintf(drv=2Eifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&g=
t;ifname);</span><br><span>@@ -411,17 +411,17 @@</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot=
_t slot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_del_key=
(dco_context_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot)</span><b=
r><span> {</span><br><span>     struct ifdrv drv;</span><br><span>     nvli=
st_t *nvl;</span><br><span>     int ret;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id=
 %u, slot %d&quot;, __func__, peerid, slot);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, slot=
 %d&quot;, __func__, rx_peer_id, slot);</span><br><span> </span><br><span> =
    nvl =3D nvlist_create(0);</span><br><span>     nvlist_add_number(nvl, &=
quot;slot&quot;, slot);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    nvlist_add_number(nvl, &quot;peerid&quot;, peerid);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    nvlist_add_number(nvl, &quot;peer=
id&quot;, rx_peer_id);</span><br><span> </span><br><span>     CLEAR(drv);</=
span><br><span>     snprintf(drv=2Eifd_name, IFNAMSIZ, &quot;%s&quot;, dco-=
&gt;ifname);</span><br><span>@@ -480,7 +480,7 @@</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, d=
co_key_slot_t slot,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_new_key(dco_context_t *dco, unsigned int rx_peer_id, int keyid, dco_key=
_slot_t slot,</span><br><span>             const uint8_t *encrypt_key, cons=
t uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span>        =
     const uint8_t *decrypt_iv, const char *ciphername, bool epoch)</span><=
br><span> {</span><br><span>@@ -488,14 +488,14 @@</span><br><span>     nvli=
st_t *nvl, *encrypt_nvl, *decrypt_nvl;</span><br><span>     int ret;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_=
DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d&qu=
ot;, __func__, slot, keyid, peerid,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, rx-peer-=
id %u, cipher %s, epoch %d&quot;, __func__, slot, keyid, rx_peer_id,</span>=
<br><span>         ciphername, epoch);</span><br><span> </span><br><span>  =
   nvl =3D nvlist_create(0);</span><br><span> </span><br><span>     nvlist_=
add_number(nvl, &quot;slot&quot;, slot);</span><br><span>     nvlist_add_nu=
mber(nvl, &quot;keyid&quot;, keyid);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    nvlist_add_number(nvl, &quot;peerid&quot;, peerid);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    nvlist_add_number(nv=
l, &quot;peerid&quot;, rx_peer_id);</span><br><span> </span><br><span>     =
encrypt_nvl =3D key_to_nvlist(encrypt_key, encrypt_iv, ciphername);</span><=
br><span>     decrypt_nvl =3D key_to_nvlist(decrypt_key, decrypt_iv, cipher=
name);</span><br><span>@@ -527,18 +527,18 @@</span><br><span> }</span><br><=
span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_i=
nterval, int keepalive_timeout,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+dco_set_peer(dco_context_t *dco, unsigned int rx_peer_id, int k=
eepalive_interval, int keepalive_timeout,</span><br><span>              int=
 mss)</span><br><span> {</span><br><span>     struct ifdrv drv;</span><br><=
span>     nvlist_t *nvl;</span><br><span>     int ret;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &qu=
ot;%s: peer-id %u, ping interval %d, ping timeout %d&quot;, __func__, peeri=
d,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEB=
UG, &quot;%s: rx-peer-id %u, ping interval %d, ping timeout %d&quot;, __fun=
c__, rx_peer_id,</span><br><span>         keepalive_interval, keepalive_tim=
eout);</span><br><span> </span><br><span>     nvl =3D nvlist_create(0);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    nvlist_add_number(nvl=
, &quot;peerid&quot;, peerid);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    nvlist_add_number(nvl, &quot;peerid&quot;, rx_peer_id);</spa=
n><br><span>     nvlist_add_number(nvl, &quot;interval&quot;, keepalive_int=
erval);</span><br><span>     nvlist_add_number(nvl, &quot;timeout&quot;, ke=
epalive_timeout);</span><br><span> </span><br><span>@@ -560,21 +560,21 @@</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-dco_update_peer_stat(struct mult=
i_context *m, uint32_t peerid, const nvlist_t *nvl)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_stat(struct multi_context=
 *m, uint32_t rx_peer_id, const nvlist_t *nvl)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (peerid &gt;=3D m-&gt;ma=
x_clients || !m-&gt;instances[peerid])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (rx_peer_id &gt;=3D m-&gt;max_clients || !m-&gt;i=
nstances[rx_peer_id])</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;dco_update_peer_stat: inva=
lid peer ID %u returned by kernel&quot;, peerid);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;dco_update_peer_sta=
t: invalid peer RX ID %u returned by kernel&quot;, rx_peer_id);</span><br><=
span>         return;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D =
m-&gt;instances[peerid];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct multi_instance *mi =3D m-&gt;instances[rx_peer_id];</span><=
br><span> </span><br><span>     mi-&gt;context=2Ec2=2Edco_read_bytes =3D nv=
list_get_number(nvl, &quot;in&quot;);</span><br><span>     mi-&gt;context=
=2Ec2=2Edco_write_bytes =3D nvlist_get_number(nvl, &quot;out&quot;);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_=
DCO_DEBUG, &quot;%s: peer-id %u, dco_read_bytes: &quot; counter_format &quo=
t; dco_write_bytes: &quot; counter_format,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        __func__, peerid, mi-&gt;context=2Ec2=2Edco_re=
ad_bytes, mi-&gt;context=2Ec2=2Edco_write_bytes);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u,=
 dco_read_bytes: &quot; counter_format &quot; dco_write_bytes: &quot; count=
er_format,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _=
_func__, rx_peer_id, mi-&gt;context=2Ec2=2Edco_read_bytes, mi-&gt;context=
=2Ec2=2Edco_write_bytes);</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span>@@ -609,10 +609,10 @@</span><br><span>         ret=
urn -EINVAL;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* dco_message_peer_id is signed int, b=
ecause other parts of the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* dco_message_rx_peer_id is signed int, because other parts of t=
he</span><br><span>      * code treat &quot;-1&quot; as &quot;this is a mes=
sage not specific to one peer&quot;</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D =
(int)nvlist_get_number(nvl, &quot;peerid&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_rx_peer_id =3D (int)nv=
list_get_number(nvl, &quot;peerid&quot;);</span><br><span> </span><br><span=
>     type =3D (enum ovpn_notif_type)nvlist_get_number(nvl, &quot;notificat=
ion&quot;);</span><br><span> </span><br><span>@@ -633,8 +633,8 @@</span><br=
><span>                     dco-&gt;dco_del_peer_reason =3D OVPN_DEL_PEER_R=
EASON_USERSPACE;</span><br><span>                 }</span><br><span>       =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(D_DCO_DEBUG, &quot;%s: received NOTIF_DEL_PEER for peer-id=3D%d, reason=
=3D%d&quot;, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                dco-&gt;dco_message_peer_id, dco-&gt;dco_del_peer_reason);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_D=
CO_DEBUG, &quot;%s: received NOTIF_DEL_PEER for rx-peer-id=3D%d, reason=3D%=
d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               dco-&gt;dco_message_rx_peer_id, dco-&gt;dco_del_peer_reason)=
;</span><br><span> </span><br><span>             if (nvlist_exists_nvlist(n=
vl, &quot;bytes&quot;))</span><br><span>             {</span><br><span>@@ -=
642,7 +642,7 @@</span><br><span> </span><br><span>                 if (dco-=
&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span>                 {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    dco_update_p=
eer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_peer_id, bytes);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    dco_upda=
te_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_rx_peer_id, bytes);</=
span><br><span>                 }</span><br><span>                 else</sp=
an><br><span>                 {</span><br><span>@@ -655,8 +655,8 @@</span><=
br><span>             break;</span><br><span> </span><br><span>         cas=
e OVPN_NOTIF_ROTATE_KEY:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(D_DCO_DEBUG, &quot;%s: received NOTIF_ROTATE_KEY for pee=
r-id=3D%d&quot;, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                dco-&gt;dco_message_peer_id);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;%s: recei=
ved NOTIF_ROTATE_KEY for rx-peer-id=3D%d&quot;, __func__,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;dco_message_r=
x_peer_id);</span><br><span>             dco-&gt;dco_message_type =3D OVPN_=
CMD_SWAP_KEYS;</span><br><span>             break;</span><br><span> </span>=
<br><span>@@ -676,8 +676,8 @@</span><br><span>                 msg(M_WARN, =
&quot;Failed to parse float notification&quot;);</span><br><span>          =
       break;</span><br><span>             }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;%s: received NOTI=
F_FLOAT for peer-id=3D%d&quot;, __func__,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                dco-&gt;dco_message_peer_id);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, =
&quot;%s: received NOTIF_FLOAT for rx-peer-id=3D%d&quot;, __func__,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;dco=
_message_rx_peer_id);</span><br><span>             dco-&gt;dco_message_type=
 =3D OVPN_CMD_FLOAT_PEER;</span><br><span>             break;</span><br><sp=
an>         }</span><br><span>@@ -885,7 +885,7 @@</span><br><span>     for =
(size_t i =3D 0; i &lt; npeers; i++)</span><br><span>     {</span><br><span=
>         const nvlist_t *peer =3D nvpeers[i];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uint32_t peerid =3D (uint32_t)nvlist_get_n=
umber(peer, &quot;peerid&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uint32_t rx_peer_id =3D (uint32_t)nvlist_get_number(pe=
er, &quot;peerid&quot;);</span><br><span>         const nvlist_t *bytes =3D=
 nvlist_get_nvlist(peer, &quot;bytes&quot;);</span><br><span> </span><br><s=
pan>         /* we can end here in p2mp mode, or in p2p mode via</span><br>=
<span>@@ -893,7 +893,7 @@</span><br><span>          */</span><br><span>    =
     if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco_update_peer=
_stat(dco-&gt;c-&gt;multi, peerid, bytes);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            dco_update_peer_stat(dco-&gt;c-&gt;multi=
, rx_peer_id, bytes);</span><br><span>         }</span><br><span>         e=
lse</span><br><span>         {</span><br><span>@@ -914,9 +914,9 @@</span><b=
r><span> dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_=
err)</span><br><span> {</span><br><span>     ASSERT(c-&gt;c2=2Etls_multi);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &=
quot;%s: peer-id %d&quot;, __func__, c-&gt;c2=2Etls_multi-&gt;dco_peer_id);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG=
, &quot;%s: rx-peer-id %d&quot;, __func__, c-&gt;c2=2Etls_multi-&gt;dco_rx_=
peer_id);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (c-&gt;c2=2Etls_multi-&gt;dco_peer_id &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Etls_multi-&gt;dco=
_rx_peer_id &lt; 0)</span><br><span>     {</span><br><span>         return =
-EINVAL; /* DCO not active yet */</span><br><span>     }</span><br><span>di=
ff --git a/src/openvpn/dco_freebsd=2Eh b/src/openvpn/dco_freebsd=2Eh</span>=
<br><span>index 5e2a552=2E=2E7b278fd 100644</span><br><span>--- a/src/openv=
pn/dco_freebsd=2Eh</span><br><span>+++ b/src/openvpn/dco_freebsd=2Eh</span>=
<br><span>@@ -58,7 +58,7 @@</span><br><span>     char ifname[IFNAMSIZ];</sp=
an><br><span> </span><br><span>     int dco_message_type;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int dco_message_peer_id;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int dco_message_rx_peer_id=
;</span><br><span>     int dco_del_peer_reason;</span><br><span>     struct=
 sockaddr_storage dco_float_peer_ss;</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh</span>=
<br><span>index fcf8aca=2E=2Ec507184 100644</span><br><span>--- a/src/openv=
pn/dco_internal=2Eh</span><br><span>+++ b/src/openvpn/dco_internal=2Eh</spa=
n><br><span>@@ -59,18 +59,18 @@</span><br><span>  * They are implemented by=
 dco_linux=2Ec</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer(dco_context_t *dco, unsign=
ed int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context=
_t *dco, unsigned int rx_peer_id, socket_descriptor_t sd, struct sockaddr *=
localaddr,</span><br><span>                  struct sockaddr *remoteaddr, c=
onst struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_del_pe=
er(dco_context_t *dco, unsigned int peerid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int dco_del_peer(dco_context_t *dco, unsigned int =
rx_peer_id);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-int dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid=
, dco_key_slot_t slot,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int dco_new_key(dco_context_t *dco, unsigned int rx_peer_id, int keyid, =
dco_key_slot_t slot,</span><br><span>                 const uint8_t *encryp=
t_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><sp=
an>                 const uint8_t *decrypt_iv, const char *ciphername, bool=
 epoch);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_=
t slot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_del=
_key(dco_context_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco=
_swap_keys(dco_context_t *dco, unsigned int peerid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int dco_swap_keys(dco_context_t *dco, uns=
igned int rx_peer_id);</span><br><span> </span><br><span> #endif /* defined=
(ENABLE_DCO) */</span><br><span> #endif /* ifndef DCO_INTERNAL_H */</span><=
br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec=
</span><br><span>index eabb3ea=2E=2E96b7521 100644</span><br><span>--- a/sr=
c/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</sp=
an><br><span>@@ -523,7 +523,7 @@</span><br><span> }</span><br><span> </span=
><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_ne=
w_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr *lo=
caladdr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_new_pee=
r(dco_context_t *dco, unsigned int rx_peer_id, int sd, struct sockaddr *loc=
aladdr,</span><br><span>              struct sockaddr *remoteaddr, const st=
ruct in_addr *vpn_ipv4,</span><br><span>              const struct in6_addr=
 *vpn_ipv6)</span><br><span> {</span><br><span>@@ -533,13 +533,13 @@</span>=
<br><span>     {</span><br><span>         remotestr =3D print_sockaddr(remo=
teaddr, &amp;gc);</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd %d, remote=
 addr: %s&quot;, __func__, peerid, sd, remotestr);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u=
, fd %d, remote addr: %s&quot;, __func__, rx_peer_id, sd, remotestr);</span=
><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_=
create(dco, OVPN_CMD_PEER_NEW);</span><br><span>     struct nlattr *attr =
=3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -=
EMSGSIZE;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, =
rx_peer_id);</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_SOCKET, s=
d);</span><br><span> </span><br><span>     /* Set the remote endpoint if de=
fined (for UDP) */</span><br><span>@@ -754,7 +754,7 @@</span><br><span> </s=
pan><br><span>     nl_socket_set_cb(dco-&gt;nl_sock, dco-&gt;nl_cb);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&g=
t;dco_message_peer_id =3D -1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    dco-&gt;dco_message_rx_peer_id =3D -1;</span><br><span>     n=
l_cb_err(dco-&gt;nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &amp;dco-&gt;status=
);</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_FINISH, NL_CB_CUSTOM=
, ovpn_nl_cb_finish, &amp;dco-&gt;status);</span><br><span>     nl_cb_set(d=
co-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &amp;dco-&gt;stat=
us);</span><br><span>@@ -880,9 +880,9 @@</span><br><span> }</span><br><span=
> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_swap_keys(dco_context_t *dco, unsigned int peerid)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dco_swap_keys(dco_context_t *dco, unsi=
gned int rx_peer_id)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__=
, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_DCO_DEBUG, &quot;%s: rx-peer-id %u&quot;, __func__, rx_peer_id);</span><br=
><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_crea=
te(dco, OVPN_CMD_KEY_SWAP);</span><br><span>     if (!nl_msg)</span><br><sp=
an>@@ -892,7 +892,7 @@</span><br><span> </span><br><span>     struct nlattr=
 *attr =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);</span><br><span>     int=
 ret =3D -EMSGSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_P=
EER_ID, rx_peer_id);</span><br><span>     nla_nest_end(nl_msg, attr);</span=
><br><span> </span><br><span>     ret =3D ovpn_nl_msg_send(dco, nl_msg, __f=
unc__);</span><br><span>@@ -904,9 +904,9 @@</span><br><span> </span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-dco_del_peer(dco_context_t *dco, unsigned int peerid)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dco_del_peer(dco_context_t *dco, unsi=
gned int rx_peer_id)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %u&q=
uot;, __func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: rx-peer-id %u&quot;, __fu=
nc__, rx_peer_id);</span><br><span> </span><br><span>     struct nl_msg *nl=
_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL);</span><br><span>   =
  if (!nl_msg)</span><br><span>@@ -916,7 +916,7 @@</span><br><span> </span>=
<br><span>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);=
</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg,=
 OVPN_A_PEER_ID, rx_peer_id);</span><br><span>     nla_nest_end(nl_msg, att=
r);</span><br><span> </span><br><span>     ret =3D ovpn_nl_msg_send(dco, nl=
_msg, __func__);</span><br><span>@@ -928,10 +928,10 @@</span><br><span> </s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key=
_slot_t slot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_de=
l_key(dco_context_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot)</sp=
an><br><span> {</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-i=
d %u, slot %d&quot;, __func__, peerid, slot);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, slo=
t %d&quot;, __func__, rx_peer_id, slot);</span><br><span> </span><br><span>=
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_DEL)=
;</span><br><span>     if (!nl_msg)</span><br><span>@@ -940,7 +940,7 @@</sp=
an><br><span>     }</span><br><span> </span><br><span>     struct nlattr *k=
eyconf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID=
, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_P=
UT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);</span><br><span>     NL=
A_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);</span><br><span>     nla_nest=
_end(nl_msg, keyconf);</span><br><span> </span><br><span>@@ -952,11 +952,11=
 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-dco_new_key(dco_context_t *dco, uns=
igned int peerid, int keyid, dco_key_slot_t slot,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+dco_new_key(dco_context_t *dco, unsigned int =
rx_peer_id, int keyid, dco_key_slot_t slot,</span><br><span>             co=
nst uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt=
_key,</span><br><span>             const uint8_t *decrypt_iv, const char *c=
iphername, bool epoch)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer=
-id %u, cipher %s, epoch %d&quot;, __func__, slot, keyid, peerid,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s=
: slot %d, key-id %d, rx-peer-id %u, cipher %s, epoch %d&quot;, __func__, s=
lot, keyid, rx_peer_id,</span><br><span>         ciphername, epoch);</span>=
<br><span> </span><br><span>     const size_t key_len =3D cipher_kt_key_siz=
e(ciphername);</span><br><span>@@ -974,7 +974,7 @@</span><br><span>     int=
 ret =3D -EMSGSIZE;</span><br><span> </span><br><span>     struct nlattr *k=
ey_conf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER=
_ID, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NL=
A_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);</span><br><span>    =
 NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);</span><br><span>     NLA_P=
UT_U32(nl_msg, OVPN_A_KEYCONF_KEY_ID, keyid);</span><br><span>     NLA_PUT_=
U32(nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, dco_cipher);</span><br><span>@@ -100=
6,10 +1006,10 @@</span><br><span> }</span><br><span> </span><br><span> int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_set_peer(dco_conte=
xt_t *dco, unsigned int peerid, int keepalive_interval, int keepalive_timeo=
ut,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_set_peer(dco=
_context_t *dco, unsigned int rx_peer_id, int keepalive_interval, int keepa=
live_timeout,</span><br><span>              int mss)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quo=
t;%s: peer-id %u, keepalive %d/%d, mss %d&quot;, __func__, peerid,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%=
s: rx-peer-id %u, keepalive %d/%d, mss %d&quot;, __func__, rx_peer_id,</spa=
n><br><span>         keepalive_interval, keepalive_timeout, mss);</span><br=
><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_crea=
te(dco, OVPN_CMD_PEER_SET);</span><br><span>@@ -1020,7 +1020,7 @@</span><br=
><span> </span><br><span>     struct nlattr *attr =3D nla_nest_start(nl_msg=
, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_I=
D, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_=
PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);</span><br><span>     NLA_PUT_U=
32(nl_msg, OVPN_A_PEER_KEEPALIVE_INTERVAL, keepalive_interval);</span><br><=
span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT, keepalive_time=
out);</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span>@@ -=
1163,7 +1163,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_update_pe=
er_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_stat(struct con=
text_2 *c2, struct nlattr *tb[], uint32_t rx_id)</span><br><span> {</span><=
br><span>     if (tb[OVPN_A_PEER_LINK_RX_BYTES])</span><br><span>     {</sp=
an><br><span>@@ -1172,7 +1172,7 @@</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(M_WARN, &quot;%s: no link RX bytes provided in reply =
for peer %u&quot;, __func__, id);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;%s: no link RX bytes provided in re=
ply for peer with RX ID %u&quot;, __func__, rx_id);</span><br><span>     }<=
/span><br><span> </span><br><span>     if (tb[OVPN_A_PEER_LINK_TX_BYTES])</=
span><br><span>@@ -1182,7 +1182,7 @@</span><br><span>     }</span><br><span=
>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_WARN, &quot;%s: no link TX bytes provided in repl=
y for peer %u&quot;, __func__, id);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_WARN, &quot;%s: no link TX bytes provided in =
reply for peer with RX ID %u&quot;, __func__, rx_id);</span><br><span>     =
}</span><br><span> </span><br><span>     if (tb[OVPN_A_PEER_VPN_RX_BYTES])<=
/span><br><span>@@ -1192,7 +1192,7 @@</span><br><span>     }</span><br><spa=
n>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        msg(M_WARN, &quot;%s: no VPN RX bytes provided in repl=
y for peer %u&quot;, __func__, id);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_WARN, &quot;%s: no VPN RX bytes provided in r=
eply for peer with RX ID %u&quot;, __func__, rx_id);</span><br><span>     }=
</span><br><span> </span><br><span>     if (tb[OVPN_A_PEER_VPN_TX_BYTES])</=
span><br><span>@@ -1202,7 +1202,7 @@</span><br><span>     }</span><br><span=
>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_WARN, &quot;%s: no VPN TX bytes provided in reply=
 for peer %u&quot;, __func__, id);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_WARN, &quot;%s: no VPN TX bytes provided in re=
ply for peer with RX ID %u&quot;, __func__, rx_id);</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span>@@ -1220,43 +1220,43 @=
@</span><br><span> </span><br><span>     if (!tb_peer[OVPN_A_PEER_ID])</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_WARN, &quot;ovpn-dco: no peer-id provided in PEER_GET reply&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN, &quot;ovpn-dco: no rx-peer-id provided in PEER_GET reply&quot;);</span>=
<br><span>         return NL_SKIP;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id =
=3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint32_t rx_peer_id =3D nla_get_u32(tb_peer[OVPN_=
A_PEER_ID]);</span><br><span>     struct context_2 *c2;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M=
_NOIPREFIX, &quot;%s: parsing message for peer %u=2E=2E=2E&quot;, __func__,=
 peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_DCO_DEBUG | M_NOIPREFIX, &quot;%s: parsing message for peer with RX ID %u=
=2E=2E=2E&quot;, __func__, rx_peer_id);</span><br><span> </span><br><span> =
    if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><span>     {</span><=
br><span>         c2 =3D &amp;dco-&gt;c-&gt;c2;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D=
 (int)peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if ((uint32_t)c2-&gt;tls_multi-&gt;dco_rx_peer_id !=3D rx_peer_id)</span=
><br><span>         {</span><br><span>             return NL_SKIP;</span><b=
r><span>         }</span><br><span>     }</span><br><span>     else</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (peer_id &gt;=3D dco-&gt;c-&gt;multi-&gt;max_clients)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (rx_peer_id &gt;=3D dco-&=
gt;c-&gt;multi-&gt;max_clients)</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;%s: rece=
ived out of bound peer_id %u (max=3D%u)&quot;, __func__, peer_id,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot=
;%s: received out of bound rx_peer_id %u (max=3D%u)&quot;, __func__, rx_pee=
r_id,</span><br><span>                 dco-&gt;c-&gt;multi-&gt;max_clients)=
;</span><br><span>             return NL_SKIP;</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[peer_id]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct mul=
ti_instance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[rx_peer_id];</span><b=
r><span>         if (!mi)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | M_NOIPREFIX, &quot=
;%s: received data for a non-existing peer %u&quot;, __func__, peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN=
 | M_NOIPREFIX, &quot;%s: received data for a non-existing peer with RX ID =
%u&quot;, __func__, rx_peer_id);</span><br><span>             return NL_SKI=
P;</span><br><span>         }</span><br><span> </span><br><span>         c2=
 =3D &amp;mi-&gt;context=2Ec2;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_update_peer_stat(=
c2, tb_peer, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    dco_update_peer_stat(c2, tb_peer, rx_peer_id);</span><br><span> </sp=
an><br><span>     return NL_OK;</span><br><span> }</span><br><span>@@ -1311=
,16 +1311,16 @@</span><br><span>     }</span><br><span>     if (!dp_attrs[O=
VPN_A_PEER_ID])</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_DCO | M_NOIPREFIX, &quot;ovpn-dco: no peer-i=
d in PEER_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(D_DCO | M_NOIPREFIX, &quot;ovpn-dco: no rx-peer-i=
d in PEER_DEL_NTF message&quot;);</span><br><span>         return NL_STOP;<=
/span><br><span>     }</span><br><span> </span><br><span>     int reason =
=3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    unsigned int peerid =3D nla_get_u32(dp_att=
rs[OVPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    unsigned int rx_peer_id =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: received CMD_PEER_DEL_NTF, ifin=
dex: %u, peer-id %u, reason: %d&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        dco-&gt;ifindex, peerid, reason);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D pe=
erid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_=
DEBUG | M_NOIPREFIX, &quot;ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d=
, rx-peer-id %u, reason: %d&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dco-&gt;ifindex, rx_peer_id, reason);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_rx_peer_id=
 =3D rx_peer_id;</span><br><span>     dco-&gt;dco_del_peer_reason =3D reaso=
n;</span><br><span>     dco-&gt;dco_message_type =3D OVPN_CMD_PEER_DEL_NTF;=
</span><br><span> </span><br><span>@@ -1350,10 +1350,10 @@</span><br><span>=
 </span><br><span>     if (!fp_attrs[OVPN_A_PEER_ID])</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &=
quot;ovpn-dco: no peer-id in PEER_FLOAT_NTF message&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: =
no rx-peer-id in PEER_FLOAT_NTF message&quot;);</span><br><span>         re=
turn NL_STOP;</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t rx_p=
eer_id =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);</span><br><span> </span><=
br><span>     if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&amp;=
dco-&gt;dco_float_peer_ss))</span><br><span>     {</span><br><span>@@ -1361=
,9 +1361,9 @@</span><br><span>     }</span><br><span> </span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_PEER_FLOAT_NT=
F, ifindex: %u, peer-id %u, address: %s&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        dco-&gt;ifindex, peerid, print_sockaddr((s=
truct sockaddr *)&amp;dco-&gt;dco_float_peer_ss, &amp;gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D (=
int)peerid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_DCO_DEBUG, &quot;ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, rx-p=
eer-id %u, address: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        dco-&gt;ifindex, rx_peer_id, print_sockaddr((struct socka=
ddr *)&amp;dco-&gt;dco_float_peer_ss, &amp;gc));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_rx_peer_id =3D (int)rx=
_peer_id;</span><br><span>     dco-&gt;dco_message_type =3D OVPN_CMD_PEER_F=
LOAT_NTF;</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><b=
r><span>@@ -1393,7 +1393,7 @@</span><br><span>     }</span><br><span>     i=
f (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: n=
o peer-id in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no rx-peer-id in K=
EY_SWAP_NTF message&quot;);</span><br><span>         return NL_STOP;</span>=
<br><span>     }</span><br><span>     if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])=
</span><br><span>@@ -1403,11 +1403,11 @@</span><br><span>     }</span><br><=
span> </span><br><span>     int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYC=
ONF_KEY_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsi=
gned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int rx_peer_id=
 =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;=
ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %u, peer-id %u, key-id: %d&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco-&gt;i=
findex, peer_id, key_id);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    dco-&gt;dco_message_peer_id =3D peer_id;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;ovpn-dco: received =
CMD_KEY_SWAP_NTF, ifindex: %d, rx-peer-id %u, key-id: %d&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;ifindex, rx_pee=
r_id, key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
co-&gt;dco_message_rx_peer_id =3D (int)rx_peer_id;</span><br><span>     dco=
-&gt;dco_message_key_id =3D key_id;</span><br><span>     dco-&gt;dco_messag=
e_type =3D OVPN_CMD_KEY_SWAP_NTF;</span><br><span> </span><br><span>@@ -152=
1,28 +1521,28 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_peer(dc=
o_context_t *dco, int peer_id, const bool raise_sigusr1_on_err)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_get_peer(dco_context_t *dco=
, int rx_peer_id, const bool raise_sigusr1_on_err)</span><br><span> {</span=
><br><span>     ASSERT(dco);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* peer_id =3D=3D -1 means &quot;dump all peer=
s&quot;, but this is allowed in MP mode only=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* rx_peer_id =3D=3D -1 means &quot;dump al=
l peers&quot;, but this is allowed in MP mode only=2E</span><br><span>     =
 * If it happens in P2P mode it means that the DCO peer was deleted and we<=
/span><br><span>      * can simply bail out</span><br><span>      */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (peer_id =3D=3D -1 &a=
mp;&amp; dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (rx_peer_id =3D=3D -1 &amp;&amp; dco-&gt;i=
fmode =3D=3D OVPN_MODE_P2P)</span><br><span>     {</span><br><span>        =
 return 0;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s=
: peer-id %d&quot;, __func__, peer_id);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: rx-peer-id=
 %u&quot;, __func__, rx_peer_id);</span><br><span> </span><br><span>     st=
ruct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);</spa=
n><br><span>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER=
);</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (peer_id !=3D -1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rx_peer_id !=3D -1)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT_U32(nl_msg, OVPN_A_PEER=
_ID, rx_peer_id);</span><br><span>     }</span><br><span>     else</span><b=
r><span>     {</span><br><span>@@ -1573,7 +1573,7 @@</span><br><span>      =
   return -1;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return dco_get_peer(&amp;c-&gt;c1=2Etu=
ntap-&gt;dco, c-&gt;c2=2Etls_multi-&gt;dco_peer_id, raise_sigusr1_on_err);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dco_get_p=
eer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id=
, raise_sigusr1_on_err);</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span>diff --git a/src/openvpn/dco_linux=2Eh b/src/openvp=
n/dco_linux=2Eh</span><br><span>index c487581=2E=2Ef79e5b1 100644</span><br=
><span>--- a/src/openvpn/dco_linux=2Eh</span><br><span>+++ b/src/openvpn/dc=
o_linux=2Eh</span><br><span>@@ -87,7 +87,7 @@</span><br><span>     unsigned=
 int ifindex;</span><br><span> </span><br><span>     int dco_message_type;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int dco_message_pe=
er_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int dco_m=
essage_rx_peer_id;</span><br><span>     int dco_message_key_id;</span><br><=
span>     int dco_del_peer_reason;</span><br><span>     struct sockaddr_sto=
rage dco_float_peer_ss;</span><br><span>diff --git a/src/openvpn/dco_win=2E=
c b/src/openvpn/dco_win=2Ec</span><br><span>index dbe8b78=2E=2Ef1e0418 1006=
44</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/=
openvpn/dco_win=2Ec</span><br><span>@@ -405,11 +405,11 @@</span><br><span> =
}</span><br><span> </span><br><span> int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco, unsigned int peerid, so=
cket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, socket_descript=
or_t sd,</span><br><span>              struct sockaddr *localaddr, struct s=
ockaddr *remoteaddr,</span><br><span>              const struct in_addr *vp=
n_ipv4, const struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-i=
d %u, fd &quot; SOCKET_PRINTF, __func__, peerid, sd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id=
 %u, fd &quot; SOCKET_PRINTF, __func__, rx_peer_id, sd);</span><br><span> <=
/span><br><span>     if (dco-&gt;ifmode =3D=3D DCO_MODE_P2P)</span><br><spa=
n>     {</span><br><span>@@ -444,7 +444,7 @@</span><br><span>         newPe=
er=2EVpnAddr6 =3D *vpn_ipv6;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    newPeer=2EPeerId =3D pe=
erid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    newPeer=2E=
PeerId =3D rx_peer_id;</span><br><span> </span><br><span>     DWORD bytesRe=
turned;</span><br><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN=
_IOCTL_MP_NEW_PEER, &amp;newPeer, sizeof(newPeer), NULL, 0,</span><br><span=
>@@ -458,11 +458,11 @@</span><br><span> }</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_del_peer(dco=
_context_t *dco, unsigned int peerid)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_del_peer(dco_context_t *dco, unsigned int rx_peer_id)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s=
: rx-peer-id %u&quot;, __func__, rx_peer_id);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_MP_DEL_PEER del_peer =3D=
 { peerid };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_MP_DEL_PEER del_peer =3D { rx_peer_id };</span><br><span>     VOID *buf =
=3D NULL;</span><br><span>     DWORD len =3D 0;</span><br><span>     DWORD =
ioctl =3D OVPN_IOCTL_DEL_PEER;</span><br><span>@@ -484,13 +484,13 @@</span>=
<br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_set_peer(dco_context_t *dco, unsigned i=
nt peerid, int keepalive_interval, int keepalive_timeout,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             int mss)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dco_set_peer(dco_context_t *dco, unsi=
gned int rx_peer_id, int keepalive_interval,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             int keepalive_timeout, int mss)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_DCO_DEBUG, &quot;%s: peer-id %u, keepalive %d/%d, mss %d&quot;, __func__,=
 peerid,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        keepa=
live_interval, keepalive_timeout, mss);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, keepalive=
 %d/%d, mss %d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        rx_peer_id, keepalive_interval, keepalive_timeout, mss)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keepalive_time=
out, mss };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_MP_SET_PEER mp_peer =3D { rx_peer_id, keepalive_interval, keepalive_timeou=
t, mss };</span><br><span>     OVPN_SET_PEER peer =3D { keepalive_interval,=
 keepalive_timeout, mss };</span><br><span>     VOID *buf =3D NULL;</span><=
br><span>     DWORD len =3D 0;</span><br><span>@@ -518,11 +518,11 @@</span>=
<br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_new_key(dco_context_t *dco, unsigned in=
t peerid, int keyid, dco_key_slot_t slot,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+dco_new_key(dco_context_t *dco, unsigned int rx_peer_=
id, int keyid, dco_key_slot_t slot,</span><br><span>             const uint=
8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,</s=
pan><br><span>             const uint8_t *decrypt_iv, const char *ciphernam=
e, bool epoch)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %u, =
cipher %s&quot;, __func__, slot, keyid, peerid,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id =
%d, rx-peer-id %u, cipher %s&quot;, __func__, slot, keyid, rx_peer_id,</spa=
n><br><span>         ciphername);</span><br><span> </span><br><span>     co=
nst int nonce_len =3D 8;</span><br><span>@@ -537,7 +537,7 @@</span><br><spa=
n>     v1-&gt;CipherAlg =3D dco_get_cipher(ciphername);</span><br><span>   =
  ASSERT(keyid &gt;=3D 0 &amp;&amp; keyid &lt;=3D UCHAR_MAX);</span><br><sp=
an>     v1-&gt;KeyId =3D (unsigned char)keyid;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    v1-&gt;PeerId =3D peerid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    v1-&gt;PeerId =3D rx_peer_id;</span>=
<br><span>     v1-&gt;KeySlot =3D slot;</span><br><span> </span><br><span> =
    /* for epoch we use key material as a seed, no as actual key */</span><=
br><span>@@ -573,19 +573,19 @@</span><br><span> }</span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_del_=
key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_del_key(dco_context_t *dc=
o, unsigned int rx_peer_id, dco_key_slot_t slot)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO, &quot;%s: peer=
-id %u, slot %d called but ignored&quot;, __func__, peerid, slot);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;%s: rx-=
peer-id %u, slot %d called but ignored&quot;, __func__, rx_peer_id, slot);<=
/span><br><span>     /* FIXME: Implement in driver first */</span><br><span=
>     return 0;</span><br><span> }</span><br><span> </span><br><span> int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_swap_keys(dco_conte=
xt_t *dco, unsigned int peer_id)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_swap_keys(dco_context_t *dco, unsigned int rx_peer_id)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peer_id);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: r=
x-peer-id %u&quot;, __func__, rx_peer_id);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    OVPN_MP_SWAP_KEYS swap =3D { pee=
r_id };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_=
SWAP_KEYS swap =3D { rx_peer_id };</span><br><span>     DWORD ioctl =3D OVP=
N_IOCTL_SWAP_KEYS;</span><br><span>     VOID *buf =3D NULL;</span><br><span=
>     DWORD len =3D 0;</span><br><span>@@ -676,7 +676,7 @@</span><br><span>=
         msg(D_DCO_DEBUG, &quot;%s: completion%s success [%lu]&quot;, __fun=
c__, queued ? &quot;&quot; : &quot; non-queued&quot;,</span><br><span>     =
        bytes_read);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        dco-&gt;dco_message_peer_id =3D dco-&gt;notif_buf=
=2EPeerId;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
co-&gt;dco_message_rx_peer_id =3D dco-&gt;notif_buf=2EPeerId;</span><br><sp=
an>         dco-&gt;dco_message_type =3D dco-&gt;notif_buf=2ECmd;</span><br=
><span>         dco-&gt;dco_del_peer_reason =3D dco-&gt;notif_buf=2EDelPeer=
Reason;</span><br><span>         dco-&gt;dco_float_peer_ss =3D dco-&gt;noti=
f_buf=2EFloatAddress;</span><br><span>@@ -695,7 +695,7 @@</span><br><span> =
        ASSERT(false);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;=
dco_message_rx_peer_id =3D -1;</span><br><span>     dco-&gt;dco_message_typ=
e =3D 0;</span><br><span> </span><br><span>     switch (dco-&gt;iostate)</s=
pan><br><span>@@ -833,7 +833,7 @@</span><br><span> </span><br><span>       =
  if (stat-&gt;PeerId &gt;=3D (int)dco-&gt;c-&gt;multi-&gt;max_clients)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_WARN, &quot;%s: received out of bound peer_id %d (max=
=3D%u)&quot;, __func__, stat-&gt;PeerId,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: received out of boun=
d rx_peer_id %d (max=3D%u)&quot;, __func__, stat-&gt;PeerId,</span><br><spa=
n>                 dco-&gt;c-&gt;multi-&gt;max_clients);</span><br><span>  =
           continue;</span><br><span>         }</span><br><span>@@ -841,7 +=
841,7 @@</span><br><span>         struct multi_instance *mi =3D dco-&gt;c-&=
gt;multi-&gt;instances[stat-&gt;PeerId];</span><br><span>         if (!mi)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(M_WARN, &quot;%s: received data for a non-existing pee=
r %d&quot;, __func__, stat-&gt;PeerId);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: received data for a n=
on-existing peer with RX ID %u&quot;, __func__, stat-&gt;PeerId);</span><br=
><span>             continue;</span><br><span>         }</span><br><span> <=
/span><br><span>@@ -904,7 +904,7 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     /* first, try a new ioctl */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OVPN_GET_PEER_STATS ps =3D { =2EPeerId =
=3D c-&gt;c2=2Etls_multi-&gt;dco_peer_id };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    OVPN_GET_PEER_STATS ps =3D { =2EPeerId =3D c-&g=
t;c2=2Etls_multi-&gt;dco_rx_peer_id };</span><br><span> </span><br><span>  =
   OVPN_PEER_STATS peer_stats =3D { 0 };</span><br><span>     DWORD bytes_r=
eturned =3D 0;</span><br><span>@@ -1014,16 +1014,16 @@</span><br><span> </s=
pan><br><span> void</span><br><span> dco_win_add_iroute_ipv4(dco_context_t =
*dco, in_addr_t dst, unsigned int netbits,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        unsigned int peer_id)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        unsi=
gned int rx_peer_id)</span><br><span> {</span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span> </span><br><span>     OVPN_MP_IROUTE ro=
ute =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =2EA=
ddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D =
peer_id, =2EIPv6 =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =3D netbits,=
 =2EPeerId =3D rx_peer_id, =2EIPv6 =3D 0</span><br><span>     };</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_=
DEBUG, &quot;%s: %s/%u -&gt; peer %u&quot;, __func__, print_in_addr_t(dst, =
IA_NET_ORDER, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        netbits, peer_id);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%d -&gt; rx-peer-id %u&quot;, __=
func__, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        netbits, rx_peer_id);</span><br><=
span> </span><br><span>     DWORD bytes_returned =3D 0;</span><br><span>   =
  if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;=
route, sizeof(route), NULL, 0,</span><br><span>@@ -1037,14 +1037,14 @@</spa=
n><br><span> </span><br><span> void</span><br><span> dco_win_add_iroute_ipv=
6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                        unsigned=
 int peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  unsigned int rx_peer_id)</span><br><span> {</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    OVPN_MP_IROUTE route =3D { =2EAddr=
=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =
=3D 1 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP=
_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPee=
rId =3D rx_peer_id, =2EIPv6 =3D 1 };</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: %s/%u -&gt;=
 peer %u&quot;, __func__, print_in6_addr(dst, IA_NET_ORDER, &amp;gc),</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        netbits, peer_id);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG,=
 &quot;%s: %s/%d -&gt; rx-peer-id %u&quot;, __func__, print_in6_addr(dst, I=
A_NET_ORDER, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        netbits, rx_peer_id);</span><br><span> </span><br><span>     DWO=
RD bytes_returned =3D 0;</span><br><span>     if (!DeviceIoControl(dco-&gt;=
tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,<=
/span><br><span>diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=
=2Eh</span><br><span>index a92e5ad=2E=2Efc9d698 100644</span><br><span>--- =
a/src/openvpn/dco_win=2Eh</span><br><span>+++ b/src/openvpn/dco_win=2Eh</sp=
an><br><span>@@ -50,7 +50,7 @@</span><br><span>     struct rw_handle rwhand=
le;   /**&lt; Used to hook async I/O to the OpenVPN event loop=2E */</span>=
<br><span>     int ov_ret;                  /**&lt; Win32 error code for ov=
erlapped operation, 0 for success */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int dco_message_peer_id;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int dco_message_rx_peer_id;</=
span><br><span>     int dco_message_type;</span><br><span>     int dco_del_=
peer_reason;</span><br><span>     struct sockaddr_storage dco_float_peer_ss=
;</span><br><span>@@ -68,10 +68,10 @@</span><br><span> bool dco_win_support=
s_multipeer(void);</span><br><span> </span><br><span> void dco_win_add_irou=
te_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                             uns=
igned int peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                             unsigned int rx_peer_id);</span><br><span> </s=
pan><br><span> void dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_=
addr dst, unsigned int netbits,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                             unsigned int peer_id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                             unsi=
gned int rx_peer_id);</span><br><span> </span><br><span> void dco_win_del_i=
route_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits);</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/open=
vpn/forward=2Ec</span><br><span>index 1604224=2E=2E1f5670b 100644</span><br=
><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forw=
ard=2Ec</span><br><span>@@ -151,7 +151,7 @@</span><br><span>     }</span><b=
r><span> </span><br><span>     /* no active peer (p2p tls-server mode) */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2=2Etls_=
multi-&gt;dco_peer_id =3D=3D -1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id =3D=3D -1)</sp=
an><br><span>     {</span><br><span>         return;</span><br><span>     }=
</span><br><span>@@ -1270,15 +1270,15 @@</span><br><span> #if defined(ENABL=
E_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</span>=
<br><span>     struct context *c =3D dco-&gt;c;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* FreeBSD currently sends =
us removal notifcation with the old peer-id in</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* FreeBSD currently sends us removal notifc=
ation with the old RX peer ID in</span><br><span>      * p2p mode with the =
ping timeout reason, so ignore that one to not shoot</span><br><span>      =
* ourselves in the foot and removing the just established session */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco-&gt;dco_message_=
peer_id !=3D c-&gt;c2=2Etls_multi-&gt;dco_peer_id)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (dco-&gt;dco_message_rx_peer_id !=3D =
c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id)</span><br><span>     {</span><br><=
span>         msg(D_DCO_DEBUG,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            &quot;%s: received message for mismatching peer-id %d,=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;%s: received message for mismatching rx-peer-id %d, &quot;</span><br>=
<span>             &quot;expected %d&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            __func__, dco-&gt;dco_message_peer_id, c-=
&gt;c2=2Etls_multi-&gt;dco_peer_id);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            __func__, dco-&gt;dco_message_rx_peer_id, c-&g=
t;c2=2Etls_multi-&gt;dco_rx_peer_id);</span><br><span>         return;</spa=
n><br><span>     }</span><br><span> </span><br><span>@@ -1286,21 +1286,21 @=
@</span><br><span>     {</span><br><span>         case OVPN_CMD_DEL_PEER:</=
span><br><span>             /* peer is gone, unset ID to prevent more kerne=
l calls */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D -1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_=
id =3D -1;</span><br><span>             if (dco-&gt;dco_del_peer_reason =3D=
=3D OVPN_DEL_PEER_REASON_EXPIRED)</span><br><span>             {</span><br>=
<span>                 msg(D_DCO_DEBUG,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    &quot;%s: received peer expired notif=
ication of for peer-id &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    &quot;%s: received peer expired notification =
of for rx-peer-id &quot;</span><br><span>                     &quot;%d&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 __func__, dco-&gt;dco_message_peer_id);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    __func__, dco-&gt;dco_message_rx_p=
eer_id);</span><br><span>                 trigger_ping_timeout_signal(c);</=
span><br><span>                 return;</span><br><span>             }</spa=
n><br><span>             break;</span><br><span> </span><br><span>         =
case OVPN_CMD_SWAP_KEYS:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(D_DCO_DEBUG, &quot;%s: received key rotation notificatio=
n for peer-id %d&quot;, __func__,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                dco-&gt;dco_message_peer_id);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;%s=
: received key rotation notification for rx-peer-id %d&quot;, __func__,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                dco-&gt=
;dco_message_rx_peer_id);</span><br><span>             tls_session_soft_res=
et(c-&gt;c2=2Etls_multi);</span><br><span>             break;</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index 1cf2a21=2E=2E2cf5495 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -3277,7 +3277,7 @@</span><br><span> </span><br><span>     /* Wh=
en kernel already deleted the peer, the socket is no longer</span><br><span=
>      * installed, and we do not need to clean up the state in the kernel =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context=
=2Ec2=2Etls_multi-&gt;dco_peer_id =3D -1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mi-&gt;context=2Ec2=2Etls_multi-&gt;dco_rx_peer_i=
d =3D -1;</span><br><span>     mi-&gt;context=2Esig-&gt;signal_text =3D rea=
son;</span><br><span>     multi_signal_instance(m, mi, SIGTERM);</span><br>=
<span> }</span><br><span>@@ -3289,19 +3289,19 @@</span><br><span> </span><b=
r><span>     struct multi_context *m =3D dco-&gt;c-&gt;multi;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =
=3D dco-&gt;dco_message_peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int rx_peer_id =3D dco-&gt;dco_message_rx_peer_id;</span><=
br><span> </span><br><span>     /* no peer-specific message delivered -&gt;=
 nothing to process=2E</span><br><span>      * bail out right away</span><b=
r><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (peer_id &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (rx_peer_id &lt; 0)</span><br><span>     {</span><br><span>         r=
eturn;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (((uint32_t)peer_id &lt; m-&gt;max_clients=
) &amp;&amp; m-&gt;instances[peer_id])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (((uint32_t)rx_peer_id &lt; m-&gt;max_clients) &a=
mp;&amp; m-&gt;instances[rx_peer_id])</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct multi_instance *mi =
=3D m-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct multi_instance *mi =3D m-&gt;instances[rx_peer_id]=
;</span><br><span>         set_prefix(mi);</span><br><span>         if (dco=
-&gt;dco_message_type =3D=3D OVPN_CMD_DEL_PEER)</span><br><span>         {<=
/span><br><span>@@ -3338,9 +3338,9 @@</span><br><span>             msglevel=
 =3D D_DCO_DEBUG;</span><br><span>         }</span><br><span>         msg(m=
sglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &=
quot;Received DCO message for unknown peer-id: %d, &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;Received DCO messag=
e for unknown rx-peer-id: %d, &quot;</span><br><span>             &quot;typ=
e %d, del_peer_reason %d&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            peer_id, dco-&gt;dco_message_type, dco-&gt;dco_del_pe=
er_reason);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    rx_peer_id, dco-&gt;dco_message_type, dco-&gt;dco_del_peer_reason);</sp=
an><br><span>     }</span><br><span> }</span><br><span> #endif /* if define=
d(ENABLE_DCO) */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/ope=
nvpn/ssl=2Ec</span><br><span>index aeec020=2E=2E137e340 100644</span><br><s=
pan>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</sp=
an><br><span>@@ -1179,7 +1179,7 @@</span><br><span> </span><br><span>     /=
* get command line derived options */</span><br><span>     ret-&gt;opt =3D =
*tls_options;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret-=
&gt;dco_peer_id =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ret-&gt;dco_rx_peer_id =3D -1;</span><br><span>     ret-&gt;use_asy=
mmetric_peer_id =3D false;</span><br><span>     /* The rx_peer_id is also u=
sed to identify DCO clients */</span><br><span>     ret-&gt;rx_peer_id =3D =
MAX_PEER_ID;</span><br><span>@@ -1685,12 +1685,12 @@</span><br><span>      =
    * ping-exit or mssfix are set to update in-kernel config */</span><br><=
span>         if (options-&gt;ping_send_timeout || options-&gt;ping_rec_tim=
eout || frame-&gt;mss_fix)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            int ret =3D dco_set_peer(dco, m=
ulti-&gt;dco_peer_id, options-&gt;ping_send_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            int ret =3D dco_set_peer(dco,=
 multi-&gt;dco_rx_peer_id, options-&gt;ping_send_timeout,</span><br><span> =
                                   options-&gt;ping_rec_timeout, frame-&gt;=
mss_fix);</span><br><span>             if (ret &lt; 0)</span><br><span>    =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     msg(D_DCO, &quot;Cannot set DCO peer parameters for peer (id=3D%d): %s=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      multi-&gt;dco_peer_id, strerror(-ret));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;Cannot set DCO p=
eer parameters for peer (rx-id=3D%u): %s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    multi-&gt;dco_rx_peer_id, s=
trerror(-ret));</span><br><span>                 return false;</span><br><s=
pan>             }</span><br><span>         }</span><br><span>diff --git a/=
src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>ind=
ex f6392f9=2E=2Ef32d188 100644</span><br><span>--- a/src/openvpn/ssl_common=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -7=
19,10 +719,10 @@</span><br><span>      * This is the handle that DCO uses t=
o identify this session with the</span><br><span>      * kernel=2E</span><b=
r><span>      *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 We keep this separate as the normal peer_id can change during</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * We keep this separate as =
the normal rx_peer_id can change during</span><br><span>      * p2p NCP and=
 we need to track the id that is really used=2E</span><br><span>      */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int dco_peer_id;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int dco_rx_peer_id;=
</span><br><span> </span><br><span>     dco_context_t *dco;</span><br><span=
> };</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1982?usp=3Demail">change 1982</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1982?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I25fad88fb4bb8e841a50981e31=
97d5b8d8f9069b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 19=
82 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dEFxKmpwcRM=--


--===============1047300127541944837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1047300127541944837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1047300127541944837==--

