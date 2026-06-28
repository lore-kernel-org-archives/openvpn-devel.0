Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AC6C43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/e+BpXWIlG1HEg2lAJ9pzzlEAFzyJQIRg0BfITHPm+U=; b=S+EQratb2XYap5poF/vRjLWpyp
	n+EX/Pi4dMzgojLEVmss0yHEdSVpAbP/92Xwyv72YvtkKPEqmBChUL2Od7cP7Ac8biLhmD82fEFMg
	EDlTXop5s+IS+ivTiohFNRYHq2xtAbPsuexuNrwcKMkO/pfDMwaEyMMHdnIj705FY/PU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdqxD-0007J8-6m;
	Sun, 28 Jun 2026 14:57:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdqxC-0007J0-4y
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 14:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=B6rBB8mMNGyNAARn8wZjZsaFjFIurOcSnfUxN+71vk0=; b=YNdAC5Oq+oTG8QSKDBxvdSv/qH
 rci8efeyOJPRjQSfBj0KPe+xDR4cWEjKfRwY1a3xFxRiRHKW+LBAUMsIKxXXQ7c6UAKvjDmcGyAmg
 Tyhf3G2oHMQlJHcEGajIBtIEceYgfwv2+vTCcduZ6vnqzqNeDtI7KXgzm/X/u2M53DRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B6rBB8mMNGyNAARn8wZjZsaFjFIurOcSnfUxN+71vk0=; b=e
 3S2ZisGfASH2Y4LclDmgwgUefRFO71313hos5KYDI5FVYB+ZRyYAmaW+uI6XIAihtOq/sMaHW5LXT
 S7N06Jyo1OVreBYZKAg9Rsa0/D/Ew5fxUXaMssC2Y8SxYeFc/oHpWDR4TZE5hPA59gQRyJh5OBCM8
 rSjyao3L6QAduQuo=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdqx7-0006NT-U8 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 14:57:47 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so299507f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782658655; x=1783263455; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B6rBB8mMNGyNAARn8wZjZsaFjFIurOcSnfUxN+71vk0=;
 b=bFeBO4/PZXhouR6sz0CEOj4ItR4QC9+loKqzV06D9hJRklT7n2vkOl34QVqNkRaLZk
 qCBEEXL/2SyjUqX4PUP2n19a5b7cstRZN1MfRZ8ssRWj6LaR/dLfsjgF+eLMRYeuu6GM
 EJxFZzL1yejSiPgYgiuf3itY1J29KDDY2QJdS4YNlsB/AarWp919Hknxu51RIEeqbaLY
 w4YcBCJBt/BbnqiDBRyEZgqfnogM4m82X2xav2AKMLmZ6UBT9vqAwE7nQUhCRLsjbUal
 20gbZ4d8MrYv7GjkNYlXp6HkjbB/cAEqwM+pstqGIpXG/2HDR2wrvNo4WYb2597Z+DiH
 vMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782658655; x=1783263455;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6rBB8mMNGyNAARn8wZjZsaFjFIurOcSnfUxN+71vk0=;
 b=quG1l21y2H74hBQQWCB1wJkNEKwpQyp+0rvZNM+GZxsMfKJYquYyRENdz2gPIf3oux
 mit85pUhG2uW5jWPxq9Pva/+u+8KFLGTfcTn5PujYyp4hqCkQvjJG4CQ18reG3zgcWbb
 a+C1pQrAgQ/lmGftOccvGDsCIvIElkGaNO08uBkhptaVPjOUa9pVV2Pp61b2AAPDRqAx
 lhR5MW4UTgLk8dQJzdWRaV4fkeg5PNmFo9ZRxcVnE5JtRY6ir66XXYeBS+r/A4Oo0/YG
 GyZ/aiXi2eODOGuhdQE7TPE9Q7N9Ra4N3ZQObTF/SlNjB8bAnTKchqcZwJJMf8YdriZg
 6+ug==
X-Gm-Message-State: AOJu0Yze1PboLCEIIBajgANAAr0CRubncwdn4jg0lnvYtUP+sefUM5x/
 das/rw/v092A+U9xQft+lscRgnn/v5yWZf6fHOP1zvm5jkc3/uTaEkaPKEXttQg4sn1YVxGfyj2
 5ThulTbcoRCRHrYYCNEptRffC/pf/knHmkX9l7/IOsnhqSZ+Cvhi5GdE9rdRcvb+0TZYsv5DjQt
 vcwLBu+A==
X-Gm-Gg: AfdE7cmXvaZ1VgO4kPPjbK0cKjhbiT8trWg2F2N8aioC5rIGV0nx2qAARl7y2Tm98AM
 Jz7hRmfkWoS1xomJJ95IKSMQ79YMW2CvAP/JZC++1kzphAUBP4oXSdYWVdMLvdbqmWmKIgozjnb
 rvQZvCwW268LWrUo7tw2rQfOlT1qZOgt8f64i5xkxP/r8bdT12QxWZtJ6DXhMvuic1XLEcTZuTo
 Fk+CMvkhl6P0xUlanseUmWegw2hh4MN29MicNI2Z9itwp8y/k4N2r7JqrV4kYwwVc9eARO5Hfi6
 q2BNeWWJ9vn59he21auUh3oAop/fdZCE6mGAU3gc5GSHr1eptK6hT1Uo9z4T6rqgvBuvnkYSV8W
 WD1jMZJsarer37V9/U7x3FiLt5Rdeb05rTWBz+VmPuV/XvIVqaz+HcwaY0h9WBR1caNfce7gG9S
 LSyKYmdBJonZUQGwxQoawB0Sf0gv7GqZ3GE2EwKssgJ117Tvz5V58LuxrJm8EZNi4SYqZ1IwsLO
 zhkY34rdZw9ntVF7fUBYZsW3BXZ0IatFcwy/yxPsr265Wxx3RzSXqRpwoeUn7jhEPZUJnlYq1UT
 9l0=
X-Received: by 2002:a5d:5d0b:0:b0:460:1223:a044 with SMTP id
 ffacd0b85a97d-46dbc3abd1amr21634571f8f.0.1782658654615; 
 Sun, 28 Jun 2026 07:57:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm44278291f8f.9.2026.06.28.07.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 07:57:33 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 28 Jun 2026 14:57:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
X-Gerrit-Change-Number: 1720
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1720?usp=email>
X-Gerrit-Commit: 1572ee902f1d1ad75c1ad621ddcdc8bc80a5d522
In-Reply-To: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk2YTAzMjQ2NWU2NmI0OWFiMGNlOGIxYTg0ZWFkOGQ5YWNlZjkxOGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f84eba4611ebbb2b52dac72a122471836964a127-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdqx7-0006NT-U8
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
Content-Type: multipart/mixed; boundary="===============6229235530564873985=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6229235530564873985==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6Nj8KqUNmM8="; charset=UTF-8

--6Nj8KqUNmM8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Extract handle_connection_attempt from multi=
_get_create_instance_udp
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Extract handle_connection_attempt from multi_get_create_insta=
nce_udp

The multi_get_create_instance_udp is quite large=2E This factors o=
ut the
one branch that handles and creates new connection attempts=2E

Chan=
ge-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
Signed-off-by: Arne Schwab=
e <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720
Message-Id: <=
20260628130500=2E26086-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37336=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
=
1 file changed, 72 insertions(+), 50 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/1720/4

diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 143a330=2E=2Ef919b67 100644
--- =
a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -194,12 +194,81 @@
   =
  return false;
 }
 
-/*
+/**
+ * Handles a packet if no existing session e=
xists for this incoming packet=2E
+ *
+ * It will either send a reply with =
a hmac cookie if this is the first
+ * packet of a three-way handshake or c=
reate a multi_instance if it is a
+ * packet that completes the three-way h=
andshake=2E
+ */
+static struct multi_instance *
+handle_connection_attempt=
(struct multi_context *m,
+                          struct link_socket *so=
ck,
+                          struct mroute_addr *real,
+                 =
         const uint64_t hv,
+                          struct hash_bucket *=
bucket)
+{
+    struct hash *hash =3D m->hash;
+    struct tls_pre_decrypt_=
state state =3D { 0 };
+    struct multi_instance *mi =3D NULL;
+    struct=
 gc_arena gc =3D gc_new();
+
+    if (m->deferred_shutdown_signal=2Esignal_=
received)
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI: Connecti=
on attempt from %s ignored while server is "
+            "shutting down",
=
+            mroute_addr_print(real, &gc));
+    }
+    else if (do_pre_dec=
rypt_check(m, &state, *real, sock))
+    {
+        /* This is an unknown s=
ession but with valid tls-auth/tls-crypt
+         * (or no auth at all)=2E=
  If this is the initial packet of a
+         * session, we just send a re=
ply with a HMAC session id and
+         * do not generate a session slot *=
/
+
+        if (frequency_limit_event_allowed(m->new_connection_limiter))
=
+        {
+            /* a successful three-way handshake only counts aga=
inst
+             * connect-freq but not against connect-freq-initial */
+=
            reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
+
=
+            mi =3D multi_create_instance(m, real, sock);
+            if (=
mi)
+            {
+                hash_add_fast(hash, bucket, &mi->real, =
hv, mi);
+                mi->did_real_hash =3D true;
+                mult=
i_assign_peer_id(m, mi);
+
+                /* If we have a session id alre=
ady, ensure that the
+                 * state is using the same */
+      =
          if (session_id_defined(&state=2Eserver_session_id)
+             =
       && session_id_defined((&state=2Epeer_session_id)))
+                =
{
+                    mi->context=2Ec2=2Etls_multi->n_sessions++;
+       =
             struct tls_session *session =3D
+                        &mi->=
context=2Ec2=2Etls_multi->session[TM_INITIAL];
+                    session=
_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+                =
}
+            }
+        }
+        else
+        {
+            msg(D_MUL=
TI_ERRORS,
+                "MULTI: Connection from %s would exceed new con=
nection frequency limit as controlled by --connect-freq",
+                =
mroute_addr_print(real, &gc));
+        }
+    }
+    free_tls_pre_decrypt_=
state(&state);
+    gc_free(&gc);
+    return mi;
+}
+
+/**
  * Get a clien=
t instance based on real address=2E  If
  * the instance doesn't exist, cre=
ate it while
  * maintaining real address hash table atomicity=2E
  */
-
 s=
truct multi_instance *
 multi_get_create_instance_udp(struct multi_context =
*m, bool *floated, struct link_socket *sock)
 {
@@ -258,54 +327,7 @@
      =
   /* we have no existing multi instance for this connection */
         if=
 (!mi)
         {
-            struct tls_pre_decrypt_state state =3D { 0 }=
;
-            if (m->deferred_shutdown_signal=2Esignal_received)
-        =
    {
-                msg(D_MULTI_ERRORS,
-                    "MULTI: Con=
nection attempt from %s ignored while server is "
-                    "shu=
tting down",
-                    mroute_addr_print(&real, &gc));
-        =
    }
-            else if (do_pre_decrypt_check(m, &state, real, sock))
- =
           {
-                /* This is an unknown session but with valid =
tls-auth/tls-crypt
-                 * (or no auth at all)=2E  If this is t=
he initial packet of a
-                 * session, we just send a reply wi=
th a HMAC session id and
-                 * do not generate a session slot=
 */
-
-                if (frequency_limit_event_allowed(m->new_connection_=
limiter))
-                {
-                    /* a successful three-way=
 handshake only counts against
-                     * connect-freq but not=
 against connect-freq-initial */
-                    reflect_filter_rate_l=
imit_decrease(m->initial_rate_limiter);
-
-                    mi =3D multi=
_create_instance(m, &real, sock);
-                    if (mi)
-           =
         {
-                        hash_add_fast(hash, bucket, &mi->real, =
hv, mi);
-                        mi->did_real_hash =3D true;
-            =
            multi_assign_peer_id(m, mi);
-
-                        /* If w=
e have a session id already, ensure that the
-                         * st=
ate is using the same */
-                        if (session_id_defined(&s=
tate=2Eserver_session_id)
-                            && session_id_define=
d((&state=2Epeer_session_id)))
-                        {
-                =
            mi->context=2Ec2=2Etls_multi->n_sessions++;
-                  =
          struct tls_session *session =3D
-                                =
&mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
-                      =
      session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
-   =
                     }
-                    }
-                }
-         =
       else
-                {
-                    msg(D_MULTI_ERRORS,
-  =
                      "MULTI: Connection from %s would exceed new connectio=
n frequency limit as controlled by --connect-freq",
-                      =
  mroute_addr_print(&real, &gc));
-                }
-            }
-      =
      free_tls_pre_decrypt_state(&state);
+            mi =3D handle_connec=
tion_attempt(m, sock, &real, hv, bucket);
         }
 
 #ifdef ENABLE_DEBUG=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a032465e66b49=
ab0ce8b1a84ead8d9acef918de
Gerrit-Change-Number: 1720
Gerrit-PatchSet: 4
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--6Nj8KqUNmM8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Extract handle_conne=
ction_attempt from multi_get_create_instance_udp<br><br>The multi_get_creat=
e_instance_udp is quite large=2E This factors out the<br>one branch that ha=
ndles and creates new connection attempts=2E<br><br>Change-Id: I6a032465e66=
b49ab0ce8b1a84ead8d9acef918de<br>Signed-off-by: Arne Schwabe &lt;arne@rfc25=
49=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720<br>Message-=
Id: &lt;20260628130500=2E26086-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37336=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/mudp=2Ec<br>1 file changed, 72 insertions(+), 50 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/20/1720/4</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec=
 b/src/openvpn/mudp=2Ec</span><br><span>index 143a330=2E=2Ef919b67 100644</=
span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn=
/mudp=2Ec</span><br><span>@@ -194,12 +194,81 @@</span><br><span>     return=
 false;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Handles=
 a packet if no existing session exists for this incoming packet=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * It will either send a reply with a hmac c=
ookie if this is the first</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * packet of a three-way handshake or create a multi_instance if it =
is a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * packet that =
completes the three-way handshake=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static struct multi_instance *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+handle_connection_attempt(struct multi_context *m,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                          struct=
 link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                          struct mroute_addr *real,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          const uint64_t =
hv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          struct hash_bucket *bucket)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct tls_pre_decrypt_state state =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *=
mi =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m=
-&gt;deferred_shutdown_signal=2Esignal_received)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_MULTI_ERRORS,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;MULTI: Connection attempt from %s =
ignored while server is &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;shutting down&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            mroute_addr_print(real, &amp;gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (do_pre_decrypt_chec=
k(m, &amp;state, *real, sock))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* This is an unknown session but with valid tls-auth/tls-crypt</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * (or no auth at =
all)=2E  If this is the initial packet of a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * session, we just send a reply with a HMA=
C session id and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * do not generate a session slot */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (frequency_limit_event_allowed(m-&gt;new_connection_limiter))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* a successful t=
hree-way handshake only counts against</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * connect-freq but not against connect-freq=
-initial */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    reflect_filter_rate_limit_decrease(m-&gt;initial_rate_limiter);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            mi =3D multi_create_instance(m, re=
al, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;did_real_hash =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      multi_assign_peer_id(m, mi);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            /* If we have a session id already, ensure that the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 * state is usi=
ng the same */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           if (session_id_defined(&amp;state=2Eserver_session_id)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp=
; session_id_defined((&amp;state=2Epeer_session_id)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=
=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    struct tls_session *session =3D</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        &amp;mi-=
&gt;context=2Ec2=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    session_skip_to_pre_s=
tart(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                &quot;MULTI: Connection from %s would exceed n=
ew connection frequency limit as controlled by --connect-freq&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                mroute_add=
r_print(real, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_de=
crypt_state(&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get a clien=
t instance based on real address=2E  If</span><br><span>  * the instance do=
esn&#39;t exist, create it while</span><br><span>  * maintaining real addre=
ss hash table atomicity=2E</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> struct multi_instance *</span><=
br><span> multi_get_create_instance_udp(struct multi_context *m, bool *floa=
ted, struct link_socket *sock)</span><br><span> {</span><br><span>@@ -258,5=
4 +327,7 @@</span><br><span>         /* we have no existing multi instance =
for this connection */</span><br><span>         if (!mi)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
truct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (m-&gt;deferred_shutdown_signal=2Esig=
nal_received)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  &quot;MULTI: Connection attempt from %s ignored while ser=
ver is &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            &quot;shutting down&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    mroute_addr_print(&amp;real, &amp;gc))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (do_pre_=
decrypt_check(m, &amp;state, real, sock))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                /* This is an unknown session but with valid tl=
s-auth/tls-crypt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
            * (or no auth at all)=2E  If this is the initial packet of a</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                 * sessi=
on, we just send a reply with a HMAC session id and</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 * do not generate a sessio=
n slot */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                if (frequency_lim=
it_event_allowed(m-&gt;new_connection_limiter))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    /* a successful three-way handsha=
ke only counts against</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                     * connect-freq but not against connect-freq-initial *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
reflect_filter_rate_limit_decrease(m-&gt;initial_rate_limiter);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    mi =3D multi_create_instance(m, &a=
mp;real, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, m=
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      mi-&gt;did_real_hash =3D true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        multi_assign_peer_id(m, mi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        /* If we have a session id=
 already, ensure that the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                         * state is using the same */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        if (session_id_=
defined(&amp;state=2Eserver_session_id)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                            &amp;&amp; session_id_defined=
((&amp;state=2Epeer_session_id)))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                            mi-&gt;context=2Ec2=2Etls_multi=
-&gt;n_sessions++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                         struct tls_session *session =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                &amp;mi-=
&gt;context=2Ec2=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            session_skip_to=
_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    msg(D_MULTI_ERRORS,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 &quot;MULTI: Connection from %s would exceed new connection frequency limi=
t as controlled by --connect-freq&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        mroute_addr_print(&amp;real, &am=
p;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            free_tls_pre_d=
ecrypt_state(&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            mi =3D handle_connection_attempt(m, sock, &amp;real, hv, =
bucket);</span><br><span>         }</span><br><span> </span><br><span> #ifd=
ef ENABLE_DEBUG</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail">change 1720=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
6a032465e66b49ab0ce8b1a84ead8d9acef918de </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1720 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--6Nj8KqUNmM8=--


--===============6229235530564873985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6229235530564873985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6229235530564873985==--

