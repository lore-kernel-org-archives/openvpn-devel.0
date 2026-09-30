Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B557CA5FC1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5mIAD54w+AF9W9j7vN+rqTMnMij74Cr0IvsJ6x1Euw=; b=IgZdxgS7r2ZXVRbTy5T4UvkJ6Q
	amIdKhe51LkLDrXIA+F2H9tKt3dcTSG3ZDkvVrTAduQJdaKkq6/CN8sqrCCQFf2mr3kcfhVOQxk1I
	aPHk4WwTRX2+Iha07j6+HNO6pd/Y0dvts63Xl9M+6KzaAkVvii7l6AIAKtE169oRnFSc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeD-0003ZY-9B;
	Wed, 30 Sep 2026 08:26:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdy-0003Yu-UG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sOyQ5KTKZ+t1Kfa5CPxM1HN0fny2QMqLEG5tLFmIbmA=; b=WFqJRNHM9MuS5xRi+lIT640zCj
 Z5JuYOEsV4EQUl8wvu79khGMzbCPbgAu3PSD1zFSB1X/GcbOuiWtMHka8YmsA9aldaOjhdakEfjYZ
 OBwAuCOYXixcYH1xeqQqUiKagrT5k5SU70hFUIAgr1kZGW1eIE3ZCXeyZobZTUETpHeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sOyQ5KTKZ+t1Kfa5CPxM1HN0fny2QMqLEG5tLFmIbmA=; b=e
 jTlUN6DIXsAq1yXNVMbo6Vg35k2Y9mifTHzjQezvrc/uUrHwUFlw/tkoG/NIda+aaLXgftVtl3iMC
 FrBrvQFBuELuXkhK6GNm7e+gDE5/pMSAFvcJjaoC14j5DF75s7qctgmr90BKNJf2oUBiKssZQRoYU
 VYc42qvzD4FdX2bU=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdo-0006kQ-KF for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:18 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso38354905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756770; x=1791361570; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sOyQ5KTKZ+t1Kfa5CPxM1HN0fny2QMqLEG5tLFmIbmA=;
 b=TJHRjxoUPvIU1OFuWMI1h1K3h/rzAfmgm7s6W7FJ25nc8Lj9GRG6LSHBGzRdS+TVcM
 mjaA20fdiSWL76DjwPkBJ6kL1ufNWtETdoylHb5FkfIMzfIwiDnnqeHHw9KHceuTCjiL
 54+8g6hF0X/4z6V5DUdAW0U4HoAuIn0S6GdINVPWjCpP1DerufLpNCNRUPs1Gxu0ED0O
 eyOHHiYAcFa8us07EZu7aFnI08mejcQpNX8KnjkCSI3wUWpq/XmB7or2NJ8lLA0+VtqT
 ss81so2z1OmMVK5YLthfN8Rk11oT4DQC3htFwoL/grCcKz+i44LqvRt3FawTYrHZKzes
 eh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756770; x=1791361570;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sOyQ5KTKZ+t1Kfa5CPxM1HN0fny2QMqLEG5tLFmIbmA=;
 b=LD24jdt8mSY5bHDMNqCWRXP8YCyow8/v51qn98ifBd1rSp6VKVTaCYMf0cCaKxV2tQ
 9RmS/qfMaKEI7t1DIsMd9j6snhHSUiMrgEuB1GqVJ0pU1Vu9YnIYaOs672MBiXokPnEb
 JFH8J8UPgVpcGqAfD2F6PD61LTa0TN6ghANeBd6J6QseYGhAQkfXmZH23E2sqIjNqAbs
 ZzEzvoln2D8StSAXxjoVPk3jgff9QVnXxG0AXwrQSDE5AJsl+8fmz6pOEpJSeMWjmQWO
 +nl9e4/xqINDfA4oBNr3UAFtWwCwQqBETeQheJ/cC/dTjjgy4QaQqNLBjJwFY1Pdhjaz
 5xtQ==
X-Gm-Message-State: AFuF++kS7mAR+r+sgSBlyTgooyOHMRBKWcb/duWRDwYIFBE71JEq0y08
 ld9e8fmaWWNmPPoVgJSsRMTypNy+hBJ9v2fTxOkeS00IrrGPy8wAOxsmWMvK0d1E4JT0GUcIG/Y
 T3MqhIrrTr9uNWzaj9vCKTsi8//VMWxaTzArswM4FetTpvTjlYLsdUm/rQ4caENPjdVLe
X-Gm-Gg: AYBFou1M7AjATyBlqPXrRPisdi3L5Ryv0b2EyEiLke0DQgP1LkedmE4Mlg5aUr6Rnvz
 JMzZtRdcjLBD8tWsYvIZ0rLLhslG/eAxod7HPcHy74MXqHpNyPqAVv3hLp3w5ruFTPuYfyNq5JF
 jh+glp6kk1r4de6RKi/7AsuAOuFWteawGVqtpxTummqMm219tvP76nrNlrBKESVyJ+xXkJZdiKd
 yG0v7Rlwx+nalGhs5HR0JF/4mMHK2vuXhlO+Om4FYhTEVJFHVgJF+aJSy0bDzXnVaYXXHaPumVE
 oX+wdi01i8hqUfiM990HMmB15toPbi5msjGQ4zUQH15BaVQOLza21ZOvtql5Pl9IQ706s8OJPgG
 BuTeAiI3BvdkSFEU0GmFpXRomnU9ikz4XfzN1lIhXDoSsOdAmQJcXUdKCPT3rjwZqSsuvJChh2l
 MFRecuMf/TZjlSxJjaCOzH5uPDcgRzYtDu6NzVznFz8p7sFBgoJm4n1BPsivBrDVVen8f6Nwjlf
 ljsjiJwhbskoUuGRT47X1gZnfeh7G7f2G5zDalKNC+V8lAEys/i2hdpU9hp1pQjurGihs7PZjrq
 M6HtsA9lGhUW1b68wqfL3TN11M1cZZrVOfmtqZDz+ljOR11t3HP21opbbP3yDVhL3LqdmYA=
X-Received: by 2002:a05:600c:46cf:b0:4a0:151e:f744 with SMTP id
 5b1f17b1804b1-4a01b01bb16mr9601145e9.22.1790756769862; 
 Wed, 30 Sep 2026 01:26:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174d886dsm42340255e9.1.2026.09.30.01.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: 672047f190f4737776f8f9417948477b3142da07
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <086a3c13558b86b115c4b6ac5191abe3e92144f6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdo-0006kQ-KF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Send
 tls-crypt-v2 probe requests from the client
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
Content-Type: multipart/mixed; boundary="===============8618971477811148890=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8618971477811148890==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s45lQm3Bjtc="; charset=UTF-8

--s45lQm3Bjtc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail

to look a=
t the new patch set (#29)=2E


Change subject: oob: Send tls-crypt-v2 probe=
 requests from the client
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Send tls-crypt-v2 probe requests from the client

When t=
ls-crypt-v2 is configured, send the probe as P_CONTROL_OOB_WKC_V1
with the =
wrapped client key (WKc) appended, so the server can recover
the per-client=
 key and unwrap it=2E Without tls-crypt-v2 the probe stays a
plain P_CONTRO=
L_OOB_V1, unchanged=2E

  - drop the "skip probing under tls-crypt-v2" bail=
-out
  - make the WKc available on the probe's wrap context (mirroring
    =
do_init_crypto_tls()), so tls_wrap_control() appends it, and free it
    wi=
th the rest of the probe's key material
  - choose the opcode (P_CONTROL_OO=
B_WKC_V1 vs P_CONTROL_OOB_V1) and
    report "tls-crypt-v2" in the wrapping=
 log line

Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Signed-off-=
by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/client-options=
=2Erst
M src/openvpn/oob_client=2Ec
2 files changed, 26 insertions(+), 27 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/59/1759/29

diff --git a/doc/man-sections/client-options=2Erst b/doc/=
man-sections/client-options=2Erst
index 7749f37=2E=2E370ef60 100644
--- a/d=
oc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=
=2Erst
@@ -625,9 +625,8 @@
   remote=2E
 
   The probe carries the same con=
trol-channel wrapping as a normal
-  connection (``--tls-auth`` or ``--tls-=
crypt``, when configured)=2E With
-  ``--tls-crypt-v2`` the remotes are lef=
t in their configured order,
-  because the server cannot unwrap an out-of-=
band probe yet=2E
+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls=
-crypt-v2``,
+  when configured)=2E
 
   Only UDP remotes are probed, and o=
nly when there are at least two
   remotes; remotes reached through a SOCKS=
 proxy are not probed=2E The
diff --git a/src/openvpn/oob_client=2Ec b/src/=
openvpn/oob_client=2Ec
index 70c9675=2E=2E35c71e3 100644
--- a/src/openvpn/=
oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -73,6 +73,7 @@
     /* W=
hat each probe is built from; only the request_id differs=2E */
     struct=
 tls_auth_standalone *tas;
     struct session_id *client_sid;
+    int opc=
ode;
     struct oob_probe_request req;
 #ifdef TARGET_ANDROID
     bool fd=
_protected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket */
@@ =
-90,22 +91,11 @@
 /* Build the standalone wrapping context the probe is sen=
t with, mirroring the
  * one the server answers it with, keyed like ce, th=
e entry every other probed
  * remote was checked against; without tls-auth=
/tls-crypt it stays in
- * TLS_WRAP_NONE and the probe goes out in plaintex=
t=2E Returns NULL (and logs)
- * for tls-crypt-v2, which the probe cannot c=
arry yet=2E */
+ * TLS_WRAP_NONE and the probe goes out in plaintext=2E */
=
 static struct tls_auth_standalone *
 oob_probe_init_tls_auth_standalone(st=
ruct context *c, const struct connection_entry *ce,
                       =
             struct gc_arena *gc)
 {
-    /* tls-crypt-v2 wraps with a per-=
client key the server only learns from the
-     * wrapped client key (WKc)=
 carried in the TLS handshake=2E An out-of-band
-     * probe carries no WK=
c, so the server cannot unwrap it; skip probing rather
-     * than send so=
mething unverifiable=2E */
-    if (ce->tls_crypt_v2_file)
-    {
-        =
msg(D_LOW, "server-probe: not supported with tls-crypt-v2; using configured=
 order");
-        return NULL;
-    }
-
     /* options=2Ece is not mapped=
 yet; options_postprocess_mutate_ce() has already
      * copied any global=
 key into ce=2E Loaded again per-connection later=2E */
     do_init_tls_wr=
ap_key(c, ce);
@@ -116,6 +106,14 @@
     to=2Ereplay_window =3D c->options=
=2Ereplay_window;
     to=2Ereplay_time =3D c->options=2Ereplay_time;
 
+  =
  /* Attach our WKc so tls_wrap_control() appends it=2E Only a client has o=
ne;
+     * a server config's tls-crypt-v2 key leaves the probe in TLS_WRAP=
_NONE, so
+     * it must not be sent as P_CONTROL_OOB_WKC_V1=2E */
+    if=
 (ce->tls_crypt_v2_file && c->options=2Etls_client)
+    {
+        to=2Etl=
s_wrap=2Etls_crypt_v2_wkc =3D &c->c1=2Eks=2Etls_crypt_v2_wkc;
+    }
+
    =
 struct tls_auth_standalone *tas =3D tls_auth_standalone_init(&to, gc);
 
 =
    tls_init_control_channel_frame_parameters(&tas->frame, ce->tls_mtu);
@@=
 -134,6 +132,8 @@
     tls_auth_standalone_free(tas);
     free_key_ctx_bi(=
&c->c1=2Eks=2Etls_wrap_key);
     CLEAR(c->c1=2Eks=2Etls_wrap_key);
+    bu=
f_clear(&c->c1=2Eks=2Etls_crypt_v2_wkc);
+    free_buf(&c->c1=2Eks=2Etls_cr=
ypt_v2_wkc);
     /* the raw key bytes too: do_init_crypto_tls_c1() may nev=
er load a key over
      * them, so they would otherwise stay resident for =
the process lifetime */
     secure_memzero(&c->c1=2Eks=2Eoriginal_wrap_key=
data, sizeof(c->c1=2Eks=2Eoriginal_wrap_keydata));
@@ -153,7 +153,7 @@
    =
     return false;
     }
     *probe =3D tls_wrap_oob_standalone(&pc->tas-=
>tls_wrap, pc->tas, pc->client_sid, &payload,
-                            =
         P_CONTROL_OOB_V1);
+                                     pc->opcod=
e);
     return BLEN(probe) > 0;
 }
 
@@ -693,14 +693,8 @@
     }
 
     /*=
 Wrapping context for the probe (tls-auth/tls-crypt, or plaintext if
-     =
* neither)=2E NULL means this configuration cannot be probed; keep the
-   =
  * configured order=2E */
+     * neither)=2E */
     struct tls_auth_stan=
dalone *tas =3D oob_probe_init_tls_auth_standalone(c, tmpl, &gc);
-    if (=
!tas)
-    {
-        gc_free(&gc);
-        return;
-    }
 
     struct p=
robe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };
     =
struct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, t=
rue, &gc);
@@ -709,18 +703,24 @@
     /* Every probe is a single probe requ=
est TLV, wrapped (or sent in
      * plaintext) like any other control pack=
et, with the client session id as
      * the sender session id=2E Each tra=
nsmission is built on its own, as each
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
Gerrit-PatchSet: 29
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

--s45lQm3Bjtc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #29</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Send tls-crypt-v2 probe requests from the client<br><br>When=
 tls-crypt-v2 is configured, send the probe as P_CONTROL_OOB_WKC_V1<br>with=
 the wrapped client key (WKc) appended, so the server can recover<br>the pe=
r-client key and unwrap it=2E Without tls-crypt-v2 the probe stays a<br>pla=
in P_CONTROL_OOB_V1, unchanged=2E<br><br>  - drop the &quot;skip probing un=
der tls-crypt-v2&quot; bail-out<br>  - make the WKc available on the probe&=
#39;s wrap context (mirroring<br>    do_init_crypto_tls()), so tls_wrap_con=
trol() appends it, and free it<br>    with the rest of the probe&#39;s key =
material<br>  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL_OOB_V1=
) and<br>    report &quot;tls-crypt-v2&quot; in the wrapping log line<br><b=
r>Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0<br>Signed-off-by: Le=
v Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-op=
tions=2Erst<br>M src/openvpn/oob_client=2Ec<br>2 files changed, 26 insertio=
ns(+), 27 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/59/1759/29</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc=
/man-sections/client-options=2Erst b/doc/man-sections/client-options=2Erst<=
/span><br><span>index 7749f37=2E=2E370ef60 100644</span><br><span>--- a/doc=
/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/c=
lient-options=2Erst</span><br><span>@@ -625,9 +625,8 @@</span><br><span>   =
remote=2E</span><br><span> </span><br><span>   The probe carries the same c=
ontrol-channel wrapping as a normal</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  connection (``--tls-auth`` or ``--tls-crypt``, when configu=
red)=2E With</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls=
-crypt-v2`` the remotes are left in their configured order,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  because the server cannot unwrap an=
 out-of-band probe yet=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls-crypt-v2``,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  when configured)=
=2E</span><br><span> </span><br><span>   Only UDP remotes are probed, and o=
nly when there are at least two</span><br><span>   remotes; remotes reached=
 through a SOCKS proxy are not probed=2E The</span><br><span>diff --git a/s=
rc/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>inde=
x 70c9675=2E=2E35c71e3 100644</span><br><span>--- a/src/openvpn/oob_client=
=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -7=
3,6 +73,7 @@</span><br><span>     /* What each probe is built from; only th=
e request_id differs=2E */</span><br><span>     struct tls_auth_standalone =
*tas;</span><br><span>     struct session_id *client_sid;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int opcode;</span><br><span>     =
struct oob_probe_request req;</span><br><span> #ifdef TARGET_ANDROID</span>=
<br><span>     bool fd_protected[PROBE_AF_COUNT]; /* VPNService protect(), =
once per socket */</span><br><span>@@ -90,22 +91,11 @@</span><br><span> /* =
Build the standalone wrapping context the probe is sent with, mirroring the=
</span><br><span>  * one the server answers it with, keyed like ce, the ent=
ry every other probed</span><br><span>  * remote was checked against; witho=
ut tls-auth/tls-crypt it stays in</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * TLS_WRAP_NONE and the probe goes out in plaintext=2E Returns=
 NULL (and logs)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * fo=
r tls-crypt-v2, which the probe cannot carry yet=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * TLS_WRAP_NONE and the probe goes out =
in plaintext=2E */</span><br><span> static struct tls_auth_standalone *</sp=
an><br><span> oob_probe_init_tls_auth_standalone(struct context *c, const s=
truct connection_entry *ce,</span><br><span>                               =
     struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* tls-crypt-v2 wraps with a per-client key the =
server only learns from the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * wrapped client key (WKc) carried in the TLS handshake=2E An ou=
t-of-band</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * probe=
 carries no WKc, so the server cannot unwrap it; skip probing rather</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * than send something u=
nverifiable=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(D_LOW, &quot;server-probe: not supported with tls-crypt-v2; using confi=
gured order&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
   /* options=2Ece is not mapped yet; options_postprocess_mutate_ce() has a=
lready</span><br><span>      * copied any global key into ce=2E Loaded agai=
n per-connection later=2E */</span><br><span>     do_init_tls_wrap_key(c, c=
e);</span><br><span>@@ -116,6 +106,14 @@</span><br><span>     to=2Ereplay_w=
indow =3D c-&gt;options=2Ereplay_window;</span><br><span>     to=2Ereplay_t=
ime =3D c-&gt;options=2Ereplay_time;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Attach our WKc so tls_wrap_contro=
l() appends it=2E Only a client has one;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * a server config&#39;s tls-crypt-v2 key leaves t=
he probe in TLS_WRAP_NONE, so</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * it must not be sent as P_CONTROL_OOB_WKC_V1=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_v2_=
file &amp;&amp; c-&gt;options=2Etls_client)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;c-&gt;c1=2Eks=
=2Etls_crypt_v2_wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     struct tls_auth_standalone *tas =3D tls_auth_standalone_init(&amp;=
to, gc);</span><br><span> </span><br><span>     tls_init_control_channel_fr=
ame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br><span>@@ -134=
,6 +132,8 @@</span><br><span>     tls_auth_standalone_free(tas);</span><br>=
<span>     free_key_ctx_bi(&amp;c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><s=
pan>     CLEAR(c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf_clear(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_w=
kc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&a=
mp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc);</span><br><span>     /* the raw key b=
ytes too: do_init_crypto_tls_c1() may never load a key over</span><br><span=
>      * them, so they would otherwise stay resident for the process lifeti=
me */</span><br><span>     secure_memzero(&amp;c-&gt;c1=2Eks=2Eoriginal_wra=
p_keydata, sizeof(c-&gt;c1=2Eks=2Eoriginal_wrap_keydata));</span><br><span>=
@@ -153,7 +153,7 @@</span><br><span>         return false;</span><br><span>=
     }</span><br><span>     *probe =3D tls_wrap_oob_standalone(&amp;pc-&gt;=
tas-&gt;tls_wrap, pc-&gt;tas, pc-&gt;client_sid, &amp;payload,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
   P_CONTROL_OOB_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                     pc-&gt;opcode);</span><br><span>    =
 return BLEN(probe) &gt; 0;</span><br><span> }</span><br><span> </span><br>=
<span>@@ -693,14 +693,8 @@</span><br><span>     }</span><br><span> </span><=
br><span>     /* Wrapping context for the probe (tls-auth/tls-crypt, or pla=
intext if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * neith=
er)=2E NULL means this configuration cannot be probed; keep the</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * configured order=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E */</=
span><br><span>     struct tls_auth_standalone *tas =3D oob_probe_init_tls_=
auth_standalone(c, tmpl, &amp;gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (!tas)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span> </span><br><span>     struct probe_ctx pc =3D { =2Esd =3D { SOCKE=
T_UNDEFINED, SOCKET_UNDEFINED } };</span><br><span>     struct oob_probe_ta=
rget *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);</=
span><br><span>@@ -709,18 +703,24 @@</span><br><span>     /* Every probe is=
 a single probe request TLV, wrapped (or sent in</span><br><span>      * pl=
aintext) like any other control packet, with the client session id as</span=
><br><span>      * the sender session id=2E Each transmission is built on i=
ts own, as each</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 carries its own request_id=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * carries its own request_id=2E With tls-crypt-v2 the pr=
obe must carry the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * wrapped client key so the server can recover the per-client key; that=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * a P_CONTR=
OL_OOB_WKC_V1 message=2E Otherwise (tls-crypt v1, tls-auth, or</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * plaintext) it is a plain =
P_CONTROL_OOB_V1=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const bool is_v2 =3D (tas-&gt;tls_wrap=2Etls_crypt_v2_wkc !=3D NULL)=
;</span><br><span>     pc=2Etas =3D tas;</span><br><span>     pc=2Eclient_s=
id =3D &amp;client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    pc=2Eopcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB_V1;</s=
pan><br><span>     pc=2Eid_base =3D (uint32_t)get_random();</span><br><span=
>     pc=2Ereq =3D (struct oob_probe_request){</span><br><span>         =2E=
timestamp =3D (uint64_t)now,</span><br><span>         =2Eflags =3D 0,</span=
><br><span>     };</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=
=3D TLS_WRAP_CRYPT)  ? &quot;tls-crypt&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                            : (tas-&gt;tls_wrap=2Emo=
de =3D=3D TLS_WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                                 =
                   : &quot;none (plaintext)&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *wrap_name =3D is_v2         =
                           ? &quot;tls-crypt-v2&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            : (tas-&gt;tl=
s_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? &quot;tls-crypt&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                            : (tas=
-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH)  ? &quot;tls-auth&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                                         : &quot;none (plaintext)&quot;;</s=
pan><br><span>     msg(D_LOW, &quot;server-probe: probing %d remote(s) with=
 a %d ms window, control-channel wrapping: %s&quot;,</span><br><span>      =
   l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);</span><br></pre><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail=
">change 1759</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/175=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1759 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 29 </div>
<div style=3D"display:none"> Gerrit-Owner: st=
ipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>

</body></html>
--s45lQm3Bjtc=--


--===============8618971477811148890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8618971477811148890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8618971477811148890==--

