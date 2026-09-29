Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EACCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DSRmCb7xP0tQ6XBcE2E5qYAqtrzoiZV0Br9N4fq7ybA=; b=k5gMbLrtbpUivEjLdpTJlLziCQ
	YdeRUkPtdRsx4U0X+3qHEYBJtH5tz5oSl2lnJZ7UXx60wBO+rgtJqs9dBi7BSFln96lrJeATqE3OB
	cuseElQJRMmAJNlfNxj0cfd9ZLL+r2AGls0G8jcGRzFJ+oAqbcQ6RymiNp+w3BYnjwl8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhu-0002wY-MX;
	Tue, 29 Sep 2026 13:17:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXht-0002wL-4w
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LXunrswvu+leQqu8xKVpDC+KWlqTKnwGCnTjEOXsRSo=; b=IydsMsUPc3kNUGnInu7pWod+5t
 FtqY8qUZ9xTvYUSaGFJkZWjmV4pB1fBxa22SXerCZSZMfGv0nSbRTLK3r9A/C8gRqyOOrVHvMBcVE
 xuLpICUluEUZvocGArMJLsVkE0pi1+ar/Ge66PrOD+vv0I2oe96ArEFlskNozOsL7mhQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LXunrswvu+leQqu8xKVpDC+KWlqTKnwGCnTjEOXsRSo=; b=M
 gqWw9yEGQMpcFwV+o9aTl0jTOQtBZtE4S8L4NTx6P46BFZdxtDyV12reStqAM4TFnfjGXVFscs9RX
 UyNCcv5wHN9KFYUWqxSUQurYFlFYVKxbJEAiCIKrCi8tqLbFCb2fcw4/pPKugTOe19q00Enr+R8Qj
 VA20/qe+wfZcXxp8=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhm-0007ll-GL for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:14 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af9f88c95so133896f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687824; x=1791292624; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LXunrswvu+leQqu8xKVpDC+KWlqTKnwGCnTjEOXsRSo=;
 b=IShY12ATpykJFasGVAih3sLIS+UFKuoc8WSr26QIKt/JZkzicRrqWqtW845K37jCSB
 A74kBAZFXQXgEXgRvotNdeC8xbpNEm9waWHQlWNz0PiKFzzXjdCEkS4MCA4u/7NJvNBE
 HQqJhyKyY2e1rGzGdbi18kjdNr9Hi6DP5x09+3Ja2W2hQPOnHS1dIWqnMxnRYc1zjOMm
 cVfgjm45/YcESK1LpR2WhTUNVYdNu/bLTLEsM5PGsa0fjyEzf5/nqVV8i3EVd69UhnxN
 +j8cJEL2n1sOsRyOgqPBChPK+2uGbzqfQ2XT6dF/PX2k5sunAQSBzKT7oV8XSawIb6du
 zasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687824; x=1791292624;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LXunrswvu+leQqu8xKVpDC+KWlqTKnwGCnTjEOXsRSo=;
 b=U/N0u0mJ1VlqzIJSS39XKjKn+VZOa90evfSSNgTU6RN2PRfJ1N6bz7aOEufgOroLZy
 XPpGW2YSirhVxlZUCMTfZAoijLTP+VIYIIdtOWxjp/q4SyCBZWfLhY4pAtNUVCzQX4+T
 0mFNeNTdSltKkJzQFfb7Ib6NAn9VvdJGGFUiAS+LiuxJF9rnl/9aS5EkJ3PdIdpjnMD5
 Mi2BeOB+isrMsgsvjMZ391iXv1PtDSuHanQheEGnR1dox53fUt9O2LO7JYHc1CDCcRzo
 1ILYTQo6x5rhxAXflxT7dxRSirHfdLO1URDlhs5Ds0h6mP0jD1G41QH3UWGs3BRPPMCR
 PTrw==
X-Gm-Message-State: AFuF++kD6dzmw1BLKsDPjq6YAhb5OTu8kLK5p3xbUWqn36SZ3DuCUene
 tprhueisjRMYLf27l9d+MVwKJmlDytO0lFJpX5TavyAkXOz9SjDoXycSbGpaVkuy5oE/tfaDu4P
 hBLJiMFrEGDow1/UEj5Qz9Zc4xG+53h6mK4+dMaNoTJfYzhr19f4AYqp53ohRD9n+G00V
X-Gm-Gg: AYBFou3BNpji3CCiNPV6i58SBJtegajzFcpi5TM7JX3QOlXntrheSw/xO8HlQDB+I0Z
 vRJH9VqLMuZdhvmwioC6VewYXewI/u2AcAvYUZ2imfNup75wo6Gv1C1fklyU/2n1EbTPczaKU48
 3TOFSyYx3TZFZNRxyGsk10WHfCzamC3nINtsnhYvtjXU4oJytdqYKZJKFe43J8UBW2TExKbicu4
 ShLWrWzx5w7pmk+puT/6b5wN0JfsXqXZd3Lj0/8o1Xj+fsji31+b1QeXCX/Ew75Yd4QC1KrA2CD
 Ca9HF86wv5K2Ph99yK3IDvdPSiZukQc/M+wHKIWLC/cCTT+me5E0ZAA8TOgq5T5tYkEw10gNUzk
 9L/BWfXGGDgp0XSdnYG9YhuXguTeXpTEz34ONmgzj7/u+J+3aZKUz0cPFrhrkR+HsxozzFJAK24
 XjXcFWBAXLXK6nTo+5odxuSVpZqRJ+Cq0vIxiMu4Dh9WxdXcyHM5nadqKobZXYU+fG0//NaWAxQ
 dCm8RjuEFZasiaujq433kPntL8IV1fLDmcE4N0ZJ2EIjSHOVcdVQ8NWj/kKSaWBKix/D9C9Bf8l
 SyVpesZXd7Kan2ARxJrk+UnG2WxmrULMuZcxaVu6nUZokNjokRPGYyyIpIql
X-Received: by 2002:a05:600c:1daa:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a00ec54708mr34267815e9.0.1790687823492; 
 Tue, 29 Sep 2026 06:17:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013c6f760sm3406155e9.0.2026.09.29.06.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:17:03 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 8e6caa8785f6ff1d737dd446e99f5463e4d91f63
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <65c2d5e1c73444fb35e331a2415625fbce00e8f1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhm-0007ll-GL
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
Content-Type: multipart/mixed; boundary="===============4203941292537351400=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4203941292537351400==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="esgF7xcryRE="; charset=UTF-8

--esgF7xcryRE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail

to look a=
t the new patch set (#28)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Unwrap tls-cryp=
t-v2 server probes (P_CONTROL_OOB_WKC_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Unwrap tls-crypt-v2 server probes (P_CONT=
ROL_OOB_WKC_V1)

A tls-crypt-v2 server learns the per-client key only from =
the wrapped
client key (WKc)=2E An out-of-band probe belongs to no session,=
 so the
client must carry the WKc with the probe for the server to unwrap i=
t=2E

Add the receive side of this with a new opcode, P_CONTROL_OOB_WKC_V1
=
(13): P_CONTROL_OOB_V1 with the WKc appended, mirroring
CONTROL_HARD_RESET_=
CLIENT_V3 and CONTROL_WKC_V1=2E read_control_auth()
extracts the WKc for it=
, loading the per-client key before unwrapping,
and the server answers it e=
xactly like P_CONTROL_OOB_V1, through its own
verdict as elsewhere in the e=
num=2E The reply stays a plain
P_CONTROL_OOB_V1: the server already holds t=
he key after the unwrap, so
tls_wrap_oob_standalone() now takes the opcode=
=2E

The client still sends plain probes; sending P_CONTROL_OOB_WKC_V1 is
a=
dded in a following commit=2E

Change-Id: Idb8c0c660a98de8ec549b69f6692a7b4=
1b092eaf
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/=
mudp=2Ec
M src/openvpn/oob_client=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openv=
pn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
5 files changed, 167=
 insertions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/58/1758/28

diff --git a/src/openvpn/mudp=2Ec b/s=
rc/openvpn/mudp=2Ec
index 767a692=2E=2E750eb9d 100644
--- a/src/openvpn/mud=
p=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -109,7 +109,12 @@
     reset_packet_id_=
send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
     state->tls_wrap_t=
mp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;
 
-    struct buffer buf=
 =3D tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_sid, &payload);=

+    /* The reply carries no WKc: with tls-crypt-v2 the server has already=

+     * recovered the per-client key from the request's WKc (it is loaded =
into
+     * state->tls_wrap_tmp), so the reply is wrapped with that key as=
 a plain
+     * P_CONTROL_OOB_V1 message=2E */
+    struct buffer buf =3D
=
+        tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_sid, &paylo=
ad, P_CONTROL_OOB_V1);
     send_standalone_reply(m, &buf, "Server Probe", =
"Server probe from client, sending probe reply",
                          =
 sock);
 
@@ -232,7 +237,7 @@
 
         return ret;
     }
-    else if (v=
erdict =3D=3D VERDICT_VALID_OOB_V1)
+    else if (verdict =3D=3D VERDICT_VA=
LID_OOB_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)
     {
         /* O=
ut-of-band server probe=2E state->newbuf points at the OOB message
        =
  * (read_control_auth has stripped the opcode, session id and any
diff --g=
it a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index abf53a0=
=2E=2E4736816 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob=
_client=2Ec
@@ -152,7 +152,8 @@
     {
         return false;
     }
-    *=
probe =3D tls_wrap_oob_standalone(&pc->tas->tls_wrap, pc->tas, pc->client_s=
id, &payload);
+    *probe =3D tls_wrap_oob_standalone(&pc->tas->tls_wrap, =
pc->tas, pc->client_sid, &payload,
+                                     P_=
CONTROL_OOB_V1);
     return BLEN(probe) > 0;
 }
 
diff --git a/src/openvpn=
/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index e5c69b4=2E=2Ed3077a5 100644
--=
- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -145,7 +145,8 =
@@
         }
 
         if ((header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_HA=
RD_RESET_CLIENT_V3
-            || (header >> P_OPCODE_SHIFT) =3D=3D P_CONT=
ROL_WKC_V1)
+            || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC=
_V1
+            || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)=

         {
             if (!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
=
             {
@@ -202,7 +203,8 @@
     bool ret =3D false;
 
     const ui=
nt8_t opcode =3D *(BPTR(buf)) >> P_OPCODE_SHIFT;
-    if ((opcode =3D=3D P_=
CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)
+    if ((o=
pcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_=
V1
+         || opcode =3D=3D P_CONTROL_OOB_WKC_V1)
         && !tls_crypt_=
v2_extract_client_key(buf, ctx, opt))
     {
         msg(D_TLS_ERRORS, "TL=
S Error: can not extract tls-crypt-v2 client key from %s",
@@ -393,10 +395,=
16 @@
     {
         return VERDICT_VALID_WKC_V1;
     }
-    else if (opc=
ode_is_oob(op))
+    else if (op =3D=3D P_CONTROL_OOB_V1)
     {
         r=
eturn VERDICT_VALID_OOB_V1;
     }
+    else if (op =3D=3D P_CONTROL_OOB_WK=
C_V1)
+    {
+        /* The WKc was unwrapped by read_control_auth() above=
, so the per-client
+         * key is already loaded into state->tls_wrap_=
tmp=2E */
+        return VERDICT_VALID_OOB_WKC_V1;
+    }
     else
     {=

         return VERDICT_VALID_RESET_V2;
@@ -453,8 +461,10 @@
 
 struct buf=
fer
 tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_stan=
dalone *tas,
-                        struct session_id *own_sid, const str=
uct buffer *payload)
+                        struct session_id *own_sid, c=
onst struct buffer *payload, int opcode)
 {
+    ASSERT(opcode_is_oob(opcod=
e));
+
     /* Copy buffer here to point at the same data but allow tls_wra=
p_control
      * to potentially change buf to point to another buffer with=
out
      * modifying the buffer in tas */
@@ -465,10 +475,11 @@
      * or=
 ACK fields=2E */
     ASSERT(buf_copy(&buf, payload));
 
-    uint8_t head=
er =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    uint8_t header =
=3D (uint8_t)(opcode << P_OPCODE_SHIFT);
 
     /* Add tls-auth/tls-crypt w=
rapping, this might replace buf with
-     * ctx->work */
+     * ctx->work=
=2E For P_CONTROL_OOB_WKC_V1 the wrapped client key is appended
+     * her=
e too (tls-crypt-v2)=2E */
     tls_wrap_control(ctx, header, &buf, own_sid=
);
 
     return buf;
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ss=
l_pkt=2Eh
index 38e6665=2E=2E298615d 100644
--- a/src/openvpn/ssl_pkt=2Eh
+=
++ b/src/openvpn/ssl_pkt=2Eh
@@ -64,17 +64,25 @@
  * do_pre_decrypt_check()=
, never handled by tls_pre_decrypt()=2E */
 #define P_CONTROL_OOB_V1 12
 
+=
/* Variant of P_CONTROL_OOB_V1 with an appended wrapped client key (WKc), l=
ike
+ * P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E Used when tls-=
crypt-v2 is
+ * configured: an out-of-band message belongs to no establishe=
d session, so the
+ * client must carry the WKc for the server to recover t=
he per-client key and
+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt =
and the openvpn-rfc wire
+ * protocol (CONTROL_OOB_WKC_V1)=2E */
+#define P=
_CONTROL_OOB_WKC_V1 13
+
 /* define the range of defined opcodes, in- and o=
ut-of-band
  * Since we do no longer support key-method 1 we consider
  * t=
he v1 op codes invalid */
 #define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE =
 12
+#define P_LAST_OPCODE  13
 
 /* Is op one of the out-of-band opcodes? =
*/
 static inline bool
 opcode_is_oob(int op)
 {
-    return op =3D=3D P_CO=
NTROL_OOB_V1;
+    return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL=
_OOB_WKC_V1;
 }
 
 /*
@@ -110,6 +118,8 @@
     /** This packet is a valid o=
ut-of-band control message (e=2Eg=2E a server
      * probe)=2E It does not=
 belong to a session and must not create one=2E */
     VERDICT_VALID_OOB_V=
1,
+    /** as VERDICT_VALID_OOB_V1, with a wrapped client key appended (tl=
s-crypt-v2) */
+    VERDICT_VALID_OOB_WKC_V1,
     /** the packet failed on=
 of the various checks */
     VERDICT_INVALID
 };
@@ -240,10 +250,14 @@
  =
* @param tas       standalone auth context providing the work buffer
  * @p=
aram own_sid   session id to use as our session id in the header
  * @param=
 payload   the OOB message (header and TLVs) to wrap
+ * @param opcode    t=
he OOB opcode to use: P_CONTROL_OOB_V1, or
+ *                  P_CONTROL_O=
OB_WKC_V1 to append the tls-crypt-v2 wrapped
+ *                  client ke=
y (the context must then carry it)=2E
  * @return          the wrapped pack=
et buffer, ready to send
  */
 struct buffer tls_wrap_oob_standalone(struct=
 tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                     =
                 struct session_id *own_sid, const struct buffer *payload);=

+                                      struct session_id *own_sid, const s=
truct buffer *payload,
+                                      int opcode);
=
 
 
 /**
@@ -290,6 +304,9 @@
         case P_CONTROL_OOB_V1:
             r=
eturn "P_CONTROL_OOB_V1";
 
+        case P_CONTROL_OOB_WKC_V1:
+          =
  return "P_CONTROL_OOB_WKC_V1";
+
         case P_ACK_V1:
             ret=
urn "P_ACK_V1";
 
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/test=
s/unit_tests/openvpn/test_pkt=2Ec
index e41dc6e=2E=2Eb30fb90 100644
--- a/t=
ests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pk=
t=2Ec
@@ -719,7 +719,7 @@
      * bare payload, with none of the reliabilit=
y/ACK fields a control packet
      * carries=2E */
     struct buffer buf =
=3D
-        tls_wrap_oob_standalone(&tas_client->tls_wrap, tas_client, &si=
d, &payload);
+        tls_wrap_oob_standalone(&tas_client->tls_wrap, tas_c=
lient, &sid, &payload, P_CONTROL_OOB_V1);
     assert_int_equal((BPTR(&buf)=
)[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_V1);
 
     /* Server side: the state=
less first-packet path must recognise the opcode,
@@ -805,6 +805,125 @@
   =
  free_tas(&tas_server);
 }
 
+/* A matching tls-crypt-v2 server/client key=
 pair (the client key's WKc was
+ * wrapped with this server key), reused f=
rom the tls-crypt-v2 unit tests=2E */
+static const char *oob_v2_server_key=
 =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 server key-----\n"
+    "AAECAwQ=
FBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEyMzQ1=
Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY2RlZ=
mdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n"
+    "-----END OpenVPN tls-crypt-v=
2 server key-----\n";
+
+static const char *oob_v2_client_key =3D
+    "---=
--BEGIN OpenVPN tls-crypt-v2 client key-----\n"
+    "AAECAwQFBgcICQoLDA0OD=
xAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0=
BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3B=
xcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
+    "kJGSk5SVlpeYmZqbnJ2en6Ch=
oqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
+    "wMHCw8TFxsfIycrLzM3Oz9DR0=
tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
+    "8PHy8/T19vf4+fr7/P3+/xd9pc=
B0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n"
+    "LHg5bv2TwlmPR3HgaMr8o9LTh9h=
xUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n"
+    "3dS6ogH9AkaT+kRRDgNcKWkQCbwm=
JK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n"
+    "zh2vheFqGMPdGpukbFrT3rcO3VLxU=
eG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n"
+    "j0TzJ3BVru9W3CpotdNt7u09knxAfp=
CxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n"
+    "RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozo=
D8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n"
+    "/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayz=
HgEr\n"
+    "-----END OpenVPN tls-crypt-v2 client key-----\n";
+
+/* End-t=
o-end check of the tls-crypt-v2 out-of-band probe: the client wraps an
+ * =
OOB payload as a P_CONTROL_OOB_WKC_V1 message (the payload encrypted with t=
he
+ * per-client key Kc, with the wrapped client key WKc appended), and th=
e server's
+ * stateless first-packet path (tls_pre_decrypt_lite) recovers =
Kc from the WKc,
+ * decrypts the payload, and returns VERDICT_VALID_OOB_WK=
C_V1=2E */
+static void
+test_oob_wkc_v1_roundtrip(void **ut_state)
+{
+   =
 now =3D 0x5f000000;
+
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadro=
om =3D 200, =2Epayload_size =3D 1400 }, 0 };
+
+    /* ---- Client: wrap an=
 OOB probe as P_CONTROL_OOB_WKC_V1 (WKc appended) ---- */
+    struct tls_a=
uth_standalone tas_client =3D { 0 };
+    tas_client=2Eframe =3D frame;
+  =
  tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;
+    tas_client=2Etls_wr=
ap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
+    =
packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, "UT-CLIENT",=
 0);
+    tas_client=2Eworkbuf =3D alloc_buf(1600);
+    tas_client=2Etls_w=
rap=2Ework =3D alloc_buf(1600);
+
+    /* Load Kc and obtain the WKc, exact=
ly as a tls-crypt-v2 client does=2E */
+    struct buffer wkc =3D { 0 };
+ =
   tls_crypt_v2_init_client_key(&tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi,
=
+                                 &tas_client=2Etls_wrap=2Eoriginal_wrap_ke=
ydata, &wkc, oob_v2_client_key,
+                                 true);
+ =
   tas_client=2Etls_wrap=2Etls_crypt_v2_wkc =3D &wkc;
+
+    const uint8_t =
payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c, 0xde,
+                =
                      0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };
+    struct buf=
fer payload =3D alloc_buf(64);
+    buf_write(&payload, payload_bytes, size=
of(payload_bytes));
+
+    struct session_id client_sid =3D { { 1, 2, 3, 4,=
 5, 6, 7, 8 } };
+    reset_packet_id_send(&tas_client=2Etls_wrap=2Eopt=2Ep=
acket_id=2Esend);
+
+    struct buffer probe =3D tls_wrap_oob_standalone(&t=
as_client=2Etls_wrap, &tas_client, &client_sid,
+                          =
                        &payload, P_CONTROL_OOB_WKC_V1);
+    assert_true(B=
LEN(&probe) > 0);
+    assert_int_equal((BPTR(&probe))[0] >> P_OPCODE_SHIFT=
, P_CONTROL_OOB_WKC_V1);
+
+    /* ---- Server: stateless path recovers Kc =
from the WKc and decrypts ---- */
+    struct tls_auth_standalone tas_serve=
r =3D { 0 };
+    tas_server=2Eframe =3D frame;
+    /* No static wrapping,=
 only a tls-crypt-v2 server key (as a v2 server runs)=2E */
+    tas_server=
=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    tas_server=2Etls_wrap=2Eopt=2Efl=
ags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
+    packet_id_ini=
t(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, "UT-SERVER", 0);
+    tls=
_crypt_v2_init_server_key(&tas_server=2Etls_wrap=2Etls_crypt_v2_server_key,=
 true, oob_v2_server_key,
+                                 true);
+    tas=
_server=2Eworkbuf =3D alloc_buf(1600);
+
+    struct link_socket_actual fro=
m =3D { 0 };
+    struct buffer srv =3D alloc_buf(1600);
+    buf_write(&sr=
v, BPTR(&probe), BLEN(&probe));
+
+    struct tls_pre_decrypt_state state =
=3D { 0 };
+    enum first_packet_verdict verdict =3D tls_pre_decrypt_lite(=
&tas_server, &state, &from, &srv);
+    assert_int_equal(verdict, VERDICT_V=
ALID_OOB_WKC_V1);
+
+    /* The decrypted payload must equal what the clien=
t sent, and the client's
+     * session id must be recovered=2E */
+    as=
sert_int_equal(BLEN(&state=2Enewbuf), (int)sizeof(payload_bytes));
+    ass=
ert_memory_equal(BPTR(&state=2Enewbuf), payload_bytes, sizeof(payload_bytes=
));
+    assert_memory_equal(state=2Epeer_session_id=2Eid, client_sid=2Eid,=
 SID_SIZE);
+    free_tls_pre_decrypt_state(&state);
+
+    /* Flipping any=
 single byte (header, session id, ciphertext or WKc) must make
+     * the =
probe fail to validate=2E */
+    for (size_t i =3D 0; i < (size_t)BLEN(&pr=
obe); i++)
+    {
+        struct tls_pre_decrypt_state tstate =3D { 0 };
+=
        buf_reset_len(&srv);
+        buf_write(&srv, BPTR(&probe), BLEN(&p=
robe));
+        (BPTR(&srv))[i] ^=3D 0xff;
+        enum first_packet_verd=
ict v =3D tls_pre_decrypt_lite(&tas_server, &tstate, &from, &srv);
+       =
 assert_int_equal(v, VERDICT_INVALID);
+        free_tls_pre_decrypt_state(=
&tstate);
+    }
+
+    free_key_ctx_bi(&tas_client=2Etls_wrap=2Eopt=2Ekey_=
ctx_bi);
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=2Epacket_id);
+  =
  free_buf(&wkc);
+    free_buf(&payload);
+    free_buf(&tas_client=2Ework=
buf);
+    free_buf(&tas_client=2Etls_wrap=2Ework);
+
+    free_key_ctx(&ta=
s_server=2Etls_wrap=2Etls_crypt_v2_server_key);
+    packet_id_free(&tas_se=
rver=2Etls_wrap=2Eopt=2Epacket_id);
+    free_buf(&tas_server=2Eworkbuf);
+=

+    free_buf(&srv);
+}
+
 static void
 test_extract_control_message(void =
**ut_state)
 {
@@ -858,6 +977,7 @@
         cmocka_unit_test(test_oob_stand=
alone_plain),
         cmocka_unit_test(test_oob_standalone_tls_auth),
    =
     cmocka_unit_test(test_oob_standalone_tls_crypt),
+        cmocka_unit_=
test(test_oob_wkc_v1_roundtrip),
         cmocka_unit_test(test_extract_con=
trol_message)
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1758?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
Gerrit-Change-Number: 1758=

Gerrit-PatchSet: 28
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <r=
alf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Atte=
ntion: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>

--esgF7xcryRE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #28</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OO=
B_WKC_V1)<br><br>A tls-crypt-v2 server learns the per-client key only from =
the wrapped<br>client key (WKc)=2E An out-of-band probe belongs to no sessi=
on, so the<br>client must carry the WKc with the probe for the server to un=
wrap it=2E<br><br>Add the receive side of this with a new opcode, P_CONTROL=
_OOB_WKC_V1<br>(13): P_CONTROL_OOB_V1 with the WKc appended, mirroring<br>C=
ONTROL_HARD_RESET_CLIENT_V3 and CONTROL_WKC_V1=2E read_control_auth()<br>ex=
tracts the WKc for it, loading the per-client key before unwrapping,<br>and=
 the server answers it exactly like P_CONTROL_OOB_V1, through its own<br>ve=
rdict as elsewhere in the enum=2E The reply stays a plain<br>P_CONTROL_OOB_=
V1: the server already holds the key after the unwrap, so<br>tls_wrap_oob_s=
tandalone() now takes the opcode=2E<br><br>The client still sends plain pro=
bes; sending P_CONTROL_OOB_WKC_V1 is<br>added in a following commit=2E<br><=
br>Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf<br>Signed-off-by: L=
ev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M=
 src/openvpn/oob_client=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/s=
sl_pkt=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>5 files changed, 1=
67 insertions(+), 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1758/28</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index =
767a692=2E=2E750eb9d 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</spa=
n><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -109,7 +109,12 @@=
</span><br><span>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eop=
t=2Epacket_id=2Esend);</span><br><span>     state-&gt;tls_wrap_tmp=2Eopt=2E=
packet_id=2Erec=2Einitialized =3D true;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D tls_wrap_oob_=
standalone(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The reply carries n=
o WKc: with tls-crypt-v2 the server has already</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * recovered the per-client key from the re=
quest&#39;s WKc (it is loaded into</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * state-&gt;tls_wrap_tmp), so the reply is wrapped with=
 that key as a plain</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * P_CONTROL_OOB_V1 message=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;state-&gt;tls=
_wrap_tmp, tas, own_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span> =
    send_standalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &quot;Serv=
er probe from client, sending probe reply&quot;,</span><br><span>          =
                 sock);</span><br><span> </span><br><span>@@ -232,7 +237,7 =
@@</span><br><span> </span><br><span>         return ret;</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (ver=
dict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1 || verdict =
=3D=3D VERDICT_VALID_OOB_WKC_V1)</span><br><span>     {</span><br><span>   =
      /* Out-of-band server probe=2E state-&gt;newbuf points at the OOB mes=
sage</span><br><span>          * (read_control_auth has stripped the opcode=
, session id and any</span><br><span>diff --git a/src/openvpn/oob_client=2E=
c b/src/openvpn/oob_client=2Ec</span><br><span>index abf53a0=2E=2E4736816 1=
00644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ =
b/src/openvpn/oob_client=2Ec</span><br><span>@@ -152,7 +152,8 @@</span><br>=
<span>     {</span><br><span>         return false;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *probe =3D tls_wra=
p_oob_standalone(&amp;pc-&gt;tas-&gt;tls_wrap, pc-&gt;tas, pc-&gt;client_si=
d, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  *probe =3D tls_wrap_oob_standalone(&amp;pc-&gt;tas-&gt;tls_wrap, pc-&gt;t=
as, pc-&gt;client_sid, &amp;payload,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                     P_CONTROL_OOB_V1);</s=
pan><br><span>     return BLEN(probe) &gt; 0;</span><br><span> }</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/=
ssl_pkt=2Ec</span><br><span>index e5c69b4=2E=2Ed3077a5 100644</span><br><sp=
an>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Ec</span><br><span>@@ -145,7 +145,8 @@</span><br><span>         }</span><=
br><span> </span><br><span>         if ((header &gt;&gt; P_OPCODE_SHIFT) =
=3D=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CO=
NTROL_WKC_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            || (header &gt;&g=
t; P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span>         {<=
/span><br><span>             if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_c=
rypt_v2_wkc))</span><br><span>             {</span><br><span>@@ -202,7 +203=
,8 @@</span><br><span>     bool ret =3D false;</span><br><span> </span><br>=
<span>     const uint8_t opcode =3D *(BPTR(buf)) &gt;&gt; P_OPCODE_SHIFT;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((opcode =3D=3D =
P_CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if ((opcode =3D=3D P_CONT=
ROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         || opcode =3D=3D P_CONTROL_=
OOB_WKC_V1)</span><br><span>         &amp;&amp; !tls_crypt_v2_extract_clien=
t_key(buf, ctx, opt))</span><br><span>     {</span><br><span>         msg(D=
_TLS_ERRORS, &quot;TLS Error: can not extract tls-crypt-v2 client key from =
%s&quot;,</span><br><span>@@ -393,10 +395,16 @@</span><br><span>     {</spa=
n><br><span>         return VERDICT_VALID_WKC_V1;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (opcode_is_o=
ob(op))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(op =3D=3D P_CONTROL_OOB_V1)</span><br><span>     {</span><br><span>       =
  return VERDICT_VALID_OOB_V1;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (op =3D=3D P_CONTROL_OOB_WKC_=
V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* The WKc was unwrapp=
ed by read_control_auth() above, so the per-client</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * key is already loaded into state-=
&gt;tls_wrap_tmp=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return VERDICT_VALID_OOB_WKC_V1;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span>     else</span><br><span>   =
  {</span><br><span>         return VERDICT_VALID_RESET_V2;</span><br><span=
>@@ -453,8 +461,10 @@</span><br><span> </span><br><span> struct buffer</spa=
n><br><span> tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_a=
uth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       struct session_id *own_sid, const struct buffer *pay=
load)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          struct session_id *own_sid, const struct buffer *payload, int opc=
ode)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(opcode_is_oob(opcode));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     /* Copy buffer here to point at th=
e same data but allow tls_wrap_control</span><br><span>      * to potential=
ly change buf to point to another buffer without</span><br><span>      * mo=
difying the buffer in tas */</span><br><span>@@ -465,10 +475,11 @@</span><b=
r><span>      * or ACK fields=2E */</span><br><span>     ASSERT(buf_copy(&a=
mp;buf, payload));</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P=
_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint8_t header =3D (uint8_t)(opcode &lt;&lt; P_OPCODE_SHIFT);</span><br><sp=
an> </span><br><span>     /* Add tls-auth/tls-crypt wrapping, this might re=
place buf with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
ctx-&gt;work */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * ctx-&gt;work=2E For P_CONTROL_OOB_WKC_V1 the wrapped client key is appen=
ded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * here too =
(tls-crypt-v2)=2E */</span><br><span>     tls_wrap_control(ctx, header, &am=
p;buf, own_sid);</span><br><span> </span><br><span>     return buf;</span><=
br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</sp=
an><br><span>index 38e6665=2E=2E298615d 100644</span><br><span>--- a/src/op=
envpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><=
span>@@ -64,17 +64,25 @@</span><br><span>  * do_pre_decrypt_check(), never =
handled by tls_pre_decrypt()=2E */</span><br><span> #define P_CONTROL_OOB_V=
1 12</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Variant of P_CONTROL_OOB_V1 with an appended wrapped client key (WKc)=
, like</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * P_CONTROL_=
HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * configured: an out-of-b=
and message belongs to no established session, so the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * client must carry the WKc for the serv=
er to recover the per-client key and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt and th=
e openvpn-rfc wire</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* protocol (CONTROL_OOB_WKC_V1)=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define P_CONTROL_OOB_WKC_V1 13</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /* define the range of defi=
ned opcodes, in- and out-of-band</span><br><span>  * Since we do no longer =
support key-method 1 we consider</span><br><span>  * the v1 op codes invali=
d */</span><br><span> #define P_FIRST_OPCODE 3</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define P_LAST_OPCODE  12</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define P_LAST_OPCODE  13</span><br><span> <=
/span><br><span> /* Is op one of the out-of-band opcodes? */</span><br><spa=
n> static inline bool</span><br><span> opcode_is_oob(int op)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return op =3D=
=3D P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;<=
/span><br><span> }</span><br><span> </span><br><span> /*</span><br><span>@@=
 -110,6 +118,8 @@</span><br><span>     /** This packet is a valid out-of-ba=
nd control message (e=2Eg=2E a server</span><br><span>      * probe)=2E It =
does not belong to a session and must not create one=2E */</span><br><span>=
     VERDICT_VALID_OOB_V1,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /** as VERDICT_VALID_OOB_V1, with a wrapped client key appended =
(tls-crypt-v2) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  VERDICT_VALID_OOB_WKC_V1,</span><br><span>     /** the packet failed on o=
f the various checks */</span><br><span>     VERDICT_INVALID</span><br><spa=
n> };</span><br><span>@@ -240,10 +250,14 @@</span><br><span>  * @param tas =
      standalone auth context providing the work buffer</span><br><span>  *=
 @param own_sid   session id to use as our session id in the header</span><=
br><span>  * @param payload   the OOB message (header and TLVs) to wrap</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opcode    the=
 OOB opcode to use: P_CONTROL_OOB_V1, or</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *                  P_CONTROL_OOB_WKC_V1 to append the=
 tls-crypt-v2 wrapped</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                  client key (the context must then carry it)=2E</span>=
<br><span>  * @return          the wrapped packet buffer, ready to send</sp=
an><br><span>  */</span><br><span> struct buffer tls_wrap_oob_standalone(st=
ruct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                      st=
ruct session_id *own_sid, const struct buffer *payload);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
struct session_id *own_sid, const struct buffer *payload,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
 int opcode);</span><br><span> </span><br><span> </span><br><span> /**</spa=
n><br><span>@@ -290,6 +304,9 @@</span><br><span>         case P_CONTROL_OOB=
_V1:</span><br><span>             return &quot;P_CONTROL_OOB_V1&quot;;</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case P_CONTROL_OOB_WKC_V1:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return &quot;P_CONTROL_OOB_WKC_V1&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         case P_=
ACK_V1:</span><br><span>             return &quot;P_ACK_V1&quot;;</span><br=
><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec=
 b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index e41dc6e=2E=
=2Eb30fb90 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br>=
<span>@@ -719,7 +719,7 @@</span><br><span>      * bare payload, with none o=
f the reliability/ACK fields a control packet</span><br><span>      * carri=
es=2E */</span><br><span>     struct buffer buf =3D</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tls_wrap_oob_standalone(&amp;tas_cl=
ient-&gt;tls_wrap, tas_client, &amp;sid, &amp;payload);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;ta=
s_client-&gt;tls_wrap, tas_client, &amp;sid, &amp;payload, P_CONTROL_OOB_V1=
);</span><br><span>     assert_int_equal((BPTR(&amp;buf))[0] &gt;&gt; P_OPC=
ODE_SHIFT, P_CONTROL_OOB_V1);</span><br><span> </span><br><span>     /* Ser=
ver side: the stateless first-packet path must recognise the opcode,</span>=
<br><span>@@ -805,6 +805,125 @@</span><br><span>     free_tas(&amp;tas_serv=
er);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* A matching tls-crypt-v2 server/client key pair (th=
e client key&#39;s WKc was</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * wrapped with this server key), reused from the tls-crypt-v2 unit =
tests=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static c=
onst char *oob_v2_server_key =3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;-----BEGIN OpenVPN tls-crypt-v2 server key-----\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAECAw=
QFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD=
0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dX=
Z3eHl6e3x9fn8=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;-----END OpenVPN tls-crypt-v2 server key-----\n&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static const char *oob_v2_client_key =3D</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN Op=
enVPN tls-crypt-v2 client key-----\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh=
8gISIjJCUmJygpKissLS4v\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1=
hZWltcXV5f\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;kJG=
Sk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;wMHCw8TFxsfIycr=
LzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;8PHy8/T19vf4+fr7/P3+/xd9pcB=
0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfK=
RNwcso86ua/dBFTyXsM9tg4aw\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuh=
o6QCFqCdqGab3\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daE=
h\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;RZ+q17SC4nba=
3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;/Z5wtPCAZ0tOzj4ItTI77fBO=
YRTfEayzHgEr\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;-----END OpenVPN tls-crypt-v2 client key-----\n&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* End-to-end check of the tls-crypt-v2 out-of-b=
and probe: the client wraps an</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * OOB payload as a P_CONTROL_OOB_WKC_V1 message (the payload en=
crypted with the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
per-client key Kc, with the wrapped client key WKc appended), and the serve=
r&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * stateless=
 first-packet path (tls_pre_decrypt_lite) recovers Kc from the WKc,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * decrypts the payload, an=
d returns VERDICT_VALID_OOB_WKC_V1=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_oob_wkc_v1_roundtrip(void **ut_state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    now =3D 0x5f000000;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayloa=
d_size =3D 1400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ---- Cli=
ent: wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc appended) ---- */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_stand=
alone tas_client =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tas_client=2Eframe =3D frame;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls=
_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&am=
p;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-CLIENT&quot;, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Ewo=
rkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(1600);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Load Kc and obtain the WKc, exactly as a tls-c=
rypt-v2 client does=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer wkc =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    tls_crypt_v2_init_client_key(&amp;tas_client=2Etls_w=
rap=2Eopt=2Ekey_ctx_bi,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                 &amp;tas_client=2Etls_wrap=2Eoriginal_=
wrap_keydata, &amp;wkc, oob_v2_client_key,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                 true);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Etls_=
crypt_v2_wkc =3D &amp;wkc;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt8_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c, 0xde,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
       0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf(64);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;payloa=
d, payload_bytes, sizeof(payload_bytes));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct session_id client_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_sen=
d(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer probe =3D tls_wrap_oob_standalone(&amp;t=
as_client=2Etls_wrap, &amp;tas_client, &amp;client_sid,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
           &amp;payload, P_CONTROL_OOB_WKC_V1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(BLEN(&amp;probe) &gt; 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal((BPT=
R(&amp;probe))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* ---- Server: stateless path recovers Kc f=
rom the WKc and decrypts ---- */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct tls_auth_standalone tas_server =3D { 0 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eframe =3D fr=
ame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* No stati=
c wrapping, only a tls-crypt-v2 server key (as a v2 server runs)=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Etls_wra=
p=2Emode =3D TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tas_server=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID |=
 CO_PACKET_ID_LONG_FORM);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    packet_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 0, 0=
, &quot;UT-SERVER&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    tls_crypt_v2_init_server_key(&amp;tas_server=2Etls_wrap=2Etls_=
crypt_v2_server_key, true, oob_v2_server_key,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                 true);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eworkbuf =3D =
alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket=
_actual from =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer srv =3D alloc_buf(1600);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_write(&amp;srv, BPTR(&amp;probe), BLEN(&=
amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_decrypt=
_state state =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    enum first_packet_verdict verdict =3D tls_pre_decrypt_lite(&amp;tas=
_server, &amp;state, &amp;from, &amp;srv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(verdict, VERDICT_VALID_OOB_WKC_=
V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* The decrypted payload must =
equal what the client sent, and the client&#39;s</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * session id must be recovered=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLE=
N(&amp;state=2Enewbuf), (int)sizeof(payload_bytes));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;state=
=2Enewbuf), payload_bytes, sizeof(payload_bytes));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_memory_equal(state=2Epeer_session=
_id=2Eid, client_sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Flipping any single byte (header, session id,=
 ciphertext or WKc) must make</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * the probe fail to validate=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; (size_t)BLEN(=
&amp;probe); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct t=
ls_pre_decrypt_state tstate =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        buf_reset_len(&amp;srv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;srv, BPTR(&amp;pro=
be), BLEN(&amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        (BPTR(&amp;srv))[i] ^=3D 0xff;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        enum first_packet_verdict v =3D tls_pre_decr=
ypt_lite(&amp;tas_server, &amp;tstate, &amp;from, &amp;srv);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(v, VERDIC=
T_INVALID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
free_tls_pre_decrypt_state(&amp;tstate);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key=
_ctx_bi(&amp;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etl=
s_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free_buf(&amp;wkc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    free_buf(&amp;payload);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    free_buf(&amp;tas_client=2Eworkbuf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=2Etls_=
wrap=2Ework);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;tas=
_server=2Etls_wrap=2Etls_crypt_v2_server_key);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_wrap=2E=
opt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free_buf(&amp;tas_server=2Eworkbuf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    free_buf(&amp;srv);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> static void</span><br><span> test_extract_control_message(void **ut_sta=
te)</span><br><span> {</span><br><span>@@ -858,6 +977,7 @@</span><br><span>=
         cmocka_unit_test(test_oob_standalone_plain),</span><br><span>     =
    cmocka_unit_test(test_oob_standalone_tls_auth),</span><br><span>       =
  cmocka_unit_test(test_oob_standalone_tls_crypt),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_oob_wkc_v1_rou=
ndtrip),</span><br><span>         cmocka_unit_test(test_extract_control_mes=
sage)</span><br><span>     };</span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">change 1758</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb8c=
0c660a98de8ec549b69f6692a7b41b092eaf </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1758 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf=
_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--esgF7xcryRE=--


--===============4203941292537351400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4203941292537351400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4203941292537351400==--

