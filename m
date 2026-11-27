Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C7606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bbGGBX5h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WvXuTvUF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WRcmLd8j;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XIIH359g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OuuAzcUJyVIpNi+GT+Oh9bYw7O5D4dX+qBNuuSJJsH8=; b=bbGGBX5hc7fTub3wHM9PEOOUk1
	vNjL5JcbeyQM5AqoaYYcRMSuL+sybuPos+6Exl8JT6aqTgzAug47MEQ3fnYrH5FUflcwQGMt/yA9F
	xLQsVVWk7lgiV/H7h/SFZxxuOKxkJJsWRUwQP+CLsul6xanVP6mRkd4XesSW3mH6fkao=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWt59-00000000552-1fdK;
	Fri, 27 Nov 2026 10:21:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWt58-0000000054s-1Ci2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wj6KhPG/eIgEA4mV90Ftl2jRgAYuBUFcwTOXb4m+XIw=; b=WvXuTvUFuC0BsUPKKjLb1RgH93
 DHesND6QMRCjGIQ2D4+54qaBLUXrMHqgJ6MFNs9sViHkHxkb+BB+vMEiROelS6BEqhE/F+HqhLUFK
 gs6g8Vy2nQd7pTc1uRfPuhp6tjqtl3ZE1esTME0H6rFu2zcqTueiJ+OMSuz2ZpAHpwN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wj6KhPG/eIgEA4mV90Ftl2jRgAYuBUFcwTOXb4m+XIw=; b=WRcmLd8j8qQ2NKN4ko7CymsdU7
 qqbSU5GXrSip4poBOWXRz3bcENUYfoONHtFAAwx+mYl7gbqLDg6YBH55fQBK0Wty6VGrpG/sk0/xN
 AG2ZcOKop+ZH1FD67qkWtGniOADx23Teiv5QtZiXyMPfVnSGYpafSIWwRjLijIDO0JY4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWt52-000000005Pm-0Bgv for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:21:30 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so4702930f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 02:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795774877; x=1796379677; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wj6KhPG/eIgEA4mV90Ftl2jRgAYuBUFcwTOXb4m+XIw=;
 b=XIIH359gp3XPTXyZ9Q+DPepJEF8SB9b+lF+1U+N4LXqSx5QpfFpu0QTEgguxsKi6Uv
 jEj2VtvDLMrIOBl3vBcH1SZwqLBVQ3xS3MbERygYE/iJvqNgUaVPgU/DxNotuKq3DcdE
 SPVvfpqQx4x/GCsxBP2bt8SNxWMOKze/nJ7csk+X9LO3mgGT4km+z+MrAodL8v3KWtK/
 fwHE5uOEtoPlXx/DOM7OL3UzcrZLQY650m2gmDZCxPr0nMeNDjPpHI6A1CxvpT6XTGWx
 DoPQRWrbNtHS9psX+uXqoPi2hvmK3KqO9jGzcJWjqj1w1d+LDXUfiPGNIo0zCQopn5KJ
 Qhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774877; x=1796379677;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wj6KhPG/eIgEA4mV90Ftl2jRgAYuBUFcwTOXb4m+XIw=;
 b=Sfq+3lEOFLzHZ3j5KPFdvPucR+l2hV2xJT+7Gb1so3yzWx6kP/Qatb6ZviwedTjDXr
 zJTw61QYOq/alNZ2dRli9XcWab25tlYUZBp8fZCeFcFEM8lsjf7C6r7z/B9dp0gDVhBF
 GpP/N80U/gx6qIeTNFNJyea0zPdIfx+YDlAPn9/dR/wda4b7FW2GJcVRJnlZBQwUIE7N
 oCr5IKL7WwgVu9DOXqGzNyF5Tt72oaE7jgQQ8ugfd1oN+kI1yG8tKfle1fdql68xeQQX
 kUNPkQLSnXiZ1AFTo8spGAiQb6H2/7jmGHtKU1kWkMuljkwXXZBKrVZlEWY+pngvZG5K
 EssA==
X-Gm-Message-State: APuU4Z8QJzKX3wPoSKa/pX/xZHWcgSQjO4GThtoe6Y6NRSmz3piTJrX3
 TAHzGtnaMo7uzjNCNcDARSMNJvtqiASG2/G0FTsWRtzDi2P5Te5V6egbBSCFulJtOm7QqqaArtT
 eCod4+ZCvhXUQUdd9KMNpV5YG63QxWJGPlI1uv1iSDRYNJy0B4glH+MgP1+1YoAqi00VO/oXYNf
 T6qbN79Q==
X-Gm-Gg: AZFdTZePKmCjCIBgerZfuTWYaJx3HrjV0NXrZvZwFX0mkBpu5SoaLHv+VDmfPrXXPOs
 aa42V0sR4CjOOiljon7+kA/tJki+TwRQ3cKOkEhCKOSHht2KSedq6GqeRIlIyRN+tXIS1uhqU+J
 PGieMGwt1d476ZmEit1Xjbq4ACVDKltTr3m53hSVqVOH0Xy69U9PSrR7jZmZcsKwUj1lshspspQ
 s2Q7ToL3bEXZ5X5yHa2gAyb45GOfH1JM0PJTsTAS+NhAMWKk1bNdhheXSoGDLuiltgAzThC8m2g
 nNg8dH52ZmzOowMTt0Ozad+e43tsz6qPrN58W4WPGdtqAyPt64Vg2zUr2kh1DVSflCPL39KhkMR
 X00L/RncAHLPj32BY3fgd3Xnl56KJLIaVJzbZDl40yQ0O8oc9+eJOQ970jyENhSLGKPD5rgDsVr
 6kGzt+n62xW1LGtb07AZEmHSKUZMcXkkzIFK0FdjXvI/mItidFBH1KyZENimxYQdrqBzAmCOlaR
 gyOv/OdGTcC8PlBR592GKWLMK2bZNiNhPqvoiKre6iiKEjS7Edd9Kq8psBvHSBhlQWp6MiaFTPF
 4L8aFEAYQX1s2U78/q99SRRKSqJR9lRwzXN4hBlJAiJRhBRzXSYyhgj+Orsrc3AsHGWiUgImJ/e
 adYpJHiSVy5/9MrgPiXWcVDwWdWfFmA3L/D8UZylAwKsXaI5zdZlTiTqqGrsyCGg7mgNUY1JXUs
 wBvOCqCvqg7d2uxp8=
X-Received: by 2002:a5d:5888:0:b0:4a7:8406:1e91 with SMTP id
 ffacd0b85a97d-4abb532eaf0mr41464127f8f.30.1795774876536; 
 Fri, 27 Nov 2026 02:21:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb42absm46993684f8f.1.2026.11.27.02.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:21:16 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 10:21:13 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I25fad88fb4bb8e841a50981e3197d5b8d8f9069b
X-Gerrit-Change-Number: 1982
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1982?usp=email>
X-Gerrit-Commit: ab970064f50f7ec7fc2b6d5b0ebd07ed65e6cc8a
In-Reply-To: <gerrit.1791286452000.I25fad88fb4bb8e841a50981e3197d5b8d8f9069b@gerrit.openvpn.net>
References: <gerrit.1791286452000.I25fad88fb4bb8e841a50981e3197d5b8d8f9069b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkyNWZhZDg4ZmI0YmI4ZTg0MWE1MDk4MWUzMTk3ZDViOGQ4ZjkwNjliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9bd329c061229d81f2dc36ed1ccb60cbc46f391f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWt52-000000005Pm-0Bgv
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: clarify RX peer
 ID naming and types
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4775164858423264959=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4775164858423264959==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dL4u+fnYfLk="; charset=UTF-8

--dL4u+fnYfLk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1982?usp=3Demail

to look at the new patch set (#=
5)=2E


Change subject: dco: clarify RX peer ID naming and types
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: clarify RX peer I=
D naming and types

The peer ID used to address a peer in DCO is its local =
RX ID=2E Make that
explicit in the installed-peer handle, notification fiel=
ds, and DCO API
parameters across all backends=2E

Use an unsigned local RX=
 ID when creating a peer and make conversions
explicit at the signed DCO ha=
ndle and Linux notification/statistics
boundaries=2E Keep DCO handles signe=
d for their -1 sentinel=2E

This prepares asymmetric peer ID support withou=
t changing behavior for
valid peer IDs=2E

Change-Id: I25fad88fb4bb8e841a50=
981e3197d5b8d8f9069b
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M =
src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M s=
rc/openvpn/dco_freebsd=2Eh
M src/openvpn/dco_internal=2Eh
M src/openvpn/dco=
_linux=2Ec
M src/openvpn/dco_linux=2Eh
M src/openvpn/dco_win=2Ec
M src/open=
vpn/dco_win=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/multi=2Ec
M src/ope=
nvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
13 files changed, 181 insertions(=
+), 181 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/82/1982/5

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dc=
o=2Ec
index 3c85c11=2E=2E0d1ae67 100644
--- a/src/openvpn/dco=2Ec
+++ b/src=
/openvpn/dco=2Ec
@@ -62,8 +62,8 @@
 
 {
     bool epoch =3D ks->crypto_opti=
ons=2Eflags & CO_EPOCH_DATA_KEY_FORMAT;
-    msg(D_DCO_DEBUG, "%s: peer_id=
=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed",
-        __func_=
_, multi->dco_peer_id, ks->key_id, epoch, multi->dco_keys_installed);
+    =
msg(D_DCO_DEBUG, "%s: rx_peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d k=
eys installed",
+        __func__, multi->dco_rx_peer_id, ks->key_id, epoch=
, multi->dco_keys_installed);
 
     /* Install a key in the PRIMARY slot o=
nly when no other key exist=2E
      * From that moment on, any new key wil=
l be installed in the SECONDARY
@@ -76,7 +76,7 @@
         slot =3D OVPN_KE=
Y_SLOT_SECONDARY;
     }
 
-    int ret =3D dco_new_key(multi->dco, multi->=
dco_peer_id, ks->key_id, slot, encrypt_key, encrypt_iv,
+    int ret =3D dc=
o_new_key(multi->dco, multi->dco_rx_peer_id, ks->key_id, slot, encrypt_key,=
 encrypt_iv,
                           decrypt_key, decrypt_iv, ciphername=
, epoch);
     if (ret =3D=3D 0)
     {
@@ -153,14 +153,14 @@
     {
      =
   msg(D_DCO, "No encryption key found=2E Purging data channel keys");
 
- =
       int ret =3D dco_del_key(dco, multi->dco_peer_id, OVPN_KEY_SLOT_PRIMA=
RY);
+        int ret =3D dco_del_key(dco, multi->dco_rx_peer_id, OVPN_KEY_=
SLOT_PRIMARY);
         if (ret < 0)
         {
             msg(D_DCO, "Ca=
nnot delete primary key during wipe: %s (%d)", strerror(-ret), ret);
      =
       return false;
         }
 
-        ret =3D dco_del_key(dco, multi->=
dco_peer_id, OVPN_KEY_SLOT_SECONDARY);
+        ret =3D dco_del_key(dco, mu=
lti->dco_rx_peer_id, OVPN_KEY_SLOT_SECONDARY);
         if (ret < 0)
      =
   {
             msg(D_DCO, "Cannot delete secondary key during wipe: %s (=
%d)", strerror(-ret), ret);
@@ -177,8 +177,8 @@
     if (primary->dco_statu=
s =3D=3D DCO_NOT_INSTALLED)
     {
         msg(D_DCO, "DCO key state misma=
tch: selected primary key is not installed "
-                   "(peer_id=
=3D%d, key_id=3D%d, dco_keys_installed=3D%d)",
-            multi->dco_peer=
_id, primary->key_id, multi->dco_keys_installed);
+                   "(rx_=
peer_id=3D%d, key_id=3D%d, dco_keys_installed=3D%d)",
+            multi->d=
co_rx_peer_id, primary->key_id, multi->dco_keys_installed);
         return=
 false;
     }
 
@@ -207,12 +207,12 @@
         if (secondary && secondary-=
>dco_status !=3D DCO_INSTALLED_PRIMARY)
         {
             msg(D_DCO, =
"DCO key state mismatch: expected old primary key is not installed as DCO p=
rimary before swap "
-                       "(peer_id=3D%d, new_primary_ke=
y_id=3D%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dco_keys_i=
nstalled=3D%d)",
-                multi->dco_peer_id, primary->key_id, seco=
ndary->key_id, secondary->dco_status, multi->dco_keys_installed);
+        =
               "(rx_peer_id=3D%d, new_primary_key_id=3D%d, old_primary_key_=
id=3D%d, old_primary_dco_status=3D%d, dco_keys_installed=3D%d)",
+         =
       multi->dco_rx_peer_id, primary->key_id, secondary->key_id, secondary=
->dco_status, multi->dco_keys_installed);
             return false;
      =
   }
 
-        int ret =3D dco_swap_keys(dco, multi->dco_peer_id);
+      =
  int ret =3D dco_swap_keys(dco, multi->dco_rx_peer_id);
         if (ret <=
 0)
         {
             msg(D_DCO, "Cannot swap keys: %s (%d)", strerro=
r(-ret), ret);
@@ -229,7 +229,7 @@
     /* if we have no secondary key anym=
ore, inform DCO about it */
     if (!secondary && multi->dco_keys_installe=
d =3D=3D 2)
     {
-        int ret =3D dco_del_key(dco, multi->dco_peer_id=
, OVPN_KEY_SLOT_SECONDARY);
+        int ret =3D dco_del_key(dco, multi->dc=
o_rx_peer_id, OVPN_KEY_SLOT_SECONDARY);
         if (ret < 0)
         {
  =
           msg(D_DCO, "Cannot delete secondary key: %s (%d)", strerror(-ret=
), ret);
@@ -543,10 +543,10 @@
 #ifdef TARGET_FREEBSD
     /* In Linux in P=
2P mode the kernel automatically removes an existing peer
      * when addi=
ng a new peer=2E FreeBSD needs to explicitly be told to do that */
-    if =
(c->c2=2Etls_multi->dco_peer_id !=3D -1)
+    if (c->c2=2Etls_multi->dco_rx=
_peer_id !=3D -1)
     {
-        dco_del_peer(&c->c1=2Etuntap->dco, c->c2=
=2Etls_multi->dco_peer_id);
-        c->c2=2Etls_multi->dco_peer_id =3D -1;=

+        dco_del_peer(&c->c1=2Etuntap->dco, c->c2=2Etls_multi->dco_rx_peer=
_id);
+        c->c2=2Etls_multi->dco_rx_peer_id =3D -1;
     }
 #endif
   =
  int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->s=
d, NULL,
@@ -557,7 +557,7 @@
         return ret;
     }
 
-    c->c2=2Etls=
_multi->dco_peer_id =3D multi->rx_peer_id;
+    c->c2=2Etls_multi->dco_rx_p=
eer_id =3D (int)multi->rx_peer_id;
 
     return 0;
 }
@@ -570,10 +570,10 @=
@
         return;
     }
 
-    if (c->c1=2Etuntap && c->c2=2Etls_multi &&=
 c->c2=2Etls_multi->dco_peer_id !=3D -1)
+    if (c->c1=2Etuntap && c->c2=
=2Etls_multi && c->c2=2Etls_multi->dco_rx_peer_id !=3D -1)
     {
-        =
dco_del_peer(&c->c1=2Etuntap->dco, c->c2=2Etls_multi->dco_peer_id);
-      =
  c->c2=2Etls_multi->dco_peer_id =3D -1;
+        dco_del_peer(&c->c1=2Etun=
tap->dco, c->c2=2Etls_multi->dco_rx_peer_id);
+        c->c2=2Etls_multi->d=
co_rx_peer_id =3D -1;
     }
 }
 
@@ -632,7 +632,7 @@
 {
     const struct =
context *c =3D &mi->context;
 
-    int peer_id =3D c->c2=2Etls_multi->rx_p=
eer_id;
+    uint32_t rx_peer_id =3D c->c2=2Etls_multi->rx_peer_id;
     st=
ruct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storag=
e local =3D { 0 };
     const socket_descriptor_t sd =3D c->c2=2Elink_socke=
ts[0]->sd;
@@ -670,13 +670,13 @@
     }
 
     int ret =3D
-        dco_new=
_peer(&c->c1=2Etuntap->dco, peer_id, sd, localaddr, remoteaddr, vpn_addr4, =
vpn_addr6);
+        dco_new_peer(&c->c1=2Etuntap->dco, rx_peer_id, sd, loc=
aladdr, remoteaddr, vpn_addr4, vpn_addr6);
     if (ret < 0)
     {
       =
  return ret;
     }
 
-    c->c2=2Etls_multi->dco_peer_id =3D peer_id;
+  =
  c->c2=2Etls_multi->dco_rx_peer_id =3D (int)rx_peer_id;
 
     return 0;
 =
}
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index b0a8621=2E=
=2Ebae239d 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -1=
80,14 +180,14 @@
  * and -1 (do not touch)=2E
  *
  * @param dco           =
     DCO device context
- * @param peer_id            the ID of the peer to=
 be modified
+ * @param rx_peer_id         the RX ID of the peer to be modi=
fied
  * @param keepalive_interval keepalive interval in seconds
  * @param=
 keepalive_timeout  keepalive timeout in seconds
  * @param mss            =
    TCP MSS value
  *
  * @return                   0 on success or a negat=
ive error code otherwise
  */
-int dco_set_peer(dco_context_t *dco, unsigne=
d int peerid, int keepalive_interval,
+int dco_set_peer(dco_context_t *dco,=
 unsigned int rx_peer_id, int keepalive_interval,
                  int kee=
palive_timeout, int mss);
 
 /**
@@ -349,7 +349,7 @@
 }
 
 static inline in=
t
-dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_inte=
rval, int keepalive_timeout,
+dco_set_peer(dco_context_t *dco, unsigned int=
 rx_peer_id, int keepalive_interval, int keepalive_timeout,
              i=
nt mss)
 {
     return 0;
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/op=
envpn/dco_freebsd=2Ec
index 9613c63=2E=2E8615cf0 100644
--- a/src/openvpn/d=
co_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -133,7 +133,7 @@
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
@@ -143,7 +143,7 @@
 
     nvl =3D nvlist_create(0);
 
-    =
msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d", __func__, peerid, sd);
+    msg(D=
_DCO_DEBUG, "%s: rx-peer-id %u, fd %d", __func__, rx_peer_id, sd);
 
     i=
f (localaddr)
     {
@@ -168,7 +168,7 @@
     }
 
     nvlist_add_number(nv=
l, "fd", sd);
-    nvlist_add_number(nvl, "peerid", peerid);
+    nvlist_ad=
d_number(nvl, "peerid", rx_peer_id);
 
     CLEAR(drv);
     snprintf(drv=
=2Eifd_name, IFNAMSIZ, "%s", dco->ifname);
@@ -353,16 +353,16 @@
 }
 
 int
=
-dco_swap_keys(dco_context_t *dco, unsigned int peerid)
+dco_swap_keys(dco_=
context_t *dco, unsigned int rx_peer_id)
 {
     struct ifdrv drv;
     nvl=
ist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %u", __func_=
_, peerid);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", __func__, rx_peer_id=
);
 
     nvl =3D nvlist_create(0);
-    nvlist_add_number(nvl, "peerid", p=
eerid);
+    nvlist_add_number(nvl, "peerid", rx_peer_id);
 
     CLEAR(drv=
);
     snprintf(drv=2Eifd_name, IFNAMSIZ, "%s", dco->ifname);
@@ -382,16 +=
382,16 @@
 }
 
 int
-dco_del_peer(dco_context_t *dco, unsigned int peerid)
=
+dco_del_peer(dco_context_t *dco, unsigned int rx_peer_id)
 {
     struct i=
fdrv drv;
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: pe=
er-id %u", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", __=
func__, rx_peer_id);
 
     nvl =3D nvlist_create(0);
-    nvlist_add_numbe=
r(nvl, "peerid", peerid);
+    nvlist_add_number(nvl, "peerid", rx_peer_id)=
;
 
     CLEAR(drv);
     snprintf(drv=2Eifd_name, IFNAMSIZ, "%s", dco->ifn=
ame);
@@ -411,17 +411,17 @@
 }
 
 int
-dco_del_key(dco_context_t *dco, unsi=
gned int peerid, dco_key_slot_t slot)
+dco_del_key(dco_context_t *dco, unsi=
gned int rx_peer_id, dco_key_slot_t slot)
 {
     struct ifdrv drv;
     nv=
list_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d=
", __func__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, slot =
%d", __func__, rx_peer_id, slot);
 
     nvl =3D nvlist_create(0);
     nvl=
ist_add_number(nvl, "slot", slot);
-    nvlist_add_number(nvl, "peerid", pe=
erid);
+    nvlist_add_number(nvl, "peerid", rx_peer_id);
 
     CLEAR(drv)=
;
     snprintf(drv=2Eifd_name, IFNAMSIZ, "%s", dco->ifname);
@@ -480,7 +48=
0,7 @@
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
@@ -488=
,14 +488,14 @@
     nvlist_t *nvl, *encrypt_nvl, *decrypt_nvl;
     int ret=
;
 
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s, e=
poch %d", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d=
, key-id %d, rx-peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, rx=
_peer_id,
         ciphername, epoch);
 
     nvl =3D nvlist_create(0);
 
 =
    nvlist_add_number(nvl, "slot", slot);
     nvlist_add_number(nvl, "keyi=
d", keyid);
-    nvlist_add_number(nvl, "peerid", peerid);
+    nvlist_add_=
number(nvl, "peerid", rx_peer_id);
 
     encrypt_nvl =3D key_to_nvlist(enc=
rypt_key, encrypt_iv, ciphername);
     decrypt_nvl =3D key_to_nvlist(decry=
pt_key, decrypt_iv, ciphername);
@@ -527,18 +527,18 @@
 }
 
 int
-dco_set_p=
eer(dco_context_t *dco, unsigned int peerid, int keepalive_interval, int ke=
epalive_timeout,
+dco_set_peer(dco_context_t *dco, unsigned int rx_peer_id,=
 int keepalive_interval, int keepalive_timeout,
              int mss)
 {
 =
    struct ifdrv drv;
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DE=
BUG, "%s: peer-id %u, ping interval %d, ping timeout %d", __func__, peerid,=

+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, ping interval %d, ping timeout %=
d", __func__, rx_peer_id,
         keepalive_interval, keepalive_timeout);
=
 
     nvl =3D nvlist_create(0);
-    nvlist_add_number(nvl, "peerid", peer=
id);
+    nvlist_add_number(nvl, "peerid", rx_peer_id);
     nvlist_add_num=
ber(nvl, "interval", keepalive_interval);
     nvlist_add_number(nvl, "time=
out", keepalive_timeout);
 
@@ -560,21 +560,21 @@
 }
 
 static void
-dco_up=
date_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nv=
l)
+dco_update_peer_stat(struct multi_context *m, uint32_t rx_peer_id, cons=
t nvlist_t *nvl)
 {
-    if (peerid >=3D m->max_clients || !m->instances[pe=
erid])
+    if (rx_peer_id >=3D m->max_clients || !m->instances[rx_peer_id]=
)
     {
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %u ret=
urned by kernel", peerid);
+        msg(M_WARN, "dco_update_peer_stat: inva=
lid peer RX ID %u returned by kernel", rx_peer_id);
         return;
     }=

 
-    struct multi_instance *mi =3D m->instances[peerid];
+    struct mul=
ti_instance *mi =3D m->instances[rx_peer_id];
 
     mi->context=2Ec2=2Edco=
_read_bytes =3D nvlist_get_number(nvl, "in");
     mi->context=2Ec2=2Edco_w=
rite_bytes =3D nvlist_get_number(nvl, "out");
 
-    msg(D_DCO_DEBUG, "%s: =
peer-id %u, dco_read_bytes: " counter_format " dco_write_bytes: " counter_f=
ormat,
-        __func__, peerid, mi->context=2Ec2=2Edco_read_bytes, mi->co=
ntext=2Ec2=2Edco_write_bytes);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, dc=
o_read_bytes: " counter_format " dco_write_bytes: " counter_format,
+      =
  __func__, rx_peer_id, mi->context=2Ec2=2Edco_read_bytes, mi->context=2Ec2=
=2Edco_write_bytes);
 }
 
 #if defined(__GNUC__) || defined(__clang__)
@@ -=
614,10 +614,10 @@
         return -EINVAL;
     }
 
-    /* dco_message_pee=
r_id is signed int, because other parts of the
+    /* dco_message_rx_peer_=
id is signed int, because other parts of the
      * code treat "-1" as "th=
is is a message not specific to one peer"
      */
-    dco->dco_message_pe=
er_id =3D (int)nvlist_get_number(nvl, "peerid");
+    dco->dco_message_rx_p=
eer_id =3D (int)nvlist_get_number(nvl, "peerid");
 
     type =3D (enum ovp=
n_notif_type)nvlist_get_number(nvl, "notification");
 
@@ -638,8 +638,8 @@
=
                     dco->dco_del_peer_reason =3D OVPN_DEL_PEER_REASON_USER=
SPACE;
                 }
             }
-            msg(D_DCO_DEBUG, "%s:=
 received NOTIF_DEL_PEER for peer-id=3D%d, reason=3D%d", __func__,
-       =
         dco->dco_message_peer_id, dco->dco_del_peer_reason);
+            =
msg(D_DCO_DEBUG, "%s: received NOTIF_DEL_PEER for rx-peer-id=3D%d, reason=
=3D%d", __func__,
+                dco->dco_message_rx_peer_id, dco->dco_de=
l_peer_reason);
 
             if (nvlist_exists_nvlist(nvl, "bytes"))
    =
         {
@@ -647,7 +647,7 @@
 
                 if (dco->c->mode =3D=3D C=
M_TOP)
                 {
-                    dco_update_peer_stat(dco->c-=
>multi, dco->dco_message_peer_id, bytes);
+                    dco_update_p=
eer_stat(dco->c->multi, dco->dco_message_rx_peer_id, bytes);
              =
   }
                 else
                 {
@@ -660,8 +660,8 @@
         =
    break;
 
         case OVPN_NOTIF_ROTATE_KEY:
-            msg(D_DCO_DE=
BUG, "%s: received NOTIF_ROTATE_KEY for peer-id=3D%d", __func__,
-         =
       dco->dco_message_peer_id);
+            msg(D_DCO_DEBUG, "%s: receiv=
ed NOTIF_ROTATE_KEY for rx-peer-id=3D%d", __func__,
+                dco->d=
co_message_rx_peer_id);
             dco->dco_message_type =3D OVPN_CMD_SWA=
P_KEYS;
             break;
 
@@ -681,8 +681,8 @@
                 msg(M_WA=
RN, "Failed to parse float notification");
                 break;
        =
     }
-            msg(D_DCO_DEBUG, "%s: received NOTIF_FLOAT for peer-id=
=3D%d", __func__,
-                dco->dco_message_peer_id);
+            =
msg(D_DCO_DEBUG, "%s: received NOTIF_FLOAT for rx-peer-id=3D%d", __func__,
=
+                dco->dco_message_rx_peer_id);
             dco->dco_messag=
e_type =3D OVPN_CMD_FLOAT_PEER;
             break;
         }
@@ -894,7 +8=
94,7 @@
     for (size_t i =3D 0; i < npeers; i++)
     {
         const nv=
list_t *peer =3D nvpeers[i];
-        uint32_t peerid =3D (uint32_t)nvlist_=
get_number(peer, "peerid");
+        uint32_t rx_peer_id =3D (uint32_t)nvli=
st_get_number(peer, "peerid");
         const nvlist_t *bytes =3D nvlist_ge=
t_nvlist(peer, "bytes");
 
         /* we can end here in p2mp mode, or in =
p2p mode via
@@ -902,7 +902,7 @@
          */
         if (dco->c->mode =3D=
=3D CM_TOP)
         {
-            dco_update_peer_stat(dco->c->multi, pee=
rid, bytes);
+            dco_update_peer_stat(dco->c->multi, rx_peer_id, b=
ytes);
         }
         else
         {
@@ -923,9 +923,9 @@
 dco_get_pee=
r_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
     ASSERT(=
c->c2=2Etls_multi);
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, c->c2=
=2Etls_multi->dco_peer_id);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %d", __fu=
nc__, c->c2=2Etls_multi->dco_rx_peer_id);
 
-    if (c->c2=2Etls_multi->dco=
_peer_id < 0)
+    if (c->c2=2Etls_multi->dco_rx_peer_id < 0)
     {
      =
   return -EINVAL; /* DCO not active yet */
     }
diff --git a/src/openvpn=
/dco_freebsd=2Eh b/src/openvpn/dco_freebsd=2Eh
index 5e2a552=2E=2E7b278fd 1=
00644
--- a/src/openvpn/dco_freebsd=2Eh
+++ b/src/openvpn/dco_freebsd=2Eh
@=
@ -58,7 +58,7 @@
     char ifname[IFNAMSIZ];
 
     int dco_message_type;
-=
    int dco_message_peer_id;
+    int dco_message_rx_peer_id;
     int dco_=
del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
 
diff --g=
it a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh
index 1022=
e66=2E=2Ea9203163 100644
--- a/src/openvpn/dco_internal=2Eh
+++ b/src/openv=
pn/dco_internal=2Eh
@@ -59,19 +59,19 @@
  * They are implemented by dco_lin=
ux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int peerid, so=
cket_descriptor_t sd,
+int dco_new_peer(dco_context_t *dco, unsigned int rx=
_peer_id, socket_descriptor_t sd,
                  struct sockaddr *locala=
ddr, struct sockaddr *remoteaddr,
                  const struct in_addr *v=
pn_ipv4, const struct in6_addr *vpn_ipv6);
 
-int dco_del_peer(dco_context_=
t *dco, unsigned int peerid);
+int dco_del_peer(dco_context_t *dco, unsigne=
d int rx_peer_id);
 
-int dco_new_key(dco_context_t *dco, unsigned int peer=
id, int keyid, dco_key_slot_t slot,
+int dco_new_key(dco_context_t *dco, un=
signed int rx_peer_id, int keyid, dco_key_slot_t slot,
                 con=
st uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_=
key,
                 const uint8_t *decrypt_iv, const char *ciphername, bo=
ol epoch);
 
-int dco_del_key(dco_context_t *dco, unsigned int peerid, dco_=
key_slot_t slot);
+int dco_del_key(dco_context_t *dco, unsigned int rx_peer=
_id, dco_key_slot_t slot);
 
-int dco_swap_keys(dco_context_t *dco, unsigne=
d int peerid);
+int dco_swap_keys(dco_context_t *dco, unsigned int rx_peer_=
id);
 
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_INTERNAL_H *=
/
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index =
fefc517=2E=2E9110649 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openv=
pn/dco_linux=2Ec
@@ -581,7 +581,7 @@
 #endif
 
 int
-dco_new_peer(dco_conte=
xt_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
+dco_ne=
w_peer(dco_context_t *dco, unsigned int rx_peer_id, int sd, struct sockaddr=
 *localaddr,
              struct sockaddr *remoteaddr, const struct in_add=
r *vpn_ipv4,
              const struct in6_addr *vpn_ipv6)
 {
@@ -591,7 +5=
91,7 @@
     {
         remotestr =3D print_sockaddr(remoteaddr, &gc);
    =
 }
-    msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d, remote addr: %s", __func__=
, peerid, sd, remotestr);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, fd %d, =
remote addr: %s", __func__, rx_peer_id, sd, remotestr);
 
     struct nl_ms=
g *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);
     if (!nl_m=
sg)
@@ -603,7 +603,7 @@
     struct nlattr *attr =3D nla_nest_start(nl_msg,=
 OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
 
-    NLA_PUT_U32(nl_msg, OVPN_=
A_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);
 =
    NLA_PUT_U32(nl_msg, OVPN_A_PEER_SOCKET, sd);
 
     /* Set the remote e=
ndpoint if defined (for UDP) */
@@ -818,7 +818,7 @@
 
     nl_socket_set_cb=
(dco->nl_sock, dco->nl_cb);
 
-    dco->dco_message_peer_id =3D -1;
+    dc=
o->dco_message_rx_peer_id =3D -1;
     nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, =
ovpn_nl_cb_error, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_FINISH, N=
L_CB_CUSTOM, ovpn_nl_cb_finish, &dco->status);
     nl_cb_set(dco->nl_cb, N=
L_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &dco->status);
@@ -944,9 +944,9 =
@@
 }
 
 int
-dco_swap_keys(dco_context_t *dco, unsigned int peerid)
+dco_s=
wap_keys(dco_context_t *dco, unsigned int rx_peer_id)
 {
-    msg(D_DCO_DEB=
UG, "%s: peer-id %u", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: rx-peer=
-id %u", __func__, rx_peer_id);
 
     struct nl_msg *nl_msg =3D ovpn_dco_n=
lmsg_create(dco, OVPN_CMD_KEY_SWAP);
     if (!nl_msg)
@@ -956,7 +956,7 @@
=
 
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
    =
 int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, pe=
erid);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);
     n=
la_nest_end(nl_msg, attr);
 
     ret =3D ovpn_nl_msg_send(dco, nl_msg, __f=
unc__);
@@ -968,9 +968,9 @@
 
 
 int
-dco_del_peer(dco_context_t *dco, unsi=
gned int peerid)
+dco_del_peer(dco_context_t *dco, unsigned int rx_peer_id)=

 {
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %u", __func__, peerid)=
;
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: rx-peer-id %u", __func__, rx_pee=
r_id);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD=
_PEER_DEL);
     if (!nl_msg)
@@ -980,7 +980,7 @@
 
     struct nlattr *att=
r =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
-   =
 NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN=
_A_PEER_ID, rx_peer_id);
     nla_nest_end(nl_msg, attr);
 
     ret =3D ov=
pn_nl_msg_send(dco, nl_msg, __func__);
@@ -992,10 +992,10 @@
 
 
 int
-dco_=
del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
+dco_=
del_key(dco_context_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot)
 =
{
     int ret =3D -EMSGSIZE;
-    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %=
d", __func__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, slot=
 %d", __func__, rx_peer_id, slot);
 
     struct nl_msg *nl_msg =3D ovpn_dc=
o_nlmsg_create(dco, OVPN_CMD_KEY_DEL);
     if (!nl_msg)
@@ -1004,7 +1004,7=
 @@
     }
 
     struct nlattr *keyconf =3D nla_nest_start(nl_msg, OVPN_A_=
KEYCONF);
-    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
+    NL=
A_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);
     NLA_PUT_U32(nl_=
msg, OVPN_A_KEYCONF_SLOT, slot);
     nla_nest_end(nl_msg, keyconf);
 
@@ -=
1016,11 +1016,11 @@
 }
 
 int
-dco_new_key(dco_context_t *dco, unsigned int=
 peerid, int keyid, dco_key_slot_t slot,
+dco_new_key(dco_context_t *dco, u=
nsigned int rx_peer_id, int keyid, dco_key_slot_t slot,
             const =
uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key=
,
             const uint8_t *decrypt_iv, const char *ciphername, bool epoc=
h)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s,=
 epoch %d", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot =
%d, key-id %d, rx-peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, =
rx_peer_id,
         ciphername, epoch);
 
     const size_t key_len =3D ci=
pher_kt_key_size(ciphername);
@@ -1038,7 +1038,7 @@
     int ret =3D -EMSGS=
IZE;
 
     struct nlattr *key_conf =3D nla_nest_start(nl_msg, OVPN_A_KEYCO=
NF);
-    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
+    NLA_PUT=
_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);
     NLA_PUT_U32(nl_msg, =
OVPN_A_KEYCONF_SLOT, slot);
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_KEY_ID,=
 keyid);
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, dco_cipher);
@=
@ -1070,10 +1070,10 @@
 }
 
 int
-dco_set_peer(dco_context_t *dco, unsigned=
 int peerid, int keepalive_interval, int keepalive_timeout,
+dco_set_peer(d=
co_context_t *dco, unsigned int rx_peer_id, int keepalive_interval, int kee=
palive_timeout,
              int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-i=
d %u, keepalive %d/%d, mss %d", __func__, peerid,
+    msg(D_DCO_DEBUG, "%s=
: rx-peer-id %u, keepalive %d/%d, mss %d", __func__, rx_peer_id,
         k=
eepalive_interval, keepalive_timeout, mss);
 
     struct nl_msg *nl_msg =
=3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);
@@ -1084,7 +1084,7 @@
 
=
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int =
ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+    N=
LA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);
     NLA_PUT_U32(nl_msg, OV=
PN_A_PEER_KEEPALIVE_INTERVAL, keepalive_interval);
     NLA_PUT_U32(nl_msg,=
 OVPN_A_PEER_KEEPALIVE_TIMEOUT, keepalive_timeout);
     nla_nest_end(nl_ms=
g, attr);
@@ -1227,7 +1227,7 @@
 }
 
 static void
-dco_update_peer_stat(str=
uct context_2 *c2, struct nlattr *tb[], uint32_t id)
+dco_update_peer_stat(=
struct context_2 *c2, struct nlattr *tb[], uint32_t rx_id)
 {
     if (tb[O=
VPN_A_PEER_LINK_RX_BYTES])
     {
@@ -1236,7 +1236,7 @@
     }
     else
  =
   {
-        msg(M_WARN, "%s: no link RX bytes provided in reply for peer =
%u", __func__, id);
+        msg(M_WARN, "%s: no link RX bytes provided in =
reply for peer with RX ID %u", __func__, rx_id);
     }
 
     if (tb[OVPN_=
A_PEER_LINK_TX_BYTES])
@@ -1246,7 +1246,7 @@
     }
     else
     {
-     =
   msg(M_WARN, "%s: no link TX bytes provided in reply for peer %u", __func=
__, id);
+        msg(M_WARN, "%s: no link TX bytes provided in reply for p=
eer with RX ID %u", __func__, rx_id);
     }
 
     if (tb[OVPN_A_PEER_VPN_=
RX_BYTES])
@@ -1256,7 +1256,7 @@
     }
     else
     {
-        msg(M_WAR=
N, "%s: no VPN RX bytes provided in reply for peer %u", __func__, id);
+   =
     msg(M_WARN, "%s: no VPN RX bytes provided in reply for peer with RX ID=
 %u", __func__, rx_id);
     }
 
     if (tb[OVPN_A_PEER_VPN_TX_BYTES])
@@ =
-1266,7 +1266,7 @@
     }
     else
     {
-        msg(M_WARN, "%s: no VPN=
 TX bytes provided in reply for peer %u", __func__, id);
+        msg(M_WAR=
N, "%s: no VPN TX bytes provided in reply for peer with RX ID %u", __func__=
, rx_id);
     }
 }
 
@@ -1284,43 +1284,43 @@
 
     if (!tb_peer[OVPN_A_PE=
ER_ID])
     {
-        msg(M_WARN, "ovpn-dco: no peer-id provided in PEER_=
GET reply");
+        msg(M_WARN, "ovpn-dco: no rx-peer-id provided in PEER=
_GET reply");
         return NL_SKIP;
     }
 
-    uint32_t peer_id =3D n=
la_get_u32(tb_peer[OVPN_A_PEER_ID]);
+    uint32_t rx_peer_id =3D nla_get_u=
32(tb_peer[OVPN_A_PEER_ID]);
     struct context_2 *c2;
 
-    msg(D_DCO_DE=
BUG | M_NOIPREFIX, "%s: parsing message for peer %u=2E=2E=2E", __func__, pe=
er_id);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer w=
ith RX ID %u=2E=2E=2E", __func__, rx_peer_id);
 
     if (dco->ifmode =3D=
=3D OVPN_MODE_P2P)
     {
         c2 =3D &dco->c->c2;
-        if (c2->tls=
_multi->dco_peer_id !=3D (int)peer_id)
+        if ((uint32_t)c2->tls_multi=
->dco_rx_peer_id !=3D rx_peer_id)
         {
             return NL_SKIP;
 =
        }
     }
     else
     {
-        if (peer_id >=3D dco->c->multi->=
max_clients)
+        if (rx_peer_id >=3D dco->c->multi->max_clients)
     =
    {
-            msg(M_WARN, "%s: received out of bound peer_id %u (max=
=3D%u)", __func__, peer_id,
+            msg(M_WARN, "%s: received out of b=
ound rx_peer_id %u (max=3D%u)", __func__, rx_peer_id,
                 dco-=
>c->multi->max_clients);
             return NL_SKIP;
         }
 
-       =
 struct multi_instance *mi =3D dco->c->multi->instances[peer_id];
+        =
struct multi_instance *mi =3D dco->c->multi->instances[rx_peer_id];
       =
  if (!mi)
         {
-            msg(M_WARN | M_NOIPREFIX, "%s: received =
data for a non-existing peer %u", __func__, peer_id);
+            msg(M_WA=
RN | M_NOIPREFIX, "%s: received data for a non-existing peer with RX ID %u"=
, __func__, rx_peer_id);
             return NL_SKIP;
         }
 
        =
 c2 =3D &mi->context=2Ec2;
     }
 
-    dco_update_peer_stat(c2, tb_peer, =
peer_id);
+    dco_update_peer_stat(c2, tb_peer, rx_peer_id);
 
     return=
 NL_OK;
 }
@@ -1375,16 +1375,16 @@
     }
     if (!dp_attrs[OVPN_A_PEER_ID=
])
     {
-        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no peer-id in PEER_D=
EL_NTF message");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no rx-peer-i=
d in PEER_DEL_NTF message");
         return NL_STOP;
     }
 
     int rea=
son =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
-    unsigned int pe=
erid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
+    unsigned int rx_peer_i=
d =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
 
-    msg(D_DCO_DEBUG | M_NOI=
PREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reas=
on: %d",
-        dco->ifindex, peerid, reason);
-    dco->dco_message_peer=
_id =3D peerid;
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD=
_PEER_DEL_NTF, ifindex: %u, rx-peer-id %u, reason: %d",
+        dco->ifind=
ex, rx_peer_id, reason);
+    dco->dco_message_rx_peer_id =3D rx_peer_id;
 =
    dco->dco_del_peer_reason =3D reason;
     dco->dco_message_type =3D OVP=
N_CMD_PEER_DEL_NTF;
 
@@ -1414,10 +1414,10 @@
 
     if (!fp_attrs[OVPN_A_P=
EER_ID])
     {
-        msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF=
 message");
+        msg(D_DCO, "ovpn-dco: no rx-peer-id in PEER_FLOAT_NTF =
message");
         return NL_STOP;
     }
-    uint32_t peerid =3D nla_get=
_u32(fp_attrs[OVPN_A_PEER_ID]);
+    uint32_t rx_peer_id =3D nla_get_u32(fp=
_attrs[OVPN_A_PEER_ID]);
 
     if (!ovpn_parse_float_addr(fp_attrs, (struc=
t sockaddr *)&dco->dco_float_peer_ss))
     {
@@ -1425,9 +1425,9 @@
     }
=
 
     struct gc_arena gc =3D gc_new();
-    msg(D_DCO_DEBUG, "ovpn-dco: re=
ceived CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s",
-        =
dco->ifindex, peerid, print_sockaddr((struct sockaddr *)&dco->dco_float_pee=
r_ss, &gc));
-    dco->dco_message_peer_id =3D (int)peerid;
+    msg(D_DCO_=
DEBUG, "ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, rx-peer-id %u, =
address: %s",
+        dco->ifindex, rx_peer_id, print_sockaddr((struct soc=
kaddr *)&dco->dco_float_peer_ss, &gc));
+    dco->dco_message_rx_peer_id =
=3D (int)rx_peer_id;
     dco->dco_message_type =3D OVPN_CMD_PEER_FLOAT_NTF=
;
 
     gc_free(&gc);
@@ -1457,7 +1457,7 @@
     }
     if (!dp_attrs[OVPN=
_A_KEYCONF_PEER_ID])
     {
-        msg(D_DCO, "ovpn-dco: no peer-id in KE=
Y_SWAP_NTF message");
+        msg(D_DCO, "ovpn-dco: no rx-peer-id in KEY_S=
WAP_NTF message");
         return NL_STOP;
     }
     if (!dp_attrs[OVPN_=
A_KEYCONF_KEY_ID])
@@ -1467,11 +1467,11 @@
     }
 
     int key_id =3D nla=
_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
-    unsigned int peer_id =3D nl=
a_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
+    unsigned int rx_peer_id =
=3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
 
-    msg(D_DCO_DEBUG, =
"ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %u, peer-id %u, key-id: %d",=

-        dco->ifindex, peer_id, key_id);
-    dco->dco_message_peer_id =3D=
 peer_id;
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifind=
ex: %u, rx-peer-id %u, key-id: %d",
+        dco->ifindex, rx_peer_id, key_=
id);
+    dco->dco_message_rx_peer_id =3D (int)rx_peer_id;
     dco->dco_me=
ssage_key_id =3D key_id;
     dco->dco_message_type =3D OVPN_CMD_KEY_SWAP_N=
TF;
 
@@ -1585,20 +1585,20 @@
 }
 
 static int
-dco_get_peer(dco_context_t =
*dco, int peer_id, const bool raise_sigusr1_on_err)
+dco_get_peer(dco_conte=
xt_t *dco, int rx_peer_id, const bool raise_sigusr1_on_err)
 {
     ASSERT(=
dco);
 
-    /* peer_id =3D=3D -1 means "dump all peers", but this is allow=
ed in MP mode only=2E
+    /* rx_peer_id =3D=3D -1 means "dump all peers", =
but this is allowed in MP mode only=2E
      * If it happens in P2P mode it=
 means that the DCO peer was deleted and we
      * can simply bail out
   =
   */
-    if (peer_id =3D=3D -1 && dco->ifmode =3D=3D OVPN_MODE_P2P)
+    =
if (rx_peer_id =3D=3D -1 && dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
      =
   return 0;
     }
 
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d",=
 __func__, peer_id);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: rx-peer-id %d=
", __func__, rx_peer_id);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_c=
reate(dco, OVPN_CMD_PEER_GET);
     if (!nl_msg)
@@ -1609,9 +1609,9 @@
    =
 struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =
=3D -EMSGSIZE;
 
-    if (peer_id !=3D -1)
+    if (rx_peer_id !=3D -1)
   =
  {
-        NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
+        NLA_PUT=
_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);
     }
     else
     {
@@ -1646,=
7 +1646,7 @@
         return -1;
     }
 
-    return dco_get_peer(&c->c1=
=2Etuntap->dco, c->c2=2Etls_multi->dco_peer_id, raise_sigusr1_on_err);
+   =
 return dco_get_peer(&c->c1=2Etuntap->dco, c->c2=2Etls_multi->dco_rx_peer_i=
d, raise_sigusr1_on_err);
 }
 
 int
diff --git a/src/openvpn/dco_linux=2Eh =
b/src/openvpn/dco_linux=2Eh
index c487581=2E=2Ef79e5b1 100644
--- a/src/ope=
nvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_linux=2Eh
@@ -87,7 +87,7 @@
     u=
nsigned int ifindex;
 
     int dco_message_type;
-    int dco_message_peer=
_id;
+    int dco_message_rx_peer_id;
     int dco_message_key_id;
     int=
 dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
diff =
--git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 0f2b9eb=2E=
=2E16cadc6 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=
=2Ec
@@ -411,11 +411,11 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, socket_descriptor_t sd,
+dco_new_peer(dco_context_t *dco, =
unsigned int rx_peer_id, socket_descriptor_t sd,
              struct socka=
ddr *localaddr, struct sockaddr *remoteaddr,
              const struct in_=
addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_DEBUG, "=
%s: peer-id %u, fd " SOCKET_PRINTF, __func__, peerid, sd);
+    msg(D_DCO_D=
EBUG, "%s: rx-peer-id %u, fd " SOCKET_PRINTF, __func__, rx_peer_id, sd);
 
=
     if (dco->ifmode =3D=3D DCO_MODE_P2P)
     {
@@ -450,7 +450,7 @@
      =
   newPeer=2EVpnAddr6 =3D *vpn_ipv6;
     }
 
-    newPeer=2EPeerId =3D pee=
rid;
+    newPeer=2EPeerId =3D rx_peer_id;
 
     DWORD bytesReturned;
    =
 if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_NEW_PEER, &newPeer, size=
of(newPeer), NULL, 0,
@@ -464,11 +464,11 @@
 }
 
 int
-dco_del_peer(dco_con=
text_t *dco, unsigned int peerid)
+dco_del_peer(dco_context_t *dco, unsigne=
d int rx_peer_id)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peer=
id);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", __func__, rx_peer_id);
 
- =
   OVPN_MP_DEL_PEER del_peer =3D { peerid };
+    OVPN_MP_DEL_PEER del_peer=
 =3D { rx_peer_id };
     VOID *buf =3D NULL;
     DWORD len =3D 0;
     DW=
ORD ioctl =3D OVPN_IOCTL_DEL_PEER;
@@ -490,13 +490,13 @@
 }
 
 int
-dco_set=
_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interval, int =
keepalive_timeout,
-             int mss)
+dco_set_peer(dco_context_t *dco,=
 unsigned int rx_peer_id, int keepalive_interval,
+             int keepali=
ve_timeout, int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive %d=
/%d, mss %d", __func__, peerid,
-        keepalive_interval, keepalive_time=
out, mss);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, keepalive %d/%d, mss %=
d", __func__,
+        rx_peer_id, keepalive_interval, keepalive_timeout, m=
ss);
 
-    OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keep=
alive_timeout, mss };
+    OVPN_MP_SET_PEER mp_peer =3D { rx_peer_id, keepa=
live_interval, keepalive_timeout, mss };
     OVPN_SET_PEER peer =3D { keep=
alive_interval, keepalive_timeout, mss };
     VOID *buf =3D NULL;
     DWO=
RD len =3D 0;
@@ -524,11 +524,11 @@
 }
 
 int
-dco_new_key(dco_context_t *d=
co, unsigned int peerid, int keyid, dco_key_slot_t slot,
+dco_new_key(dco_c=
ontext_t *dco, unsigned int rx_peer_id, int keyid, dco_key_slot_t slot,
   =
          const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint=
8_t *decrypt_key,
             const uint8_t *decrypt_iv, const char *ciphe=
rname, bool epoch)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-i=
d %u, cipher %s", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s:=
 slot %d, key-id %d, rx-peer-id %u, cipher %s", __func__, slot, keyid, rx_p=
eer_id,
         ciphername);
 
     const int nonce_len =3D 8;
@@ -543,7 +=
543,7 @@
     v1->CipherAlg =3D dco_get_cipher(ciphername);
     ASSERT(key=
id >=3D 0 && keyid <=3D UCHAR_MAX);
     v1->KeyId =3D (unsigned char)keyid=
;
-    v1->PeerId =3D peerid;
+    v1->PeerId =3D rx_peer_id;
     v1->KeyS=
lot =3D slot;
 
     /* for epoch we use key material as a seed, no as actu=
al key */
@@ -579,19 +579,19 @@
 }
 
 int
-dco_del_key(dco_context_t *dco, =
unsigned int peerid, dco_key_slot_t slot)
+dco_del_key(dco_context_t *dco, =
unsigned int rx_peer_id, dco_key_slot_t slot)
 {
-    msg(D_DCO, "%s: peer-=
id %u, slot %d called but ignored", __func__, peerid, slot);
+    msg(D_DCO=
, "%s: rx-peer-id %u, slot %d called but ignored", __func__, rx_peer_id, sl=
ot);
     /* FIXME: Implement in driver first */
     return 0;
 }
 
 int
-=
dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
+dco_swap_keys(dco_=
context_t *dco, unsigned int rx_peer_id)
 {
-    msg(D_DCO_DEBUG, "%s: peer=
-id %u", __func__, peer_id);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u", __f=
unc__, rx_peer_id);
 
-    OVPN_MP_SWAP_KEYS swap =3D { peer_id };
+    OVP=
N_MP_SWAP_KEYS swap =3D { rx_peer_id };
     DWORD ioctl =3D OVPN_IOCTL_SWA=
P_KEYS;
     VOID *buf =3D NULL;
     DWORD len =3D 0;
@@ -682,7 +682,7 @@
=
         msg(D_DCO_DEBUG, "%s: completion%s success [%lu]", __func__, queue=
d ? "" : " non-queued",
             bytes_read);
 
-        dco->dco_messa=
ge_peer_id =3D dco->notif_buf=2EPeerId;
+        dco->dco_message_rx_peer_i=
d =3D dco->notif_buf=2EPeerId;
         dco->dco_message_type =3D dco->noti=
f_buf=2ECmd;
         dco->dco_del_peer_reason =3D dco->notif_buf=2EDelPeer=
Reason;
         dco->dco_float_peer_ss =3D dco->notif_buf=2EFloatAddress;
=
@@ -701,7 +701,7 @@
         ASSERT(false);
     }
 
-    dco->dco_message_=
peer_id =3D -1;
+    dco->dco_message_rx_peer_id =3D -1;
     dco->dco_mess=
age_type =3D 0;
 
     switch (dco->iostate)
@@ -839,7 +839,7 @@
 
        =
 if (stat->PeerId >=3D (int)dco->c->multi->max_clients)
         {
-       =
     msg(M_WARN, "%s: received out of bound peer_id %d (max=3D%u)", __func_=
_, stat->PeerId,
+            msg(M_WARN, "%s: received out of bound rx_pee=
r_id %d (max=3D%u)", __func__, stat->PeerId,
                 dco->c->multi=
->max_clients);
             continue;
         }
@@ -847,7 +847,7 @@
     =
    struct multi_instance *mi =3D dco->c->multi->instances[stat->PeerId];
 =
        if (!mi)
         {
-            msg(M_WARN, "%s: received data for=
 a non-existing peer %d", __func__, stat->PeerId);
+            msg(M_WARN,=
 "%s: received data for a non-existing peer with RX ID %d", __func__, stat-=
>PeerId);
             continue;
         }
 
@@ -910,7 +910,7 @@
     }
 
=
     /* first, try a new ioctl */
-    OVPN_GET_PEER_STATS ps =3D { =2EPeer=
Id =3D c->c2=2Etls_multi->dco_peer_id };
+    OVPN_GET_PEER_STATS ps =3D { =
=2EPeerId =3D c->c2=2Etls_multi->dco_rx_peer_id };
 
     OVPN_PEER_STATS p=
eer_stats =3D { 0 };
     DWORD bytes_returned =3D 0;
@@ -1020,16 +1020,16 =
@@
 
 void
 dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsi=
gned int netbits,
-                        unsigned int peer_id)
+         =
               unsigned int rx_peer_id)
 {
     struct gc_arena gc =3D gc_n=
ew();
 
     OVPN_MP_IROUTE route =3D {
-        =2EAddr=2EAddr4=2ES_un=2ES=
_addr =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 0=

+        =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =3D netbits, =
=2EPeerId =3D rx_peer_id, =2EIPv6 =3D 0
     };
 
-    msg(D_DCO_DEBUG, "%s=
: %s/%u -> peer %u", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
-  =
      netbits, peer_id);
+    msg(D_DCO_DEBUG, "%s: %s/%u -> rx-peer-id %u"=
, __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
+        netbits, rx_p=
eer_id);
 
     DWORD bytes_returned =3D 0;
     if (!DeviceIoControl(dco->=
tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
@@ -104=
3,14 +1043,14 @@
 
 void
 dco_win_add_iroute_ipv6(dco_context_t *dco, struc=
t in6_addr dst, unsigned int netbits,
-                        unsigned int=
 peer_id)
+                        unsigned int rx_peer_id)
 {
     struct =
gc_arena gc =3D gc_new();
 
-    OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6=
 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 1 };
+=
    OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netb=
its, =2EPeerId =3D rx_peer_id, =2EIPv6 =3D 1 };
 
-    msg(D_DCO_DEBUG, "%s=
: %s/%u -> peer %u", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
-   =
     netbits, peer_id);
+    msg(D_DCO_DEBUG, "%s: %s/%u -> rx-peer-id %u",=
 __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
+        netbits, rx_pee=
r_id);
 
     DWORD bytes_returned =3D 0;
     if (!DeviceIoControl(dco->tt=
->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
diff --gi=
t a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index a92e5ad=2E=2Efc=
9d698 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco_win=2Eh
@@=
 -50,7 +50,7 @@
     struct rw_handle rwhandle;   /**< Used to hook async I=
/O to the OpenVPN event loop=2E */
     int ov_ret;                  /**< W=
in32 error code for overlapped operation, 0 for success */
 
-    int dco_m=
essage_peer_id;
+    int dco_message_rx_peer_id;
     int dco_message_type;=

     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_=
ss;
@@ -68,10 +68,10 @@
 bool dco_win_supports_multipeer(void);
 
 void dco=
_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbit=
s,
-                             unsigned int peer_id);
+                  =
           unsigned int rx_peer_id);
 
 void dco_win_add_iroute_ipv6(dco_co=
ntext_t *dco, struct in6_addr dst, unsigned int netbits,
-                 =
            unsigned int peer_id);
+                             unsigned i=
nt rx_peer_id);
 
 void dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr=
_t dst, unsigned int netbits);
 
diff --git a/src/openvpn/forward=2Ec b/src=
/openvpn/forward=2Ec
index b4277db=2E=2E256f915 100644
--- a/src/openvpn/fo=
rward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -152,7 +152,7 @@
     }
 
     /=
* no active peer (p2p tls-server mode) */
-    if (c->c2=2Etls_multi->dco_p=
eer_id =3D=3D -1)
+    if (c->c2=2Etls_multi->dco_rx_peer_id =3D=3D -1)
   =
  {
         return;
     }
@@ -1266,15 +1266,15 @@
 #if defined(ENABLE_DCO=
) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
     struct context=
 *c =3D dco->c;
 
-    /* FreeBSD currently sends us removal notifcation wi=
th the old peer-id in
+    /* FreeBSD currently sends us removal notifcatio=
n with the old RX peer ID in
      * p2p mode with the ping timeout reason,=
 so ignore that one to not shoot
      * ourselves in the foot and removing=
 the just established session */
-    if (dco->dco_message_peer_id !=3D c->=
c2=2Etls_multi->dco_peer_id)
+    if (dco->dco_message_rx_peer_id !=3D c->c=
2=2Etls_multi->dco_rx_peer_id)
     {
         msg(D_DCO_DEBUG,
-          =
  "%s: received message for mismatching peer-id %d, "
+            "%s: rec=
eived message for mismatching rx-peer-id %d, "
             "expected %d",
=
-            __func__, dco->dco_message_peer_id, c->c2=2Etls_multi->dco_pee=
r_id);
+            __func__, dco->dco_message_rx_peer_id, c->c2=2Etls_mult=
i->dco_rx_peer_id);
         return;
     }
 
@@ -1282,21 +1282,21 @@
     =
{
         case OVPN_CMD_DEL_PEER:
             /* peer is gone, unset ID t=
o prevent more kernel calls */
-            c->c2=2Etls_multi->dco_peer_id =
=3D -1;
+            c->c2=2Etls_multi->dco_rx_peer_id =3D -1;
            =
 if (dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIRED)
        =
     {
                 msg(D_DCO_DEBUG,
-                    "%s: received=
 peer expired notification of for peer-id "
+                    "%s: recei=
ved peer expired notification of for rx-peer-id "
                     "%d"=
,
-                    __func__, dco->dco_message_peer_id);
+              =
      __func__, dco->dco_message_rx_peer_id);
                 trigger_ping=
_timeout_signal(c);
                 return;
             }
             br=
eak;
 
         case OVPN_CMD_SWAP_KEYS:
-            msg(D_DCO_DEBUG, "%s:=
 received key rotation notification for peer-id %d", __func__,
-           =
     dco->dco_message_peer_id);
+            msg(D_DCO_DEBUG, "%s: received=
 key rotation notification for rx-peer-id %d", __func__,
+                d=
co->dco_message_rx_peer_id);
             tls_session_soft_reset(c->c2=2Etl=
s_multi);
             break;
 
diff --git a/src/openvpn/multi=2Ec b/src/op=
envpn/multi=2Ec
index 900b5a3=2E=2Ecfcc870 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3373,7 +3373,7 @@
 
     /* When kerne=
l already deleted the peer, the socket is no longer
      * installed, and =
we do not need to clean up the state in the kernel */
-    mi->context=2Ec2=
=2Etls_multi->dco_peer_id =3D -1;
+    mi->context=2Ec2=2Etls_multi->dco_rx=
_peer_id =3D -1;
     mi->context=2Esig->signal_text =3D reason;
     multi=
_signal_instance(m, mi, SIGTERM);
 }
@@ -3385,19 +3385,19 @@
 
     struct =
multi_context *m =3D dco->c->multi;
 
-    int peer_id =3D dco->dco_message=
_peer_id;
+    int rx_peer_id =3D dco->dco_message_rx_peer_id;
 
     /* no=
 peer-specific message delivered -> nothing to process=2E
      * bail out =
right away
      */
-    if (peer_id < 0)
+    if (rx_peer_id < 0)
     {
 =
        return;
     }
 
-    if (((uint32_t)peer_id < m->max_clients) && m=
->instances[peer_id])
+    if (((uint32_t)rx_peer_id < m->max_clients) && m=
->instances[rx_peer_id])
     {
-        struct multi_instance *mi =3D m->i=
nstances[peer_id];
+        struct multi_instance *mi =3D m->instances[rx_p=
eer_id];
         set_prefix(mi);
         if (dco->dco_message_type =3D=3D=
 OVPN_CMD_DEL_PEER)
         {
@@ -3434,9 +3434,9 @@
             msglevel =
=3D D_DCO_DEBUG;
         }
         msg(msglevel,
-            "Received D=
CO message for unknown peer-id: %d, "
+            "Received DCO message fo=
r unknown rx-peer-id: %d, "
             "type %d, del_peer_reason %d",
-  =
          peer_id, dco->dco_message_type, dco->dco_del_peer_reason);
+     =
       rx_peer_id, dco->dco_message_type, dco->dco_del_peer_reason);
     }=

 }
 #endif /* if defined(ENABLE_DCO) */
diff --git a/src/openvpn/ssl=2Ec b=
/src/openvpn/ssl=2Ec
index ca5958f=2E=2E5476c61 100644
--- a/src/openvpn/ss=
l=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1198,7 +1198,7 @@
 
     /* get command=
 line derived options */
     ret->opt =3D *tls_options;
-    ret->dco_peer=
_id =3D -1;
+    ret->dco_rx_peer_id =3D -1;
     ret->use_asymmetric_peer_=
id =3D false;
     /* The rx_peer_id is also used to identify DCO clients *=
/
     ret->rx_peer_id =3D MAX_PEER_ID;
@@ -1711,12 +1711,12 @@
          *=
 ping-exit or mssfix are set to update in-kernel config */
         if (opt=
ions->ping_send_timeout || options->ping_rec_timeout || frame->mss_fix)
   =
      {
-            int ret =3D dco_set_peer(dco, multi->dco_peer_id, opti=
ons->ping_send_timeout,
+            int ret =3D dco_set_peer(dco, multi->d=
co_rx_peer_id, options->ping_send_timeout,
                                =
    options->ping_rec_timeout, frame->mss_fix);
             if (ret < 0)
 =
            {
-                msg(D_DCO, "Cannot set DCO peer parameters f=
or peer (id=3D%d): %s",
-                    multi->dco_peer_id, strerror(-=
ret));
+                msg(D_DCO, "Cannot set DCO peer parameters for peer=
 (rx-id=3D%d): %s",
+                    multi->dco_rx_peer_id, strerror(-r=
et));
                 return false;
             }
         }
diff --git a=
/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index fe333a3=2E=
=2E7fda552 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_co=
mmon=2Eh
@@ -726,10 +726,10 @@
      * This is the handle that DCO uses to =
identify this session with the
      * kernel=2E
      *
-     * We keep th=
is separate as the normal peer_id can change during
+     * We keep this se=
parate as the normal rx_peer_id can change during
      * p2p NCP and we ne=
ed to track the id that is really used=2E
      */
-    int dco_peer_id;
+ =
   int dco_rx_peer_id;
 
     dco_context_t *dco;
 

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1982?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I25fad88fb4bb8e841a50981e3197d5b8d8f90=
69b
Gerrit-Change-Number: 1982
Gerrit-PatchSet: 5
Gerrit-Owner: Gianmarco D=
e Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--dL4u+fnYfLk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori <strong>=
uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1982?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">dco: clarify RX peer ID naming and types<br><br>The peer ID used =
to address a peer in DCO is its local RX ID=2E Make that<br>explicit in the=
 installed-peer handle, notification fields, and DCO API<br>parameters acro=
ss all backends=2E<br><br>Use an unsigned local RX ID when creating a peer =
and make conversions<br>explicit at the signed DCO handle and Linux notific=
ation/statistics<br>boundaries=2E Keep DCO handles signed for their -1 sent=
inel=2E<br><br>This prepares asymmetric peer ID support without changing be=
havior for<br>valid peer IDs=2E<br><br>Change-Id: I25fad88fb4bb8e841a50981e=
3197d5b8d8f9069b<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<b=
r>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dc=
o_freebsd=2Ec<br>M src/openvpn/dco_freebsd=2Eh<br>M src/openvpn/dco_interna=
l=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_linux=2Eh<br>M sr=
c/openvpn/dco_win=2Ec<br>M src/openvpn/dco_win=2Eh<br>M src/openvpn/forward=
=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/s=
sl_common=2Eh<br>13 files changed, 181 insertions(+), 181 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/82/1982/5</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openv=
pn/dco=2Ec</span><br><span>index 3c85c11=2E=2E0d1ae67 100644</span><br><spa=
n>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span=
><br><span>@@ -62,8 +62,8 @@</span><br><span> </span><br><span> {</span><br=
><span>     bool epoch =3D ks-&gt;crypto_options=2Eflags &amp; CO_EPOCH_DAT=
A_KEY_FORMAT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_DCO_DEBUG, &quot;%s: peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d key=
s installed&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     __func__, multi-&gt;dco_peer_id, ks-&gt;key_id, epoch, multi-&gt;dco_k=
eys_installed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_DCO_DEBUG, &quot;%s: rx_peer_id=3D%d keyid=3D%d epoch=3D%d, currently=
 %d keys installed&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        __func__, multi-&gt;dco_rx_peer_id, ks-&gt;key_id, epoch, mul=
ti-&gt;dco_keys_installed);</span><br><span> </span><br><span>     /* Insta=
ll a key in the PRIMARY slot only when no other key exist=2E</span><br><spa=
n>      * From that moment on, any new key will be installed in the SECONDA=
RY</span><br><span>@@ -76,7 +76,7 @@</span><br><span>         slot =3D OVPN=
_KEY_SLOT_SECONDARY;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_key(multi-&=
gt;dco, multi-&gt;dco_peer_id, ks-&gt;key_id, slot, encrypt_key, encrypt_iv=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dc=
o_new_key(multi-&gt;dco, multi-&gt;dco_rx_peer_id, ks-&gt;key_id, slot, enc=
rypt_key, encrypt_iv,</span><br><span>                           decrypt_ke=
y, decrypt_iv, ciphername, epoch);</span><br><span>     if (ret =3D=3D 0)</=
span><br><span>     {</span><br><span>@@ -153,14 +153,14 @@</span><br><span=
>     {</span><br><span>         msg(D_DCO, &quot;No encryption key found=
=2E Purging data channel keys&quot;);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        int ret =3D dco_del_key(dco, mult=
i-&gt;dco_peer_id, OVPN_KEY_SLOT_PRIMARY);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        int ret =3D dco_del_key(dco, multi-&gt;dco_r=
x_peer_id, OVPN_KEY_SLOT_PRIMARY);</span><br><span>         if (ret &lt; 0)=
</span><br><span>         {</span><br><span>             msg(D_DCO, &quot;C=
annot delete primary key during wipe: %s (%d)&quot;, strerror(-ret), ret);<=
/span><br><span>             return false;</span><br><span>         }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
et =3D dco_del_key(dco, multi-&gt;dco_peer_id, OVPN_KEY_SLOT_SECONDARY);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D dco_de=
l_key(dco, multi-&gt;dco_rx_peer_id, OVPN_KEY_SLOT_SECONDARY);</span><br><s=
pan>         if (ret &lt; 0)</span><br><span>         {</span><br><span>   =
          msg(D_DCO, &quot;Cannot delete secondary key during wipe: %s (%d)=
&quot;, strerror(-ret), ret);</span><br><span>@@ -177,8 +177,8 @@</span><br=
><span>     if (primary-&gt;dco_status =3D=3D DCO_NOT_INSTALLED)</span><br>=
<span>     {</span><br><span>         msg(D_DCO, &quot;DCO key state mismat=
ch: selected primary key is not installed &quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                   &quot;(peer_id=3D%d, key_id=
=3D%d, dco_keys_installed=3D%d)&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            multi-&gt;dco_peer_id, primary-&gt;key_id, mul=
ti-&gt;dco_keys_installed);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                   &quot;(rx_peer_id=3D%d, key_id=3D%d, dco_keys_in=
stalled=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            multi-&gt;dco_rx_peer_id, primary-&gt;key_id, multi-&gt;dco_ke=
ys_installed);</span><br><span>         return false;</span><br><span>     =
}</span><br><span> </span><br><span>@@ -207,12 +207,12 @@</span><br><span> =
        if (secondary &amp;&amp; secondary-&gt;dco_status !=3D DCO_INSTALLE=
D_PRIMARY)</span><br><span>         {</span><br><span>             msg(D_DC=
O, &quot;DCO key state mismatch: expected old primary key is not installed =
as DCO primary before swap &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                       &quot;(peer_id=3D%d, new_primary_key_id=
=3D%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dco_keys_insta=
lled=3D%d)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            multi-&gt;dco_peer_id, primary-&gt;key_id, secondary-&gt;key_id=
, secondary-&gt;dco_status, multi-&gt;dco_keys_installed);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                       &quot;(rx_pee=
r_id=3D%d, new_primary_key_id=3D%d, old_primary_key_id=3D%d, old_primary_dc=
o_status=3D%d, dco_keys_installed=3D%d)&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                multi-&gt;dco_rx_peer_id, primar=
y-&gt;key_id, secondary-&gt;key_id, secondary-&gt;dco_status, multi-&gt;dco=
_keys_installed);</span><br><span>             return false;</span><br><spa=
n>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        int ret =3D dco_swap_keys(dco, multi-&gt;dco_peer_id);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ret =3D dco=
_swap_keys(dco, multi-&gt;dco_rx_peer_id);</span><br><span>         if (ret=
 &lt; 0)</span><br><span>         {</span><br><span>             msg(D_DCO,=
 &quot;Cannot swap keys: %s (%d)&quot;, strerror(-ret), ret);</span><br><sp=
an>@@ -229,7 +229,7 @@</span><br><span>     /* if we have no secondary key =
anymore, inform DCO about it */</span><br><span>     if (!secondary &amp;&a=
mp; multi-&gt;dco_keys_installed =3D=3D 2)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int ret =3D dco_del_key=
(dco, multi-&gt;dco_peer_id, OVPN_KEY_SLOT_SECONDARY);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        int ret =3D dco_del_key(dco, mul=
ti-&gt;dco_rx_peer_id, OVPN_KEY_SLOT_SECONDARY);</span><br><span>         i=
f (ret &lt; 0)</span><br><span>         {</span><br><span>             msg(=
D_DCO, &quot;Cannot delete secondary key: %s (%d)&quot;, strerror(-ret), re=
t);</span><br><span>@@ -543,10 +543,10 @@</span><br><span> #ifdef TARGET_FR=
EEBSD</span><br><span>     /* In Linux in P2P mode the kernel automatically=
 removes an existing peer</span><br><span>      * when adding a new peer=2E=
 FreeBSD needs to explicitly be told to do that */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2=2Etls_multi-&gt;dco_peer_id !=
=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&g=
t;c2=2Etls_multi-&gt;dco_rx_peer_id !=3D -1)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_del_peer(&amp;c-&=
gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_multi-&gt;dco_peer_id);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_multi-&gt;d=
co_peer_id =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       dco_del_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_multi-&g=
t;dco_rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id =3D -1;</span><br><span>    =
 }</span><br><span> #endif</span><br><span>     int ret =3D dco_new_peer(&a=
mp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</spa=
n><br><span>@@ -557,7 +557,7 @@</span><br><span>         return ret;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;rx_peer=
_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2E=
tls_multi-&gt;dco_rx_peer_id =3D (int)multi-&gt;rx_peer_id;</span><br><span=
> </span><br><span>     return 0;</span><br><span> }</span><br><span>@@ -57=
0,10 +570,10 @@</span><br><span>         return;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(c-&gt;c1=2Etuntap &amp;&amp; c-&gt;c2=2Etls_multi &amp;&amp; c-&gt;c2=2Etl=
s_multi-&gt;dco_peer_id !=3D -1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (c-&gt;c1=2Etuntap &amp;&amp; c-&gt;c2=2Etls_multi &amp=
;&amp; c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id !=3D -1)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_del_pe=
er(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_multi-&gt;dco_peer_id);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_=
multi-&gt;dco_peer_id =3D -1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        dco_del_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Et=
ls_multi-&gt;dco_rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id =3D -1;</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -632,=
7 +632,7 @@</span><br><span> {</span><br><span>     const struct context *c=
 =3D &amp;mi-&gt;context;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_=
id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t rx_=
peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span>     struc=
t sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>     struct so=
ckaddr_storage local =3D { 0 };</span><br><span>     const socket_descripto=
r_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><span>@@ -670,13 +6=
70,13 @@</span><br><span>     }</span><br><span> </span><br><span>     int =
ret =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_ne=
w_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, peer_id, sd, localaddr, remoteaddr, =
vpn_addr4, vpn_addr6);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, rx_peer_id, sd, loc=
aladdr, remoteaddr, vpn_addr4, vpn_addr6);</span><br><span>     if (ret &lt=
; 0)</span><br><span>     {</span><br><span>         return ret;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D peer_id;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco=
_rx_peer_id =3D (int)rx_peer_id;</span><br><span> </span><br><span>     ret=
urn 0;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco=2Eh =
b/src/openvpn/dco=2Eh</span><br><span>index b0a8621=2E=2Ebae239d 100644</sp=
an><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dc=
o=2Eh</span><br><span>@@ -180,14 +180,14 @@</span><br><span>  * and -1 (do =
not touch)=2E</span><br><span>  *</span><br><span>  * @param dco           =
     DCO device context</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param peer_id            the ID of the peer to be modified</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param rx_peer_id         t=
he RX ID of the peer to be modified</span><br><span>  * @param keepalive_in=
terval keepalive interval in seconds</span><br><span>  * @param keepalive_t=
imeout  keepalive timeout in seconds</span><br><span>  * @param mss        =
        TCP MSS value</span><br><span>  *</span><br><span>  * @return      =
             0 on success or a negative error code otherwise</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_set_pee=
r(dco_context_t *dco, unsigned int peerid, int keepalive_interval,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+int dco_set_peer(dco_context=
_t *dco, unsigned int rx_peer_id, int keepalive_interval,</span><br><span> =
                 int keepalive_timeout, int mss);</span><br><span> </span><=
br><span> /**</span><br><span>@@ -349,7 +349,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> static inline int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dco_set_peer(dco_context_t *dco, unsigned int peer=
id, int keepalive_interval, int keepalive_timeout,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_set_peer(dco_context_t *dco, unsigned in=
t rx_peer_id, int keepalive_interval, int keepalive_timeout,</span><br><spa=
n>              int mss)</span><br><span> {</span><br><span>     return 0;<=
/span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_=
freebsd=2Ec</span><br><span>index 9613c63=2E=2E8615cf0 100644</span><br><sp=
an>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_=
freebsd=2Ec</span><br><span>@@ -133,7 +133,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, stru=
ct sockaddr *localaddr,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, int sd, struc=
t sockaddr *localaddr,</span><br><span>              struct sockaddr *remot=
eaddr, const struct in_addr *vpn_ipv4,</span><br><span>              const =
struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>@@ -143,7 +14=
3,7 @@</span><br><span> </span><br><span>     nvl =3D nvlist_create(0);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG, &quot;%s: peer-id %u, fd %d&quot;, __func__, peerid, sd);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &q=
uot;%s: rx-peer-id %u, fd %d&quot;, __func__, rx_peer_id, sd);</span><br><s=
pan> </span><br><span>     if (localaddr)</span><br><span>     {</span><br>=
<span>@@ -168,7 +168,7 @@</span><br><span>     }</span><br><span> </span><b=
r><span>     nvlist_add_number(nvl, &quot;fd&quot;, sd);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    nvlist_add_number(nvl, &quot;peerid&=
quot;, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
nvlist_add_number(nvl, &quot;peerid&quot;, rx_peer_id);</span><br><span> </=
span><br><span>     CLEAR(drv);</span><br><span>     snprintf(drv=2Eifd_nam=
e, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);</span><br><span>@@ -353,16 +3=
53,16 @@</span><br><span> }</span><br><span> </span><br><span> int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-dco_swap_keys(dco_context_t *d=
co, unsigned int peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_swap_keys(dco_context_t *dco, unsigned int rx_peer_id)</span><br><=
span> {</span><br><span>     struct ifdrv drv;</span><br><span>     nvlist_=
t *nvl;</span><br><span>     int ret;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u=
&quot;, __func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u&quot;, __func__, rx_pee=
r_id);</span><br><span> </span><br><span>     nvl =3D nvlist_create(0);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    nvlist_add_number(nvl=
, &quot;peerid&quot;, peerid);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    nvlist_add_number(nvl, &quot;peerid&quot;, rx_peer_id);</spa=
n><br><span> </span><br><span>     CLEAR(drv);</span><br><span>     snprint=
f(drv=2Eifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);</span><br><spa=
n>@@ -382,16 +382,16 @@</span><br><span> }</span><br><span> </span><br><spa=
n> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_del_peer(dc=
o_context_t *dco, unsigned int peerid)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dco_del_peer(dco_context_t *dco, unsigned int rx_peer_id=
)</span><br><span> {</span><br><span>     struct ifdrv drv;</span><br><span=
>     nvlist_t *nvl;</span><br><span>     int ret;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%=
s: peer-id %u&quot;, __func__, peerid);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u&quot;, __f=
unc__, rx_peer_id);</span><br><span> </span><br><span>     nvl =3D nvlist_c=
reate(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nvlist_a=
dd_number(nvl, &quot;peerid&quot;, peerid);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    nvlist_add_number(nvl, &quot;peerid&quot;, rx_p=
eer_id);</span><br><span> </span><br><span>     CLEAR(drv);</span><br><span=
>     snprintf(drv=2Eifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);</=
span><br><span>@@ -411,17 +411,17 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dc=
o_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_del_key(dco_context=
_t *dco, unsigned int rx_peer_id, dco_key_slot_t slot)</span><br><span> {</=
span><br><span>     struct ifdrv drv;</span><br><span>     nvlist_t *nvl;</=
span><br><span>     int ret;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, slot %d=
&quot;, __func__, peerid, slot);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, slot %d&quot;, _=
_func__, rx_peer_id, slot);</span><br><span> </span><br><span>     nvl =3D =
nvlist_create(0);</span><br><span>     nvlist_add_number(nvl, &quot;slot&qu=
ot;, slot);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nvlist=
_add_number(nvl, &quot;peerid&quot;, peerid);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    nvlist_add_number(nvl, &quot;peerid&quot;, rx=
_peer_id);</span><br><span> </span><br><span>     CLEAR(drv);</span><br><sp=
an>     snprintf(drv=2Eifd_name, IFNAMSIZ, &quot;%s&quot;, dco-&gt;ifname);=
</span><br><span>@@ -480,7 +480,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dc=
o_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_=
t slot,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_new_key(=
dco_context_t *dco, unsigned int rx_peer_id, int keyid, dco_key_slot_t slot=
,</span><br><span>             const uint8_t *encrypt_key, const uint8_t *e=
ncrypt_iv, const uint8_t *decrypt_key,</span><br><span>             const u=
int8_t *decrypt_iv, const char *ciphername, bool epoch)</span><br><span> {<=
/span><br><span>@@ -488,14 +488,14 @@</span><br><span>     nvlist_t *nvl, *=
encrypt_nvl, *decrypt_nvl;</span><br><span>     int ret;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &=
quot;%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d&quot;, __func_=
_, slot, keyid, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, rx-peer-id %u, ciphe=
r %s, epoch %d&quot;, __func__, slot, keyid, rx_peer_id,</span><br><span>  =
       ciphername, epoch);</span><br><span> </span><br><span>     nvl =3D n=
vlist_create(0);</span><br><span> </span><br><span>     nvlist_add_number(n=
vl, &quot;slot&quot;, slot);</span><br><span>     nvlist_add_number(nvl, &q=
uot;keyid&quot;, keyid);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    nvlist_add_number(nvl, &quot;peerid&quot;, peerid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    nvlist_add_number(nvl, &quot;pee=
rid&quot;, rx_peer_id);</span><br><span> </span><br><span>     encrypt_nvl =
=3D key_to_nvlist(encrypt_key, encrypt_iv, ciphername);</span><br><span>   =
  decrypt_nvl =3D key_to_nvlist(decrypt_key, decrypt_iv, ciphername);</span=
><br><span>@@ -527,18 +527,18 @@</span><br><span> }</span><br><span> </span=
><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_se=
t_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interval, int=
 keepalive_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_set_peer(dco_context_t *dco, unsigned int rx_peer_id, int keepalive_int=
erval, int keepalive_timeout,</span><br><span>              int mss)</span>=
<br><span> {</span><br><span>     struct ifdrv drv;</span><br><span>     nv=
list_t *nvl;</span><br><span>     int ret;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-=
id %u, ping interval %d, ping timeout %d&quot;, __func__, peerid,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s=
: rx-peer-id %u, ping interval %d, ping timeout %d&quot;, __func__, rx_peer=
_id,</span><br><span>         keepalive_interval, keepalive_timeout);</span=
><br><span> </span><br><span>     nvl =3D nvlist_create(0);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    nvlist_add_number(nvl, &quot;peer=
id&quot;, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   nvlist_add_number(nvl, &quot;peerid&quot;, rx_peer_id);</span><br><span>=
     nvlist_add_number(nvl, &quot;interval&quot;, keepalive_interval);</spa=
n><br><span>     nvlist_add_number(nvl, &quot;timeout&quot;, keepalive_time=
out);</span><br><span> </span><br><span>@@ -560,21 +560,21 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_update_peer_stat(struct multi_context *=
m, uint32_t peerid, const nvlist_t *nvl)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+dco_update_peer_stat(struct multi_context *m, uint32_t=
 rx_peer_id, const nvlist_t *nvl)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (peerid &gt;=3D m-&gt;max_clients ||=
 !m-&gt;instances[peerid])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (rx_peer_id &gt;=3D m-&gt;max_clients || !m-&gt;instances[rx_=
peer_id])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_WARN, &quot;dco_update_peer_stat: invalid peer ID =
%u returned by kernel&quot;, peerid);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        msg(M_WARN, &quot;dco_update_peer_stat: invalid p=
eer RX ID %u returned by kernel&quot;, rx_peer_id);</span><br><span>       =
  return;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m-&gt;instan=
ces[peerid];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct multi_instance *mi =3D m-&gt;instances[rx_peer_id];</span><br><span> </=
span><br><span>     mi-&gt;context=2Ec2=2Edco_read_bytes =3D nvlist_get_num=
ber(nvl, &quot;in&quot;);</span><br><span>     mi-&gt;context=2Ec2=2Edco_wr=
ite_bytes =3D nvlist_get_number(nvl, &quot;out&quot;);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &qu=
ot;%s: peer-id %u, dco_read_bytes: &quot; counter_format &quot; dco_write_b=
ytes: &quot; counter_format,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        __func__, peerid, mi-&gt;context=2Ec2=2Edco_read_bytes, mi-&=
gt;context=2Ec2=2Edco_write_bytes);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, dco_read_byte=
s: &quot; counter_format &quot; dco_write_bytes: &quot; counter_format,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, rx_pe=
er_id, mi-&gt;context=2Ec2=2Edco_read_bytes, mi-&gt;context=2Ec2=2Edco_writ=
e_bytes);</span><br><span> }</span><br><span> </span><br><span> #if defined=
(__GNUC__) || defined(__clang__)</span><br><span>@@ -614,10 +614,10 @@</spa=
n><br><span>         return -EINVAL;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* dco_message_=
peer_id is signed int, because other parts of the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* dco_message_rx_peer_id is signed int, =
because other parts of the</span><br><span>      * code treat &quot;-1&quot=
; as &quot;this is a message not specific to one peer&quot;</span><br><span=
>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;=
dco_message_peer_id =3D (int)nvlist_get_number(nvl, &quot;peerid&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_messag=
e_rx_peer_id =3D (int)nvlist_get_number(nvl, &quot;peerid&quot;);</span><br=
><span> </span><br><span>     type =3D (enum ovpn_notif_type)nvlist_get_num=
ber(nvl, &quot;notification&quot;);</span><br><span> </span><br><span>@@ -6=
38,8 +638,8 @@</span><br><span>                     dco-&gt;dco_del_peer_re=
ason =3D OVPN_DEL_PEER_REASON_USERSPACE;</span><br><span>                 }=
</span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(D_DCO_DEBUG, &quot;%s: received NOTIF_DEL_PEER fo=
r peer-id=3D%d, reason=3D%d&quot;, __func__,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                dco-&gt;dco_message_peer_id, dco-&gt=
;dco_del_peer_reason);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_DCO_DEBUG, &quot;%s: received NOTIF_DEL_PEER for rx-pe=
er-id=3D%d, reason=3D%d&quot;, __func__,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                dco-&gt;dco_message_rx_peer_id, dco-&g=
t;dco_del_peer_reason);</span><br><span> </span><br><span>             if (=
nvlist_exists_nvlist(nvl, &quot;bytes&quot;))</span><br><span>             =
{</span><br><span>@@ -647,7 +647,7 @@</span><br><span> </span><br><span>   =
              if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span>       =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          dco_update_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_pee=
r_id, bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              dco_update_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message=
_rx_peer_id, bytes);</span><br><span>                 }</span><br><span>   =
              else</span><br><span>                 {</span><br><span>@@ -6=
60,8 +660,8 @@</span><br><span>             break;</span><br><span> </span>=
<br><span>         case OVPN_NOTIF_ROTATE_KEY:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;%s: received NO=
TIF_ROTATE_KEY for peer-id=3D%d&quot;, __func__,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                dco-&gt;dco_message_peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_=
DEBUG, &quot;%s: received NOTIF_ROTATE_KEY for rx-peer-id=3D%d&quot;, __fun=
c__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 dco-&gt;dco_message_rx_peer_id);</span><br><span>             dco-&gt;dco_=
message_type =3D OVPN_CMD_SWAP_KEYS;</span><br><span>             break;</s=
pan><br><span> </span><br><span>@@ -681,8 +681,8 @@</span><br><span>       =
          msg(M_WARN, &quot;Failed to parse float notification&quot;);</spa=
n><br><span>                 break;</span><br><span>             }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &=
quot;%s: received NOTIF_FLOAT for peer-id=3D%d&quot;, __func__,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                dco-&gt;dco_messa=
ge_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_DCO_DEBUG, &quot;%s: received NOTIF_FLOAT for rx-peer-id=3D%d&qu=
ot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           dco-&gt;dco_message_rx_peer_id);</span><br><span>             dc=
o-&gt;dco_message_type =3D OVPN_CMD_FLOAT_PEER;</span><br><span>           =
  break;</span><br><span>         }</span><br><span>@@ -894,7 +894,7 @@</sp=
an><br><span>     for (size_t i =3D 0; i &lt; npeers; i++)</span><br><span>=
     {</span><br><span>         const nvlist_t *peer =3D nvpeers[i];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uint32_t peerid =3D =
(uint32_t)nvlist_get_number(peer, &quot;peerid&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uint32_t rx_peer_id =3D (uint32_=
t)nvlist_get_number(peer, &quot;peerid&quot;);</span><br><span>         con=
st nvlist_t *bytes =3D nvlist_get_nvlist(peer, &quot;bytes&quot;);</span><b=
r><span> </span><br><span>         /* we can end here in p2mp mode, or in p=
2p mode via</span><br><span>@@ -902,7 +902,7 @@</span><br><span>          *=
/</span><br><span>         if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       dco_update_peer_stat(dco-&gt;c-&gt;multi, peerid, bytes);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            dco_update_peer_st=
at(dco-&gt;c-&gt;multi, rx_peer_id, bytes);</span><br><span>         }</spa=
n><br><span>         else</span><br><span>         {</span><br><span>@@ -92=
3,9 +923,9 @@</span><br><span> dco_get_peer_stats(struct context *c, const =
bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>     ASSERT(c=
-&gt;c2=2Etls_multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, c-&gt;c2=2Etls_m=
ulti-&gt;dco_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %d&quot;, __func__, c-&gt;c2=
=2Etls_multi-&gt;dco_rx_peer_id);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2=2Etls_multi-&gt;dco_peer_i=
d &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-=
&gt;c2=2Etls_multi-&gt;dco_rx_peer_id &lt; 0)</span><br><span>     {</span>=
<br><span>         return -EINVAL; /* DCO not active yet */</span><br><span=
>     }</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Eh b/src/open=
vpn/dco_freebsd=2Eh</span><br><span>index 5e2a552=2E=2E7b278fd 100644</span=
><br><span>--- a/src/openvpn/dco_freebsd=2Eh</span><br><span>+++ b/src/open=
vpn/dco_freebsd=2Eh</span><br><span>@@ -58,7 +58,7 @@</span><br><span>     =
char ifname[IFNAMSIZ];</span><br><span> </span><br><span>     int dco_messa=
ge_type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int dco_m=
essage_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int dco_message_rx_peer_id;</span><br><span>     int dco_del_peer_reason;</=
span><br><span>     struct sockaddr_storage dco_float_peer_ss;</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/dco_internal=2Eh b/src/openv=
pn/dco_internal=2Eh</span><br><span>index 1022e66=2E=2Ea9203163 100644</spa=
n><br><span>--- a/src/openvpn/dco_internal=2Eh</span><br><span>+++ b/src/op=
envpn/dco_internal=2Eh</span><br><span>@@ -59,19 +59,19 @@</span><br><span>=
  * They are implemented by dco_linux=2Ec</span><br><span>  */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer=
(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context_=
t *dco, unsigned int rx_peer_id, socket_descriptor_t sd,</span><br><span>  =
                struct sockaddr *localaddr, struct sockaddr *remoteaddr,</s=
pan><br><span>                  const struct in_addr *vpn_ipv4, const struc=
t in6_addr *vpn_ipv6);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int dco_del_peer(dco_context_t *dco, unsigned int peerid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_del_peer(=
dco_context_t *dco, unsigned int rx_peer_id);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-int dco_new_key(dco_context_t *dc=
o, unsigned int peerid, int keyid, dco_key_slot_t slot,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+int dco_new_key(dco_context_t *dco, uns=
igned int rx_peer_id, int keyid, dco_key_slot_t slot,</span><br><span>     =
            const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const ui=
nt8_t *decrypt_key,</span><br><span>                 const uint8_t *decrypt=
_iv, const char *ciphername, bool epoch);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int dco_del_key(dco_context_t *dco, u=
nsigned int peerid, dco_key_slot_t slot);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int dco_del_key(dco_context_t *dco, unsigned int rx_p=
eer_id, dco_key_slot_t slot);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-int dco_swap_keys(dco_context_t *dco, unsigned in=
t peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_s=
wap_keys(dco_context_t *dco, unsigned int rx_peer_id);</span><br><span> </s=
pan><br><span> #endif /* defined(ENABLE_DCO) */</span><br><span> #endif /* =
ifndef DCO_INTERNAL_H */</span><br><span>diff --git a/src/openvpn/dco_linux=
=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index fefc517=2E=2E9110649=
 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++=
 b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -581,7 +581,7 @@</span><br>=
<span> #endif</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco, unsigned i=
nt peerid, int sd, struct sockaddr *localaddr,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_new_peer(dco_context_t *dco, unsigned int rx=
_peer_id, int sd, struct sockaddr *localaddr,</span><br><span>             =
 struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,</span><br><sp=
an>              const struct in6_addr *vpn_ipv6)</span><br><span> {</span>=
<br><span>@@ -591,7 +591,7 @@</span><br><span>     {</span><br><span>      =
   remotestr =3D print_sockaddr(remoteaddr, &amp;gc);</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG,=
 &quot;%s: peer-id %u, fd %d, remote addr: %s&quot;, __func__, peerid, sd, =
remotestr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_DCO_DEBUG, &quot;%s: rx-peer-id %u, fd %d, remote addr: %s&quot;, __func_=
_, rx_peer_id, sd, remotestr);</span><br><span> </span><br><span>     struc=
t nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);</span><=
br><span>     if (!nl_msg)</span><br><span>@@ -603,7 +603,7 @@</span><br><s=
pan>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span=
><br><span>     int ret =3D -EMSGSIZE;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, =
peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT=
_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);</span><br><span>     NLA_PUT_U32(=
nl_msg, OVPN_A_PEER_SOCKET, sd);</span><br><span> </span><br><span>     /* =
Set the remote endpoint if defined (for UDP) */</span><br><span>@@ -818,7 +=
818,7 @@</span><br><span> </span><br><span>     nl_socket_set_cb(dco-&gt;nl=
_sock, dco-&gt;nl_cb);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D -1;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_rx_peer_id =
=3D -1;</span><br><span>     nl_cb_err(dco-&gt;nl_cb, NL_CB_CUSTOM, ovpn_nl=
_cb_error, &amp;dco-&gt;status);</span><br><span>     nl_cb_set(dco-&gt;nl_=
cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish, &amp;dco-&gt;status);</s=
pan><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_n=
l_cb_finish, &amp;dco-&gt;status);</span><br><span>@@ -944,9 +944,9 @@</spa=
n><br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_swap_keys(dco_context_t *dco, unsigned =
int peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_swap=
_keys(dco_context_t *dco, unsigned int rx_peer_id)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;=
%s: peer-id %u&quot;, __func__, peerid);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u&quot;, __=
func__, rx_peer_id);</span><br><span> </span><br><span>     struct nl_msg *=
nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP);</span><br><span> =
    if (!nl_msg)</span><br><span>@@ -956,7 +956,7 @@</span><br><span> </spa=
n><br><span>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_KEYC=
ONF);</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID,=
 peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PU=
T_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_peer_id);</span><br><span>     nla=
_nest_end(nl_msg, attr);</span><br><span> </span><br><span>     ret =3D ovp=
n_nl_msg_send(dco, nl_msg, __func__);</span><br><span>@@ -968,9 +968,9 @@</=
span><br><span> </span><br><span> </span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-dco_del_peer(dco_context_t *dco, unsigned=
 int peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_del=
_peer(dco_context_t *dco, unsigned int rx_peer_id)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M_NOI=
PREFIX, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot=
;%s: rx-peer-id %u&quot;, __func__, rx_peer_id);</span><br><span> </span><b=
r><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_=
PEER_DEL);</span><br><span>     if (!nl_msg)</span><br><span>@@ -980,7 +980=
,7 @@</span><br><span> </span><br><span>     struct nlattr *attr =3D nla_ne=
st_start(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg=
, OVPN_A_PEER_ID, peerid);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);</span><br><span=
>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><span>     re=
t =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span>@@ -992,10 +=
992,10 @@</span><br><span> </span><br><span> </span><br><span> int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-dco_del_key(dco_context_t *dco=
, unsigned int peerid, dco_key_slot_t slot)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dco_del_key(dco_context_t *dco, unsigned int rx_pee=
r_id, dco_key_slot_t slot)</span><br><span> {</span><br><span>     int ret =
=3D -EMSGSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG, &quot;%s: peer-id %u, slot %d&quot;, __func__, peerid, slot);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG=
, &quot;%s: rx-peer-id %u, slot %d&quot;, __func__, rx_peer_id, slot);</spa=
n><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg=
_create(dco, OVPN_CMD_KEY_DEL);</span><br><span>     if (!nl_msg)</span><br=
><span>@@ -1004,7 +1004,7 @@</span><br><span>     }</span><br><span> </span=
><br><span>     struct nlattr *keyconf =3D nla_nest_start(nl_msg, OVPN_A_KE=
YCONF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U3=
2(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, rx_p=
eer_id);</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot=
);</span><br><span>     nla_nest_end(nl_msg, keyconf);</span><br><span> </s=
pan><br><span>@@ -1016,11 +1016,11 @@</span><br><span> }</span><br><span> <=
/span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-d=
co_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot=
_t slot,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_new_key=
(dco_context_t *dco, unsigned int rx_peer_id, int keyid, dco_key_slot_t slo=
t,</span><br><span>             const uint8_t *encrypt_key, const uint8_t *=
encrypt_iv, const uint8_t *decrypt_key,</span><br><span>             const =
uint8_t *decrypt_iv, const char *ciphername, bool epoch)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, =
&quot;%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d&quot;, __func=
__, slot, keyid, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, rx-peer-id %u, ciph=
er %s, epoch %d&quot;, __func__, slot, keyid, rx_peer_id,</span><br><span> =
        ciphername, epoch);</span><br><span> </span><br><span>     const si=
ze_t key_len =3D cipher_kt_key_size(ciphername);</span><br><span>@@ -1038,7=
 +1038,7 @@</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span> </=
span><br><span>     struct nlattr *key_conf =3D nla_nest_start(nl_msg, OVPN=
_A_KEYCONF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_P=
UT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID,=
 rx_peer_id);</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT,=
 slot);</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_KEY_ID, key=
id);</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, dc=
o_cipher);</span><br><span>@@ -1070,10 +1070,10 @@</span><br><span> }</span=
><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepa=
live_interval, int keepalive_timeout,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_set_peer(dco_context_t *dco, unsigned int rx_peer_id,=
 int keepalive_interval, int keepalive_timeout,</span><br><span>           =
   int mss)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, keepalive %d/%d, mss %d=
&quot;, __func__, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, keepalive %d/%d, mss %d=
&quot;, __func__, rx_peer_id,</span><br><span>         keepalive_interval, =
keepalive_timeout, mss);</span><br><span> </span><br><span>     struct nl_m=
sg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);</span><br><sp=
an>@@ -1084,7 +1084,7 @@</span><br><span> </span><br><span>     struct nlat=
tr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>     int =
ret =3D -EMSGSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_i=
d);</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_INTERVAL=
, keepalive_interval);</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER=
_KEEPALIVE_TIMEOUT, keepalive_timeout);</span><br><span>     nla_nest_end(n=
l_msg, attr);</span><br><span>@@ -1227,7 +1227,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dco_update_peer_stat(struct context_2 *c2, struct nlat=
tr *tb[], uint32_t id)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t=
 rx_id)</span><br><span> {</span><br><span>     if (tb[OVPN_A_PEER_LINK_RX_=
BYTES])</span><br><span>     {</span><br><span>@@ -1236,7 +1236,7 @@</span>=
<br><span>     }</span><br><span>     else</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: n=
o link RX bytes provided in reply for peer %u&quot;, __func__, id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%=
s: no link RX bytes provided in reply for peer with RX ID %u&quot;, __func_=
_, rx_id);</span><br><span>     }</span><br><span> </span><br><span>     if=
 (tb[OVPN_A_PEER_LINK_TX_BYTES])</span><br><span>@@ -1246,7 +1246,7 @@</spa=
n><br><span>     }</span><br><span>     else</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s:=
 no link TX bytes provided in reply for peer %u&quot;, __func__, id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot=
;%s: no link TX bytes provided in reply for peer with RX ID %u&quot;, __fun=
c__, rx_id);</span><br><span>     }</span><br><span> </span><br><span>     =
if (tb[OVPN_A_PEER_VPN_RX_BYTES])</span><br><span>@@ -1256,7 +1256,7 @@</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s=
: no VPN RX bytes provided in reply for peer %u&quot;, __func__, id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot=
;%s: no VPN RX bytes provided in reply for peer with RX ID %u&quot;, __func=
__, rx_id);</span><br><span>     }</span><br><span> </span><br><span>     i=
f (tb[OVPN_A_PEER_VPN_TX_BYTES])</span><br><span>@@ -1266,7 +1266,7 @@</spa=
n><br><span>     }</span><br><span>     else</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s:=
 no VPN TX bytes provided in reply for peer %u&quot;, __func__, id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;=
%s: no VPN TX bytes provided in reply for peer with RX ID %u&quot;, __func_=
_, rx_id);</span><br><span>     }</span><br><span> }</span><br><span> </spa=
n><br><span>@@ -1284,43 +1284,43 @@</span><br><span> </span><br><span>     =
if (!tb_peer[OVPN_A_PEER_ID])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ovpn-dco: no peer=
-id provided in PEER_GET reply&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(M_WARN, &quot;ovpn-dco: no rx-peer-id provid=
ed in PEER_GET reply&quot;);</span><br><span>         return NL_SKIP;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t rx_pe=
er_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span>     struct=
 context_2 *c2;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: parsing message fo=
r peer %u=2E=2E=2E&quot;, __func__, peer_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: pars=
ing message for peer with RX ID %u=2E=2E=2E&quot;, __func__, rx_peer_id);</=
span><br><span> </span><br><span>     if (dco-&gt;ifmode =3D=3D OVPN_MODE_P=
2P)</span><br><span>     {</span><br><span>         c2 =3D &amp;dco-&gt;c-&=
gt;c2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c2-=
&gt;tls_multi-&gt;dco_peer_id !=3D (int)peer_id)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if ((uint32_t)c2-&gt;tls_multi-&gt;dco=
_rx_peer_id !=3D rx_peer_id)</span><br><span>         {</span><br><span>   =
          return NL_SKIP;</span><br><span>         }</span><br><span>     }=
</span><br><span>     else</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (peer_id &gt;=3D dco-&gt;c-&gt;multi=
-&gt;max_clients)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (rx_peer_id &gt;=3D dco-&gt;c-&gt;multi-&gt;max_clients)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(M_WARN, &quot;%s: received out of bound peer_id %u (max=3D%u)&q=
uot;, __func__, peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(M_WARN, &quot;%s: received out of bound rx_peer_id %u =
(max=3D%u)&quot;, __func__, rx_peer_id,</span><br><span>                 dc=
o-&gt;c-&gt;multi-&gt;max_clients);</span><br><span>             return NL_=
SKIP;</span><br><span>         }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        struct multi_instance *mi =3D dco-&gt;=
c-&gt;multi-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&=
gt;instances[rx_peer_id];</span><br><span>         if (!mi)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_WARN | M_NOIPREFIX, &quot;%s: received data for a non-existing peer=
 %u&quot;, __func__, peer_id);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_WARN | M_NOIPREFIX, &quot;%s: received data fo=
r a non-existing peer with RX ID %u&quot;, __func__, rx_peer_id);</span><br=
><span>             return NL_SKIP;</span><br><span>         }</span><br><s=
pan> </span><br><span>         c2 =3D &amp;mi-&gt;context=2Ec2;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    dco_update_peer_stat(c2, tb_peer, peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    dco_update_peer_stat(c2, tb_peer, r=
x_peer_id);</span><br><span> </span><br><span>     return NL_OK;</span><br>=
<span> }</span><br><span>@@ -1375,16 +1375,16 @@</span><br><span>     }</sp=
an><br><span>     if (!dp_attrs[OVPN_A_PEER_ID])</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO | M_NOI=
PREFIX, &quot;ovpn-dco: no peer-id in PEER_DEL_NTF message&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO | M_NOIPRE=
FIX, &quot;ovpn-dco: no rx-peer-id in PEER_DEL_NTF message&quot;);</span><b=
r><span>         return NL_STOP;</span><br><span>     }</span><br><span> </=
span><br><span>     int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REA=
SON]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned in=
t peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int rx_peer_id =3D nla_get_u=
32(dp_attrs[OVPN_A_PEER_ID]);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco=
: received CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco-&gt;ifindex, =
peerid, reason);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    d=
co-&gt;dco_message_peer_id =3D peerid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: recei=
ved CMD_PEER_DEL_NTF, ifindex: %u, rx-peer-id %u, reason: %d&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;ifindex, rx=
_peer_id, reason);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dco-&gt;dco_message_rx_peer_id =3D rx_peer_id;</span><br><span>     dco-=
&gt;dco_del_peer_reason =3D reason;</span><br><span>     dco-&gt;dco_messag=
e_type =3D OVPN_CMD_PEER_DEL_NTF;</span><br><span> </span><br><span>@@ -141=
4,10 +1414,10 @@</span><br><span> </span><br><span>     if (!fp_attrs[OVPN_=
A_PEER_ID])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_FLOAT_NT=
F message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_DCO, &quot;ovpn-dco: no rx-peer-id in PEER_FLOAT_NTF message&qu=
ot;);</span><br><span>         return NL_STOP;</span><br><span>     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peerid =3D nla=
_get_u32(fp_attrs[OVPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint32_t rx_peer_id =3D nla_get_u32(fp_attrs[OVPN_A_PEE=
R_ID]);</span><br><span> </span><br><span>     if (!ovpn_parse_float_addr(f=
p_attrs, (struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss))</span><br><spa=
n>     {</span><br><span>@@ -1425,9 +1425,9 @@</span><br><span>     }</span=
><br><span> </span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;ovp=
n-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco-&gt;i=
findex, peerid, print_sockaddr((struct sockaddr *)&amp;dco-&gt;dco_float_pe=
er_ss, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
dco-&gt;dco_message_peer_id =3D (int)peerid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_=
PEER_FLOAT_NTF, ifindex: %u, rx-peer-id %u, address: %s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;ifindex, rx_peer=
_id, print_sockaddr((struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss, &amp=
;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;d=
co_message_rx_peer_id =3D (int)rx_peer_id;</span><br><span>     dco-&gt;dco=
_message_type =3D OVPN_CMD_PEER_FLOAT_NTF;</span><br><span> </span><br><spa=
n>     gc_free(&amp;gc);</span><br><span>@@ -1457,7 +1457,7 @@</span><br><s=
pan>     }</span><br><span>     if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(D_DCO, &quot;ovpn-dco: no peer-id in KEY_SWAP_NTF message&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &=
quot;ovpn-dco: no rx-peer-id in KEY_SWAP_NTF message&quot;);</span><br><spa=
n>         return NL_STOP;</span><br><span>     }</span><br><span>     if (=
!dp_attrs[OVPN_A_KEYCONF_KEY_ID])</span><br><span>@@ -1467,11 +1467,11 @@</=
span><br><span>     }</span><br><span> </span><br><span>     int key_id =3D=
 nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    unsigned int peer_id =3D nla_get_u32(dp_attrs[=
OVPN_A_KEYCONF_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    unsigned int rx_peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_P=
EER_ID]);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_NTF, ifind=
ex: %u, peer-id %u, key-id: %d&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        dco-&gt;ifindex, peer_id, key_id);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D pe=
er_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO=
_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %u, rx-peer-id =
%u, key-id: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        dco-&gt;ifindex, rx_peer_id, key_id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_rx_peer_id =3D (int)rx_=
peer_id;</span><br><span>     dco-&gt;dco_message_key_id =3D key_id;</span>=
<br><span>     dco-&gt;dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;</span><b=
r><span> </span><br><span>@@ -1585,20 +1585,20 @@</span><br><span> }</span>=
<br><span> </span><br><span> static int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-dco_get_peer(dco_context_t *dco, int peer_id, const bool =
raise_sigusr1_on_err)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_get_peer(dco_context_t *dco, int rx_peer_id, const bool raise_sigusr1=
_on_err)</span><br><span> {</span><br><span>     ASSERT(dco);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* peer_id =
=3D=3D -1 means &quot;dump all peers&quot;, but this is allowed in MP mode =
only=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* rx_pe=
er_id =3D=3D -1 means &quot;dump all peers&quot;, but this is allowed in MP=
 mode only=2E</span><br><span>      * If it happens in P2P mode it means th=
at the DCO peer was deleted and we</span><br><span>      * can simply bail =
out</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (peer_id =3D=3D -1 &amp;&amp; dco-&gt;ifmode =3D=3D OVPN_MODE=
_P2P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rx_pee=
r_id =3D=3D -1 &amp;&amp; dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><s=
pan>     {</span><br><span>         return 0;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_=
DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %d&quot;, __func__, peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG | =
M_NOIPREFIX, &quot;%s: rx-peer-id %d&quot;, __func__, rx_peer_id);</span><b=
r><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_cre=
ate(dco, OVPN_CMD_PEER_GET);</span><br><span>     if (!nl_msg)</span><br><s=
pan>@@ -1609,9 +1609,9 @@</span><br><span>     struct nlattr *attr =3D nla_=
nest_start(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (peer_id !=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (rx_peer_id !=3D -1)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID,=
 peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        N=
LA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);</span><br><span>     }</spa=
n><br><span>     else</span><br><span>     {</span><br><span>@@ -1646,7 +16=
46,7 @@</span><br><span>         return -1;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return d=
co_get_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=2Etls_multi-&gt;dco_pe=
er_id, raise_sigusr1_on_err);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return dco_get_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, c-&gt;c2=
=2Etls_multi-&gt;dco_rx_peer_id, raise_sigusr1_on_err);</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span>diff --git a/src/ope=
nvpn/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh</span><br><span>index c48758=
1=2E=2Ef79e5b1 100644</span><br><span>--- a/src/openvpn/dco_linux=2Eh</span=
><br><span>+++ b/src/openvpn/dco_linux=2Eh</span><br><span>@@ -87,7 +87,7 @=
@</span><br><span>     unsigned int ifindex;</span><br><span> </span><br><s=
pan>     int dco_message_type;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int dco_message_peer_id;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int dco_message_rx_peer_id;</span><br><span>     int =
dco_message_key_id;</span><br><span>     int dco_del_peer_reason;</span><br=
><span>     struct sockaddr_storage dco_float_peer_ss;</span><br><span>diff=
 --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>=
index 0f2b9eb=2E=2E16cadc6 100644</span><br><span>--- a/src/openvpn/dco_win=
=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -411,=
11 +411,11 @@</span><br><span> }</span><br><span> </span><br><span> int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_context_=
t *dco, unsigned int peerid, socket_descriptor_t sd,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_context_t *dco, unsigned=
 int rx_peer_id, socket_descriptor_t sd,</span><br><span>              stru=
ct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span>      =
        const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd &quot; SOCKET_PRINTF, __func__, pe=
erid, sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_DCO_DEBUG, &quot;%s: rx-peer-id %u, fd &quot; SOCKET_PRINTF, __func__, rx_=
peer_id, sd);</span><br><span> </span><br><span>     if (dco-&gt;ifmode =3D=
=3D DCO_MODE_P2P)</span><br><span>     {</span><br><span>@@ -450,7 +450,7 @=
@</span><br><span>         newPeer=2EVpnAddr6 =3D *vpn_ipv6;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    newPeer=2EPeerId =3D peerid;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    newPeer=2EPeerId =3D rx_peer_id;</span><br><span> </s=
pan><br><span>     DWORD bytesReturned;</span><br><span>     if (!DeviceIoC=
ontrol(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_NEW_PEER, &amp;newPeer, sizeof(ne=
wPeer), NULL, 0,</span><br><span>@@ -464,11 +464,11 @@</span><br><span> }</=
span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dco_del_peer(dco_context_t *dco, unsigned int peerid)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_del_peer(dco_context_=
t *dco, unsigned int rx_peer_id)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&q=
uot;, __func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u&quot;, __func__, rx_peer_=
id);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    OVPN_MP_DEL_PEER del_peer =3D { peerid };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVPN_MP_DEL_PEER del_peer =3D { rx_peer_id }=
;</span><br><span>     VOID *buf =3D NULL;</span><br><span>     DWORD len =
=3D 0;</span><br><span>     DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;</span><br>=
<span>@@ -490,13 +490,13 @@</span><br><span> }</span><br><span> </span><br>=
<span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_set_pee=
r(dco_context_t *dco, unsigned int peerid, int keepalive_interval, int keep=
alive_timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      int mss)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_s=
et_peer(dco_context_t *dco, unsigned int rx_peer_id, int keepalive_interval=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             int k=
eepalive_timeout, int mss)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, keepaliv=
e %d/%d, mss %d&quot;, __func__, peerid,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        keepalive_interval, keepalive_timeout, mss);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &q=
uot;%s: rx-peer-id %u, keepalive %d/%d, mss %d&quot;, __func__,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        rx_peer_id, keepalive_i=
nterval, keepalive_timeout, mss);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OVPN_MP_SET_PEER mp_peer =3D { peerid, =
keepalive_interval, keepalive_timeout, mss };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_MP_SET_PEER mp_peer =3D { rx_peer_id, ke=
epalive_interval, keepalive_timeout, mss };</span><br><span>     OVPN_SET_P=
EER peer =3D { keepalive_interval, keepalive_timeout, mss };</span><br><spa=
n>     VOID *buf =3D NULL;</span><br><span>     DWORD len =3D 0;</span><br>=
<span>@@ -524,11 +524,11 @@</span><br><span> }</span><br><span> </span><br>=
<span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_new_key=
(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_new_key(dco_conte=
xt_t *dco, unsigned int rx_peer_id, int keyid, dco_key_slot_t slot,</span><=
br><span>             const uint8_t *encrypt_key, const uint8_t *encrypt_iv=
, const uint8_t *decrypt_key,</span><br><span>             const uint8_t *d=
ecrypt_iv, const char *ciphername, bool epoch)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: =
slot %d, key-id %d, peer-id %u, cipher %s&quot;, __func__, slot, keyid, pee=
rid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_D=
EBUG, &quot;%s: slot %d, key-id %d, rx-peer-id %u, cipher %s&quot;, __func_=
_, slot, keyid, rx_peer_id,</span><br><span>         ciphername);</span><br=
><span> </span><br><span>     const int nonce_len =3D 8;</span><br><span>@@=
 -543,7 +543,7 @@</span><br><span>     v1-&gt;CipherAlg =3D dco_get_cipher(=
ciphername);</span><br><span>     ASSERT(keyid &gt;=3D 0 &amp;&amp; keyid &=
lt;=3D UCHAR_MAX);</span><br><span>     v1-&gt;KeyId =3D (unsigned char)key=
id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    v1-&gt;PeerId =
=3D peerid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v1-&=
gt;PeerId =3D rx_peer_id;</span><br><span>     v1-&gt;KeySlot =3D slot;</sp=
an><br><span> </span><br><span>     /* for epoch we use key material as a s=
eed, no as actual key */</span><br><span>@@ -579,19 +579,19 @@</span><br><s=
pan> }</span><br><span> </span><br><span> int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-dco_del_key(dco_context_t *dco, unsigned int peerid=
, dco_key_slot_t slot)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_del_key(dco_context_t *dco, unsigned int rx_peer_id, dco_key_slot_t =
slot)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(D_DCO, &quot;%s: peer-id %u, slot %d called but ignored&quot;, _=
_func__, peerid, slot);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(D_DCO, &quot;%s: rx-peer-id %u, slot %d called but ignored&quot=
;, __func__, rx_peer_id, slot);</span><br><span>     /* FIXME: Implement in=
 driver first */</span><br><span>     return 0;</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-dco_swap_keys(dco_context_t *dco, unsigned int peer_id)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_swap_keys(dco_context_t *d=
co, unsigned int rx_peer_id)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, =
__func__, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u&quot;, __func__, rx_peer_id);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
OVPN_MP_SWAP_KEYS swap =3D { peer_id };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    OVPN_MP_SWAP_KEYS swap =3D { rx_peer_id };</span><b=
r><span>     DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;</span><br><span>     VOI=
D *buf =3D NULL;</span><br><span>     DWORD len =3D 0;</span><br><span>@@ -=
682,7 +682,7 @@</span><br><span>         msg(D_DCO_DEBUG, &quot;%s: complet=
ion%s success [%lu]&quot;, __func__, queued ? &quot;&quot; : &quot; non-que=
ued&quot;,</span><br><span>             bytes_read);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco-&gt;dco_messag=
e_peer_id =3D dco-&gt;notif_buf=2EPeerId;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        dco-&gt;dco_message_rx_peer_id =3D dco-&gt;no=
tif_buf=2EPeerId;</span><br><span>         dco-&gt;dco_message_type =3D dco=
-&gt;notif_buf=2ECmd;</span><br><span>         dco-&gt;dco_del_peer_reason =
=3D dco-&gt;notif_buf=2EDelPeerReason;</span><br><span>         dco-&gt;dco=
_float_peer_ss =3D dco-&gt;notif_buf=2EFloatAddress;</span><br><span>@@ -70=
1,7 +701,7 @@</span><br><span>         ASSERT(false);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  dco-&gt;dco_message_peer_id =3D -1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    dco-&gt;dco_message_rx_peer_id =3D -1;</span><br><spa=
n>     dco-&gt;dco_message_type =3D 0;</span><br><span> </span><br><span>  =
   switch (dco-&gt;iostate)</span><br><span>@@ -839,7 +839,7 @@</span><br><=
span> </span><br><span>         if (stat-&gt;PeerId &gt;=3D (int)dco-&gt;c-=
&gt;multi-&gt;max_clients)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;%s: received =
out of bound peer_id %d (max=3D%u)&quot;, __func__, stat-&gt;PeerId,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &q=
uot;%s: received out of bound rx_peer_id %d (max=3D%u)&quot;, __func__, sta=
t-&gt;PeerId,</span><br><span>                 dco-&gt;c-&gt;multi-&gt;max_=
clients);</span><br><span>             continue;</span><br><span>         }=
</span><br><span>@@ -847,7 +847,7 @@</span><br><span>         struct multi_=
instance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[stat-&gt;PeerId];</span>=
<br><span>         if (!mi)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;%s: received=
 data for a non-existing peer %d&quot;, __func__, stat-&gt;PeerId);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &qu=
ot;%s: received data for a non-existing peer with RX ID %d&quot;, __func__,=
 stat-&gt;PeerId);</span><br><span>             continue;</span><br><span> =
        }</span><br><span> </span><br><span>@@ -910,7 +910,7 @@</span><br><=
span>     }</span><br><span> </span><br><span>     /* first, try a new ioct=
l */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_GET_PEER=
_STATS ps =3D { =2EPeerId =3D c-&gt;c2=2Etls_multi-&gt;dco_peer_id };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_STATS p=
s =3D { =2EPeerId =3D c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id };</span><br>=
<span> </span><br><span>     OVPN_PEER_STATS peer_stats =3D { 0 };</span><b=
r><span>     DWORD bytes_returned =3D 0;</span><br><span>@@ -1020,16 +1020,=
16 @@</span><br><span> </span><br><span> void</span><br><span> dco_win_add_=
iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        unsi=
gned int peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      unsigned int rx_peer_id)</span><br><span> {</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><s=
pan>     OVPN_MP_IROUTE route =3D {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =
=3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        =2EAddr=2EAddr4=2ES_un=2ES_addr =3D d=
st, =2ENetbits =3D netbits, =2EPeerId =3D rx_peer_id, =2EIPv6 =3D 0</span><=
br><span>     };</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: %s/%u -&gt; peer %u&quot;, __fu=
nc__, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        netbits, peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u -&=
gt; rx-peer-id %u&quot;, __func__, print_in_addr_t(dst, IA_NET_ORDER, &amp;=
gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        netbits=
, rx_peer_id);</span><br><span> </span><br><span>     DWORD bytes_returned =
=3D 0;</span><br><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_=
IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,</span><br><span>@@=
 -1043,14 +1043,14 @@</span><br><span> </span><br><span> void</span><br><sp=
an> dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsign=
ed int netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  unsigned int peer_id)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        unsigned int rx_peer_id)</span>=
<br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_MP_=
IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPeer=
Id =3D peer_id, =2EIPv6 =3D 1 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENet=
bits =3D netbits, =2EPeerId =3D rx_peer_id, =2EIPv6 =3D 1 };</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBU=
G, &quot;%s: %s/%u -&gt; peer %u&quot;, __func__, print_in6_addr(dst, IA_NE=
T_ORDER, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     netbits, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u -&gt; rx-peer-id %u&quot;, __func_=
_, print_in6_addr(dst, IA_NET_ORDER, &amp;gc),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        netbits, rx_peer_id);</span><br><span> <=
/span><br><span>     DWORD bytes_returned =3D 0;</span><br><span>     if (!=
DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, =
sizeof(route), NULL, 0,</span><br><span>diff --git a/src/openvpn/dco_win=2E=
h b/src/openvpn/dco_win=2Eh</span><br><span>index a92e5ad=2E=2Efc9d698 1006=
44</span><br><span>--- a/src/openvpn/dco_win=2Eh</span><br><span>+++ b/src/=
openvpn/dco_win=2Eh</span><br><span>@@ -50,7 +50,7 @@</span><br><span>     =
struct rw_handle rwhandle;   /**&lt; Used to hook async I/O to the OpenVPN =
event loop=2E */</span><br><span>     int ov_ret;                  /**&lt; =
Win32 error code for overlapped operation, 0 for success */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int dco_message=
_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int dc=
o_message_rx_peer_id;</span><br><span>     int dco_message_type;</span><br>=
<span>     int dco_del_peer_reason;</span><br><span>     struct sockaddr_st=
orage dco_float_peer_ss;</span><br><span>@@ -68,10 +68,10 @@</span><br><spa=
n> bool dco_win_supports_multipeer(void);</span><br><span> </span><br><span=
> void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned =
int netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    unsigned int peer_id);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                             unsigned int rx_peer_id=
);</span><br><span> </span><br><span> void dco_win_add_iroute_ipv6(dco_cont=
ext_t *dco, struct in6_addr dst, unsigned int netbits,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                             unsigned int =
peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                   unsigned int rx_peer_id);</span><br><span> </span><br><s=
pan> void dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsign=
ed int netbits);</span><br><span> </span><br><span>diff --git a/src/openvpn=
/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index b4277db=2E=2E2=
56f915 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span=
>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -152,7 +152,7 @@</span><b=
r><span>     }</span><br><span> </span><br><span>     /* no active peer (p2=
p tls-server mode) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D=3D -1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Etls_multi-&gt;dco_rx=
_peer_id =3D=3D -1)</span><br><span>     {</span><br><span>         return;=
</span><br><span>     }</span><br><span>@@ -1266,15 +1266,15 @@</span><br><=
span> #if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(=
TARGET_FREEBSD))</span><br><span>     struct context *c =3D dco-&gt;c;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* F=
reeBSD currently sends us removal notifcation with the old peer-id in</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* FreeBSD currently =
sends us removal notifcation with the old RX peer ID in</span><br><span>   =
   * p2p mode with the ping timeout reason, so ignore that one to not shoot=
</span><br><span>      * ourselves in the foot and removing the just establ=
ished session */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (dco-&gt;dco_message_peer_id !=3D c-&gt;c2=2Etls_multi-&gt;dco_peer_id)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;dco_m=
essage_rx_peer_id !=3D c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id)</span><br><=
span>     {</span><br><span>         msg(D_DCO_DEBUG,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;%s: received message for =
mismatching peer-id %d, &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;%s: received message for mismatching rx-peer-i=
d %d, &quot;</span><br><span>             &quot;expected %d&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            __func__, dco-&gt;=
dco_message_peer_id, c-&gt;c2=2Etls_multi-&gt;dco_peer_id);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            __func__, dco-&gt;dco_m=
essage_rx_peer_id, c-&gt;c2=2Etls_multi-&gt;dco_rx_peer_id);</span><br><spa=
n>         return;</span><br><span>     }</span><br><span> </span><br><span=
>@@ -1282,21 +1282,21 @@</span><br><span>     {</span><br><span>         ca=
se OVPN_CMD_DEL_PEER:</span><br><span>             /* peer is gone, unset I=
D to prevent more kernel calls */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D -1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls=
_multi-&gt;dco_rx_peer_id =3D -1;</span><br><span>             if (dco-&gt;=
dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIRED)</span><br><span>  =
           {</span><br><span>                 msg(D_DCO_DEBUG,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    &quot;%s: rece=
ived peer expired notification of for peer-id &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;%s: received pe=
er expired notification of for rx-peer-id &quot;</span><br><span>          =
           &quot;%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    __func__, dco-&gt;dco_message_peer_id);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    __func__, =
dco-&gt;dco_message_rx_peer_id);</span><br><span>                 trigger_p=
ing_timeout_signal(c);</span><br><span>                 return;</span><br><=
span>             }</span><br><span>             break;</span><br><span> </=
span><br><span>         case OVPN_CMD_SWAP_KEYS:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;%s: received =
key rotation notification for peer-id %d&quot;, __func__,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                dco-&gt;dco_message_pee=
r_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(D_DCO_DEBUG, &quot;%s: received key rotation notification for rx-peer-id=
 %d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                dco-&gt;dco_message_rx_peer_id);</span><br><span>         =
    tls_session_soft_reset(c-&gt;c2=2Etls_multi);</span><br><span>         =
    break;</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 900b5a3=2E=2Ecfcc870 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -3373,7 +3373,7 @@</span><br><span> </s=
pan><br><span>     /* When kernel already deleted the peer, the socket is n=
o longer</span><br><span>      * installed, and we do not need to clean up =
the state in the kernel */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    mi-&gt;context=2Ec2=2Etls_multi-&gt;dco_peer_id =3D -1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context=2Ec2=2Etls_=
multi-&gt;dco_rx_peer_id =3D -1;</span><br><span>     mi-&gt;context=2Esig-=
&gt;signal_text =3D reason;</span><br><span>     multi_signal_instance(m, m=
i, SIGTERM);</span><br><span> }</span><br><span>@@ -3385,19 +3385,19 @@</sp=
an><br><span> </span><br><span>     struct multi_context *m =3D dco-&gt;c-&=
gt;multi;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int peer_id =3D dco-&gt;dco_message_peer_id;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int rx_peer_id =3D dco-&gt;dco_messa=
ge_rx_peer_id;</span><br><span> </span><br><span>     /* no peer-specific m=
essage delivered -&gt; nothing to process=2E</span><br><span>      * bail o=
ut right away</span><br><span>      */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (peer_id &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (rx_peer_id &lt; 0)</span><br><span>     {</spa=
n><br><span>         return;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (((uint32_t)peer_id =
&lt; m-&gt;max_clients) &amp;&amp; m-&gt;instances[peer_id])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (((uint32_t)rx_peer_id &lt;=
 m-&gt;max_clients) &amp;&amp; m-&gt;instances[rx_peer_id])</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 multi_instance *mi =3D m-&gt;instances[peer_id];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D m-&gt;i=
nstances[rx_peer_id];</span><br><span>         set_prefix(mi);</span><br><s=
pan>         if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_DEL_PEER)</span><=
br><span>         {</span><br><span>@@ -3434,9 +3434,9 @@</span><br><span> =
            msglevel =3D D_DCO_DEBUG;</span><br><span>         }</span><br>=
<span>         msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            &quot;Received DCO message for unknown peer-id: %d, &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;Received DCO message for unknown rx-peer-id: %d, &quot;</span><br><span>  =
           &quot;type %d, del_peer_reason %d&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            peer_id, dco-&gt;dco_message_ty=
pe, dco-&gt;dco_del_peer_reason);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            rx_peer_id, dco-&gt;dco_message_type, dco-&gt;dco=
_del_peer_reason);</span><br><span>     }</span><br><span> }</span><br><spa=
n> #endif /* if defined(ENABLE_DCO) */</span><br><span>diff --git a/src/ope=
nvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index ca5958f=2E=2E5476c=
61 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl=2Ec</span><br><span>@@ -1198,7 +1198,7 @@</span><br><span> <=
/span><br><span>     /* get command line derived options */</span><br><span=
>     ret-&gt;opt =3D *tls_options;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ret-&gt;dco_peer_id =3D -1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret-&gt;dco_rx_peer_id =3D -1;</span><br><spa=
n>     ret-&gt;use_asymmetric_peer_id =3D false;</span><br><span>     /* Th=
e rx_peer_id is also used to identify DCO clients */</span><br><span>     r=
et-&gt;rx_peer_id =3D MAX_PEER_ID;</span><br><span>@@ -1711,12 +1711,12 @@<=
/span><br><span>          * ping-exit or mssfix are set to update in-kernel=
 config */</span><br><span>         if (options-&gt;ping_send_timeout || op=
tions-&gt;ping_rec_timeout || frame-&gt;mss_fix)</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int ret =
=3D dco_set_peer(dco, multi-&gt;dco_peer_id, options-&gt;ping_send_timeout,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int ret=
 =3D dco_set_peer(dco, multi-&gt;dco_rx_peer_id, options-&gt;ping_send_time=
out,</span><br><span>                                    options-&gt;ping_r=
ec_timeout, frame-&gt;mss_fix);</span><br><span>             if (ret &lt; 0=
)</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                msg(D_DCO, &quot;Cannot set DCO peer parameters =
for peer (id=3D%d): %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    multi-&gt;dco_peer_id, strerror(-ret));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO, =
&quot;Cannot set DCO peer parameters for peer (rx-id=3D%d): %s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi=
-&gt;dco_rx_peer_id, strerror(-ret));</span><br><span>                 retu=
rn false;</span><br><span>             }</span><br><span>         }</span><=
br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=
=2Eh</span><br><span>index fe333a3=2E=2E7fda552 100644</span><br><span>--- =
a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=
=2Eh</span><br><span>@@ -726,10 +726,10 @@</span><br><span>      * This is =
the handle that DCO uses to identify this session with the</span><br><span>=
      * kernel=2E</span><br><span>      *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * We keep this separate as the normal peer_id can =
change during</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 We keep this separate as the normal rx_peer_id can change during</span><br=
><span>      * p2p NCP and we need to track the id that is really used=2E</=
span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int dco_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int dco_rx_peer_id;</span><br><span> </span><br><span>     dco_conte=
xt_t *dco;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1982?usp=3Demail">change 1982</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1982?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I25fad88fb4bb8e841=
a50981e3197d5b8d8f9069b </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1982 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarc=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dL4u+fnYfLk=--


--===============4775164858423264959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4775164858423264959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4775164858423264959==--

