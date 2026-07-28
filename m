Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239D5C54F4D
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AiTSH5LBxkQzD4XZC10bC26bMjq+OiikQzuhdnV7pD8=; b=TLazC/6wz0/q0XPAjxF77/Ago1
	bO/WGVI5elVaLy2nwEhyFaGNsJbx367GhjmRxcZBj8WC4mHdN62w2aoRjDneu80e5030z8BC7HnbU
	jARHG0qlrtUwU94q5zbVoUx+do2Kkx6wbfxctsGC1mIw2y9MiZ0IzN4omUP9XQ6kD9mE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLn-0001c7-8g;
	Tue, 28 Jul 2026 15:04:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLl-0001bt-01
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Va+l9fbWSoH6w58D9ducnYRdfzJVfJIxOkI8Dy1a4hA=; b=nE0wMjoSU2Ys9nFYliH2UPaRLO
 jcP1nWMDzc00fw2MwFlBd+YQNsZVbL/ZDeXlctZZmFcqvIHTrlPZj0j0oIFjm83aQ71G6LonwxD0j
 uJB3cInaUg5nfjd/3ou/uurtAK5OOTgcI1axQBRBtSmrdjAyLbNznKw+eaVmLVGe/qZg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Va+l9fbWSoH6w58D9ducnYRdfzJVfJIxOkI8Dy1a4hA=; b=g
 mbQdJJs4x/U4ZUSnmfk3P9FhuUsCsJZDb/hbor/oICKkZWAtqf1Jot9U51Y1nLWUx8q+pO0AmBV3r
 YNa/NFwdSn9rJCGvr464vZzKKQT5HLxY+SS41G83kmPd6V/ceBg3fK+lquRPLq9fCj6AeMRwbIjLY
 MP6vP6RozeXDNXNU=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLg-0000P5-Sf for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:06 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso1881109f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251038; x=1785855838; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Va+l9fbWSoH6w58D9ducnYRdfzJVfJIxOkI8Dy1a4hA=;
 b=f2WVU50c80wh3vqd5VyZlcP2lRprfXhOTwNbvscfnjLZTPJq8OrxmYeohujwf+6TI+
 oj9Fnyl6WMFLMxtiIUxrzgPpFIuTKJk8tav+KIrRDOw4Lr5rkrEeGN4CDihofLprCNsG
 cH/K2pFBpTLJwqPCiJoa71Pcy5WAKuVv1/FOjkllIH0gzJ6u4nPujkLG8vtonkESc9LQ
 7umCA2KbAapptvRYDUNvF6vSawmMNJKIpjxwGeAk4+MAvuiRkfJs4I4oTO+9rFmbsaZ+
 9ZKf8jzy/r6M4vvmbB4k9SplAhOUAR6+G2OhTjN15h16bUOJQd3Gfdp+kKPJ7KKcI9hA
 hmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251038; x=1785855838;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Va+l9fbWSoH6w58D9ducnYRdfzJVfJIxOkI8Dy1a4hA=;
 b=EIcbO5ncw9hhxfhIoOdqS3A3/dQhbJ2WQZvpeAVRmIyBBLkfu5jhUejQNSeRnpvNZ5
 LAVG+SGssc2jFsTZA8szp8beEkB78A7S8Q/Hclr663uvYPAnuBz6OBJZ/9CbwFortsRe
 mUGid/uqX3/81eqoIYnPrT774B3J2m5zuxMQ/Vbh0hITm8Aa78xeyn7QjDRHK0eba3qk
 6FcXUmPrYhojTX+h27+c5+5nK5onHj8xwBTBN3tQqA3madPzTeMK69B45oV/0WSfwuDr
 f6Z72lgpXUIJ2S0/Ii27a1RYJpiM457weiuS+Os7uFwHEy7FX7DxEjqGdaeQDXzu+/ai
 mIww==
X-Gm-Message-State: AOJu0Ywrf8lySpw15j5/hd9rrIheK3Fb5Vdr1lpbWZv/lm9SP3eiy790
 0ontXDcm5CoGGHwDvpbI/V+hsyhGPvKhX/Xz3kId3Mron6y7FetohyzVbEKfOD9kPxycqJG+awK
 0pLt302lEFyOyDKktkA4mVhhBlSe1b4cOtfCM5bdRGf9pATT625ttVHQKUXAzlwBKWNe0
X-Gm-Gg: AR+sD13gc9iYzxZnZPRa5ipc5cqE/y8eAx234SrU+OJ/u5ijBvCMRQbdm+uAeZfJEVI
 VxSHy81N70sZZW0AhsqEpMWNRNhguQvd7nrKt1HMNppgeIJ5fDhZx2TIeVOb3mi3zIBvRiR78jc
 Ix7fdQX1NtE0+vCKVtsGcA3nMJzmgxZuKlspTMCPnCf5eitkMv/7z6Ls1sjMg/DP8VzRt6vh8Kr
 0WHM0j5EtEJ7OzIg5Zb1iiKoI88B8xA6rwNYfK+7h4SGlD9EzINM1z6tvVxoHfrqvEfjQ3QFykT
 OPD0pTcHJsY+22pgepm9v5CsSBrDs6x6ADWMuA/tLNo2onQxwNFb/78UHHRBlXVNeMh1EiAOnfF
 vV016yZwwBdm2M8+u4QnaxjBAJvXuy2eXuW/lsciz0hROoODK36Sr3wX1AXKNq0TjH/lGkE/P+H
 oWlh/EPeIHH6qL7rGjBDUAs27c6jMH0FU+p8AKEl2JVib7WKlg9kdHYCUeeCJnj0tSliEJBxLBm
 AaXd0F88qb9A609E8uneJUC5AK0FElFg/c9Crz4omeFQTrY5h7o7tt0DB8Z6ik/183j
X-Received: by 2002:a05:6000:1861:b0:47f:59ef:bbb2 with SMTP id
 ffacd0b85a97d-47fb1e9272fmr3547022f8f.17.1785251038157; 
 Tue, 28 Jul 2026 08:03:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm59270865f8f.37.2026.07.28.08.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:57 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: 540aff5e0dadb70c55af4087b3724dda3deab55f
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d85ef745c3a9bee9fe12229e201142872e05ccb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLg-0000P5-Sf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: Send
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5391624562661382554=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5391624562661382554==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hWRwqRmEEt4="; charset=UTF-8

--hWRwqRmEEt4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1759?usp=3Demail

to look at the new patch set (#11)=2E
=


Change subject: oob: Send tls-crypt-v2 SERVER_PROBE from the client
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Send tls-cr=
ypt-v2 SERVER_PROBE from the client

When tls-crypt-v2 is configured, send =
the probe as P_CONTROL_OOB_WKC_V1
with the wrapped client key (WKc) appende=
d, so the server can recover the
per-client key and unwrap it=2E Without tl=
s-crypt-v2 the probe stays a plain
P_CONTROL_OOB_V1, unchanged=2E

  - drop=
 the "skip probing under tls-crypt-v2" bail-out
  - make the WKc available =
on the probe's wrap context (mirroring
    init_instance()), so tls_wrap_co=
ntrol() appends it
  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL=
_OOB_V1) and report
    "tls-crypt-v2" in the wrapping log line

Change-Id:=
 I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Signed-off-by: Lev Stipakov <lev=
@openvpn=2Enet>
---
M src/openvpn/oob_client=2Ec
1 file changed, 24 inserti=
ons(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/59/1759/11

diff --git a/src/openvpn/oob_client=2Ec b/src=
/openvpn/oob_client=2Ec
index 5700149=2E=2E694dfbc 100644
--- a/src/openvpn=
/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -105,19 +105,9 @@
     =
 * supported; the first entry's wrapping is used for all=2E) */
     const =
struct connection_entry *ce =3D c->options=2Econnection_list->array[0];
 
-=
    /* tls-crypt-v2 wraps with a per-client key the server only learns from=
 the
-     * wrapped client key (WKc) carried in the TLS handshake=2E An ou=
t-of-band
-     * probe carries no WKc, so the server cannot unwrap it; ski=
p probing rather
-     * than send something unverifiable=2E */
-    if (ce=
->tls_crypt_v2_file)
-    {
-        msg(D_LOW, "server-probe: not supporte=
d with tls-crypt-v2; using configured order");
-        return NULL;
-    }=

-
-    /* Load the tls-auth/tls-crypt key material into c->c1=2Eks (a no-o=
p if neither
-     * is configured)=2E This is run again per-connection lat=
er; calling it early
-     * here is harmless=2E */
+    /* Load the tls-au=
th/tls-crypt(-v2) key material into c->c1=2Eks (a no-op if
+     * none is =
configured)=2E This is run again per-connection later; calling it
+     * e=
arly here is harmless=2E */
     do_init_tls_wrap_key(c, ce);
 
     struct=
 tls_options to;
@@ -126,6 +116,15 @@
     to=2Ereplay_window =3D c->option=
s=2Ereplay_window;
     to=2Ereplay_time =3D c->options=2Ereplay_time;
 
+ =
   /* tls-crypt-v2 wraps with a per-client key the server learns from the
+=
     * wrapped client key (WKc)=2E init_tls_wrap_ctx() loaded the per-clien=
t key
+     * into the wrap context; make the WKc available too so the prob=
e can append
+     * it (as a P_CONTROL_OOB_WKC_V1 message), mirroring init=
_instance()=2E */
+    if (ce->tls_crypt_v2_file)
+    {
+        to=2Etls_=
wrap=2Etls_crypt_v2_wkc =3D &c->c1=2Eks=2Etls_crypt_v2_wkc;
+    }
+
     s=
truct tls_auth_standalone *tas =3D tls_auth_standalone_init(&to, gc);
 
   =
  /* Control-channel frame and work buffers, mirroring do_init_frame_tls()=
=2E */
@@ -493,8 +492,15 @@
         return;
     }
 
+    /* With tls-cryp=
t-v2 the probe must carry the wrapped client key so the
+     * server can =
recover the per-client key; that is a P_CONTROL_OOB_WKC_V1
+     * message=
=2E Otherwise (tls-crypt v1, tls-auth, or plaintext) it is a plain
+     * =
P_CONTROL_OOB_V1=2E */
+    const bool is_v2 =3D (tas->tls_wrap=2Etls_crypt=
_v2_wkc !=3D NULL);
+    const int probe_opcode =3D is_v2 ? P_CONTROL_OOB_W=
KC_V1 : P_CONTROL_OOB_V1;
+
     struct buffer probe =3D
-        tls_wrap_=
oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload, P_CONTROL_OOB_V1=
);
+        tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payl=
oad, probe_opcode);
     if (!BLEN(&probe))
     {
         msg(D_LOW, "ser=
ver-probe: could not wrap probe packet; using configured order");
@@ -504,9=
 +510,10 @@
         return;
     }
 
-    const char *wrap_name =3D (tas->=
tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
-                    =
        : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
-       =
                                                             : "none (plain=
text)";
+    const char *wrap_name =3D is_v2                               =
     ? "tls-crypt-v2"
+                            : (tas->tls_wrap=2Emode =
=3D=3D TLS_WRAP_CRYPT) ? "tls-crypt"
+                            : (tas->t=
ls_wrap=2Emode =3D=3D TLS_WRAP_AUTH)  ? "tls-auth"
+                       =
                                              : "none (plaintext)";
     ms=
g(D_LOW, "server-probe: probing %d remote(s) with a %d ms window, control-c=
hannel wrapping: %s",
         l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5cc100dd7dc810d7d=
1e6f29bb57584905fbcf4a0
Gerrit-Change-Number: 1759
Gerrit-PatchSet: 11
Gerr=
it-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--hWRwqRmEEt4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #11</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1759?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Sen=
d tls-crypt-v2 SERVER_PROBE from the client<br><br>When tls-crypt-v2 is con=
figured, send the probe as P_CONTROL_OOB_WKC_V1<br>with the wrapped client =
key (WKc) appended, so the server can recover the<br>per-client key and unw=
rap it=2E Without tls-crypt-v2 the probe stays a plain<br>P_CONTROL_OOB_V1,=
 unchanged=2E<br><br>  - drop the &quot;skip probing under tls-crypt-v2&quo=
t; bail-out<br>  - make the WKc available on the probe&#39;s wrap context (=
mirroring<br>    init_instance()), so tls_wrap_control() appends it<br>  - =
choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL_OOB_V1) and report<br>=
    &quot;tls-crypt-v2&quot; in the wrapping log line<br><br>Change-Id: I5c=
c100dd7dc810d7d1e6f29bb57584905fbcf4a0<br>Signed-off-by: Lev Stipakov &lt;l=
ev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob_client=2Ec<br>1 file chang=
ed, 24 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1759/11</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><=
br><span>index 5700149=2E=2E694dfbc 100644</span><br><span>--- a/src/openvp=
n/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br=
><span>@@ -105,19 +105,9 @@</span><br><span>      * supported; the first en=
try&#39;s wrapping is used for all=2E) */</span><br><span>     const struct=
 connection_entry *ce =3D c-&gt;options=2Econnection_list-&gt;array[0];</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
tls-crypt-v2 wraps with a per-client key the server only learns from the</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * wrapped client ke=
y (WKc) carried in the TLS handshake=2E An out-of-band</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     * probe carries no WKc, so the server=
 cannot unwrap it; skip probing rather</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * than send something unverifiable=2E */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (ce-&gt;tls_crypt_v2_file)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;server-probe:=
 not supported with tls-crypt-v2; using configured order&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* Load the tls-auth/tls-crypt key material into c-&gt;c1=2Eks (a =
no-op if neither</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* is configured)=2E This is run again per-connection later; calling it earl=
y</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * here is harml=
ess=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Loa=
d the tls-auth/tls-crypt(-v2) key material into c-&gt;c1=2Eks (a no-op if</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * none is config=
ured)=2E This is run again per-connection later; calling it</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * early here is harmless=2E */=
</span><br><span>     do_init_tls_wrap_key(c, ce);</span><br><span> </span>=
<br><span>     struct tls_options to;</span><br><span>@@ -126,6 +116,15 @@<=
/span><br><span>     to=2Ereplay_window =3D c-&gt;options=2Ereplay_window;<=
/span><br><span>     to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 tls-crypt-v2 wraps with a per-client key the server learns from the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * wrapped client key =
(WKc)=2E init_tls_wrap_ctx() loaded the per-client key</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * into the wrap context; make the W=
Kc available too so the probe can append</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * it (as a P_CONTROL_OOB_WKC_V1 message), mirrori=
ng init_instance()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;c-&gt;c1=2Eks=2Etls_=
crypt_v2_wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  struct tls_auth_standalone *tas =3D tls_auth_standalone_init(&amp;to, gc)=
;</span><br><span> </span><br><span>     /* Control-channel frame and work =
buffers, mirroring do_init_frame_tls()=2E */</span><br><span>@@ -493,8 +492=
,15 @@</span><br><span>         return;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* With tl=
s-crypt-v2 the probe must carry the wrapped client key so the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * server can recover the per=
-client key; that is a P_CONTROL_OOB_WKC_V1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * message=2E Otherwise (tls-crypt v1, tls-auth=
, or plaintext) it is a plain</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * P_CONTROL_OOB_V1=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const bool is_v2 =3D (tas-&gt;tls_wrap=2Etls_crypt_=
v2_wkc !=3D NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const int probe_opcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB_=
V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     struct buffer probe =3D</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;cl=
ient_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wra=
p, tas, &amp;client_sid, &amp;payload, probe_opcode);</span><br><span>     =
if (!BLEN(&amp;probe))</span><br><span>     {</span><br><span>         msg(=
D_LOW, &quot;server-probe: could not wrap probe packet; using configured or=
der&quot;);</span><br><span>@@ -504,9 +510,10 @@</span><br><span>         r=
eturn;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const char *wrap_name =3D (tas-&gt;tls_wrap=
=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-crypt&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                            : (tas-&gt;tl=
s_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                      =
                              : &quot;none (plaintext)&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *wrap_name =3D is_=
v2                                    ? &quot;tls-crypt-v2&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                            : =
(tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? &quot;tls-crypt&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
     : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH)  ? &quot;tls-auth&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                                                    : &quot;none (plaintext=
)&quot;;</span><br><span>     msg(D_LOW, &quot;server-probe: probing %d rem=
ote(s) with a %d ms window, control-channel wrapping: %s&quot;,</span><br><=
span>         l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);</span><br><span> =
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail">change 1759</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5cc100dd7dc810d7=
d1e6f29bb57584905fbcf4a0 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1759 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--hWRwqRmEEt4=--


--===============5391624562661382554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5391624562661382554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5391624562661382554==--

