Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E83ECD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=bxxrx/LdUIUJhrthWbwzD7pQpV2vhzQjsZCqu7y/2JU=; b=O3YBGStePe4kRx
	+AJA10ieaSBBj5fL9aXSgkEIBJvQ2ZZncs67i9xZdeAXGuxk4+/ESQaOtTOR+zt/Xaz5nYjkj0rOJ
	ulb6CkRzXTVNdi3eiRnQ1ewznfxvLUF0VzkTcFqqvQp01XqNCTPRcBZJie6Xkl0VD/XAMHkJA3eGP
	smY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbecq-0004rg-Ro;
	Mon, 22 Jun 2026 13:23:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecp-0004rY-EO
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IXjcupa2Yr42PJyS9mux68gcjZu/CEvGgf9fGZMNOTo=; b=IV5wtY5Ol/fmzZifnftzhgjbvr
 pU7hMk9y5aMWyqlwEBv1uj/FBscCWGL9vVTaRWs1s4AROxSxpSXLrjvAL4rFbPC/Q4Qec3OtI1EWv
 sV5qryBLi7jtkn98HcJZZnNFCJTOxjRAi7jOmsqRvnMEFoTggurRW9nl/pmUge6YYh1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IXjcupa2Yr42PJyS9mux68gcjZu/CEvGgf9fGZMNOTo=; b=B
 KbeknbhjXvn2jo/uMHnk1TcnVBiuSGJCAq0HxOOZae/+7JJrYI5KxcztMFhFl3FfPFXEZTBKeEDrS
 VdXhrRxXRcUpAAKZRRmWEdhdMMzOTNXPwXBs83V8y/KI8DcYeCzP+VviNJofpbdPflOkM0DUxHjd+
 zcNjrH2kMxnaERKU=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecn-0000a2-SP for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:44 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso36160575e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134616; x=1782739416; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXjcupa2Yr42PJyS9mux68gcjZu/CEvGgf9fGZMNOTo=;
 b=c9Gm5WT6L74ONpKo+FzVb9R++hE/ORNm5Zkr4Kf3v4BpmbQIf4hzoOxpMxlKiOrgj7
 n4lngcd4VhYhgPhIh2a3TMpCZaRro0xMWziY/tPbjREVMNdembuJhcEAfS6FQSLN9qhw
 dRFuzkBRhMjEaXEXXbPshj5r4LXkxmFu+TR3XG6QxEFbYkMUC5M+k4pphzTVEEVJuC95
 KtqM0fyLnS5jUC0nxddWhDsFtkBT8qY1Q/JZMINbOXEIxbapeH+kWCtp9Cs4jF6vfKpZ
 2Is7yI4J2h335VoFwL0KaTibeVQEPTalfLbvqCai1H1oMJsB3/2hdd47VycdWHcLXdTn
 vLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134616; x=1782739416;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXjcupa2Yr42PJyS9mux68gcjZu/CEvGgf9fGZMNOTo=;
 b=JiuSpxD/vCq5Qiw4XZniKI/0e52ESYTAGgFEx2c6x3nM7q3mJ/26+Y4kBpbN7Cscr0
 lF6lV5oZfLDZ8MBnImYUm2JdB2o7ezI9t6wlRDgiA6qd/vktwlC1MJsuIjzzi8WVbvsL
 6qfEc4ApsOnYO+0/S5aUc2v6Hb5pcTU3+UhKzTO38Z+WFoTsd4hiISW1Zhkkeg/JLnfW
 GwNMKpw5AmXUEO6ZPH5BYjeoq76OymiLW7ix2OgiQGwGO8W8Dc1Q0Kj3BBueTFAoKNsB
 BedJVVhT8fDSv5E44j1eOIkbcfxtvsERnd/N40np3ERnG9aHs4sqmQIUzNQKIT0oVp00
 iyeg==
X-Gm-Message-State: AOJu0YwkT2Jlr2VK4b7cSU78gSCeHBy8jxAcJRyRsxLjvDn48ic9ywv5
 zTccO7Wva4pVL7OZo/bvTWnaOeCWyJPVGXdYa9NWKuawvyOMX5/ENRsAcR/OLvExg/gtVGFXywl
 xiG7hJZhG07tb8osHejwOx0WpwQQG2qQmlL9Jv9q/9p8fHQ9Yq5f2r5TASgS41XqxIDgvWhMjjp
 EFEcCAeA==
X-Gm-Gg: AfdE7cnEn6Z2yQcvjvZKdEnzTQSS3KRXo8xslhr0xAj8Vu7WmX4uBDdbZtwp62lwHzB
 YjP4gORUaM6VMmmIqbeE4MamH61h1DjXpqYnnMn2MJ5X3EeYsP7x57jf+cU+qqpnpdjr8Z29Kv8
 ZgYv7wmyJoBGvS/tJ1BvR6F0AoVE9cwV3V+UFKlObJpzT2jlwvfC8nudNe6wxzRqB1yoNy7smmO
 N0DGTqkW3VOTh1Qjkn73FrEcZglm0wq/E5iFvqLRcZ2bCNrS9/6uAeD4fiMYfb4Pk1pm0j+eEv9
 hM2D2eeM/TmTwPD0uMU/zDvQkRQ31bZhPJsNNCX0QYMNlfMf5lz4riwegVkvl7YC75mci3zNZR6
 NTRr1KYjpuevH/1RzubFnE9QUpykpjbPB8cDq0ovrL+BU37+cU+boDrUx1+wydrk124lkh04glh
 dhOqv7218/6N+jsVYjdMar0aJEZpYzyYmU2BjV5+/Duy4jDaMneHZW9auE9Ny6EcZULCeGLmBUA
 pFcjnV4iQDN2Jrk0vlU1foLLl50haUrvFvV+Bfrj5yGxDG7HGS0wELWEHy+CooEETR73U1NZpcD
 hXo=
X-Received: by 2002:a05:600c:6288:b0:490:e18f:d108 with SMTP id
 5b1f17b1804b1-492490a7778mr150498955e9.19.1782134615458; 
 Mon, 22 Jun 2026 06:23:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd15535sm327455755e9.3.2026.06.22.06.23.35
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
X-Gerrit-Change-Number: 1720
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1720?usp=email>
X-Gerrit-Commit: d7a3ff2584547526eed3c49b6ffa9d71e3e1d885
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk2YTAzMjQ2NWU2NmI0OWFiMGNlOGIxYTg0ZWFkOGQ5YWNlZjkxOGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <732939b7b0488dae9add12beb3ee34a51fc2c0dd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecn-0000a2-SP
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2314435709076681048=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2314435709076681048==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SPZcZaoBAJU="; charset=UTF-8

--SPZcZaoBAJU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1720?usp=3Demail )


Change subject: Extract handle_conn=
ection_attempt from multi_get_create_instance_udp
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract handle_connection_attempt fro=
m multi_get_create_instance_udp

The multi_get_create_instance_udp is quite=
 large=2E This factors out the
one branch that handles and creates new conn=
ection attempts=2E

Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
Si=
gned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/mudp=2Ec
1=
 file changed, 65 insertions(+), 50 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/1720/1

diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index b1de446=2E=2Ea91d11b 100644
--- =
a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -194,12 +194,74 @@
   =
  return false;
 }
 
-/*
+struct multi_instance *
+handle_connection_attemp=
t(struct multi_context *m,
+                          struct link_socket *s=
ock,
+                          struct mroute_addr *real,
+                =
          const uint64_t hv,
+                          struct hash_bucket =
*bucket)
+{
+    struct hash *hash =3D m->hash;
+    struct tls_pre_decrypt=
_state state =3D { 0 };
+    struct multi_instance *mi =3D NULL;
+    struc=
t gc_arena gc =3D gc_new();
+
+    if (m->deferred_shutdown_signal=2Esignal=
_received)
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI: Connect=
ion attempt from %s ignored while server is "
+            "shutting down",=

+            mroute_addr_print(real, &gc));
+    }
+    else if (do_pre_de=
crypt_check(m, &state, *real, sock))
+    {
+        /* This is an unknown =
session but with valid tls-auth/tls-crypt
+         * (or no auth at all)=
=2E  If this is the initial packet of a
+         * session, we just send a=
 reply with a HMAC session id and
+         * do not generate a session slo=
t */
+
+        if (frequency_limit_event_allowed(m->new_connection_limiter=
))
+        {
+            /* a successful three-way handshake only counts =
against
+             * connect-freq but not against connect-freq-initial *=
/
+            reflect_filter_rate_limit_decrease(m->initial_rate_limiter);=

+
+            mi =3D multi_create_instance(m, real, sock);
+            i=
f (mi)
+            {
+                hash_add_fast(hash, bucket, &mi->rea=
l, hv, mi);
+                mi->did_real_hash =3D true;
+                m=
ulti_assign_peer_id(m, mi);
+
+                /* If we have a session id a=
lready, ensure that the
+                 * state is using the same */
+   =
             if (session_id_defined(&state=2Eserver_session_id)
+          =
          && session_id_defined((&state=2Epeer_session_id)))
+             =
   {
+                    mi->context=2Ec2=2Etls_multi->n_sessions++;
+    =
                struct tls_session *session =3D
+                        &m=
i->context=2Ec2=2Etls_multi->session[TM_INITIAL];
+                    sess=
ion_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+             =
   }
+            }
+        }
+        else
+        {
+            msg(D_=
MULTI_ERRORS,
+                "MULTI: Connection from %s would exceed new =
connection frequency limit as controlled by --connect-freq",
+             =
   mroute_addr_print(real, &gc));
+        }
+    }
+    free_tls_pre_decry=
pt_state(&state);
+    gc_free(&gc);
+    return mi;
+}
+
+/**
  * Get a cl=
ient instance based on real address=2E  If
  * the instance doesn't exist, =
create it while
  * maintaining real address hash table atomicity=2E
  */
-=

 struct multi_instance *
 multi_get_create_instance_udp(struct multi_conte=
xt *m, bool *floated, struct link_socket *sock)
 {
@@ -258,54 +320,7 @@
   =
      /* we have no existing multi instance for this connection */
        =
 if (!mi)
         {
-            struct tls_pre_decrypt_state state =3D { =
0 };
-            if (m->deferred_shutdown_signal=2Esignal_received)
-     =
       {
-                msg(D_MULTI_ERRORS,
-                    "MULTI: =
Connection attempt from %s ignored while server is "
-                    "=
shutting down",
-                    mroute_addr_print(&real, &gc));
-     =
       }
-            else if (do_pre_decrypt_check(m, &state, real, sock))=

-            {
-                /* This is an unknown session but with val=
id tls-auth/tls-crypt
-                 * (or no auth at all)=2E  If this i=
s the initial packet of a
-                 * session, we just send a reply=
 with a HMAC session id and
-                 * do not generate a session s=
lot */
-
-                if (frequency_limit_event_allowed(m->new_connecti=
on_limiter))
-                {
-                    /* a successful three-=
way handshake only counts against
-                     * connect-freq but =
not against connect-freq-initial */
-                    reflect_filter_rat=
e_limit_decrease(m->initial_rate_limiter);
-
-                    mi =3D mu=
lti_create_instance(m, &real, sock);
-                    if (mi)
-        =
            {
-                        hash_add_fast(hash, bucket, &mi->rea=
l, hv, mi);
-                        mi->did_real_hash =3D true;
-         =
               multi_assign_peer_id(m, mi);
-
-                        /* I=
f we have a session id already, ensure that the
-                         *=
 state is using the same */
-                        if (session_id_defined=
(&state=2Eserver_session_id)
-                            && session_id_def=
ined((&state=2Epeer_session_id)))
-                        {
-             =
               mi->context=2Ec2=2Etls_multi->n_sessions++;
-               =
             struct tls_session *session =3D
-                             =
   &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
-                   =
         session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
-=
                        }
-                    }
-                }
-      =
          else
-                {
-                    msg(D_MULTI_ERRORS,
=
-                        "MULTI: Connection from %s would exceed new connec=
tion frequency limit as controlled by --connect-freq",
-                   =
     mroute_addr_print(&real, &gc));
-                }
-            }
-   =
         free_tls_pre_decrypt_state(&state);
+            mi =3D handle_con=
nection_attempt(m, sock, &real, hv, bucket);
         }
 
 #ifdef ENABLE_DE=
BUG

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a032465e66b4=
9ab0ce8b1a84ead8d9acef918de
Gerrit-Change-Number: 1720
Gerrit-PatchSet: 1
G=
errit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--SPZcZaoBAJU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Extract handle_connection_attempt from multi_get_create_instance_u=
dp<br><br>The multi_get_create_instance_udp is quite large=2E This factors =
out the<br>one branch that handles and creates new connection attempts=2E<b=
r><br>Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mudp=2Ec<=
br>1 file changed, 65 insertions(+), 50 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/17=
20/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span=
><br><span>index b1de446=2E=2Ea91d11b 100644</span><br><span>--- a/src/open=
vpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ =
-194,12 +194,74 @@</span><br><span>     return false;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+handle_connection_a=
ttempt(struct multi_context *m,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                          struct link_socket *sock,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                          struc=
t mroute_addr *real,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          const uint64_t hv,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                          struct hash_bucket *buc=
ket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =3D m-&gt;h=
ash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_=
pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct multi_instance *mi =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;deferred_shutdown_signal=2E=
signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MUL=
TI_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;MULTI: Connection attempt from %s ignored while server is &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;shu=
tting down&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          mroute_addr_print(real, &amp;gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (do_pre_decrypt_check(m, &amp;state, *real, sock))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* This is an unknown sessi=
on but with valid tls-auth/tls-crypt</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * (or no auth at all)=2E  If this is the initial =
packet of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * session, we just send a reply with a HMAC session id and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * do not generate a sessio=
n slot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (frequency_limit_e=
vent_allowed(m-&gt;new_connection_limiter))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* a successful three-way handshake only counts a=
gainst</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
* connect-freq but not against connect-freq-initial */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            reflect_filter_rate_limit_de=
crease(m-&gt;initial_rate_limiter);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         mi =3D multi_create_instance(m, real, sock);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (mi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                hash_add_fast(hash, bucket, &am=
p;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                mi-&gt;did_real_hash =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                multi_assign_peer_id(m, mi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                /* If we have a sessio=
n id already, ensure that the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 * state is using the same */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                if (session_id_defined(=
&amp;state=2Eserver_session_id)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &amp;&amp; session_id_defined((&amp;state=
=2Epeer_session_id)))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    struc=
t tls_session *session =3D</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;ses=
sion[TM_INITIAL];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  session_skip_to_pre_start(session, &amp;state, &amp;m-&gt=
;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_ERRORS,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;MU=
LTI: Connection from %s would exceed new connection frequency limit as cont=
rolled by --connect-freq&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                mroute_addr_print(real, &amp;gc));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return mi;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span>  * Get a client instance based on real address=2E =
 If</span><br><span>  * the instance doesn&#39;t exist, create it while</sp=
an><br><span>  * maintaining real address hash table atomicity=2E</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> struct multi_instance *</span><br><span> multi_get_create_instance_=
udp(struct multi_context *m, bool *floated, struct link_socket *sock)</span=
><br><span> {</span><br><span>@@ -258,54 +320,7 @@</span><br><span>        =
 /* we have no existing multi instance for this connection */</span><br><sp=
an>         if (!mi)</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            struct tls_pre_decrypt_state state =
=3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (m-&gt;deferred_shutdown_signal=2Esignal_received)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                msg(D_MULTI_ERRORS,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    &quot;MULTI: Con=
nection attempt from %s ignored while server is &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    &quot;shutting down&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   mroute_addr_print(&amp;real, &amp;gc));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            else if (do_pre_decrypt_check(m, &amp;state, real,=
 sock))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* Thi=
s is an unknown session but with valid tls-auth/tls-crypt</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                 * (or no auth at all)=
=2E  If this is the initial packet of a</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                 * session, we just send a reply with a H=
MAC session id and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
              * do not generate a session slot */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (frequency_limit_event_allowed(m-&gt;new_connecti=
on_limiter))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       /* a successful three-way handshake only counts against</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                     * connect-fre=
q but not against connect-freq-initial */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    reflect_filter_rate_limit_decrease(=
m-&gt;initial_rate_limiter);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      mi =3D multi_create_instance(m, &amp;real, sock);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    if (mi)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        hash_add_fa=
st(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        mi-&gt;did_real_hash =3D true=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    multi_assign_peer_id(m, mi);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              /* If we have a session id already, ensure that the</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                         * stat=
e is using the same */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        if (session_id_defined(&amp;state=2Eserver_session=
_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
           &amp;&amp; session_id_defined((&amp;state=2Epeer_session_id)))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
         mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                            struct tls=
_session *session =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;se=
ssion[TM_INITIAL];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                         session_skip_to_pre_start(session, &amp;state, &am=
p;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        &quot;MULTI: Connection from %s wo=
uld exceed new connection frequency limit as controlled by --connect-freq&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        mroute_addr_print(&amp;real, &amp;gc));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            free_tls_pre_decrypt_state(&amp;state);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            mi =3D handle_con=
nection_attempt(m, sock, &amp;real, hv, bucket);</span><br><span>         }=
</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1720?usp=3Demail">change 1720</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1720?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef9=
18de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1720 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--SPZcZaoBAJU=--


--===============2314435709076681048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2314435709076681048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2314435709076681048==--

