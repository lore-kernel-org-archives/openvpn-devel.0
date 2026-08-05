Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40F0C56203
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqavaNeXyqK31xWqsaiBJ9SvdTQqbzDpZO+QYbiV0yM=; b=FBmFtU+8th9CsjsQLpsPjwH9il
	MbQgoIt2y2XeX61C+ktUExKRVYbF8W4FQi1CCJnafTYzLZaHLukzAIx7B43aF2G+xUa44QfEttHeR
	CErJgYetsJE84Z1BgTlQOJS8yxJYQlHo895j7WQfc2LuBCQJ83uXzVUVm0f7pbjDvSsg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrZRb-000775-S4;
	Wed, 05 Aug 2026 11:05:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrZRb-00076z-CI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:05:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7CXa+OJYWoVvOo3htolRohzeY72G5SrFV5LG1M/x0ic=; b=k2+eHRMxSAEJk5gEkkg5v2wABP
 XSNfTDV6NrdOfcRi7oqCdAxh+J/7gzViwLWxZvuu8SYnUKegqZpCUFasDD3Bi9WPuYL3w87YXXrU9
 5PCiNQxU5dA8PH1tIt4iggG7dO+vvVPONN/KWPYhzwHDtdKdVI4bbsHbYyBByXgg1WY8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7CXa+OJYWoVvOo3htolRohzeY72G5SrFV5LG1M/x0ic=; b=I
 6h69mkNFy2oWaKTXUQfH2qnuvruOfURvHGgjtNkcuJCF/hgp7eAz52Xwr06TwMDc7QV99Bi8x/BbT
 yYRGFgzruFmBUQG+9cOv/YyMFGu+oA0tWQadhZ2hepl5tOOnU4ej3UrTXcjSl89sxabZ54CXHCcC6
 /wccKRN7KXcBLMfw=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrZRc-00044S-Rw for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:05:55 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so6734315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785927946; x=1786532746; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7CXa+OJYWoVvOo3htolRohzeY72G5SrFV5LG1M/x0ic=;
 b=J0dxVF/W2tZREN47gswNm6UDt5fGKEnx5pyGfimsCeah9h+3fEV+IQyJrJSD2cQDVR
 s3VgflGkUYN7h6oXpYbrE//TAnbOe7ev6wVhSvg3uid+72Y1YaIG6l1sdUww0/w9Qvwn
 DasABQsiw+GjcDk/4Ipb8gUY4xtwCMRVbUvGhPYO8xNsUX9K/YyH5hBG9l9xV85geqeg
 KHfcrx9GZuhEt5ZdMT75Y3+94ppIcVmXkSlcM3fFrcjCw3S1bD48yBYRFOlQD50iGjLX
 hkN9+rufoHow5hRPh1S8Wsb9VUpOocM/NzdHznOLK7kl8MfZIizugZrYWG2PVdjb9XhS
 i90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785927946; x=1786532746;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7CXa+OJYWoVvOo3htolRohzeY72G5SrFV5LG1M/x0ic=;
 b=qOEFGVVh6/5KWQVubJey6lsCHN3buMMxRBRDt8H9QCsf0A0tqpIkexT18HZKJ+FPuB
 Hco7ZftFxMj2+p4FAcZYhdnyzEylKeGoQSheQmQodJ3wT9nnk+h7yqT1KQ9VJh6UlYUq
 lEmYkJt+bxDaTh0qX4dSrHFuS+iKP8+obqYi73tjo/p9OnRhEprFpSVvwmiSPt7miojb
 HuRjnBRnQfYxOtNswvs7FIWEe+vMtT83rzgkRbJEshb734Jl8eAmif1F8L16tKToDJka
 aKnk2wnb2YM6myWQ00iQhm5d6zB1pXMaFkANuoV4v8Rc/S3XQl35TK9UM5ocpWTbS0AH
 opMg==
X-Gm-Message-State: AOJu0Yz4G6TEIelNl5sA2y/MlykL0XAXsma4aBmX1D5h+iVBSaoFl5Ou
 lxDcfv1ST+UZ5KMfrPQ4iys8dDl+Seppw4diDTjG7lhwTk/kECsv0AFEPIjm1lBtvzirkn64BiT
 B8C0ltl88851rNVlxBo6HVOBPosAv7c4SsMy7+fRyCY0Qc24uhC3T6R/vcvk0ANNpMXBy
X-Gm-Gg: AR+sD12dDFiXoczTp2wiY/Xx0lqWjiNmyQ15J4r4ZmK2htUqVNsfg0AkwPxA0c35HOv
 wS/IoAuH1HVEhmcmvJX3xDWJV9z3XOQPpGZd2Bkqn6GTTMtbJK0KSPHsjOkxxN8+lmMEunUU8ZD
 wGh22ZvtOSUuRcr2RcVe1OiHQSmaB9dX+u0U+aqLr5h37ngCxMVX2HBWZanIh9/+stgN41j55Kx
 NRsEXuuijqBE9A9F5JzMKOvDdyYU7VOVt7MCOUy4GcjDshRPmZ4L99kChgVmySvTNyUDBTCpnut
 5K9Q2LtPS0nKBkZiIgeJFjjaK8Npc3DJTNV7Mknm0MQ5VX2gAQJNpIKoAjWM7x5sPqRARkEjj6p
 AkWxkEbuV1S2g5Pn4NSdgK3rUfWVe5uoRXCAQL+N+dV/RXXWD3twXHNKDqRmD3E+1IjdgsTCE2T
 k+VPgBV9ZZIPfTHvmPZrB0P1mGm71j2+ruLxHrUb49Sh/wCiuaK4soPfePxn2eXRijiDxGAKeDq
 iC0dfBz5CpG6ez8xMAHam6VGmaA/8A2r/TZQE9KHljapoBkfDjKFLCSXFeTER6zFZ1Z+1SDh6hT
 gWX1zSjei4VyJg0Cb8N/GEJ+PByQEVQHUGmOjt8qXTPWDm8EHCU=
X-Received: by 2002:a05:600c:c8c:b0:496:c18c:f9a3 with SMTP id
 5b1f17b1804b1-4994e79dc76mr56483745e9.5.1785927946241; 
 Wed, 05 Aug 2026 04:05:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994dfda556sm91838355e9.5.2026.08.05.04.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:05:45 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 11:05:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 673e321220a104f42914bd04adb1968a7b2d9112
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe4e02df0c2d1316cf98ec775f089bbc9cb5539f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrZRc-00044S-Rw
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2120398813355333458=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2120398813355333458==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ynT2uzAhj/Q="; charset=UTF-8

--ynT2uzAhj/Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1835?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: dco: do not exit the process when installing a DCO =
key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
co: do not exit the process when installing a DCO key fails

When the DCO p=
eer is gone from the kernel while userspace still believes
it exists, dco_n=
ew_key() fails with ENOENT and init_key_contexts() calls
msg(M_FATAL, =2E=
=2E=2E)=2E On a server this terminates the whole daemon and
disconnects eve=
ry other client, even though only a single peer is
affected=2E

Propagate t=
he failure instead=2E Since a DCO desync needs a different
recovery than an=
y other key generation error - the kernel peer has to be
re-created, which =
only a reconnect can do - report it as a distinct
key_gen_status through ge=
nerate_key_expansion() and
tls_session_generate_data_channel_keys(), and le=
t tls_multi_process()
turn it into a new TLSMP_RESTART result that check_tl=
s() dispatches as a
SIGUSR1=2E On a server this restarts only the affected =
client instance=2E

The restart request is tracked separately from 'active'=
 because it must
not be overwritten by a later TLSMP_ACTIVE or TLSMP_RECONN=
ECT
assignment, and the return value now applies an explicit precedence:
ki=
lling the session supersedes restarting it, which supersedes 'active'=2E

t=
ls_session_update_crypto_params_do_work() collapses the desync back to
a pl=
ain failure, as all of its callers already turn a failure into a
SIGUSR1=2E=


Note that commit ea3bb67e2b1e ("dco: make key state desync recoverable")
=
does not cover this case, as both of its hunks are conditional on the
key i=
nstallation having succeeded=2E

Github: fixes OpenVPN/openvpn#542
Change-I=
d: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Signed-off-by: Antonio Quartul=
li <antonio@mandelbit=2Ecom>
---
M src/openvpn/forward=2Ec
M src/openvpn/ss=
l=2Ec
M src/openvpn/ssl=2Eh
M src/openvpn/ssl_common=2Eh
4 files changed, 7=
5 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/35/1835/2

diff --git a/src/openvpn/forward=2Ec =
b/src/openvpn/forward=2Ec
index 46e1a53=2E=2Ea0ddb0f 100644
--- a/src/openv=
pn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -206,6 +206,12 @@
         =
        register_signal(c->sig, SIGTERM, "auth-control-exit");
            =
 }
         }
+        else if (tmp_status =3D=3D TLSMP_RESTART)
+        {=

+            /* The session cannot recover on its own=2E Kill the connecti=
on so
+             * that it is set up again from scratch */
+            =
register_signal(c->sig, SIGUSR1, "dco key state desync");
+        }
 
    =
     interval_future_trigger(&c->c2=2Etmp_int, wakeup);
     }
diff --git a=
/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ccd8264=2E=2Eb5ab51e 10064=
4
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1373,7 +1373,7 @@=

     secure_memzero(&e1_recv, sizeof(e1_recv));
 }
 
-static void
+static =
enum key_gen_status
 init_key_contexts(struct key_state *ks, struct tls_mul=
ti *multi, const struct key_type *key_type,
                   bool server,=
 struct key2 *key2, bool dco_enabled)
 {
@@ -1392,7 +1392,16 @@
         in=
t ret =3D init_key_dco_bi(multi, ks, key2, key_direction, key_type->cipher,=
 server);
         if (ret < 0)
         {
-            msg(M_FATAL, "Impos=
sible to install key material in DCO: %s", strerror(-ret));
+            /*=
 This normally means the DCO peer is gone from the kernel while
+          =
   * userspace still believes it exists=2E Do not take the whole
+         =
    * process down over a single peer: report the desync so that the
+     =
        * connection is restarted and the peer re-created from scratch */
+=
            msg(M_WARN,
+                "Impossible to install key materia=
l in DCO: %s=2E The underlying "
+                "DCO peer may have been d=
eleted from the kernel without "
+                "notifying userspace=2E R=
estarting the session",
+                strerror(-ret));
+            retu=
rn KEY_GEN_DCO_DESYNC;
         }
 
         /* encrypt/decrypt context are=
 unused with DCO */
@@ -1415,6 +1424,8 @@
     {
         init_key_ctx_bi(k=
ey, key2, key_direction, key_type, "Data Channel");
     }
+
+    return KE=
Y_GEN_OK;
 }
 
 static bool
@@ -1475,11 +1486,11 @@
  * Using source entrop=
y from local and remote hosts, mix into
  * master key=2E
  */
-static bool=

+static enum key_gen_status
 generate_key_expansion(struct tls_multi *mult=
i, struct key_state *ks, struct tls_session *session)
 {
     struct key_ct=
x_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
-    bool ret =3D false;
+ =
   enum key_gen_status ret =3D KEY_GEN_FAILED;
     struct key2 key2;
 
   =
  if (key->initialized)
@@ -1524,8 +1535,8 @@
         }
     }
 
-    init=
_key_contexts(ks, multi, &session->opt->key_type, server, &key2, session->o=
pt->dco_enabled);
-    ret =3D true;
+    ret =3D init_key_contexts(ks, mul=
ti, &session->opt->key_type, server, &key2,
+                            se=
ssion->opt->dco_enabled);
 
 exit:
     secure_memzero(&key2, sizeof(key2))=
;
@@ -1539,10 +1550,10 @@
  * This erases the source material used to gener=
ate the data channel keys, and
  * can thus be called only once per session=
=2E
  */
-bool
+enum key_gen_status
 tls_session_generate_data_channel_keys=
(struct tls_multi *multi, struct tls_session *session)
 {
-    bool ret =3D=
 false;
+    enum key_gen_status ret =3D KEY_GEN_FAILED;
     struct key_st=
ate *ks =3D &session->key[KS_PRIMARY]; /* primary key */
 
     if (ks->aut=
henticated <=3D KS_AUTH_FALSE)
@@ -1553,7 +1564,8 @@
 
     ks->crypto_opti=
ons=2Eflags =3D session->opt->crypto_flags;
 
-    if (!generate_key_expans=
ion(multi, ks, session))
+    ret =3D generate_key_expansion(multi, ks, ses=
sion);
+    if (ret !=3D KEY_GEN_OK)
     {
         msg(D_TLS_ERRORS, "TLS=
 Error: generate_key_expansion failed");
         goto cleanup;
@@ -1565,7 =
+1577,6 @@
     /* set the state of the keys for the session to generated *=
/
     ks->state =3D S_GENERATED_KEYS;
 
-    ret =3D true;
 cleanup:
     =
secure_memzero(ks->key_src, sizeof(*ks->key_src));
     return ret;
@@ -163=
7,7 +1648,10 @@
             }
         }
     }
-    return tls_session_ge=
nerate_data_channel_keys(multi, session);
+    /* A DCO desync is reported =
as a plain failure here: every caller of this
+     * function already turn=
s a failure into a SIGUSR1, which is exactly the
+     * recovery a desync =
needs */
+    return tls_session_generate_data_channel_keys(multi, session)=
 =3D=3D KEY_GEN_OK;
 }
 
 bool
@@ -3232,6 +3246,9 @@
     struct gc_arena g=
c =3D gc_new();
     int active =3D TLSMP_INACTIVE;
     bool error =3D fal=
se;
+    /* kept separate from 'active' on purpose: a restart request must =
not be
+     * overwritten by a later TLSMP_ACTIVE/TLSMP_RECONNECT assignme=
nt */
+    bool restart =3D false;
 
     tls_clear_error();
 
@@ -3334,12 =
+3351,22 @@
             /* Session is now fully authenticated=2E
         =
     * tls_session_generate_data_channel_keys will move ks->state
         =
     * from S_ACTIVE to S_GENERATED_KEYS */
-            if (!tls_session_g=
enerate_data_channel_keys(multi, session))
+            enum key_gen_status=
 status =3D tls_session_generate_data_channel_keys(multi, session);
+      =
      if (status !=3D KEY_GEN_OK)
             {
                 msg(D_TLS=
_ERRORS, "TLS Error: generate_key_expansion failed");
                 ks->=
authenticated =3D KS_AUTH_FALSE;
                 key_state_ssl_shutdown(&k=
s->ks_ssl);
                 ks->state =3D S_ERROR_PRE;
+
+                =
/* Invalidating the key state is not enough to recover from a
+            =
     * DCO desync: the kernel peer has to be re-created, and the
+         =
        * key state we just invalidated will never be retried, so ask
+    =
             * for a restart right away */
+                if (status =3D=
=3D KEY_GEN_DCO_DESYNC)
+                {
+                    restart =3D=
 true;
+                }
             }
 
             /* Update auth toke=
n on the client if needed on renegotiation
@@ -3428,7 +3455,17 @@
 
     gc=
_free(&gc);
 
-    return (tas =3D=3D TLS_AUTHENTICATION_FAILED) ? TLSMP_KI=
LL : active;
+    /* strongest outcome wins: killing the session supersedes=
 restarting it,
+     * and restarting supersedes whatever 'active' ended u=
p being */
+    if (tas =3D=3D TLS_AUTHENTICATION_FAILED)
+    {
+        r=
eturn TLSMP_KILL;
+    }
+    if (restart)
+    {
+        return TLSMP_RES=
TART;
+    }
+    return active;
 }
 
 /**
diff --git a/src/openvpn/ssl=2Eh=
 b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2E9d614aa 100644
--- a/src/openvpn/=
ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -231,6 +231,8 @@
 #define TLSMP_ACTIVE=
    1
 #define TLSMP_KILL      2
 #define TLSMP_RECONNECT 3
+/** the sessio=
n cannot recover on its own and has to be restarted */
+#define TLSMP_RESTA=
RT   4
 
 /*
  * Called by the top-level event loop=2E
@@ -561,7 +563,8 @@
=
  * This erases the source material used to generate the data channel keys,=
 and
  * can thus be called only once per session=2E
  */
-bool tls_session=
_generate_data_channel_keys(struct tls_multi *multi, struct tls_session *se=
ssion);
+enum key_gen_status tls_session_generate_data_channel_keys(struct =
tls_multi *multi,
+                                                        =
   struct tls_session *session);
 
 void tls_session_soft_reset(struct tls_=
multi *multi);
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_=
common=2Eh
index 9c90242=2E=2E6db304d 100644
--- a/src/openvpn/ssl_common=
=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -187,6 +187,21 @@
 };
 
 /**
+ * O=
utcome of generating the data channel keys of a session=2E
+ *
+ * \c KEY_G=
EN_DCO_DESYNC is kept distinct from \c KEY_GEN_FAILED because it
+ * means =
userspace and kernel disagree about the DCO peer: the session cannot
+ * re=
cover on its own and the connection has to be restarted, while any other
+ =
* failure only invalidates the affected key state=2E
+ */
+enum key_gen_sta=
tus
+{
+    KEY_GEN_OK,         /**< keys were generated and installed */
+=
    KEY_GEN_FAILED,     /**< generation failed, invalidate the key state */=

+    KEY_GEN_DCO_DESYNC, /**< the DCO peer is gone from the kernel */
+};
=
+
+/**
  * Security parameter state of one TLS and data channel %key sessio=
n=2E
  * @ingroup control_processor
  *

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Gerrit-C=
hange-Number: 1835
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbi=
t=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ralf_li=
ci <ralf@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>

--ynT2uzAhj/Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>ordex <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o: do not exit the process when installing a DCO key fails<br><br>When the =
DCO peer is gone from the kernel while userspace still believes<br>it exist=
s, dco_new_key() fails with ENOENT and init_key_contexts() calls<br>msg(M_F=
ATAL, =2E=2E=2E)=2E On a server this terminates the whole daemon and<br>dis=
connects every other client, even though only a single peer is<br>affected=
=2E<br><br>Propagate the failure instead=2E Since a DCO desync needs a diff=
erent<br>recovery than any other key generation error - the kernel peer has=
 to be<br>re-created, which only a reconnect can do - report it as a distin=
ct<br>key_gen_status through generate_key_expansion() and<br>tls_session_ge=
nerate_data_channel_keys(), and let tls_multi_process()<br>turn it into a n=
ew TLSMP_RESTART result that check_tls() dispatches as a<br>SIGUSR1=2E On a=
 server this restarts only the affected client instance=2E<br><br>The resta=
rt request is tracked separately from &#39;active&#39; because it must<br>n=
ot be overwritten by a later TLSMP_ACTIVE or TLSMP_RECONNECT<br>assignment,=
 and the return value now applies an explicit precedence:<br>killing the se=
ssion supersedes restarting it, which supersedes &#39;active&#39;=2E<br><br=
>tls_session_update_crypto_params_do_work() collapses the desync back to<br=
>a plain failure, as all of its callers already turn a failure into a<br>SI=
GUSR1=2E<br><br>Note that commit ea3bb67e2b1e (&quot;dco: make key state de=
sync recoverable&quot;)<br>does not cover this case, as both of its hunks a=
re conditional on the<br>key installation having succeeded=2E<br><br>Github=
: fixes OpenVPN/openvpn#542<br>Change-Id: I564edc6e0cc179c2b8b5ddef5e808389=
49fe9fcd<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/ope=
nvpn/ssl=2Eh<br>M src/openvpn/ssl_common=2Eh<br>4 files changed, 75 inserti=
ons(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/35/1835/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 46e1a5=
3=2E=2Ea0ddb0f 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><=
br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -206,6 +206,12 @@=
</span><br><span>                 register_signal(c-&gt;sig, SIGTERM, &quot=
;auth-control-exit&quot;);</span><br><span>             }</span><br><span> =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se if (tmp_status =3D=3D TLSMP_RESTART)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            /* The session cannot recover on its own=2E Kill the =
connection so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       * that it is set up again from scratch */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            register_signal(c-&gt;sig, SIGUSR1=
, &quot;dco key state desync&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span> </span><br><span>         inter=
val_future_trigger(&amp;c-&gt;c2=2Etmp_int, wakeup);</span><br><span>     }=
</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</sp=
an><br><span>index ccd8264=2E=2Eb5ab51e 100644</span><br><span>--- a/src/op=
envpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ =
-1373,7 +1373,7 @@</span><br><span>     secure_memzero(&amp;e1_recv, sizeof=
(e1_recv));</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static enum key_gen_status</span><br><span> init_key_con=
texts(struct key_state *ks, struct tls_multi *multi, const struct key_type =
*key_type,</span><br><span>                   bool server, struct key2 *key=
2, bool dco_enabled)</span><br><span> {</span><br><span>@@ -1392,7 +1392,16=
 @@</span><br><span>         int ret =3D init_key_dco_bi(multi, ks, key2, k=
ey_direction, key_type-&gt;cipher, server);</span><br><span>         if (re=
t &lt; 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_FATAL, &quot;Impossible to install key mat=
erial in DCO: %s&quot;, strerror(-ret));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* This normally means the DCO peer is gon=
e from the kernel while</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             * userspace still believes it exists=2E Do not take the wh=
ole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * p=
rocess down over a single peer: report the desync so that the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * connection is rest=
arted and the peer re-created from scratch */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(M_WARN,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                &quot;Impossible to install k=
ey material in DCO: %s=2E The underlying &quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                &quot;DCO peer may have been de=
leted from the kernel without &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                &quot;notifying userspace=2E Restarting th=
e session&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             strerror(-ret));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return KEY_GEN_DCO_DESYNC;</span><br><span>         }=
</span><br><span> </span><br><span>         /* encrypt/decrypt context are =
unused with DCO */</span><br><span>@@ -1415,6 +1424,8 @@</span><br><span>  =
   {</span><br><span>         init_key_ctx_bi(key, key2, key_direction, key=
_type, &quot;Data Channel&quot;);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return KEY_GEN_OK;</span><br><span> }</span><br><span=
> </span><br><span> static bool</span><br><span>@@ -1475,11 +1486,11 @@</sp=
an><br><span>  * Using source entropy from local and remote hosts, mix into=
</span><br><span>  * master key=2E</span><br><span>  */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static enum key_gen_status</span><br><span> gener=
ate_key_expansion(struct tls_multi *multi, struct key_state *ks, struct tls=
_session *session)</span><br><span> {</span><br><span>     struct key_ctx_b=
i *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    enum key_gen_status ret =3D KEY_GEN=
_FAILED;</span><br><span>     struct key2 key2;</span><br><span> </span><br=
><span>     if (key-&gt;initialized)</span><br><span>@@ -1524,8 +1535,8 @@<=
/span><br><span>         }</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_contexts(ks, mul=
ti, &amp;session-&gt;opt-&gt;key_type, server, &amp;key2, session-&gt;opt-&=
gt;dco_enabled);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
et =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
 =3D init_key_contexts(ks, multi, &amp;session-&gt;opt-&gt;key_type, server=
, &amp;key2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                     session-&gt;opt-&gt;dco_enabled);</span><br><span> </s=
pan><br><span> exit:</span><br><span>     secure_memzero(&amp;key2, sizeof(=
key2));</span><br><span>@@ -1539,10 +1550,10 @@</span><br><span>  * This er=
ases the source material used to generate the data channel keys, and</span>=
<br><span>  * can thus be called only once per session=2E</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+enum key_gen_status</span><br><sp=
an> tls_session_generate_data_channel_keys(struct tls_multi *multi, struct =
tls_session *session)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    enum key_gen_status ret =3D KEY_GEN_FAILED;</spa=
n><br><span>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];=
 /* primary key */</span><br><span> </span><br><span>     if (ks-&gt;authen=
ticated &lt;=3D KS_AUTH_FALSE)</span><br><span>@@ -1553,7 +1564,8 @@</span>=
<br><span> </span><br><span>     ks-&gt;crypto_options=2Eflags =3D session-=
&gt;opt-&gt;crypto_flags;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!generate_key_expansion(multi, ks, session))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D generate=
_key_expansion(multi, ks, session);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (ret !=3D KEY_GEN_OK)</span><br><span>     {</span><=
br><span>         msg(D_TLS_ERRORS, &quot;TLS Error: generate_key_expansion=
 failed&quot;);</span><br><span>         goto cleanup;</span><br><span>@@ -=
1565,7 +1577,6 @@</span><br><span>     /* set the state of the keys for the=
 session to generated */</span><br><span>     ks-&gt;state =3D S_GENERATED_=
KEYS;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ret =3D true;</span><br><span> cleanup:</span><br><span>     secure_m=
emzero(ks-&gt;key_src, sizeof(*ks-&gt;key_src));</span><br><span>     retur=
n ret;</span><br><span>@@ -1637,7 +1648,10 @@</span><br><span>             =
}</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return tls_session_generate_data_channe=
l_keys(multi, session);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* A DCO desync is reported as a plain failure here: every caller o=
f this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * functi=
on already turns a failure into a SIGUSR1, which is exactly the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * recovery a desync needs =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tls_se=
ssion_generate_data_channel_keys(multi, session) =3D=3D KEY_GEN_OK;</span><=
br><span> }</span><br><span> </span><br><span> bool</span><br><span>@@ -323=
2,6 +3246,9 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span>=
<br><span>     int active =3D TLSMP_INACTIVE;</span><br><span>     bool err=
or =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 kept separate from &#39;active&#39; on purpose: a restart request must not=
 be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * overwritt=
en by a later TLSMP_ACTIVE/TLSMP_RECONNECT assignment */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool restart =3D false;</span><br>=
<span> </span><br><span>     tls_clear_error();</span><br><span> </span><br=
><span>@@ -3334,12 +3351,22 @@</span><br><span>             /* Session is n=
ow fully authenticated=2E</span><br><span>              * tls_session_gener=
ate_data_channel_keys will move ks-&gt;state</span><br><span>              =
* from S_ACTIVE to S_GENERATED_KEYS */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (!tls_session_generate_data_channel_keys(mu=
lti, session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       enum key_gen_status status =3D tls_session_generate_data_channel_key=
s(multi, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (status !=3D KEY_GEN_OK)</span><br><span>             {</span=
><br><span>                 msg(D_TLS_ERRORS, &quot;TLS Error: generate_key=
_expansion failed&quot;);</span><br><span>                 ks-&gt;authentic=
ated =3D KS_AUTH_FALSE;</span><br><span>                 key_state_ssl_shut=
down(&amp;ks-&gt;ks_ssl);</span><br><span>                 ks-&gt;state =3D=
 S_ERROR_PRE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Invali=
dating the key state is not enough to recover from a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 * DCO desync: the kernel=
 peer has to be re-created, and the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 * key state we just invalidated will never=
 be retried, so ask</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 * for a restart right away */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                if (status =3D=3D KEY_GEN_DCO_DE=
SYNC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    restart =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span>             }</span><br><span> </span>=
<br><span>             /* Update auth token on the client if needed on rene=
gotiation</span><br><span>@@ -3428,7 +3455,17 @@</span><br><span> </span><b=
r><span>     gc_free(&amp;gc);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return (tas =3D=3D TLS_AUTHENTICATION_FAILED=
) ? TLSMP_KILL : active;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* strongest outcome wins: killing the session supersedes restarti=
ng it,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and re=
starting supersedes whatever &#39;active&#39; ended up being */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (tas =3D=3D TLS_AUTHENTI=
CATION_FAILED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return TLSM=
P_KILL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (restart)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return TLSMP_RESTART;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return active;</span><br><span> }</span><=
br><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ss=
l=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2E9d614aa 1006=
44</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/open=
vpn/ssl=2Eh</span><br><span>@@ -231,6 +231,8 @@</span><br><span> #define TL=
SMP_ACTIVE    1</span><br><span> #define TLSMP_KILL      2</span><br><span>=
 #define TLSMP_RECONNECT 3</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/** the session cannot recover on its own and has to be restarted */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLSMP_RESTA=
RT   4</span><br><span> </span><br><span> /*</span><br><span>  * Called by =
the top-level event loop=2E</span><br><span>@@ -561,7 +563,8 @@</span><br><=
span>  * This erases the source material used to generate the data channel =
keys, and</span><br><span>  * can thus be called only once per session=2E</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bo=
ol tls_session_generate_data_channel_keys(struct tls_multi *multi, struct t=
ls_session *session);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+enum key_gen_status tls_session_generate_data_channel_keys(struct tls_mul=
ti *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                                  struct tls_session *sessi=
on);</span><br><span> </span><br><span> void tls_session_soft_reset(struct =
tls_multi *multi);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9c9024=
2=2E=2E6db304d 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</spa=
n><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -187,6 +187=
,21 @@</span><br><span> };</span><br><span> </span><br><span> /**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Outcome of generating the =
data channel keys of a session=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
\c KEY_GEN_DCO_DESYNC is kept distinct from \c KEY_GEN_FAILED because it</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * means userspace and=
 kernel disagree about the DCO peer: the session cannot</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * recover on its own and the connectio=
n has to be restarted, while any other</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * failure only invalidates the affected key state=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+enum key_gen_status</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    KEY_GEN_OK,         /**&lt; keys were generated and =
installed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    KEY=
_GEN_FAILED,     /**&lt; generation failed, invalidate the key state */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    KEY_GEN_DCO_DESYNC,=
 /**&lt; the DCO peer is gone from the kernel */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span>  * Security parameter state of one TLS and data channel %key =
session=2E</span><br><span>  * @ingroup control_processor</span><br><span> =
 *</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change 1835</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I564edc6e0cc17=
9c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1835 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: ralf_lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--ynT2uzAhj/Q=--


--===============2120398813355333458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2120398813355333458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2120398813355333458==--

