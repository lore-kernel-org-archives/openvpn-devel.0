Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E47C982C2
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIj52y0YrAOH8C2Tr1KYZ3rzQSVEDKLMwE1ea0DWVro=; b=Le8YXcxxRTqqI7rPtduR/nd085
	w/PWZ3sJlsvNQLh8ln89ZnOjPiZ966dpOF7VvEK+ux8SeahFQE9mPz4RxiGj5bDiT0o9kWb6QIogo
	eHjsqMvSn9goNnOBzyv4vv4GGdp56lgdgPNBsAZ3wbjyCkGTNfhBMTEzBZ89hWF8txYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wd-0000I7-1e;
	Mon, 14 Sep 2026 14:19:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67Wa-0000Hl-RO
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hJTB77QuX8GfOLfwyzFjJvWfHrNg5Fy+diAPHngBzEs=; b=FE6bKK/PghhMJH2CETyJv2lJRm
 eK+qBZegr/f2T2bmBS2HiOikHwHR6sZnxKqqdSYRViGyznYbvijfXT7SKh+eubNfK3QyGzuu/uQOQ
 6v2LnsjOE+p8fzwjzDszNVYVPtnV/oUfIbJuacNPA/OUxYbiTvUBbaE9xgA95wXMX6Kw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hJTB77QuX8GfOLfwyzFjJvWfHrNg5Fy+diAPHngBzEs=; b=S
 JjHkDJ0dRZ2f+5M7JycRb1Qusb/JxPA7jvT29SEGzp440CvaYCiHPiPebEL62vUfy1avDWApAp7IB
 zrJwim78l4mTHEHiTeT9kI1WuRp9joL9jByggoC575N4fZJhyPIjfgSHLjmML/1MMaEnnTI51pBMU
 OPp0lrVe/UEFziZE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WQ-0006eZ-VC for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:10 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so11109235e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395536; x=1790000336; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hJTB77QuX8GfOLfwyzFjJvWfHrNg5Fy+diAPHngBzEs=;
 b=dkOA5K1FkoUCh8FLo5kKics2d1RusE4F+EkI4uqH4sCtTswASVCTqaeRQpTcdUZ3lu
 eOJoFsSvnwmjVv9gydMWbKr4xfOoDJuM2kUTtou23+E9g0jdetu+f4hpoDkq25N3droy
 bLbYFdaKs39XqLYrLffLw/wxlN26TWThol692+YB6+nZUZBOUebTInInoUjnAU3XZ1oF
 9TTk2U2A5pGPnUlzz/RQ6xjqSw9j9ClqTWsAp5rglaKRZELFWqwetlV8xkUM5GMx4KcO
 3G92D++zrMXgAdVJhzmkks9a089w1mG7UtShx9nlwf8IEO45ekpX6cSyds0sFB7v1LCH
 CZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395536; x=1790000336;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hJTB77QuX8GfOLfwyzFjJvWfHrNg5Fy+diAPHngBzEs=;
 b=jRzY8mEWP3LCRPidPwiyMsKhMchlIfwQyVI9rSPEBpFxlaCRoOsGFfhqATK5SueObg
 sg3NHfAwelSOPWhVOljzynNMO8nCT68qzUZFkGDd2IQQGAE6X1ahBFSo3uVYO3CSnxPA
 eCOOSCPGwikYScmUoqcmqrjo07Tt9s0YYaVS8XM4PkR0nH/21aX1GpzhtPDfTt5CKb33
 +w43sIlSaLJwVu6QZHNWd3QcXYmbANqUMMB5qjlxLPhjyfQaaPxX9hFs3zSQk+wwnbpL
 lMwvySt76r/tSgw5mk8dlwZ4XUuKal5+zLSLnL4AFxR0kXVAA/h/Dw4Hf/m47VXRv76X
 62ag==
X-Gm-Message-State: AFuF++k9saC8cPNCu6s79NpA9Y8Qlv0d+ssGCI1FHXnoklvUzIC5QpSV
 1Z1okSmkVBtkJUXc29PII4OUN3u/nVovkvvPUWWXY2IihCyCL/Et2M0s8IOFCh8yABn+ApLJ/Ac
 UT/8kKRIaE3X7jahzX6EPAAJ5niIXIFaLTRwi2Y94AolYaXY/QGamtI+UPYaPD//uoF6w
X-Gm-Gg: AYBFou05VYkUkso9BD+T5QA6uaUFXFzRj/QW8j1ZpjO+sF1ZWUzc7IaeLw8bTCPwcNz
 6Zjr/anxeEWBpsqxhSdkNg0yfC395GjoXz2IZWXcDf2bcvcY/I0s90C3isanKvU4gR6DEwNTFcg
 zT4UCKJgZ3oB1Fpdhoeka1vItFMYxIxTg8x8HJ+E2shDgocRpFE1IIO3Kvjo4YCnJ8WKVUUfK1N
 LsO5UHlghSYS6N7kRQWgjsalCx+hKHeQVtuyQR+2dt0Xc9xgEFaNVIMbvORbmHdwhtf7rwJDEo5
 +8fG78tVqBlbPk7GXPxTvZVFuUaysh1VvLN2pmHgnnNZjBsdLnHW9jfN3eKSPKq05yqrhYrmt6z
 wdBePBjc459wm0lF9D4/HC+r++KbsS/lraFZx0Bs9XzWyCy8vllKXmk7hjtLijVREyjM7QJB1bu
 Ub9/5oAmkTdYHr3pLFZJMN0aITbJ/wIYtIzwT84YvcVHk2+GoN4TaxcbOxDx7t//y39Dq+W4Vkw
 0d9fqu+epaA4ali8qiBPIoEvjo5z3UUyYEj40bcCn6jdY37l9SFCZqOmz6/aV6l7BJBQZ0D5PiY
 o1zM5gaK/V3rN8CFT+/omrG03zfbS4M4nkOIJH5y493hFN4FM8Ny/NwGYnKLUA==
X-Received: by 2002:a05:600c:1547:b0:49c:fc6c:be09 with SMTP id
 5b1f17b1804b1-49e7a67cae4mr35489995e9.32.1789395536281; 
 Mon, 14 Sep 2026 07:18:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d4e3f3sm446536465e9.15.2026.09.14.07.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:55 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: 695fbbde00e7a7d7d9ac262d45d789b37800485f
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21190473d2fdfc913ee9bcc48ee12890f94c3062-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WQ-0006eZ-VC
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
Content-Type: multipart/mixed; boundary="===============5537831242091104676=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5537831242091104676==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NyWerHS6YOk="; charset=UTF-8

--NyWerHS6YOk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1759?usp=3Demail

to look at the new patch set (#20)=2E
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
    do_init_crypto_tls()), so tls_wr=
ap_control() appends it
  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CO=
NTROL_OOB_V1) and
    report "tls-crypt-v2" in the wrapping log line

Chang=
e-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Signed-off-by: Lev Stipakov=
 <lev@openvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/open=
vpn/oob_client=2Ec
2 files changed, 28 insertions(+), 35 deletions(-)


  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1759/20
=

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/clie=
nt-options=2Erst
index 84a9f51=2E=2E74ae59e 100644
--- a/doc/man-sections/c=
lient-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -618,9 +=
618,8 @@
   the fastest of its priority group, without constraining the oth=
ers=2E
 
   The probe carries the same control-channel wrapping as a normal=

-  connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With=

-  ``--tls-crypt-v2`` the remotes are left in their configured order,
-  b=
ecause the server cannot unwrap an out-of-band probe yet=2E
+  connection (=
``--tls-auth``, ``--tls-crypt`` or ``--tls-crypt-v2``,
+  when configured)=
=2E
 
   Only UDP remotes are probed, and only when there are at least two
=
   remotes; remotes reached through a SOCKS proxy are not probed=2E All
dif=
f --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 6be=
de64=2E=2E3072d3c 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn=
/oob_client=2Ec
@@ -83,13 +83,9 @@
 
 static bool oob_probe_eligible(const =
struct connection_entry *ce);
 
-/* Build a standalone control-channel wrap=
ping context for the probe, mirroring
- * the tls_auth_standalone the serve=
r uses to answer it=2E With neither tls-auth
- * nor tls-crypt configured t=
he context stays in TLS_WRAP_NONE and the probe is
- * sent in plaintext, e=
xactly as before; with either configured the probe is
- * authenticated/enc=
rypted like any other control packet=2E Returns NULL (and
- * logs) for con=
figurations the probe cannot wrap yet, in which case the caller
- * skips p=
robing and keeps the configured remote order=2E */
+/* Build the standalone=
 wrapping context the probe is sent with, mirroring the
+ * one the server =
answers it with; without tls-auth/tls-crypt it stays in
+ * TLS_WRAP_NONE a=
nd the probe goes out in plaintext=2E */
 static struct tls_auth_standalone=
 *
 oob_probe_init_tls_auth_standalone(struct context *c, struct gc_arena *=
gc)
 {
@@ -108,19 +104,8 @@
         }
     }
 
-    /* tls-crypt-v2 wraps =
with a per-client key the server only learns from the
-     * wrapped clien=
t key (WKc) carried in the TLS handshake=2E An out-of-band
-     * probe ca=
rries no WKc, so the server cannot unwrap it; skip probing rather
-     * t=
han send something unverifiable=2E */
-    if (ce->tls_crypt_v2_file)
-    =
{
-        msg(D_LOW, "server-probe: not supported with tls-crypt-v2; using=
 configured order");
-        return NULL;
-    }
-
-    /* Load the tls-au=
th/tls-crypt key material into c->c1=2Eks (a no-op if neither
-     * is co=
nfigured)=2E This is run again per-connection later; calling it early
-    =
 * here is harmless=2E */
+    /* options=2Ece is not mapped yet; options_p=
ostprocess_mutate_ce() has already
+     * copied any global key into ce=2E=
 Loaded again per-connection later=2E */
     do_init_tls_wrap_key(c, ce);
=
 
     struct tls_options to;
@@ -129,9 +114,16 @@
     to=2Ereplay_window =
=3D c->options=2Ereplay_window;
     to=2Ereplay_time =3D c->options=2Erepl=
ay_time;
 
+    /* the server learns the per-client key from the WKc the pr=
obe appends;
+     * a tls-crypt-v2 server has no WKc, and init_tls_wrap_ct=
x() leaves such a
+     * config in TLS_WRAP_NONE, so the probe must not cl=
aim to be one */
+    if (ce->tls_crypt_v2_file && c->options=2Etls_client)=

+    {
+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &c->c1=2Eks=2Etls_cry=
pt_v2_wkc;
+    }
+
     struct tls_auth_standalone *tas =3D tls_auth_stand=
alone_init(&to, gc);
 
-    /* Control-channel frame and work buffers, mirr=
oring do_init_frame_tls()=2E */
     tls_init_control_channel_frame_paramet=
ers(&tas->frame, ce->tls_mtu);
     tas->tls_wrap=2Ework =3D alloc_buf_gc(B=
UF_SIZE(&tas->frame), gc);
     tas->workbuf =3D alloc_buf_gc(BUF_SIZE(&tas=
->frame), gc);
@@ -636,14 +628,8 @@
     struct gc_arena gc =3D gc_new();
 =

     /* Wrapping context for the probe (tls-auth/tls-crypt, or plaintext i=
f
-     * neither)=2E NULL means this configuration cannot be probed; keep =
the
-     * configured order=2E */
+     * neither)=2E */
     struct tls_a=
uth_standalone *tas =3D oob_probe_init_tls_auth_standalone(c, &gc);
-    if=
 (!tas)
-    {
-        gc_free(&gc);
-        return;
-    }
 
     /* A s=
ingle random session id identifies all of our probes; servers echo it
     =
 * back in the reply's peer_session_id, letting us reject spoofed replies=
=2E */
@@ -715,8 +701,15 @@
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
@@ -726,9=
 +719,10 @@
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
Gerrit-PatchSet: 20
Gerr=
it-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--NyWerHS6YOk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #20</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1759?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Sen=
d tls-crypt-v2 SERVER_PROBE from the client<br><br>When tls-crypt-v2 is con=
figured, send the probe as P_CONTROL_OOB_WKC_V1<br>with the wrapped client =
key (WKc) appended, so the server can recover<br>the per-client key and unw=
rap it=2E Without tls-crypt-v2 the probe stays a<br>plain P_CONTROL_OOB_V1,=
 unchanged=2E<br><br>  - drop the &quot;skip probing under tls-crypt-v2&quo=
t; bail-out<br>  - make the WKc available on the probe&#39;s wrap context (=
mirroring<br>    do_init_crypto_tls()), so tls_wrap_control() appends it<br=
>  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL_OOB_V1) and<br>  =
  report &quot;tls-crypt-v2&quot; in the wrapping log line<br><br>Change-Id=
: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0<br>Signed-off-by: Lev Stipakov =
&lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst=
<br>M src/openvpn/oob_client=2Ec<br>2 files changed, 28 insertions(+), 35 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/59/1759/20</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sectio=
ns/client-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><=
span>index 84a9f51=2E=2E74ae59e 100644</span><br><span>--- a/doc/man-sectio=
ns/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client-optio=
ns=2Erst</span><br><span>@@ -618,9 +618,8 @@</span><br><span>   the fastest=
 of its priority group, without constraining the others=2E</span><br><span>=
 </span><br><span>   The probe carries the same control-channel wrapping as=
 a normal</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  connection=
 (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-crypt-v2`` the remotes ar=
e left in their configured order,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  because the server cannot unwrap an out-of-band probe yet=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connection (``--tl=
s-auth``, ``--tls-crypt`` or ``--tls-crypt-v2``,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  when configured)=2E</span><br><span> </span>=
<br><span>   Only UDP remotes are probed, and only when there are at least =
two</span><br><span>   remotes; remotes reached through a SOCKS proxy are n=
ot probed=2E All</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/=
src/openvpn/oob_client=2Ec</span><br><span>index 6bede64=2E=2E3072d3c 10064=
4</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/sr=
c/openvpn/oob_client=2Ec</span><br><span>@@ -83,13 +83,9 @@</span><br><span=
> </span><br><span> static bool oob_probe_eligible(const struct connection_=
entry *ce);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* Build a standalone control-channel wrapping context for the prob=
e, mirroring</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the tl=
s_auth_standalone the server uses to answer it=2E With neither tls-auth</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * nor tls-crypt configur=
ed the context stays in TLS_WRAP_NONE and the probe is</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * sent in plaintext, exactly as before; w=
ith either configured the probe is</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * authenticated/encrypted like any other control packet=2E Re=
turns NULL (and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * log=
s) for configurations the probe cannot wrap yet, in which case the caller</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * skips probing and ke=
eps the configured remote order=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Build the standalone wrapping context the probe is sen=
t with, mirroring the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * one the server answers it with; without tls-auth/tls-crypt it stays in=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLS_WRAP_NONE an=
d the probe goes out in plaintext=2E */</span><br><span> static struct tls_=
auth_standalone *</span><br><span> oob_probe_init_tls_auth_standalone(struc=
t context *c, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -1=
08,19 +104,8 @@</span><br><span>         }</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls-cr=
ypt-v2 wraps with a per-client key the server only learns from the</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * wrapped client key (WKc=
) carried in the TLS handshake=2E An out-of-band</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * probe carries no WKc, so the server canno=
t unwrap it; skip probing rather</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * than send something unverifiable=2E */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (ce-&gt;tls_crypt_v2_file)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;server-probe: not =
supported with tls-crypt-v2; using configured order&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* Load the tls-auth/tls-crypt key material into c-&gt;c1=2Eks (a no-op=
 if neither</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * is =
configured)=2E This is run again per-connection later; calling it early</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-     * here is harmless=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* option=
s=2Ece is not mapped yet; options_postprocess_mutate_ce() has already</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * copied any global =
key into ce=2E Loaded again per-connection later=2E */</span><br><span>    =
 do_init_tls_wrap_key(c, ce);</span><br><span> </span><br><span>     struct=
 tls_options to;</span><br><span>@@ -129,9 +114,16 @@</span><br><span>     =
to=2Ereplay_window =3D c-&gt;options=2Ereplay_window;</span><br><span>     =
to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the server learns th=
e per-client key from the WKc the probe appends;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * a tls-crypt-v2 server has no WKc, and i=
nit_tls_wrap_ctx() leaves such a</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * config in TLS_WRAP_NONE, so the probe must not claim to=
 be one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
e-&gt;tls_crypt_v2_file &amp;&amp; c-&gt;options=2Etls_client)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &=
amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     struct tls_auth_standalone *tas =3D tls_auth_stan=
dalone_init(&amp;to, gc);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* Control-channel frame and work buffers, mirror=
ing do_init_frame_tls()=2E */</span><br><span>     tls_init_control_channel=
_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br><span>    =
 tas-&gt;tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc)=
;</span><br><span>     tas-&gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&=
gt;frame), gc);</span><br><span>@@ -636,14 +628,8 @@</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     /* W=
rapping context for the probe (tls-auth/tls-crypt, or plaintext if</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * neither)=2E NULL means =
this configuration cannot be probed; keep the</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * configured order=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E */</span><br><span>   =
  struct tls_auth_standalone *tas =3D oob_probe_init_tls_auth_standalone(c,=
 &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ta=
s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><sp=
an>     /* A single random session id identifies all of our probes; servers=
 echo it</span><br><span>      * back in the reply&#39;s peer_session_id, l=
etting us reject spoofed replies=2E */</span><br><span>@@ -715,8 +701,15 @@=
</span><br><span>         return;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* With tls-cryp=
t-v2 the probe must carry the wrapped client key so the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * server can recover the per-clien=
t key; that is a P_CONTROL_OOB_WKC_V1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * message=2E Otherwise (tls-crypt v1, tls-auth, or p=
laintext) it is a plain</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * P_CONTROL_OOB_V1=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const bool is_v2 =3D (tas-&gt;tls_wrap=2Etls_crypt_v2_wkc=
 !=3D NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st int probe_opcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB_V1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
struct buffer probe =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_s=
id, &amp;payload, P_CONTROL_OOB_V1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas=
, &amp;client_sid, &amp;payload, probe_opcode);</span><br><span>     if (!B=
LEN(&amp;probe))</span><br><span>     {</span><br><span>         msg(D_LOW,=
 &quot;server-probe: could not wrap probe packet; using configured order&qu=
ot;);</span><br><span>@@ -726,9 +719,10 @@</span><br><span>         return;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =
=3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-crypt&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                            : (tas-&gt;tls_wrap=
=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
                         : &quot;none (plaintext)&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *wrap_name =3D is_v2   =
                                 ? &quot;tls-crypt-v2&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            : (tas-=
&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? &quot;tls-crypt&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
: (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH)  ? &quot;tls-auth&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                                               : &quot;none (plaintext)&quo=
t;;</span><br><span>     msg(D_LOW, &quot;server-probe: probing %d remote(s=
) with a %d ms window, control-channel wrapping: %s&quot;,</span><br><span>=
         l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);</span><br><span> </spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1759?usp=3Demail">change 1759</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5cc100dd7dc810d7d=
1e6f29bb57584905fbcf4a0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1759 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--NyWerHS6YOk=--


--===============5537831242091104676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5537831242091104676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5537831242091104676==--

