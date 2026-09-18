Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C563EC982DD
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c3GSfJppkom4sMu8YPsBHUc0VRwIfWrDnYG1W8OOaF4=; b=cTM+Q+oFoiF7RP9tKrrlyJ1ASD
	t2bIYWvuFyoJggopbYM33Cn7ed3Fr4NGESuxJfuUfNxki/n110bct8Ac4UQqOmWY/0wM7bdjMuOb6
	w3NzZ9mTGOD3qUTkMADiAnkGf1Nx2nXiQfr6yx21yIDhW5ugbXEwdrZSOYr69ApRYWDo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7g3J-0005mI-51;
	Fri, 18 Sep 2026 21:23:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7g3H-0005mA-Kw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 21:23:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8DcMQI+af/1MlBjWJoTnje1vQrmMS2TAEm2iwWV/eo8=; b=WdqDy+uC9URO+XcVss59FEQ+Oo
 tHFrgmE6EMJRc0Bo8eWsbfa5v+4TJgmTqPmK0ijezlSITP0MEXyjEhtv7MK9hhQFVBfILCl1iEM4Y
 K77SF26u/nEyxjXUWEgVaOLt4ipr+rMNe3EJEHoZCQfdiNgUVgAZx3l+1kcmFfNAlYQQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8DcMQI+af/1MlBjWJoTnje1vQrmMS2TAEm2iwWV/eo8=; b=E
 FY2VmHBCjaGz8aSWu6HfmiepAfGoFvY06MySy9KzbkdGQW4023qw4b/J0WZaxWwn99L7R+1lYH2l5
 yQJKVNXCM9+miwknBGoMcrD5qX+m6fSoVwJIRpmthl+7Qi88PF7nx7a6ZQ+LN7VUxDKgDsHv7r87s
 Otocl60G3UvbQ5wk=;
Received: from mail-wr2-f28.google.com ([74.125.225.92])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7g3F-0005AI-91 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 21:23:23 +0000
Received: by mail-wr2-f28.google.com with SMTP id
 ffacd0b85a97d-485b1d2874aso872360f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 14:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789766595; x=1790371395; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8DcMQI+af/1MlBjWJoTnje1vQrmMS2TAEm2iwWV/eo8=;
 b=Np3G3aMA3q6zGndVbCqALORUvO2Bx/qIZ0r+qIPKz2lKEkyLBWR3KKcT4fI8ae05nB
 hUgID+gsRago3bRwYkZCenY6QmwXVZW+Kcop1ioqsFYxC98CEVb1Idj9cm1u/OpJsq/s
 BPY3nLU4llLIsuIl6uldnHCopuH4u11C5wxz/tmhiRwYDqdZF1JV0Fh26MZlupt0lfba
 wHpCa55Cgi0BLPNCnBMaDKTHYf35PmpdG89XP426vPoT78tYb6NvanzXz2DsK2WpGvWM
 0y8Z4scvPvEVT/438rU2e4UMEN2/0jSiZuU5zZscZ1WMh4HyzRzk+37+4SuHUONwYOIe
 4IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789766595; x=1790371395;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8DcMQI+af/1MlBjWJoTnje1vQrmMS2TAEm2iwWV/eo8=;
 b=Vrc6WXjmvkC4p4InR9yenyowsdxJTrnWfyGQDu6k6Z4A1NuWo3HdaNc2TfCNRVLe+M
 agpI/Hk+CqZJLGMiZtUFFM0cnwEw64Ps0YjwH3grk9od/WTrPelsiyRyIcYS4kyunWxJ
 iQGBQs2Gz2xHpFUwk2O+z35x5CBgA18WAl+EdltvFFiS6vFeekJXluAbxXn+dPiHnm8l
 tTZEMvRHt8jEEBPpWDON6Su/S9LgaAcRNDH+saAlwn44xZ0wkzezqh645d6KReNwp3Kx
 Wv4Y3s1J4Ss064sMevOR6DCsKVHa2CRifOXladAyWxBjXFsLkM8vWrqFyFnRZmtBXXds
 rNNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc+jyxtgLEmsZUxiqnWh84yiTk+Oo3aq5glqt3bl7nM/M0kNej89sMGnQ3url0Pd+r5UAJJPMmiJJ3/6ON@lists.sourceforge.net
X-Gm-Message-State: AFuF++kpywlCFydRVb6eH19FySAnhDlh/UtSFriaLyx5giWTfxSM2hkh
 HGH+m7jd0U0KFhJj/MHapHExWW0D71QUn7irU7IPLuaSIkjktYCIQp11PlIcj9oaqVMovcRZ0E/
 jg4grZcqF2vEz7kmUHG0SPUxfFbqmyTCqQuCLXWB1w12HEdkc+R1nwf8ROGUEY9h+cSje
X-Gm-Gg: AYBFou0jxkuT5M+v1QWpxijLWtAhHUnoVJqiTe5ziu4rQlTKGUNYOCel1lzK+oOvJxC
 o0KGPTgt63hXiT2QlpwqB/PAA935z0H2O18uec1sLMwq4A7PM1TgvXx4P3D3IkL/27Yh0tUsHSN
 SensAsSwT6yPBMT2uDekGbXcg8PedRub0nLS//EES8FkAIRD+ezAhWVRC72WzxS8W0ZMq+3jIMC
 6xEDTjiosMUMSA2ajSOjaKzosTjJ3ihp460zKv60uFebM5G1fLq3zsS8BRYQ70qyNgtpkMEx2z+
 rlSiICJ5liNf6qnYjULKW5FMHKIR3MVKf5NwuTM7JpAfA5RNGGOTQXhajP6QITDvIx0EujVB1gL
 ndtU9zOTjE7XfcAocqunTcnYfCtJ8+u1iZvF21sgJ/YeiNlD4IckscEgtYpWZpjTF6k1aDEKdkw
 FtWCCyUx6n2wbGDBo7Q1DxMgvnkwXOT12RKad+6SLYGDSjhYDVEbgwEv29w8bQPCCRkF1vGfxqW
 Do3sGhe8hh17VIWJkHmN0KkSePlf5uqM7gyUEIKIYYNQap7cy9tGgnZ7kESeCcI2eAwYEtKM49B
 yzeC+zaJC2LUIh/kIWu6lkSxo3SjD/lUgDprVJWNOmfGzCApPMrDZReENyl6gw==
X-Received: by 2002:a05:6000:2401:b0:487:939:3fa9 with SMTP id
 ffacd0b85a97d-4871e38b4a9mr10359467f8f.27.1789766594560; 
 Fri, 18 Sep 2026 14:23:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724460767sm1580861f8f.13.2026.09.18.14.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 14:23:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 21:23:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 6b5f8ff6763307e659b32a4bf47967abf8cb9311
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <455541e98ff933e0ebbed6d5cd86b01bd668412e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7g3F-0005AI-91
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 lstipakov@gmail.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4185867452172094124=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4185867452172094124==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mBpgacdv0ag="; charset=UTF-8

--mBpgacdv0ag=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1835?usp=3Demail )

Change subject: dco: do not exit the process when i=
nstalling a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

dco: do not exit the process when installing a DCO key fails
=

When the DCO peer is gone from the kernel while userspace still believes
i=
t exists, dco_new_key() fails with ENOENT and init_key_contexts() calls
msg=
(M_FATAL, =2E=2E=2E)=2E On a server this terminates the whole daemon and
di=
sconnects every other client, even though only a single peer is
affected=2E=


Propagate the failure instead=2E Since a DCO desync needs a different
rec=
overy than any other key generation error - the kernel peer has to be
re-cr=
eated, which only a reconnect can do - report it as a distinct
key_gen_stat=
us through generate_key_expansion() and
tls_session_generate_data_channel_k=
eys(), and let tls_multi_process()
turn it into a new TLSMP_RESTART result =
that check_tls() dispatches as a
SIGUSR1=2E On a server this restarts only =
the affected client instance=2E

The restart request is tracked separately =
from 'active' because it must
not be overwritten by a later TLSMP_ACTIVE or=
 TLSMP_RECONNECT
assignment, and the return value now applies an explicit p=
recedence:
killing the session supersedes restarting it, which supersedes '=
active'=2E

tls_session_update_crypto_params_do_work() collapses the desync=
 back to
a plain failure, as all of its callers already turn a failure into=
 a
SIGUSR1=2E

Note that commit ea3bb67e2b1e ("dco: make key state desync r=
ecoverable")
does not cover this case, as both of its hunks are conditional=
 on the
key installation having succeeded=2E

Github: fixes OpenVPN/openvpn=
#542
Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Signed-off-by: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
835
Message-Id: <20260806120220=2E3806-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg381=
76=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/o=
penvpn/forward=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
3 files chan=
ged, 73 insertions(+), 22 deletions(-)




diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec
index 83cd113=2E=2E6fe5849 100644
--- a/src/=
openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -206,6 +206,12 @@
    =
             register_signal(c->sig, SIGTERM, "auth-control-exit");
       =
      }
         }
+        else if (tmp_status =3D=3D TLSMP_RESTART)
+    =
    {
+            /* The session cannot recover on its own=2E Kill the con=
nection so
+             * that it is set up again from scratch */
+       =
     register_signal(c->sig, SIGUSR1, "dco key state desync");
+        }
 =

         interval_future_trigger(&c->c2=2Etmp_int, wakeup);
     }
diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ddbf067=2E=2E2a115d4 =
100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1401,7 +1401=
,22 @@
     secure_memzero(&e1_recv, sizeof(e1_recv));
 }
 
-static void
+/=
**
+ * Outcome of generating the data channel keys of a session=2E
+ *
+ * =
\c KEY_GEN_DCO_DESYNC is kept distinct from \c KEY_GEN_FAILED because it
+ =
* means userspace and kernel disagree about the DCO peer: the session canno=
t
+ * recover on its own and the connection has to be restarted, while any =
other
+ * failure only invalidates the affected key state=2E
+ */
+enum key=
_gen_status
+{
+    KEY_GEN_OK,         /**< keys were generated and instal=
led */
+    KEY_GEN_FAILED,     /**< generation failed, invalidate the key =
state */
+    KEY_GEN_DCO_DESYNC, /**< the DCO peer is gone from the kernel=
 */
+};
+
+static enum key_gen_status
 init_key_contexts(struct key_state *=
ks, struct tls_multi *multi, const struct key_type *key_type,
             =
      bool server, const struct key2 *key2, bool dco)
 {
@@ -1420,7 +1435,1=
6 @@
         int ret =3D init_key_dco_bi(multi, ks, key2, key_direction, k=
ey_type->cipher, server);
         if (ret < 0)
         {
-            msg=
(M_FATAL, "Impossible to install key material in DCO: %s", strerror(-ret));=

+            /* This normally means the DCO peer is gone from the kernel w=
hile
+             * userspace still believes it exists=2E Do not take the =
whole
+             * process down over a single peer: report the desync so=
 that the
+             * connection is restarted and the peer re-created f=
rom scratch */
+            msg(M_WARN,
+                "Impossible to ins=
tall key material in DCO: %s=2E The underlying "
+                "DCO peer=
 may have been deleted from the kernel without "
+                "notifyin=
g userspace=2E Restarting the session=2E",
+                strerror(-ret))=
;
+            return KEY_GEN_DCO_DESYNC;
         }
 
         /* encrypt/=
decrypt context are unused with DCO */
@@ -1443,6 +1467,8 @@
     {
       =
  init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
    =
 }
+
+    return KEY_GEN_OK;
 }
 
 static bool
@@ -1503,11 +1529,11 @@
  * =
Using source entropy from local and remote hosts, mix into
  * master key=
=2E
  */
-static bool
+static enum key_gen_status
 generate_key_expansion(s=
truct tls_multi *multi, struct key_state *ks, struct tls_session *session)
=
 {
     const struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
=
-    bool ret =3D false;
+    enum key_gen_status ret =3D KEY_GEN_FAILED;
 =
    struct key2 key2;
 
     if (key->initialized)
@@ -1552,8 +1578,8 @@
  =
       }
     }
 
-    init_key_contexts(ks, multi, &session->opt->key_type=
, server, &key2, session->opt->dco_enabled);
-    ret =3D true;
+    ret =
=3D init_key_contexts(ks, multi, &session->opt->key_type, server, &key2,
+ =
                           session->opt->dco_enabled);
 
 exit:
     secure=
_memzero(&key2, sizeof(key2));
@@ -1567,10 +1593,10 @@
  * This erases the =
source material used to generate the data channel keys, and
  * can thus be=
 called only once per session=2E
  */
-bool
+static enum key_gen_status
 tl=
s_session_generate_data_channel_keys(struct tls_multi *multi, struct tls_se=
ssion *session)
 {
-    bool ret =3D false;
+    enum key_gen_status ret =
=3D KEY_GEN_FAILED;
     struct key_state *ks =3D &session->key[KS_PRIMARY]=
; /* primary key */
 
     if (ks->authenticated <=3D KS_AUTH_FALSE)
@@ -15=
81,7 +1607,8 @@
 
     ks->crypto_options=2Eflags =3D session->opt->crypto_=
flags;
 
-    if (!generate_key_expansion(multi, ks, session))
+    ret =3D=
 generate_key_expansion(multi, ks, session);
+    if (ret !=3D KEY_GEN_OK)
=
     {
         msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed=
");
         goto cleanup;
@@ -1593,7 +1620,6 @@
     /* set the state of t=
he keys for the session to generated */
     ks->state =3D S_GENERATED_KEYS=
;
 
-    ret =3D true;
 cleanup:
     secure_memzero(ks->key_src, sizeof(*k=
s->key_src));
     return ret;
@@ -1665,7 +1691,10 @@
             }
      =
   }
     }
-    return tls_session_generate_data_channel_keys(multi, sessi=
on);
+    /* A DCO desync is reported as a plain failure here: every caller=
 of this
+     * function already turns a failure into a SIGUSR1, which is =
exactly the
+     * recovery a desync needs */
+    return tls_session_gene=
rate_data_channel_keys(multi, session) =3D=3D KEY_GEN_OK;
 }
 
 bool
@@ -33=
36,6 +3365,9 @@
     struct gc_arena gc =3D gc_new();
     int active =3D T=
LSMP_INACTIVE;
     bool error =3D false;
+    /* kept separate from 'activ=
e' on purpose: a restart request must not be
+     * overwritten by a later=
 TLSMP_ACTIVE/TLSMP_RECONNECT assignment */
+    bool restart =3D false;
 
=
     tls_clear_error();
 
@@ -3436,12 +3468,22 @@
             /* Session i=
s now fully authenticated=2E
              * tls_session_generate_data_chan=
nel_keys will move ks->state
              * from S_ACTIVE to S_GENERATED_K=
EYS */
-            if (!tls_session_generate_data_channel_keys(multi, sess=
ion))
+            enum key_gen_status status =3D tls_session_generate_data=
_channel_keys(multi, session);
+            if (status !=3D KEY_GEN_OK)
   =
          {
                 msg(D_TLS_ERRORS, "TLS Error: generate_key_exp=
ansion failed");
                 ks->authenticated =3D KS_AUTH_FALSE;
    =
             key_state_ssl_shutdown(&ks->ks_ssl);
                 ks->stat=
e =3D S_ERROR_PRE;
+
+                /* Invalidating the key state is not =
enough to recover from a
+                 * DCO desync: the kernel peer ha=
s to be re-created, and the
+                 * key state we just invalidat=
ed will never be retried, so ask
+                 * for a restart right aw=
ay */
+                if (status =3D=3D KEY_GEN_DCO_DESYNC)
+             =
   {
+                    restart =3D true;
+                }
            =
 }
 
             /* Update auth token on the client if needed on renegotia=
tion
@@ -3529,7 +3571,17 @@
 
     gc_free(&gc);
 
-    return (tas =3D=3D =
TLS_AUTHENTICATION_FAILED) ? TLSMP_KILL : active;
+    /* strongest outcome=
 wins: killing the session supersedes restarting it,
+     * and restarting=
 supersedes whatever 'active' ended up being */
+    if (tas =3D=3D TLS_AUT=
HENTICATION_FAILED)
+    {
+        return TLSMP_KILL;
+    }
+    if (rest=
art)
+    {
+        return TLSMP_RESTART;
+    }
+    return active;
 }
 
=
 /**
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=
=2E=2E5483fbb 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@=
 -231,6 +231,8 @@
 #define TLSMP_ACTIVE    1
 #define TLSMP_KILL      2
 #d=
efine TLSMP_RECONNECT 3
+/** the session cannot recover on its own and has =
to be restarted */
+#define TLSMP_RESTART   4
 
 /*
  * Called by the top-l=
evel event loop=2E
@@ -554,15 +556,6 @@
 void show_available_tls_ciphers(co=
nst char *cipher_list, const char *cipher_list_tls13,
                     =
            const char *tls_cert_profile);
 
-
-/**
- * Generate data chann=
el keys for the supplied TLS session=2E
- *
- * This erases the source mate=
rial used to generate the data channel keys, and
- * can thus be called onl=
y once per session=2E
- */
-bool tls_session_generate_data_channel_keys(str=
uct tls_multi *multi, struct tls_session *session);
-
 void tls_session_sof=
t_reset(struct tls_multi *multi);
 
 /**

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Gerrit-Change=
-Number: 1835
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--mBpgacdv0ag=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1835?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco: do not exit the process when installi=
ng a DCO key fails<br><br>When the DCO peer is gone from the kernel while u=
serspace still believes<br>it exists, dco_new_key() fails with ENOENT and i=
nit_key_contexts() calls<br>msg(M_FATAL, =2E=2E=2E)=2E On a server this ter=
minates the whole daemon and<br>disconnects every other client, even though=
 only a single peer is<br>affected=2E<br><br>Propagate the failure instead=
=2E Since a DCO desync needs a different<br>recovery than any other key gen=
eration error - the kernel peer has to be<br>re-created, which only a recon=
nect can do - report it as a distinct<br>key_gen_status through generate_ke=
y_expansion() and<br>tls_session_generate_data_channel_keys(), and let tls_=
multi_process()<br>turn it into a new TLSMP_RESTART result that check_tls()=
 dispatches as a<br>SIGUSR1=2E On a server this restarts only the affected =
client instance=2E<br><br>The restart request is tracked separately from &#=
39;active&#39; because it must<br>not be overwritten by a later TLSMP_ACTIV=
E or TLSMP_RECONNECT<br>assignment, and the return value now applies an exp=
licit precedence:<br>killing the session supersedes restarting it, which su=
persedes &#39;active&#39;=2E<br><br>tls_session_update_crypto_params_do_wor=
k() collapses the desync back to<br>a plain failure, as all of its callers =
already turn a failure into a<br>SIGUSR1=2E<br><br>Note that commit ea3bb67=
e2b1e (&quot;dco: make key state desync recoverable&quot;)<br>does not cove=
r this case, as both of its hunks are conditional on the<br>key installatio=
n having succeeded=2E<br><br>Github: fixes OpenVPN/openvpn#542<br>Change-Id=
: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd<br>Signed-off-by: Antonio Quart=
ulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1835<br>Message-Id: &lt;20260806120220=2E3806-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg38176=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/ssl=
=2Ec<br>M src/openvpn/ssl=2Eh<br>3 files changed, 73 insertions(+), 22 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/src/openvp=
n/forward=2Ec</span><br><span>index 83cd113=2E=2E6fe5849 100644</span><br><=
span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forwar=
d=2Ec</span><br><span>@@ -206,6 +206,12 @@</span><br><span>                =
 register_signal(c-&gt;sig, SIGTERM, &quot;auth-control-exit&quot;);</span>=
<br><span>             }</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (tmp_status =3D=3D TLSMP_=
RESTART)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* The se=
ssion cannot recover on its own=2E Kill the connection so</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             * that it is set up agai=
n from scratch */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          register_signal(c-&gt;sig, SIGUSR1, &quot;dco key state desync&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span> </span><br><span>         interval_future_trigger(&amp;c-&gt;c=
2=2Etmp_int, wakeup);</span><br><span>     }</span><br><span>diff --git a/s=
rc/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index ddbf067=2E=
=2E2a115d4 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1401,7 +1401,22 @@</span><br=
><span>     secure_memzero(&amp;e1_recv, sizeof(e1_recv));</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Outcome of generating =
the data channel keys of a session=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * \c KEY_GEN_DCO_DESYNC is kept distinct from \c KEY_GEN_FAILED because i=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * means userspace=
 and kernel disagree about the DCO peer: the session cannot</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * recover on its own and the conne=
ction has to be restarted, while any other</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * failure only invalidates the affected key state=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+enum key_gen_status</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    KEY_GEN_OK,         /**&lt; keys were generate=
d and installed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   KEY_GEN_FAILED,     /**&lt; generation failed, invalidate the key state =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    KEY_GEN_DCO_D=
ESYNC, /**&lt; the DCO peer is gone from the kernel */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic enum key_gen_status</span><br><span> init_key_contexts(struct key_sta=
te *ks, struct tls_multi *multi, const struct key_type *key_type,</span><br=
><span>                   bool server, const struct key2 *key2, bool dco)</=
span><br><span> {</span><br><span>@@ -1420,7 +1435,16 @@</span><br><span>  =
       int ret =3D init_key_dco_bi(multi, ks, key2, key_direction, key_type=
-&gt;cipher, server);</span><br><span>         if (ret &lt; 0)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(M_FATAL, &quot;Impossible to install key material in DCO: %s&quot;=
, strerror(-ret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* This normally means the DCO peer is gone from the kernel whil=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * use=
rspace still believes it exists=2E Do not take the whole</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             * process down over a sin=
gle peer: report the desync so that the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             * connection is restarted and the peer re-=
created from scratch */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                &quot;Impossible to install key material in DCO: %s=
=2E The underlying &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                &quot;DCO peer may have been deleted from the kernel =
without &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           &quot;notifying userspace=2E Restarting the session=2E&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                strerr=
or(-ret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return KEY_GEN_DCO_DESYNC;</span><br><span>         }</span><br><span> <=
/span><br><span>         /* encrypt/decrypt context are unused with DCO */<=
/span><br><span>@@ -1443,6 +1467,8 @@</span><br><span>     {</span><br><spa=
n>         init_key_ctx_bi(key, key2, key_direction, key_type, &quot;Data C=
hannel&quot;);</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return KEY_GEN_OK;</span><br><span> }</span><br><span> </span><br><span>=
 static bool</span><br><span>@@ -1503,11 +1529,11 @@</span><br><span>  * Us=
ing source entropy from local and remote hosts, mix into</span><br><span>  =
* master key=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static enum key_gen_status</span><br><span> generate_key_expansion(s=
truct tls_multi *multi, struct key_state *ks, struct tls_session *session)<=
/span><br><span> {</span><br><span>     const struct key_ctx_bi *key =3D &a=
mp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    enum key_gen_status ret =3D KEY_GEN_FAILED;</span>=
<br><span>     struct key2 key2;</span><br><span> </span><br><span>     if =
(key-&gt;initialized)</span><br><span>@@ -1552,8 +1578,8 @@</span><br><span=
>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    init_key_contexts(ks, multi, &amp;sessi=
on-&gt;opt-&gt;key_type, server, &amp;key2, session-&gt;opt-&gt;dco_enabled=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D init_key_=
contexts(ks, multi, &amp;session-&gt;opt-&gt;key_type, server, &amp;key2,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       session-&gt;opt-&gt;dco_enabled);</span><br><span> </span><br><span>=
 exit:</span><br><span>     secure_memzero(&amp;key2, sizeof(key2));</span>=
<br><span>@@ -1567,10 +1593,10 @@</span><br><span>  * This erases the sourc=
e material used to generate the data channel keys, and</span><br><span>  * =
can thus be called only once per session=2E</span><br><span>  */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static enum key_gen_status</span><br><span> tls=
_session_generate_data_channel_keys(struct tls_multi *multi, struct tls_ses=
sion *session)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    enum key_gen_status ret =3D KEY_GEN_FAILED;</span><br><=
span>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* pri=
mary key */</span><br><span> </span><br><span>     if (ks-&gt;authenticated=
 &lt;=3D KS_AUTH_FALSE)</span><br><span>@@ -1581,7 +1607,8 @@</span><br><sp=
an> </span><br><span>     ks-&gt;crypto_options=2Eflags =3D session-&gt;opt=
-&gt;crypto_flags;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!generate_key_expansion(multi, ks, session))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D generate_key_ex=
pansion(multi, ks, session);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ret !=3D KEY_GEN_OK)</span><br><span>     {</span><br><spa=
n>         msg(D_TLS_ERRORS, &quot;TLS Error: generate_key_expansion failed=
&quot;);</span><br><span>         goto cleanup;</span><br><span>@@ -1593,7 =
+1620,6 @@</span><br><span>     /* set the state of the keys for the sessio=
n to generated */</span><br><span>     ks-&gt;state =3D S_GENERATED_KEYS;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
et =3D true;</span><br><span> cleanup:</span><br><span>     secure_memzero(=
ks-&gt;key_src, sizeof(*ks-&gt;key_src));</span><br><span>     return ret;<=
/span><br><span>@@ -1665,7 +1691,10 @@</span><br><span>             }</span=
><br><span>         }</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return tls_session_generate_data_channel_keys(mu=
lti, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* A DCO desync is reported as a plain failure here: every caller of this</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * function alread=
y turns a failure into a SIGUSR1, which is exactly the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * recovery a desync needs */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return tls_session_gen=
erate_data_channel_keys(multi, session) =3D=3D KEY_GEN_OK;</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span>@@ -3336,6 +3365=
,9 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     int active =3D TLSMP_INACTIVE;</span><br><span>     bool error =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* kept sep=
arate from &#39;active&#39; on purpose: a restart request must not be</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * overwritten by a l=
ater TLSMP_ACTIVE/TLSMP_RECONNECT assignment */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool restart =3D false;</span><br><span> </=
span><br><span>     tls_clear_error();</span><br><span> </span><br><span>@@=
 -3436,12 +3468,22 @@</span><br><span>             /* Session is now fully =
authenticated=2E</span><br><span>              * tls_session_generate_data_=
channel_keys will move ks-&gt;state</span><br><span>              * from S_=
ACTIVE to S_GENERATED_KEYS */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (!tls_session_generate_data_channel_keys(multi, sess=
ion))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            en=
um key_gen_status status =3D tls_session_generate_data_channel_keys(multi, =
session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (status !=3D KEY_GEN_OK)</span><br><span>             {</span><br><spa=
n>                 msg(D_TLS_ERRORS, &quot;TLS Error: generate_key_expansio=
n failed&quot;);</span><br><span>                 ks-&gt;authenticated =3D =
KS_AUTH_FALSE;</span><br><span>                 key_state_ssl_shutdown(&amp=
;ks-&gt;ks_ssl);</span><br><span>                 ks-&gt;state =3D S_ERROR_=
PRE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* Invalidating th=
e key state is not enough to recover from a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 * DCO desync: the kernel peer has =
to be re-created, and the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 * key state we just invalidated will never be retrie=
d, so ask</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       * for a restart right away */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (status =3D=3D KEY_GEN_DCO_DESYNC)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    restar=
t =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        }</span><br><span>             }</span><br><span> </span><br><span>=
             /* Update auth token on the client if needed on renegotiation<=
/span><br><span>@@ -3529,7 +3571,17 @@</span><br><span> </span><br><span>  =
   gc_free(&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return (tas =3D=3D TLS_AUTHENTICATION_FAILED) ? TLSMP_=
KILL : active;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* strongest outcome wins: killing the session supersedes restarting it,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and restarting s=
upersedes whatever &#39;active&#39; ended up being */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tas =3D=3D TLS_AUTHENTICATION_FAI=
LED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return TLSMP_KILL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (restart)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return TLSMP_RESTART;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return active;</span><br><span> }</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl=2Eh b/sr=
c/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2E5483fbb 100644</span><=
br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2E=
h</span><br><span>@@ -231,6 +231,8 @@</span><br><span> #define TLSMP_ACTIVE=
    1</span><br><span> #define TLSMP_KILL      2</span><br><span> #define T=
LSMP_RECONNECT 3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
 the session cannot recover on its own and has to be restarted */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define TLSMP_RESTART   4</sp=
an><br><span> </span><br><span> /*</span><br><span>  * Called by the top-le=
vel event loop=2E</span><br><span>@@ -554,15 +556,6 @@</span><br><span> voi=
d show_available_tls_ciphers(const char *cipher_list, const char *cipher_li=
st_tls13,</span><br><span>                                 const char *tls_=
cert_profile);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Generate data channel key=
s for the supplied TLS session=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This=
 erases the source material used to generate the data channel keys, and</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * can thus be called onl=
y once per session=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool tls_session_g=
enerate_data_channel_keys(struct tls_multi *multi, struct tls_session *sess=
ion);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> void tls_session_soft_reset(struct tls_multi *multi);</span><br><span> </=
span><br><span> /**</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change 1=
835</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5=
64edc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1835 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--mBpgacdv0ag=--


--===============4185867452172094124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4185867452172094124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4185867452172094124==--

