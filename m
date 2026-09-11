Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F7FC88E58
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QNGNfolyRYGL50vlNyc9BA4UATTlcausEh4bygCfCY=; b=GAY5OILorrtg/wmcdaPep7a+s6
	80vuJsTsp2HT0ejl7dyWRDoXLDdPawySHUDCa7w+QNcPUiV0pe+YyrmwD9yoLJ/6OK7CplBlaPgPu
	1WDfGKULg2OipCd6zT0PKjZ9UlY2s4gU9oVjQKelN6ydwsOOTEdhv+63biMHulTtXjyE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIF-0006wN-I8;
	Fri, 11 Sep 2026 09:11:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xIB-0006vd-UC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UeCpyECVJ50sZ/2FZpSs6srciXC3UK+NrRC9Os6puIA=; b=d5xeJYH43HB2fxbS7z9Rl2+xaC
 oj0ystevrGk7ZKhQH+1aTJYGKn8KJVgIlkvlY9Kn4qOTsoiwt5EPsDOsKCV22/YD2nw3lbp6xDhcv
 u8Lz35TYAaEPL1fqxHEObJFZFP+iPg0GeTlCRCwVprSbMplKGHsLNciyDy1MKesrLm5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UeCpyECVJ50sZ/2FZpSs6srciXC3UK+NrRC9Os6puIA=; b=h
 IGvlO139C2bYZ7gY3vJ6aUwMjmt7fuY00Ku21MAdS9FoAkNBSNCuH/UqSxA68GHVmogb++WlIZsd/
 4Gue78EmAIFFPPOTR+pJpcn/I7DCW2OtszjSWJFCwJv0adBX6jCBRiFhcdC/xO5o2mfnNRMV/Ttf/
 GQ1BTu2WQqvTyScY=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xI8-0006ca-GF for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:32 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so4212055e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117882; x=1789722682; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UeCpyECVJ50sZ/2FZpSs6srciXC3UK+NrRC9Os6puIA=;
 b=DQFHdwZP5hPWoRNRtVzIWqgBm4AP5n/fqE+JHJ9zblfOP8c0bBpRZhvE+ZQO6sOIPB
 gi72SrC9Rr9ztkd3Wy/yHU5OX5LUvkonLgKZ/itvOlw56cLTohZ/nyjaa58IJS5OyXuh
 lfF2M7tOH6AVYv9acAQ/kMJe6DRTmv/O5+DGaXo2i0/tcCD7Za5WfC01Ulq/z0qOY+np
 qdmZ4PbrrGcYHmxeIKT1RAKHjP0cBtO9/Oz1x7e8T8pYIQoxg3gl24CbbJ895rpbL/ra
 wpwCwtMiR1cUlzWmj7RAXEPIIpXgtdmP4Q7zuX1s+QjF73LKCdOOeLyX0Hc2CSBPrAyv
 yDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117882; x=1789722682;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UeCpyECVJ50sZ/2FZpSs6srciXC3UK+NrRC9Os6puIA=;
 b=lkx1WZLwil0LPOCfkFS3avsXKSMAEJBlAWXY/Je66kOtO5MUHfspP4AB9HcDyaS2zn
 PBnaMIc+7f3vBc4uGaL5vhAE1Xyhk3F9eeY2dJBzqjFdPZfg3iSxLpKNqlhE1AACjAuv
 ik5WtKmedSoggEtGTCqwECdAcimnocZlfmjMn9O412DD+3+C15EGex01kt+wL15jLk68
 YwIyTujSy3WVVOHz1ioikCpB5uOuZUDtuttOJPlvuZnSr9IQuZxiknUecrt0FDW7Vv72
 tJNEFvskEk++RpdqaAIhKfhdlS23lM0emZzJmQSEjmnnPq5eKAlRw/We2SCQu57TOIts
 MfUQ==
X-Gm-Message-State: AFuF++lYgzjRJMBno6nnZnf+S8A+0PCcu/9EZzudzW/fV+wt/+FoDKOp
 LPDVPc8PrKd5wySplHiXsC27zWXiS66sF1CWPYd+UlXaE8baxp37PmBov1o/kQuUVwocPquueXA
 1O093+d2uiFOQY2FoWHDPptdvJIp3++/Zw98hmO4CimSVWs8/xJi2EnG8MWS0ugrCNVuVu2Ad+r
 7KMsR7yw==
X-Gm-Gg: AYBFou3LKzJ5M5Epni9SGkiCMPdjMJFMi+7ET8r2kwBGfhXEpgN209/npqFA+/fbY9D
 uBzigA1x9ehDtVMOyvkF+N8unZ0PGbHA5e6KEcyI/pZte6qy+ruRhEJSeHcyUgsz+55fGqu5Yz/
 Z6tF7UM/T8RTcK9lADVxuRfHdsZ8+82eJ/8t/LDCbknIXGUfzCe4n6Vv8+L3CGs3OH9lX7usNy5
 DKuSMPg7utZxW6QTdmzoUUwN04x7WEeAxTyKI2TENvdG4yxnqMwLnZE2a0gmUp4vASgVReZhp1s
 NlP9e1rA23T2pFaN8eiIOeEU3r0ICOXEN4itzByPnjMhtgt63DnFztTJ7iqckuRO4wo0eneeOjQ
 XVjMaFf8WESKPSYoVe6faOYsOvgCmJG7x/VlWafWfQujqbGp8lgLE6o4kGCwx75OD9wPqU7COKQ
 u1HESG0jAszlmsA6bH606dI01yYgq1ylzqKFI+YprSttFUCI8NABxNEuvOUqfRnDdxiPWzJWZMX
 rtb/3FZi72Qf+DG3MVeickg0hFRzpJXKRq2b11OU2isbnnv88rKyo9KPR/MW1we/vrkxXcUOsBe
 sEPwL06tFvSOEzVrla93bSp2rlGf8IDx43X2RKb8wf7iBo/AZiK1B6QjCMkHGXeneOCYnJZF
X-Received: by 2002:a05:600c:1385:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-49e61878ab9mr55235965e9.3.1789117881684; 
 Fri, 11 Sep 2026 02:11:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49db038401fsm129320205e9.13.2026.09.11.02.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:20 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: d9bd55db2ac03da4ece97aab53b207bfc2a349f1
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54d817b05ef977cdfea38343e2bbf2d950d89094-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xI8-0006ca-GF
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0968127457631908527=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0968127457631908527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KjIElw9FPwM="; charset=UTF-8

--KjIElw9FPwM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1759?usp=3Demail

to look at the new patch set (#17)=2E
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
M doc/man-sections/client-options=2Erst
M src/openvpn/o=
ob_client=2Ec
2 files changed, 28 insertions(+), 30 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1759/17

diff=
 --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-op=
tions=2Erst
index cf9883f=2E=2Eea8f205 100644
--- a/doc/man-sections/client=
-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -618,9 +618,8=
 @@
   group is treated as best=2E
 
   The probe carries the same control-=
channel wrapping as a normal
-  connection (``--tls-auth`` or ``--tls-crypt=
``, when configured)=2E With
-  ``--tls-crypt-v2`` the remotes are left in =
their configured order,
-  because the server cannot unwrap an out-of-band =
probe yet=2E
+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls-cryp=
t-v2``,
+  when configured)=2E
 
   Only UDP remotes are probed=2E Remotes =
that answered are tried first, in
   the order described above; all other r=
emotes, including TCP ones, follow
diff --git a/src/openvpn/oob_client=2Ec =
b/src/openvpn/oob_client=2Ec
index 7d429f0=2E=2E5ae8462 100644
--- a/src/op=
envpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -80,9 +80,7 @@
  *=
 the tls_auth_standalone the server uses to answer it=2E With neither tls-a=
uth
  * nor tls-crypt configured the context stays in TLS_WRAP_NONE and the=
 probe is
  * sent in plaintext, exactly as before; with either configured =
the probe is
- * authenticated/encrypted like any other control packet=2E R=
eturns NULL (and
- * logs) for configurations the probe cannot wrap yet, in=
 which case the caller
- * skips probing and keeps the configured remote or=
der=2E */
+ * authenticated/encrypted like any other control packet=2E */
 =
static struct tls_auth_standalone *
 oob_probe_init_tls_auth_standalone(str=
uct context *c, struct gc_arena *gc)
 {
@@ -95,19 +93,9 @@
      * supporte=
d; the first entry's wrapping is used for all=2E) */
     const struct conn=
ection_entry *ce =3D c->options=2Econnection_list->array[0];
 
-    /* tls-=
crypt-v2 wraps with a per-client key the server only learns from the
-     =
* wrapped client key (WKc) carried in the TLS handshake=2E An out-of-band
-=
     * probe carries no WKc, so the server cannot unwrap it; skip probing r=
ather
-     * than send something unverifiable=2E */
-    if (ce->tls_crypt=
_v2_file)
-    {
-        msg(D_LOW, "server-probe: not supported with tls-=
crypt-v2; using configured order");
-        return NULL;
-    }
-
-    /* =
Load the tls-auth/tls-crypt key material into c->c1=2Eks (a no-op if neithe=
r
-     * is configured)=2E This is run again per-connection later; calling=
 it early
-     * here is harmless=2E */
+    /* Load the tls-auth/tls-cryp=
t(-v2) key material into c->c1=2Eks (a no-op if
+     * none is configured)=
=2E This is run again per-connection later; calling it
+     * early here i=
s harmless=2E */
     do_init_tls_wrap_key(c, ce);
 
     struct tls_option=
s to;
@@ -116,6 +104,15 @@
     to=2Ereplay_window =3D c->options=2Ereplay_=
window;
     to=2Ereplay_time =3D c->options=2Ereplay_time;
 
+    /* tls-c=
rypt-v2 wraps with a per-client key the server learns from the
+     * wrap=
ped client key (WKc)=2E init_tls_wrap_ctx() loaded the per-client key
+    =
 * into the wrap context; make the WKc available too so the probe can appen=
d
+     * it (as a P_CONTROL_OOB_WKC_V1 message), mirroring init_instance()=
=2E */
+    if (ce->tls_crypt_v2_file)
+    {
+        to=2Etls_wrap=2Etls_=
crypt_v2_wkc =3D &c->c1=2Eks=2Etls_crypt_v2_wkc;
+    }
+
     struct tls_a=
uth_standalone *tas =3D tls_auth_standalone_init(&to, gc);
 
     /* Contro=
l-channel frame and work buffers, mirroring do_init_frame_tls()=2E */
@@ -5=
42,14 +539,8 @@
     struct gc_arena gc =3D gc_new();
 
     /* Wrapping co=
ntext for the probe (tls-auth/tls-crypt, or plaintext if
-     * neither)=
=2E NULL means this configuration cannot be probed; keep the
-     * config=
ured order=2E */
+     * neither)=2E */
     struct tls_auth_standalone *ta=
s =3D oob_probe_init_tls_auth_standalone(c, &gc);
-    if (!tas)
-    {
-  =
      gc_free(&gc);
-        return;
-    }
 
     /* A single random sessi=
on id identifies all of our probes; servers echo it
      * back in the rep=
ly's peer_session_id, letting us reject spoofed replies=2E */
@@ -596,8 +58=
7,15 @@
         return;
     }
 
+    /* With tls-crypt-v2 the probe must =
carry the wrapped client key so the
+     * server can recover the per-clie=
nt key; that is a P_CONTROL_OOB_WKC_V1
+     * message=2E Otherwise (tls-cr=
ypt v1, tls-auth, or plaintext) it is a plain
+     * P_CONTROL_OOB_V1=2E *=
/
+    const bool is_v2 =3D (tas->tls_wrap=2Etls_crypt_v2_wkc !=3D NULL);
+=
    const int probe_opcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB=
_V1;
+
     struct buffer probe =3D
-        tls_wrap_oob_standalone(&tas->=
tls_wrap, tas, &client_sid, &payload, P_CONTROL_OOB_V1);
+        tls_wrap_=
oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload, probe_opcode);
 =
    if (!BLEN(&probe))
     {
         msg(D_LOW, "server-probe: could not =
wrap probe packet; using configured order");
@@ -607,9 +605,10 @@
         =
return;
     }
 
-    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=
=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
-                            : (tas->tls=
_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
-                          =
                                          : "none (plaintext)";
+    const =
char *wrap_name =3D is_v2                                    ? "tls-crypt-v=
2"
+                            : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRY=
PT) ? "tls-crypt"
+                            : (tas->tls_wrap=2Emode =3D=
=3D TLS_WRAP_AUTH)  ? "tls-auth"
+                                         =
                            : "none (plaintext)";
     msg(D_LOW, "server-p=
robe: probing %d remote(s) with a %d ms window, control-channel wrapping: %=
s",
         l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fb=
cf4a0
Gerrit-Change-Number: 1759
Gerrit-PatchSet: 17
Gerrit-Owner: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--KjIElw9FPwM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #17</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
ev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M=
 src/openvpn/oob_client=2Ec<br>2 files changed, 28 insertions(+), 30 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/59/1759/17</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/cl=
ient-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>=
index cf9883f=2E=2Eea8f205 100644</span><br><span>--- a/doc/man-sections/cl=
ient-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2E=
rst</span><br><span>@@ -618,9 +618,8 @@</span><br><span>   group is treated=
 as best=2E</span><br><span> </span><br><span>   The probe carries the same=
 control-channel wrapping as a normal</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  connection (``--tls-auth`` or ``--tls-crypt``, when confi=
gured)=2E With</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--t=
ls-crypt-v2`` the remotes are left in their configured order,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  because the server cannot unwrap =
an out-of-band probe yet=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls-crypt-v2``=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  when configured)=
=2E</span><br><span> </span><br><span>   Only UDP remotes are probed=2E Rem=
otes that answered are tried first, in</span><br><span>   the order describ=
ed above; all other remotes, including TCP ones, follow</span><br><span>dif=
f --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br=
><span>index 7d429f0=2E=2E5ae8462 100644</span><br><span>--- a/src/openvpn/=
oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><=
span>@@ -80,9 +80,7 @@</span><br><span>  * the tls_auth_standalone the serv=
er uses to answer it=2E With neither tls-auth</span><br><span>  * nor tls-c=
rypt configured the context stays in TLS_WRAP_NONE and the probe is</span><=
br><span>  * sent in plaintext, exactly as before; with either configured t=
he probe is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * authent=
icated/encrypted like any other control packet=2E Returns NULL (and</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * logs) for configurations t=
he probe cannot wrap yet, in which case the caller</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * skips probing and keeps the configured remo=
te order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * au=
thenticated/encrypted like any other control packet=2E */</span><br><span> =
static struct tls_auth_standalone *</span><br><span> oob_probe_init_tls_aut=
h_standalone(struct context *c, struct gc_arena *gc)</span><br><span> {</sp=
an><br><span>@@ -95,19 +93,9 @@</span><br><span>      * supported; the firs=
t entry&#39;s wrapping is used for all=2E) */</span><br><span>     const st=
ruct connection_entry *ce =3D c-&gt;options=2Econnection_list-&gt;array[0];=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* tls-crypt-v2 wraps with a per-client key the server only learns from th=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * wrapped clien=
t key (WKc) carried in the TLS handshake=2E An out-of-band</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * probe carries no WKc, so the se=
rver cannot unwrap it; skip probing rather</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * than send something unverifiable=2E */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (ce-&gt;tls_crypt_v2_fi=
le)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;server-pr=
obe: not supported with tls-crypt-v2; using configured order&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* Load the tls-auth/tls-crypt key material into c-&gt;c1=2E=
ks (a no-op if neither</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * is configured)=2E This is run again per-connection later; calling i=
t early</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * here is=
 harmless=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Load the tls-auth/tls-crypt(-v2) key material into c-&gt;c1=2Eks (a no-o=
p if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * none is =
configured)=2E This is run again per-connection later; calling it</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * early here is harmless=
=2E */</span><br><span>     do_init_tls_wrap_key(c, ce);</span><br><span> <=
/span><br><span>     struct tls_options to;</span><br><span>@@ -116,6 +104,=
15 @@</span><br><span>     to=2Ereplay_window =3D c-&gt;options=2Ereplay_wi=
ndow;</span><br><span>     to=2Ereplay_time =3D c-&gt;options=2Ereplay_time=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* tls-crypt-v2 wraps with a per-client key the server learns from the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wrapped clien=
t key (WKc)=2E init_tls_wrap_ctx() loaded the per-client key</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * into the wrap context; make=
 the WKc available too so the probe can append</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * it (as a P_CONTROL_OOB_WKC_V1 message), m=
irroring init_instance()=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;c-&gt;c1=2Eks=
=2Etls_crypt_v2_wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     struct tls_auth_standalone *tas =3D tls_auth_standalone_init(&amp;=
to, gc);</span><br><span> </span><br><span>     /* Control-channel frame an=
d work buffers, mirroring do_init_frame_tls()=2E */</span><br><span>@@ -542=
,14 +539,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span> </span><br><span>     /* Wrapping context for the probe (tls-auth=
/tls-crypt, or plaintext if</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * neither)=2E NULL means this configuration cannot be probed; ke=
ep the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * configur=
ed order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* neither)=2E */</span><br><span>     struct tls_auth_standalone *tas =3D o=
ob_probe_init_tls_auth_standalone(c, &amp;gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!tas)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span> </span><br><span>     /* A single random session id i=
dentifies all of our probes; servers echo it</span><br><span>      * back i=
n the reply&#39;s peer_session_id, letting us reject spoofed replies=2E */<=
/span><br><span>@@ -596,8 +587,15 @@</span><br><span>         return;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* With tls-crypt-v2 the probe must carry the wrapped c=
lient key so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * server can recover the per-client key; that is a P_CONTROL_OOB_WKC_V1</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * message=2E Oth=
erwise (tls-crypt v1, tls-auth, or plaintext) it is a plain</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * P_CONTROL_OOB_V1=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool is_v2 =3D =
(tas-&gt;tls_wrap=2Etls_crypt_v2_wkc !=3D NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const int probe_opcode =3D is_v2 ? P_CONTR=
OL_OOB_WKC_V1 : P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     struct buffer probe =3D</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        tls_wrap_oob_standalone(&amp;=
tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload, P_CONTROL_OOB_V1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_s=
tandalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload, probe_=
opcode);</span><br><span>     if (!BLEN(&amp;probe))</span><br><span>     {=
</span><br><span>         msg(D_LOW, &quot;server-probe: could not wrap pro=
be packet; using configured order&quot;);</span><br><span>@@ -607,9 +605,10=
 @@</span><br><span>         return;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *wra=
p_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-cry=
pt&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;tls=
-auth&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                                                          : &quot;none (pla=
intext)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *wrap_name =3D is_v2                                    ? &quot;t=
ls-crypt-v2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)=
 ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP=
_AUTH)  ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                                                =
     : &quot;none (plaintext)&quot;;</span><br><span>     msg(D_LOW, &quot;=
server-probe: probing %d remote(s) with a %d ms window, control-channel wra=
pping: %s&quot;,</span><br><span>         l-&gt;len, OOB_PROBE_WINDOW_MS, w=
rap_name);</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail"=
>change 1759</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1759 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--KjIElw9FPwM=--


--===============0968127457631908527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0968127457631908527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0968127457631908527==--

