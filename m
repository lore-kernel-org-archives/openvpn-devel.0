Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C9606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aHYvcPI6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DeAfmgys;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d9NUECOk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HD4RpVUS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kabmEXY1FMkB/xyPK94VF86MthaAj+lJZJ/a73W2kE0=; b=aHYvcPI6oARLvP3+9GqOMam3ob
	yz/BJG+34nn7eRHv3diYYhXFM0nLzd2ojc9Hhge8t6xX/b5UJfZX7Y/SRVX9X0Btofr0pNX8BnH6V
	XS4QI2v3W9MbJRk0F5N3yPtpTW1Ej63SJmDgNn+WkicCGK/id4hcMWod2Gy9z2Yfzhp0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR8Pv-0000000005d-16i1;
	Wed, 11 Nov 2026 13:31:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR8Pc-000000008VO-2xsS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1y6ex9LW9uEmqIdXDxGIcTd7Y2XpVRJU00mTTSaV0E=; b=DeAfmgysfiHVADLC1+4Ebf/s5n
 lBqnnPGfNr3pb+eTRKusKeQDaR3ahNgz4dWt54p9k2U3UDNsj11WQOf0NVraQq5QvDbAtzCy+MxXv
 Uw1ElSZSUcVbLqCvog6u2ZMXxOcSQG4Qfxr7/Ua5hspNafsLdjElzuzhhuCfG54v3HlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1y6ex9LW9uEmqIdXDxGIcTd7Y2XpVRJU00mTTSaV0E=; b=d9NUECOkDWV9XfAJfpys2e9/bv
 7qxkvnZjpusGm+tmk/q5N7bc0EPo69GacWwLwhyKJHDB8+KB8Zr8UeZwHX8JnkO+Iopknj59jDKJd
 dZv9estgU92XUgeGDc9CyD7DZ4e0mBokFq6DvxpHl8wonWaVpvk17nr98qxHg0WHvALw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR8PZ-000000006Ym-3Zxn for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:30:52 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so31945385e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794403843; x=1795008643; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a1y6ex9LW9uEmqIdXDxGIcTd7Y2XpVRJU00mTTSaV0E=;
 b=HD4RpVUSIyoszxh0Vv1Ixddr7R0nftQHdoOS+EtBq3gJb0jFk+Ilm63y1QSj+WZSnI
 i5a+OxKf+FXJCEKZEM8xve5QgGtnnnm+eIdP/vgFMdHdLznmM5BinSEM/kpeczdBg+y7
 KGLPSotGhaAW416vooAyoeAWQrGyu+yS7bB5L4NpWgiRmgz6GpaxDLLn5zJxpiUl6/7W
 TwaCK4GYi+HB/nyUBvRrZHOMJIuxcyZp+5zsAmoOMXTZALHPnDjzb9qPfQDIJiZ229cl
 0ARX5uA34gEWVGlLM+Wfgkve+eCo8CUR6hqC/shOlpxIKL5MWH9H4NxxGcMvfThJzr0c
 DZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794403843; x=1795008643;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a1y6ex9LW9uEmqIdXDxGIcTd7Y2XpVRJU00mTTSaV0E=;
 b=zmKYvIi70m2BzYlvy8AI6QnnnaghSOjISVs6aaPELkp2WA8RfZHovmaSCjtsk5404l
 j5qMziYqRbmBqCbJ9IKOOuViPyKgz/djFddk3njJZd0SwrSHCU6VM8WLoT6lWAAsBflv
 TkjX0ZSD3IZG0yWPjFdLO4CvEFBcsTFc5YXu4X7MYANzpdlhHwaeBT6GloP1qYOh+c6V
 TZ7D0ZfZ2cG0P0dODjJZwkQKOrNoZU6Et1tlAHuyO6/0lEMIzNSBiO+NhCCyhGGRCy8z
 sxz3t3KbyHFpGK9ORa1AjPzNLedwLFzLMonvJY+u99mCHE/ggteMPMAtG+362tfwihbe
 bbaw==
X-Gm-Message-State: APuU4Z++a8g0azGtIPU7/GNrX38/qyiRWCd1IRr4pHsRjLIV1RrtJvH8
 UMyYbsfjeBVSJFRJZOAyLXVJeRUEtRG2qNKZ48huVFgGyO0fYQm8yWdmlb+kKMv4YEUYnfoEDAz
 mZqPfkjwI9sUfemTNlmpx0XnEeAj2ylz6ebUMEv20t6BR8/pYkSA7pwyLw+FxWHQIjb07dq4992
 xfRcyUhw==
X-Gm-Gg: AYBFou0POkSH8I7nAi9r8s3PJf5CGCKu//FfNEsWlqeClJEwshFkaWTKwYbBVtcPyDv
 l0Dy5a3jJMXGVxAulVRqVrroFBgKk3gi3iLRmJV365I2Ao9g6BuL0z10WV33Vu7/lFPlxtbVFvH
 fx8K1x6kHQshx6O0Nq8QYNcRm6MiWRWsvmvzjryJmC/0lxduXyfXnMp2zTFOnhqv2NQPS9xippk
 8SUwWhhMweSFXhtG8FTrO8l1gF/CqB6p6zQ3f8Q8BC2dpLSFn90d3G0xBDGSp0YnP/+dPUKfcz3
 EvUdtNBAIDVG/BBwDkpipQQfC1xRfYAPvgti8apzCbKWrbOe0nVrufwP4iA8BNL7iDL65NDJ2St
 kipWRS9jNeixWU3ubts5CrAonZwjsXrbEyOz3POq9GdJ8Uumo8wwe661VDG1oIYm57b5mOaLvlp
 BUIhsyQH0Mem9lHEIlVnMzwwOM38+aiuNuVvj9XgmSCGe83oj4yEpBVQUPmZClGVK8IzrCVmf2c
 Hb44dQA73gVBZEyVDtFxH5EyQk+SfayrUSQPzNX7sCrbEPd83Ca+BVWHH6JiacN6uYNyBhQR/bK
 isUx05xAFPOaavnevVJH4WyiOC3z3VvLFfvySweQqBaN2fezotxDoQY7rcxAR86SOeqSfDrl8e6
 kVIJ6nPir/hI8KFZUfLNAWQZug8sU/Ykf6J8baiJ596gbp1Thl+3ZaV0OX9I9XFBuovyMrkJT5Y
 cdiBhlPnPCxKI+QVU=
X-Received: by 2002:a05:600d:82f1:b0:4a2:cbe:beac with SMTP id
 5b1f17b1804b1-4ba093c85ebmr48912665e9.23.1794403843056; 
 Wed, 11 Nov 2026 05:30:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08ddbe68sm100138755e9.0.2026.11.11.05.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:30:42 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 13:30:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 7c26995119d4b1dbaf696843e8017ef7fa1cea33
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f37ffdbe77a879b5525aefe643ca9c7ee2ddabf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR8PZ-000000006Ym-3Zxn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5876349748474749365=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5876349748474749365==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="08rYW6T8bQM="; charset=UTF-8

--08rYW6T8bQM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#3)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2175?usp=3Demail )


Change subject: Extract tls_pre_de=
crypt_extract_session_id and pre_decrypt_find_session
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract tls_pre_decrypt_extract_se=
ssion_id and pre_decrypt_find_session

These functions fulfil steps that ca=
n be easily moved to their own
functions to make tls_pre_decrypt a bit more=
 readable=2E

Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Signed-o=
ff-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file c=
hanged, 70 insertions(+), 37 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/75/2175/3

diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 3ad7fe7=2E=2E3af5c95 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3765,6 +3765,70 @@
     return tr=
ue;
 }
 
+static bool
+tls_pre_decrypt_extract_session_id(const struct link=
_socket_actual *from,
+                                   struct buffer buf=
, struct session_id *sid)
+{
+    /* skip op code */
+    buf_advance(&buf,=
 1);
+    if (!session_id_read(sid, &buf) || !session_id_defined(sid))
+   =
 {
+        struct gc_arena gc =3D gc_new();
+        msg(D_TLS_ERRORS, "TL=
S Error: session-id not found in packet from %s",
+            print_link_s=
ocket_actual(from, &gc));
+        gc_free(&gc);
+        return false;
+  =
  }
+    return true;
+}
+
+/**
+ *  Find session matching the session id i=
n sid in multi=2Esession array
+ *
+ * @return index of session in multi=2E=
session array, TM_SIZE if not found
+ *         and -1 on error
+ */
+stati=
c int
+pre_decrypt_find_session(struct tls_multi *multi, const struct link_=
socket_actual *from,
+                         const struct session_id *sid=
)
+{
+    struct gc_arena gc =3D gc_new();
+    int i;
+    /* use session =
ID to match up packet with appropriate tls_session object */
+    for (i =
=3D 0; i < TM_SIZE; ++i)
+    {
+        struct tls_session *session =3D &m=
ulti->session[i];
+        struct key_state *ks =3D &session->key[KS_PRIMAR=
Y];
+
+        dmsg(
+            D_TLS_DEBUG,
+            "TLS: initial p=
acket test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, store=
d-sid=3D%s, stored-ip=3D%s",
+            i, state_name(ks->state), session=
_id_print(&session->session_id, &gc),
+            session_id_print(sid, &g=
c), print_link_socket_actual(from, &gc),
+            session_id_print(&ks-=
>session_id_remote, &gc),
+            print_link_socket_actual(&ks->remote=
_addr, &gc));
+
+        if (session_id_equal(&ks->session_id_remote, sid))=

+        /* found a match */
+        {
+            if (i =3D=3D TM_LAME_=
DUCK)
+            {
+                msg(D_TLS_ERRORS, "TLS ERROR: receive=
d control packet with stale session-id=3D%s",
+                    session_=
id_print(sid, &gc));
+                i =3D -1;
+                goto done;=

+            }
+            dmsg(D_TLS_DEBUG, "TLS: found match, session[%=
d], sid=3D%s", i,
+                 session_id_print(sid, &gc));
+         =
   break;
+        }
+    }
+
+done:
+    gc_free(&gc);
+    return i;
+}
+=

 /*
  *
  * When we are in TLS mode, this is the first routine which sees
=
@@ -3820,7 +3884,6 @@
     /* control channel packet */
     bool do_burst =
=3D false;
     bool new_link =3D false;
-    struct session_id sid; /* rem=
ote session ID */
 
     /* verify legal opcode */
     if (!tls_pre_decryp=
t_verify_opcode(op, multi->opt=2Eserver, from))
@@ -3834,46 +3897,16 @@
   =
  dmsg(D_TLS_DEBUG, "TLS: control channel, op=3D%s, IP=3D%s", packet_opcode=
_name(op),
          print_link_socket_actual(from, &gc));
 
-    /* get re=
mote session-id */
+    struct session_id sid; /* remote session ID */
+   =
 if (!tls_pre_decrypt_extract_session_id(from, *buf, &sid))
     {
-       =
 struct buffer tmp =3D *buf;
-        buf_advance(&tmp, 1);
-        if (!s=
ession_id_read(&sid, &tmp) || !session_id_defined(&sid))
-        {
-      =
      msg(D_TLS_ERRORS, "TLS Error: session-id not found in packet from %s"=
,
-                print_link_socket_actual(from, &gc));
-            goto =
error;
-        }
+        goto error;
     }
 
-    int i;
-    /* use ses=
sion ID to match up packet with appropriate tls_session object */
-    for =
(i =3D 0; i < TM_SIZE; ++i)
+    int i =3D pre_decrypt_find_session(multi, =
from, &sid);
+    if (i =3D=3D -1)
     {
-        struct tls_session *sess=
ion =3D &multi->session[i];
-        struct key_state *ks =3D &session->key=
[KS_PRIMARY];
-
-        dmsg(
-            D_TLS_DEBUG,
-            "TLS:=
 initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=
=3D%s, stored-sid=3D%s, stored-ip=3D%s",
-            i, state_name(ks->sta=
te), session_id_print(&session->session_id, &gc),
-            session_id_p=
rint(&sid, &gc), print_link_socket_actual(from, &gc),
-            session_=
id_print(&ks->session_id_remote, &gc),
-            print_link_socket_actua=
l(&ks->remote_addr, &gc));
-
-        if (session_id_equal(&ks->session_id_=
remote, &sid))
-        /* found a match */
-        {
-            if (i =
=3D=3D TM_LAME_DUCK)
-            {
-                msg(D_TLS_ERRORS, "TLS=
 ERROR: received control packet with stale session-id=3D%s",
-             =
       session_id_print(&sid, &gc));
-                goto error;
-        =
    }
-            dmsg(D_TLS_DEBUG, "TLS: found match, session[%d], sid=3D=
%s", i,
-                 session_id_print(&sid, &gc));
-            break;=

-        }
+        goto error;
     }
 
     /*

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c=
0
Gerrit-Change-Number: 2175
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--08rYW6T8bQM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Extract tls_pre_decrypt_extract_session_id and pre_decrypt_fi=
nd_session<br><br>These functions fulfil steps that can be easily moved to =
their own<br>functions to make tls_pre_decrypt a bit more readable=2E<br><b=
r>Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 =
file changed, 70 insertions(+), 37 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/2175/3<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><s=
pan>index 3ad7fe7=2E=2E3af5c95 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3765,6 +=
3765,70 @@</span><br><span>     return true;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_pre_decrypt_extra=
ct_session_id(const struct link_socket_actual *from,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   struct=
 buffer buf, struct session_id *sid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* skip op code */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf_advance(&amp;buf, 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!session_id_read(sid, &amp;buf) || !session_id_defined(=
sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_TLS_ERRORS, &quot;TLS Error: session-id not found in packet from %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
print_link_socket_actual(from, &amp;gc));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  Find session matching the session id=
 in sid in multi=2Esession array</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return index of session in multi=2Esession array, TM_SIZE if not found</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         and -1 on err=
or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+pre_decrypt_find_session(struct tls_multi=
 *multi, const struct link_socket_actual *from,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                         const struct session_i=
d *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* use session ID =
to match up packet with appropriate tls_session object */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; TM_SIZE; ++i=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *sess=
ion =3D &amp;multi-&gt;session[i];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct key_state *ks =3D &amp;session-&gt;key[KS_PRI=
MARY];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        dmsg(</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            D_TLS_DEBUG,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &quot;TLS: initial pa=
cket test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored=
-sid=3D%s, stored-ip=3D%s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            i, state_name(ks-&gt;state), session_id_print(&amp=
;session-&gt;session_id, &amp;gc),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            session_id_print(sid, &amp;gc), print_link_socke=
t_actual(from, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            session_id_print(&amp;ks-&gt;session_id_remote, &amp;gc),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            print_li=
nk_socket_actual(&amp;ks-&gt;remote_addr, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (session_id_equal(&amp;ks-&gt;session_id_remote, =
sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* fou=
nd a match */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
i =3D=3D TM_LAME_DUCK)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(D_TLS_ERRORS, &quot;TLS ERROR: received control packet wit=
h stale session-id=3D%s&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    session_id_print(sid, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                i =3D -1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto done=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_TLS_D=
EBUG, &quot;TLS: found match, session[%d], sid=3D%s&quot;, i,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                 session_id_print=
(sid, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return i;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /*</span><br><span>  *</span><br><span>  * When we are in TLS mod=
e, this is the first routine which sees</span><br><span>@@ -3820,7 +3884,6 =
@@</span><br><span>     /* control channel packet */</span><br><span>     b=
ool do_burst =3D false;</span><br><span>     bool new_link =3D false;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session_id sid; =
/* remote session ID */</span><br><span> </span><br><span>     /* verify le=
gal opcode */</span><br><span>     if (!tls_pre_decrypt_verify_opcode(op, m=
ulti-&gt;opt=2Eserver, from))</span><br><span>@@ -3834,46 +3897,16 @@</span=
><br><span>     dmsg(D_TLS_DEBUG, &quot;TLS: control channel, op=3D%s, IP=
=3D%s&quot;, packet_opcode_name(op),</span><br><span>          print_link_s=
ocket_actual(from, &amp;gc));</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* get remote session-id */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid; /* remote =
session ID */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!tls_pre_decrypt_extract_session_id(from, *buf, &amp;sid))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t buffer tmp =3D *buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        buf_advance(&amp;tmp, 1);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (!session_id_read(&amp;sid, &amp;tmp) || !session_i=
d_defined(&amp;sid))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(D_TLS_ERRORS, &quot;TLS Error: session-id not found in packet from %s&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                p=
rint_link_socket_actual(from, &amp;gc));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            goto error;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto error;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* use session ID to match up pa=
cket with appropriate tls_session object */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; TM_SIZE; ++i)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int i =3D pre_decrypt_find_ses=
sion(multi, from, &amp;sid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (i =3D=3D -1)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct tls_session *session =3D &am=
p;multi-&gt;session[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        dmsg(</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            D_TLS_DEBUG,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &quot;TLS: initial packet test, i=3D%d sta=
te=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=
=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   i, state_name(ks-&gt;state), session_id_print(&amp;session-&gt;session_i=
d, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   session_id_print(&amp;sid, &amp;gc), print_link_socket_actual(from, &amp=
;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sess=
ion_id_print(&amp;ks-&gt;session_id_remote, &amp;gc),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            print_link_socket_actual(&amp;k=
s-&gt;remote_addr, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (s=
ession_id_equal(&amp;ks-&gt;session_id_remote, &amp;sid))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* found a match */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (i =3D=3D TM_LAME_DUCK)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                msg(D_TLS_ERRORS, =
&quot;TLS ERROR: received control packet with stale session-id=3D%s&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    se=
ssion_id_print(&amp;sid, &amp;gc));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                goto error;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            dmsg(D_TLS_DEBUG, &quot;TLS: found match, session[%=
d], sid=3D%s&quot;, i,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                 session_id_print(&amp;sid, &amp;gc));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto error;</span><br><span>     }</span><br>=
<span> </span><br><span>     /*</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">change 217=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I230b3b2483e15477b179b277dc8f7c91c53fa0c0 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2175 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--08rYW6T8bQM=--


--===============5876349748474749365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5876349748474749365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5876349748474749365==--

