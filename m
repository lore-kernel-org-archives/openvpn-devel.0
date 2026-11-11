Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDF606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J0xLIx21;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ieevnBjb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NnZm1Kp3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XRYJuq4H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=fdD0m7r/tkFAcDreW6l5OTyXzHkDzUNG3h81zn9AE/Y=; b=J0xLIx21XBzOTP0byLOayHuS0Z
	zeIvMoB8gV5DPQm6N+JxhV7dt9WHYjYlmbiKQngyt/y9qT8E4/jrtEn6fSrqQwbhGU5nOnC4J93fw
	73YqviWTlZPsR7ozoHtqJwk2T2u4IWetYw2282A0j4cEU98XGqJiW2NTp8519FrDDTpQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR6A7-000000006EH-0sZ1;
	Wed, 11 Nov 2026 11:06:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR6A3-000000006E2-0sQn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ot55DwxBGZLRI3j0/X1F0zhWm4rlOVbPgioLuqQFXco=; b=ieevnBjbxpLkMF/xcZkj+e6uLb
 G+uBCCYRORi9QYhFUEGST7Fg445ApzypPUgYkI2OCTUMYsXE7v4eziWe+HwD815A1y6+6OmhpUutc
 JrkmWfYDuddZ7t8g90qRp/RW2c7+MGd3v1TqyS8yhUnvzNN9Pni7vNvl24Z90vqzCG6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ot55DwxBGZLRI3j0/X1F0zhWm4rlOVbPgioLuqQFXco=; b=NnZm1Kp37ZQyt4vVt9LxCHQcSy
 lQ1yYV1vVVlABkX0q/Fx8HgLJI1OHFmUpVrBmek2llCUwzwBtBSabzeQx2/OExNMVdqsfFHXeLQnk
 fUbC62lZ0YSyfvJ5c44RIK8nEUiCyJi8PN+xwU459FheHv/hC/5oQU7Gngo4CSSPgJqE=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR6A1-000000005PI-2K19 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:06:38 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so26454965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 03:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794395191; x=1794999991; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ot55DwxBGZLRI3j0/X1F0zhWm4rlOVbPgioLuqQFXco=;
 b=XRYJuq4HGwzwQFTcxRu0/8zWhFLZbhhDgjhbIzSvs0klNf6K2LYoRRUdCzVXcanUhw
 6l+WgHrlvIPOLoiymKJnmm/b39jZNNumA0Rq8UNJD2YmcaaJtQeYYWfqH5FG2RtbE+ou
 F4fx6fIPalopFbTPq2B4upY04wiaMzdvW5OGu0KSM7HolHfo6u+NxsATK1ncDqG5LZOr
 9u9+KDIVHbvQlsAL3jDPz/mUB3cjt7x+hBLxoDfYyMyusTT78TMuHVM8Df6xv27LFpni
 +UO0WxEOGMHwBgG/+SlyJ7t1dN6cbsWjOJ10Sg/3A8B5MSnz7tTZFGKmc2DYOGMbxaNY
 zDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794395191; x=1794999991;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ot55DwxBGZLRI3j0/X1F0zhWm4rlOVbPgioLuqQFXco=;
 b=Rl3jMUTrBc2WNvpgWFnTIg4/t8ui/cjrYe8iX5dPbUm4C1MpC3uJo+IIq4YaZEq18M
 o8uNch/iE8yxM5krhc37MRxTjVM63LiQiaeBlxbcFXphr74gHWUHvbVtCX27kdHZPXvb
 CnvKuXW+GBwmYhZDOLvsA4sKny1d9CXmVoJOMZUXvcRmUvams+5YEtKWEZFSshZbOet3
 upZHQCTnzS6qXRjOO4+TWKxhvXtaYUymenLBPBVcRNfbVRUIRDBdqqtnttr3vpNwMa7S
 p5/tUlF1xKexyheYuOiTL4yII3tVLRgA7vibcbv0Tv1pLGqxK9CFtygfZ1PvCe3mYr9W
 vbuw==
X-Gm-Message-State: APuU4Z/Ao4LVMp6ZJ71tiQyeaCofOPgPtZfo1fbX//CBT10e60TxvVt0
 +SDFDEGVlL8hwQT805LrXRDlY5JbFkzVIAlTsyQ4RZoX2cmjHn2cgjRAplHTd0THBCEEGoWdqbo
 KyVOoeNJ7i21fdJAa12U/6S5paCwZfNL5ZVhnLJZzyFFccnwhXsBG+zFd3CQ5tKv5UdaO5+8CUa
 BGZvfBSA==
X-Gm-Gg: AYBFou3mP3ci87r+FBMzMI9ZfubrS6QHWrLyavz0fCWCdANK5j4nm2kFFaWwmjuuSXF
 fqKqIXFEQEOUHR0QjRixzASXfwjPpyombSc5vnKimh3mekLQLL/NaTGi4D+8xAqeyrORBSAStyT
 8e98IXVKC0pUsNIbUdPOfRpqCxqNLpp5/fOIIMGSntWNx8j9/n3d+nxZ5UDMFYNWpPPUJSo7dge
 Cb+GQnZVOSzjSzYCaPR5xG2jXy+7518G9/mKVo/OzN1X5/spGPAhbxE+cwtkRwsqxuFN2gP9WSU
 NeQ/SZrKVo8tWmfUBKPGpTRrOMolTz5Xh2MALFsp+/B0Nj/hdqLAvz1bDBqVhuKYvWECQjVzCJo
 Ad5r0oxecgQ+vB3bfu3rjz9hv/ahGsZFdb0tIYSaLF0FyBv/L/3UpExIRTs4p36N2w3mXh37tJb
 wnm3A36JQ7v9GKdxMmpkb4gj8SUP3xxyQBTcBPOusDDqp9eNbd8H2h53XkWRO+WrR5BZ9fFv9aD
 appqBPMaefVuEGX3UjgGisVIro3rflA2vCnXuj95zCZoTdxKTf1Kcb4abM/7q3I6w//+IPCWRYg
 c8jRx0i5+G25ZIn+HcsGXS91JNc3NHaixygRgjkjpdEzqefdXGSMFrs5BAZIPgB20kvTy1AMO1y
 rfH/w/+IDmj2WMCa8P/FYk0DVePchBpi19u4xvRjFpgoVuDuk0W8F5aT6ssOkO6hBdB+cTmWPRR
 vZCRDBMC7eU66n8AU=
X-Received: by 2002:a05:600c:a113:b0:4b0:a307:46f8 with SMTP id
 5b1f17b1804b1-4ba093582c1mr27344165e9.10.1794395190871; 
 Wed, 11 Nov 2026 03:06:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0951fe22sm55815415e9.3.2026.11.11.03.06.30
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:06:30 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 11:06:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 1693290a2e19497da1a033a50cd189e7d254ef86
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <224657933a23ff60f80cf7cafa2f99860891525b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR6A1-000000005PI-2K19
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
Content-Type: multipart/mixed; boundary="===============2947979592195309637=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2947979592195309637==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="piR7ZIcKWuc="; charset=UTF-8

--piR7ZIcKWuc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2175?usp=3Demail )


Change subject: Extract tls_pre_=
decrypt_extract_session_id and pre_decrypt_find_session
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract tls_pre_decrypt_extract=
_session_id and pre_decrypt_find_session

These functions fulfil steps that=
 can be easily moved to their own
functions to make tls_pre_decrypt a bit m=
ore readable=2E

Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Signe=
d-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/ssl=2Ec
1 fil=
e changed, 68 insertions(+), 37 deletions(-)



  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/75/2175/1

diff --git a/src/openvpn=
/ssl=2Ec b/src/openvpn/ssl=2Ec
index 3ad7fe7=2E=2E2f13e19 100644
--- a/src/=
openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3765,6 +3765,68 @@
     retur=
n true;
 }
 
+static bool
+tls_pre_decrypt_extract_session_id(const struct =
link_socket_actual *from, struct buffer buf, struct session_id *sid)
+{
+  =
  /* skip op code */
+    buf_advance(&buf, 1);
+    if (!session_id_read(s=
id, &buf) || !session_id_defined(sid))
+    {
+        struct gc_arena gc =
=3D gc_new();
+        msg(D_TLS_ERRORS, "TLS Error: session-id not found i=
n packet from %s",
+            print_link_socket_actual(from, &gc));
+    =
    gc_free(&gc);
+        return false;
+    }
+    return true;
+}
+
+/**=

+ *  Find session matching the session id in sid in multi=2Esession array
=
+ *
+ * @return index of session in multi=2Esession array, TM_SIZE if not f=
ound
+ *         and -1 on error
+ */
+static int
+pre_decrypt_find_session=
(struct tls_multi *multi, const struct link_socket_actual *from, struct ses=
sion_id *sid)
+{
+    struct gc_arena gc =3D gc_new();
+    int i;
+    /* =
use session ID to match up packet with appropriate tls_session object */
+ =
   for (i =3D 0; i < TM_SIZE; ++i)
+    {
+        struct tls_session *sess=
ion =3D &multi->session[i];
+        struct key_state *ks =3D &session->key=
[KS_PRIMARY];
+
+        dmsg(
+            D_TLS_DEBUG,
+            "TLS:=
 initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=
=3D%s, stored-sid=3D%s, stored-ip=3D%s",
+            i, state_name(ks->sta=
te), session_id_print(&session->session_id, &gc),
+            session_id_p=
rint(sid, &gc), print_link_socket_actual(from, &gc),
+            session_i=
d_print(&ks->session_id_remote, &gc),
+            print_link_socket_actual=
(&ks->remote_addr, &gc));
+
+        if (session_id_equal(&ks->session_id_r=
emote, sid))
+        /* found a match */
+        {
+            if (i =3D=
=3D TM_LAME_DUCK)
+            {
+                msg(D_TLS_ERRORS, "TLS ER=
ROR: received control packet with stale session-id=3D%s",
+                =
    session_id_print(&sid, &gc));
+                i =3D -1;
+             =
   goto done;
+            }
+            dmsg(D_TLS_DEBUG, "TLS: found mat=
ch, session[%d], sid=3D%s", i,
+                 session_id_print(&sid, &gc=
));
+            break;
+        }
+    }
+
+done:
+    gc_free(&gc);
+    =
return i;
+}
+
 /*
  *
  * When we are in TLS mode, this is the first routi=
ne which sees
@@ -3820,7 +3882,6 @@
     /* control channel packet */
     =
bool do_burst =3D false;
     bool new_link =3D false;
-    struct session_=
id sid; /* remote session ID */
 
     /* verify legal opcode */
     if (!=
tls_pre_decrypt_verify_opcode(op, multi->opt=2Eserver, from))
@@ -3834,46 +=
3895,16 @@
     dmsg(D_TLS_DEBUG, "TLS: control channel, op=3D%s, IP=3D%s",=
 packet_opcode_name(op),
          print_link_socket_actual(from, &gc));
 
=
-    /* get remote session-id */
+    struct session_id sid; /* remote sess=
ion ID */
+    if (!tls_pre_decrypt_extract_session_id(from, *buf, &sid))
 =
    {
-        struct buffer tmp =3D *buf;
-        buf_advance(&tmp, 1);
-=
        if (!session_id_read(&sid, &tmp) || !session_id_defined(&sid))
-   =
     {
-            msg(D_TLS_ERRORS, "TLS Error: session-id not found in p=
acket from %s",
-                print_link_socket_actual(from, &gc));
-   =
         goto error;
-        }
+        goto error;
     }
 
-    int i;
-=
    /* use session ID to match up packet with appropriate tls_session objec=
t */
-    for (i =3D 0; i < TM_SIZE; ++i)
+    int i =3D pre_decrypt_find_s=
ession(multi, from, &sid);
+    if (i =3D=3D -1)
     {
-        struct tls=
_session *session =3D &multi->session[i];
-        struct key_state *ks =3D=
 &session->key[KS_PRIMARY];
-
-        dmsg(
-            D_TLS_DEBUG,
-   =
         "TLS: initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=
=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s",
-            i, state=
_name(ks->state), session_id_print(&session->session_id, &gc),
-           =
 session_id_print(&sid, &gc), print_link_socket_actual(from, &gc),
-       =
     session_id_print(&ks->session_id_remote, &gc),
-            print_link=
_socket_actual(&ks->remote_addr, &gc));
-
-        if (session_id_equal(&ks=
->session_id_remote, &sid))
-        /* found a match */
-        {
-      =
      if (i =3D=3D TM_LAME_DUCK)
-            {
-                msg(D_TLS_=
ERRORS, "TLS ERROR: received control packet with stale session-id=3D%s",
- =
                   session_id_print(&sid, &gc));
-                goto erro=
r;
-            }
-            dmsg(D_TLS_DEBUG, "TLS: found match, session=
[%d], sid=3D%s", i,
-                 session_id_print(&sid, &gc));
-      =
      break;
-        }
+        goto error;
     }
 
     /*

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7=
c91c53fa0c0
Gerrit-Change-Number: 2175
Gerrit-PatchSet: 1
Gerrit-Owner: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>

--piR7ZIcKWuc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Extract tls_pre_decrypt_extract_session_id and pre_decrypt_fin=
d_session<br><br>These functions fulfil steps that can be easily moved to t=
heir own<br>functions to make tls_pre_decrypt a bit more readable=2E<br><br=
>Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0<br>Signed-off-by: Arn=
e Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 f=
ile changed, 68 insertions(+), 37 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/2175/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><sp=
an>index 3ad7fe7=2E=2E2f13e19 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3765,6 +=
3765,68 @@</span><br><span>     return true;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_pre_decrypt_extra=
ct_session_id(const struct link_socket_actual *from, struct buffer buf, str=
uct session_id *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* skip op co=
de */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advanc=
e(&amp;buf, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!session_id_read(sid, &amp;buf) || !session_id_defined(sid))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_ERROR=
S, &quot;TLS Error: session-id not found in packet from %s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            print_link_socket=
_actual(from, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Find session matching the session id in sid in multi=
=2Esession array</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return index of =
session in multi=2Esession array, TM_SIZE if not found</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *         and -1 on error</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+pre_decrypt_find_session(struct tls_multi *multi, const st=
ruct link_socket_actual *from, struct session_id *sid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* use session ID to match up packet with appr=
opriate tls_session object */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;sessi=
on[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dmsg(</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            D_TLS_DEBUG,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;TLS: initial packet test, i=3D%d state=3D%s=
, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i, =
state_name(ks-&gt;state), session_id_print(&amp;session-&gt;session_id, &am=
p;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
ession_id_print(sid, &amp;gc), print_link_socket_actual(from, &amp;gc),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            session_id_=
print(&amp;ks-&gt;session_id_remote, &amp;gc),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            print_link_socket_actual(&amp;ks-&gt=
;remote_addr, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (se=
ssion_id_equal(&amp;ks-&gt;session_id_remote, sid))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* found a match */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (i =3D=3D TM_LAME_DUCK)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_TLS_ER=
RORS, &quot;TLS ERROR: received control packet with stale session-id=3D%s&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      session_id_print(&amp;sid, &amp;gc));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                i =3D -1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                goto done;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            dmsg(D_TLS_DEBUG, &quot;TLS: fou=
nd match, session[%d], sid=3D%s&quot;, i,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                 session_id_print(&amp;sid, &amp;gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*<=
/span><br><span>  *</span><br><span>  * When we are in TLS mode, this is th=
e first routine which sees</span><br><span>@@ -3820,7 +3882,6 @@</span><br>=
<span>     /* control channel packet */</span><br><span>     bool do_burst =
=3D false;</span><br><span>     bool new_link =3D false;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct session_id sid; /* remote ses=
sion ID */</span><br><span> </span><br><span>     /* verify legal opcode */=
</span><br><span>     if (!tls_pre_decrypt_verify_opcode(op, multi-&gt;opt=
=2Eserver, from))</span><br><span>@@ -3834,46 +3895,16 @@</span><br><span> =
    dmsg(D_TLS_DEBUG, &quot;TLS: control channel, op=3D%s, IP=3D%s&quot;, p=
acket_opcode_name(op),</span><br><span>          print_link_socket_actual(f=
rom, &amp;gc));</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* get remote session-id */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct session_id sid; /* remote session ID */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tls_pre_dec=
rypt_extract_session_id(from, *buf, &amp;sid))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer tmp =
=3D *buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_=
advance(&amp;tmp, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (!session_id_read(&amp;sid, &amp;tmp) || !session_id_defined(&am=
p;sid))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRO=
RS, &quot;TLS Error: session-id not found in packet from %s&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                print_link_soc=
ket_actual(from, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            goto error;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      goto error;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* use session ID to match up packet with app=
ropriate tls_session object */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    for (i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int i =3D pre_decrypt_find_session(multi, f=
rom, &amp;sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (i =3D=3D -1)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct tls_session *session =3D &amp;multi-&gt;se=
ssion[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stru=
ct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        dmsg(</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            D_TLS_DEBUG,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            &quot;TLS: initial packet test, i=3D%d state=3D%s, mysid=
=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            i, state_nam=
e(ks-&gt;state), session_id_print(&amp;session-&gt;session_id, &amp;gc),</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            session_id_p=
rint(&amp;sid, &amp;gc), print_link_socket_actual(from, &amp;gc),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            session_id_print(&a=
mp;ks-&gt;session_id_remote, &amp;gc),</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            print_link_socket_actual(&amp;ks-&gt;remote_ad=
dr, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (session_id_equal=
(&amp;ks-&gt;session_id_remote, &amp;sid))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* found a match */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (i =3D=3D TM_LAME_DUCK)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(D_TLS_ERRORS, &quot;TLS ERROR: =
received control packet with stale session-id=3D%s&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    session_id_print(&a=
mp;sid, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       dmsg(D_TLS_DEBUG, &quot;TLS: found match, session[%d], sid=3D%s&quot=
;, i,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
 session_id_print(&amp;sid, &amp;gc));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto error;</span><br><span>     }</span><br><span> </span><br>=
<span>     /*</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">change 2175</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I230b3b2483e15477b=
179b277dc8f7c91c53fa0c0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2175 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--piR7ZIcKWuc=--


--===============2947979592195309637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2947979592195309637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2947979592195309637==--

