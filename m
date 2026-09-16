Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD4BC982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BIDttY5DeXM0r0jwY4qkBzMrveSEZJu+YT1jVPGNKIw=; b=h9gD+4iNH4PSOheyNVUBbCfNqQ
	I83F/tPDaHjVrRKRHY5xKCU3kvJW3qb7pf/yPp5eQAuXBeqNbO0xrDCUpLAM+cCRU35SMW+5iUQo0
	NS1TOFB2/q9Mr/jaw/duJRRaMdqVpCYeHqGaDHDhEW3cuXjjYMGrdhueGu/s5fSKPZXA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6uOR-000803-Cg;
	Wed, 16 Sep 2026 18:30:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6uOP-0007zv-Gt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 18:30:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OyiOZGiWMJDj//0V30K/nQIGfwu6rHCIDsBbtI5+FhA=; b=jmI0oc/UQAUSHeEx62f44/iOG7
 BzVhMz00l6RRZ1flAOBwIYaDKlT8D4qQZVvbSDcd/mwdzbnkwABvFs6HZInCDVrUjhGDXlV70/99A
 /U/a2f+Gc7WYdo/du+o7Y00f2Ds0cLfioi/dJR37b7q+XkAgyKFzY3YnGZKI0YFFLMsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OyiOZGiWMJDj//0V30K/nQIGfwu6rHCIDsBbtI5+FhA=; b=Z
 HesmnIZTHC3XTnCwVCuDEL37y2B1ptmbN9V7gVmbUvSpf79TQrSm8EeBbZy8us/E+ydIJvASc8+iP
 Hzi9Y5eSOjWunDlcDwnWWQLbh6TDXnifSXO1JR334GbhkW+U16LWGOqIP2BXyM6W9ySt6lhNZRdx6
 XXPJbdaMF5VRidwI=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6uOO-0008VS-51 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 18:30:01 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so197225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789583394; x=1790188194; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OyiOZGiWMJDj//0V30K/nQIGfwu6rHCIDsBbtI5+FhA=;
 b=MHeisCCwaYMKZXUq7miP1/gzJsZlNx27w3h2MCl+cfIczL3mtAT/RSKu+vMODzUgnh
 ZfkSla0v84TCpnhfY8nFtIapXgZzy/MevIwl5cBcsT/FC/cDE0La08LOwjRA1KDXJ758
 zzTWlve9rQ8Y9AsU5EeUJXCHz1xpYp3PbsBvL51JX68GGCHfgFSanGliT4KfeZsV5pXk
 1ZEjBtkqKAaw0qm3Gpcs2Fh1DKqytGNgBodgii/VCcbp53ebZHiRu4fnB6iO/Hsd7/z6
 zu3MVfrUmPIyg9cu8dVrhAyuDT/NLUmmShBTyESyWWb0PNwxT7Zdc33BvyxIuWyIPCpl
 K2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789583394; x=1790188194;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OyiOZGiWMJDj//0V30K/nQIGfwu6rHCIDsBbtI5+FhA=;
 b=wlACrhHAZ2zJhhJittB8RrmAMoQegV6dJeoqNFe08g+QcH5H/lQD2B7gNeSGw6s6b7
 f6RAJwMkvnmPUWxYGLvXdN3stITT1RelQgOeY5Bt9efqkbE7TJagHvvsAo7DTcJfUI/k
 PjvT9PIOCzzmaTfPXFpAqYmBop/89jWY4hK/ha/SD8MpYHNQTTCWsxXGbbddh2oUMSWF
 IVkFv47spcJ8g2MMOgMnm2njvXmqjbO3MJlF5aWT7tt+qUwmueIkgzPEvVoE6V5rDzPd
 K+2TLROK9GFYq86Wyv93FhyLXytVSF3oaPCxo3f9co+d/BcN1HFS8rpaGyJ3zrScDXSc
 PBSg==
X-Gm-Message-State: AFuF++lsPhQmPR9X+Ds7mLnXwg6r0ejDz8E73ngm3c6DExfOXB3m19oc
 sHthXVLI4aNZNQ/gYd07oVVGUtbORpIVLVAb7PsBh7rQ+d+KCneZ2dDN1goKXzfFqsbHvkBAiXm
 61VOgXmdJn7WQ8VYhvssHkWjuT0OYwPbAdOSMZ7CT+xFq6pDGGWtYz2QE5eI25zM1ipuA
X-Gm-Gg: AYBFou2ZJE7J7b1d4OT5MNNbERnuSzTWh39BwOaXa+kjEsIJ7pSioDsRFI3WETUk75Q
 3TIa8PRqstrYpQXWFQBWwV+La0M0CiFq9xkhScJDUOHzG9fgQkeNdoUNh433xMGIXnlNzF2oAGO
 ZrgCBg6cPiAvPflgKmrON8ERaFTDHZY4WKTLY8ovPs4bcI3WltQezGVGrvf3VSCSHubQUGBSN9S
 63FSLG8HmCtb6vJdkKJIT4hsip+9hK2bfixxhTPBhu1PxN2OFyryRaBUrWJsG+XxnK7H1qdeSCv
 LxggD3AUjMuqqiIPWExl02YYkZf4mF1dIhvhw0ANKyl9otwRp0mnETxqaROF/v7RiK9ES9N1Y6x
 bOCxryOXanlLtxOy4avwRGRvbk881EorWmawYKT+iJ61D4pixi0ouze3jiu41mfn/jZ2sC0cvbx
 8bUhx/Zf9mRvDYbBOmPtAYacbF0tNsPcSeKNvz8DEm0ipig9aaO54qmHAFbzGzsBBmoD86OhTkB
 mNLlkcI8W/88INM4l6Qz8wuUQ5Bjo3GPdOiT1xMBFLZEJRHl808T8owzs8gXMxx55JQ/rIG+X73
 Bx8NKHpiyxvtUW3YvPg7F4T4bpOb0RjSPVZiAOTQwxJy1KUhNEwGWnDu4cgfKA==
X-Received: by 2002:a05:600d:8485:10b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49fbc43a0a0mr17794945e9.8.1789583393409; 
 Wed, 16 Sep 2026 11:29:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f98csm8058751f8f.11.2026.09.16.11.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:29:53 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 18:29:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 razvanc <razvanc@mailbox.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: e46f6dafb372f98c8a12147e51aeeab08736c5a5
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad0ffe199888386caf3015b947866b9ffdd998e2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6uOO-0008VS-51
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
Content-Type: multipart/mixed; boundary="===============3475211268581805017=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3475211268581805017==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ee+P/MlNXrI="; charset=UTF-8

--ee+P/MlNXrI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#11) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld, Code-Review+2 by razvanc


Change subject: Make required act=
ion returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make required action returned from=
 pre_decrypt_verdict more explicit

The current code relies on the conditio=
n if state=2Eserver_session_id
is defined to decide if session_skip_to_pre_=
start should be used=2E

Instead explicitly return the intent and use that =
to decide if
session_skip_to_pre_start should be called=2E

Change-Id: Iccd=
d4cfad090c565aac27e16cdaa9871106c2f89
Signed-off-by: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826
Message-Id: <2026091=
5163852=2E3477-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39205=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
1 file=
 changed, 46 insertions(+), 19 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/26/1826/11

diff --git a/src/openvpn/=
mudp=2Ec b/src/openvpn/mudp=2Ec
index de3d467=2E=2E88b0091 100644
--- a/src=
/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -87,9 +87,28 @@
           =
                "Reset packet from client, sending HMAC based reset challen=
ge", sock);
 }
 
+/**
+ * Verdict if this packet should create a new sessio=
n=2E If a packet is invalid
+ * or we send out an HMAC based challenge, we =
do not want to create a new
+ * session=2E
+ */
+enum pre_decrypt_verdict
+=
{
+    /** This packet should not create a new session */
+    PRE_DECRYPT_=
NO_ACTION,
+    /** This packet creates a new session on the first packet o=
n the session=2E
+     * We only do this for legacy tls-crypt-v2 clients th=
at do not work with
+     * the HMAC cookie challenge approach where we nee=
d to keep the client
+     * specific tls-crypt key to be able to decrypt t=
he third packet */
+    PRE_DECRYPT_CREATE_SESSION,
+    /** Creates a new =
session=2E The HMAC challenge has been already completed
+     * and the fi=
rst two packets of the three way handshake are skipped in
+     * the sessi=
on setup */
+    PRE_DECRYPT_CREATE_SESSION_SKIP
+};
 
-/* Returns true if =
this packet should create a new session */
-static bool
+/** Returns a verd=
ict if this packet should create a new session */
+static enum pre_decrypt_=
verdict
 do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decry=
pt_state *state,
                      struct mroute_addr addr, struct link=
_socket *sock)
 {
@@ -111,7 +130,7 @@
          * responses */
         if =
(!reflect_filter_rate_limit_check(m->initial_rate_limiter))
         {
-   =
         return false;
+            return PRE_DECRYPT_NO_ACTION;
         =
}
     }
 
@@ -136,7 +155,7 @@
                 calculate_session_id_hmac(s=
tate->peer_session_id, from, hmac_key, handwindow, 0);
             send_hm=
ac_reset_packet(m, state, tas, &sid, true, sock);
 
-            return fal=
se;
+            return PRE_DECRYPT_NO_ACTION;
         }
         else
   =
      {
@@ -153,11 +172,11 @@
                     "ignoring connection att=
empt from old client (%s)",
                     peer);
                 gc=
_free(&gc);
-                return false;
+                return PRE_DECR=
YPT_NO_ACTION;
             }
             else
             {
-           =
     return true;
+                return PRE_DECRYPT_CREATE_SESSION;
     =
        }
         }
     }
@@ -170,7 +189,7 @@
         send_hmac_reset_pa=
cket(m, state, tas, &sid, false, sock);
 
         /* We have a reply do no=
t create a new session */
-        return false;
+        return PRE_DECRYP=
T_NO_ACTION;
     }
     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 |=
| verdict =3D=3D VERDICT_VALID_ACK_V1
              || verdict =3D=3D VERDI=
CT_VALID_WKC_V1)
@@ -181,6 +200,7 @@
 
         bool pkt_is_ack =3D (verdic=
t =3D=3D VERDICT_VALID_ACK_V1);
         bool ret =3D check_session_hmac_an=
d_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);
+        enum pre_=
decrypt_verdict action =3D PRE_DECRYPT_NO_ACTION;
 
         const char *pe=
er =3D print_link_socket_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t=
 pkt_firstbyte =3D *BPTR(&m->top=2Ec2=2Ebuf);
@@ -198,14 +218,15 @@
       =
          "Valid packet (%s) with HMAC challenge from peer (%s), "
        =
         "accepting new connection=2E",
                 packet_opcode_name=
(op), peer);
+            action =3D PRE_DECRYPT_CREATE_SESSION_SKIP;
     =
    }
         gc_free(&gc);
 
-        return ret;
+        return action;=

     }
 
     /* VERDICT_INVALID */
-    return false;
+    return PRE_DEC=
RYPT_NO_ACTION;
 }
 
 /**
@@ -220,9 +241,6 @@
                           st=
ruct link_socket *sock,
                           struct mroute_addr *real=
)
 {
-    struct hash *hash =3D m->hash;
-    struct tls_pre_decrypt_state =
state =3D { 0 };
-    struct multi_instance *mi =3D NULL;
     struct gc_ar=
ena gc =3D gc_new();
 
     if (m->deferred_shutdown_signal=2Esignal_receiv=
ed)
@@ -231,8 +249,17 @@
             "MULTI: Connection attempt from %s ig=
nored while server is "
             "shutting down",
             mroute_a=
ddr_print(real, &gc));
+        gc_free(&gc);
+        return NULL;
     }
=
-    else if (do_pre_decrypt_check(m, &state, *real, sock))
+
+    struct h=
ash *hash =3D m->hash;
+    struct tls_pre_decrypt_state state =3D { 0 };
+=
    struct multi_instance *mi =3D NULL;
+
+    enum pre_decrypt_verdict ver=
dict =3D do_pre_decrypt_check(m, &state, *real, sock);
+
+    if (verdict !=
=3D PRE_DECRYPT_NO_ACTION)
     {
         /* This is an unknown session bu=
t with valid tls-auth/tls-crypt
          * (or no auth at all)=2E  If this=
 is the initial packet of a
@@ -255,14 +282,14 @@
                 mi->did_=
real_hash =3D true;
                 multi_assign_peer_id(m, mi);
 
-      =
          /* If we have a session id already, ensure that the
-            =
     * state is using the same */
-                if (session_id_defined(&=
state=2Eserver_session_id)
-                    && session_id_defined((&sta=
te=2Epeer_session_id)))
+                struct tls_session *session =3D
+ =
                   &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
+
+ =
               if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)
        =
         {
+                    /* This verdict is only possible if we have=
 a peer session ID */
+                    ASSERT(session_id_defined(&state=
=2Epeer_session_id));
                     mi->context=2Ec2=2Etls_multi->n_=
sessions++;
-                    struct tls_session *session =3D
-         =
               &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
        =
             session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom=
);
                 }
             }

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Gerrit-Change=
-Number: 1826
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--ee+P/MlNXrI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #11</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld, Code-Review+2 by razvanc</p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Make required action returned from pre_decrypt_verdict more explicit<=
br><br>The current code relies on the condition if state=2Eserver_session_i=
d<br>is defined to decide if session_skip_to_pre_start should be used=2E<br=
><br>Instead explicitly return the intent and use that to decide if<br>sess=
ion_skip_to_pre_start should be called=2E<br><br>Change-Id: Iccdd4cfad090c5=
65aac27e16cdaa9871106c2f89<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826<br>Message=
-Id: &lt;20260915163852=2E3477-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39205=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/mudp=2Ec<br>1 file changed, 46 insertions(+), 19 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/26/1826/11</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2E=
c b/src/openvpn/mudp=2Ec</span><br><span>index de3d467=2E=2E88b0091 100644<=
/span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvp=
n/mudp=2Ec</span><br><span>@@ -87,9 +87,28 @@</span><br><span>             =
              &quot;Reset packet from client, sending HMAC based reset chal=
lenge&quot;, sock);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Verdict if this packet should create a new session=
=2E If a packet is invalid</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * or we send out an HMAC based challenge, we do not want to create =
a new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * session=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+enum pre_decrypt_verdict</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /** This packet should not create a new sessi=
on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYP=
T_NO_ACTION,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**=
 This packet creates a new session on the first packet on the session=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * We only do this=
 for legacy tls-crypt-v2 clients that do not work with</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * the HMAC cookie challenge approac=
h where we need to keep the client</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * specific tls-crypt key to be able to decrypt the thir=
d packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_=
DECRYPT_CREATE_SESSION,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /** Creates a new session=2E The HMAC challenge has been already co=
mpleted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and t=
he first two packets of the three way handshake are skipped in</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * the session setup */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT_CREATE_S=
ESSION_SKIP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Return=
s true if this packet should create a new session */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/** Returns a verdict if this packet should create =
a new session */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic enum pre_decrypt_verdict</span><br><span> do_pre_decrypt_check(struct m=
ulti_context *m, struct tls_pre_decrypt_state *state,</span><br><span>     =
                 struct mroute_addr addr, struct link_socket *sock)</span><=
br><span> {</span><br><span>@@ -111,7 +130,7 @@</span><br><span>          *=
 responses */</span><br><span>         if (!reflect_filter_rate_limit_check=
(m-&gt;initial_rate_limiter))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_=
ACTION;</span><br><span>         }</span><br><span>     }</span><br><span> =
</span><br><span>@@ -136,7 +155,7 @@</span><br><span>                 calcu=
late_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow,=
 0);</span><br><span>             send_hmac_reset_packet(m, state, tas, &am=
p;sid, true, sock);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;</span><br><=
span>         }</span><br><span>         else</span><br><span>         {</s=
pan><br><span>@@ -153,11 +172,11 @@</span><br><span>                     &q=
uot;ignoring connection attempt from old client (%s)&quot;,</span><br><span=
>                     peer);</span><br><span>                 gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         return PRE_DECRYPT_NO_ACTION;</span><br><span>             }</span=
><br><span>             else</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                return PRE_D=
ECRYPT_CREATE_SESSION;</span><br><span>             }</span><br><span>     =
    }</span><br><span>     }</span><br><span>@@ -170,7 +189,7 @@</span><br>=
<span>         send_hmac_reset_packet(m, state, tas, &amp;sid, false, sock)=
;</span><br><span> </span><br><span>         /* We have a reply do not crea=
te a new session */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return PRE_DECRYPT_NO_ACTION;</span><br><span>     }</span><br><spa=
n>     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verdict =3D=3D V=
ERDICT_VALID_ACK_V1</span><br><span>              || verdict =3D=3D VERDICT=
_VALID_WKC_V1)</span><br><span>@@ -181,6 +200,7 @@</span><br><span> </span>=
<br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1=
);</span><br><span>         bool ret =3D check_session_hmac_and_pkt_id(stat=
e, from, hmac_key, handwindow, pkt_is_ack);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        enum pre_decrypt_verdict action =3D PRE_DEC=
RYPT_NO_ACTION;</span><br><span> </span><br><span>         const char *peer=
 =3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc);</span><=
br><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebuf=
);</span><br><span>@@ -198,14 +218,15 @@</span><br><span>                 &=
quot;Valid packet (%s) with HMAC challenge from peer (%s), &quot;</span><br=
><span>                 &quot;accepting new connection=2E&quot;,</span><br>=
<span>                 packet_opcode_name(op), peer);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            action =3D PRE_DECRYPT_CREATE=
_SESSION_SKIP;</span><br><span>         }</span><br><span>         gc_free(=
&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return ret;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return action;</span><br><span>     }</span><br><span> </span=
><br><span>     /* VERDICT_INVALID */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return PRE_DECRYPT_NO_ACTION;</span><br><span> }</span><b=
r><span> </span><br><span> /**</span><br><span>@@ -220,9 +241,6 @@</span><b=
r><span>                           struct link_socket *sock,</span><br><spa=
n>                           struct mroute_addr *real)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D NULL;</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>=
     if (m-&gt;deferred_shutdown_signal=2Esignal_received)</span><br><span>=
@@ -231,8 +249,17 @@</span><br><span>             &quot;MULTI: Connection a=
ttempt from %s ignored while server is &quot;</span><br><span>             =
&quot;shutting down&quot;,</span><br><span>             mroute_addr_print(r=
eal, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return NULL;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (do_pre_decrypt_check(m, &amp;state, *r=
eal, sock))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =3D m=
-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct multi_instance *mi =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    enum pre_decrypt_verdict verdict =3D do_pre_decry=
pt_check(m, &amp;state, *real, sock);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (verdict !=3D PRE_DECRYPT_NO_ACTION)</span><br><span>     {</span><br=
><span>         /* This is an unknown session but with valid tls-auth/tls-c=
rypt</span><br><span>          * (or no auth at all)=2E  If this is the ini=
tial packet of a</span><br><span>@@ -255,14 +282,14 @@</span><br><span>    =
             mi-&gt;did_real_hash =3D true;</span><br><span>               =
  multi_assign_peer_id(m, mi);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                /* If we have a session id alrea=
dy, ensure that the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               * state is using the same */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                if (session_id_defined(&amp;state=2Es=
erver_session_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                &amp;&amp; session_id_defined((&amp;state=2Epeer_session_id=
)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
struct tls_session *session =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;se=
ssion[TM_INITIAL];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (=
verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)</span><br><span>           =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        /* This verdict is only possible if we have a peer session ID */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    AS=
SERT(session_id_defined(&amp;state=2Epeer_session_id));</span><br><span>   =
                  mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    struct tl=
s_session *session =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[T=
M_INITIAL];</span><br><span>                     session_skip_to_pre_start(=
session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span>         =
        }</span><br><span>             }</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?=
usp=3Demail">change 1826</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1826?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1826 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerri=
t-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--ee+P/MlNXrI=--


--===============3475211268581805017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3475211268581805017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3475211268581805017==--

