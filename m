Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B599BC88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wRKOZ0zj70WydH/GUl2bzEJM8sRoKeRkKoMsNbc6qeY=; b=GqVqSGfgsRgS7YuTaNP/dKifHI
	4LyZxDvFwaqEGGqZnH8Zf2iZTcDYzdZLIu8v5PkzpAodpJkS+A606TgAsxfht04uyLuRLYEzHhj0K
	8n2c++4Y+cANdWopwCHHVhAxwolu+RZMsVzA2DFm268eTeX1oyhJmHnGyiNN1tICJtOU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536t-0006VT-5g;
	Fri, 11 Sep 2026 15:24:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536L-0006TI-FB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ig2WZY4qGddQCp9sKRUtu0n8IMubWDgexdOGdaoqasw=; b=QGVpPNmRHFtbTMm0SUChkyeWL3
 eiTzVlNQdbxPjx2hKXOJJXet1WiO1OCjbTZWz5jw6KtM6dRjIrGSnTDmwBU2B9ZKTVGngJ9hG3nr4
 dFeAxzs9Y46bq5HF/iwrUrCoOCK3Cw2UtDUgax8o3ZgSs0z+yx86DAtNT5EbD0Xl2ywE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ig2WZY4qGddQCp9sKRUtu0n8IMubWDgexdOGdaoqasw=; b=g
 PgwLh+lQgVFG5PjrYqK6saX5KCfc2xYlTApeibpIw5ATdKmgmIyGxfmlTf4v+qeiJQL/QvXHYVDLU
 1xhvgejD5EgxwB6EmG3RraEX3iueJx/QYSxMJF1ZogudoyfgZzLTNJBzygMbNVg7iR0vvgUqaF5Z2
 /D6/PXA1UFUWDNCc=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x536I-00019H-0w for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:41 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so817575f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140211; x=1789745011; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ig2WZY4qGddQCp9sKRUtu0n8IMubWDgexdOGdaoqasw=;
 b=K8TIaH4aPt6dgFhx4owggvDVde1iQrGOlrdBbOWnIsiFQXn0VVaiz3WK2+DQY6RPgc
 whujW79ETEomyHSSNxuRvRcqp7NQTvF7oplj6R7y5xsyerOADelW78v1YEA7Usuyllg5
 i0YzYx8qfidNXJXjPkj408U/LnBd53QT02ozgPMvCE8yFO1qInB9TESwcFKLDemVCBQ1
 gMh42q67h0M/dvsYjc6QEG+GDo4voJQAPIycW0SrCViJ+593YqCWDVS6Dz6w4WZ2yWsf
 4GLnVbBScwQ1qATdwcoj9f+2hehkhPaYNwRVFWnvtjG2Zg/6YiCw7nMQEbwUpjQzzfVS
 A9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140211; x=1789745011;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ig2WZY4qGddQCp9sKRUtu0n8IMubWDgexdOGdaoqasw=;
 b=sDiSbLssuU+eiCmqAc9fczxq3qmMlo55I9hvOmgeWnTYRuyxs0IajHSA5Yv7mfUcw9
 FrFzNTWhSw+kYjH5kiD/iJEZR3O5LqbVo3jhfuI5t2/yyDG9MTJieSOdWdm/bYJnBEwP
 SyXaAdIeo0T+8KMJg62edFJi1Q3/rE5ujFu1f8yOc+4vnoMCGq+/cn1XmiOQjJU4QFXr
 t/v1jTpuuqIhJ6RQCEXn6mR4jypeMM1U0rXeUPvyvqY2QPhuRHIdVwumHDn5Lq4ie8AV
 ZoJaabhfnIdXO7f2aapX7wd0gM3JZpzcXaGupmaFjpEEPwQTScwcQmooixTF1FstmNdf
 yXyA==
X-Gm-Message-State: AFuF++nthhHHUtCYomcTSzqH9JKDw5ChglFnvy/0yl8Ixsf9vad26kic
 RuoZU0zR3Q0Wlml7y/2bGVk7OPAZC9BXZLOyrNGuqA6V/NygCOfWzdjOzkerY8Y0U4S7yB2LbVy
 7PHk3OfTEKLzOS8t7tA4XHjMlzlN9vlU96fA4M0b8e1JJFCez1zE/OHm2UsjY6cIh5QTI
X-Gm-Gg: AYBFou0zDzErF6SJQpvwFJEvtLr8oMIUb9jRejIpXEKHptiIiNGoakYpsohUIJDA+p0
 ITuITHsAjOmZkbWCBjqbqT3qFaDX4DkJpbefGW1TtB6eOu5ulKbS8/IuZgICOcKWp0VR4lIpfxH
 ds6tOfdmHDhf4Jp5ICSRILkhvJ3F0iplOcCpmVMopz0Avm/MNWmQdSDjpR+wdaE9+/kf1Q9VlYJ
 6Qie35PT7pSM1O3AtxZyXmkPq0WUNdqBU6q5IBK4VZqq3SkgOJdYbmvZBxCAnlqX1kshlDhY/e4
 at3L05KFyboMJrCGL0AOHjlyyiJueQmawLKN7je92j1x+OJkazqj4ad4NHDBDBP/IEIooogrxbN
 sVFywy2euIEIdju4Nf99pTvJXbT7fDisguHP1S7kNPyDmc52dVQiQWBAkKvh2WuapWTYh24tzG9
 l1XVSZkFOCN318xgTWiz8WXf509Ha/bL7n9RZT+NiGNOEkbqViiI3S57RTqaaNW1LSAUoiq1oPS
 Vqvpd1QZ4O+f2VkhBq31aChiPw4bMfdm5G9XKgYX8t81ggn9D13fj8nQfT6JnTBJ0bginqqqi7q
 GmsNQuluwj9gy4yVrSz4RT6WV3BVGp8nqWoyfRG9t9xgl5nuRMkGUbnM7Pyv1g==
X-Received: by 2002:a05:6000:5c6:b0:486:f4ba:ce0a with SMTP id
 ffacd0b85a97d-486f4bace38mr1460036f8f.9.1789140211239; 
 Fri, 11 Sep 2026 08:23:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm6683936f8f.19.2026.09.11.08.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:30 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: e999f45c962329ae86de2ff9171383846b1925dc
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0c392c8331d329abcc3161bfdd5e779d893c8ed-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x536I-00019H-0w
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
Content-Type: multipart/mixed; boundary="===============8304345296007264654=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8304345296007264654==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iQBBniJJbwA="; charset=UTF-8

--iQBBniJJbwA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1759?usp=3Demail

to look at the new patch set (#18)=2E
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
d, so the server can recover
the per-client key and unwrap it=2E Without tl=
s-crypt-v2 the probe stays a
plain P_CONTROL_OOB_V1, unchanged=2E

  - drop=
 the "skip probing under tls-crypt-v2" bail-out
  - make the WKc available =
on the probe's wrap context (mirroring
    init_instance()), so tls_wrap_co=
ntrol() appends it
  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL=
_OOB_V1) and
    report "tls-crypt-v2" in the wrapping log line

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
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1759/18

diff=
 --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-op=
tions=2Erst
index 3958ef9=2E=2E8b80dbd1 100644
--- a/doc/man-sections/clien=
t-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -618,9 +618,=
8 @@
   group is treated as best=2E
 
   The probe carries the same control=
-channel wrapping as a normal
-  connection (``--tls-auth`` or ``--tls-cryp=
t``, when configured)=2E With
-  ``--tls-crypt-v2`` the remotes are left in=
 their configured order,
-  because the server cannot unwrap an out-of-band=
 probe yet=2E
+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls-cry=
pt-v2``,
+  when configured)=2E
 
   Only UDP remotes are probed, and only =
when there are at least two
   remotes; remotes reached through a SOCKS pro=
xy are not probed=2E All
diff --git a/src/openvpn/oob_client=2Ec b/src/open=
vpn/oob_client=2Ec
index 286b08e=2E=2Efb59104 100644
--- a/src/openvpn/oob_=
client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -80,9 +80,7 @@
  * the tls_a=
uth_standalone the server uses to answer it=2E With neither tls-auth
  * no=
r tls-crypt configured the context stays in TLS_WRAP_NONE and the probe is
=
  * sent in plaintext, exactly as before; with either configured the probe =
is
- * authenticated/encrypted like any other control packet=2E Returns NUL=
L (and
- * logs) for configurations the probe cannot wrap yet, in which cas=
e the caller
- * skips probing and keeps the configured remote order=2E */
=
+ * authenticated/encrypted like any other control packet=2E */
 static str=
uct tls_auth_standalone *
 oob_probe_init_tls_auth_standalone(struct contex=
t *c, struct gc_arena *gc)
 {
@@ -95,19 +93,9 @@
      * supported; the fir=
st entry's wrapping is used for all=2E) */
     const struct connection_ent=
ry *ce =3D c->options=2Econnection_list->array[0];
 
-    /* tls-crypt-v2 w=
raps with a per-client key the server only learns from the
-     * wrapped =
client key (WKc) carried in the TLS handshake=2E An out-of-band
-     * pro=
be carries no WKc, so the server cannot unwrap it; skip probing rather
-   =
  * than send something unverifiable=2E */
-    if (ce->tls_crypt_v2_file)
=
-    {
-        msg(D_LOW, "server-probe: not supported with tls-crypt-v2; =
using configured order");
-        return NULL;
-    }
-
-    /* Load the t=
ls-auth/tls-crypt key material into c->c1=2Eks (a no-op if neither
-     * =
is configured)=2E This is run again per-connection later; calling it early
=
-     * here is harmless=2E */
+    /* Load the tls-auth/tls-crypt(-v2) key=
 material into c->c1=2Eks (a no-op if
+     * none is configured)=2E This i=
s run again per-connection later; calling it
+     * early here is harmless=
=2E */
     do_init_tls_wrap_key(c, ce);
 
     struct tls_options to;
@@ -=
116,6 +104,15 @@
     to=2Ereplay_window =3D c->options=2Ereplay_window;
  =
   to=2Ereplay_time =3D c->options=2Ereplay_time;
 
+    /* tls-crypt-v2 wr=
aps with a per-client key the server learns from the
+     * wrapped client=
 key (WKc)=2E init_tls_wrap_ctx() loaded the per-client key
+     * into th=
e wrap context; make the WKc available too so the probe can append
+     * =
it (as a P_CONTROL_OOB_WKC_V1 message), mirroring do_init_crypto_tls()=2E *=
/
+    if (ce->tls_crypt_v2_file)
+    {
+        to=2Etls_wrap=2Etls_crypt=
_v2_wkc =3D &c->c1=2Eks=2Etls_crypt_v2_wkc;
+    }
+
     struct tls_auth_s=
tandalone *tas =3D tls_auth_standalone_init(&to, gc);
 
     /* Control-cha=
nnel frame and work buffers, mirroring do_init_frame_tls()=2E */
@@ -567,14=
 +564,8 @@
     struct gc_arena gc =3D gc_new();
 
     /* Wrapping context=
 for the probe (tls-auth/tls-crypt, or plaintext if
-     * neither)=2E NUL=
L means this configuration cannot be probed; keep the
-     * configured or=
der=2E */
+     * neither)=2E */
     struct tls_auth_standalone *tas =3D o=
ob_probe_init_tls_auth_standalone(c, &gc);
-    if (!tas)
-    {
-        g=
c_free(&gc);
-        return;
-    }
 
     /* A single random session id i=
dentifies all of our probes; servers echo it
      * back in the reply's pe=
er_session_id, letting us reject spoofed replies=2E */
@@ -633,8 +624,15 @@=

         return;
     }
 
+    /* With tls-crypt-v2 the probe must carry t=
he wrapped client key so the
+     * server can recover the per-client key;=
 that is a P_CONTROL_OOB_WKC_V1
+     * message=2E Otherwise (tls-crypt v1,=
 tls-auth, or plaintext) it is a plain
+     * P_CONTROL_OOB_V1=2E */
+    =
const bool is_v2 =3D (tas->tls_wrap=2Etls_crypt_v2_wkc !=3D NULL);
+    con=
st int probe_opcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB_V1;
+
=
     struct buffer probe =3D
-        tls_wrap_oob_standalone(&tas->tls_wra=
p, tas, &client_sid, &payload, P_CONTROL_OOB_V1);
+        tls_wrap_oob_sta=
ndalone(&tas->tls_wrap, tas, &client_sid, &payload, probe_opcode);
     if =
(!BLEN(&probe))
     {
         msg(D_LOW, "server-probe: could not wrap pr=
obe packet; using configured order");
@@ -644,9 +642,10 @@
         return;=

     }
 
-    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=3D TLS_W=
RAP_CRYPT)  ? "tls-crypt"
-                            : (tas->tls_wrap=2Em=
ode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
-                                   =
                                 : "none (plaintext)";
+    const char *wra=
p_name =3D is_v2                                    ? "tls-crypt-v2"
+     =
                       : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? "tl=
s-crypt"
+                            : (tas->tls_wrap=2Emode =3D=3D TLS_WR=
AP_AUTH)  ? "tls-auth"
+                                                   =
                  : "none (plaintext)";
     msg(D_LOW, "server-probe: prob=
ing %d remote(s) with a %d ms window, control-channel wrapping: %s",
      =
   l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Ge=
rrit-Change-Number: 1759
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--iQBBniJJbwA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1759?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Sen=
d tls-crypt-v2 SERVER_PROBE from the client<br><br>When tls-crypt-v2 is con=
figured, send the probe as P_CONTROL_OOB_WKC_V1<br>with the wrapped client =
key (WKc) appended, so the server can recover<br>the per-client key and unw=
rap it=2E Without tls-crypt-v2 the probe stays a<br>plain P_CONTROL_OOB_V1,=
 unchanged=2E<br><br>  - drop the &quot;skip probing under tls-crypt-v2&quo=
t; bail-out<br>  - make the WKc available on the probe&#39;s wrap context (=
mirroring<br>    init_instance()), so tls_wrap_control() appends it<br>  - =
choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL_OOB_V1) and<br>    rep=
ort &quot;tls-crypt-v2&quot; in the wrapping log line<br><br>Change-Id: I5c=
c100dd7dc810d7d1e6f29bb57584905fbcf4a0<br>Signed-off-by: Lev Stipakov &lt;l=
ev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M=
 src/openvpn/oob_client=2Ec<br>2 files changed, 28 insertions(+), 30 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/59/1759/18</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/cl=
ient-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>=
index 3958ef9=2E=2E8b80dbd1 100644</span><br><span>--- a/doc/man-sections/c=
lient-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=
=2Erst</span><br><span>@@ -618,9 +618,8 @@</span><br><span>   group is trea=
ted as best=2E</span><br><span> </span><br><span>   The probe carries the s=
ame control-channel wrapping as a normal</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  connection (``--tls-auth`` or ``--tls-crypt``, when co=
nfigured)=2E With</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``=
--tls-crypt-v2`` the remotes are left in their configured order,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  because the server cannot unwr=
ap an out-of-band probe yet=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls-crypt-v=
2``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  when configur=
ed)=2E</span><br><span> </span><br><span>   Only UDP remotes are probed, an=
d only when there are at least two</span><br><span>   remotes; remotes reac=
hed through a SOCKS proxy are not probed=2E All</span><br><span>diff --git =
a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>i=
ndex 286b08e=2E=2Efb59104 100644</span><br><span>--- a/src/openvpn/oob_clie=
nt=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ =
-80,9 +80,7 @@</span><br><span>  * the tls_auth_standalone the server uses =
to answer it=2E With neither tls-auth</span><br><span>  * nor tls-crypt con=
figured the context stays in TLS_WRAP_NONE and the probe is</span><br><span=
>  * sent in plaintext, exactly as before; with either configured the probe=
 is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * authenticated/e=
ncrypted like any other control packet=2E Returns NULL (and</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * logs) for configurations the probe=
 cannot wrap yet, in which case the caller</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * skips probing and keeps the configured remote order=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * authentica=
ted/encrypted like any other control packet=2E */</span><br><span> static s=
truct tls_auth_standalone *</span><br><span> oob_probe_init_tls_auth_standa=
lone(struct context *c, struct gc_arena *gc)</span><br><span> {</span><br><=
span>@@ -95,19 +93,9 @@</span><br><span>      * supported; the first entry&=
#39;s wrapping is used for all=2E) */</span><br><span>     const struct con=
nection_entry *ce =3D c-&gt;options=2Econnection_list-&gt;array[0];</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls-=
crypt-v2 wraps with a per-client key the server only learns from the</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * wrapped client key (W=
Kc) carried in the TLS handshake=2E An out-of-band</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * probe carries no WKc, so the server can=
not unwrap it; skip probing rather</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     * than send something unverifiable=2E */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (ce-&gt;tls_crypt_v2_file)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;server-probe: not=
 supported with tls-crypt-v2; using configured order&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Load the tls-auth/tls-crypt key material into c-&gt;c1=2Eks (a no-o=
p if neither</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * is=
 configured)=2E This is run again per-connection later; calling it early</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * here is harmless=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Load t=
he tls-auth/tls-crypt(-v2) key material into c-&gt;c1=2Eks (a no-op if</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * none is configure=
d)=2E This is run again per-connection later; calling it</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * early here is harmless=2E */</s=
pan><br><span>     do_init_tls_wrap_key(c, ce);</span><br><span> </span><br=
><span>     struct tls_options to;</span><br><span>@@ -116,6 +104,15 @@</sp=
an><br><span>     to=2Ereplay_window =3D c-&gt;options=2Ereplay_window;</sp=
an><br><span>     to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tl=
s-crypt-v2 wraps with a per-client key the server learns from the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * wrapped client key (WK=
c)=2E init_tls_wrap_ctx() loaded the per-client key</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * into the wrap context; make the WK=
c available too so the probe can append</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * it (as a P_CONTROL_OOB_WKC_V1 message), mirrorin=
g do_init_crypto_tls()=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;c-&gt;c1=2Eks=2E=
tls_crypt_v2_wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     struct tls_auth_standalone *tas =3D tls_auth_standalone_init(&amp;to,=
 gc);</span><br><span> </span><br><span>     /* Control-channel frame and w=
ork buffers, mirroring do_init_frame_tls()=2E */</span><br><span>@@ -567,14=
 +564,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span> </span><br><span>     /* Wrapping context for the probe (tls-auth/tl=
s-crypt, or plaintext if</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * neither)=2E NULL means this configuration cannot be probed; keep =
the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * configured =
order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * n=
either)=2E */</span><br><span>     struct tls_auth_standalone *tas =3D oob_=
probe_init_tls_auth_standalone(c, &amp;gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!tas)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span> </span><br><span>     /* A single random session id iden=
tifies all of our probes; servers echo it</span><br><span>      * back in t=
he reply&#39;s peer_session_id, letting us reject spoofed replies=2E */</sp=
an><br><span>@@ -633,8 +624,15 @@</span><br><span>         return;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* With tls-crypt-v2 the probe must carry the wrapped clie=
nt key so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 server can recover the per-client key; that is a P_CONTROL_OOB_WKC_V1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * message=2E Otherw=
ise (tls-crypt v1, tls-auth, or plaintext) it is a plain</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * P_CONTROL_OOB_V1=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const bool is_v2 =3D (ta=
s-&gt;tls_wrap=2Etls_crypt_v2_wkc !=3D NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const int probe_opcode =3D is_v2 ? P_CONTROL_=
OOB_WKC_V1 : P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     struct buffer probe =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        tls_wrap_oob_standalone(&amp;tas=
-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload, P_CONTROL_OOB_V1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_stan=
dalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload, probe_opc=
ode);</span><br><span>     if (!BLEN(&amp;probe))</span><br><span>     {</s=
pan><br><span>         msg(D_LOW, &quot;server-probe: could not wrap probe =
packet; using configured order&quot;);</span><br><span>@@ -644,9 +642,10 @@=
</span><br><span>         return;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *wrap_n=
ame =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-crypt&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;tls-au=
th&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                                                       : &quot;none (plaint=
ext)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *wrap_name =3D is_v2                                    ? &quot;tls-=
crypt-v2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? =
&quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AU=
TH)  ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                                                   =
  : &quot;none (plaintext)&quot;;</span><br><span>     msg(D_LOW, &quot;ser=
ver-probe: probing %d remote(s) with a %d ms window, control-channel wrappi=
ng: %s&quot;,</span><br><span>         l-&gt;len, OOB_PROBE_WINDOW_MS, wrap=
_name);</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail">ch=
ange 1759</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1759 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--iQBBniJJbwA=--


--===============8304345296007264654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8304345296007264654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8304345296007264654==--

