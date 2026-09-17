Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C04DC982D6
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFrKu4eOaZP+HIOXgQ+YNLHFfs4XZK1Zj9GfI264DYU=; b=YPPHyfnfkc70injehv47468vyG
	0BdBYVEpy02Z/DeBBBAIcx39lq/FTlTyn504ts1+sq0cd3rbon9gjE/H2/XKgm9aW0sfwJv8eIqzk
	tiwd6zeMImPswKhnJI+64jolsVC8gF+GQLUcjg5RKzDP/lJuvuvN+hXb/tEOSu6MP+fg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767t-0007Zq-PY;
	Thu, 17 Sep 2026 07:01:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767r-0007Zd-TI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zhn1gvQchAC/0z494e320rzdThOvpYpDBYxTWPkC32Y=; b=C9fgw4flFLn4+P6+USJY179s6t
 VzsPh7qX5o6T/iiUbjDRoRWSIdBBqlZ5H9VqzaH5LqDiz4/aUc2Ru5eeef4mLlzY8ZSFnvGp5u5ir
 9H6+XOdw/7SyN0bgJlBqwEebcqVTcTqKB+EQNGorqN1DZkhKgv/2lWw6412QLVuYCmwc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zhn1gvQchAC/0z494e320rzdThOvpYpDBYxTWPkC32Y=; b=Q
 Fil/AdqGPU3XVfPa2xUDMq6N9Xvdhy8H2379apW0nZ2vnGdjnxag61d2Yc6t00cLhihHae3eWdb+o
 DfYjC2SniRwyF+y5arCpGEZDolpG5Jde38JBUF24qPE8TOUvBIHZNz9WCBYpbHpr9jMRquGjqM+8A
 DNXJ+gG2nfUVxCpY=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767n-0006nQ-4h for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:41 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so3189455e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628493; x=1790233293; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zhn1gvQchAC/0z494e320rzdThOvpYpDBYxTWPkC32Y=;
 b=eRATev5Mf3NFlafsLhDqs6DGScVPoNbVIseZ5HwTEM17lj+lMttBzILKJ+03lZr2SK
 x0XiMzIXMPJll/OF4sJu9sTrSSwmXnOj/RweA+xC15BC0PaI1KpL0+jTanZjB5tk48vs
 BJ/CyG1dTuwvX3ucfhbpLahKh4XIOeQ7NKxdEzx+fqM6NYX2NW9DsgMR0kn8186RVreN
 yzDAOtsIZHejWa5YVOyqfHcHvq+3dOcWlWQgJU/A+8YUqKMXGD2ODhvx1ky6oR9FUMh+
 XadJlVvGhaeu9qHdRjzL3t9B7E33aYNel8ZJsxA3XXAs58VUn6f0N8lH4n6Q1Eq/K/2s
 pU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628493; x=1790233293;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zhn1gvQchAC/0z494e320rzdThOvpYpDBYxTWPkC32Y=;
 b=UCQ5d4THyZR3wxyIBXlBBAgkbsb714UitSRyd8XW1zL4O41lsuN7qBAJtXYiRBNnHd
 M8VdHZ29icLrE5/M8CghhSe2N9scbFOFocPy7a7oLa/CNTfqvG67vZdfo8XfFlM8GBt2
 CVGo9vFjaCZO0cp+ZDwE7IXNh9lo+HHNveu1Snl2o1LuYM8B3iXOHU/P8huFSTrUIjtm
 +hfAvQZ8VdRec8jte/nURoRwaQ38++4wvFBtjr/oTGopiC7r1jdKyrICz+GOmKmUsO45
 almJLnu0SPeSP5YvIrj9bNb1IAeNR64f6mAzwFI4zjwSC5Lt3Sc/KV996S4TyIV/j3pQ
 FpFA==
X-Gm-Message-State: AFuF++kEUN4wPEsvJ/H6RqpWU2TqC5YR2P3ayx+tKaJMz9OsU3Gj0mG+
 lhEfWpzfDvPwlUCslf0bvoM2Bje2FvO3vwFl2WLx4GHPcRoYm5WID+1RQoavv7stAt5lBs7u0uw
 rbfPulTSe0TurkdVfzIZ9T0KeSUkNzJwpHUYyEBtkW4NcDxR6TglBoyKwQRtK6eW3AmU7G2SSHP
 AMFiLs7w==
X-Gm-Gg: AYBFou0f0foXHVkWaZSxSZl842SnLjUhD+jWORrcRfplbmeML6m/QutkKGaatCCv577
 GXzHHPAIwZFjpyWCJrK7Li6oz6I9RemBhOPKcEERmPMJD09GNIfSbYgklivhmF8brkETccNdLRb
 rtuwsRW6b/4OZ14DKuHeGMQi+Qoz5yrkJnph27+v53gaHGt8RdV4ybBezDX0D4+yYjqVkmDFEh9
 KpvRrHzFAEeCCcff3FnBcxBeJjIBBBdKdDWM1Sw6PXI/bfAariS3pvUmD54qL00eQ5xx0yg8egN
 BybknKR7ue1YOcWJlZ+kfMCn3m/e5deHxI6ewp1ovgR25/rn6USEJ5M/Ogw2z+efTwwEhs+Vfl3
 kbxJBzDnhis9x6fMcmh8AEykEmmYjxoy4WubDFtN5siZbOjmeTXDxfcHF0kYIyZ3aaFtbWWcCcI
 6jQ3ib/fuvZ1t0Ri5TorNGdbzkLMnTrYg39PW7g7cn6nKj17/6dict22A5ExBt9+r8PfOFrDUeQ
 kbbYCACtZOwrJHIlGR5GOllWHciYxAX4a5A0nRUydOlBh6+7vjV/dq2UONubQ5+lJbHsC/kB0i7
 bZViYYcNM3RJeF+h/i4uVPj2yMt3xfEGh/BBUGWN1kO92yH/XleQVV9ikZC9zg==
X-Received: by 2002:a05:600c:1551:b0:49c:f512:2361 with SMTP id
 5b1f17b1804b1-49eb733721dmr98018945e9.14.1789628492330; 
 Thu, 17 Sep 2026 00:01:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f98csm12330756f8f.11.2026.09.17.00.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:31 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 7d5fc1ca55f0bc7c51ad1ac00b94c1af84c1a848
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9afbdf43e462466989cd31434c115ccc8e82de6f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767n-0006nQ-4h
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
Content-Type: multipart/mixed; boundary="===============0419393230039012728=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0419393230039012728==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uttSsmXatng="; charset=UTF-8

--uttSsmXatng=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1758?usp=3Demail

to look at the new patch set (#23)=2E
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
n=2Enet:29418/openvpn refs/changes/58/1758/23

diff --git a/src/openvpn/mud=
p=2Ec b/src/openvpn/mudp=2Ec
index 2ef642a=2E=2Ea460634 100644
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
 
@@ -144,7 +149,7 @@
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
@@ -242,7 +247,7 @@=

 
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
index de00c04=2E=2Edd3d0a6 100644
--- a/s=
rc/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -716,7 +716,8=
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
index 8e78444=
=2E=2Eccbb728 100644
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
@@ -200,7 +201,8 @@
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
@@ -391,10 +393,16 @@
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
@@ -451,=
8 +459,10 @@
 
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
3,10 +473,11 @@
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
index a7dc6d9=2E=2E22d1cb9 100644
--- a/=
src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -63,17 +63,25 @@
 =
 * in do_pre_decrypt_check(), never handled by tls_pre_decrypt()=2E */
 #de=
fine P_CONTROL_OOB_V1 12
 
+/* Variant of P_CONTROL_OOB_V1 with an appended=
 wrapped client key (WKc), like
+ * P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONT=
ROL_WKC_V1=2E Used when tls-crypt-v2 is
+ * configured: an out-of-band mess=
age belongs to no established session, so the
+ * client must carry the WKc=
 for the server to recover the per-client key and
+ * unwrap the message=2E=
 See doc/tls-crypt-v2=2Etxt and the openvpn-rfc wire
+ * protocol (CONTROL_=
OOB_WKC_V1)=2E */
+#define P_CONTROL_OOB_WKC_V1 13
+
 /* define the range o=
f defined opcodes, in- and out-of-band
  * Since we do no longer support ke=
y-method 1 we consider
  * the v1 op codes invalid */
 #define P_FIRST_OPCO=
DE 3
-#define P_LAST_OPCODE  12
+#define P_LAST_OPCODE  13
 
 /* the out-of=
-band opcodes, which carry no reliability header */
 static inline bool
 op=
code_is_oob(int op)
 {
-    return op =3D=3D P_CONTROL_OOB_V1;
+    return =
op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;
 }
 
 /*
@@ -=
109,6 +117,8 @@
     /** This packet is a valid out-of-band control message=
 (e=2Eg=2E a server
      * probe)=2E It does not belong to a session and m=
ust not create one=2E */
     VERDICT_VALID_OOB_V1,
+    /** as VERDICT_VAL=
ID_OOB_V1, with a wrapped client key appended (tls-crypt-v2) */
+    VERDIC=
T_VALID_OOB_WKC_V1,
     /** the packet failed on of the various checks */
=
     VERDICT_INVALID
 };
@@ -239,10 +249,14 @@
  * @param tas       standal=
one auth context providing the work buffer
  * @param own_sid   session id =
to use as our session id in the header
  * @param payload   the OOB message=
 payload (TLV stream) to wrap
+ * @param opcode    the OOB opcode to use: P=
_CONTROL_OOB_V1, or
+ *                  P_CONTROL_OOB_WKC_V1 to append the=
 tls-crypt-v2 wrapped
+ *                  client key (the context must the=
n carry it)=2E
  * @return          the wrapped packet buffer, ready to sen=
d
  */
 struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, str=
uct tls_auth_standalone *tas,
-                                      struct=
 session_id *own_sid, const struct buffer *payload);
+                     =
                 struct session_id *own_sid, const struct buffer *payload,
=
+                                      int opcode);
 
 
 /**
diff --git a/t=
ests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2E=
c
index ca3045a=2E=2E894ac4f 100644
--- a/tests/unit_tests/openvpn/test_pkt=
=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -716,7 +716,7 @@
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
@@ -802,6 +802,125 @@
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
@@ -855,6 +974,7=
 @@
         cmocka_unit_test(test_oob_standalone_plain),
         cmocka_u=
nit_test(test_oob_standalone_tls_auth),
         cmocka_unit_test(test_oob_=
standalone_tls_crypt),
+        cmocka_unit_test(test_oob_wkc_v1_roundtrip)=
,
         cmocka_unit_test(test_extract_control_message)
     };
 

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb8c0c660a98de8ec549b69=
f6692a7b41b092eaf
Gerrit-Change-Number: 1758
Gerrit-PatchSet: 23
Gerrit-Own=
er: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--uttSsmXatng=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #23</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
n refs/changes/58/1758/23</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec</span><br><span>index 2ef642a=2E=2Ea460634 100644</span><br=
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
an> </span><br><span>@@ -144,7 +149,7 @@</span><br><span>     int handwindo=
w =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><=
span>     if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDI=
CT_VALID_RESET_V2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    || verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        || verdict =3D=3D VERDICT_VALID_OOB_V1 || v=
erdict =3D=3D VERDICT_VALID_OOB_WKC_V1)</span><br><span>     {</span><br><s=
pan>         /* Check if we are still below our limit for sending out</span=
><br><span>          * responses */</span><br><span>@@ -242,7 +247,7 @@</sp=
an><br><span> </span><br><span>         return ret;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (verdict =
=3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1 || verdict =3D=3D=
 VERDICT_VALID_OOB_WKC_V1)</span><br><span>     {</span><br><span>         =
/* Out-of-band server probe=2E state-&gt;newbuf points at the TLV payload</=
span><br><span>          * (read_control_auth has stripped the opcode, sess=
ion id and any</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec</span><br><span>index de00c04=2E=2Edd3d0a6 100644<=
/span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/=
openvpn/oob_client=2Ec</span><br><span>@@ -716,7 +716,8 @@</span><br><span>=
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
ndex 8e78444=2E=2Eccbb728 100644</span><br><span>--- a/src/openvpn/ssl_pkt=
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
            {</span><br><span>@@ -200,7 +201,8 @@</span><br><span>     bool=
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
91,10 +393,16 @@</span><br><span>     {</span><br><span>         return VER=
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
return VERDICT_VALID_RESET_V2;</span><br><span>@@ -451,8 +459,10 @@</span><=
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
/</span><br><span>@@ -463,10 +473,11 @@</span><br><span>      * or ACK fiel=
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
/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index a7dc6d=
9=2E=2E22d1cb9 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><=
br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -63,17 +63,25 @@<=
/span><br><span>  * in do_pre_decrypt_check(), never handled by tls_pre_dec=
rypt()=2E */</span><br><span> #define P_CONTROL_OOB_V1 12</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Variant of P_CON=
TROL_OOB_V1 with an appended wrapped client key (WKc), like</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * P_CONTROL_HARD_RESET_CLIENT_V3 /=
 P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * configured: an out-of-band message belongs to=
 no established session, so the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * client must carry the WKc for the server to recover the per-=
client key and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * un=
wrap the message=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc wire</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocol (CONTROL_OO=
B_WKC_V1)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine P_CONTROL_OOB_WKC_V1 13</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /* define the range of defined opcodes, in- and o=
ut-of-band</span><br><span>  * Since we do no longer support key-method 1 w=
e consider</span><br><span>  * the v1 op codes invalid */</span><br><span> =
#define P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define P_LAST_OPCODE  12</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define P_LAST_OPCODE  13</span><br><span> </span><br><span> /* th=
e out-of-band opcodes, which carry no reliability header */</span><br><span=
> static inline bool</span><br><span> opcode_is_oob(int op)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return op =3D=
=3D P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;<=
/span><br><span> }</span><br><span> </span><br><span> /*</span><br><span>@@=
 -109,6 +117,8 @@</span><br><span>     /** This packet is a valid out-of-ba=
nd control message (e=2Eg=2E a server</span><br><span>      * probe)=2E It =
does not belong to a session and must not create one=2E */</span><br><span>=
     VERDICT_VALID_OOB_V1,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /** as VERDICT_VALID_OOB_V1, with a wrapped client key appended =
(tls-crypt-v2) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  VERDICT_VALID_OOB_WKC_V1,</span><br><span>     /** the packet failed on o=
f the various checks */</span><br><span>     VERDICT_INVALID</span><br><spa=
n> };</span><br><span>@@ -239,10 +249,14 @@</span><br><span>  * @param tas =
      standalone auth context providing the work buffer</span><br><span>  *=
 @param own_sid   session id to use as our session id in the header</span><=
br><span>  * @param payload   the OOB message payload (TLV stream) to wrap<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opcode    =
the OOB opcode to use: P_CONTROL_OOB_V1, or</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *                  P_CONTROL_OOB_WKC_V1 to append =
the tls-crypt-v2 wrapped</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *                  client key (the context must then carry it)=2E</sp=
an><br><span>  * @return          the wrapped packet buffer, ready to send<=
/span><br><span>  */</span><br><span> struct buffer tls_wrap_oob_standalone=
(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
 struct session_id *own_sid, const struct buffer *payload);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
   struct session_id *own_sid, const struct buffer *payload,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
    int opcode);</span><br><span> </span><br><span> </span><br><span> /**</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/u=
nit_tests/openvpn/test_pkt=2Ec</span><br><span>index ca3045a=2E=2E894ac4f 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -716,=
7 +716,7 @@</span><br><span>      * bare payload, with none of the reliabil=
ity/ACK fields a control packet</span><br><span>      * carries=2E */</span=
><br><span>     struct buffer buf =3D</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        tls_wrap_oob_standalone(&amp;tas_client-&gt;tls_wra=
p, tas_client, &amp;sid, &amp;payload);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;tas_client-&gt;tls=
_wrap, tas_client, &amp;sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><sp=
an>     assert_int_equal((BPTR(&amp;buf))[0] &gt;&gt; P_OPCODE_SHIFT, P_CON=
TROL_OOB_V1);</span><br><span> </span><br><span>     /* Server side: the st=
ateless first-packet path must recognise the opcode,</span><br><span>@@ -80=
2,6 +802,125 @@</span><br><span>     free_tas(&amp;tas_server);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* A matching tls-crypt-v2 server/client key pair (the client key&#39=
;s WKc was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wrappe=
d with this server key), reused from the tls-crypt-v2 unit tests=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *oob_v=
2_server_key =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;-----BEGIN OpenVPN tls-crypt-v2 server key-----\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0ODx=
AREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSE=
lKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-=
----END OpenVPN tls-crypt-v2 server key-----\n&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static const char *oob_v2_client_key =3D</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN OpenVPN tls-crypt-=
v2 client key-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKi=
ssLS4v\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;YGFiY2R=
lZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;kJGSk5SVlpeYmZqbnJ2=
en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;wMHCw8TFxsfIycrLzM3Oz9DR0tPU1db=
X2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;8PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmz=
PJPM8a7r0mEWdXwbDadSV\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTy=
XsM9tg4aw\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;zh2v=
heFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;j0TzJ3BVru9W3Cpo=
tdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;RZ+q17SC4nba3Pp8/Fs0+hSbv2tJ=
ozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----=
END OpenVPN tls-crypt-v2 client key-----\n&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* End-to-end check of the tls-crypt-v2 out-of-band probe: the c=
lient wraps an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OO=
B payload as a P_CONTROL_OOB_WKC_V1 message (the payload encrypted with the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * per-client key K=
c, with the wrapped client key WKc appended), and the server&#39;s</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * stateless first-packet pa=
th (tls_pre_decrypt_lite) recovers Kc from the WKc,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * decrypts the payload, and returns VERD=
ICT_VALID_OOB_WKC_V1=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_oob_wkc_v1_roundtrip(void **ut_state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    now =3D 0x5f000000;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 140=
0 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* ---- Client: wrap an O=
OB probe as P_CONTROL_OOB_WKC_V1 (WKc appended) ---- */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_clie=
nt =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ta=
s_client=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Eopt=2E=
flags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=
=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-CLIENT&quot;, 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Eworkbuf =3D al=
loc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
as_client=2Etls_wrap=2Ework =3D alloc_buf(1600);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Load Kc and obtain the WKc, exactly as a tls-crypt-v2 clie=
nt does=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer wkc =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    tls_crypt_v2_init_client_key(&amp;tas_client=2Etls_wrap=2Eopt=2E=
key_ctx_bi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                         &amp;tas_client=2Etls_wrap=2Eoriginal_wrap_keydata=
, &amp;wkc, oob_v2_client_key,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                 true);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Etls_crypt_v2_wkc=
 =3D &amp;wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t payloa=
d_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c, 0xde,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                      0xa=
d, 0xbe, 0xef, 0x00, 0x11, 0x22 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer payload =3D alloc_buf(64);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;payload, payload=
_bytes, sizeof(payload_bytes));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id client_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;tas=
_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer probe =3D tls_wrap_oob_standalone(&amp;tas_client=
=2Etls_wrap, &amp;tas_client, &amp;client_sid,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                                =
  &amp;payload, P_CONTROL_OOB_WKC_V1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(BLEN(&amp;probe) &gt; 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal((BPTR(&amp;pr=
obe))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* ---- Server: stateless path recovers Kc from the W=
Kc and decrypts ---- */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct tls_auth_standalone tas_server =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eframe =3D frame;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* No static wrappin=
g, only a tls-crypt-v2 server key (as a v2 server runs)=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Etls_wrap=2Emode =
=3D TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tas_server=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKE=
T_ID_LONG_FORM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 packet_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;U=
T-SERVER&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    tls_crypt_v2_init_server_key(&amp;tas_server=2Etls_wrap=2Etls_crypt_v2_=
server_key, true, oob_v2_server_key,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                 true);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eworkbuf =3D alloc_buf=
(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_actual f=
rom =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer srv =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buf_write(&amp;srv, BPTR(&amp;probe), BLEN(&amp;probe=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_decrypt_state st=
ate =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
num first_packet_verdict verdict =3D tls_pre_decrypt_lite(&amp;tas_server, =
&amp;state, &amp;from, &amp;srv);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(verdict, VERDICT_VALID_OOB_WKC_V1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* The decrypted payload must equal w=
hat the client sent, and the client&#39;s</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * session id must be recovered=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
state=2Enewbuf), (int)sizeof(payload_bytes));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;state=2Enewbuf)=
, payload_bytes, sizeof(payload_bytes));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_memory_equal(state=2Epeer_session_id=2Eid, =
client_sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Flipping any single byte (header, session id, ciphert=
ext or WKc) must make</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * the probe fail to validate=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; (size_t)BLEN(&amp;pro=
be); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_pre_d=
ecrypt_state tstate =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_reset_len(&amp;srv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        buf_write(&amp;srv, BPTR(&amp;probe), BLEN(=
&amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  (BPTR(&amp;srv))[i] ^=3D 0xff;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        enum first_packet_verdict v =3D tls_pre_decrypt_lite(&=
amp;tas_server, &amp;tstate, &amp;from, &amp;srv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        assert_int_equal(v, VERDICT_INVALID)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_tls_p=
re_decrypt_state(&amp;tstate);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&a=
mp;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eo=
pt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free_buf(&amp;wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free_buf(&amp;payload);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free_buf(&amp;tas_client=2Eworkbuf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=2Etls_wrap=2Ewor=
k);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;tas_server=2E=
tls_wrap=2Etls_crypt_v2_server_key);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epack=
et_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf=
(&amp;tas_server=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_b=
uf(&amp;srv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 void</span><br><span> test_extract_control_message(void **ut_state)</span>=
<br><span> {</span><br><span>@@ -855,6 +974,7 @@</span><br><span>         c=
mocka_unit_test(test_oob_standalone_plain),</span><br><span>         cmocka=
_unit_test(test_oob_standalone_tls_auth),</span><br><span>         cmocka_u=
nit_test(test_oob_standalone_tls_crypt),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_oob_wkc_v1_roundtrip),</=
span><br><span>         cmocka_unit_test(test_extract_control_message)</spa=
n><br><span>     };</span><br><span> </span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=
=3Demail">change 1758</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1758?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1758 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--uttSsmXatng=--


--===============0419393230039012728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0419393230039012728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0419393230039012728==--

