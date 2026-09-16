Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213E2C88E7F
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1+1xgRy8Sg7HYtVZyP1hmwMwJdjgB5EdC7rdLmCmtw=; b=fRIzUoTUwrbwDDwrEUxOdSR1fo
	6acLlp+x3fSanPl6vxYh0PGjHIBlJ2j8OMrAdo9vVgcMY7rc0Fkg15BRoQDkcSOfYczR1loZlKroj
	XmcWeV8Qm+82EN+7sombunDWOAH5q2zgb+un/PCOfRsSpNHn7Brp9KD44reb/nIodvLs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6uOU-0006ZT-A9;
	Wed, 16 Sep 2026 18:30:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6uOR-0006ZM-RM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 18:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mStRxXGvcoKX8fJu1Zrc0wzvFw0MrAu77gtmVHVuQNQ=; b=fOKqaQp8Z8WZFJTf59Jjsmyzs8
 Hqsqug0/Lfk00m3W+9/QpreqLjpd5ptYBzBgDVLp4RObNY4TPg7AHmCciz3Gjhdkx6zAq/f+UAE/2
 S7B1PUP3WiMAokkDfmot5j8QXoTs+zU8mL78y4v7wHN4ciShzu2Kdm5gSX9C6KkjSLiQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mStRxXGvcoKX8fJu1Zrc0wzvFw0MrAu77gtmVHVuQNQ=; b=S
 5Ls7LcY0+HQiCupK3Dk6GQQej2BjUyQpRq5CmWdpc7tYZN4p+2XD4monfiVXmGrHstOm5zXQMeeVQ
 cTBW685ZHWKEp3ADI/rFKSKW43QBVUsLzwNb/PHDu5ajnvZe7vF2xu3gIkYYYNHc0tNgQsDr3+gV8
 SafUpTobF9znJYZ8=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6uOO-0004la-U2 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 18:30:03 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso196575e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789583394; x=1790188194; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mStRxXGvcoKX8fJu1Zrc0wzvFw0MrAu77gtmVHVuQNQ=;
 b=L86jZD3h4ObrqdJROSc/Wqad/stcPZkViVZCXEyup6oH84ifY+l0oAAIZP6VuY7VUl
 5Ma6OMwNW9PpUCuWHaBXztH18HNOTfDPnwHzCDi4kxgCq/p9+NaVNJjh41t9IrrqSruB
 h/Bf7TeGflFwDnvk0Y9R0/WPgcADW5PhD6KuYNUM6NyMCBIWgpIHVooF/luR5xYUu73J
 k16Qb1HZAN9Dw+Kp4euHYRa5GPSD7ngis6Xj/a3qmindhHIsFPWmIP+MxYWtUdUSmuks
 B74AEgWg0qS1OjvH6iWbXdvO1e0R+d6zIDE+OkPUeKMs3ViFTpC+BWlq6GK4TzaZb+zf
 EO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789583394; x=1790188194;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mStRxXGvcoKX8fJu1Zrc0wzvFw0MrAu77gtmVHVuQNQ=;
 b=NXKtttK2ie4QHCY7pKkts61YOpFd+a23rMdrHbECs+AS1zR/FX5aOlcOwCwVVBQw5z
 fW7GEnq4feP09V7nRUbiHnNRCFRXSe1OFhysSIgnejWN3DCxWCorSnFtyyeetn2sGVaF
 AJEIe3sdym0lcUzA1S8NmL8Y3K8YlTlljO9mAabXPx/1+3UuJZaXr99Fj6bvTBbdGmMg
 vCFfQ2IVtJu88beAIP49L5b2lj6j0TWEezY2FMxmTWomxJ3vtgSXmqMbC5+A1pz1qlVa
 orYKZAz3TYkmdv0iSq5NorzPT2FlzLJ6iF4EKwLSsYqWU1nrHrjM/45u4lUbDlOyW5hC
 LRVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdfDYIQU3WR+J3LckxXnxqMEhuXIdQvxtTp6P8Rr7No1qMDZ41A75iTgFEcqZH53RPA9oAGygreYnZzryC@lists.sourceforge.net
X-Gm-Message-State: AFuF++k93V28Zs3ofxHbnf2unlBIUT2WSZUKYi8vsaZJb+AjDymhI62j
 DKhjb2AziDHFKFHDl+k35DZL8kEFMhTJ28FdZA5x/Zz/OI/fxvE7MaFE+N5hCuSvgBWuJ0DsQ0L
 0SKzCJh/p2kXusdAPcpXO62a2qQP/H6B5anxbJDb+qtAFh2iwmOw1vDyVBZHgj/jHd06J
X-Gm-Gg: AYBFou0UtRNFrtsT0WoWRb1O6klvqJv1YIV9u8KxkqiaauKQ3rsgVnMQ8W/toFme/3m
 PZcbDpwGW+lJ8u91Pz/pzgVJrPjn15OJRW8qXVDWUOFLuM8KD+cRqjA0LaQD3lyiu5iewmyTC5V
 MTcchfLeViiyh7NfnMqLg5EIlqalIX06q3ErHSbs4Gw0x90ZXnNVjGLz1jrQiEuNU1nFn7lSSS0
 3VxcGdYOxsonJ+9Rzqq4zRQVLz1aGLyk52Qre/QQjl+la0AaKNuOnyarPqWPeNZR97u4D7xAqgF
 Xfdo6PR6JwxwU+pL4bd+vLc9aBSimmRBDPKRmpETEhG8jpcA0hqZ7cBAaVh4Os8dv+NOWXH7XeU
 uajDhb9OdFkzr4jOIOF0gGUstx57NjjfGElCSFznosZEr3iagMmx+rYLSF0gN6RPKanzzPgWwtp
 8d+LMtj5bWtcd+9PtSTLhH48LgS27U+WnzX2ZQFIsqQTnKcbFeWI+ydv+yuziSmgAq08JaEVJXn
 R7xcuQz1JvXV8OGDkxglDWKNff1DtDyvUbpCFLuWw9JOE+Rp5fRhM9B8G/RHNRDHhwfBiZYjUO/
 8xOHBE0wGLSL4NtKUfuaz+yBvxLtgn68xeYXpQ1FmscqS0/yIvY1S8stLZSCaVSBOcsbwSum
X-Received: by 2002:a05:600c:8b61:b0:49e:6891:27a8 with SMTP id
 5b1f17b1804b1-49eb732e411mr41416895e9.25.1789583394219; 
 Wed, 16 Sep 2026 11:29:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1d0d0bsm11233315e9.1.2026.09.16.11.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:29:53 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 18:29:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: e46f6dafb372f98c8a12147e51aeeab08736c5a5
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad0ffe199888386caf3015b947866b9ffdd998e2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6uOO-0004la-U2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6005826610056294440=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6005826610056294440==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RdeVWEB32i8="; charset=UTF-8

--RdeVWEB32i8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1826?usp=3Demail )

Change subject: Make required action returned from =
pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Make required action returned from pre_decrypt_verdi=
ct more explicit

The current code relies on the condition if state=2Eserve=
r_session_id
is defined to decide if session_skip_to_pre_start should be us=
ed=2E

Instead explicitly return the intent and use that to decide if
sessi=
on_skip_to_pre_start should be called=2E

Change-Id: Iccdd4cfad090c565aac27=
e16cdaa9871106c2f89
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1826
Message-Id: <20260915163852=2E3477-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg39205=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
1 file changed, 46 inserti=
ons(+), 19 deletions(-)




diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec
index de3d467=2E=2E88b0091 100644
--- a/src/openvpn/mudp=2Ec
+++ =
b/src/openvpn/mudp=2Ec
@@ -87,9 +87,28 @@
                           "Reset=
 packet from client, sending HMAC based reset challenge", sock);
 }
 
+/**
=
+ * Verdict if this packet should create a new session=2E If a packet is in=
valid
+ * or we send out an HMAC based challenge, we do not want to create =
a new
+ * session=2E
+ */
+enum pre_decrypt_verdict
+{
+    /** This packet=
 should not create a new session */
+    PRE_DECRYPT_NO_ACTION,
+    /** Th=
is packet creates a new session on the first packet on the session=2E
+    =
 * We only do this for legacy tls-crypt-v2 clients that do not work with
+ =
    * the HMAC cookie challenge approach where we need to keep the client
+=
     * specific tls-crypt key to be able to decrypt the third packet */
+  =
  PRE_DECRYPT_CREATE_SESSION,
+    /** Creates a new session=2E The HMAC ch=
allenge has been already completed
+     * and the first two packets of the=
 three way handshake are skipped in
+     * the session setup */
+    PRE_D=
ECRYPT_CREATE_SESSION_SKIP
+};
 
-/* Returns true if this packet should cre=
ate a new session */
-static bool
+/** Returns a verdict if this packet sho=
uld create a new session */
+static enum pre_decrypt_verdict
 do_pre_decryp=
t_check(struct multi_context *m, struct tls_pre_decrypt_state *state,
     =
                 struct mroute_addr addr, struct link_socket *sock)
 {
@@ -=
111,7 +130,7 @@
          * responses */
         if (!reflect_filter_rate_=
limit_check(m->initial_rate_limiter))
         {
-            return false;=

+            return PRE_DECRYPT_NO_ACTION;
         }
     }
 
@@ -136,7 +=
155,7 @@
                 calculate_session_id_hmac(state->peer_session_id,=
 from, hmac_key, handwindow, 0);
             send_hmac_reset_packet(m, sta=
te, tas, &sid, true, sock);
 
-            return false;
+            retur=
n PRE_DECRYPT_NO_ACTION;
         }
         else
         {
@@ -153,11 +17=
2,11 @@
                     "ignoring connection attempt from old client (=
%s)",
                     peer);
                 gc_free(&gc);
-         =
       return false;
+                return PRE_DECRYPT_NO_ACTION;
       =
      }
             else
             {
-                return true;
+   =
             return PRE_DECRYPT_CREATE_SESSION;
             }
         }
 =
    }
@@ -170,7 +189,7 @@
         send_hmac_reset_packet(m, state, tas, &s=
id, false, sock);
 
         /* We have a reply do not create a new session=
 */
-        return false;
+        return PRE_DECRYPT_NO_ACTION;
     }
  =
   else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verdict =3D=3D VERDI=
CT_VALID_ACK_V1
              || verdict =3D=3D VERDICT_VALID_WKC_V1)
@@ -1=
81,6 +200,7 @@
 
         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID=
_ACK_V1);
         bool ret =3D check_session_hmac_and_pkt_id(state, from, =
hmac_key, handwindow, pkt_is_ack);
+        enum pre_decrypt_verdict action=
 =3D PRE_DECRYPT_NO_ACTION;
 
         const char *peer =3D print_link_sock=
et_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t pkt_firstbyte =3D *BP=
TR(&m->top=2Ec2=2Ebuf);
@@ -198,14 +218,15 @@
                 "Valid packe=
t (%s) with HMAC challenge from peer (%s), "
                 "accepting ne=
w connection=2E",
                 packet_opcode_name(op), peer);
+        =
    action =3D PRE_DECRYPT_CREATE_SESSION_SKIP;
         }
         gc_free=
(&gc);
 
-        return ret;
+        return action;
     }
 
     /* VERD=
ICT_INVALID */
-    return false;
+    return PRE_DECRYPT_NO_ACTION;
 }
 
 =
/**
@@ -220,9 +241,6 @@
                           struct link_socket *sock=
,
                           struct mroute_addr *real)
 {
-    struct hash =
*hash =3D m->hash;
-    struct tls_pre_decrypt_state state =3D { 0 };
-    =
struct multi_instance *mi =3D NULL;
     struct gc_arena gc =3D gc_new();
 =

     if (m->deferred_shutdown_signal=2Esignal_received)
@@ -231,8 +249,17 =
@@
             "MULTI: Connection attempt from %s ignored while server is =
"
             "shutting down",
             mroute_addr_print(real, &gc));=

+        gc_free(&gc);
+        return NULL;
     }
-    else if (do_pre_d=
ecrypt_check(m, &state, *real, sock))
+
+    struct hash *hash =3D m->hash;=

+    struct tls_pre_decrypt_state state =3D { 0 };
+    struct multi_insta=
nce *mi =3D NULL;
+
+    enum pre_decrypt_verdict verdict =3D do_pre_decryp=
t_check(m, &state, *real, sock);
+
+    if (verdict !=3D PRE_DECRYPT_NO_ACT=
ION)
     {
         /* This is an unknown session but with valid tls-auth/=
tls-crypt
          * (or no auth at all)=2E  If this is the initial packet=
 of a
@@ -255,14 +282,14 @@
                 mi->did_real_hash =3D true;
  =
               multi_assign_peer_id(m, mi);
 
-                /* If we hav=
e a session id already, ensure that the
-                 * state is using =
the same */
-                if (session_id_defined(&state=2Eserver_session=
_id)
-                    && session_id_defined((&state=2Epeer_session_id))=
)
+                struct tls_session *session =3D
+                    &mi=
->context=2Ec2=2Etls_multi->session[TM_INITIAL];
+
+                if (ver=
dict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)
                 {
+          =
          /* This verdict is only possible if we have a peer session ID */
=
+                    ASSERT(session_id_defined(&state=2Epeer_session_id));
=
                     mi->context=2Ec2=2Etls_multi->n_sessions++;
-         =
           struct tls_session *session =3D
-                        &mi->co=
ntext=2Ec2=2Etls_multi->session[TM_INITIAL];
                     session_s=
kip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
                 }
=
             }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1826?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: mer=
ged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4c=
fad090c565aac27e16cdaa9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchS=
et: 11
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--RdeVWEB32i8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1826?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Make required action returned from pre_dec=
rypt_verdict more explicit<br><br>The current code relies on the condition =
if state=2Eserver_session_id<br>is defined to decide if session_skip_to_pre=
_start should be used=2E<br><br>Instead explicitly return the intent and us=
e that to decide if<br>session_skip_to_pre_start should be called=2E<br><br=
>Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89<br>Signed-off-by: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1826<br>Message-Id: &lt;20260915163852=2E3477-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39205=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 file changed=
, 46 insertions(+), 19 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index de3d467=2E=2E88b00=
91 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/=
src/openvpn/mudp=2Ec</span><br><span>@@ -87,9 +87,28 @@</span><br><span>   =
                        &quot;Reset packet from client, sending HMAC based =
reset challenge&quot;, sock);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Verdict if this packet should create a ne=
w session=2E If a packet is invalid</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * or we send out an HMAC based challenge, we do not want t=
o create a new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * se=
ssion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+enum pre_decrypt_verdict</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /** This packet should not create a =
new session */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    P=
RE_DECRYPT_NO_ACTION,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /** This packet creates a new session on the first packet on the sess=
ion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * We onl=
y do this for legacy tls-crypt-v2 clients that do not work with</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * the HMAC cookie challeng=
e approach where we need to keep the client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * specific tls-crypt key to be able to decrypt=
 the third packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    PRE_DECRYPT_CREATE_SESSION,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /** Creates a new session=2E The HMAC challenge has been a=
lready completed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * and the first two packets of the three way handshake are skipped in</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the session setu=
p */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT=
_CREATE_SESSION_SKIP</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/* Returns true if this packet should create a new session */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** Returns a verdict if this packet shou=
ld create a new session */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static enum pre_decrypt_verdict</span><br><span> do_pre_decrypt_chec=
k(struct multi_context *m, struct tls_pre_decrypt_state *state,</span><br><=
span>                      struct mroute_addr addr, struct link_socket *soc=
k)</span><br><span> {</span><br><span>@@ -111,7 +130,7 @@</span><br><span> =
         * responses */</span><br><span>         if (!reflect_filter_rate_l=
imit_check(m-&gt;initial_rate_limiter))</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return PRE_D=
ECRYPT_NO_ACTION;</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span>@@ -136,7 +155,7 @@</span><br><span>            =
     calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, h=
andwindow, 0);</span><br><span>             send_hmac_reset_packet(m, state=
, tas, &amp;sid, true, sock);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;=
</span><br><span>         }</span><br><span>         else</span><br><span> =
        {</span><br><span>@@ -153,11 +172,11 @@</span><br><span>           =
          &quot;ignoring connection attempt from old client (%s)&quot;,</sp=
an><br><span>                     peer);</span><br><span>                 g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                return PRE_DECRYPT_NO_ACTION;</span><br><span>        =
     }</span><br><span>             else</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
return PRE_DECRYPT_CREATE_SESSION;</span><br><span>             }</span><br=
><span>         }</span><br><span>     }</span><br><span>@@ -170,7 +189,7 @=
@</span><br><span>         send_hmac_reset_packet(m, state, tas, &amp;sid, =
false, sock);</span><br><span> </span><br><span>         /* We have a reply=
 do not create a new session */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return PRE_DECRYPT_NO_ACTION;</span><br><span>     }</s=
pan><br><span>     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verd=
ict =3D=3D VERDICT_VALID_ACK_V1</span><br><span>              || verdict =
=3D=3D VERDICT_VALID_WKC_V1)</span><br><span>@@ -181,6 +200,7 @@</span><br>=
<span> </span><br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDIC=
T_VALID_ACK_V1);</span><br><span>         bool ret =3D check_session_hmac_a=
nd_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        enum pre_decrypt_verdict acti=
on =3D PRE_DECRYPT_NO_ACTION;</span><br><span> </span><br><span>         co=
nst char *peer =3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &am=
p;gc);</span><br><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;=
top=2Ec2=2Ebuf);</span><br><span>@@ -198,14 +218,15 @@</span><br><span>    =
             &quot;Valid packet (%s) with HMAC challenge from peer (%s), &q=
uot;</span><br><span>                 &quot;accepting new connection=2E&quo=
t;,</span><br><span>                 packet_opcode_name(op), peer);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            action =3D PRE_=
DECRYPT_CREATE_SESSION_SKIP;</span><br><span>         }</span><br><span>   =
      gc_free(&amp;gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return action;</span><br><span>     }</span><br=
><span> </span><br><span>     /* VERDICT_INVALID */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return PRE_DECRYPT_NO_ACTION;</span><br><=
span> }</span><br><span> </span><br><span> /**</span><br><span>@@ -220,9 +2=
41,6 @@</span><br><span>                           struct link_socket *sock=
,</span><br><span>                           struct mroute_addr *real)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D NULL=
;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </=
span><br><span>     if (m-&gt;deferred_shutdown_signal=2Esignal_received)</=
span><br><span>@@ -231,8 +249,17 @@</span><br><span>             &quot;MULT=
I: Connection attempt from %s ignored while server is &quot;</span><br><spa=
n>             &quot;shutting down&quot;,</span><br><span>             mrou=
te_addr_print(real, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return NULL;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else if (do_pre_decrypt_check(m,=
 &amp;state, *real, sock))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct h=
ash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    enum pre_decrypt_verdict verdict =
=3D do_pre_decrypt_check(m, &amp;state, *real, sock);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (verdict !=3D PRE_DECRYPT_NO_ACTION)</span><br><span>=
     {</span><br><span>         /* This is an unknown session but with vali=
d tls-auth/tls-crypt</span><br><span>          * (or no auth at all)=2E  If=
 this is the initial packet of a</span><br><span>@@ -255,14 +282,14 @@</spa=
n><br><span>                 mi-&gt;did_real_hash =3D true;</span><br><span=
>                 multi_assign_peer_id(m, mi);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                /* If we have a =
session id already, ensure that the</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                 * state is using the same */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (session_id_define=
d(&amp;state=2Eserver_session_id)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    &amp;&amp; session_id_defined((&amp;state=
=2Epeer_session_id)))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                struct tls_session *session =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    &amp;mi-&gt;context=2Ec2=
=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)</span><b=
r><span>                 {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    /* This verdict is only possible if we have a pe=
er session ID */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 ASSERT(session_id_defined(&amp;state=2Epeer_session_id));<=
/span><br><span>                     mi-&gt;context=2Ec2=2Etls_multi-&gt;n_=
sessions++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          struct tls_session *session =3D</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        &amp;mi-&gt;context=2Ec2=2Etls_=
multi-&gt;session[TM_INITIAL];</span><br><span>                     session=
_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span>=
<br><span>                 }</span><br><span>             }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1826?usp=3Demail">change 1826</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106=
c2f89 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1826 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>

</body></html>
--RdeVWEB32i8=--


--===============6005826610056294440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6005826610056294440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6005826610056294440==--

