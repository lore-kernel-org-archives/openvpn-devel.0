Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C615FCA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMxthkXZJEkPXH/NtP4xdlrDhXi1wV+3VOtUVSIf1oY=; b=dkDi+whQ2xnWWmMcv7Lvc4TBCD
	iY0kct1+w9d5urLAmqVJ7Monq5+XGxzP039VkYFfJT+cvd+afCIYhTGt8a7+n73KylLOjpWQpbPZ6
	44PidGQ4jKHGUmHP0YxqmxoJU9oQMCY7U97JiYg/vYrPhiexRbw1dlvlOYQvyz3ROw7s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpe8-0002lf-S2;
	Wed, 30 Sep 2026 08:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdo-0002ix-55
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q/xnTMVlWG6nyVXgkKmW5WF0WIesVlMTKQhC5lHf4gU=; b=JZkbuZbgLYQfgLKHNrNCzBUx8G
 PgKk/bus78nVLzvdeTe28WVim805TQIjqahP8zGkwo2s+mCIHIBuQQF6BGvvXtBz6bOSWxMzUl9P0
 KggjXPo24BCyoiYcuy9ddzTarBlsoIRhvJ8N4dYW8h/+S+6cAP23tjiFmCIoP64Y4//Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q/xnTMVlWG6nyVXgkKmW5WF0WIesVlMTKQhC5lHf4gU=; b=B
 EAWuHRI331iZ9D7Chac8p5s5Viecm9lZWmmAFedcgSwZ7SkrFp9XyDVt1PSM+oaNBswfpIpe5dFdE
 oheXKqji7O8n7+F9/c+IZIvDpspO/Ul9E1+s/AYRedU+U1hzPESgPlFfuWdR/JkzeFR61Zp6oLJH+
 HffS90Aw7orBxnS8=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdm-0005od-B4 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:16 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so30932865e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756768; x=1791361568; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q/xnTMVlWG6nyVXgkKmW5WF0WIesVlMTKQhC5lHf4gU=;
 b=hSM3v7KRzvHIlAqBrjE91dhrKyUMa2fDQruAgBrJ2Jweo/dM2ucgX6vx2co+ve3MZy
 abdojXUt2olo1OoIrlVTUTmS3Ah9KRTGjAhXiB4gY1OpeYnLF76NGKuEDJiHCqGP7Jio
 oUjZW+NGAaTytXM/phnp3qudpi2uLtSqYmViS4iJrbiZ1cnHRis6zXEfhfVENpEM7L0S
 z9Gtodj8KUK5TRKmOEpjsDTK2VNGvSrLv1i/hCMjDD9AXX3crmAovIg23+aj9RJS6Jlk
 7am4nVwCfHmkIkPYvbCLbt4ApKov3bdWmxARarz7ELHGMm9+mS92YMWAfoBEhgMaKngh
 YgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756768; x=1791361568;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q/xnTMVlWG6nyVXgkKmW5WF0WIesVlMTKQhC5lHf4gU=;
 b=w2wz83WDswL+ox9MjclEr+r6wTrfM/+2k6IzxgbrJHtZo5vTbtXC0Ax18gEe09Npp+
 jB7m+HZF+pvKSVTt0SGa7QXU8wTAgk4+bFXi/gxybkZokoQkbyk7EMBabZ/dgobmLpz5
 WdWyknL8+3C8tFdMn9xmk8AJKKhTv4slMyJ1lqqU3SHTQsMXlLrHA8pcfOvq+HBn18Ap
 cEYQHpn6Cke4kOQxJG+jwtIzmZL+aeCutJA7ucAHXLbl1MObaRJ/AiZSlaYygDNf3noL
 CyLNHMC2EGnlCUJZu5nTqUEC9Urypz1iEgsep42wx7ulW/wCGv/twthHPTW2A/MzxxDw
 ANEg==
X-Gm-Message-State: AFuF++mTPKDaTV5uPvyRq2mfXrZRy4eWWdMWZQhvGEoVZbmDzgbBOqHj
 AC4chuWev4NIXVv/FzApMY0Tb18HnGVjxuSiK9G+4X6w0ulObUXxTaTcXEnDpohfqa12WJ0T0sq
 zRx0z2oEE+VJjizjIPY7uRGZxe4ww5uGAgMwVIc4ViWaKPurV2g2xYRGIbbM+GWFvoIOY
X-Gm-Gg: AYBFou2JuQbgqQlwv0Gam3em5sPZhO67DXx7Dnc5a91+NjfJnVsBXHzqMIxofuuj+tb
 dTk5kr2N1OtQDvStr+73xzPSNLgm2UV39heeSFr4LxS6aFk8pBCXefQwtTNr25osgMFJeSleVUt
 r5trtGHW4oSlDCikYK+F6oWUUdSGaefGJXjqYS3qC5CJFsDl2bGtFlw9Ektw8aMYzPvlVyVQ9LQ
 jP65BgoeggUqn/y9SXmxIA5CqFwdTwdYXzIGlG21IB2E8+UVPeAFqXbCJQPk+O6vJrtTdujjzz5
 bARLSscfcPqyvD1d5yiKaLbAWpAgpH4PQCPy+jxC56NlujBnHYklHulHSshNl+EgPX2nfxR54o0
 mJKKiACV4Ksnn2Qlk+9sEl83doSA7fqhhW8R4qBD+T6U4Jy1YI7I2kAksxMz01jtyrN5NBTBM6U
 I7MT3C03jPt1f+fSCB53sqOuMnd7+jHapKix78cddj9h1vvGMQX0ANGoxXxh8ztx0VJZyJNoTzt
 q7k/8guuZ1KZFY8FIXzh969EnTuYcgleNT71OE5oyUBD9fdu6gGj3/xVJ/u6rMD0m24JqiiLUeE
 0KKcuKx9mN1nRyXZeNbNv4KFNLicRZz/nW7owbqtWTkQ+9vNp3J3Ko5UQKzF
X-Received: by 2002:a05:600c:6206:b0:49f:fe5a:522f with SMTP id
 5b1f17b1804b1-4a01b117cbbmr8392985e9.23.1790756767478; 
 Wed, 30 Sep 2026 01:26:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174f055csm29925865e9.9.2026.09.30.01.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:06 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 00a8fc4368a50c25b743dd7c52dd381980fe09c8
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d36761c432e7e5fb1fa8f8e2b0ab8bb14ace0876-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdm-0005od-B4
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Unwrap
 tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8780821361940736964=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8780821361940736964==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vUZSC2IrsEY="; charset=UTF-8

--vUZSC2IrsEY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail

to look a=
t the new patch set (#29)=2E


Change subject: oob: Unwrap tls-crypt-v2 ser=
ver probes (P_CONTROL_OOB_WKC_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OO=
B_WKC_V1)

A tls-crypt-v2 server learns the per-client key only from the wr=
apped
client key (WKc)=2E An out-of-band probe belongs to no session, so th=
e
client must carry the WKc with the probe for the server to unwrap it=2E

=
Add the receive side of this with a new opcode, P_CONTROL_OOB_WKC_V1
(13): =
P_CONTROL_OOB_V1 with the WKc appended, mirroring
CONTROL_HARD_RESET_CLIENT=
_V3 and CONTROL_WKC_V1=2E read_control_auth()
extracts the WKc for it, load=
ing the per-client key before unwrapping,
and the server answers it exactly=
 like P_CONTROL_OOB_V1, through its own
verdict as elsewhere in the enum=2E=
 The reply stays a plain
P_CONTROL_OOB_V1: the server already holds the key=
 after the unwrap, so
tls_wrap_oob_standalone() now takes the opcode=2E

Th=
e client still sends plain probes; sending P_CONTROL_OOB_WKC_V1 is
added in=
 a following commit=2E

Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092ea=
f
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2E=
c
M src/openvpn/oob_client=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_=
pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
5 files changed, 167 insert=
ions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/58/1758/29

diff --git a/src/openvpn/mudp=2Ec b/src/open=
vpn/mudp=2Ec
index c22c46a=2E=2Ee011326 100644
--- a/src/openvpn/mudp=2Ec
+=
++ b/src/openvpn/mudp=2Ec
@@ -109,7 +109,12 @@
     reset_packet_id_send(&s=
tate->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
     state->tls_wrap_tmp=2Eop=
t=2Epacket_id=2Erec=2Einitialized =3D true;
 
-    struct buffer buf =3D tl=
s_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_sid, &payload);
+    /=
* The reply carries no WKc: with tls-crypt-v2 the server has already
+     =
* recovered the per-client key from the request's WKc (it is loaded into
+ =
    * state->tls_wrap_tmp), so the reply is wrapped with that key as a plai=
n
+     * P_CONTROL_OOB_V1 message=2E */
+    struct buffer buf =3D
+      =
  tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_sid, &payload, P_C=
ONTROL_OOB_V1);
     send_standalone_reply(m, &buf, "Server Probe", "Server=
 probe from client, sending probe reply",
                           sock);=

 
@@ -232,7 +237,7 @@
 
         return ret;
     }
-    else if (verdict =
=3D=3D VERDICT_VALID_OOB_V1)
+    else if (verdict =3D=3D VERDICT_VALID_OOB=
_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)
     {
         /* Out-of-b=
and server probe=2E state->newbuf points at the OOB message
          * (re=
ad_control_auth has stripped the opcode, session id and any
diff --git a/sr=
c/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 2c8b6e8=2E=2E70=
c9675 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=
=2Ec
@@ -152,7 +152,8 @@
     {
         return false;
     }
-    *probe =
=3D tls_wrap_oob_standalone(&pc->tas->tls_wrap, pc->tas, pc->client_sid, &p=
ayload);
+    *probe =3D tls_wrap_oob_standalone(&pc->tas->tls_wrap, pc->ta=
s, pc->client_sid, &payload,
+                                     P_CONTRO=
L_OOB_V1);
     return BLEN(probe) > 0;
 }
 
diff --git a/src/openvpn/ssl_p=
kt=2Ec b/src/openvpn/ssl_pkt=2Ec
index d3463b8=2E=2E73d8b7f 100644
--- a/sr=
c/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -146,7 +146,8 @@
   =
      }
 
         if ((header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RES=
ET_CLIENT_V3
-            || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WK=
C_V1)
+            || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1
+ =
           || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)
     =
    {
             if (!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
      =
       {
@@ -203,7 +204,8 @@
     bool ret =3D false;
 
     const uint8_t =
opcode =3D *(BPTR(buf)) >> P_OPCODE_SHIFT;
-    if ((opcode =3D=3D P_CONTRO=
L_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)
+    if ((opcode =
=3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1
+  =
       || opcode =3D=3D P_CONTROL_OOB_WKC_V1)
         && !tls_crypt_v2_ext=
ract_client_key(buf, ctx, opt))
     {
         msg(D_TLS_ERRORS, "TLS Erro=
r: can not extract tls-crypt-v2 client key from %s",
@@ -394,10 +396,16 @@
=
     {
         return VERDICT_VALID_WKC_V1;
     }
-    else if (opcode_is=
_oob(op))
+    else if (op =3D=3D P_CONTROL_OOB_V1)
     {
         return =
VERDICT_VALID_OOB_V1;
     }
+    else if (op =3D=3D P_CONTROL_OOB_WKC_V1)
=
+    {
+        /* The WKc was unwrapped by read_control_auth() above, so t=
he per-client
+         * key is already loaded into state->tls_wrap_tmp=2E=
 */
+        return VERDICT_VALID_OOB_WKC_V1;
+    }
     else
     {
     =
    return VERDICT_VALID_RESET_V2;
@@ -453,8 +461,10 @@
 
 struct buffer
 t=
ls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone=
 *tas,
-                        struct session_id *own_sid, const struct bu=
ffer *payload)
+                        struct session_id *own_sid, const s=
truct buffer *payload, int opcode)
 {
+    ASSERT(opcode_is_oob(opcode));
+=

     /* Copy buffer here to point at the same data but allow tls_wrap_cont=
rol
      * to potentially change buf to point to another buffer without
  =
    * modifying the buffer in tas */
@@ -465,10 +475,11 @@
      * or ACK f=
ields=2E */
     ASSERT(buf_copy(&buf, payload));
 
-    uint8_t header =3D=
 (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    uint8_t header =3D (ui=
nt8_t)(opcode << P_OPCODE_SHIFT);
 
     /* Add tls-auth/tls-crypt wrapping=
, this might replace buf with
-     * ctx->work */
+     * ctx->work=2E For=
 P_CONTROL_OOB_WKC_V1 the wrapped client key is appended
+     * here too (=
tls-crypt-v2)=2E */
     tls_wrap_control(ctx, header, &buf, own_sid);
 
  =
   return buf;
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh
index 5060a4a=2E=2E0196712 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/=
src/openvpn/ssl_pkt=2Eh
@@ -64,17 +64,25 @@
  * handled by tls_pre_decrypt(=
)=2E */
 #define P_CONTROL_OOB_V1 12
 
+/* Variant of P_CONTROL_OOB_V1 with=
 an appended wrapped client key (WKc), like
+ * P_CONTROL_HARD_RESET_CLIENT=
_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is
+ * configured: an out-=
of-band message belongs to no established session, so the
+ * client must c=
arry the WKc for the server to recover the per-client key and
+ * unwrap th=
e message=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc wire
+ * protoc=
ol (CONTROL_OOB_WKC_V1)=2E */
+#define P_CONTROL_OOB_WKC_V1 13
+
 /* define=
 the range of defined opcodes, in- and out-of-band
  * Since we do no longe=
r support key-method 1 we consider
  * the v1 op codes invalid */
 #define =
P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  12
+#define P_LAST_OPCODE  13
 
 /=
* Is op one of the out-of-band opcodes? */
 static inline bool
 opcode_is_o=
ob(int op)
 {
-    return op =3D=3D P_CONTROL_OOB_V1;
+    return op =3D=3D=
 P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;
 }
 
 /*
@@ -110,6 +11=
8,8 @@
     /** This packet is a valid out-of-band control message (e=2Eg=
=2E a server
      * probe)=2E It does not belong to a session and must not=
 create one=2E */
     VERDICT_VALID_OOB_V1,
+    /** as VERDICT_VALID_OOB_=
V1, with a wrapped client key appended (tls-crypt-v2) */
+    VERDICT_VALID=
_OOB_WKC_V1,
     /** the packet failed on of the various checks */
     VE=
RDICT_INVALID
 };
@@ -240,10 +250,14 @@
  * @param tas       standalone aut=
h context providing the work buffer
  * @param own_sid   session id to use =
as our session id in the header
  * @param payload   the OOB message (heade=
r and TLVs) to wrap
+ * @param opcode    the OOB opcode to use: P_CONTROL_O=
OB_V1, or
+ *                  P_CONTROL_OOB_WKC_V1 to append the tls-crypt=
-v2 wrapped
+ *                  client key (the context must then carry it=
)=2E
  * @return          the wrapped packet buffer, ready to send
  */
 st=
ruct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_au=
th_standalone *tas,
-                                      struct session_i=
d *own_sid, const struct buffer *payload);
+                               =
       struct session_id *own_sid, const struct buffer *payload,
+         =
                             int opcode);
 
 
 /**
@@ -290,6 +304,9 @@
    =
     case P_CONTROL_OOB_V1:
             return "P_CONTROL_OOB_V1";
 
+    =
    case P_CONTROL_OOB_WKC_V1:
+            return "P_CONTROL_OOB_WKC_V1";
=
+
         case P_ACK_V1:
             return "P_ACK_V1";
 
diff --git a/te=
sts/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec=

index 887526b=2E=2Ee0164ab 100644
--- a/tests/unit_tests/openvpn/test_pkt=
=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -761,7 +761,7 @@
      =
* bare payload, with none of the reliability/ACK fields a control packet
  =
    * carries=2E */
     struct buffer buf =3D
-        tls_wrap_oob_standa=
lone(&tas_client->tls_wrap, tas_client, &sid, &payload);
+        tls_wrap_=
oob_standalone(&tas_client->tls_wrap, tas_client, &sid, &payload, P_CONTROL=
_OOB_V1);
     assert_int_equal((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTRO=
L_OOB_V1);
 
     /* Server side: the stateless first-packet path must reco=
gnise the opcode,
@@ -847,6 +847,125 @@
     free_tas(&tas_server);
 }
 
+/=
* A matching tls-crypt-v2 server/client key pair (the client key's WKc was
=
+ * wrapped with this server key), reused from the tls-crypt-v2 unit tests=
=2E */
+static const char *oob_v2_server_key =3D
+    "-----BEGIN OpenVPN t=
ls-crypt-v2 server key-----\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGx=
wdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0x=
NTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9=
fn8=3D\n"
+    "-----END OpenVPN tls-crypt-v2 server key-----\n";
+
+static=
 const char *oob_v2_client_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 cl=
ient key-----\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUm=
JygpKissLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV=
1hZWltcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4=
iJiouMjY6P\n"
+    "kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i=
5uru8vb6/\n"
+    "wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp=
6uvs7e7v\n"
+    "8PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdX=
wbDadSV\n"
+    "LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM=
9tg4aw\n"
+    "3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCd=
qGab3\n"
+    "zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6=
daEh\n"
+    "j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHn=
N5k\n"
+    "RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4W=
xu\n"
+    "/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n"
+    "-----END OpenVPN =
tls-crypt-v2 client key-----\n";
+
+/* End-to-end check of the tls-crypt-v2=
 out-of-band probe: the client wraps an
+ * OOB payload as a P_CONTROL_OOB_=
WKC_V1 message (the payload encrypted with the
+ * per-client key Kc, with =
the wrapped client key WKc appended), and the server's
+ * stateless first-=
packet path (tls_pre_decrypt_lite) recovers Kc from the WKc,
+ * decrypts t=
he payload, and returns VERDICT_VALID_OOB_WKC_V1=2E */
+static void
+test_o=
ob_wkc_v1_roundtrip(void **ut_state)
+{
+    now =3D 0x5f000000;
+
+    str=
uct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D=
 1400 }, 0 };
+
+    /* ---- Client: wrap an OOB probe as P_CONTROL_OOB_WKC=
_V1 (WKc appended) ---- */
+    struct tls_auth_standalone tas_client =3D {=
 0 };
+    tas_client=2Eframe =3D frame;
+    tas_client=2Etls_wrap=2Emode =
=3D TLS_WRAP_CRYPT;
+    tas_client=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNOR=
E_PACKET_ID | CO_PACKET_ID_LONG_FORM);
+    packet_id_init(&tas_client=2Etl=
s_wrap=2Eopt=2Epacket_id, 0, 0, "UT-CLIENT", 0);
+    tas_client=2Eworkbuf =
=3D alloc_buf(1600);
+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(1600);=

+
+    /* Load Kc and obtain the WKc, exactly as a tls-crypt-v2 client doe=
s=2E */
+    struct buffer wkc =3D { 0 };
+    tls_crypt_v2_init_client_key=
(&tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi,
+                              =
   &tas_client=2Etls_wrap=2Eoriginal_wrap_keydata, &wkc, oob_v2_client_key,=

+                                 true);
+    tas_client=2Etls_wrap=2Etls_=
crypt_v2_wkc =3D &wkc;
+
+    const uint8_t payload_bytes[] =3D { 0x01, 0x0=
0, 0x02, 0x00, 0x0c, 0xde,
+                                      0xad, 0xb=
e, 0xef, 0x00, 0x11, 0x22 };
+    struct buffer payload =3D alloc_buf(64);
=
+    buf_write(&payload, payload_bytes, sizeof(payload_bytes));
+
+    stru=
ct session_id client_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    reset_pac=
ket_id_send(&tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+
+    struct=
 buffer probe =3D tls_wrap_oob_standalone(&tas_client=2Etls_wrap, &tas_clie=
nt, &client_sid,
+                                                  &payloa=
d, P_CONTROL_OOB_WKC_V1);
+    assert_true(BLEN(&probe) > 0);
+    assert_i=
nt_equal((BPTR(&probe))[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);
+
+   =
 /* ---- Server: stateless path recovers Kc from the WKc and decrypts ---- =
*/
+    struct tls_auth_standalone tas_server =3D { 0 };
+    tas_server=2E=
frame =3D frame;
+    /* No static wrapping, only a tls-crypt-v2 server key=
 (as a v2 server runs)=2E */
+    tas_server=2Etls_wrap=2Emode =3D TLS_WRAP=
_NONE;
+    tas_server=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID |=
 CO_PACKET_ID_LONG_FORM);
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=
=2Epacket_id, 0, 0, "UT-SERVER", 0);
+    tls_crypt_v2_init_server_key(&tas=
_server=2Etls_wrap=2Etls_crypt_v2_server_key, true, oob_v2_server_key,
+   =
                              true);
+    tas_server=2Eworkbuf =3D alloc_bu=
f(1600);
+
+    struct link_socket_actual from =3D { 0 };
+    struct buffe=
r srv =3D alloc_buf(1600);
+    buf_write(&srv, BPTR(&probe), BLEN(&probe))=
;
+
+    struct tls_pre_decrypt_state state =3D { 0 };
+    enum first_pack=
et_verdict verdict =3D tls_pre_decrypt_lite(&tas_server, &state, &from, &sr=
v);
+    assert_int_equal(verdict, VERDICT_VALID_OOB_WKC_V1);
+
+    /* The=
 decrypted payload must equal what the client sent, and the client's
+     =
* session id must be recovered=2E */
+    assert_int_equal(BLEN(&state=2Ene=
wbuf), (int)sizeof(payload_bytes));
+    assert_memory_equal(BPTR(&state=2E=
newbuf), payload_bytes, sizeof(payload_bytes));
+    assert_memory_equal(st=
ate=2Epeer_session_id=2Eid, client_sid=2Eid, SID_SIZE);
+    free_tls_pre_d=
ecrypt_state(&state);
+
+    /* Flipping any single byte (header, session i=
d, ciphertext or WKc) must make
+     * the probe fail to validate=2E */
+ =
   for (size_t i =3D 0; i < (size_t)BLEN(&probe); i++)
+    {
+        stru=
ct tls_pre_decrypt_state tstate =3D { 0 };
+        buf_reset_len(&srv);
+ =
       buf_write(&srv, BPTR(&probe), BLEN(&probe));
+        (BPTR(&srv))[i=
] ^=3D 0xff;
+        enum first_packet_verdict v =3D tls_pre_decrypt_lite(=
&tas_server, &tstate, &from, &srv);
+        assert_int_equal(v, VERDICT_IN=
VALID);
+        free_tls_pre_decrypt_state(&tstate);
+    }
+
+    free_ke=
y_ctx_bi(&tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi);
+    packet_id_free(&t=
as_client=2Etls_wrap=2Eopt=2Epacket_id);
+    free_buf(&wkc);
+    free_buf=
(&payload);
+    free_buf(&tas_client=2Eworkbuf);
+    free_buf(&tas_client=
=2Etls_wrap=2Ework);
+
+    free_key_ctx(&tas_server=2Etls_wrap=2Etls_crypt=
_v2_server_key);
+    packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_=
id);
+    free_buf(&tas_server=2Eworkbuf);
+
+    free_buf(&srv);
+}
+
 sta=
tic void
 test_extract_control_message(void **ut_state)
 {
@@ -901,6 +1020,=
7 @@
         cmocka_unit_test(test_oob_standalone_plain),
         cmocka_=
unit_test(test_oob_standalone_tls_auth),
         cmocka_unit_test(test_oob=
_standalone_tls_crypt),
+        cmocka_unit_test(test_oob_wkc_v1_roundtrip=
),
         cmocka_unit_test(test_extract_control_message)
     };
 

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb8c0c660a98de8ec549b6=
9f6692a7b41b092eaf
Gerrit-Change-Number: 1758
Gerrit-PatchSet: 29
Gerrit-Ow=
ner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--vUZSC2IrsEY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #29</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)<br>=
<br>A tls-crypt-v2 server learns the per-client key only from the wrapped<b=
r>client key (WKc)=2E An out-of-band probe belongs to no session, so the<br=
>client must carry the WKc with the probe for the server to unwrap it=2E<br=
><br>Add the receive side of this with a new opcode, P_CONTROL_OOB_WKC_V1<b=
r>(13): P_CONTROL_OOB_V1 with the WKc appended, mirroring<br>CONTROL_HARD_R=
ESET_CLIENT_V3 and CONTROL_WKC_V1=2E read_control_auth()<br>extracts the WK=
c for it, loading the per-client key before unwrapping,<br>and the server a=
nswers it exactly like P_CONTROL_OOB_V1, through its own<br>verdict as else=
where in the enum=2E The reply stays a plain<br>P_CONTROL_OOB_V1: the serve=
r already holds the key after the unwrap, so<br>tls_wrap_oob_standalone() n=
ow takes the opcode=2E<br><br>The client still sends plain probes; sending =
P_CONTROL_OOB_WKC_V1 is<br>added in a following commit=2E<br><br>Change-Id:=
 Idb8c0c660a98de8ec549b69f6692a7b41b092eaf<br>Signed-off-by: Lev Stipakov &=
lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/=
oob_client=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br=
>M tests/unit_tests/openvpn/test_pkt=2Ec<br>5 files changed, 167 insertions=
(+), 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/58/1758/29</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index c22c46a=2E=2Ee=
011326 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>++=
+ b/src/openvpn/mudp=2Ec</span><br><span>@@ -109,7 +109,12 @@</span><br><sp=
an>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);</span><br><span>     state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Er=
ec=2Einitialized =3D true;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct buffer buf =3D tls_wrap_oob_standalone(&a=
mp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* The reply carries no WKc: with t=
ls-crypt-v2 the server has already</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * recovered the per-client key from the request&#39;s W=
Kc (it is loaded into</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * state-&gt;tls_wrap_tmp), so the reply is wrapped with that key as =
a plain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * P_CON=
TROL_OOB_V1 message=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tls_wrap_oob_standalone(&amp;state-&gt;tls_wrap_tmp, ta=
s, own_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span>     send_stan=
dalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &quot;Server probe from=
 client, sending probe reply&quot;,</span><br><span>                       =
    sock);</span><br><span> </span><br><span>@@ -232,7 +237,7 @@</span><br>=
<span> </span><br><span>         return ret;</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (verdict =3D=3D V=
ERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1 || verdict =3D=3D VERDICT=
_VALID_OOB_WKC_V1)</span><br><span>     {</span><br><span>         /* Out-o=
f-band server probe=2E state-&gt;newbuf points at the OOB message</span><br=
><span>          * (read_control_auth has stripped the opcode, session id a=
nd any</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/src/openvp=
n/oob_client=2Ec</span><br><span>index 2c8b6e8=2E=2E70c9675 100644</span><b=
r><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/=
oob_client=2Ec</span><br><span>@@ -152,7 +152,8 @@</span><br><span>     {</=
span><br><span>         return false;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    *probe =3D tls_wrap_oob_standalo=
ne(&amp;pc-&gt;tas-&gt;tls_wrap, pc-&gt;tas, pc-&gt;client_sid, &amp;payloa=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *probe =3D t=
ls_wrap_oob_standalone(&amp;pc-&gt;tas-&gt;tls_wrap, pc-&gt;tas, pc-&gt;cli=
ent_sid, &amp;payload,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                     P_CONTROL_OOB_V1);</span><br><span>=
     return BLEN(probe) &gt; 0;</span><br><span> }</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</s=
pan><br><span>index d3463b8=2E=2E73d8b7f 100644</span><br><span>--- a/src/o=
penvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br>=
<span>@@ -146,7 +146,8 @@</span><br><span>         }</span><br><span> </spa=
n><br><span>         if ((header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_=
HARD_RESET_CLIENT_V3</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            || (header =
&gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            || (header &gt;&gt; P_OPCODE_SHIFT=
) =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span>         {</span><br><span> =
            if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wkc))</sp=
an><br><span>             {</span><br><span>@@ -203,7 +204,8 @@</span><br><=
span>     bool ret =3D false;</span><br><span> </span><br><span>     const =
uint8_t opcode =3D *(BPTR(buf)) &gt;&gt; P_OPCODE_SHIFT;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if ((opcode =3D=3D P_CONTROL_HARD_RE=
SET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CL=
IENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         || opcode =3D=3D P_CONTROL_OOB_WKC_V1)</span=
><br><span>         &amp;&amp; !tls_crypt_v2_extract_client_key(buf, ctx, o=
pt))</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quo=
t;TLS Error: can not extract tls-crypt-v2 client key from %s&quot;,</span><=
br><span>@@ -394,10 +396,16 @@</span><br><span>     {</span><br><span>     =
    return VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else if (opcode_is_oob(op))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (op =3D=3D P_CONT=
ROL_OOB_V1)</span><br><span>     {</span><br><span>         return VERDICT_=
VALID_OOB_V1;</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (op =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* The WKc was unwrapped by read_contro=
l_auth() above, so the per-client</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * key is already loaded into state-&gt;tls_wrap_tmp=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n VERDICT_VALID_OOB_WKC_V1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span>     else</span><br><span>     {</span><br><s=
pan>         return VERDICT_VALID_RESET_V2;</span><br><span>@@ -453,8 +461,=
10 @@</span><br><span> </span><br><span> struct buffer</span><br><span> tls=
_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *=
tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       struct session_id *own_sid, const struct buffer *payload)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        struct=
 session_id *own_sid, const struct buffer *payload, int opcode)</span><br><=
span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(o=
pcode_is_oob(opcode));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     /* Copy buffer here to point at the same data but =
allow tls_wrap_control</span><br><span>      * to potentially change buf to=
 point to another buffer without</span><br><span>      * modifying the buff=
er in tas */</span><br><span>@@ -465,10 +475,11 @@</span><br><span>      * =
or ACK fields=2E */</span><br><span>     ASSERT(buf_copy(&amp;buf, payload)=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =
=3D (uint8_t)(opcode &lt;&lt; P_OPCODE_SHIFT);</span><br><span> </span><br>=
<span>     /* Add tls-auth/tls-crypt wrapping, this might replace buf with<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * ctx-&gt;work */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ctx-&gt;work=
=2E For P_CONTROL_OOB_WKC_V1 the wrapped client key is appended</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * here too (tls-crypt-v2)=
=2E */</span><br><span>     tls_wrap_control(ctx, header, &amp;buf, own_sid=
);</span><br><span> </span><br><span>     return buf;</span><br><span>diff =
--git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>i=
ndex 5060a4a=2E=2E0196712 100644</span><br><span>--- a/src/openvpn/ssl_pkt=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -64,1=
7 +64,25 @@</span><br><span>  * handled by tls_pre_decrypt()=2E */</span><b=
r><span> #define P_CONTROL_OOB_V1 12</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Variant of P_CONTROL_OOB_V1 with an a=
ppended wrapped client key (WKc), like</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E =
Used when tls-crypt-v2 is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * configured: an out-of-band message belongs to no established sessi=
on, so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * client=
 must carry the WKc for the server to recover the per-client key and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * unwrap the message=2E S=
ee doc/tls-crypt-v2=2Etxt and the openvpn-rfc wire</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * protocol (CONTROL_OOB_WKC_V1)=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_WKC=
_V1 13</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /* define the range of defined opcodes, in- and out-of-band</span><br>=
<span>  * Since we do no longer support key-method 1 we consider</span><br>=
<span>  * the v1 op codes invalid */</span><br><span> #define P_FIRST_OPCOD=
E 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define P_LAST_OPC=
ODE  12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_LA=
ST_OPCODE  13</span><br><span> </span><br><span> /* Is op one of the out-of=
-band opcodes? */</span><br><span> static inline bool</span><br><span> opco=
de_is_oob(int op)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return op =3D=3D P_CONTROL_OOB_V1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return op =3D=3D P_CONTROL_OOB_V1 || =
op =3D=3D P_CONTROL_OOB_WKC_V1;</span><br><span> }</span><br><span> </span>=
<br><span> /*</span><br><span>@@ -110,6 +118,8 @@</span><br><span>     /** =
This packet is a valid out-of-band control message (e=2Eg=2E a server</span=
><br><span>      * probe)=2E It does not belong to a session and must not c=
reate one=2E */</span><br><span>     VERDICT_VALID_OOB_V1,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /** as VERDICT_VALID_OOB_V1, wit=
h a wrapped client key appended (tls-crypt-v2) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    VERDICT_VALID_OOB_WKC_V1,</span><br><span=
>     /** the packet failed on of the various checks */</span><br><span>   =
  VERDICT_INVALID</span><br><span> };</span><br><span>@@ -240,10 +250,14 @@=
</span><br><span>  * @param tas       standalone auth context providing the=
 work buffer</span><br><span>  * @param own_sid   session id to use as our =
session id in the header</span><br><span>  * @param payload   the OOB messa=
ge (header and TLVs) to wrap</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param opcode    the OOB opcode to use: P_CONTROL_OOB_V1, or</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                  P_=
CONTROL_OOB_WKC_V1 to append the tls-crypt-v2 wrapped</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                  client key (the conte=
xt must then carry it)=2E</span><br><span>  * @return          the wrapped =
packet buffer, ready to send</span><br><span>  */</span><br><span> struct b=
uffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_sta=
ndalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                              struct session_id *own_sid, const struct buff=
er *payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                struct session_id *own_sid, const struct bu=
ffer *payload,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                 int opcode);</span><br><span> </span><br><=
span> </span><br><span> /**</span><br><span>@@ -290,6 +304,9 @@</span><br><=
span>         case P_CONTROL_OOB_V1:</span><br><span>             return &q=
uot;P_CONTROL_OOB_V1&quot;;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case P_CONTROL_OOB_WKC_V1:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return &quot;P_CONTROL=
_OOB_WKC_V1&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>         case P_ACK_V1:</span><br><span>             return=
 &quot;P_ACK_V1&quot;;</span><br><span> </span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</s=
pan><br><span>index 887526b=2E=2Ee0164ab 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_pkt=2Ec</span><br><span>@@ -761,7 +761,7 @@</span><br><span>     =
 * bare payload, with none of the reliability/ACK fields a control packet</=
span><br><span>      * carries=2E */</span><br><span>     struct buffer buf=
 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_wrap_=
oob_standalone(&amp;tas_client-&gt;tls_wrap, tas_client, &amp;sid, &amp;pay=
load);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_w=
rap_oob_standalone(&amp;tas_client-&gt;tls_wrap, tas_client, &amp;sid, &amp=
;payload, P_CONTROL_OOB_V1);</span><br><span>     assert_int_equal((BPTR(&a=
mp;buf))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OOB_V1);</span><br><span> </=
span><br><span>     /* Server side: the stateless first-packet path must re=
cognise the opcode,</span><br><span>@@ -847,6 +847,125 @@</span><br><span> =
    free_tas(&amp;tas_server);</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* A matching tls-crypt-v2 =
server/client key pair (the client key&#39;s WKc was</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * wrapped with this server key), reused =
from the tls-crypt-v2 unit tests=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static const char *oob_v2_server_key =3D</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN OpenVPN tls-cr=
ypt-v2 server key-----\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJy=
gpKissLS4v\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;YGF=
iY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END OpenVPN tls-crypt-v2 s=
erver key-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const ch=
ar *oob_v2_client_key =3D</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;-----BEGIN OpenVPN tls-crypt-v2 client key-----\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAECAwQFBgcIC=
QoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQ=
kNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e=
3x9fn+AgYKDhIWGh4iJiouMjY6P\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKzt=
LW2t7i5uru8vb6/\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7=
e7v\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quo=
t;8PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;LHg5bv2Twl=
mPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;3dS6ogH9AkaT+kRRDgNcKW=
kQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+Rd=
zXiMTCpJSovFBP1lDkYwYJPnz6daEh\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/g=
TBtcfQ/OoTFyFHnN5k\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxj=
dt4Wxu\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;-----END OpenVPN tls-crypt-v2 clien=
t key-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* End-to-end check=
 of the tls-crypt-v2 out-of-band probe: the client wraps an</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * OOB payload as a P_CONTROL_OOB_W=
KC_V1 message (the payload encrypted with the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * per-client key Kc, with the wrapped client key=
 WKc appended), and the server&#39;s</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * stateless first-packet path (tls_pre_decrypt_lite) reco=
vers Kc from the WKc,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * decrypts the payload, and returns VERDICT_VALID_OOB_WKC_V1=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_oob_wkc_v1_roundtrip(void **=
ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x5f000000;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D {=
 =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* ---- Client: wrap an OOB probe as P_CONTROL_OOB_WKC_=
V1 (WKc appended) ---- */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct tls_auth_standalone tas_client =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Eframe =3D frame;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_w=
rap=2Emode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tas_client=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_I=
D | CO_PACKET_ID_LONG_FORM);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 0=
, 0, &quot;UT-CLIENT&quot;, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tas_client=2Eworkbuf =3D alloc_buf(1600);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Ework =3D =
alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Load Kc and obt=
ain the WKc, exactly as a tls-crypt-v2 client does=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer wkc =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_cli=
ent_key(&amp;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                 &amp;ta=
s_client=2Etls_wrap=2Eoriginal_wrap_keydata, &amp;wkc, oob_v2_client_key,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
            true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tas_client=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;wkc;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const uint8_t payload_bytes[] =3D { 0x01, 0x00, 0x02=
, 0x00, 0x0c, 0xde,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                      0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer p=
ayload =3D alloc_buf(64);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_write(&amp;payload, payload_bytes, sizeof(payload_bytes));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id client_sid =3D { { =
1, 2, 3, 4, 5, 6, 7, 8 } };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    reset_packet_id_send(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_=
id=2Esend);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D=
 tls_wrap_oob_standalone(&amp;tas_client=2Etls_wrap, &amp;tas_client, &amp;=
client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                          &amp;payload, P_CONTROL_OOB_WKC_V=
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
BLEN(&amp;probe) &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal((BPTR(&amp;probe))[0] &gt;&gt; P_OPCODE_SHIFT, P=
_CONTROL_OOB_WKC_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ---- Serve=
r: stateless path recovers Kc from the WKc and decrypts ---- */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone =
tas_server =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tas_server=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* No static wrapping, only a tls-crypt-v2 server key (=
as a v2 server runs)=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    tas_server=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Etls_wrap=2Eopt=2Efl=
ags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_server=2Et=
ls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-SERVER&quot;, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_server_key(&a=
mp;tas_server=2Etls_wrap=2Etls_crypt_v2_server_key, true, oob_v2_server_key=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
               true);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tas_server=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct link_socket_actual from =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer srv =3D alloc_buf(1600=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&am=
p;srv, BPTR(&amp;probe), BLEN(&amp;probe));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    enum first_packet_verdict verdict =
=3D tls_pre_decrypt_lite(&amp;tas_server, &amp;state, &amp;from, &amp;srv);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(verdict, VERDICT_VALID_OOB_WKC_V1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* The decrypted payload must equal what the client sent, and the client=
&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * sessio=
n id must be recovered=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(BLEN(&amp;state=2Enewbuf), (int)sizeof(payloa=
d_bytes));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_memory_equal(BPTR(&amp;state=2Enewbuf), payload_bytes, sizeof(payload_byt=
es));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_mem=
ory_equal(state=2Epeer_session_id=2Eid, client_sid=2Eid, SID_SIZE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_st=
ate(&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Flipping any si=
ngle byte (header, session id, ciphertext or WKc) must make</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * the probe fail to validate=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size=
_t i =3D 0; i &lt; (size_t)BLEN(&amp;probe); i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct tls_pre_decrypt_state tstate =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_reset_len(&a=
mp;srv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf=
_write(&amp;srv, BPTR(&amp;probe), BLEN(&amp;probe));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        (BPTR(&amp;srv))[i] ^=3D 0xff;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        enum first_pac=
ket_verdict v =3D tls_pre_decrypt_lite(&amp;tas_server, &amp;tstate, &amp;f=
rom, &amp;srv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    assert_int_equal(v, VERDICT_INVALID);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        free_tls_pre_decrypt_state(&amp;tstate);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    free_key_ctx_bi(&amp;tas_client=2Etls_wrap=2Eopt=2Eke=
y_ctx_bi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packe=
t_id_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;wkc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_clie=
nt=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
ree_buf(&amp;tas_client=2Etls_wrap=2Ework);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free_key_ctx(&amp;tas_server=2Etls_wrap=2Etls_crypt_v2_server_key)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free=
(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_server=2Eworkbuf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free_buf(&amp;srv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static void</span><br><span> test_extract=
_control_message(void **ut_state)</span><br><span> {</span><br><span>@@ -90=
1,6 +1020,7 @@</span><br><span>         cmocka_unit_test(test_oob_standalon=
e_plain),</span><br><span>         cmocka_unit_test(test_oob_standalone_tls=
_auth),</span><br><span>         cmocka_unit_test(test_oob_standalone_tls_c=
rypt),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_oob_wkc_v1_roundtrip),</span><br><span>         cmocka_uni=
t_test(test_extract_control_message)</span><br><span>     };</span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
58?usp=3Demail">change 1758</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1758?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1758 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 29 </div>
<div style=3D"display:none"> =
Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--vUZSC2IrsEY=--


--===============8780821361940736964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8780821361940736964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8780821361940736964==--

