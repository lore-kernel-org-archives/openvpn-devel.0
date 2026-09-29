Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C83CA5FA5
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/kghq2f+ry2aHHv0whH2gWwvmcwso4vXZFUDducLOU=; b=Wkfj+Vl4CuTTCqOC4wci4lvcfI
	hCc7dU2lXJmk0fXMOJijyzpsKmtMOB4rbpd1BXFI8kaOTjxPKhenRQBi4YhhylZVLuEEu6asPWM0z
	udB6N0Py35PZXKo8/zRXZnsotcDoRGGzAImWaFcpH6ktpIP8d1MQJP6j+GNl+eJxa/rA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhx-00088B-VK;
	Tue, 29 Sep 2026 13:17:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhu-00087f-Qw
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gkNsSH1nf7tzGSIjF0qYBBctglsw5JSPxZrhoxeoVxo=; b=HEwbrN5G7JcAsHAIF31xBEeFaN
 y9TZm4eMviUPSYEROaIjzkb1S2x7LIpvn3zFHeqVxcHfhw1/fom6u9zJTUc21UQ1DGhobX+r1F+vz
 1mOWdA4Dgam+x8FvivAM8EyFktBIGwDlAWc9fBWFKSM/l3N3I9tpo7mAwxR+zdYG1Rmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gkNsSH1nf7tzGSIjF0qYBBctglsw5JSPxZrhoxeoVxo=; b=g
 7rXdmwdpM7yDG9V/Krm2ZBxZBIHwWl9ZyvtYvLvjNxgoXTiQ4M7zYKPMkRysbCXLuqpeI/RZpL3Ry
 m4Gd+e5z63pjbye5//8/FXfsvHfyWk6sdSIwGDB0CbB533uvbO/gvsjNyRJ4JPO1pWkX/SUfPNfIw
 a2nq46T3qkQJB7cg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXho-0007lp-5V for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:19 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e66390995so23507615e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687826; x=1791292626; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gkNsSH1nf7tzGSIjF0qYBBctglsw5JSPxZrhoxeoVxo=;
 b=CBNNukjgdUZRA/CJejSRIHPi2c3rrL8KeVj3Lxd8l+V6G+gHX9MD1QBkV4SbP4AvEx
 dTJRGHSKQffE2XsZ/Bw/lWkwXKFO6lcsAt+UerAOd3ziWZxQFm590z2NnHnVUpcPGsgA
 y9THci+ecRJHQb30e1z6dQlB375CXotFajyIr9OwsNVomE1tXAZn0/3AQxdPXrfKCKXN
 TjgzXHel7Y03R1Jt7p9ts7if8LNfjRigjsYgefXhamn+ffvs4cU0Vv6gYzWKjxk5I3NT
 RXj5MPgS6kBL4poU6luiY38z6/KHyYI8mnVNwLXKxe1qgGv5ZBZCkhPD4nlXo5daN8CA
 lPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687826; x=1791292626;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gkNsSH1nf7tzGSIjF0qYBBctglsw5JSPxZrhoxeoVxo=;
 b=Afxr74i6ZNOMFjHP9iH1u9OgzpPtfDNKG6CpHgXpTCoYNWxwJfSOlB8w4+7zurmaBL
 mvpvEZ3cXBaC6CRSHpHRJ6IOgONqX9KCYGu7JmXiQBIDV9zO/+nS4KSmaXNE0AMd8a/N
 cEcZrceVAVDeKau/QuvnFqRKAmCZ+TC4cjRPfFIDwRp4iZwprMKBWYCVGtYTx+yy16gb
 GOPWz30qO4HH5aYDc4BV9FfEfmcsoqUDEhtgPpqv/ZDF3I+/sj0hSOQQTmF8En/0bVo0
 Esa6a2gfkB3D+FYkUgJ9gBXXB8WhlqeJLFqhMEc3FRYMzMq8JUo2pTdA7aQL/mh4Gm1v
 pq+w==
X-Gm-Message-State: AFuF++ljkWuTYaCI1fKGysHvP8vgRelSrpqz8zBHhzJhebc5i9OWJ47r
 OznFcNRyu7YexViSNcV1TOkJkw8sC34IeNwXTZBwDkIIewXUsYcZxPLY72jRaVWPo0B7FXT4GbU
 2r2GjC4AC408hjLuFePPmpfu7XZMhCOc3YUZAiPy+BhvGMHXV3QslqE+REMhfw0Oy9LHj
X-Gm-Gg: AYBFou36dXpx58jOURCW+Kx7wth5Y+Nhikrx3yCyM+wO2IFfYm8WUP23OaFjHHU/KMO
 AluSrPz6/OM7HYwCbmfD0GBqM74VSiDze2IwKs10kJSgvHMi7lUZJ0mxgYvyJ9rw0XjBGfswFAH
 WnYMloRjGvF4UCppFHBJw6Nl1HLCdjt034CCvNuKjxfygJ20yyeYnRcViXkTq/R1xJq4S+zGNsx
 P1Ijfzwae5dssHg71lBHnLmYNZ/pVAraWPiYidirvz79junCOkp8U6tae17+hggmD4cf2AN0g1C
 fdC0BsWERbUjNWmhm0FkxtIkbDWCGrArWvbkIdMTJQshGHR6eVL1r9/kQC0QFPbqomhB9zjkQ6x
 aRMEiKw2yvWFwK0PVUrLDfsYtSzFdKDu0YLuF1xQ9+UUjKOECHGlCiTaJ0lQzWVO7YpTQJGm85Z
 uVT8/f3ni0BRgXlPePyOp7kNikVvgTIZEbhC00urQ9iICgaYW/KwmiahDFr+DESRJz7h5UH0FTu
 OQZiQRZ/ljPR6ZfTPR0J82sAKogz6m0BYv0L/HznH7qaYgsguU+vH4KrHFKYvy1spRYiCZ/a4pR
 vLeSTdeJJVQcz0imkWa5wYc8lu9v4bLWW/m2KN9EZOntWrRskMkAcm7ZOqvekSbjYvZelHA=
X-Received: by 2002:a05:600c:1d1c:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49ff06bcd5fmr214564255e9.8.1790687825461; 
 Tue, 29 Sep 2026 06:17:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00ed06ea7sm58723275e9.4.2026.09.29.06.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:17:05 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: 790dd1a9d62bf33296f84ae7a50acafd67007491
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <efc7405a0f4e8659fee5bba7723d55df3a30368c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXho-0007lp-5V
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Send
 tls-crypt-v2 SERVER_PROBE from the client
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
Content-Type: multipart/mixed; boundary="===============6781068316893609170=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6781068316893609170==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oeKVT8kdwNA="; charset=UTF-8

--oeKVT8kdwNA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail

to look a=
t the new patch set (#28)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Send tls-crypt-=
v2 SERVER_PROBE from the client
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

oob: Send tls-crypt-v2 SERVER_PROBE from the client

Wh=
en tls-crypt-v2 is configured, send the probe as P_CONTROL_OOB_WKC_V1
with =
the wrapped client key (WKc) appended, so the server can recover
the per-cl=
ient key and unwrap it=2E Without tls-crypt-v2 the probe stays a
plain P_CO=
NTROL_OOB_V1, unchanged=2E

  - drop the "skip probing under tls-crypt-v2" =
bail-out
  - make the WKc available on the probe's wrap context (mirroring
=
    do_init_crypto_tls()), so tls_wrap_control() appends it, and free it
  =
  with the rest of the probe's key material
  - choose the opcode (P_CONTRO=
L_OOB_WKC_V1 vs P_CONTROL_OOB_V1) and
    report "tls-crypt-v2" in the wrap=
ping log line

Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Signed-=
off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/client-opti=
ons=2Erst
M src/openvpn/oob_client=2Ec
2 files changed, 26 insertions(+), 2=
7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/59/1759/28

diff --git a/doc/man-sections/client-options=2Erst b/d=
oc/man-sections/client-options=2Erst
index 7749f37=2E=2E370ef60 100644
--- =
a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-optio=
ns=2Erst
@@ -625,9 +625,8 @@
   remote=2E
 
   The probe carries the same c=
ontrol-channel wrapping as a normal
-  connection (``--tls-auth`` or ``--tl=
s-crypt``, when configured)=2E With
-  ``--tls-crypt-v2`` the remotes are l=
eft in their configured order,
-  because the server cannot unwrap an out-o=
f-band probe yet=2E
+  connection (``--tls-auth``, ``--tls-crypt`` or ``--t=
ls-crypt-v2``,
+  when configured)=2E
 
   Only UDP remotes are probed, and=
 only when there are at least two
   remotes; remotes reached through a SOC=
KS proxy are not probed=2E The
diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec
index 4736816=2E=2E26922f0 100644
--- a/src/openvp=
n/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -73,6 +73,7 @@
     /*=
 What each probe is built from; only the request_id differs=2E */
     stru=
ct tls_auth_standalone *tas;
     struct session_id *client_sid;
+    int o=
pcode;
     struct oob_probe_request req;
 #ifdef TARGET_ANDROID
     bool =
fd_protected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket */
@=
@ -90,22 +91,11 @@
 /* Build the standalone wrapping context the probe is s=
ent with, mirroring the
  * one the server answers it with, keyed like ce, =
the entry every other probed
  * remote was checked against; without tls-au=
th/tls-crypt it stays in
- * TLS_WRAP_NONE and the probe goes out in plaint=
ext=2E Returns NULL (and logs)
- * for tls-crypt-v2, which the probe cannot=
 carry yet=2E */
+ * TLS_WRAP_NONE and the probe goes out in plaintext=2E *=
/
 static struct tls_auth_standalone *
 oob_probe_init_tls_auth_standalone(=
struct context *c, const struct connection_entry *ce,
                     =
               struct gc_arena *gc)
 {
-    /* tls-crypt-v2 wraps with a pe=
r-client key the server only learns from the
-     * wrapped client key (WK=
c) carried in the TLS handshake=2E An out-of-band
-     * probe carries no =
WKc, so the server cannot unwrap it; skip probing rather
-     * than send =
something unverifiable=2E */
-    if (ce->tls_crypt_v2_file)
-    {
-      =
  msg(D_LOW, "server-probe: not supported with tls-crypt-v2; using configur=
ed order");
-        return NULL;
-    }
-
     /* options=2Ece is not mapp=
ed yet; options_postprocess_mutate_ce() has already
      * copied any glob=
al key into ce=2E Loaded again per-connection later=2E */
     do_init_tls_=
wrap_key(c, ce);
@@ -116,6 +106,14 @@
     to=2Ereplay_window =3D c->option=
s=2Ereplay_window;
     to=2Ereplay_time =3D c->options=2Ereplay_time;
 
+ =
   /* Attach our WKc so tls_wrap_control() appends it=2E Only a client has =
one;
+     * a server config's tls-crypt-v2 key leaves the probe in TLS_WRA=
P_NONE, so
+     * it must not be sent as P_CONTROL_OOB_WKC_V1=2E */
+    i=
f (ce->tls_crypt_v2_file && c->options=2Etls_client)
+    {
+        to=2Et=
ls_wrap=2Etls_crypt_v2_wkc =3D &c->c1=2Eks=2Etls_crypt_v2_wkc;
+    }
+
   =
  struct tls_auth_standalone *tas =3D tls_auth_standalone_init(&to, gc);
 
=
     tls_init_control_channel_frame_parameters(&tas->frame, ce->tls_mtu);
@=
@ -134,6 +132,8 @@
     tls_auth_standalone_free(tas);
     free_key_ctx_bi=
(&c->c1=2Eks=2Etls_wrap_key);
     CLEAR(c->c1=2Eks=2Etls_wrap_key);
+    b=
uf_clear(&c->c1=2Eks=2Etls_crypt_v2_wkc);
+    free_buf(&c->c1=2Eks=2Etls_c=
rypt_v2_wkc);
     /* the raw key bytes too: do_init_crypto_tls_c1() may ne=
ver load a key over
      * them, so they would otherwise stay resident for=
 the process lifetime */
     secure_memzero(&c->c1=2Eks=2Eoriginal_wrap_ke=
ydata, sizeof(c->c1=2Eks=2Eoriginal_wrap_keydata));
@@ -153,7 +153,7 @@
   =
      return false;
     }
     *probe =3D tls_wrap_oob_standalone(&pc->tas=
->tls_wrap, pc->tas, pc->client_sid, &payload,
-                           =
          P_CONTROL_OOB_V1);
+                                     pc->opco=
de);
     return BLEN(probe) > 0;
 }
 
@@ -693,14 +693,8 @@
     }
 
     /=
* Wrapping context for the probe (tls-auth/tls-crypt, or plaintext if
-    =
 * neither)=2E NULL means this configuration cannot be probed; keep the
-  =
   * configured order=2E */
+     * neither)=2E */
     struct tls_auth_sta=
ndalone *tas =3D oob_probe_init_tls_auth_standalone(c, tmpl, &gc);
-    if =
(!tas)
-    {
-        gc_free(&gc);
-        return;
-    }
 
     struct =
probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };
    =
 struct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, =
true, &gc);
@@ -709,18 +703,24 @@
     /* Every probe is a single probe req=
uest TLV, wrapped (or sent in
      * plaintext) like any other control pac=
ket, with the client session id as
      * the sender session id=2E Each tr=
ansmission is built on its own, as each
-     * carries its own request_id=
=2E */
+     * carries its own request_id=2E With tls-crypt-v2 the probe mu=
st carry the
+     * wrapped client key so the server can recover the per-c=
lient key; that is
+     * a P_CONTROL_OOB_WKC_V1 message=2E Otherwise (tls=
-crypt v1, tls-auth, or
+     * plaintext) it is a plain P_CONTROL_OOB_V1=
=2E */
+    const bool is_v2 =3D (tas->tls_wrap=2Etls_crypt_v2_wkc !=3D NUL=
L);
     pc=2Etas =3D tas;
     pc=2Eclient_sid =3D &client_sid;
+    pc=2E=
opcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB_V1;
     pc=2Eid_ba=
se =3D (uint32_t)get_random();
     pc=2Ereq =3D (struct oob_probe_request)=
{
         =2Etimestamp =3D (uint64_t)now,
         =2Eflags =3D 0,
     };=

 
-    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRY=
PT)  ? "tls-crypt"
-                            : (tas->tls_wrap=2Emode =3D=
=3D TLS_WRAP_AUTH) ? "tls-auth"
-                                          =
                          : "none (plaintext)";
+    const char *wrap_name =
=3D is_v2                                    ? "tls-crypt-v2"
+            =
                : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? "tls-crypt=
"
+                            : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH=
)  ? "tls-auth"
+                                                          =
           : "none (plaintext)";
     msg(D_LOW, "server-probe: probing %d =
remote(s) with a %d ms window, control-channel wrapping: %s",
         l->l=
en, OOB_PROBE_WINDOW_MS, wrap_name);
 

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1759?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Gerrit-Chan=
ge-Number: 1759
Gerrit-PatchSet: 28
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ec=
om>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>

--oeKVT8kdwNA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #28</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Send tls-crypt-v2 SERVER_PROBE from the client<=
br><br>When tls-crypt-v2 is configured, send the probe as P_CONTROL_OOB_WKC=
_V1<br>with the wrapped client key (WKc) appended, so the server can recove=
r<br>the per-client key and unwrap it=2E Without tls-crypt-v2 the probe sta=
ys a<br>plain P_CONTROL_OOB_V1, unchanged=2E<br><br>  - drop the &quot;skip=
 probing under tls-crypt-v2&quot; bail-out<br>  - make the WKc available on=
 the probe&#39;s wrap context (mirroring<br>    do_init_crypto_tls()), so t=
ls_wrap_control() appends it, and free it<br>    with the rest of the probe=
&#39;s key material<br>  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CON=
TROL_OOB_V1) and<br>    report &quot;tls-crypt-v2&quot; in the wrapping log=
 line<br><br>Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0<br>Signed=
-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-section=
s/client-options=2Erst<br>M src/openvpn/oob_client=2Ec<br>2 files changed, =
26 insertions(+), 27 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1759/28</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-op=
tions=2Erst</span><br><span>index 7749f37=2E=2E370ef60 100644</span><br><sp=
an>--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/ma=
n-sections/client-options=2Erst</span><br><span>@@ -625,9 +625,8 @@</span><=
br><span>   remote=2E</span><br><span> </span><br><span>   The probe carrie=
s the same control-channel wrapping as a normal</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  connection (``--tls-auth`` or ``--tls-crypt``, =
when configured)=2E With</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  ``--tls-crypt-v2`` the remotes are left in their configured order,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  because the server cann=
ot unwrap an out-of-band probe yet=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls-=
crypt-v2``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  when c=
onfigured)=2E</span><br><span> </span><br><span>   Only UDP remotes are pro=
bed, and only when there are at least two</span><br><span>   remotes; remot=
es reached through a SOCKS proxy are not probed=2E The</span><br><span>diff=
 --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br>=
<span>index 4736816=2E=2E26922f0 100644</span><br><span>--- a/src/openvpn/o=
ob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><s=
pan>@@ -73,6 +73,7 @@</span><br><span>     /* What each probe is built from=
; only the request_id differs=2E */</span><br><span>     struct tls_auth_st=
andalone *tas;</span><br><span>     struct session_id *client_sid;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int opcode;</span><br><s=
pan>     struct oob_probe_request req;</span><br><span> #ifdef TARGET_ANDRO=
ID</span><br><span>     bool fd_protected[PROBE_AF_COUNT]; /* VPNService pr=
otect(), once per socket */</span><br><span>@@ -90,22 +91,11 @@</span><br><=
span> /* Build the standalone wrapping context the probe is sent with, mirr=
oring the</span><br><span>  * one the server answers it with, keyed like ce=
, the entry every other probed</span><br><span>  * remote was checked again=
st; without tls-auth/tls-crypt it stays in</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * TLS_WRAP_NONE and the probe goes out in plaintext=
=2E Returns NULL (and logs)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * for tls-crypt-v2, which the probe cannot carry yet=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * TLS_WRAP_NONE and the prob=
e goes out in plaintext=2E */</span><br><span> static struct tls_auth_stand=
alone *</span><br><span> oob_probe_init_tls_auth_standalone(struct context =
*c, const struct connection_entry *ce,</span><br><span>                    =
                struct gc_arena *gc)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* tls-crypt-v2 wraps with a per-clie=
nt key the server only learns from the</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * wrapped client key (WKc) carried in the TLS handsha=
ke=2E An out-of-band</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * probe carries no WKc, so the server cannot unwrap it; skip probing ra=
ther</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * than send =
something unverifiable=2E */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(D_LOW, &quot;server-probe: not supported with tls-crypt-v2; =
using configured order&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return NULL;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     /* options=2Ece is not mapped yet; options_postprocess_mutate=
_ce() has already</span><br><span>      * copied any global key into ce=2E =
Loaded again per-connection later=2E */</span><br><span>     do_init_tls_wr=
ap_key(c, ce);</span><br><span>@@ -116,6 +106,14 @@</span><br><span>     to=
=2Ereplay_window =3D c-&gt;options=2Ereplay_window;</span><br><span>     to=
=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Attach our WKc so tls_=
wrap_control() appends it=2E Only a client has one;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * a server config&#39;s tls-crypt-v2=
 key leaves the probe in TLS_WRAP_NONE, so</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * it must not be sent as P_CONTROL_OOB_WKC_V1=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&g=
t;tls_crypt_v2_file &amp;&amp; c-&gt;options=2Etls_client)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;=
c-&gt;c1=2Eks=2Etls_crypt_v2_wkc;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     struct tls_auth_standalone *tas =3D tls_auth_standalo=
ne_init(&amp;to, gc);</span><br><span> </span><br><span>     tls_init_contr=
ol_channel_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br>=
<span>@@ -134,6 +132,8 @@</span><br><span>     tls_auth_standalone_free(tas=
);</span><br><span>     free_key_ctx_bi(&amp;c-&gt;c1=2Eks=2Etls_wrap_key);=
</span><br><span>     CLEAR(c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;c-&gt;c1=2Eks=2Et=
ls_crypt_v2_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free_buf(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc);</span><br><span>     /* =
the raw key bytes too: do_init_crypto_tls_c1() may never load a key over</s=
pan><br><span>      * them, so they would otherwise stay resident for the p=
rocess lifetime */</span><br><span>     secure_memzero(&amp;c-&gt;c1=2Eks=
=2Eoriginal_wrap_keydata, sizeof(c-&gt;c1=2Eks=2Eoriginal_wrap_keydata));</=
span><br><span>@@ -153,7 +153,7 @@</span><br><span>         return false;</=
span><br><span>     }</span><br><span>     *probe =3D tls_wrap_oob_standalo=
ne(&amp;pc-&gt;tas-&gt;tls_wrap, pc-&gt;tas, pc-&gt;client_sid, &amp;payloa=
d,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                  P_CONTROL_OOB_V1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                     pc-&gt;opcode);</span=
><br><span>     return BLEN(probe) &gt; 0;</span><br><span> }</span><br><sp=
an> </span><br><span>@@ -693,14 +693,8 @@</span><br><span>     }</span><br>=
<span> </span><br><span>     /* Wrapping context for the probe (tls-auth/tl=
s-crypt, or plaintext if</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * neither)=2E NULL means this configuration cannot be probed; keep =
the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * configured =
order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * n=
either)=2E */</span><br><span>     struct tls_auth_standalone *tas =3D oob_=
probe_init_tls_auth_standalone(c, tmpl, &amp;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!tas)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span> </span><br><span>     struct probe_ctx pc =3D { =
=2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };</span><br><span>     st=
ruct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len, =
true, &amp;gc);</span><br><span>@@ -709,18 +703,24 @@</span><br><span>     =
/* Every probe is a single probe request TLV, wrapped (or sent in</span><br=
><span>      * plaintext) like any other control packet, with the client se=
ssion id as</span><br><span>      * the sender session id=2E Each transmiss=
ion is built on its own, as each</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * carries its own request_id=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * carries its own request_id=2E With tl=
s-crypt-v2 the probe must carry the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * wrapped client key so the server can recover the per=
-client key; that is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * a P_CONTROL_OOB_WKC_V1 message=2E Otherwise (tls-crypt v1, tls-auth=
, or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * plaintex=
t) it is a plain P_CONTROL_OOB_V1=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const bool is_v2 =3D (tas-&gt;tls_wrap=2Etls_crypt_=
v2_wkc !=3D NULL);</span><br><span>     pc=2Etas =3D tas;</span><br><span> =
    pc=2Eclient_sid =3D &amp;client_sid;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    pc=2Eopcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_C=
ONTROL_OOB_V1;</span><br><span>     pc=2Eid_base =3D (uint32_t)get_random()=
;</span><br><span>     pc=2Ereq =3D (struct oob_probe_request){</span><br><=
span>         =2Etimestamp =3D (uint64_t)now,</span><br><span>         =2Ef=
lags =3D 0,</span><br><span>     };</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *wrap_name =3D (tas-&gt;tls_=
wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-crypt&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            : (tas-&g=
t;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
                                  : &quot;none (plaintext)&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *wrap_name =3D=
 is_v2                                    ? &quot;tls-crypt-v2&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
  : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? &quot;tls-crypt&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
         : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH)  ? &quot;tls-auth=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                                        : &quot;none (plain=
text)&quot;;</span><br><span>     msg(D_LOW, &quot;server-probe: probing %d=
 remote(s) with a %d ms window, control-channel wrapping: %s&quot;,</span><=
br><span>         l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);</span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
759?usp=3Demail">change 1759</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1759?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1759 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 28 </div>
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
--oeKVT8kdwNA=--


--===============6781068316893609170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6781068316893609170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6781068316893609170==--

