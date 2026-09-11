Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A455BC88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cFnpefZPfPGtlUKnqHSUcmgdSvx0V4iU1+O9hfJ3Mp4=; b=ABoLhXvsagZS33zNgJvg7imySD
	A16808cP5Mq14T0SP1VgiLurJFLz8vhqSmPOBrtM+RzXm6qz9uvNq1cKF7kQtl1MRr9QlqLVuB2ZA
	/Kz0yX4i2BzLjEdFfL9MHLUueve/idjpzkrKkQBkJSrWMhVE0386M09jPYcWEkwDu21g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIJ-0004iT-3f;
	Fri, 11 Sep 2026 09:11:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xIB-0004hw-Fo
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Yl+XrERZihWwnaMCdaf8rVK8gVF3z424rAbd/x2GCD8=; b=kxlt+Qha8VzN6ZV3MzvpFiI3L6
 104au+P3+vfexd6iHr/UYA7l5FewZkqjb/27++DVMg3e/oD2jgpSDArXnsuY0FjAKcTAtiT354+na
 qxlO+9VEBwnOzNkc96HxGIUV4KBsuH3qiUw+Zo2vJSIOccs7dRM9f7n31AYnxjzQKiZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Yl+XrERZihWwnaMCdaf8rVK8gVF3z424rAbd/x2GCD8=; b=L
 RMNOTrDQ6/QP/BR8HPqPu3kLfJy4m/qZ/V0oxsi7Dl+rIm0oq+iLDUXfKFdlekQeHnqBeiREy7xsv
 UHtL/tWARLbHDwqgWgat8po1Y/MVFDwwqNwnBHWeJVSmTCumNpH2F1vtHoQbcdnaSp0uWoad0VwbI
 0O7gd0cSej9b0LXw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xI6-0008Cs-Ph for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:28 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-485850cf499so511976f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117880; x=1789722680; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yl+XrERZihWwnaMCdaf8rVK8gVF3z424rAbd/x2GCD8=;
 b=crRsZhCswVZ4II0irkjBBnvaCu9RQFd6ZNS+Pb3F4nPZq7OdnzUtyiPD7w10MYJppB
 2Ioy789XpK8fwRvDKG4EW90i5DewEktKY8BYB8yJjbGaqV7oxblevkbUAdhHMJPd7Eqi
 3QduF1Fe61gwc4dnuIdjvR1Bkc14nPfDpp7wZj/0gExCgAau1xe7u1d3/5qMjZvDUIKG
 AS0g506TFFrsRLGrt7CLK4DnGNe7ub3rnXGoD284Zsr27d41Bj2mzChIErVJcpeQkchU
 47YaJlakmrrJxbKO/hegRlDVbAL8a3JkN3Ms5bYgYMejZOnZeYgR5VLPlvtuSEO9BSx6
 DZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117880; x=1789722680;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yl+XrERZihWwnaMCdaf8rVK8gVF3z424rAbd/x2GCD8=;
 b=XHO06y9v9KnyWMfyvnDJtdINSMdZn6atVIAuNqfaXswF//3LE82KTEhBOfDvM9PDmC
 Vf49as36h+4lW7QUGlRzf2PtRUk675Fg44Vp5HhbriRRDFW41c6Z8kth5zA0vsVCAztl
 diLtrTANbXqy273Jkk5VXP1IpuXic/Rh+0WIVv7tNyjlvBN90PMtjiBpf0VqQenZzj9o
 bprH/PbERyAYVyfaLxcmksHTJ+QL+zMAypWJ1WQbDCfJ2/7noV14MpKJXmc2thcchQUi
 BEUzSnuIk9f8ILxacFG8zV1QcroyMHjP/Q90RNSo4rMomzlnqmiI8lH7mmtJku3A3ya4
 32kg==
X-Gm-Message-State: AFuF++mCjILy/1LM7h607s/NBSdwqaopeSjCjrtHKURi9ZF2nefNSOtG
 Ce7A+xpn79I1ulQue+SEGnAIaJj6W/ZvYcA28KxLMjSKHjPYy37uN/wnHGvh00gZ/XneQxwYLmN
 hk61uD7q0P5bSxqd1G+Ftc1fvMdMKEQwNHx+Oav66ZCyE50kynIyn/duZAVP8K5UFfNJjcfeAb7
 4z1KTxvQ==
X-Gm-Gg: AYBFou0c2DtBrc7ASp81R00F2kdtuLQaNjy74sRPtvFbZcP0mtxiIRRqvhxvkUiP3/4
 2DA4FIypgo2G516kO3CcTXVYPCPsl9gnf6hmvPg4z/ySfbbbPtS+y9tBN9Z9217Y1/o2wkK7nFu
 MlWZsbKn90ueb8G9XZJHZVnEj8qKamBMejLLE46YJiepq58lzZRMpBCJBeXWCq8E2MBqxXp4GiV
 xIlrkE0zqg4iY3V0JQcLcDhLU8pp3tF2Tp6vsRj512J6Jd97dP03EO/IiT8mQUoIn4CGc4ZPSx7
 OitnjsrFMwz72+dFh6XbUVWbYzdd9aRbw6cIB/SNarxYfwOK+WClxrwNuR0Htm0yXFSA22JyIIV
 qcShqHvP/cz/MTMj8MasOeUtEemduogyShMN9VqTDzPZdWVobppon8r7qnqdDdDjrm/OmZpTe6a
 QZpevKpfp/CtjUj9MlmN3CcOCEtumeBSVixlQEy0Xn7yy+POeuzkBcufpNB0lIqOUQ6j2Aaj7os
 WkIBg9nPSysvCZIt4LZC9b5hWNxc2uVX3BYE/gpJrqtYCxGMIH3ncauhGhTv+B85uoOm9eYGusN
 hdGESumQqDBOZbgXTJsEjTeB5pof+H7QGvVIvoGGqMHZcNuddPDQCNml+rKB4e8=
X-Received: by 2002:a05:6000:1868:b0:485:8ad5:fc38 with SMTP id
 ffacd0b85a97d-486eb1d5cfbmr3762356f8f.19.1789117879708; 
 Fri, 11 Sep 2026 02:11:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb3602eesm4287229f8f.34.2026.09.11.02.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:19 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: af99e3a2a3d9e6062ceba73202f06373bda305cc
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c4c29648033d766c061ec14e894890ac4c77058-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xI6-0008Cs-Ph
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
Content-Type: multipart/mixed; boundary="===============2770587940949923144=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2770587940949923144==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ExxJjR9u5tM="; charset=UTF-8

--ExxJjR9u5tM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1758?usp=3Demail

to look at the new patch set (#17)=2E
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
    the WKc appended, mirroring CONTROL_HARD_RESET_CLIENT_V3/CONTRO=
L_WKC_V1
  - tls_wrap_control() appends the WKc for opcode 13; read_control=
_auth()
    runs tls_crypt_v2_extract_client_key() for it, loading the per-=
client
    key before unwrapping the message
  - tls_pre_decrypt_lite() ret=
urns the new VERDICT_VALID_OOB_WKC_V1, one
    verdict per opcode as elsewh=
ere in the enum; do_pre_decrypt_check()
    groups it with VERDICT_VALID_OO=
B_V1 and derives the resend-WKc reply
    flag from it
  - P_LAST_OPCODE be=
comes 13 and opcode_is_oob() covers both OOB opcodes
  - tls_wrap_oob_stand=
alone() takes the opcode; the server reply stays a
    plain P_CONTROL_OOB_=
V1 (the server already holds the key after unwrap)
  - test_pkt: round-trip=
 test of the wrap/extract/unwrap path

The client still sends plain probes;=
 sending P_CONTROL_OOB_WKC_V1 is added
in a following commit=2E

Change-Id:=
 Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
Signed-off-by: Lev Stipakov <lev=
@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/oob_client=2Ec
M s=
rc/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn=
/test_pkt=2Ec
5 files changed, 165 insertions(+), 14 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1758/17

dif=
f --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 1061f95=2E=2E43=
aa732 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -109,=
7 +109,12 @@
     reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_=
id=2Esend);
     state->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =
=3D true;
 
-    struct buffer buf =3D tls_wrap_oob_standalone(&state->tls_=
wrap_tmp, tas, own_sid, &payload);
+    /* The reply carries no WKc: with t=
ls-crypt-v2 the server has already
+     * recovered the per-client key fro=
m the request's WKc (it is loaded into
+     * state->tls_wrap_tmp), so the=
 reply is wrapped with that key as a plain
+     * P_CONTROL_OOB_V1 message=
=2E */
+    struct buffer buf =3D
+        tls_wrap_oob_standalone(&state->=
tls_wrap_tmp, tas, own_sid, &payload, P_CONTROL_OOB_V1);
     send_standalo=
ne_reply(m, &buf, "Server Probe", "Server probe from client, sending probe =
reply",
                           sock);
 
@@ -135,7 +140,7 @@
     int ha=
ndwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
     if (verdict =3D=3D=
 VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2
-        |=
| verdict =3D=3D VERDICT_VALID_OOB_V1)
+        || verdict =3D=3D VERDICT_V=
ALID_OOB_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)
     {
         /* =
Check if we are still below our limit for sending out
          * responses=
 */
@@ -233,7 +238,7 @@
 
         return ret;
     }
-    else if (verdict=
 =3D=3D VERDICT_VALID_OOB_V1)
+    else if (verdict =3D=3D VERDICT_VALID_OO=
B_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)
     {
         /* Out-of-=
band server probe=2E state->newbuf points at the TLV payload
          * (r=
ead_control_auth has stripped the opcode, session id and any
diff --git a/s=
rc/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 9690d0e=2E=2E7=
d429f0 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=
=2Ec
@@ -596,7 +596,8 @@
         return;
     }
 
-    struct buffer probe=
 =3D tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload);
+=
    struct buffer probe =3D
+        tls_wrap_oob_standalone(&tas->tls_wrap=
, tas, &client_sid, &payload, P_CONTROL_OOB_V1);
     if (!BLEN(&probe))
  =
   {
         msg(D_LOW, "server-probe: could not wrap probe packet; using =
configured order");
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_=
pkt=2Ec
index 78552c4=2E=2E614d599 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++=
 b/src/openvpn/ssl_pkt=2Ec
@@ -145,7 +145,8 @@
         }
 
         if ((h=
eader >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
-           =
 || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)
+            || (he=
ader >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1
+            || (header >> =
P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)
         {
             if (!b=
uf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
             {
@@ -199,7 +200,8=
 @@
     bool ret =3D false;
 
     const uint8_t opcode =3D *(BPTR(buf)) >=
> P_OPCODE_SHIFT;
-    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 ||=
 opcode =3D=3D P_CONTROL_WKC_V1)
+    if ((opcode =3D=3D P_CONTROL_HARD_RES=
ET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1
+         || opcode =3D=3D P=
_CONTROL_OOB_WKC_V1)
         && !tls_crypt_v2_extract_client_key(buf, ctx,=
 opt))
     {
         msg(D_TLS_ERRORS, "TLS Error: can not extract tls-cr=
ypt-v2 client key from %s",
@@ -390,10 +392,16 @@
     {
         return VE=
RDICT_VALID_WKC_V1;
     }
-    else if (opcode_is_oob(op))
+    else if (o=
p =3D=3D P_CONTROL_OOB_V1)
     {
         return VERDICT_VALID_OOB_V1;
   =
  }
+    else if (op =3D=3D P_CONTROL_OOB_WKC_V1)
+    {
+        /* The WK=
c was unwrapped by read_control_auth() above, so the per-client
+         *=
 key is already loaded into state->tls_wrap_tmp=2E */
+        return VERDI=
CT_VALID_OOB_WKC_V1;
+    }
     else
     {
         return VERDICT_VALID_=
RESET_V2;
@@ -450,8 +458,10 @@
 
 struct buffer
 tls_wrap_oob_standalone(st=
ruct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                 =
       struct session_id *own_sid, const struct buffer *payload)
+         =
               struct session_id *own_sid, const struct buffer *payload, in=
t opcode)
 {
+    ASSERT(opcode_is_oob(opcode));
+
     /* Copy buffer here=
 to point at the same data but allow tls_wrap_control
      * to potentiall=
y change buf to point to another buffer without
      * modifying the buffe=
r in tas */
@@ -462,10 +472,11 @@
      * or ACK fields=2E */
     ASSERT(b=
uf_copy(&buf, payload));
 
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_=
V1 << P_OPCODE_SHIFT);
+    uint8_t header =3D (uint8_t)(opcode << P_OPCODE=
_SHIFT);
 
     /* Add tls-auth/tls-crypt wrapping, this might replace buf =
with
-     * ctx->work */
+     * ctx->work=2E For P_CONTROL_OOB_WKC_V1 the=
 wrapped client key is appended
+     * here too (tls-crypt-v2)=2E */
     =
tls_wrap_control(ctx, header, &buf, own_sid);
 
     return buf;
diff --git=
 a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 581ec48=2E=2E89e=
9619 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ =
-67,18 +67,26 @@
  * legal on an established session; see opcode_valid_in_s=
ession() below=2E */
 #define P_CONTROL_OOB_V1 12
 
+/* Variant of P_CONTRO=
L_OOB_V1 with an appended wrapped client key (WKc), like
+ * P_CONTROL_HARD=
_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is
+ * config=
ured: an out-of-band message belongs to no established session, so the
+ * =
client must carry the WKc for the server to recover the per-client key and
=
+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc wi=
re
+ * protocol (CONTROL_OOB_WKC_V1)=2E */
+#define P_CONTROL_OOB_WKC_V1 13=

+
 /* define the range of defined opcodes, in- and out-of-band=2E Note thi=
s is not
  * the set of opcodes legal on an established session; see
  * op=
code_valid_in_session()=2E
  * Since we do no longer support key-method 1 w=
e consider
  * the v1 op codes invalid */
 #define P_FIRST_OPCODE 3
-#defin=
e P_LAST_OPCODE  12
+#define P_LAST_OPCODE  13
 
 static inline bool
 opcod=
e_is_oob(int op)
 {
-    return op =3D=3D P_CONTROL_OOB_V1;
+    return op =
=3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1;
 }
 
 /**
@@ -14=
0,6 +148,8 @@
     /** This packet is a valid out-of-band control message (=
e=2Eg=2E a server
      * probe)=2E It does not belong to a session and mus=
t not create one=2E */
     VERDICT_VALID_OOB_V1,
+    /** as VERDICT_VALID=
_OOB_V1, with a wrapped client key appended (tls-crypt-v2) */
+    VERDICT_=
VALID_OOB_WKC_V1,
     /** the packet failed on of the various checks */
  =
   VERDICT_INVALID
 };
@@ -270,10 +280,14 @@
  * @param tas       standalon=
e auth context providing the work buffer
  * @param own_sid   session id to=
 use as our session id in the header
  * @param payload   the OOB message p=
ayload (TLV stream) to wrap
+ * @param opcode    the OOB opcode to use: P_C=
ONTROL_OOB_V1, or
+ *                  P_CONTROL_OOB_WKC_V1 to append the t=
ls-crypt-v2 wrapped
+ *                  client key (the context must then =
carry it)=2E
  * @return          the wrapped packet buffer, ready to send
=
  */
 struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struc=
t tls_auth_standalone *tas,
-                                      struct s=
ession_id *own_sid, const struct buffer *payload);
+                       =
               struct session_id *own_sid, const struct buffer *payload,
+ =
                                     int opcode);
 
 
 /**
diff --git a/tes=
ts/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
=
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
Gerrit-PatchSet: 17
Gerrit-Own=
er: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ExxJjR9u5tM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #17</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1758?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Unw=
rap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)<br><br>A tls-crypt-v2=
 server learns the per-client key only from the wrapped<br>client key (WKc)=
=2E An out-of-band probe belongs to no session, so the<br>client must carry=
 the WKc with the probe for the server to unwrap it=2E<br><br>Add the recei=
ve/protocol side of this:<br><br>  - new opcode P_CONTROL_OOB_WKC_V1 (13): =
like P_CONTROL_OOB_V1 but with<br>    the WKc appended, mirroring CONTROL_H=
ARD_RESET_CLIENT_V3/CONTROL_WKC_V1<br>  - tls_wrap_control() appends the WK=
c for opcode 13; read_control_auth()<br>    runs tls_crypt_v2_extract_clien=
t_key() for it, loading the per-client<br>    key before unwrapping the mes=
sage<br>  - tls_pre_decrypt_lite() returns the new VERDICT_VALID_OOB_WKC_V1=
, one<br>    verdict per opcode as elsewhere in the enum; do_pre_decrypt_ch=
eck()<br>    groups it with VERDICT_VALID_OOB_V1 and derives the resend-WKc=
 reply<br>    flag from it<br>  - P_LAST_OPCODE becomes 13 and opcode_is_oo=
b() covers both OOB opcodes<br>  - tls_wrap_oob_standalone() takes the opco=
de; the server reply stays a<br>    plain P_CONTROL_OOB_V1 (the server alre=
ady holds the key after unwrap)<br>  - test_pkt: round-trip test of the wra=
p/extract/unwrap path<br><br>The client still sends plain probes; sending P=
_CONTROL_OOB_WKC_V1 is added<br>in a following commit=2E<br><br>Change-Id: =
Idb8c0c660a98de8ec549b69f6692a7b41b092eaf<br>Signed-off-by: Lev Stipakov &l=
t;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/o=
ob_client=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>=
M tests/unit_tests/openvpn/test_pkt=2Ec<br>5 files changed, 165 insertions(=
+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/58/1758/17</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 1061f95=2E=2E43=
aa732 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++=
 b/src/openvpn/mudp=2Ec</span><br><span>@@ -109,7 +109,12 @@</span><br><spa=
n>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=
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
    sock);</span><br><span> </span><br><span>@@ -135,7 +140,7 @@</span><br>=
<span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span=
><br><span> </span><br><span>     if (verdict =3D=3D VERDICT_VALID_RESET_V3=
 || verdict =3D=3D VERDICT_VALID_RESET_V2</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        || verdict =3D=3D VERDICT_VALID_OOB_V1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        || verdict =3D=3D V=
ERDICT_VALID_OOB_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)</span><br><=
span>     {</span><br><span>         /* Check if we are still below our lim=
it for sending out</span><br><span>          * responses */</span><br><span=
>@@ -233,7 +238,7 @@</span><br><span> </span><br><span>         return ret;=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (verdict =3D=3D VERDICT_VALID=
_OOB_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)</span><br><span>     {<=
/span><br><span>         /* Out-of-band server probe=2E state-&gt;newbuf po=
ints at the TLV payload</span><br><span>          * (read_control_auth has =
stripped the opcode, session id and any</span><br><span>diff --git a/src/op=
envpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 969=
0d0e=2E=2E7d429f0 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</=
span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -596,7 +=
596,8 @@</span><br><span>         return;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buf=
fer probe =3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;clie=
nt_sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer probe =3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp=
;client_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span>     if (!BLE=
N(&amp;probe))</span><br><span>     {</span><br><span>         msg(D_LOW, &=
quot;server-probe: could not wrap probe packet; using configured order&quot=
;);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_=
pkt=2Ec</span><br><span>index 78552c4=2E=2E614d599 100644</span><br><span>-=
-- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec<=
/span><br><span>@@ -145,7 +145,8 @@</span><br><span>         }</span><br><s=
pan> </span><br><span>         if ((header &gt;&gt; P_OPCODE_SHIFT) =3D=3D =
P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_W=
KC_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            |=
| (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            || (header &gt;&gt; P_OP=
CODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span>         {</span><=
br><span>             if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2=
_wkc))</span><br><span>             {</span><br><span>@@ -199,7 +200,8 @@</=
span><br><span>     bool ret =3D false;</span><br><span> </span><br><span> =
    const uint8_t opcode =3D *(BPTR(buf)) &gt;&gt; P_OPCODE_SHIFT;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if ((opcode =3D=3D P_CONTR=
OL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if ((opcode =3D=3D P_CONTROL_HAR=
D_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         || opcode =3D=3D P_CONTROL_OOB_W=
KC_V1)</span><br><span>         &amp;&amp; !tls_crypt_v2_extract_client_key=
(buf, ctx, opt))</span><br><span>     {</span><br><span>         msg(D_TLS_=
ERRORS, &quot;TLS Error: can not extract tls-crypt-v2 client key from %s&qu=
ot;,</span><br><span>@@ -390,10 +392,16 @@</span><br><span>     {</span><br=
><span>         return VERDICT_VALID_WKC_V1;</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (opcode_is_oob(op=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (op =
=3D=3D P_CONTROL_OOB_V1)</span><br><span>     {</span><br><span>         re=
turn VERDICT_VALID_OOB_V1;</span><br><span>     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (op =3D=3D P_CONTROL_OOB_WKC_V1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* The WKc was unwrapped b=
y read_control_auth() above, so the per-client</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * key is already loaded into state-&gt;=
tls_wrap_tmp=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return VERDICT_VALID_OOB_WKC_V1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span>     else</span><br><span>     {<=
/span><br><span>         return VERDICT_VALID_RESET_V2;</span><br><span>@@ =
-450,8 +458,10 @@</span><br><span> </span><br><span> struct buffer</span><b=
r><span> tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_=
standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   struct session_id *own_sid, const struct buffer *payload=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      struct session_id *own_sid, const struct buffer *payload, int opcode)=
</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(opcode_is_oob(opcode));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     /* Copy buffer here to point at the sa=
me data but allow tls_wrap_control</span><br><span>      * to potentially c=
hange buf to point to another buffer without</span><br><span>      * modify=
ing the buffer in tas */</span><br><span>@@ -462,10 +472,11 @@</span><br><s=
pan>      * or ACK fields=2E */</span><br><span>     ASSERT(buf_copy(&amp;b=
uf, payload));</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPC=
ODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
8_t header =3D (uint8_t)(opcode &lt;&lt; P_OPCODE_SHIFT);</span><br><span> =
</span><br><span>     /* Add tls-auth/tls-crypt wrapping, this might replac=
e buf with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * ctx-=
&gt;work */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * c=
tx-&gt;work=2E For P_CONTROL_OOB_WKC_V1 the wrapped client key is appended<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * here too (tls=
-crypt-v2)=2E */</span><br><span>     tls_wrap_control(ctx, header, &amp;bu=
f, own_sid);</span><br><span> </span><br><span>     return buf;</span><br><=
span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><=
br><span>index 581ec48=2E=2E89e9619 100644</span><br><span>--- a/src/openvp=
n/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span=
>@@ -67,18 +67,26 @@</span><br><span>  * legal on an established session; s=
ee opcode_valid_in_session() below=2E */</span><br><span> #define P_CONTROL=
_OOB_V1 12</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Variant of P_CONTROL_OOB_V1 with an appended wrapped client key=
 (WKc), like</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * P_CO=
NTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * configured: an ou=
t-of-band message belongs to no established session, so the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * client must carry the WKc for th=
e server to recover the per-client key and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt =
and the openvpn-rfc wire</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * protocol (CONTROL_OOB_WKC_V1)=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_WKC_V1 13</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* define the range o=
f defined opcodes, in- and out-of-band=2E Note this is not</span><br><span>=
  * the set of opcodes legal on an established session; see</span><br><span=
>  * opcode_valid_in_session()=2E</span><br><span>  * Since we do no longer=
 support key-method 1 we consider</span><br><span>  * the v1 op codes inval=
id */</span><br><span> #define P_FIRST_OPCODE 3</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define P_LAST_OPCODE  12</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define P_LAST_OPCODE  13</span><br><span=
> </span><br><span> static inline bool</span><br><span> opcode_is_oob(int o=
p)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return op =3D=3D P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CON=
TROL_OOB_WKC_V1;</span><br><span> }</span><br><span> </span><br><span> /**<=
/span><br><span>@@ -140,6 +148,8 @@</span><br><span>     /** This packet is=
 a valid out-of-band control message (e=2Eg=2E a server</span><br><span>   =
   * probe)=2E It does not belong to a session and must not create one=2E *=
/</span><br><span>     VERDICT_VALID_OOB_V1,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /** as VERDICT_VALID_OOB_V1, with a wrapped cl=
ient key appended (tls-crypt-v2) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    VERDICT_VALID_OOB_WKC_V1,</span><br><span>     /** the =
packet failed on of the various checks */</span><br><span>     VERDICT_INVA=
LID</span><br><span> };</span><br><span>@@ -270,10 +280,14 @@</span><br><sp=
an>  * @param tas       standalone auth context providing the work buffer</=
span><br><span>  * @param own_sid   session id to use as our session id in =
the header</span><br><span>  * @param payload   the OOB message payload (TL=
V stream) to wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param opcode    the OOB opcode to use: P_CONTROL_OOB_V1, or</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *                  P_CONTROL_OOB=
_WKC_V1 to append the tls-crypt-v2 wrapped</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *                  client key (the context must the=
n carry it)=2E</span><br><span>  * @return          the wrapped packet buff=
er, ready to send</span><br><span>  */</span><br><span> struct buffer tls_w=
rap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *ta=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                   struct session_id *own_sid, const struct buffer *payload=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                     struct session_id *own_sid, const struct buffer *paylo=
ad,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                      int opcode);</span><br><span> </span><br><span> </spa=
n><br><span> /**</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index ca30=
45a=2E=2E894ac4f 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span>=
<br><span>@@ -716,7 +716,7 @@</span><br><span>      * bare payload, with no=
ne of the reliability/ACK fields a control packet</span><br><span>      * c=
arries=2E */</span><br><span>     struct buffer buf =3D</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        tls_wrap_oob_standalone(&amp;tas_=
client-&gt;tls_wrap, tas_client, &amp;sid, &amp;payload);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;=
tas_client-&gt;tls_wrap, tas_client, &amp;sid, &amp;payload, P_CONTROL_OOB_=
V1);</span><br><span>     assert_int_equal((BPTR(&amp;buf))[0] &gt;&gt; P_O=
PCODE_SHIFT, P_CONTROL_OOB_V1);</span><br><span> </span><br><span>     /* S=
erver side: the stateless first-packet path must recognise the opcode,</spa=
n><br><span>@@ -802,6 +802,125 @@</span><br><span>     free_tas(&amp;tas_se=
rver);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* A matching tls-crypt-v2 server/client key pair (=
the client key&#39;s WKc was</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * wrapped with this server key), reused from the tls-crypt-v2 uni=
t tests=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 const char *oob_v2_server_key =3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;-----BEGIN OpenVPN tls-crypt-v2 server key-----\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAEC=
AwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7=
PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0=
dXZ3eHl6e3x9fn8=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;-----END OpenVPN tls-crypt-v2 server key-----\n&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static const char *oob_v2_client_key =3D<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN=
 OpenVPN tls-crypt-v2 client key-----\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxw=
dHh8gISIjJCUmJygpKissLS4v\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFV=
WV1hZWltcXV5f\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6=
P\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;wMHCw8TFxsfI=
ycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;8PHy8/T19vf4+fr7/P3+/xd9=
pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0=
PfKRNwcso86ua/dBFTyXsM9tg4aw\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78Ak=
Nuho6QCFqCdqGab3\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6=
daEh\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;RZ+q17SC4=
nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;/Z5wtPCAZ0tOzj4ItTI77=
fBOYRTfEayzHgEr\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;-----END OpenVPN tls-crypt-v2 client key-----\n&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* End-to-end check of the tls-crypt-v2 out-o=
f-band probe: the client wraps an</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * OOB payload as a P_CONTROL_OOB_WKC_V1 message (the payload=
 encrypted with the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * per-client key Kc, with the wrapped client key WKc appended), and the se=
rver&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * statel=
ess first-packet path (tls_pre_decrypt_lite) recovers Kc from the WKc,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * decrypts the payload,=
 and returns VERDICT_VALID_OOB_WKC_V1=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_oob_wkc_v1_roundtrip(void **ut_state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    now =3D 0x5f000000;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epay=
load_size =3D 1400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ---- =
Client: wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc appended) ---- */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_st=
andalone tas_client =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tas_client=2Eframe =3D frame;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYP=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2E=
tls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(=
&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-CLIENT&quot;, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=
=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(1600);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Load Kc and obtain the WKc, exactly as a =
tls-crypt-v2 client does=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer wkc =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    tls_crypt_v2_init_client_key(&amp;tas_client=2E=
tls_wrap=2Eopt=2Ekey_ctx_bi,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                 &amp;tas_client=2Etls_wrap=2Eorig=
inal_wrap_keydata, &amp;wkc, oob_v2_client_key,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                 true);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=
=2Etls_crypt_v2_wkc =3D &amp;wkc;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst uint8_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c, 0xde,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
              0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf(6=
4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&a=
mp;payload, payload_bytes, sizeof(payload_bytes));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct session_id client_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8=
 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_pack=
et_id_send(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer probe =3D tls_wrap_oob_standalo=
ne(&amp;tas_client=2Etls_wrap, &amp;tas_client, &amp;client_sid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
                    &amp;payload, P_CONTROL_OOB_WKC_V1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(BLEN(&amp;probe) &gt; =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual((BPTR(&amp;probe))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* ---- Server: stateless path reco=
vers Kc from the WKc and decrypts ---- */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct tls_auth_standalone tas_server =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Efra=
me =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 No static wrapping, only a tls-crypt-v2 server key (as a v2 server runs)=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_serve=
r=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    tas_server=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_=
PACKET_ID | CO_PACKET_ID_LONG_FORM);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    packet_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epack=
et_id, 0, 0, &quot;UT-SERVER&quot;, 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    tls_crypt_v2_init_server_key(&amp;tas_server=2Etls_=
wrap=2Etls_crypt_v2_server_key, true, oob_v2_server_key,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                 true)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Ew=
orkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
link_socket_actual from =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer srv =3D alloc_buf(1600);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;srv, BPTR(&amp;pro=
be), BLEN(&amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_=
pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    enum first_packet_verdict verdict =3D tls_pre_decrypt_li=
te(&amp;tas_server, &amp;state, &amp;from, &amp;srv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(verdict, VERDICT_VAL=
ID_OOB_WKC_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The decrypted pa=
yload must equal what the client sent, and the client&#39;s</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * session id must be recovered=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(BLEN(&amp;state=2Enewbuf), (int)sizeof(payload_bytes));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&a=
mp;state=2Enewbuf), payload_bytes, sizeof(payload_bytes));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(state=2Epeer=
_session_id=2Eid, client_sid=2Eid, SID_SIZE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Flipping any single byte (header, ses=
sion id, ciphertext or WKc) must make</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * the probe fail to validate=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; (size=
_t)BLEN(&amp;probe); i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct tls_pre_decrypt_state tstate =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf_reset_len(&amp;srv);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;srv, BPTR(&a=
mp;probe), BLEN(&amp;probe));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        (BPTR(&amp;srv))[i] ^=3D 0xff;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        enum first_packet_verdict v =3D tls_pr=
e_decrypt_lite(&amp;tas_server, &amp;tstate, &amp;from, &amp;srv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(v, =
VERDICT_INVALID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      free_tls_pre_decrypt_state(&amp;tstate);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fr=
ee_key_ctx_bi(&amp;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_clien=
t=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    free_buf(&amp;wkc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    free_buf(&amp;payload);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=2Eworkbuf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=
=2Etls_wrap=2Ework);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&=
amp;tas_server=2Etls_wrap=2Etls_crypt_v2_server_key);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_=
wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free_buf(&amp;tas_server=2Eworkbuf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free_buf(&amp;srv);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> static void</span><br><span> test_extract_control_message(void *=
*ut_state)</span><br><span> {</span><br><span>@@ -855,6 +974,7 @@</span><br=
><span>         cmocka_unit_test(test_oob_standalone_plain),</span><br><spa=
n>         cmocka_unit_test(test_oob_standalone_tls_auth),</span><br><span>=
         cmocka_unit_test(test_oob_standalone_tls_crypt),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_oob_wkc=
_v1_roundtrip),</span><br><span>         cmocka_unit_test(test_extract_cont=
rol_message)</span><br><span>     };</span><br><span> </span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1758?usp=3Demail">change 1758</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1758?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b=
092eaf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1758 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--ExxJjR9u5tM=--


--===============2770587940949923144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2770587940949923144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2770587940949923144==--

