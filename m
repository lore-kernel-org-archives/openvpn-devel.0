Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FDAC5AC67
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0VKqJocsNV5vDhLUAhH5r2Pqt0EjgMdlnbRSxzZxU+k=; b=RkLfV7hV1+iidb5oCicy6rLOl/
	FsAuZueg7rNJbE86zVsk1kvE/XjU42u5OsBHd7XbEqFDeyF/ccm6LmToa6RhSUaVqqbGcauOQUHMi
	H86dOvkJkJQjFxgnIwCcPBepmHCwDigFJ190OktCGpBYhERYaUhZ68mq5z/lRgu81RBc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrwDV-0000kv-JJ;
	Thu, 06 Aug 2026 11:24:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrwDU-0000ki-Iv
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U75Yk6fjBh5Gl9JwuXIJPrYwsEUNRGcfPLbCemTCpLM=; b=QdRZRWw7+b2GQfQL0sdAXzhNQ+
 OLrMFcSxPDRK6WcGc9kFNy3g1KjbrPYhXgXGxDJqTPELSV4iOLcASIP8VqEoLmvaKvXfXorw2DcDT
 ekLFachc48MXAfOV7Hw5DjIxLEvrv13Xm6LB/QAsARVFYRxf+Cpukn1jA4Axv++L8v98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U75Yk6fjBh5Gl9JwuXIJPrYwsEUNRGcfPLbCemTCpLM=; b=a
 X1+vgGnX+khLQoPGwTvB5ZlhAfgcTvfN3L/vSwghL0fEQ9h6kYeMzwYV37+ke6V6xtIQyxysdzhGS
 crXREsfAcq8WOEMjOuFau27YF8krDAmKX3GLlVP2Xp4rW559LkMYPTpImlhJUiXuhXJHMDjdkMIWe
 vN+hiM7IYZWl5QIc=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrwDW-00024e-So for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:24:52 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47de008b020so512085f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786015485; x=1786620285; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U75Yk6fjBh5Gl9JwuXIJPrYwsEUNRGcfPLbCemTCpLM=;
 b=CoSgUTuGl4S6TZoALzm3nyk/NT/cfyoz6S8guYKEWQfTV5LLXNe8o7+jYQ196FujAk
 eDwiudk43e8p3FpotSsmhLF9AF8gvTK8093ifJth2f8ye4eO+cBQbnP+kxD5NDZypJQW
 9QH4B4DGQjNXwo2fAFKSsOK53YWe1WpUfjCMEivgBeVo5MEEdr6DU7oak2gwceh0Pjsm
 xyFX7cmUeOdZqioFSEo0BT8DE4RyOgpB1MagzabfhVewxSjo0Rs5PjsKSgwk7rBSG6/c
 BY48NWQZG4cCyUjE3o/BYBneK+Ng5bpTKUUiSmHHCYLebkZdl6nw2E+oQg6hpfHgvxIq
 1XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786015485; x=1786620285;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U75Yk6fjBh5Gl9JwuXIJPrYwsEUNRGcfPLbCemTCpLM=;
 b=jIBO6gp64sCRoHftChs/EqshFWmL6sv6bPeokPSyf9FzWecjOF4JNLfvC5Wsn2las7
 /CNgF4eX/Zd+hI864sjDMHWSr+EAvmxDtjuYYahW9kpqr+FQn3KwjfU2RddCWIW1LopF
 xPJ6eEiifB95SfDhpxEFaUv7CL9GBDZSvDkQ1IQUWYG8Msx5+ODaS9jLDkNK4aWQf8wE
 O+kW/AIRdIivSD4ayskuV7ozf0gBGK8kQP8gbBdrcW4fm4K4d9b0EuNfsGEOGJetMI2K
 VKT/Pb5kz377pqidKY4H74lTiZdbHUdePB6SDJ++kjYvo/z9MLQC8fEmi1AiZWUsiNW8
 6bkw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9pMkEdgfgQGxMWDZVofGggyLnGr3fK0lSRBhtQdijP0dO0yOBOJxJPzS6FKILL06RrhSCqgVym31Mlr9z@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx7pE90WCb4CH+co/Jkmi1nogwMob9bvDZtbz50JjizCAcp6yPA
 hWBoy4QR7l6M6BiFtaFvGKZy0Ab4MSYlYMb6PdCN3Dtk3RS1ruOQT0wqFmEMPRqKJywkh0rdUFe
 t/JmJzGNBtJm4iYJiwJ3LB8nw5epejBeBGt/JyZWhpn9Os1FRCXn0Qv0LHCkD+Rd6uQKF
X-Gm-Gg: AR+sD13Hdddy7QV/rxmeWSryCzBifRmIr6rmblVYGAAm3ErKjufaOlkpSEWVH58/x7e
 xpFCmnwZGOjFCiXEhArGi/Yy2L/Ta8XS9KGfNJEwaUVdhPTKgTH3M8Sw7FJ/gFHD1BXizuGqvKA
 lXwDtCAaQuzhxSeVeIwyiA45t9iGTcNhzgmLq+eXVWX1M4e9H8pHbd280//Ay4e9U0fksjUE8Nb
 thJvJmwSOyZrJATXYtJZcZrnt3xP0aNSHe0f2GVF+BRcnMUwZHvlp7Scw14oww+B2hRTEAGnEAc
 yoaYhZEPb2eqtDG3JxuSsflGzS09se7mU4DtZqqEGzs6JMAcsKUXELghnTNHNWmuLEgkCvFtym5
 ibQBbhGHEEJhQalC0vdNoKGSU0qXY19UjGCEu6hnb0SYm5OlL65BGpgx2pC/tZvYonQ5Ccn8Rpj
 va6N5JqXxu6TNemhoR2JxHXqKDyvwu+t39XwOYU0wVD0xfWxdtLHTt717kd9FB5OjKrcvmIJyOh
 MinB+ecU29/xMFjJgzsoonjDjPEL/0pH4GXd5H3QyYKtkprrfPDy8Wau8Dv3QgDmmipwAGOqOLs
 ZtvvM59EEHOrY3+Va+CR1XQng3I05HX80sq5f83leeGevsu1P2c=
X-Received: by 2002:a05:6000:2d86:b0:47d:f508:3364 with SMTP id
 ffacd0b85a97d-47ff4ee359dmr6936934f8f.15.1786015484495; 
 Thu, 06 Aug 2026 04:24:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b250cfsm5524152f8f.28.2026.08.06.04.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:24:43 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:24:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 031918103f2e8e2063368d0e347a72ae8b95ea1c
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c7c8d1efb0ff2c498ff13d531b013b5e174e002-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrwDW-00024e-So
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6814668283506542256=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6814668283506542256==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iTJqSvkaIz8="; charset=UTF-8

--iTJqSvkaIz8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


Hello plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Pleas=
e visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail

to=
 look at the new patch set (#3)=2E

The following approvals got outdated an=
d were removed:
Code-Review+2 by ralf_lici


Change subject: dco: do not ex=
it the process when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: do not exit the process when instal=
ling a DCO key fails

When the DCO peer is gone from the kernel while users=
pace still believes
it exists, dco_new_key() fails with ENOENT and init_key=
_contexts() calls
msg(M_FATAL, =2E=2E=2E)=2E On a server this terminates th=
e whole daemon and
disconnects every other client, even though only a singl=
e peer is
affected=2E

Propagate the failure instead=2E Since a DCO desync =
needs a different
recovery than any other key generation error - the kernel=
 peer has to be
re-created, which only a reconnect can do - report it as a =
distinct
key_gen_status through generate_key_expansion() and
tls_session_ge=
nerate_data_channel_keys(), and let tls_multi_process()
turn it into a new =
TLSMP_RESTART result that check_tls() dispatches as a
SIGUSR1=2E On a serve=
r this restarts only the affected client instance=2E

The restart request i=
s tracked separately from 'active' because it must
not be overwritten by a =
later TLSMP_ACTIVE or TLSMP_RECONNECT
assignment, and the return value now =
applies an explicit precedence:
killing the session supersedes restarting i=
t, which supersedes 'active'=2E

tls_session_update_crypto_params_do_work()=
 collapses the desync back to
a plain failure, as all of its callers alread=
y turn a failure into a
SIGUSR1=2E

Note that commit ea3bb67e2b1e ("dco: ma=
ke key state desync recoverable")
does not cover this case, as both of its =
hunks are conditional on the
key installation having succeeded=2E

Github: =
fixes OpenVPN/openvpn#542
Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9=
fcd
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/op=
envpn/forward=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
3 files chang=
ed, 73 insertions(+), 22 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/35/1835/3

diff --git a/src/openvpn/forwa=
rd=2Ec b/src/openvpn/forward=2Ec
index 46e1a53=2E=2Ea0ddb0f 100644
--- a/sr=
c/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -206,6 +206,12 @@
  =
               register_signal(c->sig, SIGTERM, "auth-control-exit");
     =
        }
         }
+        else if (tmp_status =3D=3D TLSMP_RESTART)
+  =
      {
+            /* The session cannot recover on its own=2E Kill the c=
onnection so
+             * that it is set up again from scratch */
+     =
       register_signal(c->sig, SIGUSR1, "dco key state desync");
+        }=

 
         interval_future_trigger(&c->c2=2Etmp_int, wakeup);
     }
diff =
--git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ccd8264=2E=2E4a4fea=
f 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1373,7 +13=
73,22 @@
     secure_memzero(&e1_recv, sizeof(e1_recv));
 }
 
-static void
=
+/**
+ * Outcome of generating the data channel keys of a session=2E
+ *
+ =
* \c KEY_GEN_DCO_DESYNC is kept distinct from \c KEY_GEN_FAILED because it
=
+ * means userspace and kernel disagree about the DCO peer: the session can=
not
+ * recover on its own and the connection has to be restarted, while an=
y other
+ * failure only invalidates the affected key state=2E
+ */
+enum k=
ey_gen_status
+{
+    KEY_GEN_OK,         /**< keys were generated and inst=
alled */
+    KEY_GEN_FAILED,     /**< generation failed, invalidate the ke=
y state */
+    KEY_GEN_DCO_DESYNC, /**< the DCO peer is gone from the kern=
el */
+};
+
+static enum key_gen_status
 init_key_contexts(struct key_state=
 *ks, struct tls_multi *multi, const struct key_type *key_type,
           =
        bool server, struct key2 *key2, bool dco_enabled)
 {
@@ -1392,7 +14=
07,16 @@
         int ret =3D init_key_dco_bi(multi, ks, key2, key_directio=
n, key_type->cipher, server);
         if (ret < 0)
         {
-           =
 msg(M_FATAL, "Impossible to install key material in DCO: %s", strerror(-re=
t));
+            /* This normally means the DCO peer is gone from the kern=
el while
+             * userspace still believes it exists=2E Do not take =
the whole
+             * process down over a single peer: report the desyn=
c so that the
+             * connection is restarted and the peer re-creat=
ed from scratch */
+            msg(M_WARN,
+                "Impossible to=
 install key material in DCO: %s=2E The underlying "
+                "DCO =
peer may have been deleted from the kernel without "
+                "noti=
fying userspace=2E Restarting the session=2E",
+                strerror(-r=
et));
+            return KEY_GEN_DCO_DESYNC;
         }
 
         /* encr=
ypt/decrypt context are unused with DCO */
@@ -1415,6 +1439,8 @@
     {
   =
      init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
=
     }
+
+    return KEY_GEN_OK;
 }
 
 static bool
@@ -1475,11 +1501,11 @@
=
  * Using source entropy from local and remote hosts, mix into
  * master k=
ey=2E
  */
-static bool
+static enum key_gen_status
 generate_key_expansion=
(struct tls_multi *multi, struct key_state *ks, struct tls_session *session=
)
 {
     struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
-   =
 bool ret =3D false;
+    enum key_gen_status ret =3D KEY_GEN_FAILED;
     =
struct key2 key2;
 
     if (key->initialized)
@@ -1524,8 +1550,8 @@
      =
   }
     }
 
-    init_key_contexts(ks, multi, &session->opt->key_type, se=
rver, &key2, session->opt->dco_enabled);
-    ret =3D true;
+    ret =3D in=
it_key_contexts(ks, multi, &session->opt->key_type, server, &key2,
+       =
                     session->opt->dco_enabled);
 
 exit:
     secure_memze=
ro(&key2, sizeof(key2));
@@ -1539,10 +1565,10 @@
  * This erases the source=
 material used to generate the data channel keys, and
  * can thus be calle=
d only once per session=2E
  */
-bool
+static enum key_gen_status
 tls_sess=
ion_generate_data_channel_keys(struct tls_multi *multi, struct tls_session =
*session)
 {
-    bool ret =3D false;
+    enum key_gen_status ret =3D KEY_=
GEN_FAILED;
     struct key_state *ks =3D &session->key[KS_PRIMARY]; /* pri=
mary key */
 
     if (ks->authenticated <=3D KS_AUTH_FALSE)
@@ -1553,7 +15=
79,8 @@
 
     ks->crypto_options=2Eflags =3D session->opt->crypto_flags;
 =

-    if (!generate_key_expansion(multi, ks, session))
+    ret =3D generat=
e_key_expansion(multi, ks, session);
+    if (ret !=3D KEY_GEN_OK)
     {
 =
        msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
    =
     goto cleanup;
@@ -1565,7 +1592,6 @@
     /* set the state of the keys =
for the session to generated */
     ks->state =3D S_GENERATED_KEYS;
 
-   =
 ret =3D true;
 cleanup:
     secure_memzero(ks->key_src, sizeof(*ks->key_s=
rc));
     return ret;
@@ -1637,7 +1663,10 @@
             }
         }
   =
  }
-    return tls_session_generate_data_channel_keys(multi, session);
+  =
  /* A DCO desync is reported as a plain failure here: every caller of this=

+     * function already turns a failure into a SIGUSR1, which is exactly =
the
+     * recovery a desync needs */
+    return tls_session_generate_dat=
a_channel_keys(multi, session) =3D=3D KEY_GEN_OK;
 }
 
 bool
@@ -3232,6 +32=
61,9 @@
     struct gc_arena gc =3D gc_new();
     int active =3D TLSMP_INA=
CTIVE;
     bool error =3D false;
+    /* kept separate from 'active' on pu=
rpose: a restart request must not be
+     * overwritten by a later TLSMP_A=
CTIVE/TLSMP_RECONNECT assignment */
+    bool restart =3D false;
 
     tls=
_clear_error();
 
@@ -3334,12 +3366,22 @@
             /* Session is now fu=
lly authenticated=2E
              * tls_session_generate_data_channel_keys=
 will move ks->state
              * from S_ACTIVE to S_GENERATED_KEYS */
-=
            if (!tls_session_generate_data_channel_keys(multi, session))
+ =
           enum key_gen_status status =3D tls_session_generate_data_channel=
_keys(multi, session);
+            if (status !=3D KEY_GEN_OK)
           =
  {
                 msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion f=
ailed");
                 ks->authenticated =3D KS_AUTH_FALSE;
            =
     key_state_ssl_shutdown(&ks->ks_ssl);
                 ks->state =3D S_=
ERROR_PRE;
+
+                /* Invalidating the key state is not enough t=
o recover from a
+                 * DCO desync: the kernel peer has to be =
re-created, and the
+                 * key state we just invalidated will =
never be retried, so ask
+                 * for a restart right away */
+ =
               if (status =3D=3D KEY_GEN_DCO_DESYNC)
+                {
+  =
                  restart =3D true;
+                }
             }
 
   =
          /* Update auth token on the client if needed on renegotiation
@@ =
-3428,7 +3470,17 @@
 
     gc_free(&gc);
 
-    return (tas =3D=3D TLS_AUTH=
ENTICATION_FAILED) ? TLSMP_KILL : active;
+    /* strongest outcome wins: k=
illing the session supersedes restarting it,
+     * and restarting superse=
des whatever 'active' ended up being */
+    if (tas =3D=3D TLS_AUTHENTICAT=
ION_FAILED)
+    {
+        return TLSMP_KILL;
+    }
+    if (restart)
+  =
  {
+        return TLSMP_RESTART;
+    }
+    return active;
 }
 
 /**
dif=
f --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2E5483=
fbb 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -231,6 +2=
31,8 @@
 #define TLSMP_ACTIVE    1
 #define TLSMP_KILL      2
 #define TLSM=
P_RECONNECT 3
+/** the session cannot recover on its own and has to be rest=
arted */
+#define TLSMP_RESTART   4
 
 /*
  * Called by the top-level event=
 loop=2E
@@ -554,15 +556,6 @@
 void show_available_tls_ciphers(const char *=
cipher_list, const char *cipher_list_tls13,
                               =
  const char *tls_cert_profile);
 
-
-/**
- * Generate data channel keys fo=
r the supplied TLS session=2E
- *
- * This erases the source material used =
to generate the data channel keys, and
- * can thus be called only once per=
 session=2E
- */
-bool tls_session_generate_data_channel_keys(struct tls_mu=
lti *multi, struct tls_session *session);
-
 void tls_session_soft_reset(st=
ruct tls_multi *multi);
 
 /**

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Gerrit-Change-Numb=
er: 1835
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ral=
f_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mande=
lbit=2Ecom>

--iTJqSvkaIz8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p>ordex <=
strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></=
p><p>The following approvals got outdated and were removed:
Code-Review+2 b=
y ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco: do not exit the process when installing a=
 DCO key fails<br><br>When the DCO peer is gone from the kernel while users=
pace still believes<br>it exists, dco_new_key() fails with ENOENT and init_=
key_contexts() calls<br>msg(M_FATAL, =2E=2E=2E)=2E On a server this termina=
tes the whole daemon and<br>disconnects every other client, even though onl=
y a single peer is<br>affected=2E<br><br>Propagate the failure instead=2E S=
ince a DCO desync needs a different<br>recovery than any other key generati=
on error - the kernel peer has to be<br>re-created, which only a reconnect =
can do - report it as a distinct<br>key_gen_status through generate_key_exp=
ansion() and<br>tls_session_generate_data_channel_keys(), and let tls_multi=
_process()<br>turn it into a new TLSMP_RESTART result that check_tls() disp=
atches as a<br>SIGUSR1=2E On a server this restarts only the affected clien=
t instance=2E<br><br>The restart request is tracked separately from &#39;ac=
tive&#39; because it must<br>not be overwritten by a later TLSMP_ACTIVE or =
TLSMP_RECONNECT<br>assignment, and the return value now applies an explicit=
 precedence:<br>killing the session supersedes restarting it, which superse=
des &#39;active&#39;=2E<br><br>tls_session_update_crypto_params_do_work() c=
ollapses the desync back to<br>a plain failure, as all of its callers alrea=
dy turn a failure into a<br>SIGUSR1=2E<br><br>Note that commit ea3bb67e2b1e=
 (&quot;dco: make key state desync recoverable&quot;)<br>does not cover thi=
s case, as both of its hunks are conditional on the<br>key installation hav=
ing succeeded=2E<br><br>Github: fixes OpenVPN/openvpn#542<br>Change-Id: I56=
4edc6e0cc179c2b8b5ddef5e80838949fe9fcd<br>Signed-off-by: Antonio Quartulli =
&lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M sr=
c/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>3 files changed, 73 insertion=
s(+), 22 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/35/1835/3</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 46e1a53=
=2E=2Ea0ddb0f 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -206,6 +206,12 @@<=
/span><br><span>                 register_signal(c-&gt;sig, SIGTERM, &quot;=
auth-control-exit&quot;);</span><br><span>             }</span><br><span>  =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e if (tmp_status =3D=3D TLSMP_RESTART)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* The session cannot recover on its own=2E Kill the c=
onnection so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      * that it is set up again from scratch */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            register_signal(c-&gt;sig, SIGUSR1,=
 &quot;dco key state desync&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span> </span><br><span>         interv=
al_future_trigger(&amp;c-&gt;c2=2Etmp_int, wakeup);</span><br><span>     }<=
/span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</spa=
n><br><span>index ccd8264=2E=2E4a4feaf 100644</span><br><span>--- a/src/ope=
nvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -=
1373,7 +1373,22 @@</span><br><span>     secure_memzero(&amp;e1_recv, sizeof=
(e1_recv));</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Outcome of generating the data channel keys of a session=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * \c KEY_GEN_DCO_DESYNC is kept distinct from=
 \c KEY_GEN_FAILED because it</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * means userspace and kernel disagree about the DCO peer: the se=
ssion cannot</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reco=
ver on its own and the connection has to be restarted, while any other</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * failure only invalida=
tes the affected key state=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum k=
ey_gen_status</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    KEY_GEN_OK,         =
/**&lt; keys were generated and installed */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    KEY_GEN_FAILED,     /**&lt; generation failed,=
 invalidate the key state */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    KEY_GEN_DCO_DESYNC, /**&lt; the DCO peer is gone from the kern=
el */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static enum key_gen_status</span><br><span> init_k=
ey_contexts(struct key_state *ks, struct tls_multi *multi, const struct key=
_type *key_type,</span><br><span>                   bool server, struct key=
2 *key2, bool dco_enabled)</span><br><span> {</span><br><span>@@ -1392,7 +1=
407,16 @@</span><br><span>         int ret =3D init_key_dco_bi(multi, ks, k=
ey2, key_direction, key_type-&gt;cipher, server);</span><br><span>         =
if (ret &lt; 0)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;Impossible to install k=
ey material in DCO: %s&quot;, strerror(-ret));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* This normally means the DCO peer =
is gone from the kernel while</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             * userspace still believes it exists=2E Do not take =
the whole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   * process down over a single peer: report the desync so that the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             * connection i=
s restarted and the peer re-created from scratch */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;Impossible to i=
nstall key material in DCO: %s=2E The underlying &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                &quot;DCO peer may have=
 been deleted from the kernel without &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                &quot;notifying userspace=2E Resta=
rting the session=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                strerror(-ret));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return KEY_GEN_DCO_DESYNC;</span><br><span=
>         }</span><br><span> </span><br><span>         /* encrypt/decrypt c=
ontext are unused with DCO */</span><br><span>@@ -1415,6 +1439,8 @@</span><=
br><span>     {</span><br><span>         init_key_ctx_bi(key, key2, key_dir=
ection, key_type, &quot;Data Channel&quot;);</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return KEY_GEN_OK;</span><br><span> }</spa=
n><br><span> </span><br><span> static bool</span><br><span>@@ -1475,11 +150=
1,11 @@</span><br><span>  * Using source entropy from local and remote host=
s, mix into</span><br><span>  * master key=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static enum key_gen_status</span><br><=
span> generate_key_expansion(struct tls_multi *multi, struct key_state *ks,=
 struct tls_session *session)</span><br><span> {</span><br><span>     struc=
t key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    enum key_gen_status ret =
=3D KEY_GEN_FAILED;</span><br><span>     struct key2 key2;</span><br><span>=
 </span><br><span>     if (key-&gt;initialized)</span><br><span>@@ -1524,8 =
+1550,8 @@</span><br><span>         }</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_conte=
xts(ks, multi, &amp;session-&gt;opt-&gt;key_type, server, &amp;key2, sessio=
n-&gt;opt-&gt;dco_enabled);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ret =3D init_key_contexts(ks, multi, &amp;session-&gt;opt-&gt;key_t=
ype, server, &amp;key2,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            session-&gt;opt-&gt;dco_enabled);</span><br=
><span> </span><br><span> exit:</span><br><span>     secure_memzero(&amp;ke=
y2, sizeof(key2));</span><br><span>@@ -1539,10 +1565,10 @@</span><br><span>=
  * This erases the source material used to generate the data channel keys,=
 and</span><br><span>  * can thus be called only once per session=2E</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum key_gen_st=
atus</span><br><span> tls_session_generate_data_channel_keys(struct tls_mul=
ti *multi, struct tls_session *session)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    enum key_gen_status ret =3D KE=
Y_GEN_FAILED;</span><br><span>     struct key_state *ks =3D &amp;session-&g=
t;key[KS_PRIMARY]; /* primary key */</span><br><span> </span><br><span>    =
 if (ks-&gt;authenticated &lt;=3D KS_AUTH_FALSE)</span><br><span>@@ -1553,7=
 +1579,8 @@</span><br><span> </span><br><span>     ks-&gt;crypto_options=2E=
flags =3D session-&gt;opt-&gt;crypto_flags;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!generate_key_expansion(mul=
ti, ks, session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ret =3D generate_key_expansion(multi, ks, session);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret !=3D KEY_GEN_OK)</span><br><s=
pan>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS Error: gene=
rate_key_expansion failed&quot;);</span><br><span>         goto cleanup;</s=
pan><br><span>@@ -1565,7 +1592,6 @@</span><br><span>     /* set the state o=
f the keys for the session to generated */</span><br><span>     ks-&gt;stat=
e =3D S_GENERATED_KEYS;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ret =3D true;</span><br><span> cleanup:</span><br><=
span>     secure_memzero(ks-&gt;key_src, sizeof(*ks-&gt;key_src));</span><b=
r><span>     return ret;</span><br><span>@@ -1637,7 +1663,10 @@</span><br><=
span>             }</span><br><span>         }</span><br><span>     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return tls_session_gene=
rate_data_channel_keys(multi, session);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* A DCO desync is reported as a plain failure here=
: every caller of this</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * function already turns a failure into a SIGUSR1, which is exactly=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * recovery=
 a desync needs */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return tls_session_generate_data_channel_keys(multi, session) =3D=3D KEY=
_GEN_OK;</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span>@@ -3232,6 +3261,9 @@</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     int active =3D TLSMP_INACTIVE;</span><br><sp=
an>     bool error =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* kept separate from &#39;active&#39; on purpose: a restart =
request must not be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * overwritten by a later TLSMP_ACTIVE/TLSMP_RECONNECT assignment */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool restart =3D f=
alse;</span><br><span> </span><br><span>     tls_clear_error();</span><br><=
span> </span><br><span>@@ -3334,12 +3366,22 @@</span><br><span>            =
 /* Session is now fully authenticated=2E</span><br><span>              * t=
ls_session_generate_data_channel_keys will move ks-&gt;state</span><br><spa=
n>              * from S_ACTIVE to S_GENERATED_KEYS */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (!tls_session_generate_data=
_channel_keys(multi, session))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            enum key_gen_status status =3D tls_session_generate_=
data_channel_keys(multi, session);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (status !=3D KEY_GEN_OK)</span><br><span>    =
         {</span><br><span>                 msg(D_TLS_ERRORS, &quot;TLS Err=
or: generate_key_expansion failed&quot;);</span><br><span>                 =
ks-&gt;authenticated =3D KS_AUTH_FALSE;</span><br><span>                 ke=
y_state_ssl_shutdown(&amp;ks-&gt;ks_ssl);</span><br><span>                 =
ks-&gt;state =3D S_ERROR_PRE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       /* Invalidating the key state is not enough to recover from a</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 * DCO des=
ync: the kernel peer has to be re-created, and the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 * key state we just invalid=
ated will never be retried, so ask</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                 * for a restart right away */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if (status =3D=3D=
 KEY_GEN_DCO_DESYNC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   restart =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span>             }</span><br=
><span> </span><br><span>             /* Update auth token on the client if=
 needed on renegotiation</span><br><span>@@ -3428,7 +3470,17 @@</span><br><=
span> </span><br><span>     gc_free(&amp;gc);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return (tas =3D=3D TLS_AUTHEN=
TICATION_FAILED) ? TLSMP_KILL : active;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* strongest outcome wins: killing the session supe=
rsedes restarting it,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * and restarting supersedes whatever &#39;active&#39; ended up being=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tas =3D=
=3D TLS_AUTHENTICATION_FAILED)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return TLSMP_KILL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (re=
start)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return TLSMP_RESTAR=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return active;</span><br><s=
pan> }</span><br><span> </span><br><span> /**</span><br><span>diff --git a/=
src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=
=2E5483fbb 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span=
>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -231,6 +231,8 @@</span><br><s=
pan> #define TLSMP_ACTIVE    1</span><br><span> #define TLSMP_KILL      2</=
span><br><span> #define TLSMP_RECONNECT 3</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** the session cannot recover on its own and has to =
be restarted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine TLSMP_RESTART   4</span><br><span> </span><br><span> /*</span><br><span=
>  * Called by the top-level event loop=2E</span><br><span>@@ -554,15 +556,=
6 @@</span><br><span> void show_available_tls_ciphers(const char *cipher_li=
st, const char *cipher_list_tls13,</span><br><span>                        =
         const char *tls_cert_profile);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
Generate data channel keys for the supplied TLS session=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * This erases the source material used to generate the d=
ata channel keys, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * can thus be called only once per session=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-bool tls_session_generate_data_channel_keys(struct tls_multi *multi,=
 struct tls_session *session);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void tls_session_soft_reset(struct tls_multi *mu=
lti);</span><br><span> </span><br><span> /**</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
835?usp=3Demail">change 1835</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1835?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1835 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></=
html>
--iTJqSvkaIz8=--


--===============6814668283506542256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6814668283506542256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6814668283506542256==--

