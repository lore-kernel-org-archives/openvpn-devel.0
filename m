Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91332C88E5A
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fj4575mJKxD6WbM3CYEVf9yNmswVcZqc94tNzb3y8jk=; b=aY9cM5hchMYtGPI5B7KBOiMoFe
	/RjqxAPs4VumpIjWXJcSnTLRZTUtpm6XGwFpLSRjCFh82Pch2DtgOYRSpOabOF5b469LLDiIc+WOP
	MYRcZdMnLxcA7uION7208gK3cITY42aH3dvR8isPf6YmwMFPHSzRDQ7wDUTJ3FM5641E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536z-0008KU-0B;
	Fri, 11 Sep 2026 15:24:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536q-0008IT-7H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mio7N37p3qe1s8z/A99eBixXA6qy6+eBDyiowAGWC3A=; b=EnFOgAo6Z2kFQRCurDy0a1ijx2
 FwuZ4/9rF1oNQK2kE1/QxhL1DVyGV0cls6dqndvzB71vD4KlW+XUivb+CfDLdfjqPvSwB1VSBMW3g
 6IEa/CKpsCTcfoe+1De2ej7b9PqFuxCAsgKkaj0pSK4y2gmbMVnnR6+pq4AS4QorWYWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mio7N37p3qe1s8z/A99eBixXA6qy6+eBDyiowAGWC3A=; b=J
 XpXZXeKDxvYlIJBqAM+k3mwozoqME2HojRy0aXFdQcGZZDugd3eEQZfQMAqDDFAYw+nKZpYZlwmvx
 uPwavlI0g0Ty//wRHTFaH/xaLLelAVsaN/VBKedQV/SKxhfYtZpO3s3sw/PfcxNt+3lp7W/u/m0OW
 DtDRUq9UvvbZt5yc=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x536G-00019E-Lh for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:42 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495437bb891so5109535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140210; x=1789745010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mio7N37p3qe1s8z/A99eBixXA6qy6+eBDyiowAGWC3A=;
 b=B6RfEJmBWa9S5eau0kQkPTDT/9LBQEOegypaKaAeglSuqnNZi6jC4/3cFGNeRIu0LB
 FmAsZntW1rUIKICq3B0bt925yEcHV7pm2ds00bOsTB3/OUO5cfj871RQ/SrKcHhsAljk
 HUp+lt/A1xGz5UWPn6M9UNlbpgWTcMBytWLX+cwXCvisrh3DNeMhRYienqe3UIaBXdTF
 BUAZ/+suRbthK61jtwL9zvJMz0rrW8221VB+F+3o0JxGqeZgcWulUWCiUtlhFnjnBWwq
 A+CeuOMBY6Zfwc27Y2HU5Kfl9aeFQd81xNuiSmH/QN1xYBnIWttVqH6Kck2qs0dR7pwa
 z02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140210; x=1789745010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mio7N37p3qe1s8z/A99eBixXA6qy6+eBDyiowAGWC3A=;
 b=H04tBhTG2QAEPPvJ0mgaBTuEVyN6nTzsYpqc3EvjseT957Bv0gbICdHvP5idYAZT/U
 uPmDXmyijxeJSAcpU3uqV7HHB6P2cZ4vudGJ98wKIk5Lv+exzBZCDQiylmmlWbJQw0th
 hSY/GSZtyzbeQxHGVmNmoQfhjRo+3eluy6o7fDrU3i0NoN9lXGw1ZeraoxsByg4ebNKe
 N2+mab10GCB71VPJJxBjF4JHSNEdt08MXbdlA2npB+fsHdFKfR4JwEXF0Z/NHSoy6Rmo
 I0fxojMpFNusIW/A50yHHj+/u4q4M1XcXEd+Wp/xCrSa6LksbESNZcm+MHQN1pgzytq4
 qBPg==
X-Gm-Message-State: AFuF++npkKy3luPeuTufgnBOjdpTQsxBGJkq6xgSVcNehgVnrrTIJ+Ai
 BtoJV16p7R9sIx1ODRusbfKEuMcwSne6wyuqFpiznbzkpbw1Tm82YSIvDjE+/bsNTODZa6x0Ol7
 s0CnCIh1f2I+ykp1mHYpJd84kjewu47uhwR7VbqFWpA/I+c33OrGO9188v8vYZCgHeCNq
X-Gm-Gg: AYBFou1gKDAsvhKMgWWdG4bk/Yro8lKGVDmPieWvx8OAHvroS3MxjPvhzPPlbZX181W
 bMS3/bOaoAhQUlvbEHe/NiRVohHGeQnzaNZgkoFr9/kvqlgSqrKILX6TWut7GK5DL8DoISLix1N
 ha4JW1VuVIYsANz3TSoFBb16uYtZ2PRC0V655cSJ6sKzaA/3GeyS1RQOoMStURxHonjcuzu+6Z/
 5lPP6rkP2RSB9t35vFm1+Tgn0eeeNR9/4h3dMNDiz1QMCkMDTINI6ZhzQpChf5TvNoYoaA4UTD+
 FjhzMcZIK8rKm4FoPohAVHM/t1DZ2EgQD22aQF0oqq3aE4Os6LvZizBm9nvXc/hOy89ODbAySWt
 bSYHR++fLKBVB5/c6oS9UzMIyk5mzU5lojkiZkyg3VtJCQW4lbH9wjUsk8+c34j1SK+YJEfzOpd
 W9yG6KOiOJdI1ZkVp70fuJBP7kpvA436DlI/2T8dvY/5ZXzCZZjLzKwUOiAg7ZagDuhl7eR6Rci
 FJ/X01syFXy/m2h9zNqOOER0lHPNiVbPVCtpQKb/+mJxSYZMvqV6gj7THb6KUHf0+Ysj3UvkDzw
 zOvd7PIynYYwnD9c71scqNdanjcStvi3S8cN+sQZ0nPso+E0jpLD4vleS3iojg==
X-Received: by 2002:a05:600d:2398:b0:49d:7d4:5f0d with SMTP id
 5b1f17b1804b1-49d26dc6100mr87013525e9.16.1789140209787; 
 Fri, 11 Sep 2026 08:23:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ed106sm6382007f8f.1.2026.09.11.08.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:29 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 66ce7a961bc597a230b68e241e37463885288cfe
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2be0b1e0c573a224dd9093e3352b10795176b56-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x536G-00019E-Lh
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0082211376365536324=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0082211376365536324==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nryJho1E6o0="; charset=UTF-8

--nryJho1E6o0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1758?usp=3Demail

to look at the new patch set (#18)=2E
=


Change subject: oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC=
_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Un=
wrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)

A tls-crypt-v2 serv=
er learns the per-client key only from the wrapped
client key (WKc)=2E An o=
ut-of-band probe belongs to no session, so the
client must carry the WKc wi=
th the probe for the server to unwrap it=2E

Add the receive/protocol side =
of this:

  - new opcode P_CONTROL_OOB_WKC_V1 (13): like P_CONTROL_OOB_V1 b=
ut with
    the WKc appended, mirroring CONTROL_HARD_RESET_CLIENT_V3 and
  =
  CONTROL_WKC_V1
  - tls_wrap_control() appends the WKc for opcode 13;
    =
read_control_auth() runs tls_crypt_v2_extract_client_key() for it,
    load=
ing the per-client key before unwrapping the message
  - tls_pre_decrypt_li=
te() returns the new VERDICT_VALID_OOB_WKC_V1, one
    verdict per opcode a=
s elsewhere in the enum; do_pre_decrypt_check()
    answers it exactly like=
 VERDICT_VALID_OOB_V1
  - P_LAST_OPCODE becomes 13 and opcode_is_oob() cove=
rs both OOB opcodes
  - tls_wrap_oob_standalone() takes the opcode; the ser=
ver reply stays a
    plain P_CONTROL_OOB_V1 (the server already holds the =
key after the
    unwrap)
  - test_pkt: round-trip test of the wrap/extract=
/unwrap path

The client still sends plain probes; sending P_CONTROL_OOB_WK=
C_V1 is
added in a following commit=2E

Change-Id: Idb8c0c660a98de8ec549b69=
f6692a7b41b092eaf
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src=
/openvpn/mudp=2Ec
M src/openvpn/oob_client=2Ec
M src/openvpn/ssl_pkt=2Ec
M =
src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
5 files cha=
nged, 165 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/58/1758/18

diff --git a/src/openvpn/mud=
p=2Ec b/src/openvpn/mudp=2Ec
index 1061f95=2E=2E43aa732 100644
--- a/src/op=
envpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -109,7 +109,12 @@
     reset_p=
acket_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
     state->t=
ls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;
 
-    struct b=
uffer buf =3D tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_sid, &=
payload);
+    /* The reply carries no WKc: with tls-crypt-v2 the server ha=
s already
+     * recovered the per-client key from the request's WKc (it i=
s loaded into
+     * state->tls_wrap_tmp), so the reply is wrapped with th=
at key as a plain
+     * P_CONTROL_OOB_V1 message=2E */
+    struct buffer=
 buf =3D
+        tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_si=
d, &payload, P_CONTROL_OOB_V1);
     send_standalone_reply(m, &buf, "Server=
 Probe", "Server probe from client, sending probe reply",
                 =
          sock);
 
@@ -135,7 +140,7 @@
     int handwindow =3D m->top=2Eopt=
ions=2Ehandshake_window;
 
     if (verdict =3D=3D VERDICT_VALID_RESET_V3 |=
| verdict =3D=3D VERDICT_VALID_RESET_V2
-        || verdict =3D=3D VERDICT_=
VALID_OOB_V1)
+        || verdict =3D=3D VERDICT_VALID_OOB_V1 || verdict =
=3D=3D VERDICT_VALID_OOB_WKC_V1)
     {
         /* Check if we are still b=
elow our limit for sending out
          * responses */
@@ -233,7 +238,7 @@=

 
         return ret;
     }
-    else if (verdict =3D=3D VERDICT_VALID_O=
OB_V1)
+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1 || verdict =3D=3D =
VERDICT_VALID_OOB_WKC_V1)
     {
         /* Out-of-band server probe=2E st=
ate->newbuf points at the TLV payload
          * (read_control_auth has st=
ripped the opcode, session id and any
diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec
index 55db223=2E=2E286b08e 100644
--- a/s=
rc/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -633,7 +633,8=
 @@
         return;
     }
 
-    struct buffer probe =3D tls_wrap_oob_sta=
ndalone(&tas->tls_wrap, tas, &client_sid, &payload);
+    struct buffer pro=
be =3D
+        tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &=
payload, P_CONTROL_OOB_V1);
     if (!BLEN(&probe))
     {
         msg(D_L=
OW, "server-probe: could not wrap probe packet; using configured order");
d=
iff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 78552c4=
=2E=2E614d599 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pk=
t=2Ec
@@ -145,7 +145,8 @@
         }
 
         if ((header >> P_OPCODE_SHI=
FT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
-            || (header >> P_OPCO=
DE_SHIFT) =3D=3D P_CONTROL_WKC_V1)
+            || (header >> P_OPCODE_SHIF=
T) =3D=3D P_CONTROL_WKC_V1
+            || (header >> P_OPCODE_SHIFT) =3D=
=3D P_CONTROL_OOB_WKC_V1)
         {
             if (!buf_copy(&ctx->work,=
 ctx->tls_crypt_v2_wkc))
             {
@@ -199,7 +200,8 @@
     bool ret =
=3D false;
 
     const uint8_t opcode =3D *(BPTR(buf)) >> P_OPCODE_SHIFT;
=
-    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_C=
ONTROL_WKC_V1)
+    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 || op=
code =3D=3D P_CONTROL_WKC_V1
+         || opcode =3D=3D P_CONTROL_OOB_WKC_V=
1)
         && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
     {
    =
     msg(D_TLS_ERRORS, "TLS Error: can not extract tls-crypt-v2 client key =
from %s",
@@ -390,10 +392,16 @@
     {
         return VERDICT_VALID_WKC_V1=
;
     }
-    else if (opcode_is_oob(op))
+    else if (op =3D=3D P_CONTROL=
_OOB_V1)
     {
         return VERDICT_VALID_OOB_V1;
     }
+    else if (=
op =3D=3D P_CONTROL_OOB_WKC_V1)
+    {
+        /* The WKc was unwrapped by=
 read_control_auth() above, so the per-client
+         * key is already lo=
aded into state->tls_wrap_tmp=2E */
+        return VERDICT_VALID_OOB_WKC_V=
1;
+    }
     else
     {
         return VERDICT_VALID_RESET_V2;
@@ -450,=
8 +458,10 @@
 
 struct buffer
 tls_wrap_oob_standalone(struct tls_wrap_ctx =
*ctx, struct tls_auth_standalone *tas,
-                        struct sess=
ion_id *own_sid, const struct buffer *payload)
+                        str=
uct session_id *own_sid, const struct buffer *payload, int opcode)
 {
+    =
ASSERT(opcode_is_oob(opcode));
+
     /* Copy buffer here to point at the s=
ame data but allow tls_wrap_control
      * to potentially change buf to po=
int to another buffer without
      * modifying the buffer in tas */
@@ -46=
2,10 +472,11 @@
      * or ACK fields=2E */
     ASSERT(buf_copy(&buf, payl=
oad));
 
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHI=
FT);
+    uint8_t header =3D (uint8_t)(opcode << P_OPCODE_SHIFT);
 
     /*=
 Add tls-auth/tls-crypt wrapping, this might replace buf with
-     * ctx->=
work */
+     * ctx->work=2E For P_CONTROL_OOB_WKC_V1 the wrapped client ke=
y is appended
+     * here too (tls-crypt-v2)=2E */
     tls_wrap_control(c=
tx, header, &buf, own_sid);
 
     return buf;
diff --git a/src/openvpn/ssl=
_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 581ec48=2E=2E89e9619 100644
--- a/=
src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -67,18 +67,26 @@
 =
 * legal on an established session; see opcode_valid_in_session() below=2E =
*/
 #define P_CONTROL_OOB_V1 12
 
+/* Variant of P_CONTROL_OOB_V1 with an a=
ppended wrapped client key (WKc), like
+ * P_CONTROL_HARD_RESET_CLIENT_V3 /=
 P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is
+ * configured: an out-of-ba=
nd message belongs to no established session, so the
+ * client must carry =
the WKc for the server to recover the per-client key and
+ * unwrap the mes=
sage=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc wire
+ * protocol (C=
ONTROL_OOB_WKC_V1)=2E */
+#define P_CONTROL_OOB_WKC_V1 13
+
 /* define the =
range of defined opcodes, in- and out-of-band=2E Note this is not
  * the s=
et of opcodes legal on an established session; see
  * opcode_valid_in_sess=
ion()=2E
  * Since we do no longer support key-method 1 we consider
  * the=
 v1 op codes invalid */
 #define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  1=
2
+#define P_LAST_OPCODE  13
 
 static inline bool
 opcode_is_oob(int op)
 =
{
-    return op =3D=3D P_CONTROL_OOB_V1;
+    return op =3D=3D P_CONTROL_O=
OB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;
 }
 
 /**
@@ -140,6 +148,8 @@
    =
 /** This packet is a valid out-of-band control message (e=2Eg=2E a server
=
      * probe)=2E It does not belong to a session and must not create one=
=2E */
     VERDICT_VALID_OOB_V1,
+    /** as VERDICT_VALID_OOB_V1, with a =
wrapped client key appended (tls-crypt-v2) */
+    VERDICT_VALID_OOB_WKC_V1=
,
     /** the packet failed on of the various checks */
     VERDICT_INVAL=
ID
 };
@@ -270,10 +280,14 @@
  * @param tas       standalone auth context p=
roviding the work buffer
  * @param own_sid   session id to use as our sess=
ion id in the header
  * @param payload   the OOB message payload (TLV stre=
am) to wrap
+ * @param opcode    the OOB opcode to use: P_CONTROL_OOB_V1, o=
r
+ *                  P_CONTROL_OOB_WKC_V1 to append the tls-crypt-v2 wrap=
ped
+ *                  client key (the context must then carry it)=2E
  *=
 @return          the wrapped packet buffer, ready to send
  */
 struct buf=
fer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_stand=
alone *tas,
-                                      struct session_id *own_s=
id, const struct buffer *payload);
+                                      s=
truct session_id *own_sid, const struct buffer *payload,
+                 =
                     int opcode);
 
 
 /**
diff --git a/tests/unit_tests/op=
envpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index ca3045a=2E=
=2E894ac4f 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_pkt=2Ec
@@ -716,7 +716,7 @@
      * bare payload, wi=
th none of the reliability/ACK fields a control packet
      * carries=2E *=
/
     struct buffer buf =3D
-        tls_wrap_oob_standalone(&tas_client->=
tls_wrap, tas_client, &sid, &payload);
+        tls_wrap_oob_standalone(&ta=
s_client->tls_wrap, tas_client, &sid, &payload, P_CONTROL_OOB_V1);
     ass=
ert_int_equal((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_V1);
 
     =
/* Server side: the stateless first-packet path must recognise the opcode,
=
@@ -802,6 +802,125 @@
     free_tas(&tas_server);
 }
 
+/* A matching tls-c=
rypt-v2 server/client key pair (the client key's WKc was
+ * wrapped with t=
his server key), reused from the tls-crypt-v2 unit tests=2E */
+static cons=
t char *oob_v2_server_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 server =
key-----\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpK=
issLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWl=
tcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n"
+    "---=
--END OpenVPN tls-crypt-v2 server key-----\n";
+
+static const char *oob_v2=
_client_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
+ =
   "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+  =
  "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+   =
 "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
+    =
"kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
+    "=
wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
+    "8=
PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n"
+    "LH=
g5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n"
+    "3dS=
6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n"
+    "zh2v=
heFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n"
+    "j0TzJ=
3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n"
+    "RZ+q17=
SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n"
+    "/Z5wtPC=
AZ0tOzj4ItTI77fBOYRTfEayzHgEr\n"
+    "-----END OpenVPN tls-crypt-v2 client=
 key-----\n";
+
+/* End-to-end check of the tls-crypt-v2 out-of-band probe:=
 the client wraps an
+ * OOB payload as a P_CONTROL_OOB_WKC_V1 message (the=
 payload encrypted with the
+ * per-client key Kc, with the wrapped client =
key WKc appended), and the server's
+ * stateless first-packet path (tls_pr=
e_decrypt_lite) recovers Kc from the WKc,
+ * decrypts the payload, and ret=
urns VERDICT_VALID_OOB_WKC_V1=2E */
+static void
+test_oob_wkc_v1_roundtrip=
(void **ut_state)
+{
+    now =3D 0x5f000000;
+
+    struct frame frame =3D=
 { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+
+  =
  /* ---- Client: wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc appended) =
---- */
+    struct tls_auth_standalone tas_client =3D { 0 };
+    tas_clie=
nt=2Eframe =3D frame;
+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;=

+    tas_client=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PA=
CKET_ID_LONG_FORM);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epack=
et_id, 0, 0, "UT-CLIENT", 0);
+    tas_client=2Eworkbuf =3D alloc_buf(1600)=
;
+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(1600);
+
+    /* Load Kc =
and obtain the WKc, exactly as a tls-crypt-v2 client does=2E */
+    struct=
 buffer wkc =3D { 0 };
+    tls_crypt_v2_init_client_key(&tas_client=2Etls_=
wrap=2Eopt=2Ekey_ctx_bi,
+                                 &tas_client=2Etl=
s_wrap=2Eoriginal_wrap_keydata, &wkc, oob_v2_client_key,
+                 =
                true);
+    tas_client=2Etls_wrap=2Etls_crypt_v2_wkc =3D &w=
kc;
+
+    const uint8_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c=
, 0xde,
+                                      0xad, 0xbe, 0xef, 0x00, 0x11=
, 0x22 };
+    struct buffer payload =3D alloc_buf(64);
+    buf_write(&pay=
load, payload_bytes, sizeof(payload_bytes));
+
+    struct session_id clien=
t_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    reset_packet_id_send(&tas_cl=
ient=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+
+    struct buffer probe =3D t=
ls_wrap_oob_standalone(&tas_client=2Etls_wrap, &tas_client, &client_sid,
+ =
                                                 &payload, P_CONTROL_OOB_WK=
C_V1);
+    assert_true(BLEN(&probe) > 0);
+    assert_int_equal((BPTR(&pro=
be))[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);
+
+    /* ---- Server: st=
ateless path recovers Kc from the WKc and decrypts ---- */
+    struct tls_=
auth_standalone tas_server =3D { 0 };
+    tas_server=2Eframe =3D frame;
+ =
   /* No static wrapping, only a tls-crypt-v2 server key (as a v2 server ru=
ns)=2E */
+    tas_server=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    tas_ser=
ver=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_=
FORM);
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, =
"UT-SERVER", 0);
+    tls_crypt_v2_init_server_key(&tas_server=2Etls_wrap=
=2Etls_crypt_v2_server_key, true, oob_v2_server_key,
+                     =
            true);
+    tas_server=2Eworkbuf =3D alloc_buf(1600);
+
+    st=
ruct link_socket_actual from =3D { 0 };
+    struct buffer srv =3D alloc_bu=
f(1600);
+    buf_write(&srv, BPTR(&probe), BLEN(&probe));
+
+    struct tl=
s_pre_decrypt_state state =3D { 0 };
+    enum first_packet_verdict verdict=
 =3D tls_pre_decrypt_lite(&tas_server, &state, &from, &srv);
+    assert_in=
t_equal(verdict, VERDICT_VALID_OOB_WKC_V1);
+
+    /* The decrypted payload=
 must equal what the client sent, and the client's
+     * session id must =
be recovered=2E */
+    assert_int_equal(BLEN(&state=2Enewbuf), (int)sizeof=
(payload_bytes));
+    assert_memory_equal(BPTR(&state=2Enewbuf), payload_b=
ytes, sizeof(payload_bytes));
+    assert_memory_equal(state=2Epeer_session=
_id=2Eid, client_sid=2Eid, SID_SIZE);
+    free_tls_pre_decrypt_state(&stat=
e);
+
+    /* Flipping any single byte (header, session id, ciphertext or W=
Kc) must make
+     * the probe fail to validate=2E */
+    for (size_t i =
=3D 0; i < (size_t)BLEN(&probe); i++)
+    {
+        struct tls_pre_decryp=
t_state tstate =3D { 0 };
+        buf_reset_len(&srv);
+        buf_write(=
&srv, BPTR(&probe), BLEN(&probe));
+        (BPTR(&srv))[i] ^=3D 0xff;
+   =
     enum first_packet_verdict v =3D tls_pre_decrypt_lite(&tas_server, &tst=
ate, &from, &srv);
+        assert_int_equal(v, VERDICT_INVALID);
+        =
free_tls_pre_decrypt_state(&tstate);
+    }
+
+    free_key_ctx_bi(&tas_cli=
ent=2Etls_wrap=2Eopt=2Ekey_ctx_bi);
+    packet_id_free(&tas_client=2Etls_w=
rap=2Eopt=2Epacket_id);
+    free_buf(&wkc);
+    free_buf(&payload);
+    =
free_buf(&tas_client=2Eworkbuf);
+    free_buf(&tas_client=2Etls_wrap=2Ewor=
k);
+
+    free_key_ctx(&tas_server=2Etls_wrap=2Etls_crypt_v2_server_key);
=
+    packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_id);
+    free_bu=
f(&tas_server=2Eworkbuf);
+
+    free_buf(&srv);
+}
+
 static void
 test_ex=
tract_control_message(void **ut_state)
 {
@@ -855,6 +974,7 @@
         cmoc=
ka_unit_test(test_oob_standalone_plain),
         cmocka_unit_test(test_oob=
_standalone_tls_auth),
         cmocka_unit_test(test_oob_standalone_tls_cr=
ypt),
+        cmocka_unit_test(test_oob_wkc_v1_roundtrip),
         cmocka=
_unit_test(test_extract_control_message)
     };
 

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf=

Gerrit-Change-Number: 1758
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipa=
kov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--nryJho1E6o0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1758?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Unw=
rap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)<br><br>A tls-crypt-v2=
 server learns the per-client key only from the wrapped<br>client key (WKc)=
=2E An out-of-band probe belongs to no session, so the<br>client must carry=
 the WKc with the probe for the server to unwrap it=2E<br><br>Add the recei=
ve/protocol side of this:<br><br>  - new opcode P_CONTROL_OOB_WKC_V1 (13): =
like P_CONTROL_OOB_V1 but with<br>    the WKc appended, mirroring CONTROL_H=
ARD_RESET_CLIENT_V3 and<br>    CONTROL_WKC_V1<br>  - tls_wrap_control() app=
ends the WKc for opcode 13;<br>    read_control_auth() runs tls_crypt_v2_ex=
tract_client_key() for it,<br>    loading the per-client key before unwrapp=
ing the message<br>  - tls_pre_decrypt_lite() returns the new VERDICT_VALID=
_OOB_WKC_V1, one<br>    verdict per opcode as elsewhere in the enum; do_pre=
_decrypt_check()<br>    answers it exactly like VERDICT_VALID_OOB_V1<br>  -=
 P_LAST_OPCODE becomes 13 and opcode_is_oob() covers both OOB opcodes<br>  =
- tls_wrap_oob_standalone() takes the opcode; the server reply stays a<br> =
   plain P_CONTROL_OOB_V1 (the server already holds the key after the<br>  =
  unwrap)<br>  - test_pkt: round-trip test of the wrap/extract/unwrap path<=
br><br>The client still sends plain probes; sending P_CONTROL_OOB_WKC_V1 is=
<br>added in a following commit=2E<br><br>Change-Id: Idb8c0c660a98de8ec549b=
69f6692a7b41b092eaf<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt=
;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/oob_client=2Ec<br>M src=
/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/ope=
nvpn/test_pkt=2Ec<br>5 files changed, 165 insertions(+), 14 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/58/1758/18</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec</span><br><span>index 1061f95=2E=2E43aa732 100644</span><br=
><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2E=
c</span><br><span>@@ -109,7 +109,12 @@</span><br><span>     reset_packet_id=
_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><spa=
n>     state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D tru=
e;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct buffer buf =3D tls_wrap_oob_standalone(&amp;state-&gt;tls_wrap_tm=
p, tas, own_sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* The reply carries no WKc: with tls-crypt-v2 the server h=
as already</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * re=
covered the per-client key from the request&#39;s WKc (it is loaded into</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * state-&gt;tls_w=
rap_tmp), so the reply is wrapped with that key as a plain</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * P_CONTROL_OOB_V1 message=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_=
wrap_oob_standalone(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload=
, P_CONTROL_OOB_V1);</span><br><span>     send_standalone_reply(m, &amp;buf=
, &quot;Server Probe&quot;, &quot;Server probe from client, sending probe r=
eply&quot;,</span><br><span>                           sock);</span><br><sp=
an> </span><br><span>@@ -135,7 +140,7 @@</span><br><span>     int handwindo=
w =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><=
span>     if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDI=
CT_VALID_RESET_V2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    || verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        || verdict =3D=3D VERDICT_VALID_OOB_V1 || v=
erdict =3D=3D VERDICT_VALID_OOB_WKC_V1)</span><br><span>     {</span><br><s=
pan>         /* Check if we are still below our limit for sending out</span=
><br><span>          * responses */</span><br><span>@@ -233,7 +238,7 @@</sp=
an><br><span> </span><br><span>         return ret;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (verdict =
=3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1 || verdict =3D=3D=
 VERDICT_VALID_OOB_WKC_V1)</span><br><span>     {</span><br><span>         =
/* Out-of-band server probe=2E state-&gt;newbuf points at the TLV payload</=
span><br><span>          * (read_control_auth has stripped the opcode, sess=
ion id and any</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec</span><br><span>index 55db223=2E=2E286b08e 100644<=
/span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/=
openvpn/oob_client=2Ec</span><br><span>@@ -633,7 +633,8 @@</span><br><span>=
         return;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct buffer probe =3D tls_wrap_oo=
b_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer prob=
e =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wr=
ap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload=
, P_CONTROL_OOB_V1);</span><br><span>     if (!BLEN(&amp;probe))</span><br>=
<span>     {</span><br><span>         msg(D_LOW, &quot;server-probe: could =
not wrap probe packet; using configured order&quot;);</span><br><span>diff =
--git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>i=
ndex 78552c4=2E=2E614d599 100644</span><br><span>--- a/src/openvpn/ssl_pkt=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -145,=
7 +145,8 @@</span><br><span>         }</span><br><span> </span><br><span>  =
       if ((header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLI=
ENT_V3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || =
(header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            || (header &gt;&gt; P_OPC=
ODE_SHIFT) =3D=3D P_CONTROL_WKC_V1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CON=
TROL_OOB_WKC_V1)</span><br><span>         {</span><br><span>             if=
 (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wkc))</span><br><span> =
            {</span><br><span>@@ -199,7 +200,8 @@</span><br><span>     bool=
 ret =3D false;</span><br><span> </span><br><span>     const uint8_t opcode=
 =3D *(BPTR(buf)) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 =
|| opcode =3D=3D P_CONTROL_WKC_V1)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 || opc=
ode =3D=3D P_CONTROL_WKC_V1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         || opcode =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span>   =
      &amp;&amp; !tls_crypt_v2_extract_client_key(buf, ctx, opt))</span><br=
><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS Error: c=
an not extract tls-crypt-v2 client key from %s&quot;,</span><br><span>@@ -3=
90,10 +392,16 @@</span><br><span>     {</span><br><span>         return VER=
DICT_VALID_WKC_V1;</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else if (opcode_is_oob(op))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (op =3D=3D P_CONTROL_OOB_V1)<=
/span><br><span>     {</span><br><span>         return VERDICT_VALID_OOB_V1=
;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (op =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* The WKc was unwrapped by read_control_auth() abo=
ve, so the per-client</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * key is already loaded into state-&gt;tls_wrap_tmp=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return VERDICT_VAL=
ID_OOB_WKC_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     else</span><br><span>     {</span><br><span>         =
return VERDICT_VALID_RESET_V2;</span><br><span>@@ -450,8 +458,10 @@</span><=
br><span> </span><br><span> struct buffer</span><br><span> tls_wrap_oob_sta=
ndalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        struct=
 session_id *own_sid, const struct buffer *payload)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        struct session_id=
 *own_sid, const struct buffer *payload, int opcode)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opcode_is_oo=
b(opcode));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     /* Copy buffer here to point at the same data but allow tls_w=
rap_control</span><br><span>      * to potentially change buf to point to a=
nother buffer without</span><br><span>      * modifying the buffer in tas *=
/</span><br><span>@@ -462,10 +472,11 @@</span><br><span>      * or ACK fiel=
ds=2E */</span><br><span>     ASSERT(buf_copy(&amp;buf, payload));</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t =
header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D (uint8_t=
)(opcode &lt;&lt; P_OPCODE_SHIFT);</span><br><span> </span><br><span>     /=
* Add tls-auth/tls-crypt wrapping, this might replace buf with</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * ctx-&gt;work */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * ctx-&gt;work=2E For P_CO=
NTROL_OOB_WKC_V1 the wrapped client key is appended</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * here too (tls-crypt-v2)=2E */</spa=
n><br><span>     tls_wrap_control(ctx, header, &amp;buf, own_sid);</span><b=
r><span> </span><br><span>     return buf;</span><br><span>diff --git a/src=
/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 581ec4=
8=2E=2E89e9619 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><=
br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -67,18 +67,26 @@<=
/span><br><span>  * legal on an established session; see opcode_valid_in_se=
ssion() below=2E */</span><br><span> #define P_CONTROL_OOB_V1 12</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Variant o=
f P_CONTROL_OOB_V1 with an appended wrapped client key (WKc), like</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * P_CONTROL_HARD_RESET_CLIE=
NT_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * configured: an out-of-band message bel=
ongs to no established session, so the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * client must carry the WKc for the server to recover t=
he per-client key and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc w=
ire</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocol (CON=
TROL_OOB_WKC_V1)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define P_CONTROL_OOB_WKC_V1 13</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /* define the range of defined opcodes, in=
- and out-of-band=2E Note this is not</span><br><span>  * the set of opcode=
s legal on an established session; see</span><br><span>  * opcode_valid_in_=
session()=2E</span><br><span>  * Since we do no longer support key-method 1=
 we consider</span><br><span>  * the v1 op codes invalid */</span><br><span=
> #define P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define P_LAST_OPCODE  12</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define P_LAST_OPCODE  13</span><br><span> </span><br><span> sta=
tic inline bool</span><br><span> opcode_is_oob(int op)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return op =3D=3D P_=
CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;</span>=
<br><span> }</span><br><span> </span><br><span> /**</span><br><span>@@ -140=
,6 +148,8 @@</span><br><span>     /** This packet is a valid out-of-band co=
ntrol message (e=2Eg=2E a server</span><br><span>      * probe)=2E It does =
not belong to a session and must not create one=2E */</span><br><span>     =
VERDICT_VALID_OOB_V1,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /** as VERDICT_VALID_OOB_V1, with a wrapped client key appended (tls-=
crypt-v2) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    VER=
DICT_VALID_OOB_WKC_V1,</span><br><span>     /** the packet failed on of the=
 various checks */</span><br><span>     VERDICT_INVALID</span><br><span> };=
</span><br><span>@@ -270,10 +280,14 @@</span><br><span>  * @param tas      =
 standalone auth context providing the work buffer</span><br><span>  * @par=
am own_sid   session id to use as our session id in the header</span><br><s=
pan>  * @param payload   the OOB message payload (TLV stream) to wrap</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opcode    the O=
OB opcode to use: P_CONTROL_OOB_V1, or</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *                  P_CONTROL_OOB_WKC_V1 to append the t=
ls-crypt-v2 wrapped</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *                  client key (the context must then carry it)=2E</span><b=
r><span>  * @return          the wrapped packet buffer, ready to send</span=
><br><span>  */</span><br><span> struct buffer tls_wrap_oob_standalone(stru=
ct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                      stru=
ct session_id *own_sid, const struct buffer *payload);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                      st=
ruct session_id *own_sid, const struct buffer *payload,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                      i=
nt opcode);</span><br><span> </span><br><span> </span><br><span> /**</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_t=
ests/openvpn/test_pkt=2Ec</span><br><span>index ca3045a=2E=2E894ac4f 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -716,7 +71=
6,7 @@</span><br><span>      * bare payload, with none of the reliability/A=
CK fields a control packet</span><br><span>      * carries=2E */</span><br>=
<span>     struct buffer buf =3D</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        tls_wrap_oob_standalone(&amp;tas_client-&gt;tls_wrap, ta=
s_client, &amp;sid, &amp;payload);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        tls_wrap_oob_standalone(&amp;tas_client-&gt;tls_wrap=
, tas_client, &amp;sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span>  =
   assert_int_equal((BPTR(&amp;buf))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_=
OOB_V1);</span><br><span> </span><br><span>     /* Server side: the statele=
ss first-packet path must recognise the opcode,</span><br><span>@@ -802,6 +=
802,125 @@</span><br><span>     free_tas(&amp;tas_server);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* A matching tls-crypt-v2 server/client key pair (the client key&#39;s WK=
c was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wrapped wit=
h this server key), reused from the tls-crypt-v2 unit tests=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static const char *oob_v2_ser=
ver_key =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quo=
t;-----BEGIN OpenVPN tls-crypt-v2 server key-----\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0ODxAREhM=
UFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0x=
NTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----E=
ND OpenVPN tls-crypt-v2 server key-----\n&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static const char *oob_v2_client_key =3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN OpenVPN tls-crypt-v2 cl=
ient key-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4=
v\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;YGFiY2RlZmdo=
aWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;kJGSk5SVlpeYmZqbnJ2en6Ch=
oqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna=
29zd3t/g4eLj5OXm5+jp6uvs7e7v\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;8PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8=
a7r0mEWdXwbDadSV\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9t=
g4aw\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;zh2vheFqG=
MPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;j0TzJ3BVru9W3CpotdNt7=
u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozo=
D8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END=
 OpenVPN tls-crypt-v2 client key-----\n&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* End-to-end check of the tls-crypt-v2 out-of-band probe: the clie=
nt wraps an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OOB p=
ayload as a P_CONTROL_OOB_WKC_V1 message (the payload encrypted with the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * per-client key Kc, =
with the wrapped client key WKc appended), and the server&#39;s</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * stateless first-packet path =
(tls_pre_decrypt_lite) recovers Kc from the WKc,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * decrypts the payload, and returns VERDICT_V=
ALID_OOB_WKC_V1=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_o=
ob_wkc_v1_roundtrip(void **ut_state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   now =3D 0x5f000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct frame=
 frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* ---- Client: wrap an OOB pr=
obe as P_CONTROL_OOB_WKC_V1 (WKc appended) ---- */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_client =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_c=
lient=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Eopt=2Efla=
gs |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etl=
s_wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-CLIENT&quot;, 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Eworkbuf =3D alloc_b=
uf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_cl=
ient=2Etls_wrap=2Ework =3D alloc_buf(1600);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Load Kc and obtain the WKc, exactly as a tls-crypt-v2 client do=
es=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer wkc =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tls_crypt_v2_init_client_key(&amp;tas_client=2Etls_wrap=2Eopt=2Ekey_c=
tx_bi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                    &amp;tas_client=2Etls_wrap=2Eoriginal_wrap_keydata, &am=
p;wkc, oob_v2_client_key,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 true);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Etls_crypt_v2_wkc =3D =
&amp;wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t payload_byt=
es[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c, 0xde,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                      0xad, 0xbe=
, 0xef, 0x00, 0x11, 0x22 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer payload =3D alloc_buf(64);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;payload, payload_bytes=
, sizeof(payload_bytes));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct se=
ssion_id client_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;tas_clien=
t=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer probe =3D tls_wrap_oob_standalone(&amp;tas_client=2Etls_=
wrap, &amp;tas_client, &amp;client_sid,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                                  &amp;=
payload, P_CONTROL_OOB_WKC_V1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(BLEN(&amp;probe) &gt; 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal((BPTR(&amp;probe))[0=
] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* ---- Server: stateless path recovers Kc from the WKc and =
decrypts ---- */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct tls_auth_standalone tas_server =3D { 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tas_server=2Eframe =3D frame;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* No static wrapping, only=
 a tls-crypt-v2 server key (as a v2 server runs)=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Etls_wrap=2Emode =3D TLS=
_WRAP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_=
server=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LO=
NG_FORM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet=
_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-SERVE=
R&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls=
_crypt_v2_init_server_key(&amp;tas_server=2Etls_wrap=2Etls_crypt_v2_server_=
key, true, oob_v2_server_key,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                 true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tas_server=2Eworkbuf =3D alloc_buf(1600);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_actual from =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct b=
uffer srv =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_write(&amp;srv, BPTR(&amp;probe), BLEN(&amp;probe));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_decrypt_state state =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum =
first_packet_verdict verdict =3D tls_pre_decrypt_lite(&amp;tas_server, &amp=
;state, &amp;from, &amp;srv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(verdict, VERDICT_VALID_OOB_WKC_V1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* The decrypted payload must equal what th=
e client sent, and the client&#39;s</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * session id must be recovered=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;state=
=2Enewbuf), (int)sizeof(payload_bytes));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;state=2Enewbuf), pay=
load_bytes, sizeof(payload_bytes));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_memory_equal(state=2Epeer_session_id=2Eid, clien=
t_sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    free_tls_pre_decrypt_state(&amp;state);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Flipping any single byte (header, session id, ciphertext or =
WKc) must make</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* the probe fail to validate=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (size_t i =3D 0; i &lt; (size_t)BLEN(&amp;probe); i+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_pre_decrypt_=
state tstate =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        buf_reset_len(&amp;srv);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        buf_write(&amp;srv, BPTR(&amp;probe), BLEN(&amp;pr=
obe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (BPTR=
(&amp;srv))[i] ^=3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        enum first_packet_verdict v =3D tls_pre_decrypt_lite(&amp;tas=
_server, &amp;tstate, &amp;from, &amp;srv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        assert_int_equal(v, VERDICT_INVALID);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_tls_pre_decr=
ypt_state(&amp;tstate);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&amp;tas_=
client=2Etls_wrap=2Eopt=2Ekey_ctx_bi);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epa=
cket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_b=
uf(&amp;wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fr=
ee_buf(&amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    free_buf(&amp;tas_client=2Eworkbuf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=2Etls_wrap=2Ework);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;tas_server=2Etls_wr=
ap=2Etls_crypt_v2_server_key);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;=
tas_server=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&am=
p;srv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void<=
/span><br><span> test_extract_control_message(void **ut_state)</span><br><s=
pan> {</span><br><span>@@ -855,6 +974,7 @@</span><br><span>         cmocka_=
unit_test(test_oob_standalone_plain),</span><br><span>         cmocka_unit_=
test(test_oob_standalone_tls_auth),</span><br><span>         cmocka_unit_te=
st(test_oob_standalone_tls_crypt),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_oob_wkc_v1_roundtrip),</span><=
br><span>         cmocka_unit_test(test_extract_control_message)</span><br>=
<span>     };</span><br><span> </span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Dema=
il">change 1758</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
758?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1758 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--nryJho1E6o0=--


--===============0082211376365536324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0082211376365536324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0082211376365536324==--

