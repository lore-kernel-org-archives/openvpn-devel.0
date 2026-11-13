Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B3606BD3B
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KJxaNJKG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VvyrfJdz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XyZOngZZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AJzs6LXP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ks1+lARPUqxZCAlJ/wk/+C5Olj+YJzTEC7oyrInbwt0=; b=KJxaNJKGr2hDohpcrfWLSaDnPd
	ri5ykacozw5IKTgijoAUiGd7LcStBdnxdIq+0ZUFXgPmTI0Y6BRKWDviHWxF1/cdOYDZyOyV6YOa6
	4Yh0c0wu7sSc+RD7q9MSAx5x+hZ2zLP/kPgJ8bnxqGH3Za+tWUSXyCkA+W7OY9POER6M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRvKm-000000000O8-1pE0;
	Fri, 13 Nov 2026 17:45:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRvKk-000000000Nv-1nyA
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:45:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zU8C8GbiBATMr8RSNZZCUGn49peiYVqgG6iDdfNh1lw=; b=VvyrfJdz7KWugNn/aTOkK24Y4P
 hUU3Gmy9lOq26/LWPmh3TUUK081FjmgZCwhK469vFiTsAQ32BY/OhvbMQolCN9ojJhax/BvZkU3VF
 lh2RmVJB7R5ngN3r/lx8gOi6Et20J6LSpjoC26uM+8yBnJ/wVaFIiGf0uWJIKlnYenvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zU8C8GbiBATMr8RSNZZCUGn49peiYVqgG6iDdfNh1lw=; b=XyZOngZZoc3i9pdH1sNE4+DH0M
 sNVBNoXW085BD1wBR9raUFBZmB2RjN3nEtJ6I+jnnR8NFi2+1r/XbUVeSQXwPkwQtoBciS/ms737o
 fu8JEchC38q0R6/SQ/xaNfdB7SRpQUJiERVsET7MuDZD26J+Kl+8T+MRmzawVMWiU4/I=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRvKh-000000002TB-2TkT for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:45:06 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so13561925e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 09:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794591897; x=1795196697; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zU8C8GbiBATMr8RSNZZCUGn49peiYVqgG6iDdfNh1lw=;
 b=AJzs6LXPnIPtUOcOmE23eSywoQ+zUjpVR3Cqlc1X2CIohkQZ38KbYAHr8SAggxkryF
 p7AdHPup1vzkJ8/OaCYgvuODv/nrRab7uIu2zNCet/f69pPBkv4JfGEKnUSoJFxkGtK2
 twmWWyLOs3imKjmAWbYJ8I0f1omcxD8SnusPLUvJsgDEMp64X9SLzuap/a8TLXEZYVVx
 sCbyKfK455+JtlvumaI93bV+QzxcMjs7uFd3Xp7Zmwef8XO1KAdVVTQQNZi2EG3cHr8I
 MC908Wr0gDN7QzFTC9DOch0YZbXVzYEpd96rlGWfih0sJERzmwD3qZmp9sUBQo+Hg7F+
 B4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591897; x=1795196697;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zU8C8GbiBATMr8RSNZZCUGn49peiYVqgG6iDdfNh1lw=;
 b=gRLj2GKGWD7DSAEf1xRFO54t626zh+zVajc/k9OoiBkpGzQoPeWF6N3yXX6kJHSCIF
 9whY3hJfg62fQ56s9hf0gxz7tR4VYdvK7VQu3znMAPWFu5Rr4g6HuTLJuKe3KyzA1u65
 H3vfv65tHWmrM7cat21DSuw35e5x/K/SERuBF8ERySGRYZrz/xenTFhvGmclYGGeKZQd
 IV1ZX5pcC2NP9Rsrsfd31f+Cl7FD2KVq62QrVEzP+9Xr596Iu0a2k70bTGSZ3kgJhip3
 zf3ClwFbMPb49aj4NIjQQH0c426Ohmm16gajIc7iIO8nxX3TYiJJyyUjpUFtCXtX2LE9
 mEog==
X-Forwarded-Encrypted: i=1;
 AL+hErGSZ6Jgjajv8bA+D1e5/wZ0vEfGGKmdct4+s2BFRtL1qINKMyGcT79XJepHl2OCAZ9mmZq1WjaobI5tNgwu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9WeqtfSCFzTAj424/i1BtzJz1DUe6DCt2px6EcYVl9Dd/Zwj7o
 H3b20AsDNZx37DbafXT/lrafLxo1p8UCr71HsmRhEoQFaCQHVYcUo5cAWaX+RdOGOE6O60nvxng
 XPDP4OR2xksg6A0MBghqIm9CoZiv5ywgC6cT/5rLLUZQu/h8shuPjS8oQyEeDaO/OTg3ies7ZaO
 T6J2Ejfw==
X-Gm-Gg: AYBFou0T4bdmweb3yb2a4ZndwSygmk5ObyDBEsSv3WqCoXhlfgAPLZWXUC1pak32IGX
 Ev5tvfk6KJzkz7ImhvRefKPAVQQfNpFuOk3qo7bbwesKqqpAx0UtgE4G7wF9J88QUZ5xeCLd/9G
 JiMt4YQ3R9lIVyfHBTqestpE1Fk4zxwfJ5c8QsYlZrEhSvCEqczuQUhSvf8pLzLZuKPl74lFzzz
 sAzRZxNE+JIR2gJRaLWmy9c9QEfMlp2LbzuKNu1qrsom5mPN+7RczQ6WKvVhc7AHST0zdoxEvbD
 wfzXepPjRkbLt0CPbFQQ1Iv3AkfyhzhvFlGFSxTGCFsV0XbD7TgrCSwZCWzsn32CeEffeZjiFqk
 SUQE4epxx9WMM9r7WEPILBPYj7HvLMDgdjzpGUc6WtvD5CBXz3IDipSpDMOndMpYH+uDUvg2Ds9
 0Kxw51uvLHpj7Zbkvod751QxakJHfcTUNQrepAo4V+oEIikjw9egmRBeo/4R9LwTxAHv4ak8g+z
 siUvc2PnL+vNN1vmMjUGi9a97chIAa52qGwaAB1cQhpsdzxvk6RB5KY4F09eD9L2vEeipg9VoLo
 XbCc7iwMIH4hMoBYGT33yXAhoVpdRk+7ECAF6t9+g8EXpFxR2v8esHrTVnX7neIRpPy0AMFx8dG
 OUujY2UgL/hBmUsjge5yjjRBXC/ArZY6ooXvLgKLxO2lQvSAHbDPVlFcNmRJqRbGKyqfx0neo7W
 1H55qYkzHHefIzvTebh40VzJ+cAv0vlvrpoYf+
X-Received: by 2002:a05:600c:3acf:b0:4ba:4395:560f with SMTP id
 5b1f17b1804b1-4bb55a70e39mr75705885e9.8.1794591896735; 
 Fri, 13 Nov 2026 09:44:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571d7e87sm47322325e9.3.2026.11.13.09.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:44:56 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 17:44:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 2a6784b2e2ae52b53379945fc5a88fb33a30142d
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1cdb13ca2bdaff21e4de94e96dea5be0ecb9a36c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRvKh-000000002TB-2TkT
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2750823754934349964=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2750823754934349964==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+NmRmoWzRJw="; charset=UTF-8

--+NmRmoWzRJw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2175?usp=3Demail )

Change subject: Extract tls_pre_decrypt_ext=
ract_session_id and pre_decrypt_find_session
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract tls_pre_decrypt_extract_session_id =
and pre_decrypt_find_session

These functions fulfil steps that can be easi=
ly moved to their own
functions to make tls_pre_decrypt a bit more readable=
=2E

Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175
Message=
-Id: <20261113104930=2E25197-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41246=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=
=2Ec
1 file changed, 76 insertions(+), 37 deletions(-)




diff --git a/src=
/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index f91f226=2E=2E7721b55 100644
--=
- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3765,6 +3765,76 @@
  =
   return true;
 }
 
+/**
+ * Read the session form the packet buffer buf a=
nd puts it into the
+ * parameter sid=2E
+ *
+ * @return true if the extrac=
tion was successful, false otherwise
+ */
+static bool
+tls_pre_decrypt_ext=
ract_session_id(const struct link_socket_actual *from,
+                   =
                struct buffer buf, struct session_id *sid)
+{
+    /* skip =
op code */
+    buf_advance(&buf, 1);
+    if (!session_id_read(sid, &buf) =
|| !session_id_defined(sid))
+    {
+        struct gc_arena gc =3D gc_new(=
);
+        msg(D_TLS_ERRORS, "TLS Error: session-id not found in packet fr=
om %s",
+            print_link_socket_actual(from, &gc));
+        gc_free=
(&gc);
+        return false;
+    }
+    return true;
+}
+
+/**
+ *  Find =
session matching the session id in sid in multi=2Esession array
+ *
+ * @re=
turn index of session in multi=2Esession array, TM_SIZE if not found
+ *   =
      and -1 on error
+ */
+static int
+tls_pre_decrypt_find_session(struct=
 tls_multi *multi, const struct link_socket_actual *from,
+                =
             const struct session_id *sid)
+{
+    struct gc_arena gc =3D g=
c_new();
+    int i;
+    /* use session ID to match up packet with appropr=
iate tls_session object */
+    for (i =3D 0; i < TM_SIZE; ++i)
+    {
+   =
     struct tls_session *session =3D &multi->session[i];
+        struct ke=
y_state *ks =3D &session->key[KS_PRIMARY];
+
+        dmsg(
+            D_=
TLS_DEBUG,
+            "TLS: initial packet test, i=3D%d state=3D%s, mysid=
=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s",
+      =
      i, state_name(ks->state), session_id_print(&session->session_id, &gc)=
,
+            session_id_print(sid, &gc), print_link_socket_actual(from, &=
gc),
+            session_id_print(&ks->session_id_remote, &gc),
+         =
   print_link_socket_actual(&ks->remote_addr, &gc));
+
+        if (session=
_id_equal(&ks->session_id_remote, sid))
+        /* found a match */
+     =
   {
+            if (i =3D=3D TM_LAME_DUCK)
+            {
+              =
  msg(D_TLS_ERRORS, "TLS ERROR: received control packet with stale session-=
id=3D%s",
+                    session_id_print(sid, &gc));
+              =
  i =3D -1;
+                goto done;
+            }
+            dmsg(D_=
TLS_DEBUG, "TLS: found match, session[%d], sid=3D%s", i,
+                 =
session_id_print(sid, &gc));
+            break;
+        }
+    }
+
+done:=

+    gc_free(&gc);
+    return i;
+}
+
 /*
  *
  * When we are in TLS mode=
, this is the first routine which sees
@@ -3820,7 +3890,6 @@
     /* contro=
l channel packet */
     bool do_burst =3D false;
     bool new_link =3D fa=
lse;
-    struct session_id sid; /* remote session ID */
 
     /* verify l=
egal opcode */
     if (!tls_pre_decrypt_verify_opcode(op, multi->opt=2Eser=
ver, from))
@@ -3834,46 +3903,16 @@
     dmsg(D_TLS_DEBUG, "TLS: control ch=
annel, op=3D%s, IP=3D%s", packet_opcode_name(op),
          print_link_sock=
et_actual(from, &gc));
 
-    /* get remote session-id */
+    struct sessi=
on_id sid; /* remote session ID */
+    if (!tls_pre_decrypt_extract_sessio=
n_id(from, *buf, &sid))
     {
-        struct buffer tmp =3D *buf;
-      =
  buf_advance(&tmp, 1);
-        if (!session_id_read(&sid, &tmp) || !sessi=
on_id_defined(&sid))
-        {
-            msg(D_TLS_ERRORS, "TLS Error: =
session-id not found in packet from %s",
-                print_link_socket=
_actual(from, &gc));
-            goto error;
-        }
+        goto erro=
r;
     }
 
-    int i;
-    /* use session ID to match up packet with appr=
opriate tls_session object */
-    for (i =3D 0; i < TM_SIZE; ++i)
+    int=
 i =3D tls_pre_decrypt_find_session(multi, from, &sid);
+    if (i =3D=3D -=
1)
     {
-        struct tls_session *session =3D &multi->session[i];
-   =
     struct key_state *ks =3D &session->key[KS_PRIMARY];
-
-        dmsg(
-=
            D_TLS_DEBUG,
-            "TLS: initial packet test, i=3D%d sta=
te=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=
=3D%s",
-            i, state_name(ks->state), session_id_print(&session->s=
ession_id, &gc),
-            session_id_print(&sid, &gc), print_link_socke=
t_actual(from, &gc),
-            session_id_print(&ks->session_id_remote, =
&gc),
-            print_link_socket_actual(&ks->remote_addr, &gc));
-
-   =
     if (session_id_equal(&ks->session_id_remote, &sid))
-        /* found =
a match */
-        {
-            if (i =3D=3D TM_LAME_DUCK)
-            =
{
-                msg(D_TLS_ERRORS, "TLS ERROR: received control packet wi=
th stale session-id=3D%s",
-                    session_id_print(&sid, &gc)=
);
-                goto error;
-            }
-            dmsg(D_TLS_DEBU=
G, "TLS: found match, session[%d], sid=3D%s", i,
-                 session_=
id_print(&sid, &gc));
-            break;
-        }
+        goto error;
 =
    }
 
     /*

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2175?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I230=
b3b2483e15477b179b277dc8f7c91c53fa0c0
Gerrit-Change-Number: 2175
Gerrit-Pat=
chSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--+NmRmoWzRJw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Extract tls_pre_decrypt_extract_se=
ssion_id and pre_decrypt_find_session<br><br>These functions fulfil steps t=
hat can be easily moved to their own<br>functions to make tls_pre_decrypt a=
 bit more readable=2E<br><br>Change-Id: I230b3b2483e15477b179b277dc8f7c91c5=
3fa0c0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2175<br>Message-Id: &lt;20261113104930=2E25=
197-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg41246=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec=
<br>1 file changed, 76 insertions(+), 37 deletions(-)<br><br></pre>
<pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index f9=
1f226=2E=2E7721b55 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><=
br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3765,6 +3765,76 @@</=
span><br><span>     return true;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Read the session form the packet buffe=
r buf and puts it into the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * parameter sid=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 true if the extraction was successful, false otherwise</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tls_pre_decrypt_extract_session_id(const struct link_socket_act=
ual *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                          struct buffer buf, struct session_id *sid)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* skip op code */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_advance(&amp;buf, 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!session_id_read(sid, &=
amp;buf) || !session_id_defined(sid))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_TLS_ERRORS, &quot;TLS Error: session=
-id not found in packet from %s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            print_link_socket_actual(from, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Find =
session matching the session id in sid in multi=2Esession array</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return index of session in multi=2Esession a=
rray, TM_SIZE if not found</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *         and -1 on error</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_pre_dec=
rypt_find_session(struct tls_multi *multi, const struct link_socket_actual =
*from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                const struct session_id *sid)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* use session ID to match up packet with appropriate t=
ls_session object */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct tls_session *session =3D &amp;multi-&gt;session[i];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct key_sta=
te *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        dmsg(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            D_TLS_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;TLS: initial packet test, i=3D%d state=3D%s, mysid=
=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            i, state_n=
ame(ks-&gt;state), session_id_print(&amp;session-&gt;session_id, &amp;gc),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            session_=
id_print(sid, &amp;gc), print_link_socket_actual(from, &amp;gc),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            session_id_print(&=
amp;ks-&gt;session_id_remote, &amp;gc),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            print_link_socket_actual(&amp;ks-&gt;remote=
_addr, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session_i=
d_equal(&amp;ks-&gt;session_id_remote, sid))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* found a match */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (i =3D=3D TM_LAME_DUCK)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                msg(D_TLS_ERRORS, &quo=
t;TLS ERROR: received control packet with stale session-id=3D%s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    sess=
ion_id_print(sid, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                i =3D -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                goto done;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            dmsg(D_TLS_DEBUG, &quot;TLS: found match, sessi=
on[%d], sid=3D%s&quot;, i,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                 session_id_print(sid, &amp;gc));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return i;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  *<=
/span><br><span>  * When we are in TLS mode, this is the first routine whic=
h sees</span><br><span>@@ -3820,7 +3890,6 @@</span><br><span>     /* contro=
l channel packet */</span><br><span>     bool do_burst =3D false;</span><br=
><span>     bool new_link =3D false;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct session_id sid; /* remote session ID */</span><br=
><span> </span><br><span>     /* verify legal opcode */</span><br><span>   =
  if (!tls_pre_decrypt_verify_opcode(op, multi-&gt;opt=2Eserver, from))</sp=
an><br><span>@@ -3834,46 +3903,16 @@</span><br><span>     dmsg(D_TLS_DEBUG,=
 &quot;TLS: control channel, op=3D%s, IP=3D%s&quot;, packet_opcode_name(op)=
,</span><br><span>          print_link_socket_actual(from, &amp;gc));</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ge=
t remote session-id */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct session_id sid; /* remote session ID */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!tls_pre_decrypt_extract_session_=
id(from, *buf, &amp;sid))</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        struct buffer tmp =3D *buf;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf_advance(&amp;tmp, 1);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!session_i=
d_read(&amp;sid, &amp;tmp) || !session_id_defined(&amp;sid))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TLS Error: s=
ession-id not found in packet from %s&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                print_link_socket_actual(from, &amp;=
gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto=
 error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* use session ID to match up packet with appropriate tls_session o=
bject */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; TM_SIZE; ++i)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int i =3D tls_pre_decrypt_find_session(multi, from, &amp;sid);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (i =3D=3D -1)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct tls_session *session =3D &amp;multi-&gt;session[i];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        struct key_state *ks=
 =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    dmsg(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
D_TLS_DEBUG,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   &quot;TLS: initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=
=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            i, state_name(ks-&gt;state=
), session_id_print(&amp;session-&gt;session_id, &amp;gc),</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            session_id_print(&amp;sid,=
 &amp;gc), print_link_socket_actual(from, &amp;gc),</span><br><span style=
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
ssageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c5=
3fa0c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2175 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--+NmRmoWzRJw=--


--===============2750823754934349964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2750823754934349964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2750823754934349964==--

