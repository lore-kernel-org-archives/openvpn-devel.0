Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67FEC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMMJ0EumBrdFK4BjyMC+cL17mt2SoqEoHTqB+o9waNY=; b=d5PZ922DnZPWAIbqB0TYuTvfdC
	PeOGR5OJLsWrQnrXC5n3jONbpW4zLJjs/W8DhJKd5o9ql41A7LfjQyAmLuCtEKMVESdAubdDZnavw
	K869MUfOGZO9WQqbP1dgd/lJvk1qMV9duHplEetre9r1ABeB+FkBi3Q/FwNZ2xjZiXY4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvtxJ-0004r8-IW;
	Mon, 17 Aug 2026 09:48:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvtxH-0004r0-Id
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:48:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KAThbQ+yMuSH06jbHNqTJFeMQuNtd+Yvm1m+5IsJUpA=; b=Z/VeeBmaI6bmQjkTrSIw3kMYgP
 JHm2FTHMKaDpHozkFNLXrc5PTiMDY8S6w1cEbKYiA1JJPqw5W0N95eR99KSl+ElJVBqP24Xs6ZBug
 4F2YxMc0dVf5I2rn46RukX3sLvkT9cQMktptbrE4f4AtS+xg5TbV2RVxWDz4G2r/8Pdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KAThbQ+yMuSH06jbHNqTJFeMQuNtd+Yvm1m+5IsJUpA=; b=m
 3gt5nJr393PmH8reCyQmVTbnc4gyZyXSGTXgs/T1bzchcIoFBHZ+ko7kkN2QVWK+F+o76mbUclYR2
 4DeprhS1jWTccpElbv9TTq2CaeG0N0y/SvyhU+Ax8xwbs34KsA3HSat6t/3/m7wqxDz1jPXVF3ncC
 Nn0L7wmtNx9E11wk=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvtxD-0006R5-Bs for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:48:29 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso35912595e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786960101; x=1787564901; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KAThbQ+yMuSH06jbHNqTJFeMQuNtd+Yvm1m+5IsJUpA=;
 b=PC//YNgxCOfScMHg6RqSjBIQe0LR8X09MgTrjBY1es4Qg7w9Mv/E78la1TyIOyLzih
 nLhnZ8ofAIKueEqv/u9J4Yl4+I8FiaXoTmfepqEsGcFSqyqsvOOsVPxyDsV7MGCmi56/
 t9u2iinPJ/EBQcH1kxwiZMK/oO+jppObv9mz2UCEJoGDYt18YfhAgBplVDPhXEVDd+Jk
 Dm/6EblczOtbM1LMU7eg+WfSD9Qs3laUhFfO93BlS5rqkK/SQ+PWuXUj9NRRk3zxkRnC
 Om0Zy5WyvmP3nNKFdvhj2mHV/j91Kem1O+S/sFrLEaIduRezqHm0GijrJ/88zDSlyQ5x
 Sc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786960101; x=1787564901;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KAThbQ+yMuSH06jbHNqTJFeMQuNtd+Yvm1m+5IsJUpA=;
 b=EkBt4bU/eXZq6gQlc8zpULgOqNHMXo+z8+NIxxZlpjE6Aw2fW1QFi4JINu1vzc3Taz
 SNbFX5lUtlCAKQp+F6XU9lECKRJyFuXlDDCSVUve4EhInNP+Qppp6AX0M5DbTAufy59q
 4cQfeSPAsOZOOLybbcwJNA17ZtyFzdwdv1AOaS1F/juDxR0QJDkHWEPQLeMPnk/niO01
 nYa4z3vlMhxlEWFK3nmreB2tM+Za2YJL4ldQ7axChi+16QMpv3xQ8HABAhg0FJyWARCK
 zBn4NQ9Z5Iyffk/gVdAK8PBa+kat922kh1j0swhxpp4fjAgyeg8hJEsAODK5fB/Ux1DM
 ufXA==
X-Gm-Message-State: AOJu0YyVcMfFqxmfi5VyKG1MtCPa8hDiZ1w3PGEilRzNxelWPlo0aMlo
 mg1Ze2LY0GtzJTz/o2XleJSH0Go4hd/lwCAk/G7PvXpqgPvgDIMi5Z3XXE9hqVQPkCewAuxx6CT
 teUST0d6udK7gVW9l5fUlhWwPsg7wlaYrpfAin4Nw50IQuvElch2om7iJx/xAyu/fAAgE2TJCuV
 buPwsotQ==
X-Gm-Gg: AR+sD10ONF3ymSis2KjeQ9xQ3knsJMf94ChKIXMTT5lSSs4dngdLZwyNOwszo148B4h
 AC93fwmJGDjjtcL4QxRyAZSWvvRfbJEFp8ea0SBE6chQ6hfaId/hdflh6IWLToRyNwStWP1LREr
 S7blZpiJOh5geJCYCECGhUF5yKZtzXLkQs/TiflvYD4vZGHmcqPBSkbEETv+Bgjm4z6sqnQ9l6w
 w6GC2B8jGkPrwzZO5KtdL1JsVq9dP4AHNcL2vUSYK53MzNhDkPq9nSI2GQvR3LQTVFsWdTGI75c
 PnA2baMJRHhr0jD/LJ6J5MsMF4vZ52VS9RAni5dblXwOoByjLt5VPYfuFns+O08MhGxU96Aup/z
 FEAWc7CX7taHI9ugAIpD119jXNt6t6L4AOiwXqlSePIE34q2esVMW+J+8j96t0AXLuR+sAm6NBD
 ZJSqCaUSFnfZuL1gGQC14Epc33Rr+I0ONzKCcmKG42/eiHm+xR1b547A7ex94bvw8P/AUXWayiB
 2vQI7yNfbLdaTCQz87bQYGWMRW6Daq10duCAqWBOJBF9w4jw2H6IRlAC4XyCGD0FDx1gADIZV6k
 Yf1PlYtxE9Z/5/pHrPxPScwZjrUXq/jnn88ij660j1Uo9dN5lL0=
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-49987938e19mr387328325e9.1.1786960100605; 
 Mon, 17 Aug 2026 02:48:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610966dsm175903145e9.5.2026.08.17.02.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:48:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 09:48:18 +0000
To: flichtenheld <frank@lichtenheld.com>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 0ed03b5aa12f834249b9ecd2e8edb20d5e4d6fef
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff0a745adc23ba11e7d08f376259b1b36850c2fc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvtxD-0006R5-Bs
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
Content-Type: multipart/mixed; boundary="===============5984002234168769144=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5984002234168769144==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/EqiSGPiH74="; charset=UTF-8

--/EqiSGPiH74=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa=2E

Hello flichte=
nheld, stipa, 

I'd like you to reexamine a change=2E Please visit

    htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail

to look at the new=
 patch set (#8)=2E


Change subject: Make required action returned from pre=
_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Make required action returned from pre_decrypt_verdict =
more explicit

The current code relies on the condition if state=2Eserver_s=
ession_id
is defined to decided if session_skip_to_pre_start should be used=
=2E

Instead explicitly return the intent and use that to decide if
session=
_skip_to_pre_start should be called=2E

Change-Id: Iccdd4cfad090c565aac27e1=
6cdaa9871106c2f89
---
M src/openvpn/mudp=2Ec
1 file changed, 43 insertions(=
+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/26/1826/8

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mu=
dp=2Ec
index 632b064=2E=2Edc049f6 100644
--- a/src/openvpn/mudp=2Ec
+++ b/s=
rc/openvpn/mudp=2Ec
@@ -87,9 +87,24 @@
                           "Reset pa=
cket from client, sending HMAC based reset challenge", sock);
 }
 
+/**
+ *=
 Verdict if this packet should create a new session=2E If a packet is inval=
id
+ * or we send out an HMAC based challenge, we do not want to create a n=
ew
+ * session=2E
+ */
+enum pre_decrypt_verdict
+{
+    /** This packet sh=
ould not create a new session */
+    PRE_DECRYPT_NO_ACTION,
+    /** This =
packet creates a new session normally */
+    PRE_DECRYPT_CREATE_SESSION,
+=
    /** Create a new session but skip the first two packets of
+     * the =
three way handshake */
+    PRE_DECRYPT_CREATE_SESSION_SKIP
+};
 
-/* Retur=
ns true if this packet should create a new session */
-static bool
+/** Ret=
urns a verdict if this packet should create a new session */
+static enum p=
re_decrypt_verdict
 do_pre_decrypt_check(struct multi_context *m, struct tl=
s_pre_decrypt_state *state,
                      struct mroute_addr addr, =
struct link_socket *sock)
 {
@@ -111,7 +126,7 @@
          * responses */
 =
        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
    =
     {
-            return false;
+            return PRE_DECRYPT_NO_ACTION=
;
         }
     }
 
@@ -136,7 +151,7 @@
                 calculate_sessio=
n_id_hmac(state->peer_session_id, from, hmac_key, handwindow, 0);
         =
    send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
-           =
 return false;
+            return PRE_DECRYPT_NO_ACTION;
         }
      =
   else
         {
@@ -153,11 +168,11 @@
                     "ignoring con=
nection attempt from old client (%s)",
                     peer);
        =
         gc_free(&gc);
-                return false;
+                retu=
rn PRE_DECRYPT_NO_ACTION;
             }
             else
             {
-=
                return true;
+                return PRE_DECRYPT_CREATE_SES=
SION;
             }
         }
     }
@@ -170,7 +185,7 @@
         send_hm=
ac_reset_packet(m, state, tas, &sid, false, sock);
 
         /* We have a =
reply do not create a new session */
-        return false;
+        return=
 PRE_DECRYPT_NO_ACTION;
     }
     else if (verdict =3D=3D VERDICT_VALID_C=
ONTROL_V1 || verdict =3D=3D VERDICT_VALID_ACK_V1
              || verdict =
=3D=3D VERDICT_VALID_WKC_V1)
@@ -181,6 +196,7 @@
 
         bool pkt_is_ack=
 =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
         bool ret =3D check_ses=
sion_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);
+     =
   enum pre_decrypt_verdict action =3D PRE_DECRYPT_NO_ACTION;
 
         co=
nst char *peer =3D print_link_socket_actual(&m->top=2Ec2=2Efrom, &gc);
    =
     uint8_t pkt_firstbyte =3D *BPTR(&m->top=2Ec2=2Ebuf);
@@ -198,14 +214,1=
5 @@
                 "Valid packet (%s) with HMAC challenge from peer (%s)=
, "
                 "accepting new connection=2E",
                 packet=
_opcode_name(op), peer);
+            action =3D PRE_DECRYPT_CREATE_SESSION=
_SKIP;
         }
         gc_free(&gc);
 
-        return ret;
+        re=
turn action;
     }
 
     /* VERDICT_INVALID */
-    return false;
+    re=
turn PRE_DECRYPT_NO_ACTION;
 }
 
 /**
@@ -220,9 +237,6 @@
                 =
          struct link_socket *sock,
                           struct mrout=
e_addr *real)
 {
-    struct hash *hash =3D m->hash;
-    struct tls_pre_de=
crypt_state state =3D { 0 };
-    struct multi_instance *mi =3D NULL;
     =
struct gc_arena gc =3D gc_new();
 
     if (m->deferred_shutdown_signal=2Es=
ignal_received)
@@ -231,8 +245,17 @@
             "MULTI: Connection attemp=
t from %s ignored while server is "
             "shutting down",
         =
    mroute_addr_print(real, &gc));
+        gc_free(&gc);
+        return N=
ULL;
     }
-    else if (do_pre_decrypt_check(m, &state, *real, sock))
+
+=
    struct hash *hash =3D m->hash;
+    struct tls_pre_decrypt_state state =
=3D { 0 };
+    struct multi_instance *mi =3D NULL;
+
+    enum pre_decrypt=
_verdict verdict =3D do_pre_decrypt_check(m, &state, *real, sock);
+
+    i=
f (verdict !=3D PRE_DECRYPT_NO_ACTION)
     {
         /* This is an unknow=
n session but with valid tls-auth/tls-crypt
          * (or no auth at all)=
=2E  If this is the initial packet of a
@@ -257,13 +280,16 @@
 
           =
      /* If we have a session id already, ensure that the
                 =
 * state is using the same */
-                if (session_id_defined(&stat=
e=2Eserver_session_id)
-                    && session_id_defined((&state=
=2Epeer_session_id)))
+                if (session_id_defined((&state=2Epee=
r_session_id)))
                 {
-                    mi->context=2Ec2=2E=
tls_multi->n_sessions++;
                     struct tls_session *session =
=3D
                         &mi->context=2Ec2=2Etls_multi->session[TM_INIT=
IAL];
-                    session_skip_to_pre_start(session, &state, &m->t=
op=2Ec2=2Efrom);
+
+                    if (verdict =3D=3D PRE_DECRYPT_CREA=
TE_SESSION_SKIP)
+                    {
+                        mi->contex=
t=2Ec2=2Etls_multi->n_sessions++;
+                        session_skip_to_=
pre_start(session, &state, &m->top=2Ec2=2Efrom);
+                    }
   =
              }
             }
         }

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Gerrit-C=
hange-Number: 1826
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--/EqiSGPiH74=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, stipa=2E </p>
<p>plaisthos <strong>uplo=
aded patch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Make required action returned from pre_decrypt_verdict more explicit<b=
r><br>The current code relies on the condition if state=2Eserver_session_id=
<br>is defined to decided if session_skip_to_pre_start should be used=2E<br=
><br>Instead explicitly return the intent and use that to decide if<br>sess=
ion_skip_to_pre_start should be called=2E<br><br>Change-Id: Iccdd4cfad090c5=
65aac27e16cdaa9871106c2f89<br>---<br>M src/openvpn/mudp=2Ec<br>1 file chang=
ed, 43 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1826/8</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>inde=
x 632b064=2E=2Edc049f6 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</s=
pan><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -87,9 +87,24 @@=
</span><br><span>                           &quot;Reset packet from client,=
 sending HMAC based reset challenge&quot;, sock);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Verdict if this packe=
t should create a new session=2E If a packet is invalid</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * or we send out an HMAC based challen=
ge, we do not want to create a new</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * session=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum pr=
e_decrypt_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This packet =
should not create a new session */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    PRE_DECRYPT_NO_ACTION,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /** This packet creates a new session normally */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT_CRE=
ATE_SESSION,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**=
 Create a new session but skip the first two packets of</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * the three way handshake */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT_CREATE_SE=
SSION_SKIP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Returns=
 true if this packet should create a new session */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/** Returns a verdict if this packet should create =
a new session */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic enum pre_decrypt_verdict</span><br><span> do_pre_decrypt_check(struct m=
ulti_context *m, struct tls_pre_decrypt_state *state,</span><br><span>     =
                 struct mroute_addr addr, struct link_socket *sock)</span><=
br><span> {</span><br><span>@@ -111,7 +126,7 @@</span><br><span>          *=
 responses */</span><br><span>         if (!reflect_filter_rate_limit_check=
(m-&gt;initial_rate_limiter))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_=
ACTION;</span><br><span>         }</span><br><span>     }</span><br><span> =
</span><br><span>@@ -136,7 +151,7 @@</span><br><span>                 calcu=
late_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow,=
 0);</span><br><span>             send_hmac_reset_packet(m, state, tas, &am=
p;sid, true, sock);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;</span><br><=
span>         }</span><br><span>         else</span><br><span>         {</s=
pan><br><span>@@ -153,11 +168,11 @@</span><br><span>                     &q=
uot;ignoring connection attempt from old client (%s)&quot;,</span><br><span=
>                     peer);</span><br><span>                 gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         return PRE_DECRYPT_NO_ACTION;</span><br><span>             }</span=
><br><span>             else</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                return PRE_D=
ECRYPT_CREATE_SESSION;</span><br><span>             }</span><br><span>     =
    }</span><br><span>     }</span><br><span>@@ -170,7 +185,7 @@</span><br>=
<span>         send_hmac_reset_packet(m, state, tas, &amp;sid, false, sock)=
;</span><br><span> </span><br><span>         /* We have a reply do not crea=
te a new session */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return PRE_DECRYPT_NO_ACTION;</span><br><span>     }</span><br><spa=
n>     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verdict =3D=3D V=
ERDICT_VALID_ACK_V1</span><br><span>              || verdict =3D=3D VERDICT=
_VALID_WKC_V1)</span><br><span>@@ -181,6 +196,7 @@</span><br><span> </span>=
<br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1=
);</span><br><span>         bool ret =3D check_session_hmac_and_pkt_id(stat=
e, from, hmac_key, handwindow, pkt_is_ack);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        enum pre_decrypt_verdict action =3D PRE_DEC=
RYPT_NO_ACTION;</span><br><span> </span><br><span>         const char *peer=
 =3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc);</span><=
br><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebuf=
);</span><br><span>@@ -198,14 +214,15 @@</span><br><span>                 &=
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
r><span> </span><br><span> /**</span><br><span>@@ -220,9 +237,6 @@</span><b=
r><span>                           struct link_socket *sock,</span><br><spa=
n>                           struct mroute_addr *real)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D NULL;</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>=
     if (m-&gt;deferred_shutdown_signal=2Esignal_received)</span><br><span>=
@@ -231,8 +245,17 @@</span><br><span>             &quot;MULTI: Connection a=
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
tial packet of a</span><br><span>@@ -257,13 +280,16 @@</span><br><span> </s=
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
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--/EqiSGPiH74=--


--===============5984002234168769144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5984002234168769144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5984002234168769144==--

