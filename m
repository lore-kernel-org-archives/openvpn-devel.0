Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D20C5DF67
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BAmeszCmTS0KYpQKir6G95owLvbVMcJQuLgYE4QdttQ=; b=PCtQbi0fKhiAndHsmOOGs4YW1z
	kU0sdB+AAx70bOLiNe+9M8B0C9NAhzhMLs9/tZbPkgyz5kbXh5Bsj3iQWQjRZE8vJ7+JdXX68MWsy
	PIQvqoNE5F5bXFVacx2G5yYLUxlNu/3R+2s9lmXGIi0gtvPhWfFU3ca7US7DFFiE2CDs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuqXA-0005D8-Bm;
	Fri, 14 Aug 2026 11:57:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuqWp-0005Ca-QU
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vGz3NLuwDMW1sMZzOhtabMlltDQnkbIdtVutndd9fmo=; b=eZQjDHllwpRdV0mxBQl2f7s5ei
 Mv38jbJE5dT/ENoQbe8Uo75aXy6MFmRXZ4PEYNvvYSjbojlLxOJyjKM9Nis0Ma6i11p78Fs2se2ul
 k3nvXywljbdDDbv/2VrwZjfroR4VgUSZfHz3xwwl4irQ5SAAr3uNZaspNuI6I8DcN7Xg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vGz3NLuwDMW1sMZzOhtabMlltDQnkbIdtVutndd9fmo=; b=d
 V8MfDjjfjaKPHrLXZZhM3mHucvSW+IlLKH9smVCcB24m5raxYSgfUv7Xprm8W32W7bOHnQBvDVNL4
 TOp5tpCmTztYfekfo7O/FAx4EJPpswGEgJwXW3v8RhKjYz19VdS9HIz5gUZr/6dk7kKggvpI16you
 fbmCmdjvgfYASqNg=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuqWj-0005qS-0i for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:43 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so9871635e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786708595; x=1787313395; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vGz3NLuwDMW1sMZzOhtabMlltDQnkbIdtVutndd9fmo=;
 b=ImtdZKjpNtmn6RaU73Z6P8avRPJhknbwcxiKFCykJdHoAA8T/peIfbqOfOzAd4ld3R
 qiwPlitORfdSlcPxSgThUg8iQ01XAAsr1NbxOuGBrAfxiIlmp/orWhQsZqxnGCeOaOkT
 9tvHPKTwmh+CnQtjisc+0vT6bbr37aQYrttjqFoGhVRne952JWM6mgnRLaS96ICwgTd7
 207FSuUeOTQffUYBF9i1vgdMSzohow1ia4BvL4RjnNY5zPeeEt8OKqrpG/MAFL7Jt2pr
 pBReHGyiZpEdUalXfJDpPDRlmT5N/2H4T7nJqw+wOFYKcr4796VMfrbQpkdrbje4mafq
 gB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786708595; x=1787313395;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vGz3NLuwDMW1sMZzOhtabMlltDQnkbIdtVutndd9fmo=;
 b=d7Zgo+ypdZQndXGUBiNdwEuViq1HDBFf5zf4ys+xzJOGFmVNyC8ScxtvWc58PievJC
 AG7CPaK7I5RaVKEgv/tBkvazLfUk5coQtrOAWku7yKUJ1XWl4uooraBFeWm5qK7/fjT9
 ElpBxqLr4QtBQ5FJpPuomfz3wvY5gXpg1C1q9apoLKyvfmJhNe/9nJS7PVi64d0D5vrH
 YukrxVpWiWUk0jxvYffSFeyLgwhLokUfOjqVzDEte8lPryOpXIad3rf7NFxcKs9vGfuF
 sQ/jv+eWNKmoa9PvHb9VvNVkJSYPRLa1qMwCMBylR/GWnVTOw3eDk5+TXqLjKCXEFoL3
 Q6IQ==
X-Gm-Message-State: AOJu0Yx2rUHfbuzy1ix7xVPZj8Qg1IJgUIQ/Cob0OD7OXonKZgHjF47G
 zXnc/TFM6G459NsrrtSbzVdRzgz09llLUb17WHkqU/qAHwFnx6heHAsuEgk2tPbTJepPRuwSvQb
 5cQqHp2lqU8C+UiEcisYs0cxiwXUwYdNTXC//8blsOrT+/t645iTrBTncb05XYgzKR9jGLIBsjO
 IfUYagaA==
X-Gm-Gg: AR+sD10Df8CMs3NYDiTOXfWuJ2/HBG2ZVNfjFzg5jC8AY9y4dPpNnrWbvwNSxoRzy3b
 3GHk9q3yhlUb6/gXSueE3Dh1b8xRG3JujnfFANDiEB49c9PsPnjbXrHYJhge3QXymOnUk89pcZH
 F2TRMBJhWDlBDm8hBregy4lfxqeOTEkE2dEnm0pbjz3LRcQfvZTvnIvyDJ8gzzuqZRL4JlhGY0j
 zrozuSOw/KLk6a0BBPwI66mJiH5ct0biLAmvNGVQwRqUPP+d4dg17DHDZK5wt/KOdsWF/lBH9Q3
 3Fn5bSabrI+CEe4uHh9zKk7JsZI0bE8BerNWL7DhgIIxN6/8ON/+tqzqCFZSzSV9EHHiGSW4d4v
 CjaAEbkz/7YAObEyIOWy4j64fEVHKLxm7rOV0HXDA6M7C3i+WFza4i7KzlSR5ihjbJyLtlrkDWm
 bBPadUpWXylc6Pa1ekle+6sRlwqG8XXLMJFx4zzKoAVAMXYEib2E8TKZ446wDiVxQb+szEjjrAz
 oC7cX19Gs35J7G9zsX35GJZJpZ3iyUwvP9jqTc26jc5oDCNhGES+MAtygcrsUthl9XsLB4+fqS3
 BIMuDTtksQRzLxWJPAaL6exzuhWlfqfvOFNvL372FF79eFDcgx4=
X-Received: by 2002:a05:600c:4f52:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-4998793dafcmr78469455e9.7.1786708594790; 
 Fri, 14 Aug 2026 04:56:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988adfb67sm49673655e9.3.2026.08.14.04.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:56:34 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:56:29 +0000
To: flichtenheld <frank@lichtenheld.com>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: fde394d23dc191ee47c023fbf3ffeb230e1f2101
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a7504eebbc9737cdf64d1dbe48edee3cec21ec1a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuqWj-0005qS-0i
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6465961125355847240=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6465961125355847240==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HX6RnGzNmTg="; charset=UTF-8

--HX6RnGzNmTg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, stipa, 

I'd like you to reexamine a change=2E Please vis=
it

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail

to look=
 at the new patch set (#7)=2E

The following approvals got outdated and wer=
e removed:
Code-Review-1 by stipa


Change subject: Make required action re=
turned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make required action returned from pre_d=
ecrypt_verdict more explicit

The current code relies on the condition if s=
tate=2Eserver_session_id
is defined to decided if session_skip_to_pre_start=
 should be used=2E

Instead explicitly return the intent and use that to de=
cide if
session_skip_to_pre_start should be called=2E

Change-Id: Iccdd4cfa=
d090c565aac27e16cdaa9871106c2f89
---
M src/openvpn/mudp=2Ec
1 file changed,=
 44 insertions(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/26/1826/7

diff --git a/src/openvpn/mudp=2Ec b=
/src/openvpn/mudp=2Ec
index 632b064=2E=2Ef588515 100644
--- a/src/openvpn/m=
udp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -87,9 +87,24 @@
                     =
      "Reset packet from client, sending HMAC based reset challenge", sock)=
;
 }
 
+/**
+ * Verdict if this packet should create a new session=2E If a =
packet is invalid
+ * or we send out an HMAC based challenge, we do not wan=
t to create a new
+ * session=2E
+ */
+enum pre_decrypt_verdict
+{
+    /**=
 This packet should not create a new session */
+    PRE_DECRYPT_NO_ACTION,=

+    /** This packet creates a new session normally */
+    PRE_DECRYPT_CR=
EATE_SESSION,
+    /** Create a new session but skip the first two packets =
of
+     * the three way handshake */
+    PRE_DECRYPT_CREATE_SESSION_SKIP
=
+};
 
-/* Returns true if this packet should create a new session */
-stati=
c bool
+/** Returns a verdict if this packet should create a new session */=

+static enum pre_decrypt_verdict
 do_pre_decrypt_check(struct multi_contex=
t *m, struct tls_pre_decrypt_state *state,
                      struct mro=
ute_addr addr, struct link_socket *sock)
 {
@@ -111,7 +126,7 @@
          *=
 responses */
         if (!reflect_filter_rate_limit_check(m->initial_rate=
_limiter))
         {
-            return false;
+            return PRE_DE=
CRYPT_NO_ACTION;
         }
     }
 
@@ -136,7 +151,7 @@
                 c=
alculate_session_id_hmac(state->peer_session_id, from, hmac_key, handwindow=
, 0);
             send_hmac_reset_packet(m, state, tas, &sid, true, sock);=

 
-            return false;
+            return PRE_DECRYPT_NO_ACTION;
  =
       }
         else
         {
@@ -153,11 +168,11 @@
                   =
  "ignoring connection attempt from old client (%s)",
                     =
peer);
                 gc_free(&gc);
-                return false;
+     =
           return PRE_DECRYPT_NO_ACTION;
             }
             else
 =
            {
-                return true;
+                return PRE_DEC=
RYPT_CREATE_SESSION;
             }
         }
     }
@@ -170,7 +185,7 @@
 =
        send_hmac_reset_packet(m, state, tas, &sid, false, sock);
 
       =
  /* We have a reply do not create a new session */
-        return false;
=
+        return PRE_DECRYPT_NO_ACTION;
     }
     else if (verdict =3D=3D =
VERDICT_VALID_CONTROL_V1 || verdict =3D=3D VERDICT_VALID_ACK_V1
           =
   || verdict =3D=3D VERDICT_VALID_WKC_V1)
@@ -181,6 +196,7 @@
 
         b=
ool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
         bool ret=
 =3D check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_i=
s_ack);
+        enum pre_decrypt_verdict action =3D PRE_DECRYPT_NO_ACTION;=

 
         const char *peer =3D print_link_socket_actual(&m->top=2Ec2=2Efr=
om, &gc);
         uint8_t pkt_firstbyte =3D *BPTR(&m->top=2Ec2=2Ebuf);
@@ =
-198,14 +214,16 @@
                 "Valid packet (%s) with HMAC challenge =
from peer (%s), "
                 "accepting new connection=2E",
         =
        packet_opcode_name(op), peer);
+            action =3D PRE_DECRYPT_=
CREATE_SESSION_SKIP;
+
         }
         gc_free(&gc);
 
-        return =
ret;
+        return action;
     }
 
     /* VERDICT_INVALID */
-    retur=
n false;
+    return PRE_DECRYPT_NO_ACTION;
 }
 
 /**
@@ -220,9 +238,6 @@
 =
                          struct link_socket *sock,
                       =
    struct mroute_addr *real)
 {
-    struct hash *hash =3D m->hash;
-    s=
truct tls_pre_decrypt_state state =3D { 0 };
-    struct multi_instance *mi=
 =3D NULL;
     struct gc_arena gc =3D gc_new();
 
     if (m->deferred_shu=
tdown_signal=2Esignal_received)
@@ -231,8 +246,17 @@
             "MULTI: C=
onnection attempt from %s ignored while server is "
             "shutting =
down",
             mroute_addr_print(real, &gc));
+        gc_free(&gc);
+=
        return NULL;
     }
-    else if (do_pre_decrypt_check(m, &state, *=
real, sock))
+
+    struct hash *hash =3D m->hash;
+    struct tls_pre_decr=
ypt_state state =3D { 0 };
+    struct multi_instance *mi =3D NULL;
+
+    =
enum pre_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &state, *real,=
 sock);
+
+    if (verdict !=3D PRE_DECRYPT_NO_ACTION)
     {
         /* T=
his is an unknown session but with valid tls-auth/tls-crypt
          * (or=
 no auth at all)=2E  If this is the initial packet of a
@@ -257,13 +281,16 =
@@
 
                 /* If we have a session id already, ensure that the
 =
                 * state is using the same */
-                if (session_=
id_defined(&state=2Eserver_session_id)
-                    && session_id_d=
efined((&state=2Epeer_session_id)))
+                if (session_id_defined=
((&state=2Epeer_session_id)))
                 {
-                    mi->c=
ontext=2Ec2=2Etls_multi->n_sessions++;
                     struct tls_sess=
ion *session =3D
                         &mi->context=2Ec2=2Etls_multi->se=
ssion[TM_INITIAL];
-                    session_skip_to_pre_start(session, =
&state, &m->top=2Ec2=2Efrom);
+
+                    if (verdict =3D=3D PRE=
_DECRYPT_CREATE_SESSION_SKIP)
+                    {
+                     =
   mi->context=2Ec2=2Etls_multi->n_sessions++;
+                        ses=
sion_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+            =
        }
                 }
             }
         }

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c=
2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--HX6RnGzNmTg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>plaisthos <=
strong>uploaded patch set #7</strong> to this change=2E</p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></=
p><p>The following approvals got outdated and were removed:
Code-Review-1 b=
y stipa</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Make required action returned from pre_decrypt_ver=
dict more explicit<br><br>The current code relies on the condition if state=
=2Eserver_session_id<br>is defined to decided if session_skip_to_pre_start =
should be used=2E<br><br>Instead explicitly return the intent and use that =
to decide if<br>session_skip_to_pre_start should be called=2E<br><br>Change=
-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89<br>---<br>M src/openvpn/mudp=
=2Ec<br>1 file changed, 44 insertions(+), 17 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
26/1826/7</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec<=
/span><br><span>index 632b064=2E=2Ef588515 100644</span><br><span>--- a/src=
/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><spa=
n>@@ -87,9 +87,24 @@</span><br><span>                           &quot;Reset=
 packet from client, sending HMAC based reset challenge&quot;, sock);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * V=
erdict if this packet should create a new session=2E If a packet is invalid=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * or we send out a=
n HMAC based challenge, we do not want to create a new</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * session=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+enum pre_decrypt_verdict</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /** This packet should not create a new session */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT_NO_ACTION,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /** This packet creates a new=
 session normally */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    PRE_DECRYPT_CREATE_SESSION,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /** Create a new session but skip the first two packets of=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the three wa=
y handshake */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    P=
RE_DECRYPT_CREATE_SESSION_SKIP</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-/* Returns true if this packet should create a new session */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Returns a verdict if this pac=
ket should create a new session */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static enum pre_decrypt_verdict</span><br><span> do_pre_decr=
ypt_check(struct multi_context *m, struct tls_pre_decrypt_state *state,</sp=
an><br><span>                      struct mroute_addr addr, struct link_soc=
ket *sock)</span><br><span> {</span><br><span>@@ -111,7 +126,7 @@</span><br=
><span>          * responses */</span><br><span>         if (!reflect_filte=
r_rate_limit_check(m-&gt;initial_rate_limiter))</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn PRE_DECRYPT_NO_ACTION;</span><br><span>         }</span><br><span>     }=
</span><br><span> </span><br><span>@@ -136,7 +151,7 @@</span><br><span>    =
             calculate_session_id_hmac(state-&gt;peer_session_id, from, hma=
c_key, handwindow, 0);</span><br><span>             send_hmac_reset_packet(=
m, state, tas, &amp;sid, true, sock);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_A=
CTION;</span><br><span>         }</span><br><span>         else</span><br><=
span>         {</span><br><span>@@ -153,11 +168,11 @@</span><br><span>     =
                &quot;ignoring connection attempt from old client (%s)&quot=
;,</span><br><span>                     peer);</span><br><span>            =
     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                return PRE_DECRYPT_NO_ACTION;</span><br><span>  =
           }</span><br><span>             else</span><br><span>            =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ret=
urn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      return PRE_DECRYPT_CREATE_SESSION;</span><br><span>             }</sp=
an><br><span>         }</span><br><span>     }</span><br><span>@@ -170,7 +1=
85,7 @@</span><br><span>         send_hmac_reset_packet(m, state, tas, &amp=
;sid, false, sock);</span><br><span> </span><br><span>         /* We have a=
 reply do not create a new session */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return PRE_DECRYPT_NO_ACTION;</span><br><span>   =
  }</span><br><span>     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 |=
| verdict =3D=3D VERDICT_VALID_ACK_V1</span><br><span>              || verd=
ict =3D=3D VERDICT_VALID_WKC_V1)</span><br><span>@@ -181,6 +196,7 @@</span>=
<br><span> </span><br><span>         bool pkt_is_ack =3D (verdict =3D=3D VE=
RDICT_VALID_ACK_V1);</span><br><span>         bool ret =3D check_session_hm=
ac_and_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        enum pre_decrypt_verdict =
action =3D PRE_DECRYPT_NO_ACTION;</span><br><span> </span><br><span>       =
  const char *peer =3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom,=
 &amp;gc);</span><br><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-=
&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -198,14 +214,16 @@</span><br><span>=
                 &quot;Valid packet (%s) with HMAC challenge from peer (%s)=
, &quot;</span><br><span>                 &quot;accepting new connection=2E=
&quot;,</span><br><span>                 packet_opcode_name(op), peer);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            action =3D =
PRE_DECRYPT_CREATE_SESSION_SKIP;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>         }</span><br><span>         gc_free(&=
amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return action;</span><br><span>     }</span><br><span> </span>=
<br><span>     /* VERDICT_INVALID */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return PRE_DECRYPT_NO_ACTION;</span><br><span> }</span><br=
><span> </span><br><span> /**</span><br><span>@@ -220,9 +238,6 @@</span><br=
><span>                           struct link_socket *sock,</span><br><span=
>                           struct mroute_addr *real)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D NULL;</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>=
     if (m-&gt;deferred_shutdown_signal=2Esignal_received)</span><br><span>=
@@ -231,8 +246,17 @@</span><br><span>             &quot;MULTI: Connection a=
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
tial packet of a</span><br><span>@@ -257,13 +281,16 @@</span><br><span> </s=
pan><br><span>                 /* If we have a session id already, ensure t=
hat the</span><br><span>                  * state is using the same */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (sessio=
n_id_defined(&amp;state=2Eserver_session_id)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    &amp;&amp; session_id_defined((&=
amp;state=2Epeer_session_id)))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (session_id_defined((&amp;state=2Epeer_sessio=
n_id)))</span><br><span>                 {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    mi-&gt;context=2Ec2=2Etls_multi-&g=
t;n_sessions++;</span><br><span>                     struct tls_session *se=
ssion =3D</span><br><span>                         &amp;mi-&gt;context=2Ec2=
=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    session_skip_to_pre_start(session, &amp=
;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        session_skip_to_pre_=
start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span> =
                }</span><br><span>             }</span><br><span>         }=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfad090c565=
aac27e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>

</body></html>
--HX6RnGzNmTg=--


--===============6465961125355847240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6465961125355847240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6465961125355847240==--

