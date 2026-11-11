Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C4606A338
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J2fi2lha;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JjCJymi4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ds2RuFW1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bDUmcGCG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kv10tPZ1/uFhSHUHKqvyZVF71bT9JZmZ4x6VaR5LhOM=; b=J2fi2lhal44tnbHrCt1izUz6H5
	4jLJImDRBqkJvNBo9eWlD+hh9T04GxcAm4iXPs5Vhd/zR2QKB2uVw+JorEiiGW1tXoDyx3KPv+oaH
	gTTt0ZgqLRwYt1nV09y6EbmceEqEbF5VNLrLYvNzWLAq5i2+mVaaTcY/er6vornEIDP4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR7S7-00000000419-49G9;
	Wed, 11 Nov 2026 12:29:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR7S7-0000000040y-0Nc3
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 12:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C9SrTgD9kSgF3s/CkKWF8nP1qvLABdJI0+qSnoQ7pfs=; b=JjCJymi4bhqn4187ipUgk92cwC
 K7ExCStwXjObPMXS3ybB7azrSSQ8YNhqUrLfMc1MQlozQciJfl4Auvc1r4SbZS/gQRZK5kBtLCweC
 WGkNXXUDsXlsAow5QKd1dmiA3wZ9RHPUHp0Cl+K1f4k+comLY/YJcUtL4dF4eFQppne8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C9SrTgD9kSgF3s/CkKWF8nP1qvLABdJI0+qSnoQ7pfs=; b=ds2RuFW13jSIoOd2fmErHcmFXS
 +nf151nODjLUfB9qLTja7ep/xRpqsMvd7Mg1D9t5P9iRzFz3uoQEZUIKcp2otF8gwl9gd/Rp4nEUU
 q6X1C85LrTlNfpslJxndcdsFr9zfEmLrJMO+udcSXX929pfGgucUuJwtQ5JqCaN9Iv8I=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR7S5-0000000052g-2Ett for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 12:29:23 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so31353185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 04:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794400155; x=1795004955; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C9SrTgD9kSgF3s/CkKWF8nP1qvLABdJI0+qSnoQ7pfs=;
 b=bDUmcGCGi0o/0xT8swQ5F3UWiDDnwE9q/Ht/sosDOdWIspOmWHQq906APG19AnORtm
 FoFCwZvIt2RkYpyOxXWf/n9W8bEzKec2eHUzsvaaGToIpTRxXHftvoj/x2ANs/diq4fK
 9K64lRkZ9UVkoPdmkXE8f1tkvgC9F0wAXTA2reXhsyGsIFCtAax27/y6IL9uoxgOAeBu
 nltOqS7Ks1KMIHQKKXx3T9oM6CoNJ6++j7sd5L6lSXNKPTjNRkKEiYN0v+gVX05SyM9G
 2kp2rZqg9DPU7ZpiY0IK1wkZZmufdzCkO/HbEytElIyxpOdpvCTSWVTy9by4cRrPAqn9
 ytGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794400155; x=1795004955;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C9SrTgD9kSgF3s/CkKWF8nP1qvLABdJI0+qSnoQ7pfs=;
 b=TrOeU3lY3q5jWXVTxR9ImdItGUe41sBNHXfVyA5Jh7Eak54GdngdX8FCeQATYXTuAM
 CVM45uj7bQb8MMN2GwDqIBa0iFETWEyLhnNb25vYkcpUuKbzMre40rH7SXxrDJ8RRPJo
 /58i2FdMwV1HYxUZxGhUaoPP8AOCkslGzc0odZrnBjW06zffYTnzOh7WDQlwK4v/zHOw
 eGJJ1zsr9i3edgjWUW2hszOKU79rPqjrVuyPj0vN3iojt9gX5Wev7oM5GUec1r08tLYE
 BXsmgryX9fTDyT9Ss82UKnq6bw0Z7xV4PVq2la+oRT4atYwJjDW8wWdErmfOrT37GIKq
 L8HA==
X-Gm-Message-State: APuU4Z8LpfbWH7J3NBBYUYKnzmjVCD34/AmC6/We5S9zAWDp6vpd9KGb
 My1u9HLd+z/54C4m0NNIoK5JznSUCsGGauXdvSbsPCFLlGcBmfuEPD3e+wpsed0QfW3WOUHwaMf
 MwDzopK5MKD95kQbv7sC2INUCn336DxAKWV1HOVChMhgqGlZ4m/8KIPffMt24LyYHieMU3mU9OA
 XYv9ZWcA==
X-Gm-Gg: AYBFou0xLtNjirhrCIkq1BqjXmia8pBYEWeoq9DdgCVPaEvYbqO1YUQC7tyWcX6L2aX
 NxYr6kVmGqf60f2txg9cBjTyBAYZ6RHd4XiVxlGkI1CLa88/LzRmC7QpgzAIOnCquby1cp5miFs
 pEUi1wSBAYg9Jhja2fB+0/fQe1KXOIPA18eiKlX3HwLG9Kw95WdAMJ+Pt/Si2QZE3XaubBucgRn
 hswcGZaz/EM7eztTC3rAu48wNoGkx8r2pxCi+/+2lSZJ179w6bMdvxNx7d3foVAQrx56Gy/OYvI
 04j2vXzJWunPsTQH1kkpgEk6ff1/Wq/yVMlAogOrwfGzkXKRMVwrcDbm1Ihs7DoU1JVPGjuWXB0
 cDB9EpIL47Z1tf85uF/SvOK3aMFn1OFDPIgSH4aIYhxpl3gIv3oY5Oavx2leZii0S+8GOs3RF5e
 a/YcWgVl1BX2gC4nWeMXC1wK2+YhF2rFdL1w4YNbYanwdMne6q+e3o1lrpK1y6Slz0BYlvelUXG
 UQdDsQyu3kIRZr4J1/a/DUuVaCAF9oPpizP28VOCOCrMmGO1eeOvYMjuQ+dgO57+phBFOcX3QoK
 g0370MZscaIv0F6KR7c7Pf61o0fqOwOy4zM4hSOgWOEEAHMa6zGCoGuubWA5q6Gzho8UGfFX3ni
 avZ1zblypChJktwoVqt0zc+e/+56TWxaKdgwZGCKazir9s9tHYDsEccYQ493BRanOnhUCwFImA0
 9dURZ6wy4jh9D+/h4=
X-Received: by 2002:a05:600c:3b88:b0:4b8:d17e:da27 with SMTP id
 5b1f17b1804b1-4ba093c51a8mr48185795e9.27.1794400154729; 
 Wed, 11 Nov 2026 04:29:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe63e6sm215763835e9.7.2026.11.11.04.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 04:29:14 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 12:29:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 0ffe080f1b9cebead744a2b185351866d2d6a46e
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f620267679b41f6ec8c6fe90ed4697b85dbd234a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR7S5-0000000052g-2Ett
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
Content-Type: multipart/mixed; boundary="===============1154015859275096785=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1154015859275096785==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K4uAk2bMd/E="; charset=UTF-8

--K4uAk2bMd/E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#2)=2E ( https://gerrit=2Eopenvp=
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
hanged, 68 insertions(+), 37 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/75/2175/2

diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 3ad7fe7=2E=2E17d99ad 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3765,6 +3765,68 @@
     return tr=
ue;
 }
 
+static bool
+tls_pre_decrypt_extract_session_id(const struct link=
_socket_actual *from, struct buffer buf, struct session_id *sid)
+{
+    /*=
 skip op code */
+    buf_advance(&buf, 1);
+    if (!session_id_read(sid, =
&buf) || !session_id_defined(sid))
+    {
+        struct gc_arena gc =3D g=
c_new();
+        msg(D_TLS_ERRORS, "TLS Error: session-id not found in pac=
ket from %s",
+            print_link_socket_actual(from, &gc));
+        g=
c_free(&gc);
+        return false;
+    }
+    return true;
+}
+
+/**
+ * =
 Find session matching the session id in sid in multi=2Esession array
+ *
+=
 * @return index of session in multi=2Esession array, TM_SIZE if not found
=
+ *         and -1 on error
+ */
+static int
+pre_decrypt_find_session(stru=
ct tls_multi *multi, const struct link_socket_actual *from, struct session_=
id *sid)
+{
+    struct gc_arena gc =3D gc_new();
+    int i;
+    /* use s=
ession ID to match up packet with appropriate tls_session object */
+    fo=
r (i =3D 0; i < TM_SIZE; ++i)
+    {
+        struct tls_session *session =
=3D &multi->session[i];
+        struct key_state *ks =3D &session->key[KS_=
PRIMARY];
+
+        dmsg(
+            D_TLS_DEBUG,
+            "TLS: ini=
tial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s,=
 stored-sid=3D%s, stored-ip=3D%s",
+            i, state_name(ks->state), s=
ession_id_print(&session->session_id, &gc),
+            session_id_print(s=
id, &gc), print_link_socket_actual(from, &gc),
+            session_id_prin=
t(&ks->session_id_remote, &gc),
+            print_link_socket_actual(&ks->=
remote_addr, &gc));
+
+        if (session_id_equal(&ks->session_id_remote,=
 sid))
+        /* found a match */
+        {
+            if (i =3D=3D TM=
_LAME_DUCK)
+            {
+                msg(D_TLS_ERRORS, "TLS ERROR: r=
eceived control packet with stale session-id=3D%s",
+                    se=
ssion_id_print(sid, &gc));
+                i =3D -1;
+                goto=
 done;
+            }
+            dmsg(D_TLS_DEBUG, "TLS: found match, ses=
sion[%d], sid=3D%s", i,
+                 session_id_print(sid, &gc));
+   =
         break;
+        }
+    }
+
+done:
+    gc_free(&gc);
+    return i=
;
+}
+
 /*
  *
  * When we are in TLS mode, this is the first routine which=
 sees
@@ -3820,7 +3882,6 @@
     /* control channel packet */
     bool do_=
burst =3D false;
     bool new_link =3D false;
-    struct session_id sid; =
/* remote session ID */
 
     /* verify legal opcode */
     if (!tls_pre_=
decrypt_verify_opcode(op, multi->opt=2Eserver, from))
@@ -3834,46 +3895,16 =
@@
     dmsg(D_TLS_DEBUG, "TLS: control channel, op=3D%s, IP=3D%s", packet_=
opcode_name(op),
          print_link_socket_actual(from, &gc));
 
-    /* =
get remote session-id */
+    struct session_id sid; /* remote session ID *=
/
+    if (!tls_pre_decrypt_extract_session_id(from, *buf, &sid))
     {
- =
       struct buffer tmp =3D *buf;
-        buf_advance(&tmp, 1);
-        =
if (!session_id_read(&sid, &tmp) || !session_id_defined(&sid))
-        {
-=
            msg(D_TLS_ERRORS, "TLS Error: session-id not found in packet fr=
om %s",
-                print_link_socket_actual(from, &gc));
-           =
 goto error;
-        }
+        goto error;
     }
 
-    int i;
-    /* u=
se session ID to match up packet with appropriate tls_session object */
-  =
  for (i =3D 0; i < TM_SIZE; ++i)
+    int i =3D pre_decrypt_find_session(m=
ulti, from, &sid);
+    if (i =3D=3D -1)
     {
-        struct tls_session=
 *session =3D &multi->session[i];
-        struct key_state *ks =3D &sessio=
n->key[KS_PRIMARY];
-
-        dmsg(
-            D_TLS_DEBUG,
-           =
 "TLS: initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, re=
c-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s",
-            i, state_name(ks-=
>state), session_id_print(&session->session_id, &gc),
-            session_=
id_print(&sid, &gc), print_link_socket_actual(from, &gc),
-            sess=
ion_id_print(&ks->session_id_remote, &gc),
-            print_link_socket_a=
ctual(&ks->remote_addr, &gc));
-
-        if (session_id_equal(&ks->session=
_id_remote, &sid))
-        /* found a match */
-        {
-            if =
(i =3D=3D TM_LAME_DUCK)
-            {
-                msg(D_TLS_ERRORS, "=
TLS ERROR: received control packet with stale session-id=3D%s",
-          =
          session_id_print(&sid, &gc));
-                goto error;
-     =
       }
-            dmsg(D_TLS_DEBUG, "TLS: found match, session[%d], sid=
=3D%s", i,
-                 session_id_print(&sid, &gc));
-            bre=
ak;
-        }
+        goto error;
     }
 
     /*

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53f=
a0c0
Gerrit-Change-Number: 2175
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--K4uAk2bMd/E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Extract tls_pre_decrypt_extract_session_id and pre_decrypt_fi=
nd_session<br><br>These functions fulfil steps that can be easily moved to =
their own<br>functions to make tls_pre_decrypt a bit more readable=2E<br><b=
r>Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 =
file changed, 68 insertions(+), 37 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/2175/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><s=
pan>index 3ad7fe7=2E=2E17d99ad 100644</span><br><span>--- a/src/openvpn/ssl=
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
      session_id_print(sid, &amp;gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                i =3D -1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            dmsg(D_TLS_DEBUG, &quot;TLS: found =
match, session[%d], sid=3D%s&quot;, i,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                 session_id_print(sid, &amp;gc));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br>=
<span>  *</span><br><span>  * When we are in TLS mode, this is the first ro=
utine which sees</span><br><span>@@ -3820,7 +3882,6 @@</span><br><span>    =
 /* control channel packet */</span><br><span>     bool do_burst =3D false;=
</span><br><span>     bool new_link =3D false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct session_id sid; /* remote session ID */=
</span><br><span> </span><br><span>     /* verify legal opcode */</span><br=
><span>     if (!tls_pre_decrypt_verify_opcode(op, multi-&gt;opt=2Eserver, =
from))</span><br><span>@@ -3834,46 +3895,16 @@</span><br><span>     dmsg(D_=
TLS_DEBUG, &quot;TLS: control channel, op=3D%s, IP=3D%s&quot;, packet_opcod=
e_name(op),</span><br><span>          print_link_socket_actual(from, &amp;g=
c));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* get remote session-id */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct session_id sid; /* remote session ID */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!tls_pre_decrypt_extrac=
t_session_id(from, *buf, &amp;sid))</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        struct buffer tmp =3D *buf;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_advance(&amp=
;tmp, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!session_id_read(&amp;sid, &amp;tmp) || !session_id_defined(&amp;sid))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TL=
S Error: session-id not found in packet from %s&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                print_link_socket_actual(f=
rom, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto e=
rror;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* use session ID to match up packet with appropriate tls=
_session object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int i =3D pre_decrypt_find_session(multi, from, &amp;si=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (i =3D=3D=
 -1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct tls_session *session =3D &amp;multi-&gt;session[i];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct key_state=
 *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        dmsg(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    D_TLS_DEBUG,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       &quot;TLS: initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-s=
id=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            i, state_name(ks-&gt;sta=
te), session_id_print(&amp;session-&gt;session_id, &amp;gc),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            session_id_print(&amp;si=
d, &amp;gc), print_link_socket_actual(from, &amp;gc),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            session_id_print(&amp;ks-&gt;se=
ssion_id_remote, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            print_link_socket_actual(&amp;ks-&gt;remote_addr, &amp;gc)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (session_id_equal(&amp;ks-&gt=
;session_id_remote, &amp;sid))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        /* found a match */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (i =3D=3D TM_LAME_DUCK)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                msg(D_TLS_ERRORS, &quot;TLS ERROR: received con=
trol packet with stale session-id=3D%s&quot;,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    session_id_print(&amp;sid, &amp=
;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(=
D_TLS_DEBUG, &quot;TLS: found match, session[%d], sid=3D%s&quot;, i,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                 session_id_=
print(&amp;sid, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto error;</span><br><span>     }</span><br><span> </span><br><span>     /=
*</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2175?usp=3Demail">change 2175</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7=
c91c53fa0c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2175 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--K4uAk2bMd/E=--


--===============1154015859275096785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1154015859275096785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1154015859275096785==--

