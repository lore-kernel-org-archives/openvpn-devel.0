Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6364C55167
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UfmGmKzaQvV1aKT0Ze2OX0SyOBqen+ol7TEJyDMrbRo=; b=Y9GLwMfoDFKsSef4+pRxUKfOkq
	PhlC7Q9lviWt9Q/l/HVsijho0+LYcTUZNDCImATFEUmgmMYOunLFjtewcXzHGesupz+VyVM5c6Mao
	9MIFlrdPFy7hp2bmDt2PlRXJWHEqJ7MdRcrtX9MaqeNh3+QVguJbwub2lxmB0JRwOJZo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPTX-00062p-OT;
	Thu, 30 Jul 2026 12:03:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPTW-00062h-6h
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jPqDxQGUoXI8CZAhlA4AM2+Q8nnVzgO8RrEzWtmMduI=; b=Bd9JY70+wgis3uh7lUNuMzh2Pw
 T5DiIwHa5AaOFFztX6Fsx5ca4zRZF0IgiQBf/eR9qXDl5UYzaDzTQJI6TTDs2ibcNhm2bW0D1rAI8
 gVVjy+yMP5MsV/aRkTZBrpciLJTLJRXKeAr16Fb3zg9uLQt5MJzxw+YQ+cOm5s+Ba/XE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jPqDxQGUoXI8CZAhlA4AM2+Q8nnVzgO8RrEzWtmMduI=; b=j
 s4bSpWOfP86nQKTaSATnzyf8DqdZZtLfNbnQKJ97UHpdGNXB+cUbiunNt6Ld1gO776bGSJYRtsDw8
 5Esaz+W87pTXGJYoTLDOHlE9S7gpPQGIauCCeW2idODIpMgoGTTtmsCYgIwqmNhHeKocYJlZgxuAI
 E96TynXpFHBE4DeQ=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPTX-0006Ce-4P for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:02:58 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1344360f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785412957; x=1786017757; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jPqDxQGUoXI8CZAhlA4AM2+Q8nnVzgO8RrEzWtmMduI=;
 b=Bsx50GcKLR4qzNTjZY/CsptQGCNwUKmkApx3acmAzpelqDlQtTKh7miGZ5725eAszC
 zvyiG9mq73LqpKBa2ve6aeaJe1l3WF5AuDCBcglXyBcAMcvrRWUxowrYWSVWvWi+5M7p
 RNxnllcCtxQdMHAvsCXLmR3mii+W8Ei8527qbc3CRGkTbwfANt9XMs3rHuDdlY+xVAoN
 S8OO/zvAbx3OMcxuMXlh9bC4mDmjaRHWRLeHcqNI8lV4mqtrfRiSiEmZnMoqKgxlHFLo
 13SKYLeD6i+p+xaofGN9f+GQ6oOOpnM3SAkh1A7as+9H2fYDJAe8kUhq7yp3KP1YQ+/o
 uN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785412957; x=1786017757;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jPqDxQGUoXI8CZAhlA4AM2+Q8nnVzgO8RrEzWtmMduI=;
 b=rkO3zcRU749S55NaNnNMZwT9XZt4tMZUkd/2dhL113gXnossZ+ixB+gfD9XL+aA02b
 K0HRpUxe//45S56key3+rQysCFttDdjkm4zrmb0v2yptypgv6LHH1L85bWq0DwEeHHnj
 inSF/TMIBZ1Xby1+ZRzsA0MLqtd8lVuWBxDCj2vV62Z3SWTerEZd0dwaBlc7VZPr39ny
 ofifgpQKQ4fPMvA5fxAoCF+d4WD6lCUtUb3odz9eXqbPKjHNN41mtN2WjT0ye4ZOxFb4
 ZMXZr1zNepdO+uKYNNZrmF7Q7NSBqLKdmse/EpgTFAItn48TmWEaTwwgA2ho29OTPRhZ
 PKnw==
X-Gm-Message-State: AOJu0Yy9cXSc1AjAQs82MDVv05O5TqYCxf1IE4axBesjish+v2rdbhis
 SdTBc2FejGcaFpk89f7zd86vVqUCrkSV53mK34FT3DRHYvUq+Xrsla4KxsbFj96LKmH4PlNsAmy
 Dyrs2i/3eD11hBBXgFXmFBgYwZcxzp4/twLsbSOLAPe2z7YaJq8rd2CWubMthVzPxBO/l1OtbNt
 SF17CDXg==
X-Gm-Gg: AR+sD12MnlgZJcIMHmOVTGxCvv7VmKQVdV0Q6Tx91A70ZE1KrhgVuoz/ZRiUKVf5ZpC
 R6pUORCoWoSR/qITfzZ3uOKXri7vQgClB5e+uM/LMCQbqagxrVtmnr64vqZBIqYhllKBzPXQnjS
 wo11twhc5EMNs+qSeVKvtM8YdvyLs5UF39r4QIdRkUOMb7uzJzr2EVILSJasgNFo6f3kjD1kiDb
 6tGtoq5ZUTvsoR49w2nfk8c2H8+WgiKLvPpv/Plaf63gIbQqzeXD9FQt3JfY2e9wlcjnefkyw0i
 k45tcUdFc8qfJTauEJJAQhLpGp+jSSw5dEJ0hRHszn91t+fyUyZBVpMbXq2hCxqpLDgx+aWAm8W
 /S52DB8ACuBsnIbrbnQwBfh7BkxwWXHb8EXq5YzoWtrT/NpvSRZiIRffD2ILb48a6TlhGPK43my
 jmGI91aM0Q/eO7wx2AJko7Tfx9cFvsu6BOe+BKG2fBjLkzHc2FYTwy0ZXHpSl0baUhOL++0Y9xc
 LnD54dde2WTyqTcH/xQlZav+mNJd77XMp1683ltwhDTEqs/O3KzqzYde4H29tmqxfRRhA5QiiZo
 l/6hQAl5wbEG6506hWF0bBFzHpJbf+ZO2E5+WZ6IrwvKciXYtGs=
X-Received: by 2002:a05:6000:2405:b0:47f:2634:b5a with SMTP id
 ffacd0b85a97d-47fc844f2ebmr3093824f8f.33.1785412956279; 
 Thu, 30 Jul 2026 05:02:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e439asm5170380f8f.11.2026.07.30.05.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:02:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:02:30 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 47798f76a8fffd05dafd466e4c5c29b9773b9791
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d6c47dd8d20c18ad80ae447940d2757abfcb824-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPTX-0006Ce-4P
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0990614913378057028=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0990614913378057028==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AvJgjFUPpJc="; charset=UTF-8

--AvJgjFUPpJc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail

to look at the new patch set (#2=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Replace SHA256 with SIPHASH24 in HMAC coo=
kie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Replace SHA256 with SIPHASH24 in HMAC cookie approach

Using SHA256 for t=
his is overkill since we only need a 64bit hash
value that is not predictab=
le=2E Siphash24 also fulfils these
requirements while being much faster=2E
=

Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
---
M CMakeLists=2Etx=
t
M src/openvpn/init=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/openvpn=2Eh
M=
 src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openv=
pn/Makefile=2Eam
M tests/unit_tests/openvpn/test_pkt=2Ec
8 files changed, 6=
8 insertions(+), 101 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/27/1827/2

diff --git a/CMakeLists=2Etxt b/CMak=
eLists=2Etxt
index 9e1dde1=2E=2E29b53a9 100644
--- a/CMakeLists=2Etxt
+++ b=
/CMakeLists=2Etxt
@@ -875,6 +875,7 @@
         src/openvpn/packet_id=2Ec
  =
       src/openvpn/reliable=2Ec
         src/openvpn/run_command=2Ec
+     =
   src/openvpn/siphash_reference=2Ec
         src/openvpn/session_id=2Ec
  =
       src/openvpn/ssl_pkt=2Ec
         src/openvpn/tls_crypt=2Ec
diff --gi=
t a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index db753dc=2E=2E38c309d =
100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3473,7 +34=
73,7 @@
     if (flags & CF_INIT_TLS_AUTH_STANDALONE)
     {
         c->c2=
=2Etls_auth_standalone =3D tls_auth_standalone_init(&to, &c->c2=2Egc);
-   =
     c->c2=2Esession_id_hmac =3D session_id_hmac_init();
+        ASSERT(ra=
nd_bytes(c->c2=2Esession_id_key, sizeof(c->c2=2Esession_id_key)));
     }
 =
}
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=
=2E=2Eb64cdd7 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -87,7 +87,7 @@
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m->t=
op=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    hmac_ctx_t *hmac =3D m->top=2Ec=
2=2Esession_id_hmac;
+    uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_ke=
y;
     struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     =
int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@ -119,7 +119,7 =
@@
         {
             /* Calculate the session ID HMAC for our reply a=
nd create reset packet */
             struct session_id sid =3D
-         =
       calculate_session_id_hmac(state->peer_session_id, from, hmac, handwi=
ndow, 0);
+                calculate_session_id_hmac(state->peer_session_id=
, from, hmac_key, handwindow, 0);
             send_hmac_reset_packet(m, st=
ate, tas, &sid, true, sock);
 
             return false;
@@ -151,7 +151,7 =
@@
     {
         /* Calculate the session ID HMAC for our reply and creat=
e reset packet */
         struct session_id sid =3D
-            calculate=
_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+     =
       calculate_session_id_hmac(state->peer_session_id, from, hmac_key, ha=
ndwindow, 0);
 
         send_hmac_reset_packet(m, state, tas, &sid, false,=
 sock);
 
@@ -166,7 +166,7 @@
         struct gc_arena gc =3D gc_new();
 
 =
        bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
-       =
 bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow, =
pkt_is_ack);
+        bool ret =3D check_session_hmac_and_pkt_id(state, fro=
m, hmac_key, handwindow, pkt_is_ack);
 
         const char *peer =3D print=
_link_socket_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t pkt_firstby=
te =3D *BPTR(&m->top=2Ec2=2Ebuf);
diff --git a/src/openvpn/openvpn=2Eh b/sr=
c/openvpn/openvpn=2Eh
index fa00822=2E=2Ee9e18bf 100644
--- a/src/openvpn/o=
penvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -45,6 +45,7 @@
 #include "plugi=
n=2Eh"
 #include "manage=2Eh"
 #include "dns=2Eh"
+#include "siphash=2Eh"
 =

 /*
  * Our global key schedules, packaged thusly
@@ -335,10 +336,9 @@
   =
   *   \c --tls-auth commandline option=2E */
 
 
-    hmac_ctx_t *session_=
id_hmac;
-    /**< the HMAC we use to generate and verify our syn cookie li=
ke
-     * session ids from the server=2E
-     */
+    uint8_t session_id_=
key[SIPHASH_KEY_SIZE];
+    /**< the siphash secret we use to generate and =
verify our syn cookie like
+     * session ids from the server=2E */
 
    =
 /* used to optimize calls to tls_multi_process */
     struct interval tmp=
_int;
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index =
f8444451=2E=2E6a6d9f9 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvp=
n/ssl_pkt=2Ec
@@ -31,6 +31,7 @@
 #include "crypto=2Eh"
 #include "session_i=
d=2Eh"
 #include "reliable=2Eh"
+#include "siphash=2Eh"
 #include "tls_cryp=
t=2Eh"
 
 /*
@@ -442,64 +443,53 @@
     return buf;
 }
 
-hmac_ctx_t *
-ses=
sion_id_hmac_init(void)
-{
-    /* We assume that SHA256 is always availabl=
e */
-    ASSERT(md_valid("SHA256"));
-    hmac_ctx_t *hmac_ctx =3D hmac_ct=
x_new();
-
-    uint8_t key[SHA256_DIGEST_LENGTH];
-    ASSERT(rand_bytes(k=
ey, sizeof(key)));
-
-    hmac_ctx_init(hmac_ctx, key, "SHA256");
-    retu=
rn hmac_ctx;
-}
-
 struct session_id
 calculate_session_id_hmac(struct sess=
ion_id client_sid, const struct openvpn_sockaddr *from,
-                  =
        hmac_ctx_t *hmac, int handwindow, int offset)
+                    =
      const uint8_t *key, int handwindow, int offset)
 {
-    union
-    {
=
-        uint8_t hmac_result[SHA256_DIGEST_LENGTH];
-        struct session=
_id sid;
-    } result;
-
     /* Get the valid time quantisation for our h=
mac,
      * we divide time by handwindow/2 and allow the previous
      * =
and future session time if specified by offset */
     uint32_t session_id_=
time =3D ntohl((uint32_t)(now / ((handwindow + 1) / 2) + offset));
 
-    h=
mac_ctx_reset(hmac);
+    uint8_t input[64];
+
+    /* ensure input array i=
s large enough */
+    static_assert(sizeof(input) >=3D sizeof(struct socka=
ddr_in6) + sizeof(session_id_time) + sizeof(client_sid=2Eid), "input buffer=
 not sized correctly");
+    static_assert(sizeof(input) >=3D sizeof(struct=
 sockaddr_in) + sizeof(session_id_time) + sizeof(client_sid=2Eid), "input b=
uffer not sized correctly");
+
+    struct buffer in =3D { 0 };
+    buf_se=
t_write(&in, input, sizeof(input));
+
     /* We do not care about endian h=
ere since it does not need to be
      * portable */
-    hmac_ctx_update(h=
mac, (const uint8_t *)&session_id_time, sizeof(session_id_time));
+    buf_=
write(&in, (const uint8_t *)&session_id_time, sizeof(session_id_time));
 
 =
    /* add client IP and port */
     switch (from->addr=2Esa=2Esa_family)
=
     {
         case AF_INET:
-            hmac_ctx_update(hmac, (const uin=
t8_t *)&from->addr=2Ein4, sizeof(struct sockaddr_in));
+            buf_wri=
te(&in, (const uint8_t *)&from->addr=2Ein4, sizeof(struct sockaddr_in));
  =
           break;
 
         case AF_INET6:
-            hmac_ctx_update(hm=
ac, (const uint8_t *)&from->addr=2Ein6, sizeof(struct sockaddr_in6));
+    =
        buf_write(&in, (const uint8_t *)&from->addr=2Ein6, sizeof(struct so=
ckaddr_in6));
             break;
     }
 
     /* add session id of client=
 */
-    hmac_ctx_update(hmac, client_sid=2Eid, SID_SIZE);
+    buf_write(&=
in, client_sid=2Eid, SID_SIZE);
 
-    hmac_ctx_final(hmac, result=2Ehmac_r=
esult);
+    struct session_id sid;
+    siphash(buf_bptr(&in), buf_len(&in=
), key, sid=2Eid, sizeof(sid=2Eid));
 
-    return result=2Esid;
+    retur=
n sid;
 }
 
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_sta=
te *state,
                               const struct openvpn_sockaddr *fr=
om,
-                              hmac_ctx_t *hmac,
+                     =
         uint8_t *key,
                               int handwindow,
     =
                          bool pkt_is_ack)
 {
@@ -551,7 +541,7 @@
     for =
(int offset =3D -2; offset <=3D 0; offset++)
     {
         struct session=
_id expected_id =3D
-            calculate_session_id_hmac(state->peer_sess=
ion_id, from, hmac, handwindow, offset);
+            calculate_session_id_=
hmac(state->peer_session_id, from, key, handwindow, offset);
 
         if =
(memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE) =
=3D=3D 0)
         {
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl=
_pkt=2Eh
index 82cb5b1=2E=2E03e8930 100644
--- a/src/openvpn/ssl_pkt=2Eh
++=
+ b/src/openvpn/ssl_pkt=2Eh
@@ -151,28 +151,20 @@
                         =
                       const struct link_socket_actual *from,
             =
                                   const struct buffer *buf);
 
-/* Creates=
 an SHA256 HMAC context with a random key that is used for the
- * session =
id=2E
- *
- * We do not support loading this from a config file since conti=
nuing session
- * between restarts of OpenVPN has never been supported and =
that includes
- * early session setup=2E
- */
-hmac_ctx_t *session_id_hmac_=
init(void);
-
 /**
  * Calculates the HMAC based server session id based on=
 a client session id
  * and socket addr=2E
  *
  * @param client_sid    se=
ssion id of the client
  * @param from          link_socket from the client=

- * @param hmac          the hmac context to use for the calculation
+ * @=
param key           the siphash key to use for the calculation
  * @param h=
andwindow    the quantisation of the current time
  * @param offset        =
offset to 'now' to use
  * @return              the expected server session=
 id
  */
 struct session_id calculate_session_id_hmac(struct session_id cli=
ent_sid,
-                                            const struct openvpn_=
sockaddr *from, hmac_ctx_t *hmac,
+                                        =
    const struct openvpn_sockaddr *from,
+                                 =
           const uint8_t *key,
                                            =
 int handwindow, int offset);
 
 /**
@@ -185,13 +177,13 @@
  *
  * @param s=
tate         session information
  * @param from          link_socket from =
the client
- * @param hmac          the hmac context to use for the calcula=
tion
+ * @param key           the siphash key to use for the calculation
  =
* @param handwindow    the quantisation of the current time
  * @param pkt_=
is_ack    the packet being checked is a P_ACK_V1
  * @return              t=
he expected server session id
  */
 bool check_session_hmac_and_pkt_id(stru=
ct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *from,
-    =
                               hmac_ctx_t *hmac, int handwindow, bool pkt_i=
s_ack);
+                                   uint8_t *key, int handwindow, b=
ool pkt_is_ack);
 
 /*
  * Write a control channel authentication record=2E=

diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/ope=
nvpn/Makefile=2Eam
index ae15759=2E=2Ec76d94a 100644
--- a/tests/unit_tests=
/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -172=
,6 +172,7 @@
 	$(top_srcdir)/src/openvpn/reliable=2Ec \
 	$(top_srcdir)/src=
/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec \
+	$=
(top_srcdir)/src/openvpn/siphash_reference=2Ec \
 	$(top_srcdir)/src/openvp=
n/ssl_pkt=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir=
)/src/openvpn/tls_crypt=2Ec
diff --git a/tests/unit_tests/openvpn/test_pkt=
=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index cad2ce0=2E=2E17987a4 100=
644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/open=
vpn/test_pkt=2Ec
@@ -42,6 +42,7 @@
 
 #include "mss=2Eh"
 #include "reliabl=
e=2Eh"
+#include "siphash=2Eh"
 
 int
 parse_line(const char *line, char **=
p, const int n, const char *file, const int line_num,
@@ -403,7 +404,8 @@
 =
static void
 test_verify_hmac_tls_auth(void **ut_state)
 {
-    hmac_ctx_t =
*hmac =3D session_id_hmac_init();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { =
0 };
+    rand_bytes(key, sizeof(key));
 
     struct link_socket_actual fr=
om =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;
@@ -422=
,21 +424,20 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
 
=
     /* This is a valid packet but containing a random id instead of an HMA=
C id*/
-    bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Ede=
st, hmac, 30, false);
+    bool valid =3D check_session_hmac_and_pkt_id(&st=
ate, &from=2Edest, key, 30, false);
     assert_false(valid);
 
     free_t=
ls_pre_decrypt_state(&state);
     free_buf(&buf);
     free_tas(&tas);
-  =
  hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void
 test=
_verify_hmac_none(void **ut_state)
 {
     now =3D 1000;
-    hmac_ctx_t *h=
mac =3D session_id_hmac_init();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 =
};
+    rand_bytes(key, sizeof(key));
 
     struct link_socket_actual from=
 =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;
@@ -456,1=
3 +457,13 @@
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
     /=
* This packet has a random hmac, so it should fail to validate */
-    bool=
 valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, tr=
ue);
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest=
, key, 30, true);
     assert_false(valid);
 
     struct session_id client=
_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } };
     assert=
_memory_equal(&client_id, &state=2Epeer_session_id, sizeof(struct session_i=
d));
 
-    struct session_id expected_id =3D calculate_session_id_hmac(cli=
ent_id, &from=2Edest, hmac, 30, 0);
+    struct session_id expected_id =3D =
calculate_session_id_hmac(client_id, &from=2Edest, key, 30, 0);
 
     free=
_tls_pre_decrypt_state(&state);
     buf_reset_len(&buf);
@@ -474,7 +475,7 =
@@
 
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
    =
 assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
-    valid =3D check_sess=
ion_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true);
+    valid =3D c=
heck_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true);
 
     a=
ssert_true(valid);
 
@@ -483,23 +484,23 @@
      * So setting time to the t=
wo future ones should work
      */
     now =3D 980;
-    assert_false(che=
ck_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    ass=
ert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true=
));
     now =3D 1040;
-    assert_false(check_session_hmac_and_pkt_id(&sta=
te, &from=2Edest, hmac, 30, true));
+    assert_false(check_session_hmac_an=
d_pkt_id(&state, &from=2Edest, key, 30, true));
     now =3D 1002;
-    ass=
ert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true=
));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, ke=
y, 30, true));
     now =3D 1022;
-    assert_true(check_session_hmac_and_p=
kt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_true(check_sessio=
n_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
     now =3D 1010;=

-    assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac,=
 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from=
=2Edest, key, 30, true));
 
     /* Changing the IP address should make thi=
s invalid */
     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x=
01020305);
-    assert_false(check_session_hmac_and_pkt_id(&state, &from=2E=
dest, hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&st=
ate, &from=2Edest, key, 30, true));
 
     /* Change to the correct one aga=
in */
     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x0102030=
4);
-    assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, hm=
ac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &fro=
m=2Edest, key, 30, true));
 
     /* Modify the peer id, should now fail hm=
ac verification */
     buf_inc_len(&buf, -4);
@@ -508,18 +509,17 @@
     f=
ree_tls_pre_decrypt_state(&state);
     verdict =3D tls_pre_decrypt_lite(&t=
as, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_=
V1);
-    assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, =
hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&state, &=
from=2Edest, key, 30, true));
 
     free_tls_pre_decrypt_state(&state);
  =
   free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 =
}
 
 static void
 test_verify_hmac_none_out_of_range_ack(void **ut_state)
 =
{
-    hmac_ctx_t *hmac =3D session_id_hmac_init();
+    uint8_t key[SIPHAS=
H_KEY_SIZE] =3D { 0 };
+    rand_bytes(key, sizeof(key));
 
     struct lin=
k_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2Esa_family =
=3D AF_INET;
@@ -540,7 +540,7 @@
     assert_int_equal(verdict, VERDICT_VAL=
ID_ACK_V1);
 
     /* should fail because it acks 2 */
-    bool valid =3D =
check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true);
+    b=
ool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, =
true);
     assert_false(valid);
     free_tls_pre_decrypt_state(&state);
 =

@@ -552,31 +552,17 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL=
_V1);
 
     /* should fail because it has message id 2 */
-    valid =3D c=
heck_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true);
+    va=
lid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true);=

     assert_false(valid);
 
     free_tls_pre_decrypt_state(&state);
     =
free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
-}
-=

-static hmac_ctx_t *
-init_static_hmac(void)
-{
-    ASSERT(md_valid("SHA2=
56"));
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
-
-    uint8_t key[SHA=
256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };
-
-    hmac_ctx_init(hmac_ctx, key, =
"SHA256");
-    return hmac_ctx;
 }
 
 static void
 test_calc_session_id_hm=
ac_static(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D init_static_hmac();=

+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };
     static const i=
nt handwindow =3D 100;
 
     struct openvpn_sockaddr addr =3D { 0 };
@@ -5=
88,27 +574,27 @@
     struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5,=
 6, 7 } };
 
     now =3D 1005;
-    struct session_id server_id =3D calcul=
ate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+    struct ses=
sion_id server_id =3D calculate_session_id_hmac(client_id, &addr, key, hand=
window, 0);
 
 
-    struct session_id expected_server_id =3D { { 0x84, 0x7=
3, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };
+    struct session_id expected_=
server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };
     =
/* We have to deal with different structs here annoyingly */
     /* Linux =
has an unsigned short int as family_t and this is field is always
      * s=
tored in host endianness even though the rest of the struct isn't=2E=2E=2E,=

      * so Linux little endian differs from all BSD and Linux big endian *=
/
     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(unsigned sh=
ort int) && ntohs(AF_INET) !=3D AF_INET)
     {
-        struct session_id =
linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a } };
+      =
  struct session_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x8=
5, 0x12 } };
         expected_server_id =3D linuxle;
     }
     assert_me=
mory_equal(expected_server_id=2Eid, server_id=2Eid, SID_SIZE);
 
     struc=
t session_id server_id_m1 =3D
-        calculate_session_id_hmac(client_id,=
 &addr, hmac, handwindow, -1);
+        calculate_session_id_hmac(client_id=
, &addr, key, handwindow, -1);
     struct session_id server_id_p1 =3D
-   =
     calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 1);
+   =
     calculate_session_id_hmac(client_id, &addr, key, handwindow, 1);
     =
struct session_id server_id_p2 =3D
-        calculate_session_id_hmac(clien=
t_id, &addr, hmac, handwindow, 2);
+        calculate_session_id_hmac(clien=
t_id, &addr, key, handwindow, 2);
 
     assert_memory_not_equal(expected_s=
erver_id=2Eid, server_id_m1=2Eid, SID_SIZE);
     assert_memory_not_equal(e=
xpected_server_id=2Eid, server_id_p1=2Eid, SID_SIZE);
@@ -618,20 +604,17 @@=

     now =3D 1062;
 
     struct session_id server_id2_m2 =3D
-        cal=
culate_session_id_hmac(client_id, &addr, hmac, handwindow, -2);
+        ca=
lculate_session_id_hmac(client_id, &addr, key, handwindow, -2);
     struct=
 session_id server_id2_m1 =3D
-        calculate_session_id_hmac(client_id,=
 &addr, hmac, handwindow, -1);
-    struct session_id server_id2 =3D calcul=
ate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+        calcul=
ate_session_id_hmac(client_id, &addr, key, handwindow, -1);
+    struct ses=
sion_id server_id2 =3D calculate_session_id_hmac(client_id, &addr, key, han=
dwindow, 0);
     struct session_id server_id2_p1 =3D
-        calculate_se=
ssion_id_hmac(client_id, &addr, hmac, handwindow, 1);
+        calculate_se=
ssion_id_hmac(client_id, &addr, key, handwindow, 1);
 
     assert_memory_e=
qual(server_id2_m2=2Eid, server_id_m1=2Eid, SID_SIZE);
     assert_memory_e=
qual(server_id2_m1=2Eid, expected_server_id=2Eid, SID_SIZE);
     assert_me=
mory_equal(server_id2=2Eid, server_id_p1=2Eid, SID_SIZE);
     assert_memor=
y_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);
-
-    hmac_ctx_c=
leanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e=
06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 2
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--AvJgjFUPpJc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Replace SHA256 with SIPHASH24 in HMAC cookie approach<br><br>=
Using SHA256 for this is overkill since we only need a 64bit hash<br>value =
that is not predictable=2E Siphash24 also fulfils these<br>requirements whi=
le being much faster=2E<br><br>Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8=
e06d6fc3<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<br>M src/op=
envpn/mudp=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br=
>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M=
 tests/unit_tests/openvpn/test_pkt=2Ec<br>8 files changed, 68 insertions(+)=
, 101 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/27/1827/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLis=
ts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 9e1dde1=2E=2E29b53a9 1006=
44</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -875,6 +875,7 @@</span><br><span>         src/ope=
nvpn/packet_id=2Ec</span><br><span>         src/openvpn/reliable=2Ec</span>=
<br><span>         src/openvpn/run_command=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        src/openvpn/siphash_reference=2Ec</span>=
<br><span>         src/openvpn/session_id=2Ec</span><br><span>         src/=
openvpn/ssl_pkt=2Ec</span><br><span>         src/openvpn/tls_crypt=2Ec</spa=
n><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span>=
<br><span>index db753dc=2E=2E38c309d 100644</span><br><span>--- a/src/openv=
pn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -=
3473,7 +3473,7 @@</span><br><span>     if (flags &amp; CF_INIT_TLS_AUTH_STA=
NDALONE)</span><br><span>     {</span><br><span>         c-&gt;c2=2Etls_aut=
h_standalone =3D tls_auth_standalone_init(&amp;to, &amp;c-&gt;c2=2Egc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Esessio=
n_id_hmac =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ASSERT(rand_bytes(c-&gt;c2=2Esession_id_key, size=
of(c-&gt;c2=2Esession_id_key)));</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec</span><br><span>index 9acf297=2E=2Eb64cdd7 100644</span><br=
><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2E=
c</span><br><span>@@ -87,7 +87,7 @@</span><br><span> </span><br><span>     =
verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &a=
mp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D m-&gt;top=2Ec2=2Esession_id_=
hmac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *h=
mac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span>     struct op=
envpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span=
>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br>=
<span> </span><br><span>@@ -119,7 +119,7 @@</span><br><span>         {</spa=
n><br><span>             /* Calculate the session ID HMAC for our reply and=
 create reset packet */</span><br><span>             struct session_id sid =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ca=
lculate_session_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwi=
ndow, 0);</span><br><span>             send_hmac_reset_packet(m, state, tas=
, &amp;sid, true, sock);</span><br><span> </span><br><span>             ret=
urn false;</span><br><span>@@ -151,7 +151,7 @@</span><br><span>     {</span=
><br><span>         /* Calculate the session ID HMAC for our reply and crea=
te reset packet */</span><br><span>         struct session_id sid =3D</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            calculate_sessi=
on_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            calculate_session=
_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow, 0);</span><=
br><span> </span><br><span>         send_hmac_reset_packet(m, state, tas, &=
amp;sid, false, sock);</span><br><span> </span><br><span>@@ -166,7 +166,7 @=
@</span><br><span>         struct gc_arena gc =3D gc_new();</span><br><span=
> </span><br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VAL=
ID_ACK_V1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bo=
ol ret =3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow, pkt=
_is_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bo=
ol ret =3D check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow,=
 pkt_is_ack);</span><br><span> </span><br><span>         const char *peer =
=3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc);</span><b=
r><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebuf)=
;</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvp=
n=2Eh</span><br><span>index fa00822=2E=2Ee9e18bf 100644</span><br><span>---=
 a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</s=
pan><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;plugin=2Eh&=
quot;</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> #in=
clude &quot;dns=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> /=
*</span><br><span>  * Our global key schedules, packaged thusly</span><br><=
span>@@ -335,10 +336,9 @@</span><br><span>      *   \c --tls-auth commandli=
ne option=2E */</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *session_id_hmac;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; the HMAC we use to g=
enerate and verify our syn cookie like</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * session ids from the server=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint8_t session_id_key[SIPHASH_KEY_SIZE];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; the siphash secr=
et we use to generate and verify our syn cookie like</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * session ids from the server=2E */<=
/span><br><span> </span><br><span>     /* used to optimize calls to tls_mul=
ti_process */</span><br><span>     struct interval tmp_int;</span><br><span=
>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><=
span>index f8444451=2E=2E6a6d9f9 100644</span><br><span>--- a/src/openvpn/s=
sl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@=
 -31,6 +31,7 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br>=
<span> #include &quot;session_id=2Eh&quot;</span><br><span> #include &quot;=
reliable=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;siphash=2Eh&quot;</span><br><span> #include &quot;tls_crypt=
=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>@@ -442,64=
 +443,53 @@</span><br><span>     return buf;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-session_id_hmac_init(voi=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* We assume that SHA256 is always =
available */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSER=
T(md_valid(&quot;SHA256&quot;));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(key, sizeof(key)));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_init(hmac_ctx, key, &quot;SHA2=
56&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
hmac_ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct session=
_id</span><br><span> calculate_session_id_hmac(struct session_id client_sid=
, const struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                          hmac_ctx_t *hmac, int handwindow=
, int offset)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                    const uint8_t *key, int handwindow, int offset)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    union<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uint8_t hmac_result[SHA256_DIG=
EST_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct session_id sid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    } result;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     /* Get the valid time quantisation for our hmac,</span><br><s=
pan>      * we divide time by handwindow/2 and allow the previous</span><br=
><span>      * and future session time if specified by offset */</span><br>=
<span>     uint32_t session_id_time =3D ntohl((uint32_t)(now / ((handwindow=
 + 1) / 2) + offset));</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    hmac_ctx_reset(hmac);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint8_t input[64];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* ensure input array is large enough */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static_assert(sizeof(input) &gt;=3D s=
izeof(struct sockaddr_in6) + sizeof(session_id_time) + sizeof(client_sid=2E=
id), &quot;input buffer not sized correctly&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static_assert(sizeof(input) &gt;=3D s=
izeof(struct sockaddr_in) + sizeof(session_id_time) + sizeof(client_sid=2Ei=
d), &quot;input buffer not sized correctly&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer in =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_set_write(&amp;in, input, sizeof(input));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 /* We do not care about endian here since it does not need to be</span><br=
><span>      * portable */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    hmac_ctx_update(hmac, (const uint8_t *)&amp;session_id_time, sizeo=
f(session_id_time));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_write(&amp;in, (const uint8_t *)&amp;session_id_time, sizeof(sessi=
on_id_time));</span><br><span> </span><br><span>     /* add client IP and p=
ort */</span><br><span>     switch (from-&gt;addr=2Esa=2Esa_family)</span><=
br><span>     {</span><br><span>         case AF_INET:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            hmac_ctx_update(hmac, (const u=
int8_t *)&amp;from-&gt;addr=2Ein4, sizeof(struct sockaddr_in));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;in, =
(const uint8_t *)&amp;from-&gt;addr=2Ein4, sizeof(struct sockaddr_in));</sp=
an><br><span>             break;</span><br><span> </span><br><span>        =
 case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      hmac_ctx_update(hmac, (const uint8_t *)&amp;from-&gt;addr=2Ein6, size=
of(struct sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buf_write(&amp;in, (const uint8_t *)&amp;from-&gt;addr=2E=
in6, sizeof(struct sockaddr_in6));</span><br><span>             break;</spa=
n><br><span>     }</span><br><span> </span><br><span>     /* add session id=
 of client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac=
_ctx_update(hmac, client_sid=2Eid, SID_SIZE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf_write(&amp;in, client_sid=2Eid, SID_SIZE)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  hmac_ctx_final(hmac, result=2Ehmac_result);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id sid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    siphash(buf_bptr(&amp;in), buf_len(&a=
mp;in), key, sid=2Eid, sizeof(sid=2Eid));</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return result=2Esid;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return sid;</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span> check_session_h=
mac_and_pkt_id(struct tls_pre_decrypt_state *state,</span><br><span>       =
                        const struct openvpn_sockaddr *from,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                              hmac_c=
tx_t *hmac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                      uint8_t *key,</span><br><span>                       =
        int handwindow,</span><br><span>                               bool=
 pkt_is_ack)</span><br><span> {</span><br><span>@@ -551,7 +541,7 @@</span><=
br><span>     for (int offset =3D -2; offset &lt;=3D 0; offset++)</span><br=
><span>     {</span><br><span>         struct session_id expected_id =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            calculate_se=
ssion_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, offset);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            calculate=
_session_id_hmac(state-&gt;peer_session_id, from, key, handwindow, offset);=
</span><br><span> </span><br><span>         if (memcmp_constant_time(&amp;e=
xpected_id, &amp;state-&gt;server_session_id, SID_SIZE) =3D=3D 0)</span><br=
><span>         {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/sr=
c/openvpn/ssl_pkt=2Eh</span><br><span>index 82cb5b1=2E=2E03e8930 100644</sp=
an><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvp=
n/ssl_pkt=2Eh</span><br><span>@@ -151,28 +151,20 @@</span><br><span>       =
                                         const struct link_socket_actual *f=
rom,</span><br><span>                                                const =
struct buffer *buf);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/* Creates an SHA256 HMAC context with a random key that i=
s used for the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * sess=
ion id=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * We do not support loading th=
is from a config file since continuing session</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * between restarts of OpenVPN has never been supp=
orted and that includes</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * early session setup=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *=
session_id_hmac_init(void);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> /**</span><br><span>  * Calculates the HMAC based s=
erver session id based on a client session id</span><br><span>  * and socke=
t addr=2E</span><br><span>  *</span><br><span>  * @param client_sid    sess=
ion id of the client</span><br><span>  * @param from          link_socket f=
rom the client</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par=
am hmac          the hmac context to use for the calculation</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param key           the siphas=
h key to use for the calculation</span><br><span>  * @param handwindow    t=
he quantisation of the current time</span><br><span>  * @param offset      =
  offset to &#39;now&#39; to use</span><br><span>  * @return              t=
he expected server session id</span><br><span>  */</span><br><span> struct =
session_id calculate_session_id_hmac(struct session_id client_sid,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
              const struct openvpn_sockaddr *from, hmac_ctx_t *hmac,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                  const struct openvpn_sockaddr *from,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
    const uint8_t *key,</span><br><span>                                   =
          int handwindow, int offset);</span><br><span> </span><br><span> /=
**</span><br><span>@@ -185,13 +177,13 @@</span><br><span>  *</span><br><spa=
n>  * @param state         session information</span><br><span>  * @param f=
rom          link_socket from the client</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @param hmac          the hmac context to use for the =
calculation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m key           the siphash key to use for the calculation</span><br><span>=
  * @param handwindow    the quantisation of the current time</span><br><sp=
an>  * @param pkt_is_ack    the packet being checked is a P_ACK_V1</span><b=
r><span>  * @return              the expected server session id</span><br><=
span>  */</span><br><span> bool check_session_hmac_and_pkt_id(struct tls_pr=
e_decrypt_state *state, const struct openvpn_sockaddr *from,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                   h=
mac_ctx_t *hmac, int handwindow, bool pkt_is_ack);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                   uint8_t *=
key, int handwindow, bool pkt_is_ack);</span><br><span> </span><br><span> /=
*</span><br><span>  * Write a control channel authentication record=2E</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/uni=
t_tests/openvpn/Makefile=2Eam</span><br><span>index ae15759=2E=2Ec76d94a 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br=
><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -172=
,6 +172,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/reliable=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/session_id=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/tls_crypt=2Ec</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span=
>index cad2ce0=2E=2E17987a4 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=
=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> </span><br><span> #=
include &quot;mss=2Eh&quot;</span><br><span> #include &quot;reliable=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
iphash=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> pa=
rse_line(const char *line, char **p, const int n, const char *file, const i=
nt line_num,</span><br><span>@@ -403,7 +404,8 @@</span><br><span> static vo=
id</span><br><span> test_verify_hmac_tls_auth(void **ut_state)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t =
*hmac =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    rand_bytes(key, sizeof(key));</s=
pan><br><span> </span><br><span>     struct link_socket_actual from =3D { 0=
 };</span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</=
span><br><span>@@ -422,21 +424,20 @@</span><br><span>     assert_int_equal(=
verdict, VERDICT_VALID_CONTROL_V1);</span><br><span> </span><br><span>     =
/* This is a valid packet but containing a random id instead of an HMAC id*=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D c=
heck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D=
 check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, false=
);</span><br><span>     assert_false(valid);</span><br><span> </span><br><s=
pan>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>     free_=
buf(&amp;buf);</span><br><span>     free_tas(&amp;tas);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span> te=
st_verify_hmac_none(void **ut_state)</span><br><span> {</span><br><span>   =
  now =3D 1000;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hm=
ac_ctx_t *hmac =3D session_id_hmac_init();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    rand_bytes(key, sizeof(=
key));</span><br><span> </span><br><span>     struct link_socket_actual fro=
m =3D { 0 };</span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D A=
F_INET;</span><br><span>@@ -456,13 +457,13 @@</span><br><span>     assert_i=
nt_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span> </span><br><span>=
     /* This packet has a random hmac, so it should fail to validate */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_=
session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check=
_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</spa=
n><br><span>     assert_false(valid);</span><br><span> </span><br><span>   =
  struct session_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0=
x79, 0xc8 } };</span><br><span>     assert_memory_equal(&amp;client_id, &am=
p;state=2Epeer_session_id, sizeof(struct session_id));</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session_id ex=
pected_id =3D calculate_session_id_hmac(client_id, &amp;from=2Edest, hmac, =
30, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ession_id expected_id =3D calculate_session_id_hmac(client_id, &amp;from=2E=
dest, key, 30, 0);</span><br><span> </span><br><span>     free_tls_pre_decr=
ypt_state(&amp;state);</span><br><span>     buf_reset_len(&amp;buf);</span>=
<br><span>@@ -474,7 +475,7 @@</span><br><span> </span><br><span>     verdic=
t =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</spa=
n><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    valid =3D check_session_hma=
c_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    valid =3D check_session_hmac_an=
d_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br><span> </s=
pan><br><span>     assert_true(valid);</span><br><span> </span><br><span>@@=
 -483,23 +484,23 @@</span><br><span>      * So setting time to the two futu=
re ones should work</span><br><span>      */</span><br><span>     now =3D 9=
80;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(c=
heck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(c=
heck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));=
</span><br><span>     now =3D 1040;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    assert_false(check_session_hmac_and_pkt_id(&amp;state, &a=
mp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(check_session_hmac_and_pkt_id(&amp;state, &a=
mp;from=2Edest, key, 30, true));</span><br><span>     now =3D 1002;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_session=
_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_session_=
hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><s=
pan>     now =3D 1022;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest=
, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest,=
 key, 30, true));</span><br><span>     now =3D 1010;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_session_hmac_and_pkt_=
id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(check_session_hmac_and_pkt_i=
d(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span> </span><b=
r><span>     /* Changing the IP address should make this invalid */</span><=
br><span>     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x0102=
0305);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_fals=
e(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, tru=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true=
));</span><br><span> </span><br><span>     /* Change to the correct one aga=
in */</span><br><span>     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D=
 ntohl(0x01020304);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, h=
mac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, ke=
y, 30, true));</span><br><span> </span><br><span>     /* Modify the peer id=
, should now fail hmac verification */</span><br><span>     buf_inc_len(&am=
p;buf, -4);</span><br><span>@@ -508,18 +509,17 @@</span><br><span>     free=
_tls_pre_decrypt_state(&amp;state);</span><br><span>     verdict =3D tls_pr=
e_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><span>=
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_session_hmac_and_pkt=
_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_session_hmac_and_p=
kt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span> </spa=
n><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>  =
   free_buf(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    hmac_ctx_cleanup(hmac);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    hmac_ctx_free(hmac);</span><br><span> }</span><br><span> </span>=
<br><span> static void</span><br><span> test_verify_hmac_none_out_of_range_=
ack(void **ut_state)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_=
SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 rand_bytes(key, sizeof(key));</span><br><span> </span><br><span>     struc=
t link_socket_actual from =3D { 0 };</span><br><span>     from=2Edest=2Eadd=
r=2Esa=2Esa_family =3D AF_INET;</span><br><span>@@ -540,7 +540,7 @@</span><=
br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><s=
pan> </span><br><span>     /* should fail because it acks 2 */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_session_h=
mac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_session_=
hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br><sp=
an>     assert_false(valid);</span><br><span>     free_tls_pre_decrypt_stat=
e(&amp;state);</span><br><span> </span><br><span>@@ -552,31 +552,17 @@</spa=
n><br><span>     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);</span=
><br><span> </span><br><span>     /* should fail because it has message id =
2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    valid =3D che=
ck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    valid =3D check_s=
ession_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</span>=
<br><span>     assert_false(valid);</span><br><span> </span><br><span>     =
free_tls_pre_decrypt_state(&amp;state);</span><br><span>     free_buf(&amp;=
buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cle=
anup(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_c=
tx_free(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static hmac_ctx_t *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-init_static_hmac(void)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(md_valid(&quot;SHA256&quot;));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, =
2, 3, 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_init(hmac_ctx, key,=
 &quot;SHA256&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return hmac_ctx;</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span> test_calc_session_id_hmac_static(void **ut_sta=
te)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    hmac_ctx_t *hmac =3D init_static_hmac();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, =
0 };</span><br><span>     static const int handwindow =3D 100;</span><br><s=
pan> </span><br><span>     struct openvpn_sockaddr addr =3D { 0 };</span><b=
r><span>@@ -588,27 +574,27 @@</span><br><span>     struct session_id client=
_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };</span><br><span> </span><br><span> =
    now =3D 1005;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct session_id server_id =3D calculate_session_id_hmac(client_id, &amp;a=
ddr, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct session_id server_id =3D calculate_session_id_hmac(client=
_id, &amp;addr, key, handwindow, 0);</span><br><span> </span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session_id ex=
pected_server_id =3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session=
_id expected_server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0x=
ee } };</span><br><span>     /* We have to deal with different structs here=
 annoyingly */</span><br><span>     /* Linux has an unsigned short int as f=
amily_t and this is field is always</span><br><span>      * stored in host =
endianness even though the rest of the struct isn&#39;t=2E=2E=2E,</span><br=
><span>      * so Linux little endian differs from all BSD and Linux big en=
dian */</span><br><span>     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=
=3D sizeof(unsigned short int) &amp;&amp; ntohs(AF_INET) !=3D AF_INET)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct session_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, =
0xbe, 0x0a } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct session_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0=
x85, 0x12 } };</span><br><span>         expected_server_id =3D linuxle;</sp=
an><br><span>     }</span><br><span>     assert_memory_equal(expected_serve=
r_id=2Eid, server_id=2Eid, SID_SIZE);</span><br><span> </span><br><span>   =
  struct session_id server_id_m1 =3D</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr, hmac=
, handwindow, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       calculate_session_id_hmac(client_id, &amp;addr, key, handwindow, -1)=
;</span><br><span>     struct session_id server_id_p1 =3D</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        calculate_session_id_hmac(clien=
t_id, &amp;addr, hmac, handwindow, 1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        calculate_session_id_hmac(client_id, &amp;addr, =
key, handwindow, 1);</span><br><span>     struct session_id server_id_p2 =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        calculate_=
session_id_hmac(client_id, &amp;addr, hmac, handwindow, 2);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        calculate_session_id_hmac(c=
lient_id, &amp;addr, key, handwindow, 2);</span><br><span> </span><br><span=
>     assert_memory_not_equal(expected_server_id=2Eid, server_id_m1=2Eid, S=
ID_SIZE);</span><br><span>     assert_memory_not_equal(expected_server_id=
=2Eid, server_id_p1=2Eid, SID_SIZE);</span><br><span>@@ -618,20 +604,17 @@<=
/span><br><span>     now =3D 1062;</span><br><span> </span><br><span>     s=
truct session_id server_id2_m2 =3D</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr, hmac, =
handwindow, -2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     calculate_session_id_hmac(client_id, &amp;addr, key, handwindow, -2);<=
/span><br><span>     struct session_id server_id2_m1 =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        calculate_session_id_hmac(client=
_id, &amp;addr, hmac, handwindow, -1);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct session_id server_id2 =3D calculate_session_id_=
hmac(client_id, &amp;addr, hmac, handwindow, 0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        calculate_session_id_hmac(client_id, &=
amp;addr, key, handwindow, -1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct session_id server_id2 =3D calculate_session_id_hmac(=
client_id, &amp;addr, key, handwindow, 0);</span><br><span>     struct sess=
ion_id server_id2_p1 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        calculate_session_id_hmac(client_id, &amp;addr, hmac, handwindow=
, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        calcul=
ate_session_id_hmac(client_id, &amp;addr, key, handwindow, 1);</span><br><s=
pan> </span><br><span>     assert_memory_equal(server_id2_m2=2Eid, server_i=
d_m1=2Eid, SID_SIZE);</span><br><span>     assert_memory_equal(server_id2_m=
1=2Eid, expected_server_id=2Eid, SID_SIZE);</span><br><span>     assert_mem=
ory_equal(server_id2=2Eid, server_id_p1=2Eid, SID_SIZE);</span><br><span>  =
   assert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1827?usp=3Demail">change 1827</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e0=
6d6fc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1827 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--AvJgjFUPpJc=--


--===============0990614913378057028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0990614913378057028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0990614913378057028==--

