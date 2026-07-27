Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E63C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=UFplfGfVtnioM1DT5eHV40IMtBw+wY9qd1Y6ll3fgjE=; b=ellnFqpFQdmetx
	rQyjWrDt4zW5qlyNEkIY8p0HFlVgFCMVonTkJNQGh60FESsc/AeNAhzMfKl4i7IVCMkx191qYlliJ
	1vHua6KmUPG2oWWi0v432NY0OXCP+CF5Kucg+GLWxc6uQvzP3+ba8K18Z4GFi/IE/Uhbci22nfz76
	rKM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woKco-0003yI-Hw;
	Mon, 27 Jul 2026 12:40:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woKcm-0003yA-JL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:40:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=14vTRFC/j8JalM5fqv1CL/senPZNIrVS9T1u48dXTrg=; b=Ok/WWmEu3hX8JN5GLHi4yB3LIu
 zcbNyY/m2hcFeOYRf/XKMovZaR8gyNBq+KX8g3vz1picFdbLL3xu/LXyhFV8jpEONJMQ0RkFgOuGU
 AWtkg1PLeWSKllVd6v9zCB/+ERhj7eL5oby71Kc+4juE9gzRWZLDajFOSEwVcrdXz9QY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=14vTRFC/j8JalM5fqv1CL/senPZNIrVS9T1u48dXTrg=; b=R
 5rXchL3J+7OB+GD2arvTmP2avi5A9uq3cSpJlhdT8mv9+aiRcaZ3QezZSSjZWkPzv3wgD4XBh2Yoo
 cWMLwLfisBJsAMK/mpNu/patSfgDp5ECkjXGNytZQ46UCNkoY4PN6Xkfj/etZuxbc0+zo5HowZnQO
 lc55dPfvtQP3Rkfo=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woKcq-0006la-0o for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:40:05 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso31313415e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785155998; x=1785760798; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=14vTRFC/j8JalM5fqv1CL/senPZNIrVS9T1u48dXTrg=;
 b=e9Y9wbPwpuBOVcycRmU3X3A7dSkS7FP8OLOmgh/9hrM98DdSOQ63+1NfMmfsFQzNZt
 tYVGQQ5jZoVsrYaT1ejiCUCZwT9hguaIkB2poG4EKVkKgrco340oDbbeh4ofJGLD/pNy
 IJiJpq5jV9Bcz4RVz/Nh9rUMHFn42XIt1eyZLLaaeNsgHxlptcqj5CcbqAgaFriVj1Fo
 paskl/Y8pyDRQuEOPAYTFe5azdeUzBovDpranJnBQdvR2Qj9yAN/nioroqZDscGqfVge
 9xSZw4xBtYH++8j2mhQVj/lXkKeimfcE/hWHFHVs7LTKfK9I4zQlTQzZuyNUMNNxsy/j
 /JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785155998; x=1785760798;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=14vTRFC/j8JalM5fqv1CL/senPZNIrVS9T1u48dXTrg=;
 b=INOCwSZsPttHv75Aik4M1AmLztkPZ575IUS9i97CZViebQhmMB7mgavGZ/7ec8HQBJ
 AA1SSvKMUyrDz82WGdOoATzPDePMAYOTkNU6+fEBxvHcBIZQW8fkXNAmL9niuM5NJwVd
 6aYYq5dVfj9twrkxnHG2tw6c8vs79YLon+Z4iVg7NXkktq8mRdgSLdald4d+e1hchmr/
 YPL6TPtz7Tugab5mIydRnYKbYNq1irLJLHmoqpjbEF+J0qh8cOSTqVt29AniBgGpabxq
 xCvm2Y1z1D3LSIXnyVSJkeqJw25/eclaz7n3mIgrybogXX8INsTxpI3tyc6Wb/Mq0b5p
 wlIA==
X-Gm-Message-State: AOJu0YykOyk0LYcuwjDQDEonGUq1G+aUP7o+aRjgDTPszZm/4JksTbB8
 dPn6nB1Ro1Gd2se1KTm3D90NxbU1Q4AQ3WMKwv76VjdbhM7BEzTdC+2TeetwIiqMQe4l4Dd3O2j
 FQh8lrwjHkANUhDLgjo+wnQyXdH+bH8tOW38Ct6f/lwKu/z/eSMenUm9bux8Ww/lNoZwvDLFRHO
 hzzYzGBg==
X-Gm-Gg: AR+sD10U9qfxXA9TnGKzLCkbJmaX2vfniVlQjJ+lo4mBhx294ZeS+9SlzgFIjqqkBU6
 MRm5F/bejGk3VIZ8pT5vTUFLGQVVGtRTgdy11z9WAJu703TsE+yMlS0Xo3MpFUDG4T+2gWdZ6/e
 zYVxsusOB2oaeJmQ+/RUGR6MuNn8oFXrWtkv5c4f8gb4eMauG7Vh3WrlCsxX38hxN1savpXzmGl
 dBYB1MvVG0KuUWP4M/tI7YzGphzVzRbbwXc1OBuODSQBNURdxQ6LzQEnTTGvJQ5s6mSWIIJtkPC
 CWd+EnEXLWrsKz7e+HH18WJyIrN2++ofC4yaUkkr1PnmaCFb0acO2jjJQbxb7Idnn3tJjquTNOR
 yFYq8XCLhquZ1lJyJFvx/F0m3N3iVWr3BXPYFlzbyi5Uj1MgMx4sN/zND7icENLMl51N0+Nclx4
 ix0y6LMIN53ETpc7qvOaJ1pe8doouE8d5OVNhcgv3QGJvkR7q+2/mB8QzZl2YN/Z7GlbZjhsdyg
 BYv2D1p1w+qJwAv/FszQgVyBLzxi0wOqFWzrk8iOoIsKZJ3YKKXKWzofZ7+I7UqPLMp1EbPp27g
 6yk=
X-Received: by 2002:a05:6000:4b0f:b0:47f:8f54:125f with SMTP id
 ffacd0b85a97d-47f9fc82a97mr10342363f8f.7.1785155997533; 
 Mon, 27 Jul 2026 05:39:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c631fdsm47238574f8f.28.2026.07.27.05.39.57
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:39:57 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 12:39:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 2a0be5eccb9a78b6bd73c28e4dc6b5d2b3f49fef
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a4d8c5aaad45dd924a44b34244d336912f89a0e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woKcq-0006la-0o
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make required action
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2669477998160378384=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2669477998160378384==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uuXfniSI3D4="; charset=UTF-8

--uuXfniSI3D4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826?usp=3Demail )


Change subject: Make required actio=
n returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make required action returned from pr=
e_decrypt_verdict more explicit

The current code relies on the condition i=
f state=2Eserver_session_id
is defined to decided if session_skip_to_pre_st=
art should be used=2E

Instead explicitly return the intent and use that to=
 decide if
session_skip_to_pre_start should be called=2E

Change-Id: Iccdd4=
cfad090c565aac27e16cdaa9871106c2f89
---
M src/openvpn/mudp=2Ec
1 file chang=
ed, 24 insertions(+), 12 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/26/1826/1

diff --git a/src/openvpn/mudp=
=2Ec b/src/openvpn/mudp=2Ec
index 9658b18=2E=2Eabae066 100644
--- a/src/ope=
nvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -73,9 +73,15 @@
     msg_set_pr=
efix(NULL);
 }
 
+enum pre_decrypt_verdict
+{
+    PRE_DECRYPT_NO_ACTION,
+=
    PRE_DECRYPT_CREATE_SESSION,
+    PRE_DECRYPT_CREATE_SESSION_SKIP
+};
 
=
 /* Returns true if this packet should create a new session */
-static bool=

+static enum pre_decrypt_verdict
 do_pre_decrypt_check(struct multi_contex=
t *m, struct tls_pre_decrypt_state *state,
                      struct mro=
ute_addr addr, struct link_socket *sock)
 {
@@ -97,7 +103,7 @@
          * =
responses */
         if (!reflect_filter_rate_limit_check(m->initial_rate_=
limiter))
         {
-            return false;
+            return PRE_DEC=
RYPT_NO_ACTION;
         }
     }
 
@@ -122,7 +128,7 @@
                 ca=
lculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);=

             send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
- =
           return false;
+            return PRE_DECRYPT_NO_ACTION;
       =
  }
         else
         {
@@ -139,11 +145,11 @@
                     "ig=
noring connection attempt from old client (%s)",
                     peer)=
;
                 gc_free(&gc);
-                return false;
+          =
      return PRE_DECRYPT_NO_ACTION;
             }
             else
      =
       {
-                return true;
+                return PRE_DECRYPT_=
CREATE_SESSION;
             }
         }
     }
@@ -156,7 +162,7 @@
      =
   send_hmac_reset_packet(m, state, tas, &sid, false, sock);
 
         /* =
We have a reply do not create a new session */
-        return false;
+    =
    return PRE_DECRYPT_NO_ACTION;
     }
     else if (verdict =3D=3D VERDI=
CT_VALID_CONTROL_V1 || verdict =3D=3D VERDICT_VALID_ACK_V1
              ||=
 verdict =3D=3D VERDICT_VALID_WKC_V1)
@@ -187,11 +193,11 @@
         }
    =
     gc_free(&gc);
 
-        return ret;
+        return PRE_DECRYPT_CREAT=
E_SESSION_SKIP;
     }
 
     /* VERDICT_INVALID */
-    return false;
+   =
 return PRE_DECRYPT_NO_ACTION;
 }
 
 /**
@@ -217,8 +223,11 @@
             =
"MULTI: Connection attempt from %s ignored while server is "
             "=
shutting down",
             mroute_addr_print(real, &gc));
+        return=
 NULL;
     }
-    else if (do_pre_decrypt_check(m, &state, *real, sock))
+=
    enum pre_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &state, *r=
eal, sock);
+
+    if (verdict !=3D PRE_DECRYPT_NO_ACTION)
     {
         =
/* This is an unknown session but with valid tls-auth/tls-crypt
          *=
 (or no auth at all)=2E  If this is the initial packet of a
@@ -243,13 +252=
,16 @@
 
                 /* If we have a session id already, ensure that t=
he
                  * state is using the same */
-                if (sess=
ion_id_defined(&state=2Eserver_session_id)
-                    && session_=
id_defined((&state=2Epeer_session_id)))
+                if (session_id_def=
ined((&state=2Epeer_session_id)))
                 {
                     m=
i->context=2Ec2=2Etls_multi->n_sessions++;
                     struct tls_=
session *session =3D
                         &mi->context=2Ec2=2Etls_multi=
->session[TM_INITIAL];
-                    session_skip_to_pre_start(sessi=
on, &state, &m->top=2Ec2=2Efrom);
+
+                    if (verdict =3D=3D=
 PRE_DECRYPT_CREATE_SESSION_SKIP)
+                    {
+                 =
       session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+  =
                  }
                 }
             }
         }

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cd=
aa9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 1
Gerrit-Owner: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>

--uuXfniSI3D4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Make required action returned from pre_decrypt_verdict more explic=
it<br><br>The current code relies on the condition if state=2Eserver_sessio=
n_id<br>is defined to decided if session_skip_to_pre_start should be used=
=2E<br><br>Instead explicitly return the intent and use that to decide if<b=
r>session_skip_to_pre_start should be called=2E<br><br>Change-Id: Iccdd4cfa=
d090c565aac27e16cdaa9871106c2f89<br>---<br>M src/openvpn/mudp=2Ec<br>1 file=
 changed, 24 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1826/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><spa=
n>index 9658b18=2E=2Eabae066 100644</span><br><span>--- a/src/openvpn/mudp=
=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -73,9 +7=
3,15 @@</span><br><span>     msg_set_prefix(NULL);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum pr=
e_decrypt_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT_NO_A=
CTION,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRY=
PT_CREATE_SESSION,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   PRE_DECRYPT_CREATE_SESSION_SKIP</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span> </span><br><span> /* Returns true if thi=
s packet should create a new session */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static enum pre_decrypt_verdict</span><br><span> do_pre_decrypt_c=
heck(struct multi_context *m, struct tls_pre_decrypt_state *state,</span><b=
r><span>                      struct mroute_addr addr, struct link_socket *=
sock)</span><br><span> {</span><br><span>@@ -97,7 +103,7 @@</span><br><span=
>          * responses */</span><br><span>         if (!reflect_filter_rate=
_limit_check(m-&gt;initial_rate_limiter))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return PRE=
_DECRYPT_NO_ACTION;</span><br><span>         }</span><br><span>     }</span=
><br><span> </span><br><span>@@ -122,7 +128,7 @@</span><br><span>          =
       calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac, han=
dwindow, 0);</span><br><span>             send_hmac_reset_packet(m, state, =
tas, &amp;sid, true, sock);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;</sp=
an><br><span>         }</span><br><span>         else</span><br><span>     =
    {</span><br><span>@@ -139,11 +145,11 @@</span><br><span>               =
      &quot;ignoring connection attempt from old client (%s)&quot;,</span><=
br><span>                     peer);</span><br><span>                 gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                return PRE_DECRYPT_NO_ACTION;</span><br><span>            =
 }</span><br><span>             else</span><br><span>             {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                retu=
rn PRE_DECRYPT_CREATE_SESSION;</span><br><span>             }</span><br><sp=
an>         }</span><br><span>     }</span><br><span>@@ -156,7 +162,7 @@</s=
pan><br><span>         send_hmac_reset_packet(m, state, tas, &amp;sid, fals=
e, sock);</span><br><span> </span><br><span>         /* We have a reply do =
not create a new session */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return PRE_DECRYPT_NO_ACTION;</span><br><span>     }</span>=
<br><span>     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verdict =
=3D=3D VERDICT_VALID_ACK_V1</span><br><span>              || verdict =3D=3D=
 VERDICT_VALID_WKC_V1)</span><br><span>@@ -187,11 +193,11 @@</span><br><spa=
n>         }</span><br><span>         gc_free(&amp;gc);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return PRE_DECR=
YPT_CREATE_SESSION_SKIP;</span><br><span>     }</span><br><span> </span><br=
><span>     /* VERDICT_INVALID */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return PRE_DECRYPT_NO_ACTION;</span><br><span> }</span><br><s=
pan> </span><br><span> /**</span><br><span>@@ -217,8 +223,11 @@</span><br><=
span>             &quot;MULTI: Connection attempt from %s ignored while ser=
ver is &quot;</span><br><span>             &quot;shutting down&quot;,</span=
><br><span>             mroute_addr_print(real, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (d=
o_pre_decrypt_check(m, &amp;state, *real, sock))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    enum pre_decrypt_verdict verdict =3D do_pr=
e_decrypt_check(m, &amp;state, *real, sock);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (verdict !=3D PRE_DECRYPT_NO_ACTION)</span><br><span>     {</s=
pan><br><span>         /* This is an unknown session but with valid tls-aut=
h/tls-crypt</span><br><span>          * (or no auth at all)=2E  If this is =
the initial packet of a</span><br><span>@@ -243,13 +252,16 @@</span><br><sp=
an> </span><br><span>                 /* If we have a session id already, e=
nsure that the</span><br><span>                  * state is using the same =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(session_id_defined(&amp;state=2Eserver_session_id)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &amp;&amp; session_id_d=
efined((&amp;state=2Epeer_session_id)))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                if (session_id_defined((&amp;state=2Epe=
er_session_id)))</span><br><span>                 {</span><br><span>       =
              mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><=
span>                     struct tls_session *session =3D</span><br><span> =
                        &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM=
_INITIAL];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         session_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=
=2Efrom);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    if (verdi=
ct =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        session_skip_to_pre_start(=
session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    }</span><br><span>       =
          }</span><br><span>             }</span><br><span>         }</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfad090c565aac27e16=
cdaa9871106c2f89 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uuXfniSI3D4=--


--===============2669477998160378384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2669477998160378384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2669477998160378384==--

