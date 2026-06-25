Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55934CDE001
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZkcsLaL+zhIzXC3HUgYyvCxNxl5n7lD7CipVvxNjlo=; b=cN/wECnccpEKqeyr30jR0rJuwU
	TV+eRGj+RkHQ0zshbaDyAyS9jnDxJV6PhhlG3MM439igV43obt3B70LgdFoTtO/XYnwN7GpdGEJH2
	HkM8GIdLfa5zFL0RjTC+aynv8hRAn0kdifqq9sBnbZK4L5tpckIqWWbHt9i2AlOW8rWM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckGk-0004F3-HR;
	Thu, 25 Jun 2026 13:37:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckGi-0004Ew-P3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WnS6e0DPPA0V3rfYN6bg14bHcQYE5Rv2QNpjEAPDuzM=; b=ckqQ5YA1vGiuQUiinSrXxcC33L
 f3OeIslDb5ckr3VSSTAmf+ukirbWK6k2nxsGTTavp3GCIfGjM1xmjSy+iqol/Hm5lcQ7z6MtYVScK
 fuHoZyE5GrR/yvmc3dWjE/BoHY0AfNg2/BTWiKH3F28F3oZzyn3JLPRXLxjif1o8wwGg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WnS6e0DPPA0V3rfYN6bg14bHcQYE5Rv2QNpjEAPDuzM=; b=Z
 u0tgYAF9tWvit9nIMgPtaT6XXuYwINka4UGOku7FX5LvOkDiN8pQSetEOMQRTWElIWb6TSZLTpllZ
 QQGP0mqFaEiEQvjdEj9ueRsPM2eqfcyVNYv2DDPsVtRzshcJjYyrU0twAn8QOXwMzBy6hyn1brLAy
 lqVLmXsUlNno54N8=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckGg-0001He-Py for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:25 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4924f8db066so13062295e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394637; x=1782999437; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WnS6e0DPPA0V3rfYN6bg14bHcQYE5Rv2QNpjEAPDuzM=;
 b=VgENGITuYx4qaTL5OUtVHZ/hejZhKnuQHJHvyIroukUYt9syrW2OVlw756cBsdlzLn
 IATz0onp0XYqeKjL5LDzY+2fpiF4LZrvnmEUryuL7sLqlWNgEuVO6rEnuDmknprL9dGZ
 LgG9G5padzRkleojvliZwPemM4h/brjNnTDkzzc4A3TdTiLbhkWLBSbbHljHosGA3m38
 LvTgZt/2vpAC0gXJt4rF+MXrx6IkY4cX9tgj1Rvf7Q874w+DRflqfXPsonl+nSMUGCxN
 EX9dSdPFROiNwDPxwjPmZJa+VzBb0s33YWqsII4fBqJU6hXiCZoX4TghAEQaICs2gUb3
 9LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394637; x=1782999437;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnS6e0DPPA0V3rfYN6bg14bHcQYE5Rv2QNpjEAPDuzM=;
 b=n1mlnfC17MAVUoF2wljSeTByglH6kpCneQJ0zHLX1aPCUXm1EuWcgSdCYZmuW4NcnU
 WcgzG7B9lP2Gz7bxBXk+7S09uOL3/T+Oy5K87qFgZDP8IspAgDLW93X691MsA/o4WCR+
 Dj5Eb6SZCWmxCdiZO2IKmuspZEOp0T/WsU1fyAlVzKVZCXh8kK9wfZ32KeyqmF4Mj4Tf
 QlBm9b94tgkIyNKgLS+VnXYSvRvaOxVjAF8X52eJfMMfFgvj0gld34KdAJFGTcGBXUAC
 GqKPRA+qXnbstmoHSyMeG6qn2SidKcnXQ3FSlRN2UBtBqXd9vfBT/E6wyCX3iY4l2WSB
 TV1g==
X-Gm-Message-State: AOJu0Yzkrtegx/dtKcEDxqHzxpQhtVUbsbsWCYS8j+wU4RDAzkeJhMLv
 ZcxDDMnlr7nk0eRVP653RqSkuaF69sQrIl12Qh5aGg7dOYSTPYylMC2AB6fmCBp8FKm4Er5pZL7
 nJJNz4YAvLrm8k3ENN1b5dXgwFDt/cwt5lcCOtcn2bT6xOlZ64SmC4PMz6BUgGUr2gTYLg95Try
 ORpT0AyQ==
X-Gm-Gg: AfdE7cn28DbfnUGtp8bEyl6nDpKKVlRGcwceeXi9BMmhPlxDr3oiYr3Ew3Ls6JQZ5gD
 N9qLjCTiN7d8YXh5mrBLw1nw2FPj1rRqH90uyMXruGb8dK9H+DXrilLomW2wr4+aI0EBORuxvaU
 AYkwQo811mGX/ffOZU8mSMNckiZx0tM053QgbcnEQPCW75731g7l9lv3y4H7vr9gEy8gXH2i+NY
 /j6OIitqPe/sW31ZCKHHn5Co74fX8pOQNYRLP4CxeETH5BpW3zXA5wB3J+AJtjJdPqBpFmSfzIy
 zr4BO2R7GFI6q++Vdh/uLks0OYhqdSWylaoW+ZdCuSwXJIpJtBcAQBIuYnv+KPOxXhXw/PLKOEC
 CXPi4l/IQQoABNm7hDOsYgikHOnxvsTB2y6XISWuwnESKih5wQGcRkIJIfURaJvJYkfjnmNZrJm
 6qGIGWgC83y3bFii6NAOdalCBKghxVwkxZOa03V+zpKl+muDKvwDT4bLcZR/PXoLVR9ANwajEml
 pdqdH5jX8bDfiUHtBJlqABn5kIlRDJLVFahDhPzl9QKTJ+Fv7l/4Vurq2gEvmR3+XrPi6IM1wcf
 UlM=
X-Received: by 2002:a05:600c:3b89:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-492668bac34mr31034555e9.37.1782394636403; 
 Thu, 25 Jun 2026 06:37:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660fe717sm53586225e9.14.2026.06.25.06.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:15 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
X-Gerrit-Change-Number: 1720
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1720?usp=email>
X-Gerrit-Commit: 078c63a08ef283601bd9d8b4a7171b47b6ca89a5
In-Reply-To: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk2YTAzMjQ2NWU2NmI0OWFiMGNlOGIxYTg0ZWFkOGQ5YWNlZjkxOGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bbed830647620da3ac59c2784ffaef903369fdb4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckGg-0001He-Py
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4846986733889826550=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4846986733889826550==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i9DQSuElU8E="; charset=UTF-8

--i9DQSuElU8E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1720?usp=3Demail

to look at the new patch set (#3=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Extract handle_connection_attempt from mu=
lti_get_create_instance_udp
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Extract handle_connection_attempt from multi_get_create_in=
stance_udp

The multi_get_create_instance_udp is quite large=2E This factor=
s out the
one branch that handles and creates new connection attempts=2E

C=
hange-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
Signed-off-by: Arne Sch=
wabe <arne@rfc2549=2Eorg>
---
M src/openvpn/mudp=2Ec
1 file changed, 72 ins=
ertions(+), 50 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/20/1720/3

diff --git a/src/openvpn/mudp=2Ec b/src/op=
envpn/mudp=2Ec
index b1de446=2E=2E7d4fee1 100644
--- a/src/openvpn/mudp=2Ec=

+++ b/src/openvpn/mudp=2Ec
@@ -194,12 +194,81 @@
     return false;
 }
 
-=
/*
+/**
+ * Handles a packet if no existing session exists for this incomin=
g packet=2E
+ *
+ * It will either to send a reply with a hmac cookie if th=
is is the first
+ * packet of a three-way handshake or create a multi_insta=
nce if it is a
+ * packet that completes the three-way handshake=2E
+ */
+s=
tatic struct multi_instance *
+handle_connection_attempt(struct multi_conte=
xt *m,
+                          struct link_socket *sock,
+              =
            struct mroute_addr *real,
+                          const uint=
64_t hv,
+                          struct hash_bucket *bucket)
+{
+    str=
uct hash *hash =3D m->hash;
+    struct tls_pre_decrypt_state state =3D { 0=
 };
+    struct multi_instance *mi =3D NULL;
+    struct gc_arena gc =3D gc=
_new();
+
+    if (m->deferred_shutdown_signal=2Esignal_received)
+    {
+ =
       msg(D_MULTI_ERRORS,
+            "MULTI: Connection attempt from %s =
ignored while server is "
+            "shutting down",
+            mroute=
_addr_print(real, &gc));
+    }
+    else if (do_pre_decrypt_check(m, &stat=
e, *real, sock))
+    {
+        /* This is an unknown session but with val=
id tls-auth/tls-crypt
+         * (or no auth at all)=2E  If this is the in=
itial packet of a
+         * session, we just send a reply with a HMAC ses=
sion id and
+         * do not generate a session slot */
+
+        if (fr=
equency_limit_event_allowed(m->new_connection_limiter))
+        {
+       =
     /* a successful three-way handshake only counts against
+             =
* connect-freq but not against connect-freq-initial */
+            reflect=
_filter_rate_limit_decrease(m->initial_rate_limiter);
+
+            mi =3D=
 multi_create_instance(m, real, sock);
+            if (mi)
+            {
=
+                hash_add_fast(hash, bucket, &mi->real, hv, mi);
+         =
       mi->did_real_hash =3D true;
+                multi_assign_peer_id(m,=
 mi);
+
+                /* If we have a session id already, ensure that th=
e
+                 * state is using the same */
+                if (sessi=
on_id_defined(&state=2Eserver_session_id)
+                    && session_i=
d_defined((&state=2Epeer_session_id)))
+                {
+                =
    mi->context=2Ec2=2Etls_multi->n_sessions++;
+                    struct=
 tls_session *session =3D
+                        &mi->context=2Ec2=2Etls_=
multi->session[TM_INITIAL];
+                    session_skip_to_pre_start(=
session, &state, &m->top=2Ec2=2Efrom);
+                }
+            }
+ =
       }
+        else
+        {
+            msg(D_MULTI_ERRORS,
+       =
         "MULTI: Connection from %s would exceed new connection frequency l=
imit as controlled by --connect-freq",
+                mroute_addr_print(r=
eal, &gc));
+        }
+    }
+    free_tls_pre_decrypt_state(&state);
+   =
 gc_free(&gc);
+    return mi;
+}
+
+/**
  * Get a client instance based on=
 real address=2E  If
  * the instance doesn't exist, create it while
  * ma=
intaining real address hash table atomicity=2E
  */
-
 struct multi_instanc=
e *
 multi_get_create_instance_udp(struct multi_context *m, bool *floated, =
struct link_socket *sock)
 {
@@ -258,54 +327,7 @@
         /* we have no ex=
isting multi instance for this connection */
         if (!mi)
         {
-=
            struct tls_pre_decrypt_state state =3D { 0 };
-            if (=
m->deferred_shutdown_signal=2Esignal_received)
-            {
-            =
    msg(D_MULTI_ERRORS,
-                    "MULTI: Connection attempt fro=
m %s ignored while server is "
-                    "shutting down",
-     =
               mroute_addr_print(&real, &gc));
-            }
-            =
else if (do_pre_decrypt_check(m, &state, real, sock))
-            {
-     =
           /* This is an unknown session but with valid tls-auth/tls-crypt
=
-                 * (or no auth at all)=2E  If this is the initial packet o=
f a
-                 * session, we just send a reply with a HMAC session i=
d and
-                 * do not generate a session slot */
-
-            =
    if (frequency_limit_event_allowed(m->new_connection_limiter))
-        =
        {
-                    /* a successful three-way handshake only cou=
nts against
-                     * connect-freq but not against connect-fr=
eq-initial */
-                    reflect_filter_rate_limit_decrease(m->in=
itial_rate_limiter);
-
-                    mi =3D multi_create_instance(m,=
 &real, sock);
-                    if (mi)
-                    {
-       =
                 hash_add_fast(hash, bucket, &mi->real, hv, mi);
-         =
               mi->did_real_hash =3D true;
-                        multi_a=
ssign_peer_id(m, mi);
-
-                        /* If we have a session id=
 already, ensure that the
-                         * state is using the sa=
me */
-                        if (session_id_defined(&state=2Eserver_sessi=
on_id)
-                            && session_id_defined((&state=2Epeer_se=
ssion_id)))
-                        {
-                            mi->con=
text=2Ec2=2Etls_multi->n_sessions++;
-                            struct tl=
s_session *session =3D
-                                &mi->context=2Ec2=
=2Etls_multi->session[TM_INITIAL];
-                            session_ski=
p_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
-                    =
    }
-                    }
-                }
-                else
-    =
            {
-                    msg(D_MULTI_ERRORS,
-                   =
     "MULTI: Connection from %s would exceed new connection frequency limit=
 as controlled by --connect-freq",
-                        mroute_addr_pri=
nt(&real, &gc));
-                }
-            }
-            free_tls_pr=
e_decrypt_state(&state);
+            mi =3D handle_connection_attempt(m, s=
ock, &real, hv, bucket);
         }
 
 #ifdef ENABLE_DEBUG

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9a=
cef918de
Gerrit-Change-Number: 1720
Gerrit-PatchSet: 3
Gerrit-Owner: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--i9DQSuElU8E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1720?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Extract handle_connection_attempt from multi_get_create_insta=
nce_udp<br><br>The multi_get_create_instance_udp is quite large=2E This fac=
tors out the<br>one branch that handles and creates new connection attempts=
=2E<br><br>Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mudp=
=2Ec<br>1 file changed, 72 insertions(+), 50 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
20/1720/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec<=
/span><br><span>index b1de446=2E=2E7d4fee1 100644</span><br><span>--- a/src=
/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><spa=
n>@@ -194,12 +194,81 @@</span><br><span>     return false;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Handles a packet if no existing=
 session exists for this incoming packet=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * It will either to send a reply with a hmac cookie if this is the =
first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * packet of a=
 three-way handshake or create a multi_instance if it is a</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * packet that completes the three-w=
ay handshake=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct multi_=
instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+handle_co=
nnection_attempt(struct multi_context *m,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                          struct link_socket *sock,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
     struct mroute_addr *real,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                          const uint64_t hv,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                          struct hash_b=
ucket *bucket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;deferred_shutdown=
_signal=2Esignal_received)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;MULTI: Connection attempt from %s ignored while server i=
s &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;shutting down&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            mroute_addr_print(real, &amp;gc));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (do_pre_decrypt_check(m, &amp;state, *real=
, sock))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* This is an unk=
nown session but with valid tls-auth/tls-crypt</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * (or no auth at all)=2E  If this is th=
e initial packet of a</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * session, we just send a reply with a HMAC session id and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * do not generat=
e a session slot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (frequen=
cy_limit_event_allowed(m-&gt;new_connection_limiter))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* a successful three-way handshake onl=
y counts against</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * connect-freq but not against connect-freq-initial */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            reflect_filter_rat=
e_limit_decrease(m-&gt;initial_rate_limiter);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            mi =3D multi_create_instance(m, real, sock);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (mi)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                hash_add_fast(hash, b=
ucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                mi-&gt;did_real_hash =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                multi_assign_peer_=
id(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                /* If we hav=
e a session id already, ensure that the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 * state is using the same */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                if (session_i=
d_defined(&amp;state=2Eserver_session_id)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &amp;&amp; session_id_defined((&a=
mp;state=2Epeer_session_id)))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions+=
+;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   struct tls_session *session =3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        &amp;mi-&gt;context=2Ec2=2Etls_multi=
-&gt;session[TM_INITIAL];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    session_skip_to_pre_start(session, &amp;state, &a=
mp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_ERRO=
RS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
&quot;MULTI: Connection from %s would exceed new connection frequency limit=
 as controlled by --connect-freq&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                mroute_addr_print(real, &amp;gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mi;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span>  * Get a client instance based on real addr=
ess=2E  If</span><br><span>  * the instance doesn&#39;t exist, create it wh=
ile</span><br><span>  * maintaining real address hash table atomicity=2E</s=
pan><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> struct multi_instance *</span><br><span> multi_get_create_in=
stance_udp(struct multi_context *m, bool *floated, struct link_socket *sock=
)</span><br><span> {</span><br><span>@@ -258,54 +327,7 @@</span><br><span> =
        /* we have no existing multi instance for this connection */</span>=
<br><span>         if (!mi)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            struct tls_pre_decrypt_state s=
tate =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (m-&gt;deferred_shutdown_signal=2Esignal_received)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(D_MULTI_ERRORS,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;MUL=
TI: Connection attempt from %s ignored while server is &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    &quot;shutting =
down&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          mroute_addr_print(&amp;real, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            else if (do_pre_decrypt_check(m, &amp;state=
, real, sock))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 /* This is an unknown session but with valid tls-auth/tls-crypt</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                 * (or no auth a=
t all)=2E  If this is the initial packet of a</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                 * session, we just send a reply wi=
th a HMAC session id and</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                 * do not generate a session slot */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                if (frequency_limit_event_allowed(m-&gt;new_co=
nnection_limiter))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             /* a successful three-way handshake only counts against</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                     * conne=
ct-freq but not against connect-freq-initial */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    reflect_filter_rate_limit_dec=
rease(m-&gt;initial_rate_limiter);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            mi =3D multi_create_instance(m, &amp;real, sock);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    if (mi)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        hash_=
add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        mi-&gt;did_real_hash =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            multi_assign_peer_id(m, mi);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      /* If we have a session id already, ensure that the</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
  * state is using the same */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        if (session_id_defined(&amp;state=2Eserver=
_session_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                   &amp;&amp; session_id_defined((&amp;state=2Epeer_session=
_id)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                 mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                            st=
ruct tls_session *session =3D</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                &amp;mi-&gt;context=2Ec2=2Etls_mult=
i-&gt;session[TM_INITIAL];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                            session_skip_to_pre_start(session, &amp;st=
ate, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    msg(D_MULTI_ERRORS,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        &quot;MULTI: Connection fr=
om %s would exceed new connection frequency limit as controlled by --connec=
t-freq&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                mroute_addr_print(&amp;real, &amp;gc));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            free_tls_pre_decrypt_state(&amp;state);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi =3D =
handle_connection_attempt(m, sock, &amp;real, hv, bucket);</span><br><span>=
         }</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1720?usp=3Demail">change 1720</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84=
ead8d9acef918de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
720 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--i9DQSuElU8E=--


--===============4846986733889826550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4846986733889826550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4846986733889826550==--

