Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0873BC43602
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MlmmYixJHeGwEg8fbE7qUcj5ZpXe/D0jiP6sypIqJrA=; b=iXe6K9OU3sMjQz4pCRoy7Dnrum
	70JUAJwAgANAvICwgD9B1FynDn+Skj3dN6vZyFqL75eXrHPdUQyTDGUrZi7VDRX+KV+ggmfqKYmI3
	cpH0T0L6mYdhMOnQZxX/KlWDjoCGZfLvR6wO9wUrvT1NPkS5oRMKTqIDmaZe86UqN6Jk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdqxB-00006D-U9;
	Sun, 28 Jun 2026 14:57:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdqxA-00005z-Ek
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 14:57:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ykJhseqjpG+P3MvRH6l2ZS/sAnY/vhAkCHOCypz/2HY=; b=nGKIe/bnPoPLxYWfteUIQ3I4BL
 rXnDaU5t7FPgfmZHAdrs4vgK3il90hMl5Bv5ipub83rBhppPWl1Hxf740luC47wkPDfQDOmYAnz1O
 A3929jzyrWTOOoFeI/GI7crZRyqyHfgKAoG+5ZF2MK6pzyJ5XImEzdf1xUFF5R3tg460=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ykJhseqjpG+P3MvRH6l2ZS/sAnY/vhAkCHOCypz/2HY=; b=k
 amRsURbsuyjjUXFXYE8ARu3DxcdsSpIisEw4Eb4JAYm5lpSWVsGhNUxsLUHtiVCrZ43R+3YUcNO/Z
 5oOvWw05Qh/gg0TzYqDWKC/dPO9oz/y9Xjmw40qM9k/uldDELJPyebvdZ/Dn3IW2YcoNGApOcWyt8
 nOVnxX4+gqAa9HnM=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdqx9-0006NW-EY for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 14:57:49 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49270caa5c0so17787355e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782658656; x=1783263456; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ykJhseqjpG+P3MvRH6l2ZS/sAnY/vhAkCHOCypz/2HY=;
 b=TcV9jfVVUrCrCycOkTYRA3MOUrEy2T1aKgyOBMxUBsGctRX6ZVd5IfNSgi7B1x7XHM
 2Xk3IqbHoCyEfzIbbQDcSdkZdfJJ5L2zK/Js6bZ5EbQmBDxtYfrNcnR1pmZ5xwfiQRVG
 RVFi4k4tfpGEa1rY/JE0NH3eYmWYU8MfRm9nrPcpBCnHFu3nfI8e28jXcpZkf98Si6sR
 dwA9vnISDha5S4E+OHaIpvOxa+ciCFP9DdtYU2LbwliUKh+MnYJAtaLdpPKAzmJ/fAJt
 V2JhnEdyCouQbOQ6VLHZq+yKScFcp9Jod14uK+63c0zPA80fcO+P/gs9PTlNnf1Q8ev6
 7UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782658656; x=1783263456;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ykJhseqjpG+P3MvRH6l2ZS/sAnY/vhAkCHOCypz/2HY=;
 b=UsKeCI3iaAVMyGeifaJfzynrwoZDponv4BJh4jOb5YcXo2/bmGcBbTcVTPw5Nnp5FO
 MFuaGMAVMe8dhWAsB9jLhnn4yvNx710arz29V9mY+rYvgESQcfXzft20es01+KJQWJil
 d6SLpnshfcEcmFIbNzm+cm4uVlpdxLKm1hfj6zzuyfzv64ZZBSH+yVW3ZhhzuXnVp4yV
 6Zy3x8K6fIXAHvb6iekyLXZGlxH3ynDLBtpSrmsjHSA37wAFl5sgxAT+P831lWZmGGol
 qvNoBkPECkl9yem2/oQ770jn6in3oVk+RCbGquuFOXG63VLYhKtA+JJMn+vMl4bgEHpm
 LivQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nrHCsgyG6WVCjiYclh+2YHi9A4dbJB5Fc4OcZ9kHc8emujYvL8pXRV7ymg9hgz7nELn6k9lDOzLc7lfD7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxlTrkAyRLSA8txB2ORKEL7HkzfQNucooa+Ac8ySKvW8hYG5Fn8
 Eb8o1YAiyR6knb4/H5N+w2RHH4o7a056K/ehdbPecZN5JXSMFXoLH3YYb+dcrcC4XtER0PVXi+8
 KZUwxY9Rix2NvoqXQwKpLQcx5659cEWlODQJyywASQhM2gcYOw1CAMyfbS3ceO5y3rrXYIwbcjl
 1kuuCsEw==
X-Gm-Gg: AfdE7ckBx0SzHzIqmvR1fR7IcUtdh6vUVUqCCSkmNqRDjSCsV9fIPOAjcTVHNCuUdIe
 RXS1x4DeXui6o5tGByH1lPi/M22Hff2mo94+AH2mW40MsKPMKXpW6pkhCV6BqrasIHiGhdxJ9pF
 W3C5FCUEnvmkSHbtBZFeT7jd9zcyLZfGgM67JkvjhFVZLGo7VnqlimTp4pU5GPZYEFAUB3Z0JB3
 fnVhVECGsp+og6aj5hTP3rNAi+qp15ByZPQrICDcGYCG5NmCHbxdrzK/ZXEtsz04+86IBfgQGRt
 shmwB11ekRZarcQIGxxyToyxkuCmJ2DxIlmM/hrR0aRf4ilGwTCi8/yP1+uiqkR61jKvQSLz6n9
 V4yUczfbnIrTOhR9IYcQiASWoKSdb+neiy/ECWHAWQqAL/EjK8frCOkqFUUDMQowRnC1te9w5DF
 LNClzDO115dRJfK5nd+kA4q0vCX7qGlCA//ZSEYDvUgdj+3z0rvVsxyN1UJOSVp38wEEAieoRn+
 hS6M3/jP6dT9gMwUSbOtQl8PLkU4kqpGTLBWfclw952bGzflmF+0bHHSIdcC2JUG71WwySx6EBj
 ZrA+fMw/er8C4Q==
X-Received: by 2002:a05:600c:46c3:b0:492:699e:3113 with SMTP id
 5b1f17b1804b1-492699e319cmr155116875e9.35.1782658656142; 
 Sun, 28 Jun 2026 07:57:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49271465f35sm175483045e9.9.2026.06.28.07.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 07:57:35 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 28 Jun 2026 14:57:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
X-Gerrit-Change-Number: 1720
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1720?usp=email>
X-Gerrit-Commit: 1572ee902f1d1ad75c1ad621ddcdc8bc80a5d522
In-Reply-To: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk2YTAzMjQ2NWU2NmI0OWFiMGNlOGIxYTg0ZWFkOGQ5YWNlZjkxOGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f84eba4611ebbb2b52dac72a122471836964a127-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdqx9-0006NW-EY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 handle_connection_attempt from multi_get_create_instance_udp
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5435662472856999242=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5435662472856999242==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gOdHyAxt/cU="; charset=UTF-8

--gOdHyAxt/cU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1720?usp=3Demail )

Change subject: Extract handle_connection_attempt f=
rom multi_get_create_instance_udp
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Extract handle_connection_attempt from multi_get_cre=
ate_instance_udp

The multi_get_create_instance_udp is quite large=2E This =
factors out the
one branch that handles and creates new connection attempts=
=2E

Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720
Mess=
age-Id: <20260628130500=2E26086-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37336=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
mudp=2Ec
1 file changed, 72 insertions(+), 50 deletions(-)




diff --git a=
/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 143a330=2E=2Ef919b67 100=
644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -194,12 +194,8=
1 @@
     return false;
 }
 
-/*
+/**
+ * Handles a packet if no existing s=
ession exists for this incoming packet=2E
+ *
+ * It will either send a rep=
ly with a hmac cookie if this is the first
+ * packet of a three-way handsh=
ake or create a multi_instance if it is a
+ * packet that completes the thr=
ee-way handshake=2E
+ */
+static struct multi_instance *
+handle_connection=
_attempt(struct multi_context *m,
+                          struct link_so=
cket *sock,
+                          struct mroute_addr *real,
+         =
                 const uint64_t hv,
+                          struct hash_=
bucket *bucket)
+{
+    struct hash *hash =3D m->hash;
+    struct tls_pre_=
decrypt_state state =3D { 0 };
+    struct multi_instance *mi =3D NULL;
+  =
  struct gc_arena gc =3D gc_new();
+
+    if (m->deferred_shutdown_signal=
=2Esignal_received)
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI=
: Connection attempt from %s ignored while server is "
+            "shutti=
ng down",
+            mroute_addr_print(real, &gc));
+    }
+    else if (=
do_pre_decrypt_check(m, &state, *real, sock))
+    {
+        /* This is an=
 unknown session but with valid tls-auth/tls-crypt
+         * (or no auth =
at all)=2E  If this is the initial packet of a
+         * session, we just=
 send a reply with a HMAC session id and
+         * do not generate a sess=
ion slot */
+
+        if (frequency_limit_event_allowed(m->new_connection_=
limiter))
+        {
+            /* a successful three-way handshake only =
counts against
+             * connect-freq but not against connect-freq-in=
itial */
+            reflect_filter_rate_limit_decrease(m->initial_rate_li=
miter);
+
+            mi =3D multi_create_instance(m, real, sock);
+      =
      if (mi)
+            {
+                hash_add_fast(hash, bucket, &=
mi->real, hv, mi);
+                mi->did_real_hash =3D true;
+          =
      multi_assign_peer_id(m, mi);
+
+                /* If we have a sessi=
on id already, ensure that the
+                 * state is using the same =
*/
+                if (session_id_defined(&state=2Eserver_session_id)
+   =
                 && session_id_defined((&state=2Epeer_session_id)))
+      =
          {
+                    mi->context=2Ec2=2Etls_multi->n_sessions++=
;
+                    struct tls_session *session =3D
+                   =
     &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
+                 =
   session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+      =
          }
+            }
+        }
+        else
+        {
+           =
 msg(D_MULTI_ERRORS,
+                "MULTI: Connection from %s would exce=
ed new connection frequency limit as controlled by --connect-freq",
+      =
          mroute_addr_print(real, &gc));
+        }
+    }
+    free_tls_pr=
e_decrypt_state(&state);
+    gc_free(&gc);
+    return mi;
+}
+
+/**
  * G=
et a client instance based on real address=2E  If
  * the instance doesn't =
exist, create it while
  * maintaining real address hash table atomicity=2E=

  */
-
 struct multi_instance *
 multi_get_create_instance_udp(struct mult=
i_context *m, bool *floated, struct link_socket *sock)
 {
@@ -258,54 +327,7=
 @@
         /* we have no existing multi instance for this connection */
 =
        if (!mi)
         {
-            struct tls_pre_decrypt_state state=
 =3D { 0 };
-            if (m->deferred_shutdown_signal=2Esignal_received)=

-            {
-                msg(D_MULTI_ERRORS,
-                    "=
MULTI: Connection attempt from %s ignored while server is "
-              =
      "shutting down",
-                    mroute_addr_print(&real, &gc));=

-            }
-            else if (do_pre_decrypt_check(m, &state, real,=
 sock))
-            {
-                /* This is an unknown session but w=
ith valid tls-auth/tls-crypt
-                 * (or no auth at all)=2E  If=
 this is the initial packet of a
-                 * session, we just send =
a reply with a HMAC session id and
-                 * do not generate a se=
ssion slot */
-
-                if (frequency_limit_event_allowed(m->new_c=
onnection_limiter))
-                {
-                    /* a successful=
 three-way handshake only counts against
-                     * connect-fr=
eq but not against connect-freq-initial */
-                    reflect_fil=
ter_rate_limit_decrease(m->initial_rate_limiter);
-
-                    mi=
 =3D multi_create_instance(m, &real, sock);
-                    if (mi)
- =
                   {
-                        hash_add_fast(hash, bucket, &=
mi->real, hv, mi);
-                        mi->did_real_hash =3D true;
-  =
                      multi_assign_peer_id(m, mi);
-
-                     =
   /* If we have a session id already, ensure that the
-                   =
      * state is using the same */
-                        if (session_id_=
defined(&state=2Eserver_session_id)
-                            && session=
_id_defined((&state=2Epeer_session_id)))
-                        {
-      =
                      mi->context=2Ec2=2Etls_multi->n_sessions++;
-        =
                    struct tls_session *session =3D
-                      =
          &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
-            =
                session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Ef=
rom);
-                        }
-                    }
-                }
=
-                else
-                {
-                    msg(D_MULTI_E=
RRORS,
-                        "MULTI: Connection from %s would exceed new=
 connection frequency limit as controlled by --connect-freq",
-            =
            mroute_addr_print(&real, &gc));
-                }
-           =
 }
-            free_tls_pre_decrypt_state(&state);
+            mi =3D han=
dle_connection_attempt(m, sock, &real, hv, bucket);
         }
 
 #ifdef EN=
ABLE_DEBUG

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
20?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a032465e6=
6b49ab0ce8b1a84ead8d9acef918de
Gerrit-Change-Number: 1720
Gerrit-PatchSet: =
4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--gOdHyAxt/cU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1720?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Extract handle_connection_attempt from mul=
ti_get_create_instance_udp<br><br>The multi_get_create_instance_udp is quit=
e large=2E This factors out the<br>one branch that handles and creates new =
connection attempts=2E<br><br>Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9ac=
ef918de<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720<br>Message-Id: &lt;20260628130500=
=2E26086-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37336=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
mudp=2Ec<br>1 file changed, 72 insertions(+), 50 deletions(-)<br><br></pre>=

<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><spa=
n>index 143a330=2E=2Ef919b67 100644</span><br><span>--- a/src/openvpn/mudp=
=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -194,12 =
+194,81 @@</span><br><span>     return false;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Handles a packet if no existing session exis=
ts for this incoming packet=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It =
will either send a reply with a hmac cookie if this is the first</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * packet of a three-way hands=
hake or create a multi_instance if it is a</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * packet that completes the three-way handshake=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static struct multi_instance *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+handle_connection_attempt=
(struct multi_context *m,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                          struct link_socket *sock,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                          struct mrou=
te_addr *real,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                     const uint64_t hv,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                          struct hash_bucket *bucket)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =3D m-&gt;hash;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_de=
crypt_state state =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct multi_instance *mi =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (m-&gt;deferred_shutdown_signal=2Esignal_=
received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRO=
RS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;MULTI: Connection attempt from %s ignored while server is &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;shutting d=
own&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mroute_addr_print(real, &amp;gc));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (do_pre_decrypt_check(m, &amp;state, *real, sock))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* This is an unknown session but=
 with valid tls-auth/tls-crypt</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * (or no auth at all)=2E  If this is the initial packet=
 of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * ses=
sion, we just send a reply with a HMAC session id and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * do not generate a session slot=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (frequency_limit_event_a=
llowed(m-&gt;new_connection_limiter))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            /* a successful three-way handshake only counts against=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * conn=
ect-freq but not against connect-freq-initial */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            reflect_filter_rate_limit_decrease=
(m-&gt;initial_rate_limiter);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi =3D multi_create_instance(m, real, sock);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (mi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                hash_add_fast(hash, bucket, &amp;mi-&=
gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              mi-&gt;did_real_hash =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                multi_assign_peer_id(m, mi);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                /* If we have a session id a=
lready, ensure that the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 * state is using the same */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                if (session_id_defined(&amp;s=
tate=2Eserver_session_id)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    &amp;&amp; session_id_defined((&amp;state=2Epeer_=
session_id)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    struct tls_se=
ssion *session =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM_=
INITIAL];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          session_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec=
2=2Efrom);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_ERRORS,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                &quot;MULTI: Con=
nection from %s would exceed new connection frequency limit as controlled b=
y --connect-freq&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                mroute_addr_print(real, &amp;gc));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return mi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span>  * Get a client instance based on real address=2E  If</sp=
an><br><span>  * the instance doesn&#39;t exist, create it while</span><br>=
<span>  * maintaining real address hash table atomicity=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 struct multi_instance *</span><br><span> multi_get_create_instance_udp(str=
uct multi_context *m, bool *floated, struct link_socket *sock)</span><br><s=
pan> {</span><br><span>@@ -258,54 +327,7 @@</span><br><span>         /* we =
have no existing multi instance for this connection */</span><br><span>    =
     if (!mi)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            struct tls_pre_decrypt_state state =3D { 0 }=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (m-&g=
t;deferred_shutdown_signal=2Esignal_received)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                msg(D_MULTI_ERRORS,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;MULTI: Connection=
 attempt from %s ignored while server is &quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    &quot;shutting down&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mrou=
te_addr_print(&amp;real, &amp;gc));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            else if (do_pre_decrypt_check(m, &amp;state, real, sock))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                /* This is an=
 unknown session but with valid tls-auth/tls-crypt</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                 * (or no auth at all)=2E  If =
this is the initial packet of a</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                 * session, we just send a reply with a HMAC sess=
ion id and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      * do not generate a session slot */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (frequency_limit_event_allowed(m-&gt;new_connection_limit=
er))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    /=
* a successful three-way handshake only counts against</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                     * connect-freq but no=
t against connect-freq-initial */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    reflect_filter_rate_limit_decrease(m-&gt;in=
itial_rate_limiter);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi=
 =3D multi_create_instance(m, &amp;real, sock);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    if (mi)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        hash_add_fast(hash,=
 bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        mi-&gt;did_real_hash =3D true;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        mult=
i_assign_peer_id(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      /* If we have a session id already, ensure that the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                         * state is usi=
ng the same */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 if (session_id_defined(&amp;state=2Eserver_session_id)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
   &amp;&amp; session_id_defined((&amp;state=2Epeer_session_id)))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                            struct tls_session=
 *session =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                        &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM=
_INITIAL];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                 session_skip_to_pre_start(session, &amp;state, &amp;m-&gt;=
top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        &quot;MULTI: Connection from %s would exce=
ed new connection frequency limit as controlled by --connect-freq&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
mroute_addr_print(&amp;real, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            free_tls_pre_decrypt_state(&amp;state);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            mi =3D handle_connection_=
attempt(m, sock, &amp;real, hv, bucket);</span><br><span>         }</span><=
br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1720?usp=3Demail">change 1720</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1720?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1720 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--gOdHyAxt/cU=--


--===============5435662472856999242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5435662472856999242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5435662472856999242==--

